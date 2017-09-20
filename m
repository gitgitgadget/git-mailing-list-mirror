Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D971120A2A
	for <e@80x24.org>; Wed, 20 Sep 2017 18:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbdITS1l (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 14:27:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:44846 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751024AbdITS1l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 14:27:41 -0400
Received: (qmail 6722 invoked by uid 109); 20 Sep 2017 18:27:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Sep 2017 18:27:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14953 invoked by uid 111); 20 Sep 2017 18:28:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Sep 2017 14:28:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Sep 2017 14:27:33 -0400
Date:   Wed, 20 Sep 2017 14:27:33 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 08/21] read_packed_refs(): read references with
 minimal copying
Message-ID: <20170920182732.wy6bojeaonpxb3mc@sigill.intra.peff.net>
References: <cover.1505799700.git.mhagger@alum.mit.edu>
 <597241da13f62d51fefd3396bfbab22a8f633a56.1505799700.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <597241da13f62d51fefd3396bfbab22a8f633a56.1505799700.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 19, 2017 at 08:22:16AM +0200, Michael Haggerty wrote:

> Instead of copying data from the `packed-refs` file one line at time
> and then processing it, process the data in place as much as possible.
> 
> Also, instead of processing one line per iteration of the main loop,
> process a reference line plus its corresponding peeled line (if
> present) together.
> 
> Note that this change slightly tightens up the parsing of the
> `parse-ref` file. Previously, the parser would have accepted multiple

s/parse-ref/packed-refs/, I assume

The patch itself looks good, though I did notice an interesting tangent.

> +		if (eof - pos < GIT_SHA1_HEXSZ + 2 ||
> +		    parse_oid_hex(p, &oid, &p) ||
> +		    !isspace(*p++))
> +			die_invalid_line(refs->path, pos, eof - pos);

I wondered why you didn't just check the output of parse_oid_hex(), and
included the length check (since in the long run we'd like to get rid of
uses of the static GIT_SHA1_HEXSZ macro). I imagine the answer is that
this is an mmap'd buffer, and we can't guarantee that parse_oid_hex()
wouldn't walk off the end of it.

That's fine for now, but I suspect it may become a problem when we move
to having a second hash function with a different length. You can't just
say "it must have as many bytes as the longest hash", because of course
we could have the shorter hash at the end of the buffer. But we also
can't say "it must have as many bytes as the shortest hash", because if
the content implies it's a longer hash, we'd read off the end of the
buffer.

I think in the long run we will need a parse_oid_hex() function that
takes a ptr/len (or start/end) pair.

Sorry, that got a bit off-topic. I don't think there's anything to be
done now in your series. It just raises an interesting question for
people working on the hash conversion stuff. +cc brian as an FYI.

-Peff
