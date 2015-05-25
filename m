From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 12/56] builtin/pack-objects: rewrite to take an object_id argument
Date: Mon, 25 May 2015 18:38:38 +0000
Message-ID: <1432579162-411464-13-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:42:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxKj-00023F-3h
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbbEYSmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:42:39 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50599 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751311AbbEYSkK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:10 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9B01B2809D;
	Mon, 25 May 2015 18:40:09 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269900>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/pack-objects.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 81f0e57..80fe8c7 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -540,11 +540,11 @@ static enum write_one_status write_one(struct sha1file *f,
 	return WRITE_ONE_WRITTEN;
 }
 
-static int mark_tagged(const char *path, const unsigned char *sha1, int flag,
+static int mark_tagged(const char *path, const struct object_id *oid, int flag,
 		       void *cb_data)
 {
 	unsigned char peeled[20];
-	struct object_entry *entry = packlist_find(&to_pack, sha1, NULL);
+	struct object_entry *entry = packlist_find(&to_pack, oid->hash, NULL);
 
 	if (entry)
 		entry->tagged = 1;
@@ -626,8 +626,6 @@ static struct object_entry **compute_write_order(void)
 
 	struct object_entry **wo = xmalloc(to_pack.nr_objects * sizeof(*wo));
 	struct object_entry *objects = to_pack.objects;
-	struct each_ref_fn_sha1_adapter wrapped_mark_tagged =
-		{mark_tagged, NULL};
 
 	for (i = 0; i < to_pack.nr_objects; i++) {
 		objects[i].tagged = 0;
@@ -653,7 +651,7 @@ static struct object_entry **compute_write_order(void)
 	/*
 	 * Mark objects that are at the tip of tags.
 	 */
-	for_each_tag_ref(each_ref_fn_adapter, &wrapped_mark_tagged);
+	for_each_tag_ref(mark_tagged, NULL);
 
 	/*
 	 * Give the objects in the original recency order until
@@ -2099,14 +2097,14 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 #define ll_find_deltas(l, s, w, d, p)	find_deltas(l, &s, w, d, p)
 #endif
 
-static int add_ref_tag(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int add_ref_tag(const char *path, const struct object_id *oid, int flag, void *cb_data)
 {
-	unsigned char peeled[20];
+	struct object_id peeled;
 
 	if (starts_with(path, "refs/tags/") && /* is a tag? */
-	    !peel_ref(path, peeled)        && /* peelable? */
-	    packlist_find(&to_pack, peeled, NULL))      /* object packed? */
-		add_object_entry(sha1, OBJ_TAG, NULL, 0);
+	    !peel_ref(path, peeled.hash)    && /* peelable? */
+	    packlist_find(&to_pack, peeled.hash, NULL))      /* object packed? */
+		add_object_entry(oid->hash, OBJ_TAG, NULL, 0);
 	return 0;
 }
 
@@ -2786,12 +2784,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		argv_array_clear(&rp);
 	}
 	cleanup_preferred_base();
-	if (include_tag && nr_result) {
-		struct each_ref_fn_sha1_adapter wrapped_add_ref_tag =
-			{add_ref_tag, NULL};
-
-		for_each_ref(each_ref_fn_adapter, &wrapped_add_ref_tag);
-	}
+	if (include_tag && nr_result)
+		for_each_ref(add_ref_tag, NULL);
 	stop_progress(&progress_state);
 
 	if (non_empty && !nr_result)
-- 
2.4.0
