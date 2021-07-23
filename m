Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66ACC4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 21:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82CF460F02
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 21:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhGWVTR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 17:19:17 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:38799 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbhGWVTR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 17:19:17 -0400
Received: by mail-ed1-f51.google.com with SMTP id l6so1542545edc.5
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 14:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BJzIWqqrWbnGFz4JsHKqp2pGzNJcRiH9dNMYnoOZPNw=;
        b=HRzte3emTdowHBbLJtON8ZsUXYj86wKY5ZOsoa8t2V969pnII5xZxDhQxcFGmN2BFj
         7fR2xL4AWLuBiFFKVe9itsWu0+xQdlYOlufvK62t2GxBdpCjUX9SyRkQsGony9tGG/4s
         EZriQt06jK4cRWYdKDPNizOvhDuqwGn1aLsWnfgyJiLX5Y0SkS66OhEuWxWcOqBPNlpq
         ki+o4JEEWz0hpto4n9Bz9H/LIWiDkX5HhetQIvdLUQeJl8mkY6oZxHjI8IH925GsLA59
         S8zw3m7qPdHfVN3XFUNRfPsPla97xLpQoF57aiR/OoCbu4xHiqTwsqAjuZc+R3JceU/8
         o9Wg==
X-Gm-Message-State: AOAM533WvV9k0RKVffxCBW3rcqfWljN5nphKJPSfR7PgS8L4LgUc5MdQ
        izu7X4lAtxa/tG9vSh0YyI5AIMFDks2FxKgSWaQ=
X-Google-Smtp-Source: ABdhPJwbqI4C7Zmd9leWSs3VpBT3cUaBZhA8dOnMuTLz7iJsz1cjlYeqAM68bQ8maCBpo81b3lBL7xmMBzluD6W5om4=
X-Received: by 2002:a05:6402:711:: with SMTP id w17mr7814705edx.233.1627077588613;
 Fri, 23 Jul 2021 14:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.990.git.1627044897.gitgitgadget@gmail.com> <9f8ab62b84256be6d7d984d576ff4fda09d88a1d.1627044897.git.gitgitgadget@gmail.com>
In-Reply-To: <9f8ab62b84256be6d7d984d576ff4fda09d88a1d.1627044897.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 23 Jul 2021 17:59:37 -0400
Message-ID: <CAPig+cQK8F2p4JT6FCFxNALxhoj2_opZit-ao=pLNhOHxN+gDw@mail.gmail.com>
Subject: Re: [PATCH 1/7] diffcore-rename: use a mem_pool for exact rename
 detection's hashmap
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 23, 2021 at 8:55 AM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Exact rename detection, via insert_file_table(), uses a hashmap to store
> files by oid.  Use a mem_pool for the hashmap entries so these can all be
> allocated and deallocated together.
> [...]
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> diff --git a/diffcore-rename.c b/diffcore-rename.c
> @@ -355,7 +357,7 @@ static int find_exact_renames(struct diff_options *options)
>         /* Free the hash data structure and entries */
> -       hashmap_clear_and_free(&file_table, struct file_similarity, entry);
> +       hashmap_clear(&file_table);

Does the in-code comment become a bit out of date with this change?
(It might make sense to drop the comment altogether -- or, if not,
explain that the hashmap entries get thrown away later with the pool?)

Not necessarily worth a re-roll.
