From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 20/56] builtin/show-branch: rewrite functions to take object_id arguments
Date: Mon, 25 May 2015 18:38:46 +0000
Message-ID: <1432579162-411464-21-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:41:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxJl-0001Zq-PL
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbbEYSk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:40:26 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50602 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751289AbbEYSkO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:14 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9AA9B28099;
	Mon, 25 May 2015 18:40:13 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269881>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/show-branch.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index b06f966..7e00657 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -394,39 +394,42 @@ static int append_ref(const char *refname, const unsigned char *sha1,
 	return 0;
 }
 
-static int append_head_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int append_head_ref(const char *refname, const struct object_id *oid,
+			   int flag, void *cb_data)
 {
-	unsigned char tmp[20];
+	struct object_id tmp;
 	int ofs = 11;
 	if (!starts_with(refname, "refs/heads/"))
 		return 0;
 	/* If both heads/foo and tags/foo exists, get_sha1 would
 	 * get confused.
 	 */
-	if (get_sha1(refname + ofs, tmp) || hashcmp(tmp, sha1))
+	if (get_sha1(refname + ofs, tmp.hash) || oidcmp(&tmp, oid))
 		ofs = 5;
-	return append_ref(refname + ofs, sha1, 0);
+	return append_ref(refname + ofs, oid->hash, 0);
 }
 
-static int append_remote_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int append_remote_ref(const char *refname, const struct object_id *oid,
+			     int flag, void *cb_data)
 {
-	unsigned char tmp[20];
+	struct object_id tmp;
 	int ofs = 13;
 	if (!starts_with(refname, "refs/remotes/"))
 		return 0;
 	/* If both heads/foo and tags/foo exists, get_sha1 would
 	 * get confused.
 	 */
-	if (get_sha1(refname + ofs, tmp) || hashcmp(tmp, sha1))
+	if (get_sha1(refname + ofs, tmp.hash) || oidcmp(&tmp, oid))
 		ofs = 5;
-	return append_ref(refname + ofs, sha1, 0);
+	return append_ref(refname + ofs, oid->hash, 0);
 }
 
-static int append_tag_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int append_tag_ref(const char *refname, const struct object_id *oid,
+			  int flag, void *cb_data)
 {
 	if (!starts_with(refname, "refs/tags/"))
 		return 0;
-	return append_ref(refname + 5, sha1, 0);
+	return append_ref(refname + 5, oid->hash, 0);
 }
 
 static const char *match_ref_pattern = NULL;
@@ -457,9 +460,9 @@ static int append_matching_ref(const char *refname, const struct object_id *oid,
 	if (wildmatch(match_ref_pattern, tail, 0, NULL))
 		return 0;
 	if (starts_with(refname, "refs/heads/"))
-		return append_head_ref(refname, oid->hash, flag, cb_data);
+		return append_head_ref(refname, oid, flag, cb_data);
 	if (starts_with(refname, "refs/tags/"))
-		return append_tag_ref(refname, oid->hash, flag, cb_data);
+		return append_tag_ref(refname, oid, flag, cb_data);
 	return append_ref(refname, oid->hash, 0);
 }
 
@@ -467,18 +470,14 @@ static void snarf_refs(int head, int remotes)
 {
 	if (head) {
 		int orig_cnt = ref_name_cnt;
-		struct each_ref_fn_sha1_adapter wrapped_append_head_ref =
-			{append_head_ref, NULL};
 
-		for_each_ref(each_ref_fn_adapter, &wrapped_append_head_ref);
+		for_each_ref(append_head_ref, NULL);
 		sort_ref_range(orig_cnt, ref_name_cnt);
 	}
 	if (remotes) {
 		int orig_cnt = ref_name_cnt;
-		struct each_ref_fn_sha1_adapter wrapped_append_remote_ref =
-			{append_remote_ref, NULL};
 
-		for_each_ref(each_ref_fn_adapter, &wrapped_append_remote_ref);
+		for_each_ref(append_remote_ref, NULL);
 		sort_ref_range(orig_cnt, ref_name_cnt);
 	}
 }
-- 
2.4.0
