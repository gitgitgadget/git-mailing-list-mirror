From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 1/4] cache-tree: Create/update cache-tree on checkout
Date: Mon,  7 Jul 2014 17:33:42 -0700
Message-ID: <1404779625-16972-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 02:34:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4JMK-0007s7-2T
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 02:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755396AbaGHAeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 20:34:08 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:34472 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754015AbaGHAeF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 20:34:05 -0400
Received: by mail-qg0-f46.google.com with SMTP id q107so4188701qgd.19
        for <git@vger.kernel.org>; Mon, 07 Jul 2014 17:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MZN+HqLlnPsF8w2kchNABhp3azNgpWNm8q3eMPKqTRM=;
        b=Kps5jX1ckIUn0QE16jtpY5nNroPyXWbjYAo+y00ZCRgNbVbslOXWOt/nv7zRwew8Im
         OtvYto7I1cOCRsBovUCHl72Cm9i5ivY4WCPquJ9FaltXQaK7tGu0IlUOGVwbNstcp7xB
         6hFMXAuMkJeDkPqpBpuAamW0RoG25tW37OKTZ0qEakxC/XyhXGfRx5U5pt7/L1Q8tkmn
         D6H1emuc4Jxjux9Oanstwp06FfGKyGqOlrSXTr4zDjumfefIWAKX2ZIkWb3xngX/bwxI
         s5J/70w9Vx0PYU5++wY0k5zrjc7iNeRhMkTt2fteY5sbQOOmDvHE1FrokEyRD5Z8jPWo
         +J+A==
X-Gm-Message-State: ALoCoQnxvKdrtBeXpRZorUj7w8jsVawdZ9wIb+XfYE/rF+ODk/+lwLfYZhkLvInTiNdb666HHPQO
X-Received: by 10.140.80.144 with SMTP id c16mr50042185qgd.79.1404779643456;
        Mon, 07 Jul 2014 17:34:03 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.197.27])
        by mx.google.com with ESMTPSA id z14sm77426952qaw.7.2014.07.07.17.34.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Jul 2014 17:34:02 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.390.gcb682f8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252997>

When git checkout checks out a branch, create or update the
cache-tree so that subsequent operations are faster.

update_main_cache_tree learned a new flag, WRITE_TREE_REPAIR.  When
WRITE_TREE_REPAIR is set, portions of the cache-tree which do not
correspond to existing tree objects are invalidated (and portions which
do are marked as valid).  No new tree objects are created.

Signed-off-by: David Turner <dturner@twitter.com>
---
 builtin/checkout.c    |  8 ++++++++
 cache-tree.c          | 12 +++++++++++-
 cache-tree.h          |  1 +
 t/t0090-cache-tree.sh | 19 ++++++++++++++++---
 4 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 07cf555..054214f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -553,6 +553,14 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		}
 	}
 
+	if (!active_cache_tree)
+		active_cache_tree = cache_tree();
+
+	if (!cache_tree_fully_valid(active_cache_tree))
+		cache_tree_update(active_cache_tree,
+				  (const struct cache_entry * const *)active_cache,
+				  active_nr, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
+
 	if (write_cache(newfd, active_cache, active_nr) ||
 	    commit_locked_index(lock_file))
 		die(_("unable to write new index file"));
diff --git a/cache-tree.c b/cache-tree.c
index 7fa524a..f951d7d 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -239,9 +239,12 @@ static int update_one(struct cache_tree *it,
 	struct strbuf buffer;
 	int missing_ok = flags & WRITE_TREE_MISSING_OK;
 	int dryrun = flags & WRITE_TREE_DRY_RUN;
+	int repair = flags & WRITE_TREE_REPAIR;
 	int to_invalidate = 0;
 	int i;
 
+	assert(!(dryrun && repair));
+
 	*skip_count = 0;
 
 	if (0 <= it->entry_count && has_sha1_file(it->sha1))
@@ -374,7 +377,14 @@ static int update_one(struct cache_tree *it,
 #endif
 	}
 
-	if (dryrun)
+	if (repair) {
+		unsigned char sha1[20];
+		hash_sha1_file(buffer.buf, buffer.len, tree_type, sha1);
+		if (has_sha1_file(sha1))
+			hashcpy(it->sha1, sha1);
+		else
+			to_invalidate = 1;
+	} else if (dryrun)
 		hash_sha1_file(buffer.buf, buffer.len, tree_type, it->sha1);
 	else if (write_sha1_file(buffer.buf, buffer.len, tree_type, it->sha1)) {
 		strbuf_release(&buffer);
diff --git a/cache-tree.h b/cache-tree.h
index f1923ad..666d18f 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -39,6 +39,7 @@ int update_main_cache_tree(int);
 #define WRITE_TREE_IGNORE_CACHE_TREE 2
 #define WRITE_TREE_DRY_RUN 4
 #define WRITE_TREE_SILENT 8
+#define WRITE_TREE_REPAIR 16
 
 /* error return codes */
 #define WRITE_TREE_UNREADABLE_INDEX (-1)
diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 6c33e28..98fb1ab 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -44,14 +44,14 @@ test_expect_success 'read-tree HEAD establishes cache-tree' '
 
 test_expect_success 'git-add invalidates cache-tree' '
 	test_when_finished "git reset --hard; git read-tree HEAD" &&
-	echo "I changed this file" > foo &&
+	echo "I changed this file" >foo &&
 	git add foo &&
 	test_invalid_cache_tree
 '
 
 test_expect_success 'update-index invalidates cache-tree' '
 	test_when_finished "git reset --hard; git read-tree HEAD" &&
-	echo "I changed this file" > foo &&
+	echo "I changed this file" >foo &&
 	git update-index --add foo &&
 	test_invalid_cache_tree
 '
@@ -85,9 +85,22 @@ test_expect_success 'reset --hard without index gives cache-tree' '
 	test_shallow_cache_tree
 '
 
-test_expect_failure 'checkout gives cache-tree' '
+test_expect_success 'checkout gives cache-tree' '
+	git tag current &&
 	git checkout HEAD^ &&
 	test_shallow_cache_tree
 '
 
+test_expect_success 'checkout -b gives cache-tree' '
+	git checkout current &&
+	git checkout -b prev HEAD^ &&
+	test_shallow_cache_tree
+'
+
+test_expect_success 'checkout -B gives cache-tree' '
+	git checkout current &&
+	git checkout -B prev HEAD^ &&
+	test_shallow_cache_tree
+'
+
 test_done
-- 
2.0.0.390.gcb682f8
