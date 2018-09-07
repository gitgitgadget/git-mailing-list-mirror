Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD97E1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 00:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbeIGFFP (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 01:05:15 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33656 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbeIGFFP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 01:05:15 -0400
Received: by mail-qk1-f195.google.com with SMTP id z78-v6so8657857qka.0
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 17:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3oPRvJ/hp8RfcVUqLICxJ3NoKsgTYAFa/CGVy7BNj7g=;
        b=jQ2nr+CWLaGX7U9/QTC9d30l94pjuBEtJlv/SfaWXl22vXs/9tVebwR8QiLJh0rjkU
         LKIZKBXOzcdVAbUDVB30ewNpkxA51EAc/Px523o94+RJq6MeoELSBsQnr4T0u8LDqcKI
         d9LpjPRRx5/+t58SZtcnEww1rDkyv8zKz/8sXwvfOr2jiPGBPQWQb7sKs0Mf3BJK8Tnk
         27eYtKbLa3qlK0ACXyhMf5yvFmlCMyL4hmaUKJHA/0BBEyURGNuiJaGZePak6sgeNjem
         OdcHMOqgz8vFv8fjmlbyHtD5jM5SYVKO+zhr+v8upztJ6ExTcASX/NrzWlfbEbDkw2/N
         RxTw==
X-Gm-Message-State: APzg51CIMCb5KIrqQWK2cqc5pgrdkNBNFqF39TfRE1inv4KvTqh9UwMU
        upSqjuS3JTPEYPeKixaF+qmfu3IwKa584i06HBTYWg==
X-Google-Smtp-Source: ANB0VdYImArb2MaQ4Aq7+J8ivGsPFU5qr9HgfNvHe/3ZVdx4yJugjHFQvXgLYSadaXlMR1RhC97STTIeLdcElBuvNRE=
X-Received: by 2002:a37:48e:: with SMTP id 136-v6mr4179359qke.26.1536280032321;
 Thu, 06 Sep 2018 17:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.34.git.gitgitgadget@gmail.com> <787e1fb61626afe79cfc846c4175d4b4d169ff42.1536158789.git.gitgitgadget@gmail.com>
In-Reply-To: <787e1fb61626afe79cfc846c4175d4b4d169ff42.1536158789.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 6 Sep 2018 20:27:01 -0400
Message-ID: <CAPig+cSOcfQDYP+LEZxhRst__dXZUc=euoORZk0iGYrh9adm1A@mail.gmail.com>
Subject: Re: [PATCH 02/11] multi-pack-index: verify bad header
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 5, 2018 at 10:46 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Add tests that check corrupted headers in a few ways:
> [...]
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> @@ -154,6 +154,51 @@ test_expect_success 'verify multi-pack-index success' '
> +corrupt_midx_and_verify() {
> +       POS=$1
> +       DATA="${2:-\0}"
> +       OBJDIR=$3
> +       GREPSTR="$4"

If you happen to re-roll, perhaps make these assignments part of the
&&-chain to protect against someone coming along some day an inserting
code before them without realizing that the &&-chain is broken.

> +       FILE=$OBJDIR/pack/multi-pack-index &&
> +       chmod a+w $FILE &&
> +       test_when_finished mv midx-backup $FILE &&
> +       cp $FILE midx-backup &&
> +       printf "$DATA" | dd of="$FILE" bs=1 seek="$POS" conv=notrunc &&
> +       test_must_fail git multi-pack-index verify --object-dir=$OBJDIR 2>test_err &&
> +       grep -v "^+" test_err >err &&
> +       test_i18ngrep "$GREPSTR" err
> +}
