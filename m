Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15870C433E0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 21:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE505206A1
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 21:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgF3Vs6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:48:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39914 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbgF3Vs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 17:48:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id q5so21615113wru.6
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 14:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g5N10Tgb1XRx+Vg2pREgqSHSFL/BLVa5yEIiBJNj1Nk=;
        b=Tl98pp6hEVzyZTu6D8CCovOSOcnyvDvfHd3DuXXqhbEzoiJuxU4nK+k8SGBllZPRKw
         vhat5EUDJB4wrHCpv6aoWdf0BBy1VUOxdH5mQHwXAvm5tTbl5RfqnFOMjJn7YOtIDgfj
         NolCUQOh06VYaIFojbgeGKuChb4r9EB7bdeafdQnVl9+d++A7+nVejI3vhwnvjV2x9+8
         o1RRgUtxbygR+ml7oRCNiNTEutuHhvgfbeOIJczXScoPsrW/vO/VigGttWiFF1CsbJKQ
         JZLyx0gsqTmXXxSkL+1xCqMVr98SOAt/3DzzbzEIxDggwgOEBgwffClSkYbk6etibXoU
         A/hA==
X-Gm-Message-State: AOAM530kbU+gAUPUsbP8ylPYD5R/AXxYu/BeErTZpBBN4uwWJFPDL+kS
        9E4X30o5mRMyQ+qS1tGK/REPW3Ls9RATSU4KBPw=
X-Google-Smtp-Source: ABdhPJyKaI/+Lac5ldFecM+yI9poIKr/O1e/ujavFb8IGIdcxWnn/IVAY2Dnz/iSXhGsy9dEDR5yNxUHr6+k3fXf4Jg=
X-Received: by 2002:adf:f34f:: with SMTP id e15mr23795469wrp.415.1593553735080;
 Tue, 30 Jun 2020 14:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593529394.git.liu.denton@gmail.com> <67d5b93fdaab7f73f352293372ee3d71fb7c1409.1593529394.git.liu.denton@gmail.com>
In-Reply-To: <67d5b93fdaab7f73f352293372ee3d71fb7c1409.1593529394.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 30 Jun 2020 17:48:44 -0400
Message-ID: <CAPig+cTYJwDL_uGfSR0OmU4fYANbqQ5jLkyN29WXDvq6gWG_Zg@mail.gmail.com>
Subject: Re: [PATCH 1/5] t3701: stop using `env` in force_color()
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 30, 2020 at 11:03 AM Denton Liu <liu.denton@gmail.com> wrote:
> In a future patch, we plan on making the test_must_fail()-family of
> functions accept only git commands. Even though force_color() wraps an
> invocation of `env git`, test_must_fail() will not be able to figure
> this out since it will assume that force_color() is just some random
> function which is disallowed.
>
> Instead of using `env` in force_color() (which does not support shell
> functions), export the environment variables in a subshell. Write the
> invocation as `force_color test_must_fail git ...` since shell functions
> are now supported.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> @@ -31,7 +31,13 @@ diff_cmp () {
>  force_color () {
> -       env GIT_PAGER_IN_USE=true TERM=vt100 "$@"
> +       (
> +               GIT_PAGER_IN_USE=true &&
> +               export GIT_PAGER_IN_USE &&
> +               TERM=vt100 &&
> +               export TERM &&
> +               "$@"
> +       )
>  }

I'm having trouble understanding why this function was transformed the
way it was. I presume the subshell is to ensure that the variable
assignments don't escape the function context since you're dropping
'env', however, it seems the following would be simpler:

    force_color ()  {
        (GIT_PAGER_IN_USE=true TERM=vt100 "$@")
    }

Or, is there something non-obvious going on that I'm missing?

By the way, I'm wondering if the subshell deserves an in-code comment.
Whereas, we have somewhat settled upon the idiom 'test_must_fail env
FOO=bar ...' when we need to make sure variable assignments don't
escape the local context -- since 'FOO=bar test_must_fail ...' doesn't
make that guarantee under all shells -- the use of a subshell here to
achieve the same (if I'm understanding correctly) is not nearly so
obvious. The non-obviousness is due to "$@" being abstract -- someone
reading the code won't necessarily realize that the first element of
"$@" might be a shell function, thus would not necessarily understand
the use of a subshell.
