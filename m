Return-Path: <SRS0=dguO=BT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2421C433E0
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 02:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFBD52067D
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 02:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgHICaw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 22:30:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38461 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgHICau (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 22:30:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id a14so5031137wra.5
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 19:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m9jsFnkPL+9qanCJOByGa0Sk7Z5JVJhYkgFxr4Bkmaw=;
        b=tIKTTY82eICJhmAaqx5Xo9t/5wefbmXcQk7PdqqouCwUBGtTGXQUX76VxCanLxTBVQ
         b0ll4/bVTgk7QAeRKZYfhmplwRJxqSUcEVtvapeLIMNvxGK3ZHr6DM8Orf2fiWL9PlIz
         6BMVRfaQlnN62bUP62k9xXBizo9+ke1wXvWgTlOY8QiFv2y/6l8Cvkp+kM3QM5tteY4l
         PEOwHZwC07/g0X13CRjfc6mmDHZ2CtnIyKugCIRo4cDH0zWrZKNCu2d4jyUKrEs8IMDQ
         0xpCpEsel3QXAEIZ08v1B+Rt+EknH6a3xi7Gx7I7W/sXFSNaMwnseONGEw/JrstAwTOx
         B0qA==
X-Gm-Message-State: AOAM530fRelUn20ERtFFfrjB2mXWvfYuUJjXcvrZmpZOZGQeeWKCjJAE
        /TrSxDEkyf/bqFC35QBS2pXcKtN9ZOmgznWI9SU=
X-Google-Smtp-Source: ABdhPJyZbZD5keAJlMwPxgcnc6lH0m5DF0at7rgoV3reF9hyj3t64ecTm6lo87jt9PkTwThad8IOUy47DPEMv9ITopg=
X-Received: by 2002:a5d:540c:: with SMTP id g12mr18019755wrv.120.1596940248854;
 Sat, 08 Aug 2020 19:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.827.git.git.1596644952296.gitgitgadget@gmail.com>
 <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com> <7f408b7d4069403b969d334f4940ebf87f1dc797.1596906081.git.gitgitgadget@gmail.com>
In-Reply-To: <7f408b7d4069403b969d334f4940ebf87f1dc797.1596906081.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 8 Aug 2020 22:30:38 -0400
Message-ID: <CAPig+cQ0ikSOdmohSkE8o+ZmyuXMXPEvSaz7MtWwCUxFghqrHQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] t6422: fix bad check against missing file
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 8, 2020 at 1:02 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> diff --git a/t/t6422-merge-rename-corner-cases.sh b/t/t6422-merge-rename-corner-cases.sh
> @@ -974,8 +974,8 @@ test_expect_failure 'rrdd-check: rename/rename(2to1)/delete/delete conflict' '
> -               test_cmp file_is_missing foo &&
> -               test_cmp file_is_missing bar &&
> +               test_path_is_missing foo &&
> +               test_path_is_missing bar &&

These errors in the tests went unnoticed because they are inside
test_expect_failure(), which makes one wonder if test_cmp() should be
updated to throw a hard error to help diagnose this sort of problem
sooner. (Then again, that might be overkill since there are relatively
few test_expect_failures() around, so it may not buy us much. On the
other hand, every little bit helps.)
