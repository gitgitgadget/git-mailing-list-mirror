Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3320920C32
	for <e@80x24.org>; Thu,  7 Dec 2017 01:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbdLGBEY (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 20:04:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:50464 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751718AbdLGBEX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 20:04:23 -0500
Received: (qmail 3389 invoked by uid 109); 7 Dec 2017 01:04:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Dec 2017 01:04:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16845 invoked by uid 111); 7 Dec 2017 01:04:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 06 Dec 2017 20:04:44 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Dec 2017 20:04:21 -0500
Date:   Wed, 6 Dec 2017 20:04:21 -0500
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] diff: add test showing regression to --relative
Message-ID: <20171207010421.GC1975@sigill.intra.peff.net>
References: <20171207003517.11729-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171207003517.11729-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 06, 2017 at 04:35:17PM -0800, Jacob Keller wrote:

> Subject: [PATCH] diff: add test showing regression to --relative

Since we'd hopefully not ever merge that regression, I think this patch
ought to stand on its own. In which case it probably wants to say
something like:

  diff: test --relative without a prefix

  We already test "diff --relative=subdir", but not that
  "--relative" by itself should use the current directory as
  its prefix.

> diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
> index 3950f5034d31..41e4f59b2ffb 100755
> --- a/t/t4045-diff-relative.sh
> +++ b/t/t4045-diff-relative.sh
> @@ -70,4 +70,9 @@ for type in diff numstat stat raw; do
>  	check_$type dir/file2 --relative=sub
>  done
>  
> +cd subdir
> +for type in diff numstat stat raw; do
> +	check_$type file2 --relative
> +done

We should avoid moving the cwd of the whole test script in
case we add tests later. Normally we'd do the cd inside a
subshell, but that's complicated by the wrapper (we wouldn't
want to increment the test counter just inside the subshell,
for instance).

Adding "cd .." is the smallest thing we could do to fix
that. But I think the more robust solution is to actually
teach the check_* helper about doing the "cd" inside the
test_expect block. Or just pushing the helper down into the
test block and living with repeating the
"test_expect_success" parts for each call.

-Peff
