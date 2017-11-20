Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8189A202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 20:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752562AbdKTU2a (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 15:28:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:35028 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752539AbdKTU2a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 15:28:30 -0500
Received: (qmail 4007 invoked by uid 109); 20 Nov 2017 20:28:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 20 Nov 2017 20:28:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15868 invoked by uid 111); 20 Nov 2017 20:28:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 20 Nov 2017 15:28:45 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Nov 2017 15:28:28 -0500
Date:   Mon, 20 Nov 2017 15:28:28 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/5] p5551: add a script to test fetch pack-dir rescans
Message-ID: <20171120202827.xqbqzwkawuli7csv@sigill.intra.peff.net>
References: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since fetch often deals with object-ids we don't have (yet),
it's an easy mistake for it to use a function like
parse_object() that gives the correct result (e.g., NULL)
but does so very slowly (because after failing to find the
object, we re-scan the pack directory looking for new
packs).

The regular test suite won't catch this because the end
result is correct, but we would want to know about
performance regressions, too. Let's add a test to the
regression suite.

Note that this uses a synthetic repository that has a large
number of packs. That's not ideal, as it means we're not
testing what "normal" users see (in fact, some of these
problems have existed for ages without anybody noticing
simply because a rescan on a normal repository just isn't
that expensive).

So what we're really looking for here is the spike you'd
notice in a pathological case (a lot of unknown objects
coming into a repo with a lot of packs). If that's fast,
then the normal cases should be, too.

Note that the test also makes liberal use of $MODERN_GIT for
setup; some of these regressions go back a ways, and we
should be able to use it to find the problems there.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/perf/p5551-fetch-rescan.sh | 55 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100755 t/perf/p5551-fetch-rescan.sh

diff --git a/t/perf/p5551-fetch-rescan.sh b/t/perf/p5551-fetch-rescan.sh
new file mode 100755
index 0000000000..b99dc23e32
--- /dev/null
+++ b/t/perf/p5551-fetch-rescan.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+
+test_description='fetch performance with many packs
+
+It is common for fetch to consider objects that we might not have, and it is an
+easy mistake for the code to use a function like `parse_object` that might
+give the correct _answer_ on such an object, but do so slowly (due to
+re-scanning the pack directory for lookup failures).
+
+The resulting performance drop can be hard to notice in a real repository, but
+becomes quite large in a repository with a large number of packs. So this
+test creates a more pathological case, since any mistakes would produce a more
+noticeable slowdown.
+'
+. ./perf-lib.sh
+. "$TEST_DIRECTORY"/perf/lib-pack.sh
+
+test_expect_success 'create parent and child' '
+	git init parent &&
+	git clone parent child
+'
+
+
+test_expect_success 'create refs in the parent' '
+	(
+		cd parent &&
+		git commit --allow-empty -m foo &&
+		head=$(git rev-parse HEAD) &&
+		test_seq 1000 |
+		sed "s,.*,update refs/heads/& $head," |
+		$MODERN_GIT update-ref --stdin
+	)
+'
+
+test_expect_success 'create many packs in the child' '
+	(
+		cd child &&
+		setup_many_packs
+	)
+'
+
+test_perf 'fetch' '
+	# start at the same state for each iteration
+	obj=$($MODERN_GIT -C parent rev-parse HEAD) &&
+	(
+		cd child &&
+		$MODERN_GIT for-each-ref --format="delete %(refname)" refs/remotes |
+		$MODERN_GIT update-ref --stdin &&
+		rm -vf .git/objects/$(echo $obj | sed "s|^..|&/|") &&
+
+		git fetch
+	)
+'
+
+test_done
-- 
2.15.0.494.g79a8547723

