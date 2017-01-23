Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2134D20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 18:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751323AbdAWSBT (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 13:01:19 -0500
Received: from 89-28-117-31.starnet.md ([89.28.117.31]:50638 "EHLO
        home.thecybershadow.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbdAWSBI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 13:01:08 -0500
Received: by home.thecybershadow.net (Postfix, from userid 1000)
        id 4340755FC59; Mon, 23 Jan 2017 18:01:05 +0000 (UTC)
From:   Vladimir Panteleev <git@thecybershadow.net>
To:     git@vger.kernel.org
Cc:     Vladimir Panteleev <git@thecybershadow.net>
Subject: [PATCH v3 4/5] show-ref: Detect dangling refs under --verify as well
Date:   Mon, 23 Jan 2017 18:00:58 +0000
Message-Id: <20170123180059.4288-5-git@thecybershadow.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170123180059.4288-1-git@thecybershadow.net>
References: <20170123180059.4288-1-git@thecybershadow.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move detection of dangling refs into show_one, so that they are
detected when --verify is present as well as when it is absent.

Signed-off-by: Vladimir Panteleev <git@thecybershadow.net>
---
 builtin/show-ref.c  | 16 ++++++++--------
 t/t1403-show-ref.sh | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index ab8e0dc41..107d05fe0 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -22,6 +22,14 @@ static void show_one(const char *refname, const struct object_id *oid)
 	const char *hex;
 	struct object_id peeled;
 
+	/* This changes the semantics slightly that even under quiet we
+	 * detect and return error if the repository is corrupt and
+	 * ref points at a nonexistent object.
+	 */
+	if (!has_sha1_file(oid->hash))
+		die("git show-ref: bad ref %s (%s)", refname,
+		    oid_to_hex(oid));
+
 	if (quiet)
 		return;
 
@@ -77,14 +85,6 @@ static int show_ref(const char *refname, const struct object_id *oid,
 match:
 	found_match++;
 
-	/* This changes the semantics slightly that even under quiet we
-	 * detect and return error if the repository is corrupt and
-	 * ref points at a nonexistent object.
-	 */
-	if (!has_sha1_file(oid->hash))
-		die("git show-ref: bad ref %s (%s)", refname,
-		    oid_to_hex(oid));
-
 	show_one(refname, oid);
 
 	return 0;
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index c6872bd96..30354fd26 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -184,4 +184,26 @@ test_expect_success 'show-ref --verify HEAD' '
 	test_cmp expect actual
 '
 
+test_expect_success 'show-ref --verify with dangling ref' '
+	sha1_file() {
+		echo "$*" | sed "s#..#.git/objects/&/#"
+	} &&
+
+	remove_object() {
+		file=$(sha1_file "$*") &&
+		test -e "$file" &&
+		rm -f "$file"
+	} &&
+
+	test_when_finished "rm -rf dangling" &&
+	(
+		git init dangling &&
+		cd dangling &&
+		test_commit dangling &&
+		sha=$(git rev-parse refs/tags/dangling) &&
+		remove_object $sha &&
+		test_must_fail git show-ref --verify refs/tags/dangling
+	)
+'
+
 test_done
-- 
2.11.0

