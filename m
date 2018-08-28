Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F263F1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbeH2BQE (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:16:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:59486 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726998AbeH2BQE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:16:04 -0400
Received: (qmail 29716 invoked by uid 109); 28 Aug 2018 21:22:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Aug 2018 21:22:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5778 invoked by uid 111); 28 Aug 2018 21:22:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 28 Aug 2018 17:22:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Aug 2018 17:22:32 -0400
Date:   Tue, 28 Aug 2018 17:22:32 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 1/9] coccinelle: use <...> for function exclusion
Message-ID: <20180828212232.GA11036@sigill.intra.peff.net>
References: <20180828212126.GA7039@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180828212126.GA7039@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes we want to suppress a coccinelle transformation
inside a particular function. For example, in finding
conversions of hashcmp() to oidcmp(), we should not convert
the call in oidcmp() itself, since that would cause infinite
recursion. We write that like this:

  @@
  identifier f != oidcmp;
  expression E1, E2;
  @@
    f(...) {...
  - hashcmp(E1->hash, E2->hash)
  + oidcmp(E1, E2)
    ...}

to match the interior of any function _except_ oidcmp().

Unfortunately, this doesn't catch all cases (e.g., the one
in sequencer.c that this patch fixes). The problem, as
explained by one of the Coccinelle developers in [1], is:

  For transformation, A ... B requires that B occur on every
  execution path starting with A, unless that execution path
  ends up in error handling code.  (eg, if (...) { ...
  return; }).  Here your A is the start of the function.  So
  you need a call to hashcmp on every path through the
  function, which fails when you add ifs.

  [...]

  Another issue with A ... B is that by default A and B
  should not appear in the matched region.  So your original
  rule matches only the case where every execution path
  contains exactly one call to hashcmp, not more than one.

One way to solve this is to put the pattern inside an
angle-bracket pattern like "<... P ...>", which allows zero
or more matches of P. That works (and is what this patch
does), but it has one drawback: it matches more than we care
about, and Coccinelle uses extra CPU. Here are timings for
"make coccicheck" before and after this patch:

  [before]
  real	1m27.122s
  user	7m34.451s
  sys	0m37.330s

  [after]
  real	2m18.040s
  user	10m58.310s
  sys	0m41.549s

That's not ideal, but it's more important for this to be
correct than to be fast. And coccicheck is already fairly
slow (and people don't run it for every single patch). So
it's an acceptable tradeoff.

There _is_ a better way to do it, which is to record the
position at which we find hashcmp(), and then check it
against the forbidden function list. Like:

  @@
  position p : script:python() { p[0].current_element != "oidcmp" };
  expression E1,E2;
  @@
  - hashcmp@p(E1->hash, E2->hash)
  + oidcmp(E1, E2)

This is only a little slower than the current code, and does
the right thing in all cases. Unfortunately, not all builds
of Coccinelle include python support (including the ones in
Debian). Requiring it may mean that fewer people can easily
run the tool, which is worse than it simply being a little
slower.

We may want to revisit this decision in the future if:

  - builds with python become more common

  - we find more uses for python support that tip the
    cost-benefit analysis

But for now this patch sticks with the angle-bracket
solution, and converts all existing cocci patches. This
fixes only one missed case in the current code, though it
makes a much better difference for some new rules I'm adding
(converting "!hashcmp()" to "hasheq()" misses over half the
possible conversions using the old form).

[1] https://public-inbox.org/git/alpine.DEB.2.21.1808240652370.2344@hadrien/

Helped-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/coccinelle/commit.cocci    |  4 ++--
 contrib/coccinelle/object_id.cocci | 20 ++++++++++----------
 sequencer.c                        |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/contrib/coccinelle/commit.cocci b/contrib/coccinelle/commit.cocci
index aec3345adb..c49aa558f0 100644
--- a/contrib/coccinelle/commit.cocci
+++ b/contrib/coccinelle/commit.cocci
@@ -15,10 +15,10 @@ expression c;
 identifier f !~ "^(get_commit_tree|get_commit_tree_in_graph_one|load_tree_for_commit)$";
 expression c;
 @@
-  f(...) {...
+  f(...) {<...
 - c->maybe_tree
 + get_commit_tree(c)
-  ...}
+  ...>}
 
 @@
 expression c;
diff --git a/contrib/coccinelle/object_id.cocci b/contrib/coccinelle/object_id.cocci
index 09afdbf994..5869979be7 100644
--- a/contrib/coccinelle/object_id.cocci
+++ b/contrib/coccinelle/object_id.cocci
@@ -20,10 +20,10 @@ expression E1;
 identifier f != oid_to_hex;
 expression E1;
 @@
-  f(...) {...
+  f(...) {<...
 - sha1_to_hex(E1->hash)
 + oid_to_hex(E1)
-  ...}
+  ...>}
 
 @@
 expression E1, E2;
@@ -35,10 +35,10 @@ expression E1, E2;
 identifier f != oid_to_hex_r;
 expression E1, E2;
 @@
-   f(...) {...
+   f(...) {<...
 - sha1_to_hex_r(E1, E2->hash)
 + oid_to_hex_r(E1, E2)
-  ...}
+  ...>}
 
 @@
 expression E1;
@@ -50,10 +50,10 @@ expression E1;
 identifier f != oidclr;
 expression E1;
 @@
-  f(...) {...
+  f(...) {<...
 - hashclr(E1->hash)
 + oidclr(E1)
-  ...}
+  ...>}
 
 @@
 expression E1, E2;
@@ -65,10 +65,10 @@ expression E1, E2;
 identifier f != oidcmp;
 expression E1, E2;
 @@
-  f(...) {...
+  f(...) {<...
 - hashcmp(E1->hash, E2->hash)
 + oidcmp(E1, E2)
-  ...}
+  ...>}
 
 @@
 expression E1, E2;
@@ -92,10 +92,10 @@ expression E1, E2;
 identifier f != oidcpy;
 expression E1, E2;
 @@
-  f(...) {...
+  f(...) {<...
 - hashcpy(E1->hash, E2->hash)
 + oidcpy(E1, E2)
-  ...}
+  ...>}
 
 @@
 expression E1, E2;
diff --git a/sequencer.c b/sequencer.c
index 84bf598c3e..305de743a0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4545,7 +4545,7 @@ int skip_unnecessary_picks(void)
 		if (item->commit->parents->next)
 			break; /* merge commit */
 		parent_oid = &item->commit->parents->item->object.oid;
-		if (hashcmp(parent_oid->hash, oid->hash))
+		if (oidcmp(parent_oid, oid))
 			break;
 		oid = &item->commit->object.oid;
 	}
-- 
2.19.0.rc0.584.g84d5b2a847

