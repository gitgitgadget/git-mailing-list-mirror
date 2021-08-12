Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F4AC4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 20:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C399B60F35
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 20:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbhHLUbp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 16:31:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:45900 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229677AbhHLUbo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 16:31:44 -0400
Received: (qmail 24826 invoked by uid 109); 12 Aug 2021 20:31:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Aug 2021 20:31:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25383 invoked by uid 111); 12 Aug 2021 20:31:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Aug 2021 16:31:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Aug 2021 16:31:18 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v3 17/25] t/helper/test-read-midx.c: add --checksum mode
Message-ID: <YRWFFgfXnyiRKdC1@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
 <60ec8b3466e7f94610a45bdd1c79feb06e439429.1627420428.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60ec8b3466e7f94610a45bdd1c79feb06e439429.1627420428.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 27, 2021 at 05:20:07PM -0400, Taylor Blau wrote:

> Subsequent tests will want to check for the existence of a multi-pack
> bitmap which matches the multi-pack-index stored in the pack directory.
> 
> The multi-pack bitmap includes the hex checksum of the MIDX it
> corresponds to in its filename (for example,
> '$packdir/multi-pack-index-<checksum>.bitmap'). As a result, some tests
> want a way to learn what '<checksum>' is.
> 
> This helper addresses that need by printing the checksum of the
> repository's multi-pack-index.

Makes sense. It might be nice to have a generic tool for pulling hashes
out of checksum files. Perhaps even a tool that is shipped with Git for
operating on such files (for in-the-field debugging and diagnosis). But
that can definitely be separate from this series (if ever).

>  t/helper/test-read-midx.c | 16 +++++++++++++++-
>  t/lib-bitmap.sh           |  4 ++++
>  2 files changed, 19 insertions(+), 1 deletion(-)

The patch itself looks fine to me. One curiosity:

> diff --git a/t/lib-bitmap.sh b/t/lib-bitmap.sh
> index ecb5d0e05d..09cd036f4d 100644
> --- a/t/lib-bitmap.sh
> +++ b/t/lib-bitmap.sh
> @@ -260,3 +260,7 @@ have_delta () {
>  	echo $1 | git cat-file --batch-check="%(deltabase)" >actual &&
>  	test_cmp expect actual
>  }
> +
> +midx_checksum () {
> +	test-tool read-midx --checksum "${1:-.git/objects}"
> +}

This default ".git/objects" will only _usually_ be the right thing. :)
If the actual C code accepted a missing object-dir, it could use the
correct object directory discovered by setup_git_directory().

Probably not a big deal either way, though.

-Peff
