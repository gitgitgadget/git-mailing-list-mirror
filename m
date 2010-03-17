From: Andreas Gruenbacher <agruen@suse.de>
Subject: [PATCH 9/9] fetch: Make automatic tag following work with arbitrary refspecs
Date: Thu, 18 Mar 2010 00:59:22 +0100
Message-ID: <ff287641841582e06f6a145e9c697badb089b9d4.1268913163.git.agruen@suse.de>
References: <cover.1268913163.git.agruen@suse.de>
	<f2bf11648d2cfb58e348d2c8caffa841012fd994.1268913163.git.agruen@suse.de>
	<f747d7538f2a2bbdb48c9902298fa87691097eba.1268913163.git.agruen@suse.de>
	<b7762c1e05412618584e38b868bcc870676f6e62.1268913163.git.agruen@suse.de>
	<672662f82e19ab268bd83f2b48980f43f126c089.1268913163.git.agruen@suse.de>
	<dbb0f92deca35a16c898af697dc41affc377ae0b.1268913163.git.agruen@suse.de>
	<d3c00e2a27003dca196d5480007544610cc1e5b8.1268913163.git.agruen@suse.de>
	<24bf0bf2a12b1eccf3aa8f6bd1753012dfdb9987.1268913163.git.agruen@suse.de>
	<3f1d446c333b7eaabce513e846efe5313d2084fb.1268913163.git.agruen@suse.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 18 12:56:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsEKb-0002C7-EB
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 12:56:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961Ab0CRLzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 07:55:36 -0400
Received: from cantor2.suse.de ([195.135.220.15]:50444 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752865Ab0CRLz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 07:55:28 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 5877786EE4
	for <git@vger.kernel.org>; Thu, 18 Mar 2010 12:55:27 +0100 (CET)
In-Reply-To: <3f1d446c333b7eaabce513e846efe5313d2084fb.1268913163.git.agruen@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142461>

Make automatic tag following and the --tags and --no-tags options work
together with arbitrary refspecs: by default, tags will always be
fetched automatically, the --tags option will fetch all tags (and only
tags), and the --no-tags option will not fetch any tags.  This allows to
define how things are mapped and which things to fetch independently.

Signed-off-by: Andres Gruenbacher <agruen@suse.de>
---
 builtin/fetch.c |   37 ++++++++++++++++++++++++++-----------
 1 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8c01876..9265d76 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -147,6 +147,7 @@ static void add_default_tags(const struct ref *remote_refs,
 			     struct string_list *existing_refs,
 			     struct string_list *peeled_map,
 			     struct ref *ref_map,
+			     int overwrite,
 			     struct ref ***tail)
 {
 	struct string_list mapped_refs = { NULL, 0, 0, 0 };
@@ -180,12 +181,8 @@ static void add_default_tags(const struct ref *remote_refs,
 	for (tag = &tags; *tag; ) {
 		ref = *tag;
 		peer_ref = ref->peer_ref;
-		if (!(string_list_has_string(existing_refs, peer_ref->name) ||
-		      string_list_has_string(&mapped_refs, ref->name))) {
-			struct string_list_item *item;
-
-			item = string_list_lookup(ref->name, peeled_map);
-			ref->automatic = !(item && will_fetch(ref_map, item->util));
+		if ((overwrite || !string_list_has_string(existing_refs, peer_ref->name)) &&
+		    !string_list_has_string(&mapped_refs, ref->name)) {
 			string_list_insert(peer_ref->name, existing_refs);
 			move_tag_to_tail(tag, tail);
 			continue;
@@ -218,6 +215,10 @@ int ref_is_automatic(const struct ref *ref) {
 	return ref->automatic;
 }
 
+int ref_is_tag(const struct ref *ref) {
+	return !prefixcmp(ref->name, "refs/tags/");
+}
+
 static struct ref *get_ref_map(struct transport *transport,
 			       struct refspec *refs, int ref_count, int tags,
 			       struct string_list *peeled_map,
@@ -231,7 +232,7 @@ static struct ref *get_ref_map(struct transport *transport,
 
 	const struct ref *remote_refs = transport_get_remote_refs(transport);
 
-	if (ref_count || tags == TAGS_SET) {
+	if (ref_count) {
 		for (i = 0; i < ref_count; i++) {
 			get_fetch_map(remote_refs, &refs[i], &tail, 0);
 			if (refs[i].dst && refs[i].dst[0])
@@ -240,8 +241,6 @@ static struct ref *get_ref_map(struct transport *transport,
 		/* Merge everything on the command line, but not --tags */
 		for (rm = ref_map; rm; rm = rm->next)
 			rm->merge = 1;
-		if (tags == TAGS_SET)
-			get_fetch_map(remote_refs, tag_refspec, &tail, 0);
 	} else {
 		/* Use the defaults */
 		struct remote *remote = transport->remote;
@@ -287,8 +286,24 @@ static struct ref *get_ref_map(struct transport *transport,
 		}
 	}
 
-	if (tags == TAGS_DEFAULT && *autotags)
-		add_default_tags(remote_refs, &existing_refs, peeled_map, ref_map, &tail);
+	if (tags == TAGS_SET) {
+		add_default_tags(remote_refs, &existing_refs, peeled_map, ref_map, 1, &tail);
+		discard_refs(&ref_map, 1, ref_is_tag);
+		free_refs(rm);
+	} else if (tags == TAGS_DEFAULT && *autotags) {
+		add_default_tags(remote_refs, &existing_refs, peeled_map, ref_map, 0, &tail);
+		for (rm = ref_map; rm; rm = rm->next) {
+			struct string_list_item *item;
+
+			if (prefixcmp(rm->name, "refs/tags/"))
+				continue;
+			item = string_list_lookup(rm->name, peeled_map);
+			rm->automatic = !(item && will_fetch(ref_map, item->util));
+		}
+	} else {
+		discard_refs(&ref_map, 0, ref_is_tag);
+		free_refs(rm);
+	}
 	string_list_clear(&existing_refs, 0);
 
 	ref_remove_duplicates(ref_map);
-- 
1.7.0.2.273.gc2413
