Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9C4C1F461
	for <e@80x24.org>; Sat, 17 Aug 2019 18:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfHQSD2 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 17 Aug 2019 14:03:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42019 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfHQSD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 14:03:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id b16so4606623wrq.9
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 11:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xstdjuDlk6JD+5KAZljO3qec/49QHEgqm3G2QUnW7Fo=;
        b=P+am7mh/S51ZQYQBHUM/RPp4USHoEpSU+nnVrbXHRum8VG+gJ/TTh3STwO2n39yz4J
         6OD+lGja8WnqbvaX7hA+B51io0MbinGA4yyo47qGaw8Xzyvkd0j1Hq/V8NnK5Zvit/l4
         O7gjlSstCiMi6v0GksenAVmg7+nvbYUGUDO0Hb8cfmNIINErnZHajC97W6tjholM87k4
         rXHh2uVr/5nPtcL7ODccDRYxEUubPM3C8sUzTAPla31kqu1uRxRmh2aAwi9xUjrF+UZY
         0Vo4YAnwoshlHp1k9TWRQ4QKcPLPVZzWB553B4pXkYi1WyQCv/Y13uwl9j+miHFvmdx8
         aPCg==
X-Gm-Message-State: APjAAAX3+yfwG75Nr5aHM9MYotdq8XiBt4pq6PTk3jlMmEviBCFHrqzX
        rLywtqh5azDkceGEfiL2ZDe9aYhnxd++OM5nQCI=
X-Google-Smtp-Source: APXvYqznCSRNsROMQ9+XPMcqxGyriGmhHxW52QZkS1XjnUvFd6g50Y0n/TKx/WstFxlWDTOIEZQkF0CrWSR/bSuPIDA=
X-Received: by 2002:a5d:4cc5:: with SMTP id c5mr16405054wrt.278.1566065005930;
 Sat, 17 Aug 2019 11:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <c77a0081-93ab-7b97-e322-9616f6e7f86c@web.de> <4b04cf3f-966a-3aa9-6a30-7ac3a234e1ed@web.de>
In-Reply-To: <4b04cf3f-966a-3aa9-6a30-7ac3a234e1ed@web.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 17 Aug 2019 14:03:14 -0400
Message-ID: <CAPig+cRi5uUKHGNB+DezAMaQ6R27U-5Xyy3bUE2c=W0CoyPkVQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] archive-tar: fix pax extended header length calculation
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 17, 2019 at 12:24 PM René Scharfe <l.s.r@web.de> wrote:
> A pax extended header records starts with a decimal number.  Its value

s/records/record/

> is the length of the whole record, including its own length.
>
> The calculation of that number if strbuf_append_ext_header() is off by

s/if/in/

> one in case the length of the rest is close to a higher order of
> magnitude.  This affects paths and link targets a bit shorter than 1000,
> 10000, 100000 etc. characters -- paths with a length of up to 100 fit
> into the tar header and don't need a pax extended header.
>
> The mistake has been present since the function was added by ae64bbc18c
> ("tar-tree: Introduce write_entry()", 2006-03-25).
>
> Account for digits added to len during the loop and keep incrementing
> until we have enough space for len and the rest.  The crucial change is
> to check against the current value of len before each iteration, instead
> of against its value before the loop.
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
