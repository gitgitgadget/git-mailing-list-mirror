Return-Path: <SRS0=WTnS=CW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24740C433E2
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 21:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E43B6221F0
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 21:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgIMVgy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Sep 2020 17:36:54 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42484 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgIMVgw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Sep 2020 17:36:52 -0400
Received: by mail-ed1-f67.google.com with SMTP id j2so4939326eds.9
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 14:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gd3pGXPZgBHBHqvZbtlNsnPQ+BVgbflF5ya+9Q8nLCY=;
        b=K3fvg1X+yILHSJyWv5mHwsJ/WoLku2X3NagB1uTXx7N8N+Pha193zGbrmFALmiSEA0
         brhlGv6MLo7K1R10+xyRGaZBBGbqw3Z+/xkdL/kRaAtugELv5igb75M3+BeiDH7ZEcoa
         SqqXUQQG0Af9k4hlGOwnVhvis6wxMeC4daGrg4MDx49dQEtLJ9Owj/0tD06e7rxbU03D
         1ESgWkBH+d1srlUJaOOKPiOFPLcqy3C1Km4glONy/3n0X0Nc5u9smM4l4q8D0KaNrzAb
         tHMkiTayTt2PNCAKXDDDF6UyvYd3pakij3d5NLT9PH+hdcYxK2kcO77RNh57TABwq23L
         4vIA==
X-Gm-Message-State: AOAM530ep699bGW9VCdph5Zm6uGPXf+GphV813CYxxD+Ccvkro13WjIu
        jHKcA6p0goWKmsB3esMnm/TF8fXl10Pz4qC4r9X48lfHg10=
X-Google-Smtp-Source: ABdhPJx9znirWibHhh5ZQSZSDH7RE5iIeTytSPvRuH2m9YEAD8WNG2I/1KeUh7ghln68eiCivXtoG2ij0MRzgaMGgm0=
X-Received: by 2002:a05:6402:1016:: with SMTP id c22mr14801110edu.89.1600033010636;
 Sun, 13 Sep 2020 14:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200911185754.64173-3-alipman88@gmail.com> <20200913193140.66906-1-alipman88@gmail.com>
 <20200913193140.66906-4-alipman88@gmail.com>
In-Reply-To: <20200913193140.66906-4-alipman88@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 13 Sep 2020 17:36:39 -0400
Message-ID: <CAPig+cTNp84Dm=0n-Bb9o=1nZNDFRE20XDWUPJT8yjdefv15rA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ref-filter: allow merged and no-merged filters
To:     Aaron Lipman <alipman88@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 13, 2020 at 3:32 PM Aaron Lipman <alipman88@gmail.com> wrote:
> Enable ref-filter to process multiple merged and no-merged filters, and
> extend functionality to git branch, git tag and git for-each-ref. This
> provides an easy way to check for branches that are "graduation
> candidates:"
>
> $ git branch --no-merged master --merged next

A few subjective comments below, not necessarily worth a re-roll...

> To accomplish this, store the merged and no-merged filters in two
> commit_list structs (reachable_from and unreachable_from) rather than
> using a single commit struct (merge_commit).

This sort of implementation detail is readily discoverable by reading
the patch itself, and since there is no complexity about it which
requires extensive explanation, we'd normally leave it out of the
commit message.

> If passed more than one merged (or more than one no-merged) filter, refs
> must be reachable from any one of the merged commits, and reachable from
> none of the no-merged commits.
>
> Signed-off-by: Aaron Lipman <alipman88@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> @@ -2231,13 +2231,20 @@ void ref_array_clear(struct ref_array *array)
> -static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
> +static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata, int reachable)
>  {
>         [...]
> +       struct commit_list *check_reachable_list = reachable ?
> +               ref_cbdata->filter->reachable_from :
> +               ref_cbdata->filter->unreachable_from;
> +
> +       if (!check_reachable_list)
> +               return;

Rather than adding a boolean 'reachable' parameter to the function
signature, you could instead directly pass in the `struct commit_list
*` upon which to operate, which would allow you to drop the ternary
operator here, and...

> @@ -2322,8 +2337,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
> -       if (filter->merge_commit)
> -               do_merge_filter(&ref_cbdata);
> +       do_merge_filter(&ref_cbdata, 1);
> +       do_merge_filter(&ref_cbdata, 0);

... make the callers a bit less opaque by eliminating the
less-than-meaningful 0-or-1, and making it obvious which list is being
consulted:

    do_merge_filter(&ref_cbdata, ref_cbdata->filter->reachable_from);
    do_merge_filter(&ref_cbdata, ref_cbdata->filter->unreachable_from);

> @@ -2541,31 +2556,22 @@ int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
> +       if (starts_with(opt->long_name, "no"))
> +               commit_list_insert(merge_commit, &rf->unreachable_from);
> +       else
> +               commit_list_insert(merge_commit, &rf->reachable_from);

... quite like it's obvious here into which list the item is being inserted.

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> @@ -1299,8 +1299,8 @@ test_expect_success '--merged catches invalid object names' '
> -test_expect_success '--merged is incompatible with --no-merged' '
> -       test_must_fail git branch --merged HEAD --no-merged HEAD
> +test_expect_success '--merged is compatible with --no-merged' '
> +       git branch --merged master --no-merged master
>  '

This revised test doesn't seem to have all that much value since this
combination is checked by new tests added elsewhere by the patch.
Therefore, another option would be simply to drop the test rather than
revising it. (But, again, it's a judgment call.)

> diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
> @@ -226,6 +226,16 @@ test_expect_success 'multiple branch --contains' '
> +test_expect_success 'multiple branch --merged' '
> +test_expect_success 'multiple branch --no-merged' '
> +test_expect_success 'branch --merged combined with --no-merged' '

Would it make sense to also test multiple --merged and multiple
--no-merged? (Genuine question, not a demand to add more tests.)

> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> @@ -2016,7 +2016,7 @@ test_expect_success '--merged can be used in non-list mode' '
>  test_expect_success '--merged is incompatible with --no-merged' '
> -       test_must_fail git tag --merged HEAD --no-merged HEAD
> +       git tag --merged HEAD --no-merged HEAD
>  '

I think you forgot s/incompatible/compatible/ in the test title (which
you changed in the other cases).
