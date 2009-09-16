From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [RFC/PATCH v2] fetch: Speed up fetch by rewriting find_non_local_tags
Date: Wed, 16 Sep 2009 23:53:49 +0100
Message-ID: <20090916225350.45746.85139.julian@quantumfyre.co.uk>
References: <20090916074737.58044.42776.julian@quantumfyre.co.uk>
	<7vbplb2pi7.fsf@alter.siamese.dyndns.org>
	<alpine.LNX.2.00.0909162141140.13697@reaper.quantumfyre.co.uk>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 00:58:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo3Sa-0001PH-4W
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 00:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760220AbZIPW6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 18:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759902AbZIPW6h
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 18:58:37 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:55784 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755112AbZIPW6h (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Sep 2009 18:58:37 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 34B41115448
	for <git@vger.kernel.org>; Wed, 16 Sep 2009 23:58:38 +0100 (BST)
Received: (qmail 14936 invoked by uid 103); 16 Sep 2009 23:56:07 +0100
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/9808. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.025887 secs); 16 Sep 2009 22:56:07 -0000
Received: from reaper.quantumfyre.co.uk (HELO rayne.quantumfyre.co.uk) (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 16 Sep 2009 23:56:07 +0100
X-git-sha1: e072415d2baf79ac2c59dd0347d95ea236879a37 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <alpine.LNX.2.00.0909162141140.13697@reaper.quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128690>

When trying to get a list of remote tags to see if we need to fetch
any we were doing a linear search for the matching tag ref for the
tag^{} commit entries.  This proves to be incredibly slow for large
numbers of tags.  Rewrite the function so that we can do lookup in
string_lists instead.

For a repository with 50000 tags (and just a single commit on a single
branch), a fetch that does nothing goes from ~ 1m50s to ~4.2s.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---

Not only does this not require a custom hash table, it is also slightly
faster than the last version (~4.2s vs ~4.5s).

If nothing else, having rewritten it completely, at least I now
understand what the old find_non_local_tags function was actually doing
... ;)

 builtin-fetch.c |   85 ++++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 59 insertions(+), 26 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index cb48c57..c9a2563 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -504,57 +504,90 @@ static int will_fetch(struct ref **head, const unsigned char *sha1)
 	return 0;
 }
 
+struct tag_data {
+	struct ref **head;
+	struct ref ***tail;
+	struct string_list *refs;
+};
+
+static int add_to_tail(struct string_list_item *item, void *cb_data)
+{
+	struct tag_data *data = (struct tag_data *)cb_data;
+	unsigned char *commit = (unsigned char *)item->util;
+	struct ref *rm = NULL;
+	struct string_list_item *sli;
+
+	/* Tag objects will have the commit sha1 associated with the peeled
+	 * ref, if there is not a peeled ref then the ref is probably a
+	 * lightweight tag and so refers to a commit directly */
+	sli = string_list_lookup(item->string, data->refs);
+	if (sli)
+		commit = sli->util;
+
+	/* skip over tags that we don't have the commits for. */
+	if (!has_sha1_file(commit) && !will_fetch(data->head, commit))
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
+	struct string_list peeled_refs = { NULL, 0, 0, 1 };
+	struct string_list remote_refs = { NULL, 0, 0, 1 };
+	struct tag_data data = {head, tail, &peeled_refs};
+	struct string_list *refs;
 	char *ref_name;
 	int ref_name_len;
-	const unsigned char *ref_sha1;
-	const struct ref *tag_ref;
-	struct ref *rm = NULL;
 	const struct ref *ref;
+	struct string_list_item *item;
 
 	for_each_ref(add_existing, &existing_refs);
 	for (ref = transport_get_remote_refs(transport); ref; ref = ref->next) {
 		if (prefixcmp(ref->name, "refs/tags"))
 			continue;
 
+		/* skip duplicates */
+		if (string_list_lookup(ref->name, &remote_refs))
+			continue;
+
+		refs = &remote_refs;
 		ref_name = xstrdup(ref->name);
 		ref_name_len = strlen(ref_name);
-		ref_sha1 = ref->old_sha1;
 
+		/* we want to store peeled refs by the base ref name in the
+		 * peeled_refs string list */
 		if (!strcmp(ref_name + ref_name_len - 3, "^{}")) {
 			ref_name[ref_name_len - 3] = 0;
-			tag_ref = transport_get_remote_refs(transport);
-			while (tag_ref) {
-				if (!strcmp(tag_ref->name, ref_name)) {
-					ref_sha1 = tag_ref->old_sha1;
-					break;
-				}
-				tag_ref = tag_ref->next;
-			}
+			refs = &peeled_refs;
 		}
 
-		if (!string_list_has_string(&existing_refs, ref_name) &&
-		    !string_list_has_string(&new_refs, ref_name) &&
-		    (has_sha1_file(ref->old_sha1) ||
-		     will_fetch(head, ref->old_sha1))) {
-			string_list_insert(ref_name, &new_refs);
-
-			rm = alloc_ref(ref_name);
-			rm->peer_ref = alloc_ref(ref_name);
-			hashcpy(rm->old_sha1, ref_sha1);
-
-			**tail = rm;
-			*tail = &rm->next;
+		/* ignore refs that we already have */
+		if (!string_list_has_string(&existing_refs, ref_name)) {
+			item = string_list_insert(ref_name, refs);
+			item->util = (void *)ref->old_sha1;
 		}
+
 		free(ref_name);
 	}
+
+	/* For all the tags in the remote_refs string list, call add_to_tail to
+	 * add them to the list of refs to be fetched */
+	for_each_string_list(add_to_tail, &remote_refs, &data);
+
 	string_list_clear(&existing_refs, 0);
-	string_list_clear(&new_refs, 0);
+	string_list_clear(&peeled_refs, 0);
+	string_list_clear(&remote_refs, 0);
 }
 
 static void check_not_current_branch(struct ref *ref_map)
-- 
1.6.4.2
