Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E483202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 19:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbdJ3THN (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 15:07:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:40496 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752763AbdJ3THM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 15:07:12 -0400
Received: (qmail 12179 invoked by uid 109); 30 Oct 2017 19:07:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 30 Oct 2017 19:07:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26092 invoked by uid 111); 30 Oct 2017 19:07:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 30 Oct 2017 15:07:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Oct 2017 12:07:10 -0700
Date:   Mon, 30 Oct 2017 12:07:10 -0700
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Stefan Beller <sbeller@google.com>, gitster@pobox.com,
        git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 2/2] diff.c: get rid of duplicate implementation
Message-ID: <20171030190710.w7pyokbfxzkjdqcx@sigill.intra.peff.net>
References: <xmqqinf3izgm.fsf@gitster.mtv.corp.google.com>
 <20171025184912.21657-1-sbeller@google.com>
 <20171025184912.21657-3-sbeller@google.com>
 <b6012c19-c067-1700-12de-2a42c25c9c7d@web.de>
 <20171030175941.tbjlfp72txgod22x@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171030175941.tbjlfp72txgod22x@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 30, 2017 at 10:59:41AM -0700, Jeff King wrote:

> > There's also https://www.strchr.com/hash_functions, which lists DJB2
> > as Bernstein.  Both functions rank somewhere in the middle of that list.
> 
> FWIW, I did some experiments with Murmur3 and SipHash a while back, but
> I don't think I came up with anything faster than the existing code.
> OTOH, moving to SipHash gives us the ability to randomize the hashes,
> which can resist some DoS attacks (although as I've said before,
> computing arbitrary diffs for untrusted strangers is pretty much a
> DoS-in-a-box).

By the way, one of the things that complicates plugging new functions
into xdiff's hashing is that xdl_hash_record() simultaneously computes
the hash _and_ finds the end-of-line marker.

So the "siphash is only 10% slower" number I showed came with quite a
few contortions to do both. Here it is compared to a more naive
application of the siphash code (i.e., memchr to find end-of-line, and
then feed the resulting bytes to siphash):

Test                                  origin            HEAD^                    jk/xdl-siphash-wip
-------------------------------------------------------------------------------------------------------
4000.1: log -3000 (baseline)          0.05(0.05+0.00)   0.05(0.05+0.00) +0.0%    0.05(0.05+0.00) +0.0%
4000.2: log --raw -3000 (tree-only)   0.31(0.27+0.03)   0.31(0.27+0.03) +0.0%    0.31(0.27+0.03) +0.0%
4000.3: log -p -3000 (Myers)          2.06(2.01+0.05)   2.30(2.21+0.09) +11.7%   2.96(2.91+0.04) +43.7%
4000.4: log -p -3000 --histogram      2.44(2.38+0.06)   2.67(2.60+0.07) +9.4%    3.32(3.26+0.06) +36.1%
4000.5: log -p -3000 --patience       2.57(2.47+0.09)   2.90(2.82+0.08) +12.8%   3.48(3.43+0.05) +35.4%

There "origin" is the existing djb hash, "HEAD^" is the complicated
"fast" siphash (which I very well may have screwed up), and the final is
the more naive version, which is quite a bit slower.

-Peff
