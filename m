Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEEEC4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 21:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiLNVhh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 16:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiLNVhf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 16:37:35 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C6D37FA5
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 13:37:33 -0800 (PST)
Received: (qmail 28643 invoked by uid 109); 14 Dec 2022 21:37:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Dec 2022 21:37:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23094 invoked by uid 111); 14 Dec 2022 21:37:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Dec 2022 16:37:33 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Dec 2022 16:37:32 -0500
From:   Jeff King <peff@peff.net>
To:     Peter Grayson <pete@jpgrayson.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff: fix regression with --stat and unmerged file
Message-ID: <Y5pCHAWnNUUy6TW+@coredump.intra.peff.net>
References: <20221214174150.404821-1-pete@jpgrayson.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221214174150.404821-1-pete@jpgrayson.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2022 at 12:41:51PM -0500, Peter Grayson wrote:

> A regression was introduced in
> 
> 12fc4ad89e (diff.c: use utf8_strwidth() to count display width, 2022-09-14)
> 
> that causes missing newlines after "Unmerged" entries in `git diff --cached
> --stat` output.

Oof, clearly we don't have good test coverage here. Thanks for catching
it.

> This patch adds the missing newline along with a new test to cover this
> behavior.

Both look good to me, but two quick comments:

> diff --git a/diff.c b/diff.c
> index 1054a4b732..85f035a9e8 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2801,7 +2801,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  		else if (file->is_unmerged) {
>  			strbuf_addf(&out, " %s%s%*s | %*s",
>  				    prefix, name, padding, "",
> -				    number_width, "Unmerged");
> +				    number_width, "Unmerged\n");
>  			emit_diff_symbol(options, DIFF_SYMBOL_STATS_LINE,
>  					 out.buf, out.len, 0);
>  			strbuf_reset(&out);

Looking at the offending patch, it also touches "Bin". But that one
handles its newline separately (since sometimes there is more data on
the line). So this is the only spot that needs to be fixed.

> diff --git a/t/t4046-diff-unmerged.sh b/t/t4046-diff-unmerged.sh
> index 0ae0cd3a52..ffaf69335f 100755
> --- a/t/t4046-diff-unmerged.sh
> +++ b/t/t4046-diff-unmerged.sh
> @@ -86,4 +86,14 @@ test_expect_success 'diff-files -3' '
>  	test_cmp diff-files-3.expect diff-files-3.actual
>  '
>  
> +test_expect_success 'diff --stat' '
> +	for path in $paths
> +	do
> +		echo " $path | Unmerged" || return 1
> +	done >diff-stat.expect &&
> +	echo " 0 files changed" >>diff-stat.expect &&
> +	git diff --cached --stat >diff-stat.actual &&
> +	test_cmp diff-stat.expect diff-stat.actual
> +'

The rest of this script uses diff-files, but here we're using "diff
--cached". It feels like it would be simple to use diff-files for
consistency, but strangely it errors out, complaining that the blob
can't be read.

This has to do with the setup for the test, which uses "hash-object"
without "-w", meaning our index mentions objects we don't actually have.
I'm not sure if this is the test trying to cleverly assert that we don't
look at the objects themselves, but regardless it seems weird to me that
"diff-files" wants to look at the unmerged entries but "diff --cached"
doesn't (it does seem like "diff --cached" is right here; diff-files
would produce two lines).

So there may be another bug, but if so I don't think it's a recent one.
And we are better off working around it for your regression fix, which
we'd hope to see merged quickly.

-Peff
