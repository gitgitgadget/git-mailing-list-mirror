Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6791320A10
	for <e@80x24.org>; Sun,  1 Oct 2017 22:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752342AbdJAWJj (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 18:09:39 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54202 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752123AbdJAWJH (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Oct 2017 18:09:07 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4C43160DC5;
        Sun,  1 Oct 2017 22:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1506895746;
        bh=by7n83xBqaf4M9h5ErfWgY83zVSSSLTF+hZXjaZ94Dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KBBgasgfx6KgUEKcKPe2YJvBBgxqn873fYs/aHaq4BTuBm+N/ZqA9uQd4uZPm5MzX
         S2PlgNze/HL4ail64wRESYLm0usP/jSzQCg8e057hmFdTX2geOPUBY8Ruxg0D1S4B+
         YClNtx5vGpTme4okq65H7EmaMAWcSkUIVp+PhBb17I/7x2welTIyD+utUjHQriqQL4
         UTQWkRHCFejVUk6EJhAm0xUzbeEyeUeZaI/wHUNVSXUvN0jbKpRUvX8AqWtGvXLaqd
         W7tjoO0B4qtZwUJF8mg+kgrHErgsubG5D3pnpK8qlda/q2Eq/eS8xI8FP8Mk/yXhjA
         vp0goOyLMbnxBjmUhabGUTxNAc0rvMIQ6/GwwOPoz5itr5zMxqCIU6lI2BIM3AtMF1
         4U2d8I2CIIw+GjGGkE/rIjBZ6uybWtZvpw/Cri4CHxkULuIgI+kb7fuxa92D8ZLI7a
         Alewfjy0jR9gPAfdSBsnMVbKyaLkG4b6VpOCsVASBuqhtTUli3d
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 19/24] refs: convert resolve_gitlink_ref to struct object_id
Date:   Sun,  1 Oct 2017 22:08:26 +0000
Message-Id: <20171001220831.214705-20-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.2.822.g60be5d43e6
In-Reply-To: <20171001220831.214705-1-sandals@crustytoothpaste.net>
References: <20171001220831.214705-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the declaration and definition of resolve_gitlink_ref to use
struct object_id and apply the following semantic patch:

@@
expression E1, E2, E3;
@@
- resolve_gitlink_ref(E1, E2, E3.hash)
+ resolve_gitlink_ref(E1, E2, &E3)

@@
expression E1, E2, E3;
@@
- resolve_gitlink_ref(E1, E2, E3->hash)
+ resolve_gitlink_ref(E1, E2, E3)

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/update-index.c | 4 ++--
 combine-diff.c         | 2 +-
 diff-lib.c             | 2 +-
 dir.c                  | 4 ++--
 read-cache.c           | 2 +-
 refs.c                 | 6 +++---
 refs.h                 | 2 +-
 sha1_file.c            | 2 +-
 unpack-trees.c         | 2 +-
 9 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 24f4b28951..fefbe60167 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -328,7 +328,7 @@ static int process_directory(const char *path, int len, struct stat *st)
 		if (S_ISGITLINK(ce->ce_mode)) {
 
 			/* Do nothing to the index if there is no HEAD! */
-			if (resolve_gitlink_ref(path, "HEAD", oid.hash) < 0)
+			if (resolve_gitlink_ref(path, "HEAD", &oid) < 0)
 				return 0;
 
 			return add_one_path(ce, path, len, st);
@@ -354,7 +354,7 @@ static int process_directory(const char *path, int len, struct stat *st)
 	}
 
 	/* No match - should we add it as a gitlink? */
-	if (!resolve_gitlink_ref(path, "HEAD", oid.hash))
+	if (!resolve_gitlink_ref(path, "HEAD", &oid))
 		return add_one_path(NULL, path, len, st);
 
 	/* Error out. */
diff --git a/combine-diff.c b/combine-diff.c
index 9e163d5ada..82f6070977 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1014,7 +1014,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			elem->mode = canon_mode(st.st_mode);
 		} else if (S_ISDIR(st.st_mode)) {
 			struct object_id oid;
-			if (resolve_gitlink_ref(elem->path, "HEAD", oid.hash) < 0)
+			if (resolve_gitlink_ref(elem->path, "HEAD", &oid) < 0)
 				result = grab_blob(&elem->oid, elem->mode,
 						   &result_size, NULL, NULL);
 			else
diff --git a/diff-lib.c b/diff-lib.c
index af4f1b7865..d2ea02f4d7 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -50,7 +50,7 @@ static int check_removed(const struct cache_entry *ce, struct stat *st)
 		 * a directory --- the blob was removed!
 		 */
 		if (!S_ISGITLINK(ce->ce_mode) &&
-		    resolve_gitlink_ref(ce->name, "HEAD", sub.hash))
+		    resolve_gitlink_ref(ce->name, "HEAD", &sub))
 			return 1;
 	}
 	return 0;
