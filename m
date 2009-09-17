From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [RFC/PATCH v3] fetch: Speed up fetch by rewriting find_non_local_tags
Date: Thu, 17 Sep 2009 08:33:19 +0100
Message-ID: <20090917073320.58452.41718.julian@quantumfyre.co.uk>
References: <20090916074737.58044.42776.julian@quantumfyre.co.uk>
	<alpine.LNX.2.00.0909170039410.14993@reaper.quantumfyre.co.uk>
	<alpine.LNX.2.00.0909170227160.15719@reaper.quantumfyre.co.uk>
	<200909170913.03639.johan@herland.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Sep 17 09:40:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoBb6-0006es-Re
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 09:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758654AbZIQHj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 03:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758411AbZIQHj4
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 03:39:56 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:45071 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756973AbZIQHj4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Sep 2009 03:39:56 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id E9194341A48
	for <git@vger.kernel.org>; Thu, 17 Sep 2009 08:39:58 +0100 (BST)
Received: (qmail 9969 invoked by uid 103); 17 Sep 2009 08:35:28 +0100
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/9810. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.025347 secs); 17 Sep 2009 07:35:28 -0000
Received: from reaper.quantumfyre.co.uk (HELO rayne.quantumfyre.co.uk) (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 17 Sep 2009 08:35:28 +0100
X-git-sha1: 5c9a553eba08e9a4359dbe8bdc7bd0b82c0f9390 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <200909170913.03639.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128727>

When trying to get a list of remote tags to see if we need to fetch
any we were doing a linear search for the matching tag ref for the
tag^{} commit entries.  This proves to be incredibly slow for large
numbers of tags.  Rewrite the function so that we build up a
string_list of refs to fetch and then process that instead.

As an extreme example, for a repository with 50000 tags (and just a
single commit on a single branch), a fetch that does nothing goes from
~1m50s to ~4.1s.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---

Ok, so here it is ...

Sometimes I forget just much we git users value our time and resources.
;)

 builtin-fetch.c |   98 ++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 65 insertions(+), 33 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index cb48c57..acb08e4 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -504,57 +504,89 @@ static int will_fetch(struct ref **head, const unsigned char *sha1)
 	return 0;
 }
 
+struct tag_data {
+	struct ref **head;
+	struct ref ***tail;
+};
+
+static int add_to_tail(struct string_list_item *item, void *cb_data)
+{
+	struct tag_data *data = (struct tag_data *)cb_data;
+	struct ref *rm = NULL;
+
+	/* We have already decided to ignore this item */
+	if (!item->util)
+		return 0;
+
+	rm = alloc_ref(item->string);
+	rm->peer_ref = alloc_ref(item->string);
+	hashcpy(rm->old_sha1, item->util);
+
+	**data->tail = rm;
+	*data->tail = &rm->next;
+
+	return 0;
+}
+
 static void find_non_local_tags(struct transport *transport,
 			struct ref **head,
 			struct ref ***tail)
 {
 	struct string_list existing_refs = { NULL, 0, 0, 0 };
-	struct string_list new_refs = { NULL, 0, 0, 1 };
-	char *ref_name;
-	int ref_name_len;
-	const unsigned char *ref_sha1;
-	const struct ref *tag_ref;
-	struct ref *rm = NULL;
+	struct string_list remote_refs = { NULL, 0, 0, 0 };
+	struct tag_data data = {head, tail};
 	const struct ref *ref;
+	struct string_list_item *item = NULL;
 
 	for_each_ref(add_existing, &existing_refs);
 	for (ref = transport_get_remote_refs(transport); ref; ref = ref->next) {
 		if (prefixcmp(ref->name, "refs/tags"))
 			continue;
 
-		ref_name = xstrdup(ref->name);
-		ref_name_len = strlen(ref_name);
-		ref_sha1 = ref->old_sha1;
-
-		if (!strcmp(ref_name + ref_name_len - 3, "^{}")) {
-			ref_name[ref_name_len - 3] = 0;
-			tag_ref = transport_get_remote_refs(transport);
-			while (tag_ref) {
-				if (!strcmp(tag_ref->name, ref_name)) {
-					ref_sha1 = tag_ref->old_sha1;
-					break;
-				}
-				tag_ref = tag_ref->next;
-			}
+		/* the peeled ref always follows the matching base ref, so if we
+		 * see a peeled ref that we don't want to fetch then we can mark
+		 * the ref entry in the list as one to ignore by setting util to
+		 * NULL. */
+		if (!strcmp(ref->name + strlen(ref->name) - 3, "^{}")) {
+			if (item && !has_sha1_file(ref->old_sha1) &&
+			    !will_fetch(head, ref->old_sha1) &&
+			    !has_sha1_file(item->util) &&
+			    !will_fetch(head, item->util) )
+				item->util = NULL;
+			item = NULL;
+			continue;
 		}
 
-		if (!string_list_has_string(&existing_refs, ref_name) &&
-		    !string_list_has_string(&new_refs, ref_name) &&
-		    (has_sha1_file(ref->old_sha1) ||
-		     will_fetch(head, ref->old_sha1))) {
-			string_list_insert(ref_name, &new_refs);
+		/* If item is non-NULL here, then we previously saw a ref not
+		 * followed by a peeled reference, so we need to check if it is
+		 * a lightweight tag that we want to fetch */
+		if (item && !has_sha1_file(item->util) &&
+		    !will_fetch(head, item->util) )
+			item->util = NULL;
 
-			rm = alloc_ref(ref_name);
-			rm->peer_ref = alloc_ref(ref_name);
-			hashcpy(rm->old_sha1, ref_sha1);
+		item = NULL;
 
-			**tail = rm;
-			*tail = &rm->next;
-		}
-		free(ref_name);
+		/* skip duplicates and refs that we already have */
+		if (string_list_has_string(&remote_refs, ref->name) ||
+		    string_list_has_string(&existing_refs, ref->name))
+			continue;
+
+		item = string_list_insert(ref->name, &remote_refs);
+		item->util = (void *)ref->old_sha1;
 	}
 	string_list_clear(&existing_refs, 0);
-	string_list_clear(&new_refs, 0);
+
+	/* We may have a final lightweight tag that needs to be checked to see
+	 * if it needs fetching. */
+	if (item && !has_sha1_file(item->util) &&
+	    !will_fetch(head, item->util) )
+		item->util = NULL;
+
+	/* For all the tags in the remote_refs string list, call add_to_tail to
+	 * add them to the list of refs to be fetched */
+	for_each_string_list(add_to_tail, &remote_refs, &data);
+
+	string_list_clear(&remote_refs, 0);
 }
 
 static void check_not_current_branch(struct ref *ref_map)
-- 
1.6.4.2
