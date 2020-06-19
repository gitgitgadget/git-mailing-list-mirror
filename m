Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DD6C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 15:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D72920706
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 15:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404309AbgFSPvZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:51:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42955 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404027AbgFSPvT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 11:51:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id o11so2450245wrv.9
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 08:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qaZUaD+gXvig7hXWo0hDehpBnrCDhCrZAozdnD7bCb8=;
        b=pZeCGMe45kCAbQKxZoqd3Z3BZYeigDl89q2EYoCwhSbXMJmcW4zKCGRDUC3pNnWrlc
         t594/1k22/cxJ7xX2lYp9B1kukFbLpyxex+LJORWka610koDT/eHPmR6RwtvpBUef6Dk
         escVhgRDIlXQG1CBNvzzAtJCPKk7d+Pd4Pq1guOy33Re5M001sM2heUwltIzRyXTlHxM
         Ip5uMCl1DmoK3w33B7vDnheR4j7o7rPJs8qWgSa3gdcpv+5yXIJOgYXfKtwJ1reEl9Bn
         kMOaU5k2qeXZfRKxAwQu+urjJy9GHZOhy2cRpiOP6shbCY5kB9FkwlImd30/mokf4c05
         DNew==
X-Gm-Message-State: AOAM530gh0tSS3k6U5t3DAYrUhTB6M/+bfuzhpZS4bphueg5/Tp6nVzP
        QjRtZ7WwlNTT1HxQAiKa9AD3xofrjXzw7fQLmb6DeOpJ0Ks=
X-Google-Smtp-Source: ABdhPJxJ+cCeKwigUE8+i6HfcHyX421syWXBujTi86q2Awed5cnWrJpoOkIBljryoo0EppnIAt3n91XhuzuaAr7IADY=
X-Received: by 2002:adf:afc3:: with SMTP id y3mr4383599wrd.277.1592581877496;
 Fri, 19 Jun 2020 08:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200619132304.GA2540657@coredump.intra.peff.net> <20200619132546.GA2540774@coredump.intra.peff.net>
In-Reply-To: <20200619132546.GA2540774@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 19 Jun 2020 11:51:06 -0400
Message-ID: <CAPig+cRNem-S5LGX=v=1Tid64sXWBxNyWH4ffgLgF0o1yN=mtw@mail.gmail.com>
Subject: Re: [PATCH 1/3] fast-export: allow dumping the refname mapping
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 19, 2020 at 9:25 AM Jeff King <peff@peff.net> wrote:
> [...]
> Let's make it possible to dump the mapping separate from the output
> stream. This can be used by a bug reporter to modify their reproduction
> recipe without revealing the original names (see the example in the
> documentation).
> [...]
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> @@ -118,6 +120,32 @@ static int has_unshown_parent(struct commit *commit)
> +static void maybe_dump_anon(FILE *out, struct seen_set *seen,
> +                           const char *orig, const char *anon)
> +{
> +       if (!out)
> +               return;
> +       if (!check_and_mark_seen(seen, orig))
> +               fprintf(out, "%s %s\n", orig, anon);
> +}

Nit: For a function which has only a single caller in this patch and
one more caller added in 3/3, I wonder if the, um, convenience of this
function short-circuiting as the very first thing it does outweighs
the loss of clarity of having the callers make the check themselves.
That is, have the caller do this instead:

    if (anonymized_refnames_handle)
        dump_anon(anonymized_refnames_handle, ...);

> @@ -1213,6 +1249,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
> +       if (anonymized_refnames_file)
> +               anonymized_refnames_handle = xfopen(anonymized_refnames_file, "w");

For completeness, do you want to close this file at some point?

> diff --git a/t/t9351-fast-export-anonymize.sh b/t/t9351-fast-export-anonymize.sh
> @@ -46,6 +46,18 @@ test_expect_success 'stream omits tag message' '
> +test_expect_success 'refname mapping can be dumped' '
> +       git fast-export --anonymize --all \
> +               --dump-anonymized-refnames=refs.out >/dev/null &&
> +       # we make no guarantees of the exact anonymized names,
> +       # so just check that we have the right number and
> +       # that a sample line looks sane.
> +       # Note that master is not anonymized, and so not included
> +       # in the mapping.
> +       test_line_count = 6 refs.out &&

This hard-coded "6" seems rather fragile, causing the test to break if
other refs are ever added or removed. Perhaps just count the refs
dynamically?

    git show-ref >refs &&
    nrefs=$(wc -l refs) &&
    # Note that master is not anonymized, and so not included
    # in the mapping.
    nrefs=$((nrefs - 1))
    test_line_count = $nrefs refs.out &&

and then drop the 'nrefs=$((nrefs - 1))' line and associated comment
in patch 2/3 which removes the "master" special case.

> +       grep "^refs/heads/other refs/heads/" refs.out
> +'
