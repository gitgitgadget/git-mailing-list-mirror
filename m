Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B3AC1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 16:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032812AbeBNQqc (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 11:46:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:52142 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1032526AbeBNQqb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 11:46:31 -0500
Received: (qmail 25112 invoked by uid 109); 14 Feb 2018 16:46:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Feb 2018 16:46:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30148 invoked by uid 111); 14 Feb 2018 16:47:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 14 Feb 2018 11:47:15 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Feb 2018 11:46:29 -0500
Date:   Wed, 14 Feb 2018 11:46:29 -0500
From:   Jeff King <peff@peff.net>
To:     Code AI <techsupport@mycode.ai>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] CodeAI fixes 1 Allocator sizeof() operand mismatch, 2
 Null Pointer Dereference, and 2 Dead Code
Message-ID: <20180214164628.GA907@sigill.intra.peff.net>
References: <CAGm8dMApDdLEzeKU-h16G0NSpnuk9LMTWA29t4MxO1qcNpUvhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGm8dMApDdLEzeKU-h16G0NSpnuk9LMTWA29t4MxO1qcNpUvhA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 14, 2018 at 10:50:12AM -0500, Code AI wrote:

> Hi my name is Benjamin Bales.
> 
> I am the founder and creator of CodeAI,
> the first non-human contributor to your software project. CodeAI finds
> and fixes security defects for you. It fixed 18. It wants to merge 5
> commits - 1 Allocator sizeof() operand mismatch, 2 Null Pointer
> Dereference issues and 2 Dead Code issues in git. To view all 18 fixed
> issues from the run claim your free open source account at mycode.ai
> and the Dockerfile used to build and run your project in CodeAI, here-
> https://drive.google.com/open?id=12d2poeHabdc0DSShDcekSU5bI0Il6Qv- .
> It is always free for open source projects.
> 
> If you have any questions about these results or have general
> inquiries about CodeAI, please send an email to techsupport@mycode.ai

Too bad the AI cannot follow SubmittingPatches. :)

We've often seen the results of static analyzers on the list. In general
we welcome fixes from static analyzers, and even fixes to silence false
positives from static analyzers if they're not too onerous (and if they
get the analyzer to a point where it generates only useful results).

But we prefer to see some analysis done on the call-sites to determine
if they are actual problems, and if the fix is appropriate.

Let's look at these ones.

> Allocator sizeof() mismatch:
> diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
> index 1145d51..c3ea5c1 100644
> --- a/t/helper/test-hashmap.c
> +++ b/t/helper/test-hashmap.c
> @@ -86,7 +86,7 @@ static void perf_hashmap(unsigned int method,
> unsigned int rounds)
>         unsigned int i, j;
> 
>         entries = malloc(TEST_SIZE * sizeof(struct test_entry *));
> -       hashes = malloc(TEST_SIZE * sizeof(int));
> +       hashes = malloc(TEST_SIZE * sizeof(unsigned));

I agree this ought to be "unsigned", though I don't know if there is any
platform in practice where the sizes of "int" and "unsigned int" differ.
However, an even better solution is "sizeof(*hashes)", which eliminates
the need to keep it in sync. Or even ALLOC_ARRAY(hashes), which does
this for us.

> Null dereference fixes:
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 4c51aec..f26858a 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1604,7 +1604,7 @@ static void show_pack_info(int stat_only)
>                              "non delta: %d objects",
>                              baseobjects),
>                           baseobjects);
> -       for (i = 0; i < deepest_delta; i++) {
> +       for (i = 0; chain_histogram && (i < deepest_delta); i++) {
>                 if (!chain_histogram[i])
>                         continue;
>                 printf_ln(Q_("chain length = %d: %lu object",

This one looks like a false positive. At the beginning of the function,
we allocate chain_histogram if deepest_delta is non-zero. And if it's
zero, we'll never enter this loop.

Curiously, the tool did not flag the reference to chain_histogram in the
earlier loop. Which is also correct, but in a much less obvious way. It
does:

  if (is_delta_type(obj->type))
          chain_histogram[obj_stat[i].delta_depth - 1]++;

So there the assumption is that if we saw any delta types, we would
previously have incremented deepest_delta to be non-zero. Which I think
holds, but seems way less likely for a static analysis tool to have
realized.

> diff --git a/unpack-trees.c b/unpack-trees.c
> index 96c3327..fcd9332 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1721,7 +1721,7 @@ static int verify_absent(const struct cache_entry *ce,
>                          enum unpack_trees_error_types error_type,
>                          struct unpack_trees_options *o)
>  {
> -       if (!o->skip_sparse_checkout && (ce->ce_flags & CE_NEW_SKIP_WORKTREE))
> +       if (ce && (!o->skip_sparse_checkout && (ce->ce_flags &
> CE_NEW_SKIP_WORKTREE)))
>                 return 0;
>         return verify_absent_1(ce, error_type, o);
>  }

This one is hard to evaluate. It seems to suggest that somebody could
pass a NULL ce to verify_absent(). But without knowing how the tool came
to that conclusion, it's hard to know if that's true of any callsites
(though just grepping the callers, most seem to otherwise dereference
"ce").

If there is such a callsite, though, this patch isn't sufficient. We'd
pass the NULL down to verify_absent_1(), which may dereference it, too
Though it returns early in some cases, so it's _possible_ that the one
code path that passes a NULL never sets those flags (again, hard to tell
without the tool reporting which execution path it found with the NULL).
I'd argue that it's still the wrong fix, though, as the result would be
very brittle.

> Dead code fixes:
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -235,7 +235,6 @@ static int edit_patch(int argc, const char **argv,
> const char *prefix)
>         init_revisions(&rev, prefix);
>         rev.diffopt.context = 7;
> 
> -       argc = setup_revisions(argc, argv, &rev, NULL);
>         rev.diffopt.output_format = DIFF_FORMAT_PATCH;
>         rev.diffopt.use_color = 0;
>         rev.diffopt.flags.ignore_dirty_submodules = 1;

This is a classic with a twist.  The dead assignments to argc are common
to many static analysis tools, but usually they suggest:

   -       argc = setup_revisions(argc, argv, &rev, NULL);
   +       setup_revisions(argc, argv, &rev, NULL);

As I've argued before for these cases, the assignment is important to
retain from a maintenance perspective. Since otherwise you leave "argc"
with a bogus value, which is a trap for somebody who later adds code to
look at it (which may not even be near this setup_revisions call, but
much later in the function).

The twist here is that the tool suggests removing the setup_revision()
call entirely. Which seems like it cannot possibly be correct. It's
setting up values in "rev" based on the incoming arguments.

> diff --git a/fsck.c b/fsck.c
> index 032699e..78563c3 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -704,7 +704,6 @@ static int fsck_ident(const char **ident, struct
> object *obj, struct fsck_option
>             !isdigit(p[4]) ||
>             (p[5] != '\n'))
>                 return report(options, obj, FSCK_MSG_BAD_TIMEZONE,
> "invalid author/committer line - bad time zone");
> -       p += 6;
>         return 0;
>  }

Another classic. And similar to the case above, I think this should
remain for maintainability. Even though we do not currently parse
further into the buffer, it would be a surprise for anybody adding code
after this is "p" had not been updated.

Though I could accept that we're very unlikely to add code here, and
that it would go _directly_ after the missing increment of "p", so the
writer of the new code is likely to notice.

-Peff
