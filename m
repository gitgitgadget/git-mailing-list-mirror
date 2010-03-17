From: Andreas Gruenbacher <agruen@suse.de>
Subject: [PATCH 7/9] fetch: Use the same ref map for all branches and tags
Date: Wed, 17 Mar 2010 22:42:27 +0100
Message-ID: <24bf0bf2a12b1eccf3aa8f6bd1753012dfdb9987.1268913163.git.agruen@suse.de>
References: <cover.1268913163.git.agruen@suse.de>
	<f2bf11648d2cfb58e348d2c8caffa841012fd994.1268913163.git.agruen@suse.de>
	<f747d7538f2a2bbdb48c9902298fa87691097eba.1268913163.git.agruen@suse.de>
	<b7762c1e05412618584e38b868bcc870676f6e62.1268913163.git.agruen@suse.de>
	<672662f82e19ab268bd83f2b48980f43f126c089.1268913163.git.agruen@suse.de>
	<dbb0f92deca35a16c898af697dc41affc377ae0b.1268913163.git.agruen@suse.de>
	<d3c00e2a27003dca196d5480007544610cc1e5b8.1268913163.git.agruen@suse.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 18 12:56:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsEKd-0002C7-EA
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 12:56:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036Ab0CRLzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 07:55:42 -0400
Received: from cantor2.suse.de ([195.135.220.15]:50441 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752740Ab0CRLz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 07:55:27 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 3D42D89471
	for <git@vger.kernel.org>; Thu, 18 Mar 2010 12:55:26 +0100 (CET)
In-Reply-To: <d3c00e2a27003dca196d5480007544610cc1e5b8.1268913163.git.agruen@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142465>

With automatic tag following and the standard refspec for remotes
(+refs/heads/*:refs/remotes/<remote>/*), we fetch all branches and tags
that we know we need, and then we check which additional tags have
become reachable in a separate second pass.  The refspec used for tags
is always hardcoded (+refs/tags/*:refs/tags/*).

Change this to compute the mapping between remote and peer refs only
once, and flag tags which may become reachable as "automatic".  After
the first pass, go through all "automatic" tags in the mapping to see
which have actually become reachable, and process these.

This change preserves the existing behavior, but allows to subsequently
fix the handling of refspecs which match tags, like
+refs/tags/*:refs/tags/<remote>/*.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
---
 builtin/fetch.c |  286 +++++++++++++++++++++++++++++--------------------------
 cache.h         |    3 +-
 2 files changed, 155 insertions(+), 134 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0f292b8..8728153 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -124,12 +124,97 @@ static int add_existing(const char *refname, const unsigned char *sha1,
 	return 0;
 }
 
-static void find_non_local_tags(struct transport *transport,
-			struct ref **head,
-			struct ref ***tail);
+static void move_tag_to_tail(struct ref **tag, struct ref ***tail) {
+	struct ref *ref = *tag;
+
+	*tag = ref->next;
+	**tail = ref;
+	*tail = &ref->next;
+	ref->next = NULL;
+}
+
+static int will_fetch(struct ref *ref_map, const unsigned char *sha1)
+{
+	struct ref *ref;
+
+	for (ref = ref_map; ref; ref = ref->next)
+		if (!hashcmp(ref->old_sha1, sha1))
+			return 1;
+	return 0;
+}
+
+static void add_default_tags(const struct ref *remote_refs,
+			     struct string_list *existing_refs,
+			     struct string_list *peeled_map,
+			     struct ref *ref_map,
+			     struct ref ***tail)
+{
+	struct ref *tags = NULL, **tags_tail = &tags;
+	struct ref *ref, *peer_ref, **tag;
+
+	for (ref = (struct ref *)remote_refs; ref; ref = ref->next) {
+		int len;
+
+		if (!ref->next)
+			break;
+		len = strlen(ref->name);
+		if (!strncmp(ref->name, ref->next->name, len) &&
+		    !strcmp(ref->next->name + len, "^{}")) {
+			struct string_list_item *item;
+
+			item = string_list_append(ref->name, peeled_map);
+			item->util = ref->next->old_sha1;
+		}
+	}
+	sort_string_list(peeled_map);
+
+	for (ref = ref_map; ref; ref = ref->next)
+		if (ref->peer_ref)
+			string_list_insert(ref->peer_ref->name, existing_refs);
+
+	get_fetch_map(remote_refs, tag_refspec, &tags_tail, 0);
+	for (tag = &tags; *tag; ) {
+		ref = *tag;
+		peer_ref = ref->peer_ref;
+		if (!string_list_has_string(existing_refs, peer_ref->name)) {
+			struct string_list_item *item;
+
+			item = string_list_lookup(ref->name, peeled_map);
+			ref->automatic = !(item && will_fetch(ref_map, item->util));
+			string_list_insert(peer_ref->name, existing_refs);
+			move_tag_to_tail(tag, tail);
+			continue;
+		}
+		tag = &(*tag)->next;
+	}
+
+	free_refs(tags);
+}
+
+static void discard_refs(struct ref **ref_map, int not, int (*fn)(const struct ref *)) {
+	struct ref *discard = NULL;
+
+	while (*ref_map) {
+		struct ref *ref = *ref_map;
+
+		if (!not ^ !fn(ref)) {
+			*ref_map = ref->next;
+			ref->next = discard;
+			discard = ref;
+			continue;
+		}
+		ref_map = &ref->next;
+	}
+	free_refs(discard);
+}
+
+int ref_is_automatic(const struct ref *ref) {
+	return ref->automatic;
+}
 
 static struct ref *get_ref_map(struct transport *transport,
 			       struct refspec *refs, int ref_count, int tags,
+			       struct string_list *peeled_map,
 			       int *autotags)
 {
 	struct string_list existing_refs = { NULL, 0, 0, 0 };
@@ -182,9 +267,6 @@ static struct ref *get_ref_map(struct transport *transport,
 			tail = &ref_map->next;
 		}
 	}
-	if (tags == TAGS_DEFAULT && *autotags)
-		find_non_local_tags(transport, &ref_map, &tail);
-	ref_remove_duplicates(ref_map);
 
 	for_each_ref(add_existing, &existing_refs);
 	for (rm = ref_map; rm; rm = rm->next) {
@@ -198,8 +280,13 @@ static struct ref *get_ref_map(struct transport *transport,
 					peer_item->util);
 		}
 	}
+
+	if (tags == TAGS_DEFAULT && *autotags)
+		add_default_tags(remote_refs, &existing_refs, peeled_map, ref_map, &tail);
 	string_list_clear(&existing_refs, 0);
 
+	ref_remove_duplicates(ref_map);
+
 	return ref_map;
 }
 
@@ -353,12 +440,22 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	for (rm = ref_map; rm; rm = rm->next) {
 		struct ref *ref = NULL;
 
+		if (rm->automatic) {
+			if (has_sha1_file(rm->old_sha1))
+				rm->automatic = 0;
+			else
+				continue;
+		}
+
 		if (rm->peer_ref) {
 			ref = xcalloc(1, sizeof(*ref) + strlen(rm->peer_ref->name) + 1);
 			strcpy(ref->name, rm->peer_ref->name);
 			hashcpy(ref->old_sha1, rm->peer_ref->old_sha1);
 			hashcpy(ref->new_sha1, rm->old_sha1);
 			ref->force = rm->peer_ref->force;
+
+			/* Remember we have updated this ref */
+			hashcpy(rm->peer_ref->old_sha1, rm->old_sha1);
 		}
 
 		commit = lookup_commit_reference_gently(rm->old_sha1, 1);
@@ -439,6 +536,15 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	return rc;
 }
 
