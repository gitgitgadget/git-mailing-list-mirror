Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22660C433E0
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 16:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2F52221F1
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 16:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbhAQQ4W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 11:56:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:58528 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729569AbhAQQ4W (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 11:56:22 -0500
Received: (qmail 21380 invoked by uid 109); 17 Jan 2021 16:55:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 17 Jan 2021 16:55:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16179 invoked by uid 111); 17 Jan 2021 16:55:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 17 Jan 2021 11:55:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 17 Jan 2021 11:55:38 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 02/11] cache-tree tests: use a sub-shell with less
 indirection
Message-ID: <YARsCsgXuiXr4uFX@coredump.intra.peff.net>
References: <20210114233515.31298-1-avarab@gmail.com>
 <20210116153554.12604-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210116153554.12604-3-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 16, 2021 at 04:35:45PM +0100, Ævar Arnfjörð Bjarmason wrote:

> diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
> index 354b7f15f7..2e3efeb80e 100755
> --- a/t/t0090-cache-tree.sh
> +++ b/t/t0090-cache-tree.sh
> @@ -27,20 +27,15 @@ generate_expected_cache_tree_rec () {
>  	printf "SHA $dir (%d entries, %d subtrees)\n" "$entries" "$subtree_count" &&
>  	for subtree in $subtrees
>  	do
> -		cd "$subtree"
> -		generate_expected_cache_tree_rec "$dir$subtree" || return 1
> -		cd ..
> +		(
> +			cd "$subtree"
> +			generate_expected_cache_tree_rec "$dir$subtree" || return 1
> +		)
>  	done

We don't check that "cd" worked either before or after your patch.
Should we?

After your patch, we "return" from inside a subshell. Is that portable?
ISTR issues around that before, but it just have been when we are not in
a function at all. Still, I wonder if:

  for ...
  do
	(
		cd "$subtree" &&
		generate_expected_cache_tree_rec "$dir$subtree"
	) || return 1
  done

might be more obvious.

> -generate_expected_cache_tree () {
> -	(
> -		generate_expected_cache_tree_rec
> -	)
> -}

I wondered what the "rec" was for, but I guess it is "recurse". Not a
problem to keep it, but I wonder if it could be dropped in the name of
shortness/simplicity (not worth a re-roll for sure, but maybe worth
doing so if you re-roll for the above issues).

-Peff
