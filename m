From: David Turner <dturner@twopensource.com>
Subject: [PATCH 1/3] cache-tree: Create/update cache-tree on checkout
Date: Fri, 27 Jun 2014 17:20:54 -0700
Message-ID: <1403914856-3546-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 28 02:21:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0gOv-0002lf-G0
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jun 2014 02:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632AbaF1AVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 20:21:50 -0400
Received: from mail-qc0-f171.google.com ([209.85.216.171]:48256 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754371AbaF1AVa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 20:21:30 -0400
Received: by mail-qc0-f171.google.com with SMTP id w7so5142374qcr.16
        for <git@vger.kernel.org>; Fri, 27 Jun 2014 17:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FKUlD5phmrQDMxTlxwndxwX1RlyvRv+dIOubzJD8MW0=;
        b=fpSYEf9Tw1rmtoM9f2DrDYyHLl7cSzblZrD+Q64sRQeEJeuq8CVCtE6TythESSsvyo
         1Den5PwlSaaQhXzrrV/4IE9TW6bG2UFGFh0DKPJa1hus0+rgp6Xcw0IK8HgflHrCE/15
         SpVmVCLfv9GjCYQS1iIERVxG6/2FztjTeauGpTwU4fwGPoocrxCk6KHiBQUb4Lsf1aIU
         rfl9UbSJvDv0/WGrj0cZtrtg82zFlwA6oNQvZGWz6f0JjyBZCbCQXd0XBB2U65r7Dl3P
         SiK318NxGiMQzriZnPK6qC5zzEnWHnCzZxOJEw1AnsVJ7sTrwuI7GOY6iYk/UTJ77fxS
         1uIg==
X-Gm-Message-State: ALoCoQmq6SH0+NHmZAE4yCRJ89nvmOJM78Dme6z8smbj9MUPVnYkWndnqqC8yAM+JXgLDjO8k9I2
X-Received: by 10.224.131.74 with SMTP id w10mr39229443qas.100.1403914889214;
        Fri, 27 Jun 2014 17:21:29 -0700 (PDT)
Received: from stross.twitter.corp ([8.25.197.27])
        by mx.google.com with ESMTPSA id j1sm18940941qaa.11.2014.06.27.17.21.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jun 2014 17:21:28 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.390.gcb682f8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252588>

When git checkout checks out a branch, create or update the
cache-tree so that subsequent operations are faster.

Signed-off-by: David Turner <dturner@twitter.com>
---
 builtin/checkout.c    |  4 ++++
 cache-tree.c          | 22 ++++++++++++----------
 cache-tree.h          |  1 +
 t/t0090-cache-tree.sh | 15 ++++++++++++++-
 4 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 07cf555..df791e8 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -553,6 +553,10 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		}
 	}
 
+	if (write_cache_as_tree(NULL, WRITE_TREE_DO_NOT_WRITE, "")) {
+		warn("Unable to write cache_tree");
+	}
+
 	if (write_cache(newfd, active_cache, active_nr) ||
 	    commit_locked_index(lock_file))
 		die(_("unable to write new index file"));
diff --git a/cache-tree.c b/cache-tree.c
index 7fa524a..fb203c6 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -568,17 +568,18 @@ static struct cache_tree *cache_tree_find(struct cache_tree *it, const char *pat
 
 int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
 {
-	int entries, was_valid, newfd;
+	int entries, was_valid, newfd = -1;
 	struct lock_file *lock_file;
 
-	/*
-	 * We can't free this memory, it becomes part of a linked list
-	 * parsed atexit()
-	 */
-	lock_file = xcalloc(1, sizeof(struct lock_file));
-
-	newfd = hold_locked_index(lock_file, 1);
+	if (!(flags & WRITE_TREE_DO_NOT_WRITE)) {
+		/*
+		 * We can't free this memory, it becomes part of a linked list
+		 * parsed atexit()
+		 */
+		lock_file = xcalloc(1, sizeof(struct lock_file));
 
+		newfd = hold_locked_index(lock_file, 1);
+	}
 	entries = read_cache();
 	if (entries < 0)
 		return WRITE_TREE_UNREADABLE_INDEX;
@@ -612,9 +613,10 @@ int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
 			cache_tree_find(active_cache_tree, prefix);
 		if (!subtree)
 			return WRITE_TREE_PREFIX_ERROR;
-		hashcpy(sha1, subtree->sha1);
+		if (sha1)
+			hashcpy(sha1, subtree->sha1);
 	}
-	else
+	else if (sha1)
 		hashcpy(sha1, active_cache_tree->sha1);
 
 	if (0 <= newfd)
diff --git a/cache-tree.h b/cache-tree.h
index f1923ad..daf6640 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -39,6 +39,7 @@ int update_main_cache_tree(int);
 #define WRITE_TREE_IGNORE_CACHE_TREE 2
 #define WRITE_TREE_DRY_RUN 4
 #define WRITE_TREE_SILENT 8
+#define WRITE_TREE_DO_NOT_WRITE 16
 
 /* error return codes */
 #define WRITE_TREE_UNREADABLE_INDEX (-1)
diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 6c33e28..7c60675 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -85,9 +85,22 @@ test_expect_success 'reset --hard without index gives cache-tree' '
 	test_shallow_cache_tree
 '
 
-test_expect_failure 'checkout gives cache-tree' '
+test_expect_success 'checkout gives cache-tree' '
+	git tag current
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