+static int contains_only_automatic_refs(struct ref *ref_map) {
+	struct ref *ref;
+
+	for (ref = ref_map; ref; ref = ref->next)
+		if (!ref->automatic)
+			return 0;
+	return 1;
+}
+
 /*
  * If running
  *
@@ -456,7 +562,7 @@ static int check_connectivity(struct ref *ref_map)
 	const char *argv[] = {"rev-list",
 		"--quiet", "--objects", "--stdin", "--not", "--all", NULL};
 
-	if (!ref_map)
+	if (contains_only_automatic_refs(ref_map))
 		return 0;
 
 	memset(&revlist, 0, sizeof(revlist));
@@ -479,6 +585,9 @@ static int check_connectivity(struct ref *ref_map)
 	sigchain_push(SIGPIPE, SIG_IGN);
 
 	for (ref = ref_map; ref; ref = ref->next) {
+		if (ref->automatic)
+			continue;
+
 		if (write_in_full(revlist.in, sha1_to_hex(ref->old_sha1), 40) < 0 ||
 		    write_str_in_full(revlist.in, "\n") < 0) {
 			if (errno != EPIPE && errno != EINVAL)
@@ -501,10 +610,9 @@ static int check_connectivity(struct ref *ref_map)
 static void select_missing_refs(struct ref *ref_map) {
 	struct ref *ref;
 
-	for (ref = ref_map; ref; ref = ref->next) {
-		if (has_sha1_file(ref->old_sha1))
-			ref->dont_fetch = 1;
-	}
+	for (ref = ref_map; ref; ref = ref->next)
+		ref->dont_fetch = ref->automatic ||
+				  has_sha1_file(ref->old_sha1);
 }
 
 static int select_all_refs(struct ref *ref_map) {
@@ -512,7 +620,7 @@ static int select_all_refs(struct ref *ref_map) {
 	int done = 1;
 
 	for (ref = ref_map; ref; ref = ref->next) {
-		if (ref->dont_fetch) {
+		if (ref->dont_fetch && !ref->automatic) {
 			ref->dont_fetch = 0;
 			done = 0;
 		}
@@ -574,111 +682,6 @@ static int prune_refs(struct transport *transport, struct ref *ref_map)
 	return result;
 }
 
-static int will_fetch(struct ref **head, const unsigned char *sha1)
-{
-	struct ref *rm = *head;
-	while (rm) {
-		if (!hashcmp(rm->old_sha1, sha1))
-			return 1;
-		rm = rm->next;
-	}
-	return 0;
-}
-
-struct tag_data {
-	struct ref **head;
-	struct ref ***tail;
-};
-
-static int add_to_tail(struct string_list_item *item, void *cb_data)
-{
-	struct tag_data *data = (struct tag_data *)cb_data;
-	struct ref *rm = NULL;
-
-	/* We have already decided to ignore this item */
-	if (!item->util)
-		return 0;
-
-	rm = alloc_ref(item->string);
-	rm->peer_ref = alloc_ref(item->string);
-	hashcpy(rm->old_sha1, item->util);
-
-	**data->tail = rm;
-	*data->tail = &rm->next;
-
-	return 0;
-}
-
-static void find_non_local_tags(struct transport *transport,
-			struct ref **head,
-			struct ref ***tail)
-{
-	struct string_list existing_refs = { NULL, 0, 0, 0 };
-	struct string_list remote_refs = { NULL, 0, 0, 0 };
-	struct tag_data data = {head, tail};
-	const struct ref *ref;
-	struct string_list_item *item = NULL;
-
-	for_each_ref(add_existing, &existing_refs);
-	for (ref = transport_get_remote_refs(transport); ref; ref = ref->next) {
-		if (prefixcmp(ref->name, "refs/tags"))
-			continue;
-
-		/*
-		 * The peeled ref always follows the matching base
-		 * ref, so if we see a peeled ref that we don't want
-		 * to fetch then we can mark the ref entry in the list
-		 * as one to ignore by setting util to NULL.
-		 */
-		if (!suffixcmp(ref->name, "^{}")) {
-			if (item && !has_sha1_file(ref->old_sha1) &&
-			    !will_fetch(head, ref->old_sha1) &&
-			    !has_sha1_file(item->util) &&
-			    !will_fetch(head, item->util))
-				item->util = NULL;
-			item = NULL;
-			continue;
-		}
-
-		/*
-		 * If item is non-NULL here, then we previously saw a
-		 * ref not followed by a peeled reference, so we need
-		 * to check if it is a lightweight tag that we want to
-		 * fetch.
-		 */
-		if (item && !has_sha1_file(item->util) &&
-		    !will_fetch(head, item->util))
-			item->util = NULL;
-
-		item = NULL;
-
-		/* skip duplicates and refs that we already have */
-		if (string_list_has_string(&remote_refs, ref->name) ||
-		    string_list_has_string(&existing_refs, ref->name))
-			continue;
-
-		item = string_list_insert(ref->name, &remote_refs);
-		item->util = (void *)ref->old_sha1;
-	}
-	string_list_clear(&existing_refs, 0);
-
-	/*
-	 * We may have a final lightweight tag that needs to be
-	 * checked to see if it needs fetching.
-	 */
-	if (item && !has_sha1_file(item->util) &&
-	    !will_fetch(head, item->util))
-		item->util = NULL;
-
-	/*
-	 * For all the tags in the remote_refs string list, call
-	 * add_to_tail to add them to the list of refs to be fetched
-	 */
-	for_each_string_list(add_to_tail, &remote_refs, &data);
-
-	string_list_clear(&remote_refs, 0);
-}
-
 static void check_not_current_branch(struct ref *ref_map)
 {
 	struct branch *current_branch = branch_get(NULL);
@@ -704,9 +707,29 @@ static int truncate_fetch_head(void)
 	return 0;
 }
 
