Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DF3B20248
	for <e@80x24.org>; Mon, 11 Mar 2019 05:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfCKFzZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 01:55:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34932 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfCKFzY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 01:55:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id y15so2984349wma.0
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 22:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R8NIVDlCgjlnTv4am5uwTgvc9PALZ2q2nGZ+EdjohdM=;
        b=tsNjeQ9GQ0p8s7c1r3CC7byzq8PVZBY0/ljwvTodMNHBpAf3YRmWTADM+gzhGpltxv
         opxu1JJ10ZGj7w38jthk2nxTggaMqLSLFBkPpX3+bARyGTGuu+cZA3Q2AB8nvAmlcZzv
         DmjjhVq1QjYgl3xV/RhwIDW56LAlFkJ2Uj3rZZDshvSyICbHimAX74jv2ij9AM31T4lF
         sKtqDCVEVwPIBEJ6/6FPyOpobBlrm6csxSvz/8scJSDWJX81wC/oDiAkHOFMRi9r92B5
         Pp+LjFPAJoUbQ43AtWgR6zLTpYHNHBoy3TdQRx5cOo3M+Pdnq7CEY1Ckh7MWEj9+AVQL
         Am6w==
X-Gm-Message-State: APjAAAW7CXhpJ1cGc9VopZwvasev/IX+r23ZoWKQHM3bMLXXjemMz1l2
        /nBoh4pXIj1vf5rjqOp4vuNlpJ5/wOMTVSSZPYE=
X-Google-Smtp-Source: APXvYqwTas0LBgWnqoxPzJtRFTwv7lHm1eSAq5MJTHRoeGbiqOxxX3RAULLEBkEbOVIPZaKyX4pS73nckm+4Ro8lsrw=
X-Received: by 2002:a7b:ce8e:: with SMTP id q14mr15883731wmj.71.1552283722900;
 Sun, 10 Mar 2019 22:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1548219737.git.liu.denton@gmail.com> <cover.1552275703.git.liu.denton@gmail.com>
 <b6aca21639eb96b65f201f4a3526d8d4a4180c59.1552275703.git.liu.denton@gmail.com>
In-Reply-To: <b6aca21639eb96b65f201f4a3526d8d4a4180c59.1552275703.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 11 Mar 2019 01:55:12 -0400
Message-ID: <CAPig+cTV8MeugunLLqS4cL-6c5X=xxXTRMV1EB8Nf3i-SapGfQ@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] merge: add scissors line on merge conflict
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 10, 2019 at 11:42 PM Denton Liu <liu.denton@gmail.com> wrote:
> This fixes a bug where the scissors line is placed after the Conflicts:
> section, in the case where a merge conflict occurs and
> commit.cleanup = scissors.
>
> Next, if commit.cleanup = scissors is specified, don't produce a
> scissors line in commit if one already exists in the MERGE_MSG file.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> @@ -246,6 +246,52 @@ test_expect_success 'merge --squash c3 with c7' '
> +test_expect_success 'merge c3 with c7 with commit.cleanup = scissors' '
> +       git config commit.cleanup scissors &&
> +       git reset --hard c3 &&
> +       test_must_fail git merge c7 &&
> +       cat result.9z >file &&
> +       git commit --no-edit -a &&
> +
> +       cat >expect <<-EOF &&

Use <<-\EOF here.

> +               Merge tag '"'"'c7'"'"'
> +
> +               # ------------------------ >8 ------------------------
> +               # Do not modify or remove the line above.
> +               # Everything below it will be ignored.
> +               #
> +               # Conflicts:
> +               #       file
> +               EOF

Style: here-doc body is normally indented to the same level as the
command which starts the here-doc, so this body is indented too much.

Same comments apply to other new test added by this patch.

> +       git cat-file commit HEAD >tmp &&
> +       sed -e '1,/^$/d' <tmp >actual &&
> +       test_i18ncmp expect actual
> +'
