Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0778A202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 17:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932658AbdJ3R7o (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 13:59:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:40356 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932552AbdJ3R7o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 13:59:44 -0400
Received: (qmail 9728 invoked by uid 109); 30 Oct 2017 17:59:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 30 Oct 2017 17:59:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25535 invoked by uid 111); 30 Oct 2017 17:59:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 30 Oct 2017 13:59:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Oct 2017 10:59:41 -0700
Date:   Mon, 30 Oct 2017 10:59:41 -0700
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Stefan Beller <sbeller@google.com>, gitster@pobox.com,
        git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 2/2] diff.c: get rid of duplicate implementation
Message-ID: <20171030175941.tbjlfp72txgod22x@sigill.intra.peff.net>
References: <xmqqinf3izgm.fsf@gitster.mtv.corp.google.com>
 <20171025184912.21657-1-sbeller@google.com>
 <20171025184912.21657-3-sbeller@google.com>
 <b6012c19-c067-1700-12de-2a42c25c9c7d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6012c19-c067-1700-12de-2a42c25c9c7d@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 26, 2017 at 07:43:19PM +0200, René Scharfe wrote:

> Am 25.10.2017 um 20:49 schrieb Stefan Beller:
> > The implementations in diff.c to detect moved lines needs to compare
> > strings and hash strings, which is implemented in that file, as well
> > as in the xdiff library.
> > 
> > Remove the rather recent implementation in diff.c and rely on the well
> > exercised code in the xdiff lib.
> > 
> > With this change the hash used for bucketing the strings for the moved
> > line detection changes from FNV32 (that is provided via the hashmaps
> > memhash) to DJB2 (which is used internally in xdiff).  Benchmarks found
> > on the web[1] do not indicate that these hashes are different in
> > performance for readable strings.
> > 
> > [1] https://softwareengineering.stackexchange.com/questions/49550/which-hashing-algorithm-is-best-for-uniqueness-and-speed
> 
> Awesome comparison!  It calls the variant used in libxdiff DJB2a (which
> uses xor to mix in the new char) instead of DJB2 (which uses addition).
> 
> There's also https://www.strchr.com/hash_functions, which lists DJB2
> as Bernstein.  Both functions rank somewhere in the middle of that list.

FWIW, I did some experiments with Murmur3 and SipHash a while back, but
I don't think I came up with anything faster than the existing code.
OTOH, moving to SipHash gives us the ability to randomize the hashes,
which can resist some DoS attacks (although as I've said before,
computing arbitrary diffs for untrusted strangers is pretty much a
DoS-in-a-box).

Anyway, I rebased them and ran p4000[1], with does show some results:

Test                                  origin            jk/xdl-murmur3-wip       jk/xdl-siphash-wip    
-------------------------------------------------------------------------------------------------------
4000.1: log -3000 (baseline)          0.05(0.05+0.00)   0.05(0.05+0.00) +0.0%    0.05(0.05+0.00) +0.0% 
4000.2: log --raw -3000 (tree-only)   0.30(0.28+0.02)   0.30(0.28+0.01) +0.0%    0.30(0.28+0.02) +0.0% 
4000.3: log -p -3000 (Myers)          2.06(1.98+0.08)   1.90(1.85+0.05) -7.8%    2.32(2.25+0.07) +12.6%
4000.4: log -p -3000 --histogram      2.50(2.42+0.07)   2.25(2.21+0.04) -10.0%   2.70(2.62+0.08) +8.0% 
4000.5: log -p -3000 --patience       2.58(2.52+0.06)   2.47(2.42+0.04) -4.3%    2.86(2.77+0.08) +10.9%

So it looks like murmur3 is indeed a little faster. SipHash is slower,
which is too bad (because the randomization would be nice). I _think_
back then I compared to XDL_FAST_HASH, which was a little faster even
than murmur3 (but generated too many collisions, which led to bad
behavior for certain cases).

Anyway, those branches are at https://github.com/peff/git if anybody
wants to look further. They probably need some cleanup. At the very
least, we'd probably need to teach the whitespace-ignoring hash function
to use the same algorithm.

-Peff

[1] Actually, I added "--no-merges" to each command in p4000. It seems
    silly as it is, since the point is to compute a bunch of diffs.
