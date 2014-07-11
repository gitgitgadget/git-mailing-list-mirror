From: David Turner <dturner@twopensource.com>
Subject: [PATCH 1/4 v6] cache-tree: Create/update cache-tree on checkout
Date: Thu, 10 Jul 2014 17:31:23 -0700
Message-ID: <1405038686-1138-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 11 02:31:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5Okk-0002Zz-PX
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 02:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbaGKAbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 20:31:51 -0400
Received: from mail-qc0-f170.google.com ([209.85.216.170]:41781 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbaGKAbu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 20:31:50 -0400
Received: by mail-qc0-f170.google.com with SMTP id c9so349912qcz.15
        for <git@vger.kernel.org>; Thu, 10 Jul 2014 17:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MZN+HqLlnPsF8w2kchNABhp3azNgpWNm8q3eMPKqTRM=;
        b=g1IHcRLLRHzlY67j3XAOype8gyb5cnTQoMJ6Bp7jlzXD5FiXsPk5FKTlzeV93PdE2y
         HYuM82Fbgc9pqMeQZ1fL3uwnbD35ZFr+TlsLx/Bn/dde5cpMukLtbWei+63qlHy08wmB
         Q0pWmt/WMuS2FrhjlUoO2Omre0uy/mofNa2NhnFBlmBleHtZ4GgM4lwGQu2smaBOKvzf
         NZKb0HlSd9Cds6uMU/00QCeb3WhPd+XAKghMwZuXgqN9oUDAbQk80Ne/rhNSEtH6bujY
         LKSMpnLcOplYe8FWm2E26BsKEpMlTQN4okrIkdeiAcD2F4upreFIXiumNwjNmNwnhnCi
         MNdA==
X-Gm-Message-State: ALoCoQmzWLCz17Cfvc0No+2nG+splnT0FtWa5cvFCoOd+DnZuhSpn8sYYA1kIEj6+aS4BeNDHWsy
X-Received: by 10.140.82.134 with SMTP id h6mr83773482qgd.88.1405038709862;
        Thu, 10 Jul 2014 17:31:49 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.197.27])
        by mx.google.com with ESMTPSA id s62sm752254qga.28.2014.07.10.17.31.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jul 2014 17:31:48 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.390.gcb682f8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253242>

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
