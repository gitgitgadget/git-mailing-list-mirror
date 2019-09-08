Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A9611F461
	for <e@80x24.org>; Sun,  8 Sep 2019 10:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfIHKFp (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Sep 2019 06:05:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:43302 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727018AbfIHKFp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Sep 2019 06:05:45 -0400
Received: (qmail 17330 invoked by uid 109); 8 Sep 2019 10:05:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 08 Sep 2019 10:05:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32755 invoked by uid 111); 8 Sep 2019 10:07:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 08 Sep 2019 06:07:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 8 Sep 2019 06:05:44 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Freese <ericdfreese@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] for-each-ref: add '--no-symbolic' option
Message-ID: <20190908100543.GB15641@sigill.intra.peff.net>
References: <20190907213646.21231-1-ericdfreese@gmail.com>
 <20190907213646.21231-2-ericdfreese@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190907213646.21231-2-ericdfreese@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 07, 2019 at 03:36:46PM -0600, Eric Freese wrote:

> Using the new flag will omit symbolic refs from the output.
> 
> Without this flag, it is possible to get this behavior by using the
> `%(symref)` formatting field name and piping output through grep to
> include only those refs that do not output a value for `%(symref)`, but
> having this flag is more elegant and intention revealing.

This seems like a reasonable addition to me. As you note, it can be done
by post-processing the result, but it can get a little clumsy.

Just letting my mind wander for a moment, a more general solution would
be providing some mechanism by which you could ask for-each-ref to omit
results based on their expansions. E.g., you might want to ask for only
refs for which %(taggerdate) is non-empty (i.e., just the annotated
tags).

But that opens a can of worms. How do we negate it? You want to omit
non-empty %(symref) here, but my tag example would only show non-empty
%(taggerdate). Howe do we combine options ("non-symrefs that point to
commits")? How do we express more complex logic, like string matching or
numeric comparison?

It's a slippery slope that ends in embedding a Turing complete language. :)
And you can already do these complex things in the language of your
choice by post-processing the output. The one advantage to doing it
inside for-each-ref is that we may save some work by filtering early.
This probably matters more for other tools like cat-file (where I might
want to say "print all the blobs", but I can't do so without a
multi-process pipeline that accesses each object twice), but we'd
eventually like to unify the formatting languages of all tools.

So in my mind there's an endgame we'd like to eventually reach where
the option added by your patch isn't needed anymore. But we're a long
way from that. And it's not entirely clear where we'd draw the line
anyway. So in the meantime, this seems like a useful thing, and it
wouldn't be a burden to carry it even if we eventually added
"--omit=%(symref)" or something.

> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 6dcd39f6f6..be19111510 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -95,6 +95,9 @@ OPTIONS
>  --ignore-case::
>  	Sorting and filtering refs are case insensitive.
>  
> +--no-symbolic::
> +	Only list refs that are not symbolic.
> +

I wonder if "symbolic" might be too vague here. Would "--no-symref" be a
better name?

I responded separately to Taylor's questions about negation, but one
thing I didn't bring up there: another option to avoid it is to specify
the action positively. E.g., "--ignore-symrefs" or similar. I could go
either way on that.

> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 465153e853..b71ab2f135 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -18,7 +18,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>  {
>  	int i;
>  	struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
> -	int maxcount = 0, icase = 0;
> +	int maxcount = 0, icase = 0, nosym = 0;

Likewise, maybe worth writing out "symref" here (and in the struct
option)? But...

> @@ -46,6 +46,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>  		OPT_CONTAINS(&filter.with_commit, N_("print only refs which contain the commit")),
>  		OPT_NO_CONTAINS(&filter.no_commit, N_("print only refs which don't contain the commit")),
>  		OPT_BOOL(0, "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
> +		OPT_BOOL(0, "no-symbolic", &nosym, N_("exclude symbolic refs")),

I think you could just write directly to &filter.no_symbolic here,
dropping nosym entirely. But I guess ignore-case directly above set a
bad example. ;)

> diff --git a/ref-filter.c b/ref-filter.c
> index f27cfc8c3e..01beb279dc 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2093,6 +2093,10 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
>  		return 0;
>  	}
>  
> +	if (filter->no_symbolic && flag & REF_ISSYMREF) {
> +		return 0;
> +	}
> +

Ooh, here we avoid the double negation of "if (!filter->no_symbolic)"
with an early return. :) (Nothing wrong with that, just an amusing
outcome given the discussion elsewhere in the thread).

> [...]

The rest of the patch looked OK, aside from other review comments. The
whole thing looks cleanly done. I don't have a strong opinion on adding
the feature to branch/tag. We've only ever promised that HEAD and
refs/remotes/.../HEAD work as symrefs, though of course they do work
anywhere in the namespace, and I imagine people have taken advantage of
that. So I don't know how useful the option would be in other contexts.

-Peff
