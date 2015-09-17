From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4] gc: save log from daemonized gc --auto and print it
 next time
Date: Thu, 17 Sep 2015 20:08:25 +0700
Message-ID: <CACsJy8CMFkGRCXuMiRme=B9ijq6ydWGPz0vyb8QoEzf4Ty3FDQ@mail.gmail.com>
References: <1440209546-23442-1-git-send-email-pclouds@gmail.com>
 <1442108202-25746-1-git-send-email-pclouds@gmail.com> <xmqq8u88ykv4.fsf@gitster.mtv.corp.google.com>
 <xmqq1te0ykaj.fsf@gitster.mtv.corp.google.com> <55F93646.9050709@alum.mit.edu>
 <xmqqmvwms6b1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 15:09:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcYvs-0004EI-LX
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 15:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbbIQNI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 09:08:56 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:36556 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbbIQNIz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 09:08:55 -0400
Received: by ioii196 with SMTP id i196so20872297ioi.3
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 06:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LvbCGAjEATqTZR4Y+vox2J47mYEl9tm6I5H4MDNwVwA=;
        b=036BRI0cOA9JZEP3OGubSo4k1n8EZGlv2uy3zeo9rYqJYhvq5SNZwaM41+VQ/jRdUW
         nCmgTzrNVO92EfbNQc67Ak0wjErmE+6bbyERxdjuuuMSGouG5VYGvdhusYZiNBgVyvhf
         5tA0RbNdN3yreEAaC+xFlIxMKrmM75+hvoC9HAX+sdwweDYfnYVgHmAfCNywdhc7RBy4
         uCr/Y62Z0c/XCG300tKLJ+eHqITObqleLGb26FzD9cIeZ9HMDgDFhnxqXPxH7JZo7eb9
         SmLvTMSob4+FQxlKPIdlBDonInZArlhuHIyFefT9071ifPKIHH0sc1xEErYelMUbvIW7
         kjXQ==
X-Received: by 10.107.9.212 with SMTP id 81mr5774241ioj.191.1442495334500;
 Thu, 17 Sep 2015 06:08:54 -0700 (PDT)
Received: by 10.107.19.227 with HTTP; Thu, 17 Sep 2015 06:08:25 -0700 (PDT)
In-Reply-To: <xmqqmvwms6b1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278112>

On Wed, Sep 16, 2015 at 11:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> I'm not sure what behavior you want. At one point you say "puts the file
>> to a final place if it is non-empty" but later you say "leave it if
>> non-empty". Should the file be written directly, or should it be written
>> to a lockfile and renamed into place only when complete?
>
> I do not think we care that deeply either way, as we do not want to
> run multiple auto-gc's at the same time in the first place.  So either
> one of the following is perfectly fine:
>
>  * We open the final destination directly, but with O_CREAT|O_EXCL,
>    which as a side effect also detects the simultanous execution
>    [*1*].  We do not do any "finalizing rename" if we go this route.
>    When we are done, close it and remove it if we did not write
>    anything, or leave it there if we did write something.
>
>  * We open a lockfile the usual way.  When we are done, close it and
>    and remove it if we did not write anything, or finalize it by
>    renaming it if we did write something.
>
> I think Duy's code wants to do the latter.

We do keep another lock before coming to opening this log file. So
once we get here we already know nobody else will be opening the log
file. We can simply open it the normal way, then make sure we clean it
up at atexit().

>> This doesn't seem like a common thing to want (as in, this might be the
>> only caller), but it probably makes sense to build it into the
>> tempfile/lockfile API nevertheless, because implementing it externally
>> would require a lot of other code to be duplicated.
>>
>> Another possibility that might work (maybe without requiring changes to
>> tempfile/lockfile): don't worry about deleting the log file if it is
>> empty, but make observers treat an empty log file the same as an absent one.
>
> Probably your "don't remove and check for emptiness" approach would
> be the simpler of the two, but I think we can go either way.

People have complained to me about stray files in $GIT_DIR, so it's
probably best that we delete empty/useless files. Although we could
delete empty files at the beginning of the next gc instead of at
atexit(). Let me try it out and see which is simplest.
-- 
Duy
