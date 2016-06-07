From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 5/8] merge-recursive: convert struct stage_data to use object_id
Date: Tue,  7 Jun 2016 00:57:13 +0000
Message-ID: <20160607005716.69222-6-sandals@crustytoothpaste.net>
References: <20160607005716.69222-2-sandals@crustytoothpaste.net>
Cc: Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 02:58:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA5Ln-0003mx-Ke
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 02:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899AbcFGA63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 20:58:29 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:40752 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751965AbcFGA50 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 20:57:26 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 57F8B282AC;
	Tue,  7 Jun 2016 00:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1465261045;
	bh=yqAQxgJAVwSYJ6RAczZMon5EC/4gy00mhDIrXLEScWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gyb1zzhakKoaI4RwrA0duVQQvT9UZ0PuXja0ZzeQ+II/qqsfVNWgocWHNfHyYA16g
	 oEILHx6tw95Irmgn3YAr3n5sRXcAYKIWb04BNZ66mnxIroyZpP0eTi3SkBGL9ptHLg
	 jhZ4yIDrNNmTliPmy/a3+rnIb1AXY0Zz0EENs0xtmSd84QLhYnog4UQHwUkQ45AA1J
	 Zn1POhyNelRvyN29W1kJB/aPZgC9rR5/oEdJVAzFo57bX1R4wLpQ9KmjAQ4vka7485
	 oIgPP0V9Jb0ko08DpQMfxFv1F8iexr4xntJU0cTPwa5srXhBF6MeJ71Uy4JPQjgzPO
	 Jl+qKhLTprfB/7XhEJ2W0DHgATZOL3fz3uAno6AY4LDS3UvBDi+q2r12KO1p763Tg3
	 WBT64ItFnNXC8G8ONE97yn654Oht+xe8g8cgfbNtXSJSMACXAOMFkdPAF4/8k/xR3n
	 9A76bv1O/YyXwQWEwR8TqGwOzVNuNJquSNg/OXMgIYx4XX+wLju
X-Mailer: git-send-email 2.8.1.369.geae769a
In-Reply-To: <20160607005716.69222-2-sandals@crustytoothpaste.net>
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296588>

Convert the anonymous struct within struct stage_data to use struct
object_id.  The following Coccinelle semantic patch was used to
implement this, followed by the transformations in standard.cocci:

@@
struct stage_data *p;
expression E1;
@@
- p->stages[E1].sha
+ p->stages[E1].oid.hash

@@
struct stage_data o;
expression E1;
@@
- o.stages[E1].sha
+ o.stages[E1].oid.hash

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 merge-recursive.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1e802097..a07050cd 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -90,7 +90,7 @@ struct rename_conflict_info {
 struct stage_data {
 	struct {
 		unsigned mode;
-		unsigned char sha[20];
+		struct object_id oid;
 	} stages[4];
 	struct rename_conflict_info *rename_conflict_info;
 	unsigned processed:1;
@@ -134,13 +134,11 @@ static inline void setup_rename_conflict_info(enum rename_type rename_type,
 		int ostage2 = ostage1 ^ 1;
 
 		ci->ren1_other.path = pair1->one->path;
-		hashcpy(ci->ren1_other.oid.hash,
-			src_entry1->stages[ostage1].sha);
+		oidcpy(&ci->ren1_other.oid, &src_entry1->stages[ostage1].oid);
 		ci->ren1_other.mode = src_entry1->stages[ostage1].mode;
 
 		ci->ren2_other.path = pair2->one->path;
-		hashcpy(ci->ren2_other.oid.hash,
-			src_entry2->stages[ostage2].sha);
+		oidcpy(&ci->ren2_other.oid, &src_entry2->stages[ostage2].oid);
 		ci->ren2_other.mode = src_entry2->stages[ostage2].mode;
 	}
 }
@@ -316,11 +314,11 @@ static struct stage_data *insert_stage_data(const char *path,
 	struct string_list_item *item;
 	struct stage_data *e = xcalloc(1, sizeof(struct stage_data));
 	get_tree_entry(o->object.oid.hash, path,
-			e->stages[1].sha, &e->stages[1].mode);
+			e->stages[1].oid.hash, &e->stages[1].mode);
 	get_tree_entry(a->object.oid.hash, path,
-			e->stages[2].sha, &e->stages[2].mode);
+			e->stages[2].oid.hash, &e->stages[2].mode);
 	get_tree_entry(b->object.oid.hash, path,
-			e->stages[3].sha, &e->stages[3].mode);
+			e->stages[3].oid.hash, &e->stages[3].mode);
 	item = string_list_insert(entries, path);
 	item->util = e;
 	return e;