diff --git a/dir.c b/dir.c
index a4198ba7fd..f09a31e102 100644
--- a/dir.c
+++ b/dir.c
@@ -1391,7 +1391,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 			break;
 		if (!(dir->flags & DIR_NO_GITLINKS)) {
 			struct object_id oid;
-			if (resolve_gitlink_ref(dirname, "HEAD", oid.hash) == 0)
+			if (resolve_gitlink_ref(dirname, "HEAD", &oid) == 0)
 				return path_untracked;
 		}
 		return path_recurse;
@@ -2282,7 +2282,7 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 	struct object_id submodule_head;
 
 	if ((flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
-	    !resolve_gitlink_ref(path->buf, "HEAD", submodule_head.hash)) {
+	    !resolve_gitlink_ref(path->buf, "HEAD", &submodule_head)) {
 		/* Do not descend and nuke a nested git work tree. */
 		if (kept_up)
 			*kept_up = 1;
diff --git a/read-cache.c b/read-cache.c
index 131485b3a6..7766196aff 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -201,7 +201,7 @@ static int ce_compare_gitlink(const struct cache_entry *ce)
 	 *
 	 * If so, we consider it always to match.
 	 */
-	if (resolve_gitlink_ref(ce->name, "HEAD", oid.hash) < 0)
+	if (resolve_gitlink_ref(ce->name, "HEAD", &oid) < 0)
 		return 0;
 	return oidcmp(&oid, &ce->oid);
 }
diff --git a/refs.c b/refs.c
index d2fd0d2a69..3329d47d16 100644
--- a/refs.c
+++ b/refs.c
@@ -1477,7 +1477,7 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 }
 
 int resolve_gitlink_ref(const char *submodule, const char *refname,
-			unsigned char *sha1)
+			struct object_id *oid)
 {
 	struct ref_store *refs;
 	int flags;
@@ -1487,8 +1487,8 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
 	if (!refs)
 		return -1;
 
-	if (!refs_resolve_ref_unsafe(refs, refname, 0, sha1, &flags) ||
-	    is_null_sha1(sha1))
+	if (!refs_resolve_ref_unsafe(refs, refname, 0, oid->hash, &flags) ||
+	    is_null_oid(oid))
 		return -1;
 	return 0;
 }
diff --git a/refs.h b/refs.h
index 1bc241424d..bb0dcd97af 100644
--- a/refs.h
+++ b/refs.h
@@ -130,7 +130,7 @@ int peel_ref(const char *refname, struct object_id *oid);
  * otherwise, return a non-zero value.
  */
 int resolve_gitlink_ref(const char *submodule, const char *refname,
-			unsigned char *sha1);
+			struct object_id *oid);
 
 /*
  * Return true iff abbrev_name is a possible abbreviation for
diff --git a/sha1_file.c b/sha1_file.c
index 793fd2d194..f8c82ce2a2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1832,7 +1832,7 @@ int index_path(struct object_id *oid, const char *path, struct stat *st, unsigne
 		strbuf_release(&sb);
 		break;
 	case S_IFDIR:
-		return resolve_gitlink_ref(path, "HEAD", oid->hash);
+		return resolve_gitlink_ref(path, "HEAD", oid);
 	default:
 		return error("%s: unsupported file type", path);
 	}
diff --git a/unpack-trees.c b/unpack-trees.c
index 0dc76eddfe..25740cb593 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1542,7 +1542,7 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 
 	if (S_ISGITLINK(ce->ce_mode)) {
 		struct object_id oid;
-		int sub_head = resolve_gitlink_ref(ce->name, "HEAD", oid.hash);
+		int sub_head = resolve_gitlink_ref(ce->name, "HEAD", &oid);
 		/*
 		 * If we are not going to update the submodule, then
 		 * we don't care.
-- 
2.14.2.822.g60be5d43e6

