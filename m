Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10F431F462
	for <e@80x24.org>; Thu, 13 Jun 2019 17:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfFMRTQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 13:19:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:54094 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726230AbfFMRTP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 13:19:15 -0400
Received: (qmail 3462 invoked by uid 109); 13 Jun 2019 17:19:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jun 2019 17:19:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20296 invoked by uid 111); 13 Jun 2019 17:20:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 13 Jun 2019 13:20:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jun 2019 13:19:13 -0400
Date:   Thu, 13 Jun 2019 13:19:13 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/3] t: add t0016-oidmap.sh
Message-ID: <20190613171913.GA14055@sigill.intra.peff.net>
References: <20190609044907.32477-1-chriscool@tuxfamily.org>
 <20190609044907.32477-3-chriscool@tuxfamily.org>
 <20190609092259.GB24208@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190609092259.GB24208@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 09, 2019 at 11:22:59AM +0200, SZEDER Gábor wrote:

> So, 'test oidmap' from the previous patch prints the value we want to
> check with:
> 
>     printf("%u\n", sha1hash(oid.hash));
> 
> First, since object ids inherently make more sense as hex values, it
> would be more appropriate to print that hash with the '%x' format
> specifier, and then we wouldn't need Perl's hex() anymore, and thus
> could swap the order of the first four bytes in oidmap's hash without
> relying on Perl, e.g. with:
> 
>   sed -e 's/^\(..\)\(..\)\(..\)\(..\).*/\4\3\2\1/'
> 
> Second, and more importantly, the need for swapping the byte order
> indicates that this test would fail on big-endian systems, I'm afraid.
> So I think we need an additional bswap32() on the printing side, and
> then could further simplify 'test_oidhash':

I agree with all your points about using hex and pushing the logic into
test-oidmap.c. BUT.

At the point where we are normalizing byte order of the hashes, I have
to wonder: why do we care about testing the hash value in the first
place? We care that oidmap can store and retrieve values, and that it
performs well. But as long as it does those things, I don't think
anybody cares if it uses the first 4 bytes of the sha1 or the last 4.

I know there are testing philosophies that go to this level of white-box
testing, but I don't think we usually do in Git. A unit test of oidmap's
externally visible behavior seems like the right level to me.

-Peff
