Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2ECE202AC
	for <e@80x24.org>; Fri,  7 Jul 2017 08:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751833AbdGGIgk (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 04:36:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:33352 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751757AbdGGIgj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 04:36:39 -0400
Received: (qmail 7106 invoked by uid 109); 7 Jul 2017 08:36:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 08:36:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20462 invoked by uid 111); 7 Jul 2017 08:36:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 04:36:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Jul 2017 04:36:37 -0400
Date:   Fri, 7 Jul 2017 04:36:37 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Kyle Meyer <kyle@kyleam.com>,
        git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: [PATCH v2 0/4] reflog-walk fixes for maint
Message-ID: <20170707083636.kjsr5ry3237paeiv@sigill.intra.peff.net>
References: <20170622184516.kq3y7nxwohm3coq4@sigill.intra.peff.net>
 <xmqqvannkfp8.fsf@gitster.mtv.corp.google.com>
 <20170622202146.cxrkjca636xl4dgk@sigill.intra.peff.net>
 <xmqqd19vix03.fsf@gitster.mtv.corp.google.com>
 <20170622215235.to6yleo3adt5klv2@sigill.intra.peff.net>
 <20170622222545.yewnynklle24ebtf@sigill.intra.peff.net>
 <20170623031315.7aw5qd7c4wdqlyf6@sigill.intra.peff.net>
 <20170704195806.ndbykl776t3vigya@genre.crustytoothpaste.net>
 <20170704212408.xy6jciggoueq6qsu@sigill.intra.peff.net>
 <20170705075508.c5ul23vivzpklpy6@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170705075508.c5ul23vivzpklpy6@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 05, 2017 at 03:55:08AM -0400, Jeff King wrote:

> The first patch is my original small fix with an extra test. I think
> that would be appropriate for 'maint'. Its behavior still has some
> quirks, but it avoids the confusion that you experienced and has a low
> risk of breaking anything else.
> 
> The rest of it replaces the fake-parent thing with a more
> straight-forward iteration over the reflogs (i.e., a cleanup of the
> further patches I've been posting). After digging into it and especially
> after writing the new tests, I think I've convinced myself that this is
> the right way forward.

Here's an updated version of the bug-fix patch, along with the fix for
the problem that Eric noticed, and some other problems I noticed while
fixing that one. So I've split these immediate fixes for maint off into
their own series.

These are based on maint itself, rather than Kyle's original commit that
introduces the double-null reflog, since some of the bugs came later in
the v2.13 cycle (if we really wanted to, we could split it again into
two more series, but I don't think it's worth the trouble).

  [1/4]: reflog-walk: skip over double-null oid due to HEAD rename

    This is the fix for the pseudo-truncation in v2.13, and is the same
    as the previous round.

  [2/4]: reflog-walk: duplicate strings in complete_reflogs list

    This fixes Eric's bug, and is the same as what I showed earlier.
    It's a triggerable use-after-free, which is why I think it's
    important to get it into maint.

  [3/4]: reflog-walk: don't free reflogs added to cache

    This is another use-after-free, though it's slightly harder to
    trigger.

  [4/4]: reflog-walk: include all fields when freeing complete_reflogs

    This one is an optional cleanup, but worth doing, I think.


 reflog-walk.c          | 33 +++++++++++++++++++++------------
 t/t1411-reflog-show.sh | 10 ++++++++++
 t/t3200-branch.sh      | 11 +++++++++++
 3 files changed, 42 insertions(+), 12 deletions(-)

-Peff
