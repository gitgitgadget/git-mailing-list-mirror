Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B45A202AC
	for <e@80x24.org>; Fri,  7 Jul 2017 09:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbdGGJFK (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 05:05:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:33436 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751833AbdGGJFK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 05:05:10 -0400
Received: (qmail 8256 invoked by uid 109); 7 Jul 2017 09:05:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 09:05:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20678 invoked by uid 111); 7 Jul 2017 09:05:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 05:05:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Jul 2017 05:05:07 -0400
Date:   Fri, 7 Jul 2017 05:05:07 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Kyle Meyer <kyle@kyleam.com>,
        git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: [PATCH v2 0/7] fixing reflog-walk oddities
Message-ID: <20170707090507.ko2ygry7j4zv7t3s@sigill.intra.peff.net>
References: <xmqqvannkfp8.fsf@gitster.mtv.corp.google.com>
 <20170622202146.cxrkjca636xl4dgk@sigill.intra.peff.net>
 <xmqqd19vix03.fsf@gitster.mtv.corp.google.com>
 <20170622215235.to6yleo3adt5klv2@sigill.intra.peff.net>
 <20170622222545.yewnynklle24ebtf@sigill.intra.peff.net>
 <20170623031315.7aw5qd7c4wdqlyf6@sigill.intra.peff.net>
 <20170704195806.ndbykl776t3vigya@genre.crustytoothpaste.net>
 <20170704212408.xy6jciggoueq6qsu@sigill.intra.peff.net>
 <20170705075508.c5ul23vivzpklpy6@sigill.intra.peff.net>
 <20170707083636.kjsr5ry3237paeiv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170707083636.kjsr5ry3237paeiv@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 07, 2017 at 04:36:36AM -0400, Jeff King wrote:

> Here's an updated version of the bug-fix patch, along with the fix for
> the problem that Eric noticed, and some other problems I noticed while
> fixing that one. So I've split these immediate fixes for maint off into
> their own series.

And here's the parent-less walk for master. This must be applied on a
merge of the bug-fix series to the current master. I didn't do it all on
"maint" because a lot of it depends on the timestamp_t work which is
only in master. And trying to use "unsigned long" and merge that up to
master correctly is error-prone. It not only doesn't create textual
conflicts, but the semantic conflicts it generates are really subtle and
only break on certain systems.

This should address all of the comments on v1, including the
multi-reflog iteration order and the --since/--until bits. There are a
few new fixes, too.

  [v2 1/7]: t1414: document some reflog-walk oddities

    The big change is that this expects the interleaved order in the
    multi-reflog test. There are a few updated comments and some
    adaptations to cover some bits from the bug-fix series.

  [v2 2/7]: revision: disallow reflog walking with revs->limited

    This is new, and just cleanly disallows some already-broken cases.

  [v2 3/7]: log: do not free parents when walking reflog
  [v2 4/7]: get_revision_1(): replace do-while with an early return
  [v2 5/7]: rev-list: check reflog_info before showing usage

    These ones are the same as before.

  [v2 6/7]: reflog-walk: stop using fake parents

    The big change here is the interleaved output. This is largely what
    I showed earlier, but with a few cleanups.

  [v2 7/7]: reflog-walk: apply --since/--until to reflog dates

    This is new, and is a cleaned-up version of what I showed earlier.
    See the commit message for some discussion. These options _do_
    actually work sanely after 6/7, but I think the semantics given here
    are probably more useful and what people would expect.

 builtin/log.c          |   4 +-
 builtin/rev-list.c     |   3 +-
 reflog-walk.c          | 152 ++++++++++++++++++++++---------------------------
 reflog-walk.h          |   7 ++-
 revision.c             |  57 ++++++++++++-------
 t/t1411-reflog-show.sh |  10 ----
 t/t1414-reflog-walk.sh | 135 +++++++++++++++++++++++++++++++++++++++++++
 t/t3200-branch.sh      |   3 +-
 8 files changed, 249 insertions(+), 122 deletions(-)
 create mode 100755 t/t1414-reflog-walk.sh

-Peff
