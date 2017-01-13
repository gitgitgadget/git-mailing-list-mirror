Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BAE220756
	for <e@80x24.org>; Fri, 13 Jan 2017 17:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750885AbdAMRyO (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 12:54:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:38918 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750789AbdAMRyO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 12:54:14 -0500
Received: (qmail 5935 invoked by uid 109); 13 Jan 2017 17:54:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Jan 2017 17:54:13 +0000
Received: (qmail 7337 invoked by uid 111); 13 Jan 2017 17:55:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Jan 2017 12:55:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jan 2017 12:54:10 -0500
Date:   Fri, 13 Jan 2017 12:54:10 -0500
From:   Jeff King <peff@peff.net>
To:     John Szakmeister <john@szakmeister.net>
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org
Subject: [PATCH 1/6] t1450: refactor loose-object removal
Message-ID: <20170113175410.qfgpm3ksqa6mkt6j@sigill.intra.peff.net>
References: <20170113175258.e66taigy4wpokohk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170113175258.e66taigy4wpokohk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 90cf590f5 (fsck: optionally show more helpful info
for broken links, 2016-07-17) added a remove_loose_object()
helper, but we already had a remove_object() helper that did
the same thing. Let's combine these into one.

The implementations had a few subtle differences, so I've
tried to take the best of both:

  - the original used "sed", but the newer version avoids
    spawning an extra process

  - the original processed "$*", which was nonsense, as it
    assumed only a single sha1. Use "$1" to make that more
    clear.

  - the newer version ran an extra rev-parse, but it was not
    necessary; it's sole caller already converted the
    argument into a raw sha1

  - the original used "rm -f", whereas the new one uses
    "rm". The latter is better because it may notice a bug
    or other unexpected failure in the test. (The original
    does check that the object exists before we remove it,
    which is good, but that's a subset of the possible
    unexpected conditions).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1450-fsck.sh | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index ee7d4736d..3297d4cb2 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -43,13 +43,13 @@ test_expect_success 'HEAD is part of refs, valid objects appear valid' '
 
 test_expect_success 'setup: helpers for corruption tests' '
 	sha1_file() {
-		echo "$*" | sed "s#..#.git/objects/&/#"
+		remainder=${1#??} &&
+		firsttwo=${1%$remainder} &&
+		echo ".git/objects/$firsttwo/$remainder"
 	} &&
 
 	remove_object() {
-		file=$(sha1_file "$*") &&
-		test -e "$file" &&
-		rm -f "$file"
+		rm "$(sha1_file "$1")"
 	}
 '
 
@@ -535,13 +535,6 @@ test_expect_success 'fsck --connectivity-only' '
 	)
 '
 
-remove_loose_object () {
-	sha1="$(git rev-parse "$1")" &&
-	remainder=${sha1#??} &&
-	firsttwo=${sha1%$remainder} &&
-	rm .git/objects/$firsttwo/$remainder
-}
-
 test_expect_success 'fsck --name-objects' '
 	rm -rf name-objects &&
 	git init name-objects &&
@@ -550,7 +543,7 @@ test_expect_success 'fsck --name-objects' '
 		test_commit julius caesar.t &&
 		test_commit augustus &&
 		test_commit caesar &&
-		remove_loose_object $(git rev-parse julius:caesar.t) &&
+		remove_object $(git rev-parse julius:caesar.t) &&
 		test_must_fail git fsck --name-objects >out &&
 		tree=$(git rev-parse --verify julius:) &&
 		grep "$tree (\(refs/heads/master\|HEAD\)@{[0-9]*}:" out
-- 
2.11.0.629.g10075098c

