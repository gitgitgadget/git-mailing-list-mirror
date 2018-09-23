Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A6E21F453
	for <e@80x24.org>; Sun, 23 Sep 2018 08:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeIWOCu convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 23 Sep 2018 10:02:50 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38061 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeIWOCt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Sep 2018 10:02:49 -0400
Received: by mail-qt1-f196.google.com with SMTP id z13-v6so5889241qts.5
        for <git@vger.kernel.org>; Sun, 23 Sep 2018 01:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YVctPRuGmaKmsIhUlgF3vtt2IviNFdLxyG+a1uk0lKI=;
        b=CgBPD007+QQzNHSM3Jy6WMhxP/GHf48FoHTiHpmy6+pxIn7XP3e0d2NrgnLUcuv3Wo
         0Tcs6EGDPDS/yFCgwVu7eQkfIO3KnkTCbRdYYr68Y5N75rA2Ibg2MuO6uzRokrCqmRt6
         8bzrI1Rq5kDg8ZltgkubUQQK5aiKy42DG5QXSqPFCjDwZ3d9E9jh76yRZ4cjMOXA9r0X
         hW1lfDHf3j9PsFXJzZmUhSSYM37Kq5U7NC+Eka5JdxVj2GADGYeyaaQ+jy1edrLA1N+O
         W7DCIl5JgcRs99u0E//ymsq9Cf03QZ68XWEOHEvcsggvRrC0qO8PUsvGn3fHPfShzLYi
         UCdg==
X-Gm-Message-State: APzg51DxNE8bfmowc4c7I+m+3XsmBYHTA7Y7FE8BAICaVGC89qXoK9K1
        OwGB9gAEyEpSZxffHNTLzqbkSvaEI8P+FIIGgl0=
X-Google-Smtp-Source: ACcGV62jDGtuj81emFgzsvDSFyVA+TBEWzWApFzgifqcHrfP5L4w9qfDVyxviPSRIQ7vm8wjvO9mdgeagm2G9V54fjg=
X-Received: by 2002:aed:2171:: with SMTP id 104-v6mr3406461qtc.220.1537689973554;
 Sun, 23 Sep 2018 01:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180922180500.4689-1-pclouds@gmail.com> <20180922180500.4689-4-pclouds@gmail.com>
In-Reply-To: <20180922180500.4689-4-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 23 Sep 2018 04:06:03 -0400
Message-ID: <CAPig+cTtjwCMRMx2xS1WPyM30ipxx5QJK_Aueu50i-jLQdpdBA@mail.gmail.com>
Subject: Re: [PATCH 3/8] refs: new ref types to make per-worktree refs visible
 to all worktrees
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 22, 2018 at 2:05 PM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> [...]
> The main worktree has to be treated specially because well.. it's
> special from the beginning. So HEAD from the main worktree is
> acccessible via the name "main/HEAD" (we can't use
> "worktrees/main/HEAD" because "main" under "worktrees" is not
> reserved).

Bikeshedding: I wonder if this would be more intuitive if called
simply "/HEAD" rather than "main/HEAD".

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> diff --git a/refs.c b/refs.c
> @@ -641,12 +641,32 @@ static int is_pseudoref_syntax(const char *refname)
> +static int is_main_pseudoref_syntax(const char *refname)
> +{
> +       return skip_prefix(refname, "main/", &refname) &&
> +               is_pseudoref_syntax(refname);
> +}
> +
> +static int is_other_pseudoref_syntax(const char *refname)
> +{
> +       if (!skip_prefix(refname, "worktrees/", &refname))
> +               return 0;
> +       refname = strchr(refname, '/');
> +       if (!refname)
> +               return 0;
> +       return is_pseudoref_syntax(refname + 1);
> +}

If the input is "worktrees/refs/" (nothing following the trailing
'/'), then an empty string will be passed to is_pseudoref_syntax(),
which will return true. Does that result in correct behavior? (Same
question about "main/" being passed to is_main_pseudoref_syntax().)
