Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 846CC20A10
	for <e@80x24.org>; Sun,  1 Oct 2017 22:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752351AbdJAWJk (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 18:09:40 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54196 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751926AbdJAWJG (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Oct 2017 18:09:06 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5D2D460DBE;
        Sun,  1 Oct 2017 22:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1506895745;
        bh=vn9j42V/PDDxzSwkRDO8pMGkZFYshW3VwtsQx+rUydY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QsHogGwtIc9jSVx9cDvTLGL4Eauua+t3D9eXXZy0JH9sA5wm4Y00BypPQMZJraA/P
         jchl+KdMoha22jsEPwxfZDLRC0QySGW3D8VPdCw2sdo/Cr2JMEUR//cxCpVzigvin6
         GXa+cT7d0xR3KgzD8JhiGL19RUZeyYvgiPqbmW1Db9+a877M0uBWNbjMQejlKHd9eu
         RZTLAWf9Mfe+bFzSp1o0pspu2p107riKnvTbUBlNsDCgGn4kV9fLAUaxRThYFbCOcq
         uPZUK0JSdUlVAy/iqnTHSP39t7BWJo9nYaSFownAHSX5Vhj7jZOam5z1APxBkWjN0e
         p2UNg/T4ULnN5SPQXKAvI1GU4YKNLXT/6/XF3HYk6aoYNPa0rXQU/ygoHy+Y7or7x3
         Lj48ASgKfRAttETu5RcKQGROhtlRijexLbARZt9dtjOamIDwg47k6utg1T3qqQ7GAW
         TUlXRZTee6WY0eSR/FR2TFWVojLgw01jJNRXufUZ/2NsozPtyqk
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 18/24] Convert remaining callers of resolve_gitlink_ref to object_id
Date:   Sun,  1 Oct 2017 22:08:25 +0000
Message-Id: <20171001220831.214705-19-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.2.822.g60be5d43e6
In-Reply-To: <20171001220831.214705-1-sandals@crustytoothpaste.net>
References: <20171001220831.214705-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 diff-lib.c     | 4 ++--
 dir.c          | 8 ++++----
 read-cache.c   | 6 +++---
 unpack-trees.c | 8 ++++----
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 4e0980caa8..af4f1b7865 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -36,7 +36,7 @@ static int check_removed(const struct cache_entry *ce, struct stat *st)
 	if (has_symlink_leading_path(ce->name, ce_namelen(ce)))
 		return 1;
 	if (S_ISDIR(st->st_mode)) {
-		unsigned char sub[20];
+		struct object_id sub;
 
 		/*
 		 * If ce is already a gitlink, we can have a plain
@@ -50,7 +50,7 @@ static int check_removed(const struct cache_entry *ce, struct stat *st)
 		 * a directory --- the blob was removed!
 		 */
 		if (!S_ISGITLINK(ce->ce_mode) &&
-		    resolve_gitlink_ref(ce->name, "HEAD", sub))
+		    resolve_gitlink_ref(ce->name, "HEAD", sub.hash))
 			return 1;
 	}
 	return 0;
diff --git a/dir.c b/dir.c
index 1d17b800cf..a4198ba7fd 100644
--- a/dir.c
+++ b/dir.c
@@ -1390,8 +1390,8 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 		if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
 			break;
 		if (!(dir->flags & DIR_NO_GITLINKS)) {
-			unsigned char sha1[20];
-			if (resolve_gitlink_ref(dirname, "HEAD", sha1) == 0)
+			struct object_id oid;
+			if (resolve_gitlink_ref(dirname, "HEAD", oid.hash) == 0)
 				return path_untracked;
 		}
 		return path_recurse;
@@ -2279,10 +2279,10 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 	int ret = 0, original_len = path->len, len, kept_down = 0;
 	int only_empty = (flag & REMOVE_DIR_EMPTY_ONLY);
 	int keep_toplevel = (flag & REMOVE_DIR_KEEP_TOPLEVEL);
-	unsigned char submodule_head[20];
+	struct object_id submodule_head;
 
 	if ((flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
-	    !resolve_gitlink_ref(path->buf, "HEAD", submodule_head)) {
+	    !resolve_gitlink_ref(path->buf, "HEAD", submodule_head.hash)) {
 		/* Do not descend and nuke a nested git work tree. */
 		if (kept_up)
 			*kept_up = 1;
diff --git a/read-cache.c b/read-cache.c
index 65f4fe8375..131485b3a6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -191,7 +191,7 @@ static int ce_compare_link(const struct cache_entry *ce, size_t expected_size)
 
 static int ce_compare_gitlink(const struct cache_entry *ce)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 
 	/*
 	 * We don't actually require that the .git directory
@@ -201,9 +201,9 @@ static int ce_compare_gitlink(const struct cache_entry *ce)
 	 *
 	 * If so, we consider it always to match.
 	 */
-	if (resolve_gitlink_ref(ce->name, "HEAD", sha1) < 0)
+	if (resolve_gitlink_ref(ce->name, "HEAD", oid.hash) < 0)
 		return 0;
-	return hashcmp(sha1, ce->oid.hash);
+	return oidcmp(&oid, &ce->oid);
 }
 
 static int ce_modified_check_fs(const struct cache_entry *ce, struct stat *st)
diff --git a/unpack-trees.c b/unpack-trees.c
index 71b70ccb12..0dc76eddfe 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1541,15 +1541,15 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	int cnt = 0;
 
 	if (S_ISGITLINK(ce->ce_mode)) {
-		unsigned char sha1[20];
-		int sub_head = resolve_gitlink_ref(ce->name, "HEAD", sha1);
+		struct object_id oid;
+		int sub_head = resolve_gitlink_ref(ce->name, "HEAD", oid.hash);
 		/*
 		 * If we are not going to update the submodule, then
 		 * we don't care.
 		 */
-		if (!sub_head && !hashcmp(sha1, ce->oid.hash))
+		if (!sub_head && !oidcmp(&oid, &ce->oid))
 			return 0;
-		return verify_clean_submodule(sub_head ? NULL : sha1_to_hex(sha1),
+		return verify_clean_submodule(sub_head ? NULL : oid_to_hex(&oid),
 					      ce, error_type, o);
 	}
 
-- 
2.14.2.822.g60be5d43e6

