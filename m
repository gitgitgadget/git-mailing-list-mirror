From: David Turner <dturner@twopensource.com>
Subject: [PATCH v9 1/4] cache-tree: Create/update cache-tree on checkout
Date: Sun, 13 Jul 2014 13:28:16 -0700
Message-ID: <1405283299-25636-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twopensource.com>,
	David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 22:28:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6QO2-00012P-4K
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 22:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbaGMU2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2014 16:28:36 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36555 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbaGMU2e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 16:28:34 -0400
Received: by mail-pa0-f46.google.com with SMTP id eu11so4179298pac.5
        for <git@vger.kernel.org>; Sun, 13 Jul 2014 13:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GZPW8K168b8QUvU2UcYdrLmHWbhfVJK07yVxw1FNE6o=;
        b=kpeik0E5itiDXcR9VXXBF3taqMEaGisHOEIoLEp7bScPESwdklTKBeoAregOq/i80u
         Jm7aKKqxSb/3a2eX7oxr176z6ZXfIQ647FpMhXGapDQ+c6GKlzn9SOalvMoCG2+J2lBH
         WHXDdbBQ48+vAF9LWGNUDQxIvXIB6nTVmRmLbyEK+z1Tcgd0FUIZKXDNkSnsJuaibeZb
         q5vtqwL7ptYbTY987IypXgqLfS0++zVD2tLoTyHARP8pKD+7R6+aI35wdRkqxk9qUIcJ
         Zh6Q1okKyip1DsZ4+chTePi4XlNNwenpCgy4XM7r8gfXuO1MtWcrJB84hArzYvQ+v3Nd
         mrWQ==
X-Gm-Message-State: ALoCoQmd27zexMTeLvdjG8DMFXkZdHOecEw79tSiEmqy755pDX46X8j82Pk9e6/VnvQk2zne7xcI
X-Received: by 10.68.171.131 with SMTP id au3mr2927563pbc.125.1405283314009;
        Sun, 13 Jul 2014 13:28:34 -0700 (PDT)
Received: from stross.twitter.corp (mobile-166-137-185-178.mycingular.net. [166.137.185.178])
        by mx.google.com with ESMTPSA id jb5sm8609217pbd.73.2014.07.13.13.28.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Jul 2014 13:28:32 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.390.gcb682f8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253457>

From: David Turner <dturner@twopensource.com>

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
index 463cfee..4f08554 100644
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
