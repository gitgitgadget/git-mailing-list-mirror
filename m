From: Andreas Gruenbacher <agruen@suse.de>
Subject: [PATCH 5/9] fetch: Move loop checking which refs we have already
Date: Tue, 16 Mar 2010 18:49:32 +0100
Message-ID: <dbb0f92deca35a16c898af697dc41affc377ae0b.1268913163.git.agruen@suse.de>
References: <cover.1268913163.git.agruen@suse.de>
	<f2bf11648d2cfb58e348d2c8caffa841012fd994.1268913163.git.agruen@suse.de>
	<f747d7538f2a2bbdb48c9902298fa87691097eba.1268913163.git.agruen@suse.de>
	<b7762c1e05412618584e38b868bcc870676f6e62.1268913163.git.agruen@suse.de>
	<672662f82e19ab268bd83f2b48980f43f126c089.1268913163.git.agruen@suse.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 18 12:56:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsEKe-0002C7-RK
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 12:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083Ab0CRLzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 07:55:44 -0400
Received: from cantor2.suse.de ([195.135.220.15]:50442 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752766Ab0CRLz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 07:55:27 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 7156689783
	for <git@vger.kernel.org>; Thu, 18 Mar 2010 12:55:26 +0100 (CET)
In-Reply-To: <672662f82e19ab268bd83f2b48980f43f126c089.1268913163.git.agruen@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142462>

This loop fits better into get_ref_map(); move it there.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
---
 builtin/fetch.c |   48 ++++++++++++++++++++++++------------------------
 1 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index fc6efc7..6dc75d4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -115,6 +115,15 @@ static void add_merge_config(struct ref **head,
 	}
 }
 
+static int add_existing(const char *refname, const unsigned char *sha1,
+			int flag, void *cbdata)
+{
+	struct string_list *list = (struct string_list *)cbdata;
+	struct string_list_item *item = string_list_insert(refname, list);
+	item->util = (void *)sha1;
+	return 0;
+}
+
 static void find_non_local_tags(struct transport *transport,
 			struct ref **head,
 			struct ref ***tail);
@@ -123,6 +132,7 @@ static struct ref *get_ref_map(struct transport *transport,
 			       struct refspec *refs, int ref_count, int tags,
 			       int *autotags)
 {
+	struct string_list existing_refs = { NULL, 0, 0, 0 };
 	int i;
 	struct ref *rm;
 	struct ref *ref_map = NULL;
@@ -176,6 +186,20 @@ static struct ref *get_ref_map(struct transport *transport,
 		find_non_local_tags(transport, &ref_map, &tail);
 	ref_remove_duplicates(ref_map);
 
+	for_each_ref(add_existing, &existing_refs);
+	for (rm = ref_map; rm; rm = rm->next) {
+		if (rm->peer_ref) {
+			struct string_list_item *peer_item;
+
+			peer_item = string_list_lookup(rm->peer_ref->name,
+						       &existing_refs);
+			if (peer_item)
+				hashcpy(rm->peer_ref->old_sha1,
+					peer_item->util);
+		}
+	}
+	string_list_clear(&existing_refs, 0);
+
 	return ref_map;
 }
 
@@ -554,15 +578,6 @@ static int prune_refs(struct transport *transport, struct ref *ref_map)
 	return result;
 }
 
-static int add_existing(const char *refname, const unsigned char *sha1,
-			int flag, void *cbdata)
-{
-	struct string_list *list = (struct string_list *)cbdata;
-	struct string_list_item *item = string_list_insert(refname, list);
-	item->util = (void *)sha1;
-	return 0;
-}
-
 static int will_fetch(struct ref **head, const unsigned char *sha1)
 {
 	struct ref *rm = *head;
@@ -696,14 +711,9 @@ static int truncate_fetch_head(void)
 static int do_fetch(struct transport *transport,
 		    struct refspec *refs, int ref_count)
 {
-	struct string_list existing_refs = { NULL, 0, 0, 0 };
-	struct string_list_item *peer_item = NULL;
 	struct ref *ref_map;
-	struct ref *rm;
 	int autotags = (transport->remote->fetch_tags == 1);
 
-	for_each_ref(add_existing, &existing_refs);
-
 	if (transport->remote->fetch_tags == 2 && tags != TAGS_UNSET)
 		tags = TAGS_SET;
 	if (transport->remote->fetch_tags == -1)
@@ -723,16 +733,6 @@ static int do_fetch(struct transport *transport,
 	if (!update_head_ok)
 		check_not_current_branch(ref_map);
 
-	for (rm = ref_map; rm; rm = rm->next) {
-		if (rm->peer_ref) {
-			peer_item = string_list_lookup(rm->peer_ref->name,
-						       &existing_refs);
-			if (peer_item)
-				hashcpy(rm->peer_ref->old_sha1,
-					peer_item->util);
-		}
-	}
-
 	if (tags == TAGS_DEFAULT && autotags)
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
 	if (fetch_refs(transport, ref_map)) {
-- 
1.7.0.2.273.gc2413
