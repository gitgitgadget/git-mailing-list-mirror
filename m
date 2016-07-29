Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FCD81F858
	for <e@80x24.org>; Fri, 29 Jul 2016 04:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbcG2EE2 (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 00:04:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:50785 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750729AbcG2EE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 00:04:26 -0400
Received: (qmail 23813 invoked by uid 102); 29 Jul 2016 04:04:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 00:04:27 -0400
Received: (qmail 31273 invoked by uid 107); 29 Jul 2016 04:04:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 00:04:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jul 2016 00:04:23 -0400
Date:	Fri, 29 Jul 2016 00:04:23 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/7] speed up pack-objects counting with many packs
Message-ID: <20160729040422.GA19678@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is a follow-up to the patches in

  http://public-inbox.org/git/20160725184938.GA12871@sigill.intra.peff.net/

that are currently queued in jk/pack-objects-optim-skimming. Roughly,
they try to optimize a loop that is O(nr_objects * nr_packs) by breaking
out early in some cases.

I had written those patches a while ago and confirmed that they did
speed up a particular nasty case I had. But when I tried to write a
t/perf test to show off the improvement, I found that they didn't help!
The reason is that the optimizations are heavily dependent on the order
of the packs, and which objects go in which pack. The loop has the same
worst-case complexity as it always did, but we rely on getting lucky to
break out early.

I think the perf test I've included here is more representative of a
real-world workloads, and with an extra optimization, I was able to show
good numbers with it.

The general strategy is to order the pack lookups in most-recently-used
order. This replaces an existing 1-element MRU cache in the normal pack
lookup code, and replaces a straight reverse-chronological iteration in
pack-objects.

All credit for thinking of this scheme goes to Michael Haggerty, who
suggested the idea to me about six months ago. It seemed like a lot of
work at the time, so I didn't do it. :) But as I started to implement
the same 1-element cache in pack-objects, I found that the code actually
gets rather awkward. The MRU solution makes the callers easier to read,
and of course it turns out to be faster, to boot.

Anyway, enough chit-chat. The patches are:

  [1/7]: t/perf: add tests for many-pack scenarios
  [2/7]: sha1_file: drop free_pack_by_name
  [3/7]: add generic most-recently-used list
  [4/7]: find_pack_entry: replace last_found_pack with MRU cache
  [5/7]: pack-objects: break out of want_object loop early
  [6/7]: pack-objects: compute local/ignore_pack_keep early
  [7/7]: pack-objects: use mru list when iterating over packs

The actual optimizations are in patches 4 and 7, which have their own
numbers. But here are end-to-end numbers for the series against the tip
of master (for the meanings, see the discussion in patch 1, and the
analysis in 4 and 7):

[p5303, linux.git]
Test                      origin                HEAD
-------------------------------------------------------------------------
5303.3: rev-list (1)      31.48(31.20+0.27)     31.18(30.95+0.22) -1.0%
5303.4: repack (1)        40.74(39.27+2.56)     40.30(38.96+2.47) -1.1%
5303.6: rev-list (50)     31.65(31.38+0.26)     31.26(31.02+0.23) -1.2%
5303.7: repack (50)       60.90(71.03+2.13)     46.95(57.46+1.85) -22.9%
5303.9: rev-list (1000)   38.63(38.25+0.37)     31.91(31.61+0.28) -17.4%
5303.10: repack (1000)    392.52(467.09+5.05)   87.38(159.98+2.92) -77.7%

[p5303, git.git]
Test                      origin              HEAD
---------------------------------------------------------------------
5303.3: rev-list (1)      1.55(1.54+0.00)     1.56(1.54+0.01) +0.6%
5303.4: repack (1)        1.83(1.82+0.06)     1.82(1.82+0.05) -0.5%
5303.6: rev-list (50)     1.58(1.56+0.02)     1.58(1.57+0.00) +0.0%
5303.7: repack (50)       2.50(3.16+0.04)     2.32(2.92+0.09) -7.2%
5303.9: rev-list (1000)   2.64(2.61+0.02)     2.23(2.21+0.01) -15.5%
5303.10: repack (1000)    12.68(19.07+0.30)   7.51(13.86+0.20) -40.8%

For curiosity, I also ran the git.git case with 10,000 packs. This is
even more silly, but it shows that the problem does get worse and worse
as the number grows, but that the patches do continue to help:

Test                        origin               HEAD
-------------------------------------------------------------------------
5303.12: rev-list (10,000)  26.00(25.86+0.13)    15.76(15.62+0.13) -39.4%
5303.13: repack (10,000)   164.11(175.30+1.34)   51.48(62.96+1.18) -68.6%

-Peff
