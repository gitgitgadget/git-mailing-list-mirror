From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Experience with Recovering From User Error (And suggestions for improvements)
Date: Mon, 16 Feb 2015 13:09:36 +0100
Message-ID: <CACBZZX4NkkMymnG5ZWtO1ya2xzVhxuqh4d3tU2U+mPU49n=m8g@mail.gmail.com>
References: <54E1C96D.2080109@active-4.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Armin Ronacher <armin.ronacher@active-4.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 13:11:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNKVI-0002Md-Gs
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 13:10:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755608AbbBPMKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 07:10:13 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:49135 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755534AbbBPMJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 07:09:56 -0500
Received: by mail-ob0-f173.google.com with SMTP id uy5so41551486obc.4
        for <git@vger.kernel.org>; Mon, 16 Feb 2015 04:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WyaxDcPvpudhD5aKRmv1krdcxNCIRTw68AGGZKGyCWA=;
        b=bIL+XRJ4QOm4OcgQRl5skPKTiJ3WbDc9Q/fHNjolLYMMTm5iSbQvazwQRR8dAOgBRR
         +wLW78iH5Xbl+hwnBZPknpzLQYzV46KW2cm6i/f72pAxxyBYrJRfuUNERUMMod4TEeBx
         GrNdxXTK7Yao7P3xJwqzfIF1O2x/NadmDWxWdK0RoeKjhA1w2o/Pbdf9EVeaDaDePdh+
         kvKApNwVSK9019pppsCz/WI+w1tehmKxJdcasGjR85js45oV4HRZObtYqT06HycenqpW
         CHXfnc6VAdU8ju7QF6C7FkYo7CMwcTpdjXHlFkwi8UaiksC+Lk57jMsU4rmFJ5ZdxG//
         JVTQ==
X-Received: by 10.202.53.84 with SMTP id c81mr14162369oia.120.1424088596191;
 Mon, 16 Feb 2015 04:09:56 -0800 (PST)
Received: by 10.76.82.1 with HTTP; Mon, 16 Feb 2015 04:09:36 -0800 (PST)
In-Reply-To: <54E1C96D.2080109@active-4.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263895>

On Mon, Feb 16, 2015 at 11:41 AM, Armin Ronacher
<armin.ronacher@active-4.com> wrote:
> Long story short: I failed big time yesterday with accidentally executing
> git reset hard in the wrong terminal window but managed to recover my
> changes from the staging area by manually examining blobs touched recently.
>
> After that however I figured I might want to add a precaution for myself
> that would have helped there.  git fsck is quite nice, but unfortunately it
> does not help if you do not have a commit.  So I figured it might be nice to
> create a dangling backup commit before a reset which would have helped me.
> Unfortunately there is currently no good way to hook into git reset.
>
> Things I noticed in the process:
>
> *   for recovering blobs, going through the objects itself was more
>     useful because they were all recent changes and as such I could
>     order by timestamp.  git fsck will not provide any timestamps
>     (which generally makes sense, but made it quite useless for me)
> *   Recovering from blobs is painful, it would be nice if git reset
>     --hard made a dangling dummy commit before :)
> *   There is no pre-commit hook which could be used to implement the
>     previous suggestion.
>
> Would it make sense to introduce a `pre-commit` hook for this sort of thing
> or even create a dummy commit by default?  I did a quick googling around and
> it looks like I was not the first person who made this mistake.  Github's
> windows client even creates dangling backup commits in what appears to be
> fixed time intervals.
>
> I understand that ultimately this was a user error on my part, but it seems
> like a small change that could save a lot of frustration.

Something like "can we have a hook for every change in the working
tree" has come up in the past, but has been defeated by performance
concerns. "git reset --hard" is a low-level-ish operation, and it's
really useful to be able to quickly reset the working tree to some
state no matter what, and without creating extra commits or whatever.

We should definitely make recovery like this harder, but is there a
reason for why you don't use "git reset --keep" instead of --hard?
It'll keep any local changes to your index/staging area, and reset the
files that don't conflict, if there's any conflicts the operation will
be aborted.

If we created such hooks for "git reset --hard" we'd just need to
expose some other thing as that low-level operation (and break scripts
that already rely on it doing the minimal "yes I want to change the
tree no matter what" thing), and then we'd just be back to square one
in a few years when users started using "git reset --really-hard" (or
whatever the flag would be).
