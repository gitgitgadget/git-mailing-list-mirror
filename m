From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/21] Support multiple worktrees
Date: Sat, 21 Dec 2013 09:00:59 +0700
Message-ID: <CACsJy8DuXbCTjcVJNH=w6h3zgo0sxRgMfSQXZFtngYy2FLJTDg@mail.gmail.com>
References: <CACsJy8BV6uerMyHNHviL0Jy8s+_jca8NM-hVfnM=u4cr-=JX1Q@mail.gmail.com>
 <xmqq7gaze00k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 21 03:01:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuBsl-0004hY-KE
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 03:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730Ab3LUCBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Dec 2013 21:01:31 -0500
Received: from mail-qe0-f54.google.com ([209.85.128.54]:43848 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab3LUCBa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Dec 2013 21:01:30 -0500
Received: by mail-qe0-f54.google.com with SMTP id cy11so3229875qeb.13
        for <git@vger.kernel.org>; Fri, 20 Dec 2013 18:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3Q4WsvwMdAxDo5qUaCS5nTzZTmPWX70kgBn8OmN3sj8=;
        b=ecEfocf9hfGdswYw+0AAyRIjkAc3e+ngeXlT0AWAtLzilzff050Zz9pe/sPXCVLraU
         I5dSr4ziyfyWSU4oAkSg6lBYMajQAhBdqFxqzSUr1ctWLkNUdIMImsuEWGvGUMYHzlhj
         H33QlmDX+0lJ6WT7xezNVDrfEiBz/NAAlDh7NRQRXvA7k+xocza0+XM+EjriJrKIvvzF
         9yxKSxGMOXT9TBb01wemN17m4D/Pf61ECJ31IivJne9X0BkVv760WCvWxPwCNWvhzQcO
         U+a66PGWY+hkjO2uq8T1qCaSmkScygyrkmm1DppSIf3jbgqluQFiHk5pz3Sj7f5w8+ul
         cLZw==
X-Received: by 10.49.39.165 with SMTP id q5mr20358968qek.48.1387591289442;
 Fri, 20 Dec 2013 18:01:29 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Fri, 20 Dec 2013 18:00:59 -0800 (PST)
In-Reply-To: <xmqq7gaze00k.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239584>

On Sat, Dec 21, 2013 at 3:32 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> I've got a better version [1] that fixes everything I can think of
>> (there's still some room for improvements). I'm going to use it a bit
>> longer before reposting again. But here's its basic design without
>> going down to code
>>
>> New .git file format includes two lines:
>> -- 8< --
>> gitid: <id>
>> gitdir: <path>
>> -- 8< --
>>
>> Which would set $GIT_COMMON_DIR to <path> and $GIT_DIR to
>> <path>/repos/<id>. Repository split is the same as before, worktree
>> stuff in $GIT_DIR, the rest in $GIT_COMMON_DIR. This .git file format
>> takes precedence over core.worktree but can still be overriden with
>> $GIT_WORK_TREE. The main interface to create new worktree is "git
>> checkout --to".
>>
>> "repos" belongs to $GIT_COMMON_DIR (i.e. shared across all checkouts).
>> The new worktrees (which I call "linked checkouts") can also access
>> HEAD of the original worktree via a virtual path "main/HEAD". This
>> makes it possible for a linked checkout to detach HEAD of the main
>> one.
>
> I am not happy with the choice of "main/HEAD" that would squat on a
> good name for remote-tracking branch (i.e. s/origin/main/), though.
> $GIT_DIR/COMMON_HEAD perhaps?

It's not just about HEAD. Anything worktree-specific of the main
checkout can be accessed this way, e.g. main/index,
main/FETCH_HEAD.... and it's not exactly "common" because it's
worktree info. Maybe 1ST_ as the prefix (e.g. 1ST_HEAD, 1ST_index...)
?

>> The interesting thing is support for third party scripts (or hooks,
>> maybe) so that they could work with both old and new git versions
>> without some sort of git version/feature detection. Of course old git
>> versions will only work with ordinary worktrees. To that end, "git
>> rev-parse --git-dir" behavior could be changed by two environment
>> variables. $GIT_ONE_PATH makes 'rev-parse --git-dir' return the .git
>> _file_ in this case, which makes it much easier to pass the repo's
>> checkout view around with "git --git-dir=... ".$GIT_COMMON_DIR_PATH
>> makes 'rev-parse --git-dir' return $GIT_COMMON_DIR if it's from a
>> linked checkout, or $GIT_DIR otherwise.
>
> I do not understand why you need to go such a route.
>
> Existing scripts that works only in a real repository will only know
> "git rev-parse --git-dir" as the way to get the real GIT_DIR and
> would not care about the "common" thing.  Scripts updated to work
> well with the "common" thing needs to be aware of the "common" thing
> anyway, so adding "git rev-parse --common-git-dir" or somesuch that
> only these updated knows would be sufficient, no?

It simplifies the changes, if the new script is to work with both old
and new git versions it may have to write

DIR=`git rev-parse --git-common-dir 2>/dev/null || git rev-parse --git-dir`

the env way makes it

DIR=`GIT_COMMON_DIR=1 git rev-parse --git-dir`
-- 
Duy
