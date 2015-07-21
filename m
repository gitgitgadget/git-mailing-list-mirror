From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question: .idx without .pack causes performance issues?
Date: Tue, 21 Jul 2015 11:57:48 -0700
Message-ID: <xmqq4mkxwd77.fsf@gitster.dls.corp.google.com>
References: <CAEtYS8QWCg5_DtrJw-e+c50vcG0OpciR6LWon-3GgyngGn+0pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 20:58:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHcjo-0003sg-Mx
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 20:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933558AbbGUS5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 14:57:51 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34254 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933262AbbGUS5v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 14:57:51 -0400
Received: by pdbbh15 with SMTP id bh15so79348304pdb.1
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 11:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=daA82jJtnj5yvmbzttoWWo2ZmRf/AJDCobeDrU6ms4A=;
        b=QE2+du6h5xehs14ephHal+NRBSRbjfAIhMO2uUZCcRqP9eFqo9xPbRjUrogDDzMqcC
         HcL6EzAjTv0A3ALcXYkEOMNoO7DmTa4I983+f62nNXJ5e3rvS/IoX8gWrfap1OZBvvN7
         OiTQv94aWhJmQJUeC9bJNh2MDA7Wh9oBLzxL/bsQwUYAv7JXcZJq3jaQAA6hJ4axyPRq
         pfQNWu5o1U/gByJAaLPt3KFyMU+vy8I9y5Ft1IadqFcVQQNzDX/NVcH5uRxxbLo8wLF0
         37DxtLlmQEU9HUIOTE52MXKQehUEiwJlnNP9NkaOkkFFEsrPqc53zrnFl3evuDspSBHD
         uCsw==
X-Received: by 10.70.45.134 with SMTP id n6mr42727061pdm.124.1437505070518;
        Tue, 21 Jul 2015 11:57:50 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3977:fdee:723a:a723])
        by smtp.gmail.com with ESMTPSA id np15sm12930375pdb.1.2015.07.21.11.57.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 Jul 2015 11:57:49 -0700 (PDT)
In-Reply-To: <CAEtYS8QWCg5_DtrJw-e+c50vcG0OpciR6LWon-3GgyngGn+0pQ@mail.gmail.com>
	(Doug Kelly's message of "Tue, 21 Jul 2015 13:41:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274396>

Doug Kelly <dougk.ff7@gmail.com> writes:

> I just wanted to relay an issue we've seen before at my day job (and
> it just recently cropped up again).  When moving users from Git for
> Windows 1.8.3 to 1.9.5, we found a few users started having operations
> take an excruciatingly long amount of time.  At some point, we traced
> the issue to a number of .pack files had been deleted (possibly
> garbage collected?) -- but their associated .idx files were still
> present.  Upon removing the "orphaned" idx files, we found performance
> returned to normal.  Otherwise, git fsck reported no issues with the
> repositories.
>
> Other users have noted that using git gc would sometimes correct the
> issue for them, but not always.
>
> Anyway, has anyone else experienced this performance degradation?

I wouldn't be surprised if such a configuration to have leftover
".idx" files that lack ".pack" affected performance, but I think you
really have to work on getting into such a situation (unless your
operating system is very cooperative and tries hard to corrupt your
repository, that is ;-), so I wouldn't be surprised if you were the
first one to report this.

We open the ".idx" file and try to keep as many of them in-core,
without opening corresponding ".pack" until the data is needed. 

When we need an object, we learn from an ".idx" file that a
particular pack ought to have a copy of it, and then attempt to open
the corresponding ".pack" file.  If this fails, we do protect
ourselves from strange repositories with only ".idx" files by not
using that ".idx" and try to see if the sought-after object exists
elsewhere (and if there isn't we say "no such object", which is also
a correct thing to do).

I however do not think that we mark the in-core structure that
corresponds to an open ".idx" file in any way when such a failure
happens.  If we really cared enough, we could do so, saying "we know
there is .idx file, but do not bother looking at it again, as we
know the corresponding .pack is missing", and that would speed things
up a bit, essentially bringing us back to a sane situation without
any ".idx" without corresponding ".pack".

I do not think it is worth the effort, though.  It would be more
fruitful to find out how you end up with ".idx exists but not
corresponding .pack" and if that is some systemic failure, see if
there is a way to prevent that from happening in the first place.

Also, I think it may not be a bad idea to teach "gc" to remove stale
".idx" files that do not have corresponding ".pack" as garbage.
