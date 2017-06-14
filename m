Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9DB620401
	for <e@80x24.org>; Wed, 14 Jun 2017 09:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751988AbdFNJdV (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 05:33:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:39874 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751880AbdFNJco (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 05:32:44 -0400
Received: (qmail 14233 invoked by uid 109); 14 Jun 2017 09:32:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 09:32:44 +0000
Received: (qmail 9751 invoked by uid 111); 14 Jun 2017 09:32:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 05:32:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jun 2017 05:32:42 -0400
Date:   Wed, 14 Jun 2017 05:32:42 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98yvind?= Holm <sunny@sunbase.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] for_each_bisect_ref(): don't trim refnames
Message-ID: <20170614093242.twipnjncaka2lhyg@sigill.intra.peff.net>
References: <cover.1497430232.git.mhagger@alum.mit.edu>
 <3615deefe90bebe746618b04c055a466a442f85b.1497430232.git.mhagger@alum.mit.edu>
 <20170614092256.c3fmfcokuwbbcvbz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170614092256.c3fmfcokuwbbcvbz@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 14, 2017 at 05:22:56AM -0400, Jeff King wrote:

> >  refs.c     | 12 ++++++++++++
> >  refs.h     |  5 ++++-
> >  revision.c |  2 +-
> >  3 files changed, 17 insertions(+), 2 deletions(-)
> 
> The change itself looks fine to me.
> 
> Since we obviously don't have even a single test for "--bisect", that
> might be worth adding.

It turns out we do, but none that actually check that we use the default
refnames. So maybe squash this in?

diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
index 3bf2759ea..534903bbd 100755
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -235,4 +235,18 @@ test_sequence "--bisect"
 
 #
 #
+
+test_expect_success '--bisect can default to good/bad refs' '
+	git update-ref refs/bisect/bad c3 &&
+	good=$(git rev-parse b1) &&
+	git update-ref refs/bisect/good-$good $good &&
+	good=$(git rev-parse c1) &&
+	git update-ref refs/bisect/good-$good $good &&
+
+	# the only thing between c3 and c1 is c2
+	git rev-parse c2 >expect &&
+	git rev-list --bisect >actual &&
+	test_cmp expect actual
+'
+
 test_done
