Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC84C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 01:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiLBBC3 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 1 Dec 2022 20:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiLBBC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 20:02:27 -0500
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3C6C1BD5
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 17:02:26 -0800 (PST)
Received: by mail-pg1-f173.google.com with SMTP id 136so3145060pga.1
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 17:02:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EuTg+Yr7mQdt0lbEEXg3bqmzSXqiVML91aYLfsCzr0Y=;
        b=6dM285Sp2yv2ar35xChXV5JCvj+7plqIx4R4lBElmLVov2WhlRlj+SHZtRfP9mY9Zu
         HRrWa6OUdF0d2xZLgXqgxtPt923ZgWN6T4Wq+68dRny90OvsdaxXe9cJD714IUSLnYia
         9h7wexAfvpZXOozHTbEpoy/3EWtC5K9b5pt3XeVUAOdGUVjRWfObOE2Xw3/9zLEjyxUK
         Jlvl4enG1TTNtUkN6hDyMAYWLdKLoPyttkyHh3b+mbr26xCHrAuc4gv1wTU/qEUa1qvY
         o0xG8RqaQoYK3tCmUyzAR/TroWnDTvydcnrRte0rCXRUbX3zV37Z6eo3Pi3oQiRLyTbA
         eOEQ==
X-Gm-Message-State: ANoB5pmlrFXvKkDVEaz1Sn6g82M3vZJDEm0NuEyKfzqZI1J1B8dNSXdo
        Hmv2oSsMLG1b7EJfKojWAZxoAwNrRXqBSUczzyYl4yKU
X-Google-Smtp-Source: AA0mqf4LBzyrpc7qyfJy/EQA1O7u+qg8p12d5J7U+KzVi3nEp6yos4eSYqYbTJkML1oQDfDwddm49ea3LOHk5a8ENio=
X-Received: by 2002:aa7:9534:0:b0:575:c857:edc0 with SMTP id
 c20-20020aa79534000000b00575c857edc0mr12367071pfp.22.1669942945887; Thu, 01
 Dec 2022 17:02:25 -0800 (PST)
MIME-Version: 1.0
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com> <patch-v2-1.8-7c9f8d2830f-20221202T000227Z-avarab@gmail.com>
In-Reply-To: <patch-v2-1.8-7c9f8d2830f-20221202T000227Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 1 Dec 2022 20:02:14 -0500
Message-ID: <CAPig+cQK8BRU0u0g+jAkyJaqSamYBynJ6s00_6H2beb6gXaRDA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] log tests: don't use "exit 1" outside a sub-shell
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 1, 2022 at 7:07 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Change an "exit 1" added in ac52d9410e5 (t4205: cover `git log
> --reflog -z` blindspot, 2019-11-19) to use "return 1" instead, which
> curiously was done in an adjacent test case added in the same commit.
>
> Using "exit 1" outside a sub-shell will cause the test framework
> itself to exit on failure, which isn't what we want to do here.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> @@ -156,7 +156,7 @@ test_expect_success 'NUL termination with --reflog --pretty=oneline' '
>         for r in $revs
>         do
>                 git show -s --pretty=oneline "$r" >raw &&
> -               cat raw | lf_to_nul || exit 1
> +               cat raw | lf_to_nul || return 1
>         done >expect &&

Using `return 1` here is "obviously correct" since this code is not
inside a subshell. Furthermore, the exit code of the for-loop itself
is not being lost down a pipe, so `return 1` is indeed an appropriate
way to signal failure. Good.
