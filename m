From: David Turner <dturner@twopensource.com>
Subject: [PATCH v8 1/4] cache-tree: Create/update cache-tree on checkout
Date: Fri, 11 Jul 2014 21:44:33 -0700
Message-ID: <1405140276-32162-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 12 06:45:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5pBW-0000DG-Ak
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 06:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbaGLEo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2014 00:44:59 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:51613 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbaGLEo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2014 00:44:59 -0400
Received: by mail-pd0-f170.google.com with SMTP id g10so206638pdj.15
        for <git@vger.kernel.org>; Fri, 11 Jul 2014 21:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MZN+HqLlnPsF8w2kchNABhp3azNgpWNm8q3eMPKqTRM=;
        b=HXICGD6SBhfNAiU5ep8VJllLR8CXauglWZTYLwAUg0m9t0PD7MjCZZoAMTGMd4NT77
         CwniZR2xUYHrtABHmCiAmQTkox6O7klSp1zI2hYnbDWYu8fp3FEpaRr8PE89Uvshn3x8
         HyaGQncjB7us0rWCbmfDvUrt4v+Pj1qejL+tXlgOXktc4Ac9Yh4HuxsTZm6dxoTcupUD
         U2C6hLQXvAOY8D7VbyB9JRb/8s9XN5ue8c/4/qXxWFPMFM7m5s62kJagZqAOlKzQJeB3
         ffD092aMmk7agWVP0aCVd8WYeGNTRTQLAy9V+RfpW6A//QQ4kz4V1hfCsnB9SDTXV9AP
         AMQA==
X-Gm-Message-State: ALoCoQncXlQAsCF2fS0Xp6kaiNqO8BQbM5FJ7hhVkbx+XcjQ3YjTbkXoUCR1Gv3dwlYZswYGjLI6
X-Received: by 10.68.96.194 with SMTP id du2mr2999707pbb.105.1405140298805;
        Fri, 11 Jul 2014 21:44:58 -0700 (PDT)
Received: from stross.twitter.corp (50-206-59-106-static.hfc.comcastbusiness.net. [50.206.59.106])
        by mx.google.com with ESMTPSA id fl6sm16828665pab.43.2014.07.11.21.44.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jul 2014 21:44:57 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.390.gcb682f8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253376>

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
