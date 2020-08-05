Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976F2C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 00:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7303E206D4
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 00:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgHEAib (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 20:38:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34075 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHEAib (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 20:38:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id f7so39048173wrw.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 17:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3O1AjzHY3Q18aby2BsYgYA+tZ2+NpUInheUSjNDTu74=;
        b=JJiulkS5qbPAmSFEipuGw+pyuT38ths450bTi0jiL7WfDRX/T8RuX5lk+0Xa28Ndm2
         /tUtQOYhSqLOgao6Kq1qVtTZu5K25BorTdY/FO/c5ZDf4D7QSmhMumghYCXRB3MhoA4i
         5Sr0RYsshab5t0tSahWUEENey5yi9857LvL3/zLS6LcD+zTSfPX/O5pU4YcdkOoD5wlX
         ARhT8FB1mO8pLjR3TuSWLT1V8JcOyPZfVjeR3iRQXdDOuNMXQEBUi4HN2FEYFIfNy/O0
         iCToYrIuMG88+yXeFjiLObOx+3q44AyyDLe60fQ5ahmfV3R8e9J+589sKxQ8iyODLt4y
         YJjQ==
X-Gm-Message-State: AOAM531qnx8gdGVcbPxHQoh4dY/ColXlLTZ+sTcDKUp8eeDd9WIB9M0N
        1an9BTyINuAdGtta8Q3BrxFKbG4PKCBPAYo+BWd0c24vHfI=
X-Google-Smtp-Source: ABdhPJxnUbfatGzb6RI1Gp4REQIslEsnu6g5MVSAgcYpr5KEYM+0YBD0oqGpBGbwpw4D8LyESsszZmJLAuqsM7hxaJw=
X-Received: by 2002:a05:6000:11c1:: with SMTP id i1mr399215wrx.277.1596587909201;
 Tue, 04 Aug 2020 17:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200801175840.1877-1-alipman88@gmail.com> <20200804220113.5909-1-alipman88@gmail.com>
 <20200804220113.5909-3-alipman88@gmail.com>
In-Reply-To: <20200804220113.5909-3-alipman88@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 4 Aug 2020 20:38:18 -0400
Message-ID: <CAPig+cQumRSCQA3Et5=h7SD7zqMm_Z6LJVUTonkewR=hNR55Ug@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] rev-list: allow bisect and first-parent flags
To:     Aaron Lipman <alipman88@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 4, 2020 at 6:01 PM Aaron Lipman <alipman88@gmail.com> wrote:
> Add first_parent_only parameter to find_bisection(), removing the
> barrier that prevented combining the --bisect and --first-parent flags
> when using git rev-list
>
> Signed-off-by: Aaron Lipman <alipman88@gmail.com>
> ---
> diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
> @@ -263,4 +263,49 @@ test_expect_success 'rev-parse --bisect can default to good/bad refs' '
> +test_output_expect_success "--bisect --first-parent" 'git rev-list --bisect --first-parent E ^F' <<EOF

Custom is to use single quotes around the test title, not double
quotes (unless you need to interpolate a variable). Same comment
applies to other tests introduced by this patch.

> +test_expect_success "--bisect-all --first-parent" '
> +cat > expect.unsorted <<EOF &&
> +$(git rev-parse E) (tag: E, dist=0)
> +[...]
> +$(git rev-parse e8) (tag: e8, dist=1)
> +EOF
> +
> +# expect results to be ordered by distance (descending),
> +# commit hash (ascending)
> +sort -k4,4r -k1,1 expect.unsorted > expect &&
> +git rev-list --bisect-all --first-parent E ^F > actual &&
> +test_cmp actual expect
> +'

Indent this test body with TAB rather than having it sit at the left
margin. You can use <<-EOF for the here-doc to allow its content to be
indented, as well.

Swap the arguments to test_cmp.

Also, for style consistency, no whitespace following redirect:

    cat >expect.unsorted <<-EOF
    ...
    EOF
    ...
    sort ... >expect &&
    git rev-list ... >actual &&
    test_cmp expect actual
