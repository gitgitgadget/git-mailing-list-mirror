Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5798FC43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2850F21556
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIJTRZ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 10 Sep 2020 15:17:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39290 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgIJTPh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 15:15:37 -0400
Received: by mail-ed1-f66.google.com with SMTP id c10so7486945edk.6
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 12:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qWZ9YvcMcrK62d5QvxhiDZb1ZNHiC5j0HhwuF2EqRIc=;
        b=lcmSXNERDyBKfkMVdHqFUBkpqCZGXKftdfFlxtT62SAkvKYaspkaEIdAuYv5mdIZKS
         O1BKXfzzQiUUDCQwQaFWiotdRsy6K82etL51juDcRc/PfAU63HQdqMJD8lj7A2QOKXnp
         HdbXPBZJNs7yxVaYjFkraVIvEU1/NzpIH6tplM1maVsF0zgJZPGJB5y9GejYpqcW2dU2
         Pqy7PgSVKa+juoMoClCQQEMR9yfd2x4+nhFGLosdAVhj4GF5Wo/vddZoB8Jik+DVXL7w
         0zHkNJyGxduBqRS4vu9PmN8f76iN2BlKsXXtYZBOHYIeZz5DtDjMbq46236pqDVPXcmB
         bsXw==
X-Gm-Message-State: AOAM530+en3DlPsJ0PlaA1c3SHcOsxGp739IVfmrW6l62M1nvoVVIrxw
        XLEKUbipPJKxPgkrXQV/8KBGAQV7JR6Qg7OHx3s=
X-Google-Smtp-Source: ABdhPJxfBhEmoLWcsuz1RLVvrsAFohI7Hydgsi+xVrCe/S1y10yHcRTRRuLa5wBGKdMtwMkFQRyLYnOe5TQOR0OiwJE=
X-Received: by 2002:a05:6402:17ed:: with SMTP id t13mr11162684edy.163.1599765320665;
 Thu, 10 Sep 2020 12:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599762679.git.martin.agren@gmail.com> <58a2469cc18839e57b45f687b6e484d69161a34c.1599762679.git.martin.agren@gmail.com>
In-Reply-To: <58a2469cc18839e57b45f687b6e484d69161a34c.1599762679.git.martin.agren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 10 Sep 2020 15:15:09 -0400
Message-ID: <CAPig+cTZLqFayp0wZEFYkaXtoOx8HedUK1oQoOa+zq=Yrgvjbg@mail.gmail.com>
Subject: Re: [PATCH 4/8] worktree: drop useless call to strbuf_reset
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 10, 2020 at 3:08 PM Martin Ågren <martin.agren@gmail.com> wrote:
> There's no need to reset the strbuf immediately after initializing it.
>
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
> diff --git a/worktree.c b/worktree.c
> @@ -552,7 +552,6 @@ const char *worktree_ref(const struct worktree *wt, const char *refname)
>  {
>         static struct strbuf sb = STRBUF_INIT;
>
> -       strbuf_reset(&sb);
>         strbuf_worktree_ref(wt, &sb, refname);
>         return sb.buf;
>  }

I think this patch is wrong and should be dropped. That strbuf is
static, and the called strbuf_worktree_ref() does not reset it, so
each call to worktree_ref() will now merely append to the existing
content (which is undesirable) following this change.
