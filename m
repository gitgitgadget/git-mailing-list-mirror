Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B08A1F404
	for <e@80x24.org>; Mon, 12 Mar 2018 02:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932656AbeCLC3M (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 22:29:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34484 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932608AbeCLC2y (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Mar 2018 22:28:54 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B550A610E6;
        Mon, 12 Mar 2018 02:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1520821733;
        bh=ZEKChyW7zH2V4bmfOuH2gzn0iqQCx2z5M87UV2NAygI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=urnmsWlyrdymh4fmAqlgusWVRLb2V54Y9qHdMQUiV/ZGvopL8cj5fBgQUBWTS0fm8
         +TPydwX+8eTERiQbmTKCLaQ6UKZ/fDPbVaa+KdIBOIHwsx3JfRVE8YQSo+MWxFghAu
         s5cqlt2AAzxTl+1V+AvqbSuG4y+9rNS0Ba4r3W6E4B6NVJZDhw0UmC4YTDCx5lZMGP
         6QLkojyUik/xRjj9sDLA9KM/rLa/5lcBzUY4xA1gkFAVwVuCmD7kNFlzxbQLpEG2zr
         TERdx7tWwGDhc0YCmgtqiys9QIMHLGprwoh0b5pf3Fw4WWVA/gnqVVj6e5c59Scq4T
         NuGvXuGzUEYaw13Bg8kc91M7Q0bKQUEY+AZUZLXrgQmuc4Fh248zq/H8Tz/Kqm++ob
         cSl6vUhO54QSJxQQCwVoPkImvD5fRtU+A6veBFHMN1XlfdO6LEsJfoBiTYwG6rCBDg
         aCpVWkIv2trotCRWiwCannRKkICAQnLYd/ZSYYYKrLhXB43TJVS
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 32/36] sha1_file: convert read_object_with_reference to object_id
Date:   Mon, 12 Mar 2018 02:27:52 +0000
Message-Id: <20180312022756.483934-33-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.660.g709887971b
In-Reply-To: <20180312022756.483934-1-sandals@crustytoothpaste.net>
References: <20180312022756.483934-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert read_object_with_reference to take pointers to struct object_id.
Update the internals of the function accordingly.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/cat-file.c     |  2 +-
 builtin/grep.c         |  4 ++--
 builtin/pack-objects.c |  2 +-
 cache.h                |  4 ++--
 fast-import.c          | 15 ++++++++-------
 sha1_file.c            | 20 ++++++++++----------
 tree-walk.c            |  9 ++++-----
 7 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 27f4f235f6..4382b4447e 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -159,7 +159,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			 * fall-back to the usual case.
 			 */
 		}
-		buf = read_object_with_reference(oid.hash, exp_type, &size, NULL);
+		buf = read_object_with_reference(&oid, exp_type, &size, NULL);
 		break;
 
 	default:
diff --git a/builtin/grep.c b/builtin/grep.c
index 9a0973e8f1..386a86b66e 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -452,7 +452,7 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 		object = parse_object_or_die(oid, oid_to_hex(oid));
 
 		grep_read_lock();
