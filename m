Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87D221F597
	for <e@80x24.org>; Mon, 16 Jul 2018 07:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbeGPHrj (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 03:47:39 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:34748 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbeGPHrj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 03:47:39 -0400
Received: by mail-yb0-f196.google.com with SMTP id e9-v6so15063037ybq.1
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 00:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+ekmgcqGmKV56GIxOExqafEpybVHX9RNjV289Nn9oQ=;
        b=a8yyTGqstQXKRbp+knlNs7n79CJotE0OEp1YIrTTIsO7kTL7zKdHB06J1fZZmqjnQ8
         DJutfT2T12XPx8HoyxHE8RR/7caHJBPbTJ+eZxRpBFrM1YCoYN16xujjEk3LrHMEnGO9
         VzccY1PLoZ1r6TyMB6bHZrm3vGWnWF2yTNSnOQT+Vqs0isPj2nNC83LYRN6/mdiP2htu
         xj/aa00Y7pVNZkQN5PrT1mzfuTxi46lWbv9zEfqjFWKz8Q+x8AimjFCNzN6DWEaq6kKb
         uG3oryRxUTTE0MssgrdaC5SVemeqq0gfUMNQpwk5kboNJ38fDDpUdmaU+kFvCDkN5o2v
         L75Q==
X-Gm-Message-State: AOUpUlFJZVa90g52OzTY7Hb4agd4y3VHqcpNlDXplHNB4JWlwcaN0uTX
        4ADD0XwnLcjiWcwoDD4809XWJxDIc/avTKU3KZk=
X-Google-Smtp-Source: AAOMgpd79NMBrXJCtVHtUu9YrHbNHGlaS6EywvUFbl/wugoAtxC7i53kaz1BjxDRkpDFFrQrP8tXNpeWsqumlhK1QnA=
X-Received: by 2002:a5b:601:: with SMTP id d1-v6mr7933873ybq.295.1531725700446;
 Mon, 16 Jul 2018 00:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
 <pull.1.v3.git.gitgitgadget@gmail.com> <6b31cbf72c4752771965de333b3cb6e82cf90b2b.1530617166.git.gitgitgadget@gmail.com>
In-Reply-To: <6b31cbf72c4752771965de333b3cb6e82cf90b2b.1530617166.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 16 Jul 2018 03:21:29 -0400
Message-ID: <CAPig+cTnRi=HuyZy+bMKeU9qutZb3K5C4qTb7gCQz7GyGN=FRw@mail.gmail.com>
Subject: Re: [PATCH v3 09/20] range-diff: adjust the output of the commit pairs
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 3, 2018 at 7:26 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> This change brings `git range-diff` yet another step closer to
> feature parity with tbdiff: it now shows the oneline, too, and indicates
> with `=` when the commits have identical diffs.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/range-diff.c b/range-diff.c
> @@ -251,9 +253,57 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
> +static void output_pair_header(struct strbuf *buf,
> +                              struct patch_util *a_util,
> +                              struct patch_util *b_util)
>  {
> -       return find_unique_abbrev(&util->oid, DEFAULT_ABBREV);
> +       static char *dashes;
> +       struct object_id *oid = a_util ? &a_util->oid : &b_util->oid;
> +       struct commit *commit;
> +
> +       if (!dashes) {
> +               char *p;
> +
> +               dashes = xstrdup(find_unique_abbrev(oid, DEFAULT_ABBREV));

It's nice to see that the bulk of the range-diff functionality has
been libified in this re-roll (residing in range-diff.c rather than
builtin/range-diff.c as in earlier versions), so it's somewhat
surprising to see libified code holding onto the 'dashes' buffer like
this in a static variable. An alternative would have been for the
caller to pass in the same buffer to output_pair_header() for re-use,
and then dispose of it at the end of processing.

> +               for (p = dashes; *p; p++)
> +                       *p = '-';
> +       }
> +
> +       strbuf_reset(buf);

...much like 'buf' is allocated by the caller, passed in and re-used
for each invocation, then released by the caller at the end.
