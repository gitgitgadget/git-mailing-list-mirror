Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F63C433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 077B32078C
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732985AbgFWRQU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:16:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45512 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732565AbgFWRQT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 13:16:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id s10so1412425wrw.12
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pk3AX4lfXG8VZMHBrglMYAFGVHUqO+ocP7g5dmrYzV8=;
        b=huEU1HW2XGU2MtnTuex2LfXfHr+Y+OHn+Y2NGU0QJGq5cG6B/GsoN1iCi4IJYXnRQr
         Yv1sv/Zrds12gyWkwga0wBZ0ldJxHCkdf/hwGOhS9A5vzt44MNngOX0rXpWbsFtSNmzs
         +iMOm3l2XI+QdqfjxNYTmcSk5oF+rW/+VjIybrHV0cPgygCzMk/SmLfC2y1yP1v3vdtU
         G1b/D7gHJE9PnwOdEMwUREdaEgxQ1dYArBNV7xDNQWo4HoE7kW5pJ6CmnaA/H4ruCKXu
         25pYfCrqNMbBIWJG7Fod+qNt+czWw2mhAhXx3WVz8VODr76Q1pvUAq3Y+n88gMsjZuhQ
         QaPg==
X-Gm-Message-State: AOAM5333LIptOmzV7PPzxRs38imP+CbyoAMaFCAiMeVlDJfyCieWXrqR
        FyuKQkRvFV/yjkieshVKiXUVHWMbXMKRjJd6Q4I=
X-Google-Smtp-Source: ABdhPJxa3ixYZ2C+YHAByCVgcruAAJZ/lQHJl1qruPPlggd0e7Cf/LAhEWBkCQiEzT6v8WcPYv7ZfHEZzvXb1tAgNw0=
X-Received: by 2002:adf:afc3:: with SMTP id y3mr27012950wrd.277.1592932576727;
 Tue, 23 Jun 2020 10:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200623152436.GA50925@coredump.intra.peff.net> <20200623152505.GI1435482@coredump.intra.peff.net>
In-Reply-To: <20200623152505.GI1435482@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 23 Jun 2020 13:16:05 -0400
Message-ID: <CAPig+cTMu3SW5UE59Eva=jh-07hOT8Dz5A5trWyEugKd_2HaKg@mail.gmail.com>
Subject: Re: [PATCH 09/10] fast-export: allow seeding the anonymized mapping
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 23, 2020 at 11:25 AM Jeff King <peff@peff.net> wrote:
> diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
> @@ -238,6 +243,25 @@ collapse "User 0", "User 1", etc into "User X"). This produces a much
> +[...] For example, if you have a bug which reproduces
> +with `git rev-list mybranch -- foo.c`, you can run:
> +
> +---------------------------------------------------
> +$ git fast-export --anonymize --all \
> +   --seed-anonymized=foo.c:secret.c \
> +   --seed-anonymized=mybranch \
> +   >stream
> +---------------------------------------------------
> +
> +After importing the stream, you can then run `git rev-list mybranch --
> +secret.c` in the anonymized repository.

I understand that your intention here is to demonstrate both forms of
--seed-anonymized, but I'm slightly concerned that people may
interpret this example as meaning that you are not allowed to
anonymize the refname when anonymizing a pathname. It might be less
ambiguous to avoid the "short form" in the example; people who have
read the description of --seed-anonymized will know that the short
form can be used without having to see it in an example.

> +Note that paths and refnames are split into tokens at slash boundaries.
> +The command above would anonymize `subdir/foo.c` as something like
> +`path123/secret.c`.

Confusing. This seems to be saying that anonymizing filenames in
subdirectories is pointless because you can't know how the leading
directory names will be anonymized. That leaves the reader wondering
how to deal with the situation. Does it require using
--seed-anonymized for each path component leading up to the filename?
Or can --seed-anonymized take an full pathname (leading directory
components and filename) in one shot?

> @@ -168,8 +169,18 @@ static const char *anonymize_str(struct hashmap *map,
> -    ret = hashmap_get_entry(map, &key, hash, &key);
>
> +    /* First check if it's a token the user configured manually... */
> +    if (anonymized_seeds.cmpfn)
> +        ret = hashmap_get_entry(&anonymized_seeds, &key, hash, &key);
> +    else
> +        ret = NULL;
> +
> +    /* ...otherwise check if we've already seen it in this context... */
> +    if (!ret)
> +        ret = hashmap_get_entry(map, &key, hash, &key);
> +
> +    /* ...and finally generate a new mapping if necessary */

I was a bit surprised to see that --seed-anonymized values are stored
in a separate hash map rather than simply being used to (literally)
seed the existing anonymization hash map. I guess there's a good
technical reason for doing it this way, such as the normal
anonymization hash map not yet being in existence at the time the
--seed-anonymized option is processed? (I haven't checked because I'm
too lazy, so it may not be worth spending time answering me.)

> @@ -1188,6 +1230,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
>         OPT_BOOL(0, "anonymize", &anonymize, N_("anonymize output")),
> +        OPT_CALLBACK_F(0, "seed-anonymized", &anonymized_seeds, N_("from:to"),
> +               N_("convert <from> to <to> in anonymized output"),
> +               PARSE_OPT_NONEG, parse_opt_seed_anonymized),

Would it be worthwhile to add a check somewhere after the
parse_options() invocation and complain if --seed-anonymized was used
without --anonymize?  (Or should --seed-anonymized perhaps imply
--anonymize?)
