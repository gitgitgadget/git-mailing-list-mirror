From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 35/56] remote: rewrite functions to take object_id arguments
Date: Mon, 25 May 2015 18:39:01 +0000
Message-ID: <1432579162-411464-36-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:41:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxJz-0001g0-Ey
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbbEYSlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:41:49 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50705 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751316AbbEYSkX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:23 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4F9782809F;
	Mon, 25 May 2015 18:40:22 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269886>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 remote.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/remote.c b/remote.c
index 6d66ec1..1623eae 100644
--- a/remote.c
+++ b/remote.c
@@ -2024,7 +2024,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 	return 1;
 }
 
-static int one_local_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int one_local_ref(const char *refname, const struct object_id *oid,
+			 int flag, void *cb_data)
 {
 	struct ref ***local_tail = cb_data;
 	struct ref *ref;
@@ -2036,7 +2037,7 @@ static int one_local_ref(const char *refname, const unsigned char *sha1, int fla
 
 	len = strlen(refname) + 1;
 	ref = xcalloc(1, sizeof(*ref) + len);
-	hashcpy(ref->new_sha1, sha1);
+	hashcpy(ref->new_sha1, oid->hash);
 	memcpy(ref->name, refname, len);
 	**local_tail = ref;
 	*local_tail = &ref->next;
@@ -2046,10 +2047,8 @@ static int one_local_ref(const char *refname, const unsigned char *sha1, int fla
 struct ref *get_local_heads(void)
 {
 	struct ref *local_refs = NULL, **local_tail = &local_refs;
-	struct each_ref_fn_sha1_adapter wrapped_one_local_ref =
-		{one_local_ref, &local_tail};
 
-	for_each_ref(each_ref_fn_adapter, &wrapped_one_local_ref);
+	for_each_ref(one_local_ref, &local_tail);
 	return local_refs;
 }
 
@@ -2101,8 +2100,8 @@ struct stale_heads_info {
 	int ref_count;
 };
 
-static int get_stale_heads_cb(const char *refname,
-	const unsigned char *sha1, int flags, void *cb_data)
+static int get_stale_heads_cb(const char *refname, const struct object_id *oid,
+			      int flags, void *cb_data)
 {
 	struct stale_heads_info *info = cb_data;
 	struct string_list matches = STRING_LIST_INIT_DUP;
@@ -2131,7 +2130,7 @@ static int get_stale_heads_cb(const char *refname,
 
 	if (stale) {
 		struct ref *ref = make_linked_ref(refname, &info->stale_refs_tail);
-		hashcpy(ref->new_sha1, sha1);
+		hashcpy(ref->new_sha1, oid->hash);
 	}
 
 clean_exit:
@@ -2144,8 +2143,6 @@ struct ref *get_stale_heads(struct refspec *refs, int ref_count, struct ref *fet
 	struct ref *ref, *stale_refs = NULL;
 	struct string_list ref_names = STRING_LIST_INIT_NODUP;
 	struct stale_heads_info info;
-	struct each_ref_fn_sha1_adapter wrapped_get_stale_heads_cb =
-		{get_stale_heads_cb, &info};
 
 	info.ref_names = &ref_names;
 	info.stale_refs_tail = &stale_refs;
@@ -2154,7 +2151,7 @@ struct ref *get_stale_heads(struct refspec *refs, int ref_count, struct ref *fet
 	for (ref = fetch_map; ref; ref = ref->next)
 		string_list_append(&ref_names, ref->name);
 	string_list_sort(&ref_names);
-	for_each_ref(each_ref_fn_adapter, &wrapped_get_stale_heads_cb);
+	for_each_ref(get_stale_heads_cb, &info);
 	string_list_clear(&ref_names, 0);
 	return stale_refs;
 }
-- 
2.4.0
