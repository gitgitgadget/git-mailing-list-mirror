From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 10/16] worktree: make branch creation distinct from
 worktree population
Date: Sun, 12 Jul 2015 17:03:29 +0700
Message-ID: <CACsJy8BS7Ss3jP9sq1TuD7-wH6tTYwTKBk9=YVMiJh2ePigjuQ@mail.gmail.com>
References: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
 <1436573146-3893-11-git-send-email-sunshine@sunshineco.com>
 <CACsJy8A8QkeFa3FyCkv8dp-J52NGGaN-AV3oG7W8tNtYqDO-cw@mail.gmail.com>
 <CAPig+cSiPeJskyanLAv71LuFoqPirUJ2FL0B0BsoT8BEVrE3LA@mail.gmail.com>
 <CACsJy8A8CeyeYZnMpbdWW-etohp3TWzGrro1khzD=8skydm6Cg@mail.gmail.com>
 <CAPig+cT-1juGLZK+F1Cy+MDE8+_bPqnX6fgfpoMnd2Qypu3oZQ@mail.gmail.com>
 <CAPig+cQcE0CkNCY6rbzRfjptesawPjeqGx9+rtVhCOADJzcU2Q@mail.gmail.com> <CAPig+cRV8oNw2Jp0mkn=CLTJERG+=O2pvewcjqF=xZ+dMgPnHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Jul 12 12:04:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEE7B-0000pj-KO
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jul 2015 12:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbbGLKD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2015 06:03:59 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:33681 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbbGLKD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2015 06:03:59 -0400
Received: by ietj16 with SMTP id j16so46280787iet.0
        for <git@vger.kernel.org>; Sun, 12 Jul 2015 03:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/JXuxHeY7yzNREFGWMi9hJvGMCZq8kkuBzovDtrNUCY=;
        b=fBxqjwH7Umf7pUs6A3B73DU+xPMv7epXxuMwBGnkw7JNH5PcCQDoSD03L0Ic7rJxok
         /A3IHFt/W9MtvQj0Galm9kj3KokvLmGdtHIIbF1rP0vWTAg+/pxhnkRN3sWSQzzWG4St
         QSk83zTU+msAOLO4cDXlnXxFw/D4TViv5GxwHM1s4gYalX1VDDfCNPYRE74ZjfYry/CY
         TySuKvFuL+NERPHgB+8LmT6tORqd0v50OdWwivgzs/6wJ11DTWIFKdd6VDJgAAQf4djr
         hBgv+uckN80F15HaWVCfQ+pmsa2584RQnfciPfA/lf5ai1K6dym0StuLV1mjJm7TPUCD
         fh6w==
X-Received: by 10.107.134.22 with SMTP id i22mr12821034iod.111.1436695438603;
 Sun, 12 Jul 2015 03:03:58 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Sun, 12 Jul 2015 03:03:29 -0700 (PDT)
In-Reply-To: <CAPig+cRV8oNw2Jp0mkn=CLTJERG+=O2pvewcjqF=xZ+dMgPnHA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273891>

(resend, +everybody)

On Sun, Jul 12, 2015 at 10:27 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> So, if I understand your concern correctly, then you are worried that,
>>> following the git-branch invocation, ref_exists() could return the
>>> wrong answer with a pluggable ref-backend since it might be answering
>>> based upon stale information. Is that what you mean? If so, I can see
>>> how that it could be an issue. (As far as I can tell, the current
>>> file-based backend doesn't have a problem with this since it's hitting
>>> the filesystem directly to answer the ref_exists() question.)
>>
>> I meant for this final sentence to end like this:
>>
>>      ...to answer the ref_exists() question, but it still seems
>>      fragile since some future change could introduce caching.
>
> In this case, it's easy enough to side-step the issue since there's no
> need to call ref_exists() if the new branch was created successfully
> (since we know it exists). The logic would effectively become this:
>
>     branch = ...
>     if (create_new_branch) {
>         exec "git branch newbranch branch"
>         exec "git symbolic-ref HEAD newbranch"
>     } else if (ref_exists(branch) && !detach)
>         exec "git symbolic-ref HEAD branch"
>     else
>         exec "git update-ref HEAD $(git rev-parse branch)"
>     exec "git reset --hard"

Yeah.. Another option we can take is deal with this at run-command.c
level (and outside this series) because this could affect everywhere:
by default, invalidate all cache after running any git commands. The
caller can pass options to keep some cache intact if they know the
command won't touch it.

If ref_exists() is the only thing we use, right now it does not use
cache so we should be safe. If the new ref backend introduces a cache,
they would need to examine all callers anyway, including this one. The
cache in refs.c seems to be for for_each_ref.. only, which we don't
call here.
-- 
Duy
