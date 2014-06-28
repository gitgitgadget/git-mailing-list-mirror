From: David Turner <dturner@twopensource.com>
Subject: [PATCH 2/3] test-dump-cache-tree: Improve output format and exit code
Date: Fri, 27 Jun 2014 17:20:55 -0700
Message-ID: <1403914856-3546-2-git-send-email-dturner@twitter.com>
References: <1403914856-3546-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 28 02:21:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0gOi-0002d1-5X
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jun 2014 02:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566AbaF1AVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 20:21:33 -0400
Received: from mail-qa0-f51.google.com ([209.85.216.51]:61127 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754511AbaF1AVb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 20:21:31 -0400
Received: by mail-qa0-f51.google.com with SMTP id j7so4717376qaq.10
        for <git@vger.kernel.org>; Fri, 27 Jun 2014 17:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xd/AwoP/8aeipmYCtRDiyokAsnyXv05QKQF7kgGdkTs=;
        b=lmmWIFbNA4GOU9EZbvHv+3kirDCjQsr5QfNHKKjgiBiIPVXbNXXAySk2YzzR10GNKj
         3mclDorfiS5nfFG6oZyM9JSGflq+mMdU0vyyB/BiU1Bo0n9kYZX3KfO7rGyL19AlHWch
         diCTAQ4Uo6YNoJbhnkA2bmW1Mt19/+IUvHCZwbK3YB0mfzNkdryPLLkAotOiOh3036nm
         HmFnj8WF54ecTlog6wq64ZbS2/7/epbLFLv4POIIvxitPe63be9TY2yKI+dkENXN36gL
         5dMXwI1znQnsMUXg06k6fBTR67sad8m30ECMJaCy+0yAGnm+bXSSpzOFO5+E7KBFEL8X
         JiMg==
X-Gm-Message-State: ALoCoQmB9gyFh0ypUIOK7IRV5M4yA5Hfp8n57LM5VyV8Ca1eViiJoYisnMFYx2lB7vwya7C/0qHc
X-Received: by 10.224.162.212 with SMTP id w20mr39226419qax.50.1403914891284;
        Fri, 27 Jun 2014 17:21:31 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.197.27])
        by mx.google.com with ESMTPSA id j1sm18940941qaa.11.2014.06.27.17.21.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jun 2014 17:21:30 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.390.gcb682f8
In-Reply-To: <1403914856-3546-1-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252586>

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
