Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95F2E1FF40
	for <e@80x24.org>; Mon,  5 Dec 2016 06:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751261AbcLEGz0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 01:55:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:51563 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751127AbcLEGz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 01:55:26 -0500
Received: (qmail 30914 invoked by uid 109); 5 Dec 2016 06:55:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Dec 2016 06:55:24 +0000
Received: (qmail 2131 invoked by uid 111); 5 Dec 2016 06:56:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Dec 2016 01:56:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Dec 2016 01:55:23 -0500
Date:   Mon, 5 Dec 2016 01:55:23 -0500
From:   Jeff King <peff@peff.net>
To:     Jack Bates <bk874k@nottheoilrig.com>
Cc:     git@vger.kernel.org, Jack Bates <jack@nottheoilrig.com>
Subject: Re: [PATCH] diff: fix up SHA-1 abbreviations outside of repository
Message-ID: <20161205065523.yspqt34p3dp5g5fk@sigill.intra.peff.net>
References: <20161204194747.7100-1-jack@nottheoilrig.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161204194747.7100-1-jack@nottheoilrig.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 04, 2016 at 12:47:47PM -0700, Jack Bates wrote:

> The three cases where "git diff" operates outside of a repository are 1)
> when we run it outside of a repository, 2) when one of the files we're
> comparing is outside of the repository we're in, and 3) the --no-index
> option. Commit 4f03666 ("diff: handle sha1 abbreviations outside of
> repository", 2016-10-20) only worked in the first case.

You didn't define "worked" here. From looking at your patch, it looks
like we look look in the object database for abbreviations in the
--no-index case, but you think we shouldn't.

I'm not sure I agree. The "--no-index" option asks git not to treat the
arguments as pathspecs, but instead as two filesystem files to diff.
But should it ignore the repository entirely? One use case is to just
ask for the diff of two files:

  git diff --no-index foo bar

which may or may not be tracked in the repository. For abbreviations, I
doubt that people would care much, but see below.

> diff --git a/builtin/diff.c b/builtin/diff.c
> index 7f91f6d..ec7c432 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -342,9 +342,11 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  		       "--no-index" : "[--no-index]");
>  
>  	}
> -	if (no_index)
> +	if (no_index) {
>  		/* If this is a no-index diff, just run it and exit there. */
> +		startup_info->have_repository = 0;
>  		diff_no_index(&rev, argc, argv);
> +	}

This reset of have_repository would affect more than just abbreviations.
We may also look at the repository for attributes, config, etc.  For
instance, right now:

  echo "*.pdf diff=pdf" >.git/info/attributes
  git config diff.pdf.textconv pdftotext
  git diff --no-index --textconv foo.pdf bar.pdf

will show a text diff of the two files, but wouldn't after your patch.

(I actually think even needing to say --textconv is actually a bug;
normally the diff porcelain defaults to --textconv, but that setup is
skipped in the no-index case).

> +To check that we don'\''t, create an blob with a SHA-1 that starts with
> +0000. (Outside of a repository, SHA-1s are all zeros.) Then make an
> +abbreviation and check that Git doesn'\''t lengthen it.

That's not always true. If we actually diff the file contents, the sha1s
are correct (which you can see in the default --patch output). It's only
in the --raw case that the sha1 is all zeroes.

I'm not 100% sure that isn't a bug.  In a normal git diff, we can show
the sha1s without actually looking at the file content, because we get
them from either the containing tree or the index. In a --no-index diff,
we create the diff_filespec structs without a valid sha1. But we can't
get away from reading the files eventually. The magic happens in
diffcore_skip_stat_unmatch(), which actually does a series of checks,
culminating in a size-check and then a comparison of the contents.

I suppose it _is_ faster than computing the actual sha1, because we can
sometimes show "modified" by only looking at the size, or the first few
bytes. But any time two files are identical, we pay the full cost. So if
you're comparing two hierarchies, say, like:

  git diff --raw one/ two/

it's probably not much more expensive to compare with the full sha1s,
because we're already reading the entire contents of every file that's
the same.

So I dunno. It kind of surprised me that anybody was using "--no-index
--raw" in the first place, so maybe there is some use case I'm missing.

-Peff
