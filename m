Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 047161F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 06:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeKKQlW (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 11:41:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:47640 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727307AbeKKQlW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 11:41:22 -0500
Received: (qmail 338 invoked by uid 109); 11 Nov 2018 06:53:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 11 Nov 2018 06:53:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31859 invoked by uid 111); 11 Nov 2018 06:52:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 11 Nov 2018 01:52:59 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2018 01:53:38 -0500
Date:   Sun, 11 Nov 2018 01:53:38 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, larsxschneider@gmail.com,
        sandals@crustytoothpaste.net, me@ttaylorr.com, jrnieder@gmail.com
Subject: Re: [PATCH 06/10] fast-export: when using paths, avoid corrupt
 stream with non-existent mark
Message-ID: <20181111065338.GF30850@sigill.intra.peff.net>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
 <20181111062312.16342-7-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181111062312.16342-7-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 10, 2018 at 10:23:08PM -0800, Elijah Newren wrote:

> If file paths are specified to fast-export and multiple refs point to a
> commit that does not touch any of the relevant file paths, then
> fast-export can hit problems.  fast-export has a list of additional refs
> that it needs to explicitly set after exporting all blobs and commits,
> and when it tries to get_object_mark() on the relevant commit, it can
> get a mark of 0, i.e. "not found", because the commit in question did
> not touch the relevant paths and thus was not exported.  Trying to
> import a stream with a mark corresponding to an unexported object will
> cause fast-import to crash.
> 
> Avoid this problem by taking the commit the ref points to and finding an
> ancestor of it that was exported, and make the ref point to that commit
> instead.

As with the earlier tag commit, I wonder if this might depend on the
context in which you're using fast-export. I suppose that if you did not
feed the ref on the command line that we would not be dealing with it at
all (and maybe that is the answer to my question about the tag thing,
too).

It does seem funny that the behavior for the earlier case (bounded
commits) and this case (skipping some commits) are different. Would you
ever want to keep walking backwards to find an ancestor in the earlier
case? Or vice versa, would you ever want to simply delete a tag in a
case like this one?

I'm not sure sure, but I suspect you may have thought about it a lot
harder than I have. :)

> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index a3c044b0af..5648a8ce9c 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -900,7 +900,18 @@ static void handle_tags_and_duplicates(void)
>  			if (anonymize)
>  				name = anonymize_refname(name);
>  			/* create refs pointing to already seen commits */
> -			commit = (struct commit *)object;
> +			commit = rewrite_commit((struct commit *)object);
> +			if (!commit) {
> +				/*
> +				 * Neither this object nor any of its
> +				 * ancestors touch any relevant paths, so
> +				 * it has been filtered to nothing.  Delete
> +				 * it.
> +				 */
> +				printf("reset %s\nfrom %s\n\n",
> +				       name, sha1_to_hex(null_sha1));
> +				continue;
> +			}

This hunk makes sense.

> --- a/t/t9350-fast-export.sh
> +++ b/t/t9350-fast-export.sh
> @@ -386,6 +386,30 @@ test_expect_success 'path limiting with import-marks does not lose unmodified fi
>  	grep file0 actual
>  '
>  
> +test_expect_success 'avoid corrupt stream with non-existent mark' '
> +	test_create_repo avoid_non_existent_mark &&
> +	(
> +		cd avoid_non_existent_mark &&
> +
> +		touch important-path &&
> +		git add important-path &&
> +		test_commit initial &&
> +
> +		touch ignored &&
> +		git add ignored &&
> +		test_commit whatever &&
> +
> +		git branch A &&
> +		git branch B &&
> +
> +		echo foo >>important-path &&
> +		git add important-path &&
> +		test_commit more changes &&
> +
> +		git fast-export --all -- important-path | git fast-import --force
> +	)
> +'

Similar comments apply about "touch" and "test_commit" to what I wrote
for the earlier patch.

-Peff
