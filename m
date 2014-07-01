From: David Turner <dturner@twopensource.com>
Subject: [PATCH 2/3] test-dump-cache-tree: Improve output format and exit code
Date: Mon, 30 Jun 2014 17:13:16 -0700
Message-ID: <1404173597-24713-2-git-send-email-dturner@twitter.com>
References: <1404173597-24713-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 02:13:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1lhe-0007mU-Tp
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 02:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756836AbaGAANj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 20:13:39 -0400
Received: from mail-qc0-f178.google.com ([209.85.216.178]:36586 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091AbaGAANi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 20:13:38 -0400
Received: by mail-qc0-f178.google.com with SMTP id c9so7619557qcz.23
        for <git@vger.kernel.org>; Mon, 30 Jun 2014 17:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xd/AwoP/8aeipmYCtRDiyokAsnyXv05QKQF7kgGdkTs=;
        b=b1fDGVj8V/SfxX6mz+/Vqdl6alocJYJDHhxmcOz0GjwunGuuQDonFJ3eb6PTkzAgJK
         TzY55jbEqMmvW1YeMKLCYQbz6dQ1y4dzCtbOWAWyC0ETiWpQSlujRF16HeYpGoh9Z8H1
         6xEcmXmVhMA5JzyZBY0lVEWI/kOS57SD2FoULFXP1YoLBe2AJh5vQmCrfxnQXtkrW4TO
         UJX9HIVijF1pbHvJD1iEU9bTvectObL3sUut/MwviuvrovroY1XtIPXaWLDrtxHOHFN6
         GAICXNwisNXEV4TPZhqkFXio+7zkCUtjDK8Cigzw4eIm8IcPUlbkXoYfhJLGGN67bhAO
         R1pg==
X-Gm-Message-State: ALoCoQklPeO/crMG0WlqSQf3+rTYIBNlD71wLuJYEHqPASDA7e8/CQUTBJWoR2m/+j8sDry9pgAy
X-Received: by 10.140.23.134 with SMTP id 6mr64413527qgp.84.1404173617438;
        Mon, 30 Jun 2014 17:13:37 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.197.27])
        by mx.google.com with ESMTPSA id p3sm316651qga.33.2014.06.30.17.13.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Jun 2014 17:13:36 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.390.gcb682f8
In-Reply-To: <1404173597-24713-1-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252703>

Make test-dump-cache-tree more useful for testing.  Do not treat known
invalid trees as errors (and do not produce non-zero exit code),
because we can fall back to the non-cache-tree codepath.

Signed-off-by: David Turner <dturner@twitter.com>
---
 t/t0090-cache-tree.sh  | 28 +++++++++++++++++++++++++---
 test-dump-cache-tree.c | 24 ++++++++++++------------
 2 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 7c60675..5383258 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -21,10 +21,13 @@ test_shallow_cache_tree () {
 	cmp_cache_tree expect
 }
 
+# Test that the cache-tree for a given directory is invalid.
+# If no directory is given, check that the root is invalid
 test_invalid_cache_tree () {
-	echo "invalid                                   (0 subtrees)" >expect &&
-	printf "SHA #(ref)  (%d entries, 0 subtrees)\n" $(git ls-files|wc -l) >>expect &&
-	cmp_cache_tree expect
+	test-dump-cache-tree >actual &&
+	sed -e "s/$_x40/SHA/" -e "s/[0-9]* subtrees//g" <actual >filtered &&
+	expect=$(printf "invalid                                  $1 ()\n") &&
+	fgrep "$expect" filtered
 }
 
 test_no_cache_tree () {
@@ -49,6 +52,25 @@ test_expect_success 'git-add invalidates cache-tree' '
 	test_invalid_cache_tree
 '
 
+test_expect_success 'git-add in subdir invalidates cache-tree' '
+	test_when_finished "git reset --hard; git read-tree HEAD" &&
+	mkdir dirx &&
+	echo "I changed this file" > dirx/foo &&
+	git add dirx/foo &&
+	test_invalid_cache_tree
+'
+
+test_expect_success 'git-add in subdir does not invalidate sibling cache-tree' '
+	git tag no-children
+	test_when_finished "git reset --hard no-children; git read-tree HEAD" &&
+	mkdir dir1 dir2 &&
+	test_commit dir1/a &&
+	test_commit dir2/b &&
+	echo "I changed this file" > dir1/a &&
+	git add dir1/a &&
+	test_invalid_cache_tree dir1/
+'
+
 test_expect_success 'update-index invalidates cache-tree' '
 	test_when_finished "git reset --hard; git read-tree HEAD" &&
 	echo "I changed this file" > foo &&
diff --git a/test-dump-cache-tree.c b/test-dump-cache-tree.c
index 47eab97..ad42ca1 100644
--- a/test-dump-cache-tree.c
+++ b/test-dump-cache-tree.c
@@ -6,12 +6,12 @@
 static void dump_one(struct cache_tree *it, const char *pfx, const char *x)
 {
 	if (it->entry_count < 0)
-		printf("%-40s %s%s (%d subtrees)\n",
-		       "invalid", x, pfx, it->subtree_nr);
+		printf("%-40s %s (%d subtrees)%s\n",
+		       "invalid", pfx, it->subtree_nr, x);
 	else
-		printf("%s %s%s (%d entries, %d subtrees)\n",
-		       sha1_to_hex(it->sha1), x, pfx,
-		       it->entry_count, it->subtree_nr);
+		printf("%s %s (%d entries, %d subtrees)%s\n",
+		       sha1_to_hex(it->sha1), pfx,
+		       it->entry_count, it->subtree_nr, x);
 }
 
 static int dump_cache_tree(struct cache_tree *it,
@@ -25,19 +25,19 @@ static int dump_cache_tree(struct cache_tree *it,
 		/* missing in either */
 		return 0;
 
-	if (it->entry_count < 0) {
+	if (it->entry_count < 0)
+		/* invalid */
 		dump_one(it, pfx, "");
-		dump_one(ref, pfx, "#(ref) ");
-		if (it->subtree_nr != ref->subtree_nr)
-			errs = 1;
-	}
 	else {
-		dump_one(it, pfx, "");
 		if (hashcmp(it->sha1, ref->sha1) ||
 		    ref->entry_count != it->entry_count ||
 		    ref->subtree_nr != it->subtree_nr) {
-			dump_one(ref, pfx, "#(ref) ");
+			/* claims to be valid but is lying */
+			dump_one(ref, pfx, " #(error)");
 			errs = 1;
+		} else {
+			/* is actually valid */
+			dump_one(it, pfx, "");
 		}
 	}
 
-- 
2.0.0.390.gcb682f8
