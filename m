From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v6 19/45] cache-tree: introduce write_index_as_tree()
Date: Mon, 20 Jul 2015 00:10:11 +0800
Message-ID: <1437322237-29863-20-git-send-email-pyokagan@gmail.com>
References: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 18:13:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGrDQ-000789-SN
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 18:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbbGSQNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 12:13:19 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36708 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938AbbGSQLg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 12:11:36 -0400
Received: by pachj5 with SMTP id hj5so89281928pac.3
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 09:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RaAlGHLA1iUZvq4xNROXLGbvJY5iLq3PsFo5zd3jRVM=;
        b=dDJSamhdGukNH0qol84k4y6kcFADWj4OI6I2TaJNBBAtvMgCQrS5j1YvVbQwFxsHVf
         fdsw750rEZdRUGXIMYmiUVkWjCT7frw3TwQWpST4ZmD7ui/+ZaoLdMyI4OOatyBpjhz+
         PqYbewU+RAXaioy08bFdYumYuBrq/CK4YIQ6IS2DJ0TRz0+8XPKr6dozFqwxWfM9lqma
         Z22H2saFWW/SIRVX4SKQ6A22R+paPBNOahqiv0gAX6ueWnJLJTiS0Tj6QtxGNtt5G0GW
         OEK1vYa6zRTYrQzhJkpRVryD5pkQMgtT9L7obFN1Uj8nIY5R7rHWIG2epl+wbSZMQlny
         IXgQ==
X-Received: by 10.66.165.67 with SMTP id yw3mr49619105pab.95.1437322296301;
        Sun, 19 Jul 2015 09:11:36 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id cq5sm17317869pad.11.2015.07.19.09.11.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 09:11:35 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gb39b692
In-Reply-To: <1437322237-29863-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274268>

A caller may wish to write a temporary index as a tree. However,
write_cache_as_tree() assumes that the index was read from, and will
write to, the default index file path. Introduce write_index_as_tree()
which removes this limitation by allowing the caller to specify its own
index_state and index file path.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 cache-tree.c | 29 +++++++++++++++++------------
 cache-tree.h |  1 +
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 32772b9..feace8b 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -592,7 +592,7 @@ static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *pat
 	return it;
 }
 
-int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
+int write_index_as_tree(unsigned char *sha1, struct index_state *index_state, const char *index_path, int flags, const char *prefix)
 {
 	int entries, was_valid, newfd;
 	struct lock_file *lock_file;
@@ -603,23 +603,23 @@ int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
 	 */
 	lock_file = xcalloc(1, sizeof(struct lock_file));
 
-	newfd = hold_locked_index(lock_file, 1);
+	newfd = hold_lock_file_for_update(lock_file, index_path, LOCK_DIE_ON_ERROR);
 
-	entries = read_cache();
+	entries = read_index_from(index_state, index_path);
 	if (entries < 0)
 		return WRITE_TREE_UNREADABLE_INDEX;
 	if (flags & WRITE_TREE_IGNORE_CACHE_TREE)
-		cache_tree_free(&(active_cache_tree));
+		cache_tree_free(&index_state->cache_tree);
 
-	if (!active_cache_tree)
-		active_cache_tree = cache_tree();
+	if (!index_state->cache_tree)
+		index_state->cache_tree = cache_tree();
 
-	was_valid = cache_tree_fully_valid(active_cache_tree);
+	was_valid = cache_tree_fully_valid(index_state->cache_tree);
 	if (!was_valid) {
-		if (cache_tree_update(&the_index, flags) < 0)
+		if (cache_tree_update(index_state, flags) < 0)
 			return WRITE_TREE_UNMERGED_INDEX;
 		if (0 <= newfd) {
-			if (!write_locked_index(&the_index, lock_file, COMMIT_LOCK))
+			if (!write_locked_index(index_state, lock_file, COMMIT_LOCK))
 				newfd = -1;
 		}
 		/* Not being able to write is fine -- we are only interested
@@ -631,14 +631,14 @@ int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
 	}
 
 	if (prefix) {
-		struct cache_tree *subtree =
-			cache_tree_find(active_cache_tree, prefix);
+		struct cache_tree *subtree;
+		subtree = cache_tree_find(index_state->cache_tree, prefix);
 		if (!subtree)
 			return WRITE_TREE_PREFIX_ERROR;
 		hashcpy(sha1, subtree->sha1);
 	}
 	else
-		hashcpy(sha1, active_cache_tree->sha1);
+		hashcpy(sha1, index_state->cache_tree->sha1);
 
 	if (0 <= newfd)
 		rollback_lock_file(lock_file);
@@ -646,6 +646,11 @@ int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
 	return 0;
 }
 
+int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
+{
+	return write_index_as_tree(sha1, &the_index, get_index_file(), flags, prefix);
+}
+
 static void prime_cache_tree_rec(struct cache_tree *it, struct tree *tree)
 {
 	struct tree_desc desc;
diff --git a/cache-tree.h b/cache-tree.h
index aa7b3e4..41c5746 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -46,6 +46,7 @@ int update_main_cache_tree(int);
 #define WRITE_TREE_UNMERGED_INDEX (-2)
 #define WRITE_TREE_PREFIX_ERROR (-3)
 
+int write_index_as_tree(unsigned char *sha1, struct index_state *index_state, const char *index_path, int flags, const char *prefix);
 int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix);
 void prime_cache_tree(struct index_state *, struct tree *);
 
-- 
2.5.0.rc2.110.gb39b692
