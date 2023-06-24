Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CFAEB64DA
	for <git@archiver.kernel.org>; Sat, 24 Jun 2023 04:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjFXEib (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jun 2023 00:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFXEia (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2023 00:38:30 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5051988
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 21:38:27 -0700 (PDT)
Received: (qmail 27695 invoked by uid 109); 24 Jun 2023 04:38:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 24 Jun 2023 04:38:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11439 invoked by uid 111); 24 Jun 2023 04:38:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 24 Jun 2023 00:38:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 24 Jun 2023 00:38:26 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7701: make annotated tag unreachable
Message-ID: <20230624043826.GA104835@coredump.intra.peff.net>
References: <48d3c2c1871c8122d22fbce7c256ca65582fcd67.1687342818.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48d3c2c1871c8122d22fbce7c256ca65582fcd67.1687342818.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2023 at 06:21:10AM -0400, Taylor Blau wrote:

> But after pruning, that object is kept around for two reasons. One, the
> tag object's mtime wasn't adjusted to be beyond the 1-hour cutoff, so it
> would be kept as due to its recency regardless. The other reason is
> because the tag itself is reachable.
> 
> Use mktag to write the tag object directly without pointing a reference
> at it, and adjust the mtime of the tag object to be older than the
> cutoff to ensure that our `gc.recentObjectsHook` configuration is
> working as intended.

Thanks, this should fix the problem (which you can notice by making the
recentObjectsHook in the test a noop and seeing that it still passes).

But there's one more thing...

> diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
> index ba428c18a8..ceb4e805d2 100755
> --- a/t/t7701-repack-unpack-unreachable.sh
> +++ b/t/t7701-repack-unpack-unreachable.sh
> @@ -126,8 +126,19 @@ test_expect_success 'gc.recentObjectsHook' '
>  	git cat-file -p $obj2 &&
>  	git cat-file -p $obj3 &&
> 
> +	# make an unreachable annotated tag object to ensure we rescue objects
> +	# which are reachable from non-pruned unreachable objects
>  	git tag -a -m tag obj2-tag $obj2 &&
> -	obj2_tag="$(git rev-parse obj2-tag)" &&
> +	obj2_tag="$(git mktag <<-EOF
> +	object $obj2
> +	type blob
> +	tag obj2-tag
> +	tagger T A Gger <tagger@example.com> 1234567890 -0000
> +	EOF
> +	)" &&

Since we are using "mktag" here, the call to "git tag" can go away
entirely. It's not only redundant, but it erroneously keeps reachability
to $obj2. The test still does something useful (it makes sure that
$obj2_tag was saved), but it is failing to test what it wanted to about
$obj2, namely that it is kept because the hook mentioned an object that
points to it.

So we'd want to squash in:

diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index ceb4e805d2..fe6c3e77a3 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -128,7 +128,6 @@ test_expect_success 'gc.recentObjectsHook' '
 
 	# make an unreachable annotated tag object to ensure we rescue objects
 	# which are reachable from non-pruned unreachable objects
-	git tag -a -m tag obj2-tag $obj2 &&
 	obj2_tag="$(git mktag <<-EOF
 	object $obj2
 	type blob

-Peff
