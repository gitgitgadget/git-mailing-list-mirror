Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F9591FF76
	for <e@80x24.org>; Sat, 24 Dec 2016 02:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762357AbcLXC5e (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Dec 2016 21:57:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:60113 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752359AbcLXC5d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2016 21:57:33 -0500
Received: (qmail 21203 invoked by uid 109); 24 Dec 2016 02:57:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 24 Dec 2016 02:57:33 +0000
Received: (qmail 28068 invoked by uid 111); 24 Dec 2016 02:58:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Dec 2016 21:58:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Dec 2016 21:57:30 -0500
Date:   Fri, 23 Dec 2016 21:57:30 -0500
From:   Jeff King <peff@peff.net>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/2] auto gc: don't write bitmaps for incremental
 repacks
Message-ID: <20161224025730.vwz2k4af6z6piinl@sigill.intra.peff.net>
References: <1482541735-21346-1-git-send-email-dturner@twosigma.com>
 <1482541735-21346-2-git-send-email-dturner@twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1482541735-21346-2-git-send-email-dturner@twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 23, 2016 at 08:08:54PM -0500, David Turner wrote:

> +	git gc --auto 2>err &&
> +	test_i18ngrep ! "^warning:" err &&
> +	ls .git/objects/pack/ | grep -v bitmap | sort >post_packs &&

I'm not sure why you omit the bitmap here. It shouldn't change, right?
In that case it should not be mentioned by comm, and not impact the
counts you check later (and in the off chance that a new .bitmap is
created, we'd want to know and fail the test, I would think).

> +	comm --output-delimiter , -1 -3 existing_packs post_packs >new &&
> +	comm --output-delimiter , -2 -3 existing_packs post_packs >del &&

I don't think --output-delimiter will be portable beyond GNU comm.

> +	test_line_count = 0 del && # No packs are deleted
> +	test_line_count = 2 new # There is one new pack and its .idx

This logic makes sense (and is much nicer than the previous round).

-Peff
