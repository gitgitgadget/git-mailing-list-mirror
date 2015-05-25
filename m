From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 09/56] builtin/fetch: rewrite to take an object_id argument
Date: Mon, 25 May 2015 18:38:35 +0000
Message-ID: <1432579162-411464-10-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:42:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxKY-0001xX-I0
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbbEYSkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:40:13 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50613 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751289AbbEYSkJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:09 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 48F782809A;
	Mon, 25 May 2015 18:40:08 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269898>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/fetch.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4878c3d..8d5b2db 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -179,13 +179,15 @@ static void add_merge_config(struct ref **head,
 	}
 }
 
-static int add_existing(const char *refname, const unsigned char *sha1,
+static int add_existing(const char *refname, const struct object_id *oid,
 			int flag, void *cbdata)
 {
 	struct string_list *list = (struct string_list *)cbdata;
 	struct string_list_item *item = string_list_insert(list, refname);
-	item->util = xmalloc(20);
-	hashcpy(item->util, sha1);
+	struct object_id *old_oid = xmalloc(sizeof(*old_oid));
+
+	oidcpy(old_oid, oid);
+	item->util = old_oid;
 	return 0;
 }
 
@@ -208,10 +210,8 @@ static void find_non_local_tags(struct transport *transport,
 	struct string_list remote_refs = STRING_LIST_INIT_NODUP;
 	const struct ref *ref;
 	struct string_list_item *item = NULL;
-	struct each_ref_fn_sha1_adapter wrapped_add_existing =
-		{add_existing, &existing_refs};
 
-	for_each_ref(each_ref_fn_adapter, &wrapped_add_existing);
+	for_each_ref(add_existing, &existing_refs);
 	for (ref = transport_get_remote_refs(transport); ref; ref = ref->next) {
 		if (!starts_with(ref->name, "refs/tags/"))
 			continue;
@@ -886,10 +886,8 @@ static int do_fetch(struct transport *transport,
 	struct ref *rm;
 	int autotags = (transport->remote->fetch_tags == 1);
 	int retcode = 0;
-	struct each_ref_fn_sha1_adapter wrapped_add_existing =
-		{add_existing, &existing_refs};
 
-	for_each_ref(each_ref_fn_adapter, &wrapped_add_existing);
+	for_each_ref(add_existing, &existing_refs);
 
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
@@ -917,9 +915,10 @@ static int do_fetch(struct transport *transport,
 			struct string_list_item *peer_item =
 				string_list_lookup(&existing_refs,
 						   rm->peer_ref->name);
-			if (peer_item)
-				hashcpy(rm->peer_ref->old_sha1,
-					peer_item->util);
+			if (peer_item) {
+				struct object_id *old_oid = peer_item->util;
+				hashcpy(rm->peer_ref->old_sha1, old_oid->hash);
+			}
 		}
 	}
 
-- 
2.4.0