@@ -351,7 +349,7 @@ static struct string_list *get_unmerged(void)
 		}
 		e = item->util;
 		e->stages[ce_stage(ce)].mode = ce->ce_mode;
-		hashcpy(e->stages[ce_stage(ce)].sha, ce->sha1);
+		hashcpy(e->stages[ce_stage(ce)].oid.hash, ce->sha1);
 	}
 
 	return unmerged;
@@ -574,9 +572,9 @@ static void update_entry(struct stage_data *entry,
 	entry->stages[1].mode = o->mode;
 	entry->stages[2].mode = a->mode;
 	entry->stages[3].mode = b->mode;
-	hashcpy(entry->stages[1].sha, o->oid.hash);
-	hashcpy(entry->stages[2].sha, a->oid.hash);
-	hashcpy(entry->stages[3].sha, b->oid.hash);
+	oidcpy(&entry->stages[1].oid, &o->oid);
+	oidcpy(&entry->stages[2].oid, &a->oid);
+	oidcpy(&entry->stages[3].oid, &b->oid);
 }
 
 static int remove_file(struct merge_options *o, int clean,
@@ -1111,7 +1109,7 @@ static struct diff_filespec *filespec_from_entry(struct diff_filespec *target,
 						 struct stage_data *entry,
 						 int stage)
 {
-	unsigned char *sha = entry->stages[stage].sha;
+	unsigned char *sha = entry->stages[stage].oid.hash;
 	unsigned mode = entry->stages[stage].mode;
 	if (mode == 0 || is_null_sha1(sha))
 		return NULL;
@@ -1425,11 +1423,11 @@ static int process_renames(struct merge_options *o,
 			remove_file(o, 1, ren1_src,
 				    renamed_stage == 2 || !was_tracked(ren1_src));
 
-			hashcpy(src_other.oid.hash,
-				ren1->src_entry->stages[other_stage].sha);
+			oidcpy(&src_other.oid,
+			       &ren1->src_entry->stages[other_stage].oid);
 			src_other.mode = ren1->src_entry->stages[other_stage].mode;
-			hashcpy(dst_other.oid.hash,
-				ren1->dst_entry->stages[other_stage].sha);
+			oidcpy(&dst_other.oid,
+			       &ren1->dst_entry->stages[other_stage].oid);
 			dst_other.mode = ren1->dst_entry->stages[other_stage].mode;
 			try_merge = 0;
 
@@ -1703,9 +1701,9 @@ static int process_entry(struct merge_options *o,
 	unsigned o_mode = entry->stages[1].mode;
 	unsigned a_mode = entry->stages[2].mode;
 	unsigned b_mode = entry->stages[3].mode;
-	unsigned char *o_sha = stage_sha(entry->stages[1].sha, o_mode);
-	unsigned char *a_sha = stage_sha(entry->stages[2].sha, a_mode);
-	unsigned char *b_sha = stage_sha(entry->stages[3].sha, b_mode);
+	unsigned char *o_sha = stage_sha(entry->stages[1].oid.hash, o_mode);
+	unsigned char *a_sha = stage_sha(entry->stages[2].oid.hash, a_mode);
+	unsigned char *b_sha = stage_sha(entry->stages[3].oid.hash, b_mode);
 
 	entry->processed = 1;
 	if (entry->rename_conflict_info) {
