Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D771620966
	for <e@80x24.org>; Wed,  5 Apr 2017 18:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754410AbdDES1D (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 14:27:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:57087 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932443AbdDESZj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 14:25:39 -0400
Received: (qmail 9594 invoked by uid 109); 5 Apr 2017 18:25:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Apr 2017 18:25:35 +0000
Received: (qmail 17875 invoked by uid 111); 5 Apr 2017 18:25:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Apr 2017 14:25:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Apr 2017 14:25:33 -0400
Date:   Wed, 5 Apr 2017 14:25:33 -0400
From:   Jeff King <peff@peff.net>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6] read-cache: force_verify_index_checksum
Message-ID: <20170405182533.a5divj63zfkfejui@sigill.intra.peff.net>
References: <20170405180625.12439-1-git@jeffhostetler.com>
 <20170405180625.12439-2-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170405180625.12439-2-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 05, 2017 at 06:06:25PM +0000, git@jeffhostetler.com wrote:

> ---
>  builtin/fsck.c  |  1 +
>  cache.h         |  2 ++
>  read-cache.c    |  7 +++++++
>  t/t1450-fsck.sh | 13 +++++++++++++
>  4 files changed, 23 insertions(+)

This version is delightfully simple. Thanks for sticking with it.

> +test_expect_success 'detect corrupt index file in fsck' '
> +	cp .git/index .git/index.backup &&
> +	test_when_finished "mv .git/index.backup .git/index" &&
> +	echo zzzzzzzz >zzzzzzzz &&
> +	test_when_finished "rm zzzzzzzz" &&
> +	git add zzzzzzzz &&
> +	sed -e "s/zzzzzzzz/yyyyyyyy/" .git/index >.git/index.yyy &&
> +	rm .git/index &&
> +	mv .git/index.yyy .git/index &&
> +	test_when_finished "rm .git/index" &&
> +	test_must_fail git fsck --cache
> +'

I was surprised by the second when-finished "rm". The earlier "mv"
should be enough to restore everything. I guess you're trying to
overcome the tendency of "mv" to complain about overwriting on some
platforms.

But wouldn't that make the first when-finished "mv" potentially a
problem, if it happens before the "rm .git/index" line?

Perhaps "mv -f" would make it all simpler (ordinarily I'd suggest just
"git reset --hard", but since we're corrupting the index, it may be
better not to rely on git for the restore). So maybe just:

  cp .git/index .git/index.backup &&
  test_when_finished "mv -f .git/index.backup .git/index" &&
  ...

I think the "rm zzzzzzzz" can go, too. We don't typically worry too much
about accumulating random files in the working tree. The important thing
is that the index is restored to a sane state.

-Peff
