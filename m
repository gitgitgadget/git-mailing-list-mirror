From: Joey Hess <joey@kitenet.net>
Subject: [PATCH 2/3] preparations for tweak-fetch hook
Date: Thu, 29 Dec 2011 21:07:19 -0400
Message-ID: <1325207240-22622-3-git-send-email-joey@kitenet.net>
References: <1325207240-22622-1-git-send-email-joey@kitenet.net>
Cc: Joey Hess <joey@kitenet.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 30 03:30:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RgSF3-00089c-CH
	for gcvg-git-2@lo.gmane.org; Fri, 30 Dec 2011 03:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754935Ab1L3Cal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Dec 2011 21:30:41 -0500
Received: from wren.kitenet.net ([80.68.85.49]:54721 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754359Ab1L3CaI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Dec 2011 21:30:08 -0500
Received: from gnu.kitenet.net (dialup-4.153.83.252.Dial1.Atlanta1.Level3.net [4.153.83.252])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 3D3A0119274;
	Thu, 29 Dec 2011 21:30:04 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 9646846966; Thu, 29 Dec 2011 20:08:11 -0500 (EST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1325207240-22622-1-git-send-email-joey@kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187794>

No behavior changes yet, only some groundwork for the next
change.

The refs_result structure combines a status code with a ref map,
which can be NULL even on success. This will be needed when
there's a tweak-fetch hook, because it can filter out all refs,
while still succeeding.

fetch_refs returns a refs_result, so that it can modify the ref_map.

Signed-off-by: Joey Hess <joey@kitenet.net>
---
 builtin/fetch.c |   55 ++++++++++++++++++++++++++++++++++++-------------------
 1 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 33ad3aa..a48358a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -29,6 +29,11 @@ enum {
 	TAGS_SET = 2
 };
 
+struct refs_result {
+	struct ref *new_refs;
+	int status;
+};
+
 static int all, append, dry_run, force, keep, multiple, prune, update_head_ok, verbosity;
 static int progress, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int tags = TAGS_DEFAULT;
@@ -89,6 +94,15 @@ static struct option builtin_fetch_options[] = {
 	OPT_END()
 };
 
+static int add_existing(const char *refname, const unsigned char *sha1,
+			int flag, void *cbdata)
+{
+	struct string_list *list = (struct string_list *)cbdata;
+	struct string_list_item *item = string_list_insert(list, refname);
+	item->util = (void *)sha1;
+	return 0;
+}
+
 static void unlock_pack(void)
 {
 	if (transport)
@@ -507,17 +521,25 @@ static int quickfetch(struct ref *ref_map)
 	return check_everything_connected(iterate_ref_map, 1, &rm);
 }
 
-static int fetch_refs(struct transport *transport, struct ref *ref_map)
+static struct refs_result fetch_refs(struct transport *transport,
+		struct ref *ref_map)
 {
-	int ret = quickfetch(ref_map);
-	if (ret)
-		ret = transport_fetch_refs(transport, ref_map);
-	if (!ret)
-		ret |= store_updated_refs(transport->url,
+	struct refs_result res;
+	res.status = quickfetch(ref_map);
+	if (res.status)
+		res.status = transport_fetch_refs(transport, ref_map);
+	if (!res.status) {
+		res.new_refs = ref_map;
+
+		res.status |= store_updated_refs(transport->url,
 				transport->remote->name,
-				ref_map);
+				res.new_refs);
+	}
+	else {
+		res.new_refs = ref_map;
+	}
 	transport_unlock_pack(transport);
-	return ret;
+	return res;
 }
 
 static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map)
@@ -542,15 +564,6 @@ static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map)
 	return result;
 }
 
-static int add_existing(const char *refname, const unsigned char *sha1,
-			int flag, void *cbdata)
-{
-	struct string_list *list = (struct string_list *)cbdata;
-	struct string_list_item *item = string_list_insert(list, refname);
-	item->util = (void *)sha1;
-	return 0;
-}
-
 static int will_fetch(struct ref **head, const unsigned char *sha1)
 {
 	struct ref *rm = *head;
@@ -673,6 +686,7 @@ static int do_fetch(struct transport *transport,
 	struct string_list_item *peer_item = NULL;
 	struct ref *ref_map;
 	struct ref *rm;
+	struct refs_result res;
 	int autotags = (transport->remote->fetch_tags == 1);
 
 	for_each_ref(add_existing, &existing_refs);
@@ -710,7 +724,9 @@ static int do_fetch(struct transport *transport,
 
 	if (tags == TAGS_DEFAULT && autotags)
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
-	if (fetch_refs(transport, ref_map)) {
+	res = fetch_refs(transport, ref_map);
+	ref_map = res.new_refs;
+	if (res.status) {
 		free_refs(ref_map);
 		return 1;
 	}
@@ -750,7 +766,8 @@ static int do_fetch(struct transport *transport,
 		if (ref_map) {
 			transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
 			transport_set_option(transport, TRANS_OPT_DEPTH, "0");
-			fetch_refs(transport, ref_map);
+			res = fetch_refs(transport, ref_map);
+			ref_map = res.new_refs;
 		}
 		free_refs(ref_map);
 	}
-- 
1.7.7.3
