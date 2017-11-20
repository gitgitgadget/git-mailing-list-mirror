Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79F66202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 20:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbdKTU0q (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 15:26:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:35020 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751173AbdKTU0p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 15:26:45 -0500
Received: (qmail 3929 invoked by uid 109); 20 Nov 2017 20:26:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 20 Nov 2017 20:26:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15816 invoked by uid 111); 20 Nov 2017 20:27:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 20 Nov 2017 15:27:01 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Nov 2017 15:26:43 -0500
Date:   Mon, 20 Nov 2017 15:26:43 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/5] p5550: factor our nonsense-pack creation
Message-ID: <20171120202643.s2cywlqykayq5qdb@sigill.intra.peff.net>
References: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a function to create a bunch of irrelevant packs to
measure the expense of reprepare_packed_git(). Let's make
that available to other perf scripts.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/perf/lib-pack.sh         | 29 +++++++++++++++++++++++++++++
 t/perf/p5550-fetch-tags.sh | 25 ++-----------------------
 2 files changed, 31 insertions(+), 23 deletions(-)
 create mode 100644 t/perf/lib-pack.sh

diff --git a/t/perf/lib-pack.sh b/t/perf/lib-pack.sh
new file mode 100644
index 0000000000..501bb7b272
--- /dev/null
+++ b/t/perf/lib-pack.sh
@@ -0,0 +1,29 @@
+# Helpers for dealing with large numbers of packs.
+
+# create $1 nonsense packs, each with a single blob
+create_packs () {
+	perl -le '
+		my ($n) = @ARGV;
+		for (1..$n) {
+			print "blob";
+			print "data <<EOF";
+			print "$_";
+			print "EOF";
+		}
+	' "$@" |
+	git fast-import &&
+
+	git cat-file --batch-all-objects --batch-check='%(objectname)' |
+	while read sha1
+	do
+		echo $sha1 | git pack-objects .git/objects/pack/pack
+	done
+}
+
+# create a large number of packs, disabling any gc which might
+# cause us to repack them
+setup_many_packs () {
+	git config gc.auto 0 &&
+	git config gc.autopacklimit 0 &&
+	create_packs 500
+}
diff --git a/t/perf/p5550-fetch-tags.sh b/t/perf/p5550-fetch-tags.sh
index a5dc39f86a..d0e0e019ea 100755
--- a/t/perf/p5550-fetch-tags.sh
+++ b/t/perf/p5550-fetch-tags.sh
@@ -20,6 +20,7 @@ start to show a noticeable performance problem on my machine, but without
 taking too long to set up and run the tests.
 '
 . ./perf-lib.sh
+. "$TEST_DIRECTORY/perf/lib-pack.sh"
 
 # make a long nonsense history on branch $1, consisting of $2 commits, each
 # with a unique file pointing to the blob at $2.
@@ -44,26 +45,6 @@ create_tags () {
 	git update-ref --stdin
 }
 
-# create $1 nonsense packs, each with a single blob
-create_packs () {
-	perl -le '
-		my ($n) = @ARGV;
-		for (1..$n) {
-			print "blob";
-			print "data <<EOF";
-			print "$_";
-			print "EOF";
-		}
-	' "$@" |
-	git fast-import &&
-
-	git cat-file --batch-all-objects --batch-check='%(objectname)' |
-	while read sha1
-	do
-		echo $sha1 | git pack-objects .git/objects/pack/pack
-	done
-}
-
 test_expect_success 'create parent and child' '
 	git init parent &&
 	git -C parent commit --allow-empty -m base &&
@@ -84,9 +65,7 @@ test_expect_success 'populate parent tags' '
 test_expect_success 'create child packs' '
 	(
 		cd child &&
-		git config gc.auto 0 &&
-		git config gc.autopacklimit 0 &&
-		create_packs 500
+		setup_many_packs
 	)
 '
 
-- 
2.15.0.494.g79a8547723