-		data = read_object_with_reference(object->oid.hash, tree_type,
+		data = read_object_with_reference(&object->oid, tree_type,
 						  &size, NULL);
 		grep_read_unlock();
 
@@ -614,7 +614,7 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		int hit, len;
 
 		grep_read_lock();
-		data = read_object_with_reference(obj->oid.hash, tree_type,
+		data = read_object_with_reference(&obj->oid, tree_type,
 						  &size, NULL);
 		grep_read_unlock();
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 66bc0057fe..a0ccbf6699 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1351,7 +1351,7 @@ static void add_preferred_base(struct object_id *oid)
 	if (window <= num_preferred_base++)
 		return;
 
-	data = read_object_with_reference(oid->hash, tree_type, &size, tree_oid.hash);
+	data = read_object_with_reference(oid, tree_type, &size, &tree_oid);
 	if (!data)
 		return;
 
diff --git a/cache.h b/cache.h
index 66f41af56e..9293c14564 100644
--- a/cache.h
+++ b/cache.h
@@ -1431,10 +1431,10 @@ extern int df_name_compare(const char *name1, int len1, int mode1, const char *n
 extern int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
 extern int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
 
-extern void *read_object_with_reference(const unsigned char *sha1,
+extern void *read_object_with_reference(const struct object_id *oid,
 					const char *required_type,
 					unsigned long *size,
-					unsigned char *sha1_ret);
+					struct object_id *oid_ret);
 
 extern struct object *peel_to_type(const char *name, int namelen,
 				   struct object *o, enum object_type);
diff --git a/fast-import.c b/fast-import.c
index af3a211ec3..dc63af1eb6 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2583,8 +2583,9 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 		oidcpy(&commit_oid, &commit_oe->idx.oid);
 	} else if (!get_oid(p, &commit_oid)) {
 		unsigned long size;
-		char *buf = read_object_with_reference(commit_oid.hash,
-			commit_type, &size, commit_oid.hash);
+		char *buf = read_object_with_reference(&commit_oid,
+						       commit_type, &size,
+						       &commit_oid);
 		if (!buf || size < 46)
 			die("Not a valid commit: %s", p);
 		free(buf);
@@ -2653,9 +2654,8 @@ static void parse_from_existing(struct branch *b)
 		unsigned long size;
 		char *buf;
 
-		buf = read_object_with_reference(b->oid.hash,
-						 commit_type, &size,
-						 b->oid.hash);
+		buf = read_object_with_reference(&b->oid, commit_type, &size,
+						 &b->oid);
 		parse_from_commit(b, buf, size);
 		free(buf);
 	}
@@ -2732,8 +2732,9 @@ static struct hash_list *parse_merge(unsigned int *count)
 			oidcpy(&n->oid, &oe->idx.oid);
 		} else if (!get_oid(from, &n->oid)) {
 			unsigned long size;
-			char *buf = read_object_with_reference(n->oid.hash,
-				commit_type, &size, n->oid.hash);
+			char *buf = read_object_with_reference(&n->oid,
+							       commit_type,
+							       &size, &n->oid);
 			if (!buf || size < 46)
 				die("Not a valid commit: %s", from);
 			free(buf);
diff --git a/sha1_file.c b/sha1_file.c
index e1292c11fd..e2b8e7694e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1399,29 +1399,29 @@ void *read_sha1_file_extended(const unsigned char *sha1,
 	return NULL;
 }
 
-void *read_object_with_reference(const unsigned char *sha1,
+void *read_object_with_reference(const struct object_id *oid,
 				 const char *required_type_name,
 				 unsigned long *size,
-				 unsigned char *actual_sha1_return)
+				 struct object_id *actual_oid_return)
 {
 	enum object_type type, required_type;
 	void *buffer;
 	unsigned long isize;
-	unsigned char actual_sha1[20];
+	struct object_id actual_oid;
 
 	required_type = type_from_string(required_type_name);
-	hashcpy(actual_sha1, sha1);
+	oidcpy(&actual_oid, oid);
 	while (1) {
 		int ref_length = -1;
 		const char *ref_type = NULL;
 
-		buffer = read_sha1_file(actual_sha1, &type, &isize);
+		buffer = read_sha1_file(actual_oid.hash, &type, &isize);
 		if (!buffer)
 			return NULL;
 		if (type == required_type) {
 			*size = isize;
-			if (actual_sha1_return)
-				hashcpy(actual_sha1_return, actual_sha1);
+			if (actual_oid_return)
+				oidcpy(actual_oid_return, &actual_oid);
 			return buffer;
 		}
 		/* Handle references */
@@ -1435,15 +1435,15 @@ void *read_object_with_reference(const unsigned char *sha1,
 		}
 		ref_length = strlen(ref_type);
 
-		if (ref_length + 40 > isize ||
+		if (ref_length + GIT_SHA1_HEXSZ > isize ||
 		    memcmp(buffer, ref_type, ref_length) ||
-		    get_sha1_hex((char *) buffer + ref_length, actual_sha1)) {
+		    get_oid_hex((char *) buffer + ref_length, &actual_oid)) {
 			free(buffer);
 			return NULL;
 		}
 		free(buffer);
 		/* Now we have the ID of the referred-to object in
-		 * actual_sha1.  Check again. */
+		 * actual_oid.  Check again. */
 	}
 }
 
diff --git a/tree-walk.c b/tree-walk.c
index a60837c491..b7e504070c 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -84,8 +84,7 @@ void *fill_tree_descriptor(struct tree_desc *desc, const struct object_id *oid)
 	void *buf = NULL;
 
 	if (oid) {
-		buf = read_object_with_reference(oid->hash, tree_type, &size,
-						 NULL);
+		buf = read_object_with_reference(oid, tree_type, &size, NULL);
 		if (!buf)
 			die("unable to read tree %s", oid_to_hex(oid));
 	}
@@ -534,7 +533,7 @@ int get_tree_entry(const struct object_id *tree_oid, const char *name, struct ob
 	unsigned long size;
 	struct object_id root;
 
-	tree = read_object_with_reference(tree_oid->hash, tree_type, &size, root.hash);
+	tree = read_object_with_reference(tree_oid, tree_type, &size, &root);
 	if (!tree)
 		return -1;
 
@@ -601,9 +600,9 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(unsigned char *tree_s
 			void *tree;
 			struct object_id root;
 			unsigned long size;
-			tree = read_object_with_reference(current_tree_oid.hash,
+			tree = read_object_with_reference(&current_tree_oid,
 							  tree_type, &size,
-							  root.hash);
+							  &root);
 			if (!tree)
 				goto done;
 
