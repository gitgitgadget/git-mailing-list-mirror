Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AA4C433FE
	for <git@archiver.kernel.org>; Sat,  8 Oct 2022 03:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiJHD1t convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 7 Oct 2022 23:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJHD1r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 23:27:47 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C462E80EBD
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 20:27:45 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id g13so3422768ile.0
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 20:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9711XhbieGWxrKnQrqZr5+ZkB8dcDL1K8GCek4wDubc=;
        b=mOJh5l7nx5wgRcrKGQ6/ZxTNRaUB/NgKvQ4LIJkCnx0EF3OPOIxo5dDiTk+ygcaMP8
         cB59IMfKJ090eQ6xG3pjZpgChnHTSKUV20vURpkgc9BNQ+KoHy8m7O1grOlw2bH87Nqg
         FHIj9Uem3nL+yjY0qpksGGskoZaJOqOU0bpQGF3gwoZviztHcnAiIDZqYGza+7fjVtu9
         L0NSWYo+VtHJ9z10euu5rWmrnqe/Uk7J54ttxmPhlepma7W3tupDFV7U35f10Fd0tTbO
         enDKSb7Of2auSlVIMNyG5s4xxBP88EW3fu1NaNFfYcz9BqFvWSmP042Bb0+eBPOxtMeg
         Qi2A==
X-Gm-Message-State: ACrzQf0pRSOTphP0iD/bph+qzP/lg5ToEv+pLrWIOaHtEItwpk7X9Inb
        m4H8rRtrdjrUMDhmuh3/QE81mKYjbhoQau1f3Pg=
X-Google-Smtp-Source: AMsMyM6PJPJJPvC8jBZvbe+QpA9sYraY1AbESsQKQBO9izlPmryquOhujmvPaR01vdMIQPaRHSQgmw3E1WXABESpMhU=
X-Received: by 2002:a05:6e02:b2f:b0:2fa:1c95:5c98 with SMTP id
 e15-20020a056e020b2f00b002fa1c955c98mr4002446ilu.249.1665199664992; Fri, 07
 Oct 2022 20:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <c333cc4b-12a1-82b6-0961-1c42080dad15@gmail.com>
 <930ff836-a5c4-0e85-517d-39645f00cd31@gmail.com> <8d627a2c-923f-181f-a03b-15f370c4dd0f@gmail.com>
In-Reply-To: <8d627a2c-923f-181f-a03b-15f370c4dd0f@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 7 Oct 2022 23:27:33 -0400
Message-ID: <CAPig+cT+Yeh95p-2PgMDYz+_AxeEA72i-zLuQu11QEyWAt8kiA@mail.gmail.com>
Subject: Re: [PATCH v3] branch: description for non-existent branch errors
To:     =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 7, 2022 at 8:49 PM Rubén Justo <rjusto@gmail.com> wrote:
> [...]
> Make the error descriptions for those branch operations with unborn or
> non-existent branches, more informative.
> [...]
> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---
> diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
> @@ -7,6 +7,28 @@ test_description='test show-branch'
> +test_expect_success 'error descriptions on empty repository' '
> +       current=$(git branch --show-current) &&
> +       cat >expect <<-EOF &&
> +       error: No commit on branch '\''$current'\'' yet.
> +       EOF

It's a matter of taste, but leaving and re-entering the single-quoted
context, along with escaping, can make for a difficult read. You could
instead take advantage of the SQ variable already defined by the test
scripts:

    echo "error: No commit on branch $SQ$current$SQ yet." >expect &&

Not worth a re-roll, of course.

> +test_expect_success 'fatal descriptions on empty repository' '
> +       current=$(git branch --show-current) &&
> +       cat >expect <<-EOF &&
> +       fatal: No commit on branch '\''$current'\'' yet.
> +       EOF

Ditto.

> +test_expect_success 'error descriptions on non-existent branch' '
> +       cat >expect <<-EOF &&
> +       error: No branch named '\''non-existent'\'.'
> +       EOF

Likewise.

> +test_expect_success 'fatal descriptions on non-existent branch' '
> +       cat >expect <<-EOF &&
> +       fatal: branch '\''non-existent'\'' does not exist
> +       EOF

Same.

> +       test_must_fail git branch --set-upstream-to=non-existent non-existent 2>actual &&
> +       test_cmp expect actual &&
> +
> +       cat >expect <<-EOF &&
> +       fatal: No branch named '\''non-existent'\''.
> +       EOF

Again.