+static int need_additional_refs(struct ref *ref_map, struct string_list *peeled_map) {
+	int additional_refs = 0;
+	struct ref *ref;
+
+	for (ref = ref_map; ref; ref = ref->next) {
+		struct string_list_item *item;
+
+		if (!ref->automatic)
+			continue;
+		item = string_list_lookup(ref->name, peeled_map);
+		if (item && has_sha1_file(item->util)) {
+			ref->automatic = 0;
+			additional_refs = 1;
+		}
+	}
+
+	return additional_refs;
+}
+
 static int do_fetch(struct transport *transport,
 		    struct refspec *refs, int ref_count)
 {
+	struct string_list peeled_map = { NULL, 0, 0, 0 };
 	struct ref *ref_map;
 	int autotags = (transport->remote->fetch_tags == 1);
 
@@ -725,7 +748,7 @@ static int do_fetch(struct transport *transport,
 			return errcode;
 	}
 
-	ref_map = get_ref_map(transport, refs, ref_count, tags, &autotags);
+	ref_map = get_ref_map(transport, refs, ref_count, tags, &peeled_map, &autotags);
 	if (!update_head_ok)
 		check_not_current_branch(ref_map);
 
@@ -735,23 +758,20 @@ static int do_fetch(struct transport *transport,
 		free_refs(ref_map);
 		return 1;
 	}
-	if (prune)
-		prune_refs(transport, ref_map);
-	free_refs(ref_map);
-
-	/* if neither --no-tags nor --tags was specified, do automated tag
-	 * following ... */
-	if (tags == TAGS_DEFAULT && autotags) {
-		struct ref **tail = &ref_map;
-		ref_map = NULL;
-		find_non_local_tags(transport, &ref_map, &tail);
-		if (ref_map) {
-			transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
-			transport_set_option(transport, TRANS_OPT_DEPTH, "0");
-			fetch_refs(transport, ref_map);
+	if (need_additional_refs(ref_map, &peeled_map)) {
+		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
+		transport_set_option(transport, TRANS_OPT_DEPTH, "0");
+		if (fetch_refs(transport, ref_map)) {
+			free_refs(ref_map);
+			return 1;
 		}
-		free_refs(ref_map);
 	}
+	if (prune) {
+		discard_refs(&ref_map, 0, ref_is_automatic);
+		prune_refs(transport, ref_map);
+	}
+	string_list_clear(&peeled_map, 0);
+	free_refs(ref_map);
 
 	return 0;
 }
diff --git a/cache.h b/cache.h
index abfc682..1aa3000 100644
--- a/cache.h
+++ b/cache.h
@@ -870,7 +870,8 @@ struct ref {
 		merge:1,
 		nonfastforward:1,
 		deletion:1,
-		dont_fetch:1;
+		dont_fetch:1,
+		automatic:1;
 	enum {
 		REF_STATUS_NONE = 0,
 		REF_STATUS_OK,
-- 
1.7.0.2.273.gc2413
