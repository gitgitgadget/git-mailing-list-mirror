Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B178DC54EE9
	for <git@archiver.kernel.org>; Sun, 18 Sep 2022 14:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiIRO4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Sep 2022 10:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiIRO4C (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Sep 2022 10:56:02 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82171CFE3
        for <git@vger.kernel.org>; Sun, 18 Sep 2022 07:55:59 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-3452214cec6so313522507b3.1
        for <git@vger.kernel.org>; Sun, 18 Sep 2022 07:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3cFaRBsD914QUsobj0otpo7eGdQr7VhquHyAUg2zMfU=;
        b=nohvF7EETHQ3MvtYlKorfiRALT3+QQb3cyoRSO8UFgNo9b4Kx07bpfHlQWxFqoJTIv
         AhP31amhP7F/RcVVp7fOii+CucEh4c2x8Ri24KrJFyOv/Kc8MGAKeADLjSbtHQUiOcCX
         KwabQERD/3GmfnR2ykyOPXgCiip2srC/iBze4Z0L4NkzSusjvojG2+AhOZkvuorlSubi
         CNrQAa/u8+N+zMJtIszYpYGoJjvekbik3Dw+woyBPID4mUmysLr7N5wxtTNcmvSJtTZV
         HRyr7vDxaY1KEzeMPNls7xOuRl0k9LuulFZmSQGl5WqCiz6MBwOHPFsS/anjrmhoElIQ
         wCyg==
X-Gm-Message-State: ACrzQf2z09a6Sj/9fEw2XtfaMrG5WXT4WR97nYjaXPzjArBnwQG5YewH
        QoUzw8z//POAE+Ak5n48PfXrIFrSoPUGgLavCWtCjiWg
X-Google-Smtp-Source: AMsMyM422PZCvtf3EXvjlO62r6OTegAhJfwXoZWJBj5Z9G4I1v9z2fpmjQpx1so4zLxKWW2hxut+Z9zhvoc5JYZyHcs=
X-Received: by 2002:a0d:e810:0:b0:345:ef8:c59d with SMTP id
 r16-20020a0de810000000b003450ef8c59dmr11543825ywe.405.1663512958822; Sun, 18
 Sep 2022 07:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <CA+JQ7M_Xwxa48ggu88rhA9dG6R3u820Tgu8B2Kg-uMbEVjy3Vg@mail.gmail.com>
 <xmqqpmftev3c.fsf@gitster.g>
In-Reply-To: <xmqqpmftev3c.fsf@gitster.g>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Sun, 18 Sep 2022 16:55:21 +0200
Message-ID: <CA+JQ7M9_o-0W1orXnPRGzoLziE0HBNkLe0HugGNFKxy0LPsgXA@mail.gmail.com>
Subject: Re: [BUG] fixup commit is dropped during rebase if subject = branch name
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 17, 2022, 8:04 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> >   # failure
> >   seq 1 3 >> bar && git add bar && git commit -m main
> >   git tag -f x
> >   seq 4 6 >> bar && git add bar && git commit -m bar
> >   seq 7 9 >> bar && git add bar && git commit --fixup :/main
> >   git -c sequence.editor=: rebase --autosquash --interactive x
> >   git diff ORIG_HEAD
>
> So near the bottom there are "init", and "x".  The commit title of
> "x" is "main" and that is what the fix-up intends to amend.

Yes, sorry if that was unclear. So the branch looks like

  474b082 (HEAD -> main) fixup! main
  acd367f bar
  576294e (tag: x) main
  dd27847 (tag: init) init

so
  git -c sequence.editor rebase -i --autosquash x
should yield

  474b082 (HEAD -> main) fixup! main
  acd367f bar
  576294e (tag: x) main
  dd27847 (tag: init) init

ie. no change, but instead yields

  acd367f (HEAD -> main) bar
  576294e (tag: x) main
  dd27847 (tag: init) init

ie. it drops the fixup! main commit but only if it's the first commit, see
second example I posted

On Sat, Sep 17, 2022 at 4:45 PM Erik Cervin Edin <erik@cervined.in> wrote:
>   # normal
>   git reset --hard init
>   seq 1 3 >> bar && git add bar && git commit -m main
>   git tag -f x
>   seq 4 6 >> bar && git add bar && git commit --fixup :/main
>   seq 7 9 >> bar && git add bar && git commit -m bar
>   git -c sequence.editor=: rebase --autosquash --interactive x
>   git diff ORIG_HEAD

yields

  acd367f (HEAD -> main) bar
  474b082 fixup! main
  576294e (tag: x) main
  dd27847 (tag: init) init

as expected.

> But then I do not think there is any valid expectation if you say
> "keep x intact and rebase everything above", which is what the
> command line arguments tell the last command to do.  Perhaps we
> should keep all original commits up to that "fixup" one without any
> reordering or squashing?

I'm not sure I follow but the report is concerning the unexpected
behavior of dropping the commit under these specific conditions. I'm
not 100% sure but as I recall, this only happens in situation where
the fixup may not be applied (and in which case it should remain as
is).

> The title of your bug report is also curious.  What happens if you
> did
>
>     git branch -m master

that works as expected

  git reset --hard init
  seq 1 3 >> bar && git add bar && git commit -m main
  git tag -f x
  seq 4 6 >> bar && git add bar && git commit -m bar
  seq 7 9 >> bar && git add bar && git commit --fixup :/main
  git branch -m master
  git -c sequence.editor=: rebase --autosquash --interactive x

but changing branch -m to switch -c reproduces the bug

  6650ace (HEAD -> master) bar
  7835cd5 (tag: x) main
  368ed2f (tag: init) init

Hope this better clarifies what is going on!
