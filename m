Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6721820248
	for <e@80x24.org>; Fri,  1 Mar 2019 18:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388252AbfCASFa (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 13:05:30 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51301 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfCASFa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 13:05:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id n19so13286638wmi.1
        for <git@vger.kernel.org>; Fri, 01 Mar 2019 10:05:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e1WVs/5TeVMG73eX4Mov4OYuRqdYRgu3WkolRLoRIJk=;
        b=GJJYl9ku4rGl3oX4xp9/PpXSKTV4PNDlWAloTu1vB/mguvA9LoIaQZZ9e0rSwtQEzr
         0kyGKX7LmPGVgHSW35g55u5dBofKBvlRJpCWbhSQf1jdQICRYlMSFsxx+zvgNkPGvJXX
         V+qrlb6+RhnXgNnEu2/wO61nahEapjwDKqRC4ok9wJ68YpukICTrHcaxP5Fvo4pqmAE4
         v9ZdaGY7a+UDj1/vBUWwLbTCmTVxUA63GM2CWtY+lpuoqyr/NWUoJpgpFaVlSId1UCBM
         zoY+fDKRWNeJJkCEiVYyKV535gBB5ojGpznRCxxm72itBjpW11/hl+becsQ1ooJMB4it
         RMCw==
X-Gm-Message-State: AHQUAuYoXVDkgS/BYJ7RzweiNK08O7dueWIiTRZ0X171MiRD+06NBR59
        ZxoU3KtgbAJ9hpQZe54cPo7TuTE7dpoM+77eZc8=
X-Google-Smtp-Source: AHgI3IZxMHqRUWknxrkIjDqfMJsBLtkx0+df0fk2iVLXrhry+hmSZd8kl6co+qGlTOu6gZl+wAjGvwwYtVsu7UgyjBI=
X-Received: by 2002:a1c:7415:: with SMTP id p21mr4140579wmc.31.1551463528412;
 Fri, 01 Mar 2019 10:05:28 -0800 (PST)
MIME-Version: 1.0
References: <20190301175024.17337-1-alban.gruin@gmail.com> <20190301175024.17337-4-alban.gruin@gmail.com>
In-Reply-To: <20190301175024.17337-4-alban.gruin@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 1 Mar 2019 13:05:18 -0500
Message-ID: <CAPig+cQmZOWUZuj2+z+qrrCO-YBMNiEnGic1_FwAcaaj5gA5-w@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] name-rev: check if a commit should be named
 before naming it
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 1, 2019 at 12:50 PM Alban Gruin <alban.gruin@gmail.com> wrote:
> Until now, name_rev() named every commit it found, even it the name

s/even it/even if/

> would ultimately be unused.
> [...]
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> @@ -107,12 +107,18 @@ static int name_rev(struct commit *commit,
>  copy_data:
> -               name->tip_name = tip_name;
> +               if (commit_list_contains(commits, commit) ||
> +                   commit_list_count(commits) == 0) {

Minor: It would probably be more efficient to check if the count is 0
first, and only search the list if not.

By the way, how big is 'commits' likely to get? Will the linear scan
done by commit_list_contains() become an issue? Should it be using a
hash table instead?

> +                       name->tip_name = tip_name;
> +                       free_alloc = 0;
> +               } else {
> +                       name->tip_name = NULL;
> +               }
