Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 057AE1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 05:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfF0FGq (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 01:06:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51171 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0FGq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 01:06:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id c66so4286277wmf.0
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 22:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ir6iILWHn9tdEXa20xivVLal1OGkqG+DTB66LqCa00w=;
        b=rkLwEyu+uBqtMKMeluVeAOJ5a6h/cxlJM7Tl2vBjxV+bEqlPIoj+/a8mB/pQZ3l+ED
         qn6pCuuF8pIMCazQF1UmYBjIHZeQTHaLDKrJ6w3aFrYVGxQ9Ge9b7ivGjqs/7QqJOqbf
         XVT7KSVxH6nMsm9D1YGwhCBKBhRl65mFwx+9a7t9kLrZzPvsWPImv5M4T6xLCd7aRs/k
         Hx5d5mSQ6RxbD5GxhtSYxE/z7bWG3Uf9eKZ+fR4tgtrAybxaGNbLbrRFMcNpOCmdq1iS
         VLZFO5rr3dAVl+D0uZSIn7u7nV2LPtIENKezJT1Px1acniKqcA234ZqKbKDqMq8S3t1f
         mgyA==
X-Gm-Message-State: APjAAAXfiSWN9i2j3KaCTDM21Qbx1xPAPOBZilcKgpSI3KaA9SyVLIgd
        ewZvhZKNuI9Lhk9MLl398+4Drdjolo3WCVN1WgI=
X-Google-Smtp-Source: APXvYqxIGE8RMibYn1hRFjjUfNSAs2EcCkFOzACeOX9trmrXwt5ej8NbBgvkQE5AOjuNg6souZ/b9niixU3DWr7aDfg=
X-Received: by 2002:a1c:7e85:: with SMTP id z127mr1608896wmc.95.1561612003595;
 Wed, 26 Jun 2019 22:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190626235032.177551-1-emilyshaffer@google.com> <20190626235032.177551-6-emilyshaffer@google.com>
In-Reply-To: <20190626235032.177551-6-emilyshaffer@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 27 Jun 2019 01:06:32 -0400
Message-ID: <CAPig+cRduaOcVyrvhXc2moKSUsZa7-7HLh197xYT035HTQp61w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 05/13] walken: configure rev_info and prepare for walk
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 26, 2019 at 7:51 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> `struct rev_info` is what's used by the struct itself.

What "struct itself"? Do you mean 'struct rev_info' is used by the
_walk_ itself? Or something?

> `repo_init_revisions()` initializes the struct; then we need to set it
> up for the walk we want to perform, which is done in
> `final_rev_info_setup()`.
> [...]
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> diff --git a/builtin/walken.c b/builtin/walken.c
> @@ -30,6 +31,40 @@ static void init_walken_defaults(void)
> +/*
> + * cmd_log calls a second set of init after the repo_init_revisions call. We'll
> + * mirror those settings in post_repo_init_init.
> + */

What is 'post_repo_init_init'?

I found the reference to cmd_log() confusing because I was looking for
it in this patch (as if it was being introduced here). Newcomers might
be even more confused. Perhaps if you state explicitly that you're
referring to existing code in an existing file, it might be clearer.
Maybe:

    builtin/log.c:cmd_log() calls a second ...

Overall, I find this entire function comment mystifying.

> +static void final_rev_info_setup(int argc, const char **argv, const char *prefix,
> +               struct rev_info *rev)
> +{
> +       /*
> +        * Optional:
> +        * setup_revision_opt is used to pass options to the setup_revisions()
> +        * call. It's got some special items for submodules and other types of
> +        * optimizations, but for now, we'll just point it to HEAD and call it
> +        * good. First we should make sure to reset it. This is useful for more
> +        * complicated stuff but a decent shortcut for the first pass is
> +        * add_head_to_pending().
> +        */

I had to pause over "call it good" for several seconds (since I
couldn't understand why someone would want to write "bad" code) until
I figured out you meant "do nothing else". It would be clearer simply
to drop that, ending the sentence at "HEAD":

    ..., but for now, we'll just point it at HEAD.

> +       /*
> +        * struct setup_revision_opt opt;
> +
> +        * memset(&opt, 0, sizeof(opt));
> +        * opt.def = "HEAD";
> +        * opt.revarg_opt = REVARG_COMMITTISH;
> +        * setup_revisions(argc, argv, rev, &opt);
> +        */
> +
> +       /* Let's force oneline format. */
> +       get_commit_format("oneline", rev);
> +       rev->verbose_header = 1;
> +
> +       /* add the HEAD to pending so we can start */
> +       add_head_to_pending(rev);
> +}

It would be easier for the reader to associate the
add_head_to_pending() invocation with the commented-out setting of
"HEAD" via 'setup_revision_opt' if the two bits abutted one another
without being separated by the "oneline" gunk.
