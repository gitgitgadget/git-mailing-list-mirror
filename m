From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] gc: save log from daemonized gc --auto and print it next time
Date: Wed, 16 Sep 2015 09:00:18 -0700
Message-ID: <xmqqmvwms6b1.fsf@gitster.mtv.corp.google.com>
References: <1440209546-23442-1-git-send-email-pclouds@gmail.com>
	<1442108202-25746-1-git-send-email-pclouds@gmail.com>
	<xmqq8u88ykv4.fsf@gitster.mtv.corp.google.com>
	<xmqq1te0ykaj.fsf@gitster.mtv.corp.google.com>
	<55F93646.9050709@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Sep 16 18:00:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcF8E-0005NM-Cp
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 18:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736AbbIPQAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 12:00:21 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36049 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354AbbIPQAU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 12:00:20 -0400
Received: by padhk3 with SMTP id hk3so212768061pad.3
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 09:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ORrrC7DxEFJWMxGJ/yhDteA+uTtvYk4i7IOLFFYmqSI=;
        b=iODs0SEYwWmvY6VDeIoUacP7LFnlY41hnDTaGzRPiWnAL3GapAssbU/7/J/yFDTJbC
         il9z76vsrKdQ4sgjVWSLqP3ZB4GhgkTsiGgVCbYvkm+sBtCEpYy7JEB3tzEQzb7OGps1
         eZivPRxLoLLx2k3ZPuetLGrTs0q3BawfBh3TU+fQ0/eZv2MPbAjeX+EKt3X8KqF6RJc7
         JMGtX1p/OFnmBSa1UbOPxCJtVovobSM4omrcUVHfhp+foJlkxdS75EZVtZRZlhrvq7rD
         DKPl+vH80YUVpda2GQN2o5u4y4As9i2CpWy5hquVfhJeyDzONV7OZARDdCWyTkz8Js5R
         WEyw==
X-Received: by 10.68.196.35 with SMTP id ij3mr30940142pbc.52.1442419219757;
        Wed, 16 Sep 2015 09:00:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:150c:7d53:9693:493e])
        by smtp.gmail.com with ESMTPSA id yi8sm28761964pab.22.2015.09.16.09.00.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 09:00:18 -0700 (PDT)
In-Reply-To: <55F93646.9050709@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 16 Sep 2015 11:28:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278033>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I'm not sure what behavior you want. At one point you say "puts the file
> to a final place if it is non-empty" but later you say "leave it if
> non-empty". Should the file be written directly, or should it be written
> to a lockfile and renamed into place only when complete?

I do not think we care that deeply either way, as we do not want to
run multiple auto-gc's at the same time in the first place.  So either
one of the following is perfectly fine:

 * We open the final destination directly, but with O_CREAT|O_EXCL,
   which as a side effect also detects the simultanous execution
   [*1*].  We do not do any "finalizing rename" if we go this route.
   When we are done, close it and remove it if we did not write
   anything, or leave it there if we did write something.

 * We open a lockfile the usual way.  When we are done, close it and
   and remove it if we did not write anything, or finalize it by
   renaming it if we did write something.

I think Duy's code wants to do the latter.

> This doesn't seem like a common thing to want (as in, this might be the
> only caller), but it probably makes sense to build it into the
> tempfile/lockfile API nevertheless, because implementing it externally
> would require a lot of other code to be duplicated.
>
> Another possibility that might work (maybe without requiring changes to
> tempfile/lockfile): don't worry about deleting the log file if it is
> empty, but make observers treat an empty log file the same as an absent one.

Probably your "don't remove and check for emptiness" approach would
be the simpler of the two, but I think we can go either way.

Thanks.

[Footnote]

*1* But one "gc" could be foreground gc that does not write to a log
    file and the other "gc" could be background that does write to a
    log file, so this cannot be the primary way to avoid double
    execution.
