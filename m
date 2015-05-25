From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 17/56] builtin/remote: rewrite functions to take object_id arguments
Date: Mon, 25 May 2015 18:38:43 +0000
Message-ID: <1432579162-411464-18-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:40:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxIa-0000s9-Ka
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbbEYSkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:40:24 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50602 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750837AbbEYSkM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:12 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id CF27828095;
	Mon, 25 May 2015 18:40:11 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269855>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/remote.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index ab39fea..f4a6ec9 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -554,20 +554,20 @@ struct rename_info {
 };
 
 static int read_remote_branches(const char *refname,
-	const unsigned char *sha1, int flags, void *cb_data)
+	const struct object_id *oid, int flags, void *cb_data)
 {
 	struct rename_info *rename = cb_data;
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list_item *item;
 	int flag;
-	unsigned char orig_sha1[20];
+	struct object_id orig_oid;
 	const char *symref;
 
 	strbuf_addf(&buf, "refs/remotes/%s/", rename->old);
 	if (starts_with(refname, buf.buf)) {
 		item = string_list_append(rename->remote_branches, xstrdup(refname));
 		symref = resolve_ref_unsafe(refname, RESOLVE_REF_READING,
-					    orig_sha1, &flag);
+					    orig_oid.hash, &flag);
 		if (flag & REF_ISSYMREF)
 			item->util = xstrdup(symref);
 		else
@@ -620,8 +620,6 @@ static int mv(int argc, const char **argv)
 	struct string_list remote_branches = STRING_LIST_INIT_NODUP;
 	struct rename_info rename;
 	int i, refspec_updated = 0;
-	struct each_ref_fn_sha1_adapter wrapped_read_remote_branches =
-		{read_remote_branches, &rename};
 
 	if (argc != 3)
 		usage_with_options(builtin_remote_rename_usage, options);
@@ -699,13 +697,13 @@ static int mv(int argc, const char **argv)
 	 * First remove symrefs, then rename the rest, finally create
 	 * the new symrefs.
 	 */
-	for_each_ref(each_ref_fn_adapter, &wrapped_read_remote_branches);
+	for_each_ref(read_remote_branches, &rename);
 	for (i = 0; i < remote_branches.nr; i++) {
 		struct string_list_item *item = remote_branches.items + i;
 		int flag = 0;
-		unsigned char sha1[20];
+		struct object_id oid;
 
-		read_ref_full(item->string, RESOLVE_REF_READING, sha1, &flag);
+		read_ref_full(item->string, RESOLVE_REF_READING, oid.hash, &flag);
 		if (!(flag & REF_ISSYMREF))
 			continue;
 		if (delete_ref(item->string, NULL, REF_NODEREF))
@@ -866,7 +864,7 @@ static void free_remote_ref_states(struct ref_states *states)
 }
 
 static int append_ref_to_tracked_list(const char *refname,
-	const unsigned char *sha1, int flags, void *cb_data)
+	const struct object_id *oid, int flags, void *cb_data)
 {
 	struct ref_states *states = cb_data;
 	struct refspec refspec;
@@ -909,10 +907,7 @@ static int get_remote_ref_states(const char *name,
 		if (query & GET_PUSH_REF_STATES)
 			get_push_ref_states(remote_refs, states);
 	} else {
-		struct each_ref_fn_sha1_adapter wrapped_append_ref_to_tracked_list =
-			{append_ref_to_tracked_list, states};
-
-		for_each_ref(each_ref_fn_adapter, &wrapped_append_ref_to_tracked_list);
+		for_each_ref(append_ref_to_tracked_list, states);
 		string_list_sort(&states->tracked);
 		get_push_ref_states_noquery(states);
 	}
-- 
2.4.0
