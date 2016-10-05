Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49BFC1F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 14:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754096AbcJEOkc (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 10:40:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:52765 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751982AbcJEOkb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 10:40:31 -0400
Received: (qmail 23749 invoked by uid 109); 5 Oct 2016 14:40:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Oct 2016 14:40:30 +0000
Received: (qmail 17581 invoked by uid 111); 5 Oct 2016 14:40:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Oct 2016 10:40:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Oct 2016 10:40:28 -0400
Date:   Wed, 5 Oct 2016 10:40:28 -0400
From:   Jeff King <peff@peff.net>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 06/18] t5613: clarify "too deep" recursion tests
Message-ID: <20161005144028.tjuvk3hkoqm3qjfd@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203412.bekizvlqtg4ls5fb@sigill.intra.peff.net>
 <CA+P7+xok5PoNKO+8R6zF9SXYfDq6BboDTDz9WZYEczs0pFK+pw@mail.gmail.com>
 <20161004134853.x3zq33ywyyzgbwsy@sigill.intra.peff.net>
 <CA+P7+xok-8vhikxkp+t8pu53YJAyUjZ0NiAwejEW2j3+eP_2Xw@mail.gmail.com>
 <20161004204933.ygfhoy24g6psyf6h@sigill.intra.peff.net>
 <CA+P7+xo3nxy1EOjDqHvKQuK128c=b73XN=6qqn6g6oRGh2VdFg@mail.gmail.com>
 <20161004205510.6bhisw7ixbgcvvwn@sigill.intra.peff.net>
 <CAGZ79kap2ndp=FK4YdqrL4tJ8_VDuuAcSCk1dtX5X2H3aaj6kQ@mail.gmail.com>
 <2ea2f077-ab02-2631-4ce9-93cdd22c3c6b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ea2f077-ab02-2631-4ce9-93cdd22c3c6b@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 05, 2016 at 03:58:53PM +0200, Jakub Narębski wrote:

> I would prefer the following:
> 
> #   A --> B --> C --> D --> E --> F --> G --> H
> #      0     1     2     3     4     5     6

Yeah, that is also more visually pleasing.

Here's a squashable update that uses that and clarifies the points in
the discussion with Jacob.

Junio, do you mind squashing this in to jk/alt-odb-cleanup?

diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
index b393613..62170b7 100755
--- a/t/t5613-info-alternate.sh
+++ b/t/t5613-info-alternate.sh
@@ -39,13 +39,16 @@ test_expect_success 'preparing third repository' '
 	)
 '
 
-# Note: These tests depend on the hard-coded value of 5 as "too deep". We start
-# the depth at 0 and count links, not repositories, so in a chain like:
+# Note: These tests depend on the hard-coded value of 5 as the maximum depth
+# we will follow recursion. We start the depth at 0 and count links, not
+# repositories. This means that in a chain like:
 #
-#   A -> B -> C -> D -> E -> F -> G -> H
-#      0    1    2    3    4    5    6
+#   A --> B --> C --> D --> E --> F --> G --> H
+#      0     1     2     3     4     5     6
 #
-# we are OK at "G", but break at "H".
+# we are OK at "G", but break at "H", even though "H" is actually the 8th
+# repository, not the 6th, which you might expect. Counting the links allows
+# N+1 repositories, and counting from 0 to 5 inclusive allows 6 links.
 #
 # Note also that we must use "--bare -l" to make the link to H. The "-l"
 # ensures we do not do a connectivity check, and the "--bare" makes sure
@@ -59,11 +62,11 @@ test_expect_success 'creating too deep nesting' '
 	git clone --bare -l -s G H
 '
 
-test_expect_success 'validity of fifth-deep repository' '
+test_expect_success 'validity of seventh repository' '
 	git -C G fsck
 '
 
-test_expect_success 'invalidity of sixth-deep repository' '
+test_expect_success 'invalidity of eighth repository' '
 	test_must_fail git -C H fsck
 '
 
