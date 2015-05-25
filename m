From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 14/56] builtin/reflog: rewrite ref functions to take an object_id argument
Date: Mon, 25 May 2015 18:38:40 +0000
Message-ID: <1432579162-411464-15-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:40:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxIa-0000s9-1n
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbbEYSkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:40:22 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50592 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751316AbbEYSkL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:11 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 8A5C328099;
	Mon, 25 May 2015 18:40:10 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269857>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/reflog.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 1163dd6..c2eb8ff 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -313,14 +313,14 @@ static int should_expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	return 0;
 }
 
-static int push_tip_to_list(const char *refname, const unsigned char *sha1,
+static int push_tip_to_list(const char *refname, const struct object_id *oid,
 			    int flags, void *cb_data)
 {
 	struct commit_list **list = cb_data;
 	struct commit *tip_commit;
 	if (flags & REF_ISSYMREF)
 		return 0;
-	tip_commit = lookup_commit_reference_gently(sha1, 1);
+	tip_commit = lookup_commit_reference_gently(oid->hash, 1);
 	if (!tip_commit)
 		return 0;
 	commit_list_insert(tip_commit, list);
@@ -352,10 +352,8 @@ static void reflog_expiry_prepare(const char *refname,
 	if (cb->unreachable_expire_kind != UE_ALWAYS) {
 		if (cb->unreachable_expire_kind == UE_HEAD) {
 			struct commit_list *elem;
-			struct each_ref_fn_sha1_adapter wrapped_push_tip_to_list =
-				{push_tip_to_list, &cb->tips};
 
-			for_each_ref(each_ref_fn_adapter, &wrapped_push_tip_to_list);
+			for_each_ref(push_tip_to_list, &cb->tips);
 			for (elem = cb->tips; elem; elem = elem->next)
 				commit_list_insert(elem->item, &cb->mark_list);
 		} else {
@@ -382,14 +380,14 @@ static void reflog_expiry_cleanup(void *cb_data)
 	}
 }
 
-static int collect_reflog(const char *ref, const unsigned char *sha1, int unused, void *cb_data)
+static int collect_reflog(const char *ref, const struct object_id *oid, int unused, void *cb_data)
 {
 	struct collected_reflog *e;
 	struct collect_reflog_cb *cb = cb_data;
 	size_t namelen = strlen(ref);
 
 	e = xmalloc(sizeof(*e) + namelen + 1);
-	hashcpy(e->sha1, sha1);
+	hashcpy(e->sha1, oid->hash);
 	memcpy(e->reflog, ref, namelen + 1);
 	ALLOC_GROW(cb->e, cb->nr + 1, cb->alloc);
 	cb->e[cb->nr++] = e;
@@ -591,11 +589,9 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	if (do_all) {
 		struct collect_reflog_cb collected;
 		int i;
-		struct each_ref_fn_sha1_adapter wrapped_collect_reflog =
-			{collect_reflog, &collected};
 
 		memset(&collected, 0, sizeof(collected));
-		for_each_reflog(each_ref_fn_adapter, &wrapped_collect_reflog);
+		for_each_reflog(collect_reflog, &collected);
 		for (i = 0; i < collected.nr; i++) {
 			struct collected_reflog *e = collected.e[i];
 			set_reflog_expiry_param(&cb.cmd, explicit_expiry, e->reflog);
-- 
2.4.0
