Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76127C43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4420021D91
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgIJTeS convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 10 Sep 2020 15:34:18 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38170 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbgIJT2y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 15:28:54 -0400
Received: by mail-ed1-f66.google.com with SMTP id c8so7524353edv.5
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 12:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sDDx7K2RlwElPOYUEW/ECBoxj1qBzn7q5jnRxf9RCzs=;
        b=SWAKHuROneJAl3TBSu6cVc8BTIUO9TTdOQuBfFcuvEjUqG59QLWav5R3TCO9KFHELe
         mmWYunvxbBqnUsxSG+DaGCduBcNM0OovkMx2ye51hCrFH/zria0P2rNGnjCbLEuWxQq3
         3FoFcUDhd77jk4seig33MoxmTmEFMdq5WubWwcCQg5mvb0tSKREl1k1xP6a0jmURBmUG
         NMm1yh7McdGnLcsMzshMyqXmp6VVD633FR0fKLN0L9RfeNPOekcpnILegFmKixjmxphp
         RDlyYGyjLEorHGUaEQ7TwVZEPnrHQKKWI010TrSh+WDHNkFL4ychsDl6Yntxvh1i0A5w
         O/JQ==
X-Gm-Message-State: AOAM530ogXKG5zMwolylMsf+WzBpeuZmBnyDO+V4SW8qfKyOEyywJbMv
        Nv6AkBXajS7F3uvhh2zfPS/IdSE44fLQSEvcZRw=
X-Google-Smtp-Source: ABdhPJwxI7Y6VJ+QBqv6k/GPeN/d6JtkvVu6zMzrtS9xmQn7WgQZGQ09wo2iA+hSxy3JJxH510Qh4dB+risQj7Pk3aM=
X-Received: by 2002:a50:8f85:: with SMTP id y5mr10969786edy.233.1599766132702;
 Thu, 10 Sep 2020 12:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599762679.git.martin.agren@gmail.com> <8383c246f8c23e61dedd69d6e69c72d51fd6b469.1599762679.git.martin.agren@gmail.com>
In-Reply-To: <8383c246f8c23e61dedd69d6e69c72d51fd6b469.1599762679.git.martin.agren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 10 Sep 2020 15:28:41 -0400
Message-ID: <CAPig+cT_VvOiKBCC=E_P0R8SXkoWPVUxxOOLovOmr8N377YNdQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] worktree: simplify search for unique worktree
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 10, 2020 at 3:08 PM Martin Ågren <martin.agren@gmail.com> wrote:
> We track the number of worktrees we've found and break out of the loop
> early once we hit 2. This is because we're not really interested in the
> number of matches -- we just want to make sure that we don't find more
> than one worktree that matches the suffix. This can be done just as well
> by checking the NULL-ness of the pointer where we collect our
> answer-to-be. Drop the redundant `nr_found` variable.
>
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
> diff --git a/worktree.c b/worktree.c
> @@ -172,13 +172,13 @@ static struct worktree *find_worktree_by_suffix(struct worktree **list,
>                                                 const char *suffix)
>  {
> -       for (; *list && nr_found < 2; list++) {
> +       for (; *list; list++) {
> @@ -186,11 +186,12 @@ static struct worktree *find_worktree_by_suffix(struct worktree **list,
>                 if ((!start || (start > 0 && is_dir_sep(path[start - 1]))) &&
>                     !fspathcmp(suffix, path + start)) {
> +                       if (found)
> +                               return NULL;
>                         found = *list;
> -                       nr_found++;
>                 }
>         }
> -       return nr_found == 1 ? found : NULL;
> +       return found;

Although this change appears to be correct and does simplify the code,
I think it also makes it a bit more opaque. With the explicit
`nr_found == 1`, it is quite obvious that the function considers
"success" to be when one and only one entry is found and any other
number is failure. But with the revised code, it is harder to work out
precisely what the conditions are. Having said that, I think a simple
comment before the function would suffice to clear up the opaqueness.
Perhaps something like:

    /* If exactly one worktree matches 'target', return it, else NULL. */
