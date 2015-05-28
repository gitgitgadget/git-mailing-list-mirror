From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: .gitconfig folder
Date: Thu, 28 May 2015 10:06:43 -0700
Message-ID: <xmqqbnh4iqcc.fsf@gitster.dls.corp.google.com>
References: <5565C6A7.60007@gmx.es>
	<xmqq7frtlq56.fsf@gitster.dls.corp.google.com>
	<20150527221813.GF23259@peff.net>
	<xmqq1ti1k5nv.fsf@gitster.dls.corp.google.com>
	<20150528075142.GB3688@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jorge <griffin@gmx.es>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 28 19:06:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy1Gc-0002be-Q8
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 19:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754389AbbE1RGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 13:06:47 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:33982 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754281AbbE1RGp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 13:06:45 -0400
Received: by igbhj9 with SMTP id hj9so119994573igb.1
        for <git@vger.kernel.org>; Thu, 28 May 2015 10:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Bm48aF6aZnH5S6pSPh8tSiLwEdi/48eeF97OtMR6mZk=;
        b=s3OY3uWnZnXqTOwyUGjAuArzjm4AQy9toPs3z6LuZkg2TGBvOyYaPINNiLn9FMwBNs
         MwxdSJLiU5k3H+EQPf3R2KNsHcQvwuL67DoNJCwJZ3I4Liv/TDxPXnRh//6fK6NM+086
         Hpmu3LrFy6+J/KNEQGWOmRWt31tdV+8IAnU56nq/HTRLQyG1nddMTXYLTo/Y/yBfHBZ/
         +n27nNql7ZkD5y/c21wzne7NcsDgDsbWRPFyYeyQCCaR5TQN/+ICjqnHUQ00c8AGodos
         ilS0hjqk7UcIKxFiabpK+k+PztbArKD3bMgabo1Ptd1KGcQlvWAiueFJeE/0xFxELR4n
         fCiQ==
X-Received: by 10.50.64.243 with SMTP id r19mr12496584igs.5.1432832804744;
        Thu, 28 May 2015 10:06:44 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91c7:752b:4513:7344])
        by mx.google.com with ESMTPSA id k16sm4693629igf.19.2015.05.28.10.06.43
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 28 May 2015 10:06:44 -0700 (PDT)
In-Reply-To: <20150528075142.GB3688@peff.net> (Jeff King's message of "Thu, 28
	May 2015 03:51:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270161>

Jeff King <peff@peff.net> writes:

> On Wed, May 27, 2015 at 03:38:12PM -0700, Junio C Hamano wrote:
>
>> The patch was meant to be a tongue-in-cheek tangent that is a vast
>> improvement for cases where we absolutely need to use mmap but does
>> not help the OP at all ;-)  I do not think there is any need for the
>> config reader to read the existing file via mmap interface; just
>> open it, strbuf_read() the whole thing (and complain when it cannot)
>> and we should be ok.
>> 
>> Or do we write back through the mmaped region or something?
>
> No, I think we must never do that in our code because our compat mmap
> implementation uses pread(). So all maps must be MAP_PRIVATE (and our
> compat mmap barfs if it is not).
>
> I started to go the strbuf_read() route, but it just felt so dirty to
> change the way the code works only to try to get a better error message.

Hmm.  I actually thought that we long time ago updated the system to
read small loose object files via read(2) instead of mmap(2) purely
as an optimization, as mmap(2) is a bad match if you are going to
read the whole thing from the beginning to the end anyway, and the
"why not strbuf_read() the whole configuration file" was a suggestion
along that line.

But apparently we do not have such an optimization in read_object()
codepath, perhaps I was hallucinating X-<.

> ... but the config-writing code is such a tangled
> mess that I don't want to spend the time or risk the regressions.

That part I agree with.  I was kinda hoping that the previous GSoC
would clean it up, but that did not happen.
