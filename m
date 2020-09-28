Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4CFC2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 05:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 787D0235F7
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 05:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgI1Fai convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 28 Sep 2020 01:30:38 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:44605 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgI1Fah (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 01:30:37 -0400
Received: by mail-ej1-f67.google.com with SMTP id r7so6683877ejs.11
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 22:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0yYGjzh/+D7htH6Ix1moqzRTmSQWI0/2mYe5uNrvhas=;
        b=RL/A6WuQKZbMFYn75Td+77NLZtANOXXdBux79tH4ychzpmU31x25n4qxE3hwsUe/yy
         lui4VAMsq1CqBirRypL57kb+Lxqn/cf8njN3w81joK13WaJfspYJTVfDaU43hhw9TR26
         yiASJNLvZa2BmbtuQMu20aYfk+KVIIfOZd40OjEeNmKHCsnnm7QV/qsJjI/w7scE2iaL
         BZ1lR1mpBE9Zxs/8U+8a3AHLyXyi/xfSpu5By0fe8/5z3VyIjRj/ab17B8JgSuFgxnMJ
         eGSG0eLCifSHpvvbr3glyaw0WFcSn+2UDuu4W+ArDyVbTFZMrBY8y4UNceVxRYi/cVDM
         6gJg==
X-Gm-Message-State: AOAM532uuZ+8NEaTEGCclPNHKb8tcJjWuD0CHSdh2oe1eebrXtxBIufO
        CUWZeQxIExkgB/0IboKJwu8QPVS9T/KfuznhhduNV0I/9BU=
X-Google-Smtp-Source: ABdhPJx3dBUaioa7BH/x35OQz8xYtjGXECJsjQHpgbpirzAC6r77v164hQCqQZY4ASKV/7G1yVTXJRJPBi2HDqhpWsE=
X-Received: by 2002:a17:907:1116:: with SMTP id qu22mr31406ejb.231.1601271035491;
 Sun, 27 Sep 2020 22:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599762679.git.martin.agren@gmail.com> <cover.1600281350.git.martin.agren@gmail.com>
 <c4825f461e0408970f2adb272098bd6f2a80ef78.1600281351.git.martin.agren@gmail.com>
In-Reply-To: <c4825f461e0408970f2adb272098bd6f2a80ef78.1600281351.git.martin.agren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 28 Sep 2020 01:30:24 -0400
Message-ID: <CAPig+cSBPFdF=hM5ho9_g6NCGAprh1mFFT5zX-C9huT3-Qkzow@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] worktree: inline `worktree_ref()` into its only caller
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 27, 2020 at 9:16 AM Martin Ågren <martin.agren@gmail.com> wrote:
> We have `strbuf_worktree_ref()`, which works on a strbuf, and a wrapper
> for it, `worktree_ref()` which returns a string. We even make this
> wrapper available through worktree.h. But it only has a single caller,
> sitting right next to it in worktree.c.
>
> Just inline the wrapper into its only caller. This means the caller can
> quite naturally reuse a single strbuf. We currently achieve something
> similar by having a static strbuf in the wrapper.
>
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
> diff --git a/worktree.c b/worktree.c
> @@ -548,18 +548,10 @@ void strbuf_worktree_ref(const struct worktree *wt,
> -const char *worktree_ref(const struct worktree *wt, const char *refname)
> -{
> -       static struct strbuf sb = STRBUF_INIT;
> -
> -       strbuf_reset(&sb);
> -       strbuf_worktree_ref(wt, &sb, refname);
> -       return sb.buf;
> -}
> -
>  int other_head_refs(each_ref_fn fn, void *cb_data)
>  {
> +       struct strbuf refname = STRBUF_INIT;
> @@ -571,14 +563,17 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
> +               strbuf_reset(&refname);

If I understand correctly, this strbuf_reset() -- which, I suppose,
moved here from the retired worktree_ref() -- is no longer needed now
that the strbuf stopped being static. So, this line should be dropped
from the patch.

> +               strbuf_worktree_ref(wt, &refname, "HEAD");
>                 if (!refs_read_ref_full(get_main_ref_store(the_repository),
> -                                       worktree_ref(wt, "HEAD"),
> +                                       refname.buf,
>                                         RESOLVE_REF_READING,
>                                         &oid, &flag))
> -                       ret = fn(worktree_ref(wt, "HEAD"), &oid, flag, cb_data);
> +                       ret = fn(refname.buf, &oid, flag, cb_data);

One wonders why the original made two calls to worktree_ref() with
identical arguments. Doing so seems to suggest that something about
HEAD might change between the calls, but that doesn't seem to be the
case. The message of the commit[1] which introduced the two calls to
worktree_ref() doesn't explain the reason, and spelunking through the
code doesn't immediately reveal why it was done that way either. So,
presumably(?), it is indeed safe to fold them into a single call to
strbuf_worktree_ref().

[1]: ab3e1f78ae (revision.c: better error reporting on ref from
different worktrees, 2018-10-21)
