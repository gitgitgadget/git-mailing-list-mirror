Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA78C433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 07:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E553E207D3
	for <git@archiver.kernel.org>; Wed, 27 May 2020 07:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgE0HaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 03:30:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:57128 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728303AbgE0HaV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 03:30:21 -0400
Received: (qmail 20450 invoked by uid 109); 27 May 2020 07:30:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2020 07:30:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1564 invoked by uid 111); 27 May 2020 07:30:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2020 03:30:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 May 2020 03:30:20 -0400
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] blame: test the -b option, use blank oid for
 boundary commits.
Message-ID: <20200527073020.GB4006199@coredump.intra.peff.net>
References: <20200525215751.1735-1-philipoakley@iee.email>
 <20200525215751.1735-5-philipoakley@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200525215751.1735-5-philipoakley@iee.email>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 25, 2020 at 10:57:51PM +0100, Philip Oakley wrote:

> The sed script removes the last hex digit from boundary commit oids
> '^hexx msg' -> '^hex  msg' until all leading hex's are gone, finally
> removing the boundary commit marker.

Thanks for documenting this, as the sed was rather hard to read:

> +test_expect_success 'test -b option, blank oid for boundary commits' '
> +	git blame -b branch1.. -- file >actual &&
> +	git blame branch1.. -- file >full &&
> +	sed -e "/^\^/{
> +		:loop;
> +		s/^\(\^[0-9a-f]*\)[0-9a-f] \(.*\)/\1  \2/g;
> +		tloop;
> +		s/^\^/ /;
> +	}" full >expected &&

I wonder if we can make it simpler.

In perl I'd probably just replace the whole string with the equivalent
number of spaces, like:

  perl -pe 's/^\^\S+/" " x length($&)/e'

but I suppose some would consider that pretty magical, too. It might be
simpler still to just avoid testing leading whitespace:

   sed 's/^\^[0-9a-f]* *//' <full >expected &&
   sed 's/^ *//' <actual >actual.stripped &&
   test_cmp expected actual.stripped

but perhaps the indentation is a useful part of what we're testing.

-Peff
