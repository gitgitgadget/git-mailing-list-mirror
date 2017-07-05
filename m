Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EAC1202AB
	for <e@80x24.org>; Wed,  5 Jul 2017 07:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752301AbdGEHzL (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 03:55:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:59742 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752125AbdGEHzK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 03:55:10 -0400
Received: (qmail 21306 invoked by uid 109); 5 Jul 2017 07:55:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Jul 2017 07:55:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5641 invoked by uid 111); 5 Jul 2017 07:55:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Jul 2017 03:55:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jul 2017 03:55:08 -0400
Date:   Wed, 5 Jul 2017 03:55:08 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Kyle Meyer <kyle@kyleam.com>,
        git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>
Subject: [PATCH 0/6] fixing reflog-walk oddities
Message-ID: <20170705075508.c5ul23vivzpklpy6@sigill.intra.peff.net>
References: <xmqqziczkh4k.fsf@gitster.mtv.corp.google.com>
 <20170622184516.kq3y7nxwohm3coq4@sigill.intra.peff.net>
 <xmqqvannkfp8.fsf@gitster.mtv.corp.google.com>
 <20170622202146.cxrkjca636xl4dgk@sigill.intra.peff.net>
 <xmqqd19vix03.fsf@gitster.mtv.corp.google.com>
 <20170622215235.to6yleo3adt5klv2@sigill.intra.peff.net>
 <20170622222545.yewnynklle24ebtf@sigill.intra.peff.net>
 <20170623031315.7aw5qd7c4wdqlyf6@sigill.intra.peff.net>
 <20170704195806.ndbykl776t3vigya@genre.crustytoothpaste.net>
 <20170704212408.xy6jciggoueq6qsu@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170704212408.xy6jciggoueq6qsu@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 04, 2017 at 05:24:08PM -0400, Jeff King wrote:

> On Tue, Jul 04, 2017 at 07:58:06PM +0000, brian m. carlson wrote:
> 
> > > And here's one more patch on top of those that's necessary to get the
> > > tests to pass (I don't expect anybody to necessarily be applying this
> > > slow string of patches; it's just to show the direction I'm looking in).
> > 
> > I've looked at your original patch, which modified reflog-walk.c, and it
> > does fix the issue.  I'm happy to send in a patch with that and a test
> > (provided you're okay with me adding your sign-off), or if you wanted to
> > send in something a bit more complete, like the series of patches here,
> > that's fine, too.
> 
> I've been on vacation for the past week, but wrapping this up is on my
> todo. I'll try to get to it tonight.

OK, so here's what I came up with.

The first patch is my original small fix with an extra test. I think
that would be appropriate for 'maint'. Its behavior still has some
quirks, but it avoids the confusion that you experienced and has a low
risk of breaking anything else.

The rest of it replaces the fake-parent thing with a more
straight-forward iteration over the reflogs (i.e., a cleanup of the
further patches I've been posting). After digging into it and especially
after writing the new tests, I think I've convinced myself that this is
the right way forward.

I tried to anticipate the behavior changes and I think all of them are
improvements. I won't be surprised if there's some hidden gotcha,
though, so this is definitely not for 'maint'. The patches do textually
depend on the fix from 1/6; my intent was that they'd be applied in
sequence and only merge up the first one to maint.

  [1/6]: reflog-walk: skip over double-null oid due to HEAD rename
  [2/6]: t1414: document some reflog-walk oddities
  [3/6]: log: do not free parents when walking reflog
  [4/6]: get_revision_1(): replace do-while with an early return
  [5/6]: rev-list: check reflog_info before showing usage
  [6/6]: reflog-walk: stop using fake parents

 builtin/log.c          |   4 +-
 builtin/rev-list.c     |   3 +-
 reflog-walk.c          | 117 ++++++++++++++-----------------------------------
 reflog-walk.h          |   6 ++-
 revision.c             |  39 ++++++++++-------
 t/t1414-reflog-walk.sh |  86 ++++++++++++++++++++++++++++++++++++
 t/t3200-branch.sh      |  10 +++++
 7 files changed, 160 insertions(+), 105 deletions(-)
 create mode 100755 t/t1414-reflog-walk.sh

-Peff
