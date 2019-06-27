Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7243A1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 05:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfF0Fm6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 01:42:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46927 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0Fm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 01:42:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so907642wrw.13
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 22:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BJTRsACX3trnzMeD0c3IXjJQcMWnuZsXcI++pD5eaHg=;
        b=jdlNW3tzYg0jjooYvFEqbq1rThIi8j7+qfscKeIT/INGRGkjCFg+7lQcBUiem4V/Dx
         bxw/9gnjzwBzSbKxcvTjPU+DpZnmHEM5u4q9hgAP4/Uy1Pj9//KlGgQ89ZCLk0/OCyc1
         d0Ap1UPwHyumQbJVg05V9HVL6aaKp1eJ0sjFwFvie/XtixrovWEqxE/QGoxvHN4hVAra
         2sCqQ/WU+N2Ciso5el9j48TSQ9TJUvwl4IVJm1jhG3TSVNpJaR4qxsh7uzE6PMIb771w
         EEBIidtNBzlfua7nJSAb7Swpp+S8xREhTPvhzQo2eZ+8yNd3+kVZykP7KL2o0stcVani
         DNIg==
X-Gm-Message-State: APjAAAVwxReWJuu124LSvqgVk2hk5Z3DHbqjwKsaHOQvMtGOGhNUiFYF
        yTBdFtPkTqUmosk24YJXhqLFzb7tMWCszF5eP2kCN3r3
X-Google-Smtp-Source: APXvYqz/gq74k14Ykd9dS2kjVzsUhMEQ6wkxFNaw4f655buMEe8OfBVGwmWJZ73owAVQ1iJc5vrXwh8kxOYWyPD31uk=
X-Received: by 2002:a5d:554b:: with SMTP id g11mr1339279wrw.10.1561614176136;
 Wed, 26 Jun 2019 22:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190626235032.177551-1-emilyshaffer@google.com> <20190626235032.177551-12-emilyshaffer@google.com>
In-Reply-To: <20190626235032.177551-12-emilyshaffer@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 27 Jun 2019 01:42:45 -0400
Message-ID: <CAPig+cSJLbeVawxRhHwqLEXBr6-3QoaYd+1zF169m5N=kq4J4Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/13] walken: add filtered object walk
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 26, 2019 at 7:51 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> Demonstrate how filter specs can be used when performing a revision walk
> of all object types. In this case, tree depth is used. Contributors who
> are following the revision walking tutorial will be encouraged to run
> the revision walk with and without the filter in order to compare the
> number of objects seen in each case.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> diff --git a/builtin/walken.c b/builtin/walken.c
> @@ -143,6 +144,10 @@ static void walken_show_object(struct object *obj, const char *str, void *buf)
>  static void walken_object_walk(struct rev_info *rev)
>  {
> +       struct list_objects_filter_options filter_options = {};
> +
> +       printf("walken_object_walk beginning...\n");

Is this debugging code which you accidentally left in? Or is it meant
to use trace_printf()? Or something else? If it is a genuine message,
should it be localizable?

> @@ -157,7 +162,24 @@ static void walken_object_walk(struct rev_info *rev)
>         blob_count = 0;
>         tree_count = 0;
>
> -       traverse_commit_list(rev, walken_show_commit, walken_show_object, NULL);
> +       if (1) {
> +               /* Unfiltered: */

The subject talks about adding a _filtered_ object walk (which is in
the 'else' arm), so should this be "if (0)" instead?

> +               trace_printf(_("Unfiltered object walk.\n"));
> +               traverse_commit_list(rev, walken_show_commit,
> +                               walken_show_object, NULL);
> +       } else {
> +               trace_printf(_("Filtered object walk with filterspec "
> +                               "'tree:1'.\n"));
> +               /*
> +                * We can parse a tree depth of 1 to demonstrate the kind of
> +                * filtering that could occur during various operations (see
> +                * `git help rev-list` and read the entry on `--filter`).
> +                */
> +               parse_list_objects_filter(&filter_options, "tree:1");
> +
> +               traverse_commit_list_filtered(&filter_options, rev,
> +                       walken_show_commit, walken_show_object, NULL, NULL);
> +       }
