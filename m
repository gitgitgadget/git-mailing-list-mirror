Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80E241F453
	for <e@80x24.org>; Thu,  8 Nov 2018 17:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbeKICpO convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 8 Nov 2018 21:45:14 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35773 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbeKICpO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 21:45:14 -0500
Received: by mail-qk1-f193.google.com with SMTP id w204so2754785qka.2
        for <git@vger.kernel.org>; Thu, 08 Nov 2018 09:08:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YR+Yj6RuXJI4zivNoveXedVA8S88GzT3BScN1lguwF4=;
        b=lYv2Oa1PywExLNdN9FxttJ640q2JKpY3K7/IkAk/AVqxENdxUDfUh0amD8vSBpuK2t
         yVFqZfodUNqavRxVUaYrGyPsWHqnPO58M7UW7RF3LXc7g4Dgx768kxovJ4cf2FJOKtju
         xTSRl/rELwfwo2HbkVjZ40CqxkZRkM4u1xVyrVRXahvJPNttmf3sb2Vc/bh73oFokTZw
         btOLdBiUzjW3VTPUVWIycLegh7+yG6f/m2ZoZVo48Ig9KzDtatFjPZTx1sqVms/KvQTT
         Ocht1D6FoRVJIV5n+/EzcbhWn/9wM03XDUbNRYfFQPAVDupcU0klingLPfyD9qnTc0DL
         Zf1g==
X-Gm-Message-State: AGRZ1gL45aUek7JR2JgxaOtwNpwQUu3IeVor0+ZX/+N9P4HeeuPAfGad
        3UzpnPApFe9dtPjAojWqvkaCMXmEY0mOpH1nkMM=
X-Google-Smtp-Source: AJdET5crChmUuJyDHOoq+qzPITk9qsraZEflFOKdb7HIiN9b+iHxEFfJD+jz5Vqo37njnl0niFfoUuJstM7cJIDQMGI=
X-Received: by 2002:ac8:36ba:: with SMTP id a55mr5109853qtc.236.1541696927842;
 Thu, 08 Nov 2018 09:08:47 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.QRO.7.76.6.1811071202480.39@tvgsbejvaqbjf.bet> <20181107122202.1813-3-avarab@gmail.com>
In-Reply-To: <20181107122202.1813-3-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 8 Nov 2018 12:08:37 -0500
Message-ID: <CAPig+cTeNcn_raJWfEK_C_du1v1KYQFTVmWA9B4DNHAXoFHw-w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] range-diff: fix regression in passing along diff options
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 7, 2018 at 7:22 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> In 73a834e9e2 ("range-diff: relieve callers of low-level configuration
> burden", 2018-07-22) we broke passing down options like --no-patch,
> --stat etc. Fix that regression, and add a test for some of these
> options being passed down.

Thanks both (Ævar and Dscho) for cleaning up my mess, and sorry for
not responding sooner; I only just found time to read the discussion
thread. One comment below...

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/range-diff.c b/range-diff.c
> @@ -453,7 +453,8 @@ int show_range_diff(const char *range1, const char *range2,
>                 memcpy(&opts, diffopt, sizeof(opts));
> -               opts.output_format = DIFF_FORMAT_PATCH;
> +               if (!opts.output_format)
> +                       opts.output_format = DIFF_FORMAT_PATCH;

Looking at diff.c:parse_diff_opt() and enable_patch_output(), rather
than introducing this new conditional, I'm thinking that a more
correct fix would be:

    opts.output_format |= DIFF_FORMAT_PATCH;

(note the '|=' operator). This would result in 'opts.output_format'
containing (DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT), just as it did
prior to 73a834e9e2 when --no-patch was specified.
