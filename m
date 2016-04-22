From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 5/6] tree-walk: convert tree_entry_extract to struct object_id
Date: Fri, 22 Apr 2016 22:02:52 +0000
Message-ID: <20160422220253.839970-6-sandals@crustytoothpaste.net>
References: <20160422220253.839970-1-sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 00:03:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atjAk-0000rb-Pz
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 00:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091AbcDVWD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 18:03:26 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:56148 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752204AbcDVWDX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2016 18:03:23 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 71E47282AD;
	Fri, 22 Apr 2016 22:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1461362600;
	bh=HECuPxs7qxnUcT+nOuV+ytgPWwePGQRh8xmfre6cH2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cYKHz5X75ZTEqEYmgOB1S/98CYBbxwH3REA+NcX2cD/sz64E+X/z9kVWjTMzB3hzf
	 V0r/GOqhtfaNWygGVH+hiapXWNfy0kMH6Sxw4XQ2bKnViX7wB24GQY8DqEtTRglK6i
	 NODRv7t4HFXFffDmOe0XsNh5oYAv2+XMnGv75v3v0t1u13SHVx550J2EaxSM6OLvpf
	 LBva/HA0RCs9oh2QRUBxf21MsD5r2LGGdp1Fe+yxzfG17qyn5Nkl0VLZKv8nBkBuGK
	 DsQPMkOAcbyDmy1pgBjG+P4HWjGU1A7K1n0ALi7IXVhMNuFdMaROUHCExzxZanTvcE
	 Ev/rlhT7IIhZEAQlYBUxmD1qdNPPcSEfsKYxCnZmpOxhf6sX9mArSaltUgvIl17z/T
	 CXm89faJXqhWJ2fZFirhobl5p0IBmToohs8rV0M9tV+yV6MCjX9RsijvMBvfDmVjV1
	 Kh/EZXIQTmZbETK9H8KfDg7YZfgN3jvhJ7+7z6k7xGC+ITAjmuu
X-Mailer: git-send-email 2.8.1.369.geae769a
In-Reply-To: <20160422220253.839970-1-sandals@crustytoothpaste.net>
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292280>

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 fsck.c        |  6 +++---
 match-trees.c | 12 ++++++------
 tree-diff.c   |  2 +-
 tree-walk.c   | 10 +++++-----
 tree-walk.h   |  4 ++--
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/fsck.c b/fsck.c
index 606eba8c..92b17f5d 100644
--- a/fsck.c
+++ b/fsck.c
@@ -450,11 +450,11 @@ static int fsck_tree(struct tree *item, struct fsck_options *options)
 	while (desc.size) {
 		unsigned mode;
 		const char *name;
-		const unsigned char *sha1;
+		const struct object_id *oid;
 
-		sha1 = tree_entry_extract(&desc, &name, &mode);
+		oid = tree_entry_extract(&desc, &name, &mode);
 
-		has_null_sha1 |= is_null_sha1(sha1);
+		has_null_sha1 |= is_null_oid(oid);
 		has_full_path |= !!strchr(name, '/');
 		has_empty_name |= !*name;
 		has_dot |= !strcmp(name, ".");
diff --git a/match-trees.c b/match-trees.c
index 751f8f20..8ca7c68f 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -131,14 +131,14 @@ static void match_trees(const unsigned char *hash1,
 
 	while (one.size) {
 		const char *path;
-		const unsigned char *elem;
+		const struct object_id *elem;
 		unsigned mode;
 		int score;
 
 		elem = tree_entry_extract(&one, &path, &mode);
 		if (!S_ISDIR(mode))
 			goto next;
-		score = score_trees(elem, hash2);
+		score = score_trees(elem->hash, hash2);
 		if (*best_score < score) {
 			free(*best_match);
 			*best_match = xstrfmt("%s%s", base, path);
@@ -146,7 +146,7 @@ static void match_trees(const unsigned char *hash1,
 		}
 		if (recurse_limit) {
 			char *newbase = xstrfmt("%s%s/", base, path);
-			match_trees(elem, hash2, best_score, best_match,
+			match_trees(elem->hash, hash2, best_score, best_match,
 				    newbase, recurse_limit - 1);
 			free(newbase);
 		}
@@ -191,15 +191,15 @@ static int splice_tree(const unsigned char *hash1,
 	while (desc.size) {
 		const char *name;
 		unsigned mode;
-		const unsigned char *sha1;
+		const struct object_id *oid;
 
-		sha1 = tree_entry_extract(&desc, &name, &mode);
+		oid = tree_entry_extract(&desc, &name, &mode);
 		if (strlen(name) == toplen &&
 		    !memcmp(name, prefix, toplen)) {
 			if (!S_ISDIR(mode))
 				die("entry %s in tree %s is not a tree",
 				    name, sha1_to_hex(hash1));
-			rewrite_here = (unsigned char *) sha1;
+			rewrite_here = (unsigned char *) oid->hash;
 			break;
 		}
 		update_tree_entry(&desc);
diff --git a/tree-diff.c b/tree-diff.c
index 402f9ff2..ff4e0d3c 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -183,7 +183,7 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 
 	if (t) {
 		/* path present in resulting tree */
-		sha1 = tree_entry_extract(t, &path, &mode);
+		sha1 = tree_entry_extract(t, &path, &mode)->hash;
 		pathlen = tree_entry_len(&t->entry);
 		isdir = S_ISDIR(mode);
 	} else {
diff --git a/tree-walk.c b/tree-walk.c
index fab57dd5..ce278424 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -433,10 +433,10 @@ static int find_tree_entry(struct tree_desc *t, const char *name, unsigned char
 	int namelen = strlen(name);
 	while (t->size) {
 		const char *entry;
-		const unsigned char *sha1;
+		const struct object_id *oid;
 		int entrylen, cmp;
 
-		sha1 = tree_entry_extract(t, &entry, mode);
+		oid = tree_entry_extract(t, &entry, mode);
 		entrylen = tree_entry_len(&t->entry);
 		update_tree_entry(t);
 		if (entrylen > namelen)
@@ -447,7 +447,7 @@ static int find_tree_entry(struct tree_desc *t, const char *name, unsigned char
 		if (cmp < 0)
 			break;
 		if (entrylen == namelen) {
-			hashcpy(result, sha1);
+			hashcpy(result, oid->hash);
 			return 0;
 		}
 		if (name[entrylen] != '/')
@@ -455,10 +455,10 @@ static int find_tree_entry(struct tree_desc *t, const char *name, unsigned char
 		if (!S_ISDIR(*mode))
 			break;
 		if (++entrylen == namelen) {
-			hashcpy(result, sha1);
+			hashcpy(result, oid->hash);
 			return 0;
 		}
-		return get_tree_entry(sha1, name + entrylen, result, mode);
+		return get_tree_entry(oid->hash, name + entrylen, result, mode);
 	}
 	return -1;
 }
diff --git a/tree-walk.h b/tree-walk.h
index 58f31f55..97a7d695 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -13,11 +13,11 @@ struct tree_desc {
 	unsigned int size;
 };
 
-static inline const unsigned char *tree_entry_extract(struct tree_desc *desc, const char **pathp, unsigned int *modep)
+static inline const struct object_id *tree_entry_extract(struct tree_desc *desc, const char **pathp, unsigned int *modep)
 {
 	*pathp = desc->entry.path;
 	*modep = desc->entry.mode;
-	return desc->entry.oid->hash;
+	return desc->entry.oid;
 }
 
 static inline int tree_entry_len(const struct name_entry *ne)
-- 
2.8.1.369.geae769a
