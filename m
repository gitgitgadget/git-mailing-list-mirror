Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED54F1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 19:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754699AbcHXTBO (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 15:01:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:60687 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753762AbcHXTBN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 15:01:13 -0400
Received: (qmail 18157 invoked by uid 109); 24 Aug 2016 18:54:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 18:54:31 +0000
Received: (qmail 6090 invoked by uid 111); 24 Aug 2016 18:54:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 14:54:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Aug 2016 14:54:28 -0400
Date:   Wed, 24 Aug 2016 14:54:28 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 3/3] receive-pack: allow a maximum input size to be
 specified
Message-ID: <20160824185428.6k6tatv4cc5pre5c@sigill.intra.peff.net>
References: <20160824184157.19264-1-chriscool@tuxfamily.org>
 <20160824184157.19264-4-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160824184157.19264-4-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 24, 2016 at 08:41:57PM +0200, Christian Couder wrote:

> +test_pack_input_limit () {
> +	case "$1" in
> +	index) unpack_limit=1 ;;
> +	unpack) unpack_limit=10000 ;;
> +	esac

Nice, this is pretty self-explanatory.

> +	test_expect_success 'prepare destination repository' '
> +		rm -fr dest &&
> +		git --bare init dest
> +	'
> +
> +	test_expect_success "set unpacklimit to $unpack_limit" '
> +		git --git-dir=dest config receive.unpacklimit "$unpack_limit"
> +	'
> +
> +	test_expect_success 'setting receive.maxInputSize to 512 rejects push' '
> +		git --git-dir=dest config receive.maxInputSize 512 &&
> +		test_must_fail git push dest HEAD
> +	'
> +
> +	test_expect_success 'bumping limit to 4k allows push' '
> +		git --git-dir=dest config receive.maxInputSize 4k &&
> +		git push dest HEAD
> +	'

Makes sense. We couldn't push, and then we could.

> +	test_expect_success 'prepare destination repository (again)' '
> +		rm -fr dest &&
> +		git --bare init dest
> +	'
> +
> +	test_expect_success 'lifting the limit allows push' '
> +		git --git-dir=dest config receive.maxInputSize 0 &&
> +		git push dest HEAD
> +	'

This is new in this iteration, I think. At first I thought "but every
_other_ test script is implicitly testing that we work without the
limit". But this is showing that setting the limit explicitly to 0 does
work, which is good.

The whole series looks fine to me.

-Peff
