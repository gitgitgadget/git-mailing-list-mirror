From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 3/8] Convert struct ref to use object_id.
Date: Tue,  9 Jun 2015 16:28:31 +0000
Message-ID: <1433867316-663554-4-git-send-email-sandals@crustytoothpaste.net>
References: <1433867316-663554-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 18:29:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2MP7-0001Qc-2G
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 18:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753911AbbFIQ3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 12:29:23 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:38335 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753565AbbFIQ3R (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 12:29:17 -0400
Received: from vauxhall.crustytoothpaste.net (107-1-110-101-ip-static.hfc.comcastbusiness.net [107.1.110.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6CF5728094;
	Tue,  9 Jun 2015 16:29:14 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1433867316-663554-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -1.5 BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271196>

Use struct object_id in three fields in struct ref and convert all the
necessary places that use it.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/clone.c        | 16 +++++++-------
 builtin/fetch-pack.c   |  4 ++--
 builtin/fetch.c        | 50 +++++++++++++++++++++----------------------
 builtin/ls-remote.c    |  2 +-
 builtin/receive-pack.c |  2 +-
 builtin/remote.c       | 12 +++++------
 connect.c              |  2 +-
 fetch-pack.c           | 18 ++++++++--------
 http-push.c            | 46 +++++++++++++++++++--------------------
 http.c                 |  2 +-
 remote-curl.c          | 10 ++++-----
 remote.c               | 58 +++++++++++++++++++++++++-------------------------
 remote.h               |  6 +++---
 send-pack.c            | 16 +++++++-------
 transport-helper.c     | 18 ++++++++--------
 transport.c            | 32 ++++++++++++++--------------
 transport.h            |  8 +++----
 walker.c               |  2 +-
 18 files changed, 152 insertions(+), 152 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index b878252..c909574 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -505,7 +505,7 @@ static void write_remote_refs(const struct ref *local_refs)
 	for (r = local_refs; r; r = r->next) {
 		if (!r->peer_ref)
 			continue;
-		add_packed_ref(r->peer_ref->name, r->old_sha1);
+		add_packed_ref(r->peer_ref->name, r->old_oid.hash);
 	}
 
 	if (commit_packed_refs())
@@ -520,9 +520,9 @@ static void write_followtags(const struct ref *refs, const char *msg)
 			continue;
 		if (ends_with(ref->name, "^{}"))
 			continue;
-		if (!has_sha1_file(ref->old_sha1))
+		if (!has_object_file(&ref->old_oid))
 			continue;
-		update_ref(msg, ref->name, ref->old_sha1,
+		update_ref(msg, ref->name, ref->old_oid.hash,
 			   NULL, 0, UPDATE_REFS_DIE_ON_ERR);
 	}
 }
@@ -542,7 +542,7 @@ static int iterate_ref_map(void *cb_data, unsigned char sha1[20])
 	if (!ref)
 		return -1;
 
-	hashcpy(sha1, ref->old_sha1);
+	hashcpy(sha1, ref->old_oid.hash);
 	*rm = ref->next;
 	return 0;
 }
@@ -591,12 +591,12 @@ static void update_head(const struct ref *our, const struct ref *remote,
 		/* Local default branch link */
 		create_symref("HEAD", our->name, NULL);
 		if (!option_bare) {
-			update_ref(msg, "HEAD", our->old_sha1, NULL, 0,
+			update_ref(msg, "HEAD", our->old_oid.hash, NULL, 0,
 				   UPDATE_REFS_DIE_ON_ERR);
 			install_branch_config(0, head, option_origin, our->name);
 		}
 	} else if (our) {
-		struct commit *c = lookup_commit_reference(our->old_sha1);
+		struct commit *c = lookup_commit_reference(our->old_oid.hash);
 		/* --branch specifies a non-branch (i.e. tags), detach HEAD */
 		update_ref(msg, "HEAD", c->object.sha1,
 			   NULL, REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
@@ -606,7 +606,7 @@ static void update_head(const struct ref *our, const struct ref *remote,
 		 * HEAD points to a branch but we don't know which one.
 		 * Detach HEAD in all these cases.
 		 */
-		update_ref(msg, "HEAD", remote->old_sha1,
+		update_ref(msg, "HEAD", remote->old_oid.hash,
 			   NULL, REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
 	}
 }
@@ -957,7 +957,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		 * remote HEAD check.
 		 */
 		for (ref = refs; ref; ref = ref->next)
-			if (is_null_sha1(ref->old_sha1)) {
+			if (is_null_oid(&ref->old_oid)) {
 				complete_refs_before_fetch = 0;
 				break;
 			}
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 4a6b340..19215b3 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -17,7 +17,7 @@ static void add_sought_entry_mem(struct ref ***sought, int *nr, int *alloc,
 	unsigned char sha1[20];
 
 	if (namelen > 41 && name[40] == ' ' && !get_sha1_hex(name, sha1)) {
-		hashcpy(ref->old_sha1, sha1);
+		hashcpy(ref->old_oid.hash, sha1);
 		name += 41;
 		namelen -= 41;
 	}
@@ -210,7 +210,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 
 	while (ref) {
 		printf("%s %s\n",
-		       sha1_to_hex(ref->old_sha1), ref->name);
+		       oid_to_hex(&ref->old_oid), ref->name);
 		ref = ref->next;
 	}
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8d5b2db..af42cde 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -195,7 +195,7 @@ static int will_fetch(struct ref **head, const unsigned char *sha1)
 {
 	struct ref *rm = *head;
 	while (rm) {
-		if (!hashcmp(rm->old_sha1, sha1))
+		if (!hashcmp(rm->old_oid.hash, sha1))
 			return 1;
 		rm = rm->next;
 	}
@@ -223,8 +223,8 @@ static void find_non_local_tags(struct transport *transport,
 		 * as one to ignore by setting util to NULL.
 		 */
 		if (ends_with(ref->name, "^{}")) {
-			if (item && !has_sha1_file(ref->old_sha1) &&
-			    !will_fetch(head, ref->old_sha1) &&
+			if (item && !has_object_file(&ref->old_oid) &&
+			    !will_fetch(head, ref->old_oid.hash) &&
 			    !has_sha1_file(item->util) &&
 			    !will_fetch(head, item->util))
 				item->util = NULL;
@@ -250,7 +250,7 @@ static void find_non_local_tags(struct transport *transport,
 			continue;
 
 		item = string_list_insert(&remote_refs, ref->name);
-		item->util = (void *)ref->old_sha1;
+		item->util = (void *)&ref->old_oid;
 	}
 	string_list_clear(&existing_refs, 1);
 
@@ -272,7 +272,7 @@ static void find_non_local_tags(struct transport *transport,
 		{
 			struct ref *rm = alloc_ref(item->string);
 			rm->peer_ref = alloc_ref(item->string);
-			hashcpy(rm->old_sha1, item->util);
+			oidcpy(&rm->old_oid, item->util);
 			**tail = rm;
 			*tail = &rm->next;
 		}
@@ -418,8 +418,8 @@ static int s_update_ref(const char *action,
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref->name,
-				   ref->new_sha1,
-				   check_old ? ref->old_sha1 : NULL,
+				   ref->new_oid.hash,
+				   check_old ? ref->old_oid.hash : NULL,
 				   0, msg, &err))
 		goto fail;
 
@@ -452,11 +452,11 @@ static int update_local_ref(struct ref *ref,
 	struct branch *current_branch = branch_get(NULL);
 	const char *pretty_ref = prettify_refname(ref->name);
 
-	type = sha1_object_info(ref->new_sha1, NULL);
+	type = sha1_object_info(ref->new_oid.hash, NULL);
 	if (type < 0)
-		die(_("object %s not found"), sha1_to_hex(ref->new_sha1));
+		die(_("object %s not found"), oid_to_hex(&ref->new_oid));
 
-	if (!hashcmp(ref->old_sha1, ref->new_sha1)) {
+	if (!oidcmp(&ref->old_oid, &ref->new_oid)) {
 		if (verbosity > 0)
 			strbuf_addf(display, "= %-*s %-*s -> %s",
 				    TRANSPORT_SUMMARY(_("[up to date]")),
@@ -467,7 +467,7 @@ static int update_local_ref(struct ref *ref,
 	if (current_branch &&
 	    !strcmp(ref->name, current_branch->name) &&
 	    !(update_head_ok || is_bare_repository()) &&
-	    !is_null_sha1(ref->old_sha1)) {
+	    !is_null_oid(&ref->old_oid)) {
 		/*
 		 * If this is the head, and it's not okay to update
 		 * the head, and the old value of the head isn't empty...
@@ -479,7 +479,7 @@ static int update_local_ref(struct ref *ref,
 		return 1;
 	}
 
-	if (!is_null_sha1(ref->old_sha1) &&
+	if (!is_null_oid(&ref->old_oid) &&
 	    starts_with(ref->name, "refs/tags/")) {
 		int r;
 		r = s_update_ref("updating tag", ref, 0);
@@ -491,8 +491,8 @@ static int update_local_ref(struct ref *ref,
 		return r;
 	}
 
-	current = lookup_commit_reference_gently(ref->old_sha1, 1);
-	updated = lookup_commit_reference_gently(ref->new_sha1, 1);
+	current = lookup_commit_reference_gently(ref->old_oid.hash, 1);
+	updated = lookup_commit_reference_gently(ref->new_oid.hash, 1);
 	if (!current || !updated) {
 		const char *msg;
 		const char *what;
@@ -516,7 +516,7 @@ static int update_local_ref(struct ref *ref,
 
 		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
 		    (recurse_submodules != RECURSE_SUBMODULES_ON))
-			check_for_new_submodule_commits(ref->new_sha1);
+			check_for_new_submodule_commits(ref->new_oid.hash);
 		r = s_update_ref(msg, ref, 0);
 		strbuf_addf(display, "%c %-*s %-*s -> %s%s",
 			    r ? '!' : '*',
@@ -531,10 +531,10 @@ static int update_local_ref(struct ref *ref,
 		int r;
 		strcpy(quickref, find_unique_abbrev(current->object.sha1, DEFAULT_ABBREV));
 		strcat(quickref, "..");
-		strcat(quickref, find_unique_abbrev(ref->new_sha1, DEFAULT_ABBREV));
+		strcat(quickref, find_unique_abbrev(ref->new_oid.hash, DEFAULT_ABBREV));
 		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
 		    (recurse_submodules != RECURSE_SUBMODULES_ON))
-			check_for_new_submodule_commits(ref->new_sha1);
+			check_for_new_submodule_commits(ref->new_oid.hash);
 		r = s_update_ref("fast-forward", ref, 1);
 		strbuf_addf(display, "%c %-*s %-*s -> %s%s",
 			    r ? '!' : ' ',
@@ -547,10 +547,10 @@ static int update_local_ref(struct ref *ref,
 		int r;
 		strcpy(quickref, find_unique_abbrev(current->object.sha1, DEFAULT_ABBREV));
 		strcat(quickref, "...");
-		strcat(quickref, find_unique_abbrev(ref->new_sha1, DEFAULT_ABBREV));
+		strcat(quickref, find_unique_abbrev(ref->new_oid.hash, DEFAULT_ABBREV));
 		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
 		    (recurse_submodules != RECURSE_SUBMODULES_ON))
-			check_for_new_submodule_commits(ref->new_sha1);
+			check_for_new_submodule_commits(ref->new_oid.hash);
 		r = s_update_ref("forced-update", ref, 1);
 		strbuf_addf(display, "%c %-*s %-*s -> %s  (%s)",
 			    r ? '!' : '+',
@@ -577,7 +577,7 @@ static int iterate_ref_map(void *cb_data, unsigned char sha1[20])
 	if (!ref)
 		return -1; /* end of the list */
 	*rm = ref->next;
-	hashcpy(sha1, ref->old_sha1);
+	hashcpy(sha1, ref->old_oid.hash);
 	return 0;
 }
 
@@ -628,7 +628,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				continue;
 			}
 
-			commit = lookup_commit_reference_gently(rm->old_sha1, 1);
+			commit = lookup_commit_reference_gently(rm->old_oid.hash, 1);
 			if (!commit)
 				rm->fetch_head_status = FETCH_HEAD_NOT_FOR_MERGE;
 
@@ -638,8 +638,8 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 			if (rm->peer_ref) {
 				ref = xcalloc(1, sizeof(*ref) + strlen(rm->peer_ref->name) + 1);
 				strcpy(ref->name, rm->peer_ref->name);
-				hashcpy(ref->old_sha1, rm->peer_ref->old_sha1);
-				hashcpy(ref->new_sha1, rm->old_sha1);
+				oidcpy(&ref->old_oid, &rm->peer_ref->old_oid);
+				oidcpy(&ref->new_oid, &rm->old_oid);
 				ref->force = rm->peer_ref->force;
 			}
 
@@ -684,7 +684,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				/* fall-through */
 			case FETCH_HEAD_MERGE:
 				fprintf(fp, "%s\t%s\t%s",
-					sha1_to_hex(rm->old_sha1),
+					oid_to_hex(&rm->old_oid),
 					merge_status_marker,
 					note.buf);
 				for (i = 0; i < url_len; ++i)
@@ -917,7 +917,7 @@ static int do_fetch(struct transport *transport,
 						   rm->peer_ref->name);
 			if (peer_item) {
 				struct object_id *old_oid = peer_item->util;
-				hashcpy(rm->peer_ref->old_sha1, old_oid->hash);
+				oidcpy(&rm->peer_ref->old_oid, old_oid);
 			}
 		}
 	}
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 4554dbc..db35e58 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -129,7 +129,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			continue;
 		if (!tail_match(pattern, ref->name))
 			continue;
-		printf("%s	%s\n", sha1_to_hex(ref->old_sha1), ref->name);
+		printf("%s	%s\n", oid_to_hex(&ref->old_oid), ref->name);
 		status = 0; /* we found something */
 	}
 	return status;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 94d0571..5941c78 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -222,7 +222,7 @@ static void show_one_alternate_sha1(const unsigned char sha1[20], void *unused)
 static void collect_one_alternate_ref(const struct ref *ref, void *data)
 {
 	struct sha1_array *sa = data;
-	sha1_array_append(sa, ref->old_sha1);
+	sha1_array_append(sa, ref->old_oid.hash);
 }
 
 static void write_head_info(void)
diff --git a/builtin/remote.c b/builtin/remote.c
index f4a6ec9..fa4d04c 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -395,7 +395,7 @@ static int get_push_ref_states(const struct ref *remote_refs,
 
 		if (!ref->peer_ref)
 			continue;
-		hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
+		oidcpy(&ref->new_oid, &ref->peer_ref->new_oid);
 
 		item = string_list_append(&states->push,
 					  abbrev_branch(ref->peer_ref->name));
@@ -404,14 +404,14 @@ static int get_push_ref_states(const struct ref *remote_refs,
 		info->forced = ref->force;
 		info->dest = xstrdup(abbrev_branch(ref->name));
 
-		if (is_null_sha1(ref->new_sha1)) {
+		if (is_null_oid(&ref->new_oid)) {
 			info->status = PUSH_STATUS_DELETE;
-		} else if (!hashcmp(ref->old_sha1, ref->new_sha1))
+		} else if (!oidcmp(&ref->old_oid, &ref->new_oid))
 			info->status = PUSH_STATUS_UPTODATE;
-		else if (is_null_sha1(ref->old_sha1))
+		else if (is_null_oid(&ref->old_oid))
 			info->status = PUSH_STATUS_CREATE;
-		else if (has_sha1_file(ref->old_sha1) &&
-			 ref_newer(ref->new_sha1, ref->old_sha1))
+		else if (has_object_file(&ref->old_oid) &&
+			 ref_newer(ref->new_oid.hash, ref->old_oid.hash))
 			info->status = PUSH_STATUS_FASTFORWARD;
 		else
 			info->status = PUSH_STATUS_OUTOFDATE;
diff --git a/connect.c b/connect.c
index c0144d8..f8b10eb 100644
--- a/connect.c
+++ b/connect.c
@@ -165,7 +165,7 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 		if (!check_ref(name, flags))
 			continue;
 		ref = alloc_ref(buffer + 41);
-		hashcpy(ref->old_sha1, old_sha1);
+		hashcpy(ref->old_oid.hash, old_sha1);
 		*list = ref;
 		list = &ref->next;
 		got_at_least_one_head = 1;
diff --git a/fetch-pack.c b/fetch-pack.c
index a912935..c02ea87 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -238,7 +238,7 @@ static void send_request(struct fetch_pack_args *args,
 
 static void insert_one_alternate_ref(const struct ref *ref, void *unused)
 {
-	rev_list_insert_ref(NULL, ref->old_sha1);
+	rev_list_insert_ref(NULL, ref->old_oid.hash);
 }
 
 #define INITIAL_FLUSH 16
@@ -280,7 +280,7 @@ static int find_common(struct fetch_pack_args *args,
 
 	fetching = 0;
 	for ( ; refs ; refs = refs->next) {
-		unsigned char *remote = refs->old_sha1;
+		unsigned char *remote = refs->old_oid.hash;
 		const char *remote_hex;
 		struct object *o;
 
@@ -570,7 +570,7 @@ static void filter_refs(struct fetch_pack_args *args,
 				continue;
 			if (get_sha1_hex(ref->name, sha1) ||
 			    ref->name[40] != '\0' ||
-			    hashcmp(sha1, ref->old_sha1))
+			    hashcmp(sha1, ref->old_oid.hash))
 				continue;
 
 			ref->matched = 1;
@@ -583,7 +583,7 @@ static void filter_refs(struct fetch_pack_args *args,
 
 static void mark_alternate_complete(const struct ref *ref, void *unused)
 {
-	mark_complete(ref->old_sha1);
+	mark_complete(ref->old_oid.hash);
 }
 
 static int everything_local(struct fetch_pack_args *args,
@@ -599,10 +599,10 @@ static int everything_local(struct fetch_pack_args *args,
 	for (ref = *refs; ref; ref = ref->next) {
 		struct object *o;
 
-		if (!has_sha1_file(ref->old_sha1))
+		if (!has_object_file(&ref->old_oid))
 			continue;
 
-		o = parse_object(ref->old_sha1);
+		o = parse_object(ref->old_oid.hash);
 		if (!o)
 			continue;
 
@@ -630,7 +630,7 @@ static int everything_local(struct fetch_pack_args *args,
 	 * Don't mark them common yet; the server has to be told so first.
 	 */
 	for (ref = *refs; ref; ref = ref->next) {
-		struct object *o = deref_tag(lookup_object(ref->old_sha1),
+		struct object *o = deref_tag(lookup_object(ref->old_oid.hash),
 					     NULL, 0);
 
 		if (!o || o->type != OBJ_COMMIT || !(o->flags & COMPLETE))
@@ -646,7 +646,7 @@ static int everything_local(struct fetch_pack_args *args,
 	filter_refs(args, refs, sought, nr_sought);
 
 	for (retval = 1, ref = *refs; ref ; ref = ref->next) {
-		const unsigned char *remote = ref->old_sha1;
+		const unsigned char *remote = ref->old_oid.hash;
 		struct object *o;
 
 		o = lookup_object(remote);
@@ -987,7 +987,7 @@ static void update_shallow(struct fetch_pack_args *args,
 	if (!si->nr_ours && !si->nr_theirs)
 		return;
 	for (i = 0; i < nr_sought; i++)
-		sha1_array_append(&ref, sought[i]->old_sha1);
+		sha1_array_append(&ref, sought[i]->old_oid.hash);
 	si->ref = &ref;
 
 	if (args->update_shallow) {
diff --git a/http-push.c b/http-push.c
index c98dad2..d054fdb 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1437,11 +1437,11 @@ static void one_remote_ref(const char *refname)
 	 * Fetch a copy of the object if it doesn't exist locally - it
 	 * may be required for updating server info later.
 	 */
-	if (repo->can_update_info_refs && !has_sha1_file(ref->old_sha1)) {
-		obj = lookup_unknown_object(ref->old_sha1);
+	if (repo->can_update_info_refs && !has_object_file(&ref->old_oid)) {
+		obj = lookup_unknown_object(ref->old_oid.hash);
 		if (obj) {
 			fprintf(stderr,	"  fetch %s for %s\n",
-				sha1_to_hex(ref->old_sha1), refname);
+				oid_to_hex(&ref->old_oid), refname);
 			add_fetch_request(obj);
 		}
 	}
@@ -1474,11 +1474,11 @@ static void add_remote_info_ref(struct remote_ls_ctx *ls)
 		return;
 	}
 
-	o = parse_object(ref->old_sha1);
+	o = parse_object(ref->old_oid.hash);
 	if (!o) {
 		fprintf(stderr,
 			"Unable to parse object %s for remote ref %s\n",
-			sha1_to_hex(ref->old_sha1), ls->dentry_name);
+			oid_to_hex(&ref->old_oid), ls->dentry_name);
 		aborted = 1;
 		free(ref);
 		return;
@@ -1487,7 +1487,7 @@ static void add_remote_info_ref(struct remote_ls_ctx *ls)
 	len = strlen(ls->dentry_name) + 42;
 	ref_info = xcalloc(len + 1, 1);
 	sprintf(ref_info, "%s	%s\n",
-		sha1_to_hex(ref->old_sha1), ls->dentry_name);
+		oid_to_hex(&ref->old_oid), ls->dentry_name);
 	fwrite_buffer(ref_info, 1, len, buf);
 	free(ref_info);
 
@@ -1591,7 +1591,7 @@ static void fetch_symref(const char *path, char **symref, unsigned char *sha1)
 static int verify_merge_base(unsigned char *head_sha1, struct ref *remote)
 {
 	struct commit *head = lookup_commit_or_die(head_sha1, "HEAD");
-	struct commit *branch = lookup_commit_or_die(remote->old_sha1, remote->name);
+	struct commit *branch = lookup_commit_or_die(remote->old_oid.hash, remote->name);
 
 	return in_merge_bases(branch, head);
 }
@@ -1654,11 +1654,11 @@ static int delete_remote_branch(const char *pattern, int force)
 			return error("Remote HEAD resolves to object %s\nwhich does not exist locally, perhaps you need to fetch?", sha1_to_hex(head_sha1));
 
 		/* Remote branch must resolve to a known object */
-		if (is_null_sha1(remote_ref->old_sha1))
+		if (is_null_oid(&remote_ref->old_oid))
 			return error("Unable to resolve remote branch %s",
 				     remote_ref->name);
-		if (!has_sha1_file(remote_ref->old_sha1))
-			return error("Remote branch %s resolves to object %s\nwhich does not exist locally, perhaps you need to fetch?", remote_ref->name, sha1_to_hex(remote_ref->old_sha1));
+		if (!has_object_file(&remote_ref->old_oid))
+			return error("Remote branch %s resolves to object %s\nwhich does not exist locally, perhaps you need to fetch?", remote_ref->name, oid_to_hex(&remote_ref->old_oid));
 
 		/* Remote branch must be an ancestor of remote HEAD */
 		if (!verify_merge_base(head_sha1, remote_ref)) {
@@ -1874,7 +1874,7 @@ int main(int argc, char **argv)
 		if (!ref->peer_ref)
 			continue;
 
-		if (is_null_sha1(ref->peer_ref->new_sha1)) {
+		if (is_null_oid(&ref->peer_ref->new_oid)) {
 			if (delete_remote_branch(ref->name, 1) == -1) {
 				error("Could not remove %s", ref->name);
 				if (helper_status)
@@ -1887,7 +1887,7 @@ int main(int argc, char **argv)
 			continue;
 		}
 
-		if (!hashcmp(ref->old_sha1, ref->peer_ref->new_sha1)) {
+		if (!oidcmp(&ref->old_oid, &ref->peer_ref->new_oid)) {
 			if (push_verbosely)
 				fprintf(stderr, "'%s': up-to-date\n", ref->name);
 			if (helper_status)
@@ -1896,11 +1896,11 @@ int main(int argc, char **argv)
 		}
 
 		if (!force_all &&
-		    !is_null_sha1(ref->old_sha1) &&
+		    !is_null_oid(&ref->old_oid) &&
 		    !ref->force) {
-			if (!has_sha1_file(ref->old_sha1) ||
-			    !ref_newer(ref->peer_ref->new_sha1,
-				       ref->old_sha1)) {
+			if (!has_object_file(&ref->old_oid) ||
+			    !ref_newer(ref->peer_ref->new_oid.hash,
+				       ref->old_oid.hash)) {
 				/*
 				 * We do not have the remote ref, or
 				 * we know that the remote ref is not
@@ -1921,10 +1921,10 @@ int main(int argc, char **argv)
 				continue;
 			}
 		}
-		hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
+		oidcpy(&ref->new_oid, &ref->peer_ref->new_oid);
 		new_refs++;
-		strcpy(old_hex, sha1_to_hex(ref->old_sha1));
-		new_hex = sha1_to_hex(ref->new_sha1);
+		strcpy(old_hex, oid_to_hex(&ref->old_oid));
+		new_hex = oid_to_hex(&ref->new_oid);
 
 		fprintf(stderr, "updating '%s'", ref->name);
 		if (strcmp(ref->name, ref->peer_ref->name))
@@ -1949,14 +1949,14 @@ int main(int argc, char **argv)
 
 		/* Set up revision info for this refspec */
 		commit_argc = 3;
-		new_sha1_hex = xstrdup(sha1_to_hex(ref->new_sha1));
+		new_sha1_hex = xstrdup(oid_to_hex(&ref->new_oid));
 		old_sha1_hex = NULL;
 		commit_argv[1] = "--objects";
 		commit_argv[2] = new_sha1_hex;
-		if (!push_all && !is_null_sha1(ref->old_sha1)) {
+		if (!push_all && !is_null_oid(&ref->old_oid)) {
 			old_sha1_hex = xmalloc(42);
 			sprintf(old_sha1_hex, "^%s",
-				sha1_to_hex(ref->old_sha1));
+				oid_to_hex(&ref->old_oid));
 			commit_argv[3] = old_sha1_hex;
 			commit_argc++;
 		}
@@ -1988,7 +1988,7 @@ int main(int argc, char **argv)
 		run_request_queue();
 
 		/* Update the remote branch if all went well */
-		if (aborted || !update_remote(ref->new_sha1, ref_lock))
+		if (aborted || !update_remote(ref->new_oid.hash, ref_lock))
 			rc = 1;
 
 		if (!rc)
diff --git a/http.c b/http.c
index f0c5bbc..96b7863 100644
--- a/http.c
+++ b/http.c
@@ -1338,7 +1338,7 @@ int http_fetch_ref(const char *base, struct ref *ref)
 	if (http_get_strbuf(url, &buffer, &options) == HTTP_OK) {
 		strbuf_rtrim(&buffer);
 		if (buffer.len == 40)
-			ret = get_sha1_hex(buffer.buf, ref->old_sha1);
+			ret = get_oid_hex(buffer.buf, &ref->old_oid);
 		else if (starts_with(buffer.buf, "ref: ")) {
 			ref->symref = xstrdup(buffer.buf + 5);
 			ret = 0;
diff --git a/remote-curl.c b/remote-curl.c
index af7b678..80cb4c7 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -168,7 +168,7 @@ static struct ref *parse_info_refs(struct discovery *heads)
 				      strlen(ref_name) + 1);
 			memset(ref, 0, sizeof(struct ref));
 			strcpy(ref->name, ref_name);
-			get_sha1_hex(start, ref->old_sha1);
+			get_oid_hex(start, &ref->old_oid);
 			if (!refs)
 				refs = ref;
 			if (last_ref)
@@ -347,7 +347,7 @@ static void output_refs(struct ref *refs)
 		if (posn->symref)
 			printf("@%s %s\n", posn->symref, posn->name);
 		else
-			printf("%s %s\n", sha1_to_hex(posn->old_sha1), posn->name);
+			printf("%s %s\n", oid_to_hex(&posn->old_oid), posn->name);
 	}
 	printf("\n");
 	fflush(stdout);
@@ -701,7 +701,7 @@ static int fetch_dumb(int nr_heads, struct ref **to_fetch)
 	if (options.depth)
 		die("dumb http transport does not support --depth");
 	for (i = 0; i < nr_heads; i++)
-		targets[i] = xstrdup(sha1_to_hex(to_fetch[i]->old_sha1));
+		targets[i] = xstrdup(oid_to_hex(&to_fetch[i]->old_oid));
 
 	walker = get_http_walker(url.buf);
 	walker->get_all = 1;
@@ -762,7 +762,7 @@ static int fetch_git(struct discovery *heads,
 		if (!*ref->name)
 			die("cannot fetch by sha1 over smart http");
 		packet_buf_write(&preamble, "%s %s\n",
-				 sha1_to_hex(ref->old_sha1), ref->name);
+				 oid_to_hex(&ref->old_oid), ref->name);
 	}
 	packet_buf_flush(&preamble);
 
@@ -814,7 +814,7 @@ static void parse_fetch(struct strbuf *buf)
 				die("protocol error: expected sha/ref, got %s'", p);
 
 			ref = alloc_ref(name);
-			hashcpy(ref->old_sha1, old_sha1);
+			hashcpy(ref->old_oid.hash, old_sha1);
 
 			*list = ref;
 			list = &ref->next;
diff --git a/remote.c b/remote.c
index 26504b7..706d2fb 100644
--- a/remote.c
+++ b/remote.c
@@ -1111,7 +1111,7 @@ static void tail_link_ref(struct ref *ref, struct ref ***tail)
 static struct ref *alloc_delete_ref(void)
 {
 	struct ref *ref = alloc_ref("(delete)");
-	hashclr(ref->new_sha1);
+	oidclr(&ref->new_oid);
 	return ref;
 }
 
@@ -1131,7 +1131,7 @@ static int try_explicit_object_name(const char *name,
 
 	if (match) {
 		*match = alloc_ref(name);
-		hashcpy((*match)->new_sha1, sha1);
+		hashcpy((*match)->new_oid.hash, sha1);
 	}
 	return 0;
 }
@@ -1226,7 +1226,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	case 0:
 		if (starts_with(dst_value, "refs/"))
 			matched_dst = make_linked_ref(dst_value, dst_tail);
-		else if (is_null_sha1(matched_src->new_sha1))
+		else if (is_null_oid(&matched_src->new_oid))
 			error("unable to delete '%s': remote ref does not exist",
 			      dst_value);
 		else if ((dst_guess = guess_ref(dst_value, matched_src)))
@@ -1357,10 +1357,10 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 	memset(&sent_tips, 0, sizeof(sent_tips));
 	for (ref = *dst; ref; ref = ref->next) {
 		if (ref->peer_ref &&
-		    !is_null_sha1(ref->peer_ref->new_sha1))
-			add_to_tips(&sent_tips, ref->peer_ref->new_sha1);
+		    !is_null_oid(&ref->peer_ref->new_oid))
+			add_to_tips(&sent_tips, ref->peer_ref->new_oid.hash);
 		else
-			add_to_tips(&sent_tips, ref->old_sha1);
+			add_to_tips(&sent_tips, ref->old_oid.hash);
 		if (starts_with(ref->name, "refs/tags/"))
 			string_list_append(&dst_tag, ref->name);
 	}
@@ -1374,7 +1374,7 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 			continue; /* not a tag */
 		if (string_list_has_string(&dst_tag, ref->name))
 			continue; /* they already have it */
-		if (sha1_object_info(ref->new_sha1, NULL) != OBJ_TAG)
+		if (sha1_object_info(ref->new_oid.hash, NULL) != OBJ_TAG)
 			continue; /* be conservative */
 		item = string_list_append(&src_tag, ref->name);
 		item->util = ref;
@@ -1394,9 +1394,9 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 			struct ref *dst_ref;
 			struct commit *commit;
 
-			if (is_null_sha1(ref->new_sha1))
+			if (is_null_oid(&ref->new_oid))
 				continue;
-			commit = lookup_commit_reference_gently(ref->new_sha1, 1);
+			commit = lookup_commit_reference_gently(ref->new_oid.hash, 1);
 			if (!commit)
 				/* not pushing a commit, which is not an error */
 				continue;
@@ -1410,7 +1410,7 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 
 			/* Add it in */
 			dst_ref = make_linked_ref(ref->name, dst_tail);
-			hashcpy(dst_ref->new_sha1, ref->new_sha1);
+			oidcpy(&dst_ref->new_oid, &ref->new_oid);
 			dst_ref->peer_ref = copy_ref(ref);
 		}
 	}
@@ -1517,7 +1517,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
 
 			/* Create a new one and link it */
 			dst_peer = make_linked_ref(dst_name, &dst_tail);
-			hashcpy(dst_peer->new_sha1, ref->new_sha1);
+			oidcpy(&dst_peer->new_oid, &ref->new_oid);
 			string_list_insert(&dst_ref_index,
 				dst_peer->name)->util = dst_peer;
 		}
@@ -1569,13 +1569,13 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		int reject_reason = 0;
 
 		if (ref->peer_ref)
-			hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
+			oidcpy(&ref->new_oid, &ref->peer_ref->new_oid);
 		else if (!send_mirror)
 			continue;
 
-		ref->deletion = is_null_sha1(ref->new_sha1);
+		ref->deletion = is_null_oid(&ref->new_oid);
 		if (!ref->deletion &&
-			!hashcmp(ref->old_sha1, ref->new_sha1)) {
+			!oidcmp(&ref->old_oid, &ref->new_oid)) {
 			ref->status = REF_STATUS_UPTODATE;
 			continue;
 		}
@@ -1594,7 +1594,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		 */
 		if (ref->expect_old_sha1) {
 			if (ref->expect_old_no_trackback ||
-			    hashcmp(ref->old_sha1, ref->old_sha1_expect))
+			    oidcmp(&ref->old_oid, &ref->old_oid_expect))
 				reject_reason = REF_STATUS_REJECT_STALE;
 		}
 
@@ -1618,15 +1618,15 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		 *     passing the --force argument
 		 */
 
-		else if (!ref->deletion && !is_null_sha1(ref->old_sha1)) {
+		else if (!ref->deletion && !is_null_oid(&ref->old_oid)) {
 			if (starts_with(ref->name, "refs/tags/"))
 				reject_reason = REF_STATUS_REJECT_ALREADY_EXISTS;
-			else if (!has_sha1_file(ref->old_sha1))
+			else if (!has_object_file(&ref->old_oid))
 				reject_reason = REF_STATUS_REJECT_FETCH_FIRST;
-			else if (!lookup_commit_reference_gently(ref->old_sha1, 1) ||
-				 !lookup_commit_reference_gently(ref->new_sha1, 1))
+			else if (!lookup_commit_reference_gently(ref->old_oid.hash, 1) ||
+				 !lookup_commit_reference_gently(ref->new_oid.hash, 1))
 				reject_reason = REF_STATUS_REJECT_NEEDS_FORCE;
-			else if (!ref_newer(ref->new_sha1, ref->old_sha1))
+			else if (!ref_newer(ref->new_oid.hash, ref->old_oid.hash))
 				reject_reason = REF_STATUS_REJECT_NONFASTFORWARD;
 		}
 
@@ -1925,7 +1925,7 @@ int get_fetch_map(const struct ref *remote_refs,
 
 		if (refspec->exact_sha1) {
 			ref_map = alloc_ref(name);
-			get_sha1_hex(name, ref_map->old_sha1);
+			get_oid_hex(name, &ref_map->old_oid);
 		} else {
 			ref_map = get_remote_ref(remote_refs, name);
 		}
@@ -1966,7 +1966,7 @@ int resolve_remote_symref(struct ref *ref, struct ref *list)
 		return 0;
 	for (; list; list = list->next)
 		if (!strcmp(ref->symref, list->name)) {
-			hashcpy(ref->old_sha1, list->old_sha1);
+			oidcpy(&ref->old_oid, &list->old_oid);
 			return 0;
 		}
 	return 1;
@@ -2181,7 +2181,7 @@ static int one_local_ref(const char *refname, const struct object_id *oid,
 
 	len = strlen(refname) + 1;
 	ref = xcalloc(1, sizeof(*ref) + len);
-	hashcpy(ref->new_sha1, oid->hash);
+	hashcpy(ref->new_oid.hash, oid->hash);
 	memcpy(ref->name, refname, len);
 	**local_tail = ref;
 	*local_tail = &ref->next;
@@ -2218,7 +2218,7 @@ struct ref *guess_remote_head(const struct ref *head,
 	/* If refs/heads/master could be right, it is. */
 	if (!all) {
 		r = find_ref_by_name(refs, "refs/heads/master");
-		if (r && !hashcmp(r->old_sha1, head->old_sha1))
+		if (r && !oidcmp(&r->old_oid, &head->old_oid))
 			return copy_ref(r);
 	}
 
@@ -2226,7 +2226,7 @@ struct ref *guess_remote_head(const struct ref *head,
 	for (r = refs; r; r = r->next) {
 		if (r != head &&
 		    starts_with(r->name, "refs/heads/") &&
-		    !hashcmp(r->old_sha1, head->old_sha1)) {
+		    !oidcmp(&r->old_oid, &head->old_oid)) {
 			*tail = copy_ref(r);
 			tail = &((*tail)->next);
 			if (!all)
@@ -2274,7 +2274,7 @@ static int get_stale_heads_cb(const char *refname, const struct object_id *oid,
 
 	if (stale) {
 		struct ref *ref = make_linked_ref(refname, &info->stale_refs_tail);
-		hashcpy(ref->new_sha1, oid->hash);
+		oidcpy(&ref->new_oid, oid);
 	}
 
 clean_exit:
@@ -2394,8 +2394,8 @@ static void apply_cas(struct push_cas_option *cas,
 			continue;
 		ref->expect_old_sha1 = 1;
 		if (!entry->use_tracking)
-			hashcpy(ref->old_sha1_expect, cas->entry[i].expect);
-		else if (remote_tracking(remote, ref->name, ref->old_sha1_expect))
+			hashcpy(ref->old_oid_expect.hash, cas->entry[i].expect);
+		else if (remote_tracking(remote, ref->name, ref->old_oid_expect.hash))
 			ref->expect_old_no_trackback = 1;
 		return;
 	}
@@ -2405,7 +2405,7 @@ static void apply_cas(struct push_cas_option *cas,
 		return;
 
 	ref->expect_old_sha1 = 1;
-	if (remote_tracking(remote, ref->name, ref->old_sha1_expect))
+	if (remote_tracking(remote, ref->name, ref->old_oid_expect.hash))
 		ref->expect_old_no_trackback = 1;
 }
 
diff --git a/remote.h b/remote.h
index 312b7ca..163ea5e 100644
--- a/remote.h
+++ b/remote.h
@@ -79,9 +79,9 @@ extern const struct refspec *tag_refspec;
 
 struct ref {
 	struct ref *next;
-	unsigned char old_sha1[20];
-	unsigned char new_sha1[20];
-	unsigned char old_sha1_expect[20]; /* used by expect-old */
+	struct object_id old_oid;
+	struct object_id new_oid;
+	struct object_id old_oid_expect; /* used by expect-old */
 	char *symref;
 	unsigned int
 		force:1,
diff --git a/send-pack.c b/send-pack.c
index 2a64fec..ae3a104 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -79,11 +79,11 @@ static int pack_objects(int fd, struct ref *refs, struct sha1_array *extra, stru
 			break;
 
 	while (refs) {
-		if (!is_null_sha1(refs->old_sha1) &&
-		    !feed_object(refs->old_sha1, po.in, 1))
+		if (!is_null_oid(&refs->old_oid) &&
+		    !feed_object(refs->old_oid.hash, po.in, 1))
 			break;
-		if (!is_null_sha1(refs->new_sha1) &&
-		    !feed_object(refs->new_sha1, po.in, 0))
+		if (!is_null_oid(&refs->new_oid) &&
+		    !feed_object(refs->new_oid.hash, po.in, 0))
 			break;
 		refs = refs->next;
 	}
@@ -261,8 +261,8 @@ static int generate_push_cert(struct strbuf *req_buf,
 			continue;
 		update_seen = 1;
 		strbuf_addf(&cert, "%s %s %s\n",
-			    sha1_to_hex(ref->old_sha1),
-			    sha1_to_hex(ref->new_sha1),
+			    oid_to_hex(&ref->old_oid),
+			    oid_to_hex(&ref->new_oid),
 			    ref->name);
 	}
 	if (!update_seen)
@@ -458,8 +458,8 @@ int send_pack(struct send_pack_args *args,
 		if (check_to_send_update(ref, args) < 0)
 			continue;
 
-		old_hex = sha1_to_hex(ref->old_sha1);
-		new_hex = sha1_to_hex(ref->new_sha1);
+		old_hex = oid_to_hex(&ref->old_oid);
+		new_hex = oid_to_hex(&ref->new_oid);
 		if (!cmds_sent) {
 			packet_buf_write(&req_buf,
 					 "%s %s %s%c%s",
diff --git a/transport-helper.c b/transport-helper.c
index 5d99a6b..4ca3e80 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -347,7 +347,7 @@ static int fetch_with_fetch(struct transport *transport,
 			continue;
 
 		strbuf_addf(&buf, "fetch %s %s\n",
-			    sha1_to_hex(posn->old_sha1),
+			    oid_to_hex(&posn->old_oid),
 			    posn->symref ? posn->symref : posn->name);
 	}
 
@@ -490,7 +490,7 @@ static int fetch_with_import(struct transport *transport,
 		else
 			private = xstrdup(name);
 		if (private) {
-			read_ref(private, posn->old_sha1);
+			read_ref(private, posn->old_oid.hash);
 			free(private);
 		}
 	}
@@ -756,7 +756,7 @@ static int push_update_refs_status(struct helper_data *data,
 		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
 		if (!private)
 			continue;
-		update_ref("update by helper", private, ref->new_sha1, NULL, 0, 0);
+		update_ref("update by helper", private, ref->new_oid.hash, NULL, 0, 0);
 		free(private);
 	}
 	strbuf_release(&buf);
@@ -803,7 +803,7 @@ static int push_refs_with_push(struct transport *transport,
 			if (ref->peer_ref)
 				strbuf_addstr(&buf, ref->peer_ref->name);
 			else
-				strbuf_addstr(&buf, sha1_to_hex(ref->new_sha1));
+				strbuf_addstr(&buf, oid_to_hex(&ref->new_oid));
 		}
 		strbuf_addch(&buf, ':');
 		strbuf_addstr(&buf, ref->name);
@@ -812,14 +812,14 @@ static int push_refs_with_push(struct transport *transport,
 		/*
 		 * The "--force-with-lease" options without explicit
 		 * values to expect have already been expanded into
-		 * the ref->old_sha1_expect[] field; we can ignore
+		 * the ref->old_oid_expect[] field; we can ignore
 		 * transport->smart_options->cas altogether and instead
 		 * can enumerate them from the refs.
 		 */
 		if (ref->expect_old_sha1) {
 			struct strbuf cas = STRBUF_INIT;
 			strbuf_addf(&cas, "%s:%s",
-				    ref->name, sha1_to_hex(ref->old_sha1_expect));
+				    ref->name, oid_to_hex(&ref->old_oid_expect));
 			string_list_append(&cas_options, strbuf_detach(&cas, NULL));
 		}
 	}
@@ -883,7 +883,7 @@ static int push_refs_with_export(struct transport *transport,
 		if (private && !get_sha1(private, sha1)) {
 			strbuf_addf(&buf, "^%s", private);
 			string_list_append(&revlist_args, strbuf_detach(&buf, NULL));
-			hashcpy(ref->old_sha1, sha1);
+			hashcpy(ref->old_oid.hash, sha1);
 		}
 		free(private);
 
@@ -1015,11 +1015,11 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 		if (buf.buf[0] == '@')
 			(*tail)->symref = xstrdup(buf.buf + 1);
 		else if (buf.buf[0] != '?')
-			get_sha1_hex(buf.buf, (*tail)->old_sha1);
+			get_oid_hex(buf.buf, &(*tail)->old_oid);
 		if (eon) {
 			if (has_attribute(eon + 1, "unchanged")) {
 				(*tail)->status |= REF_STATUS_UPTODATE;
-				read_ref((*tail)->name, (*tail)->old_sha1);
+				read_ref((*tail)->name, (*tail)->old_oid.hash);
 			}
 		}
 		tail = &((*tail)->next);
diff --git a/transport.c b/transport.c
index 40692f8..e880d94 100644
--- a/transport.c
+++ b/transport.c
@@ -79,7 +79,7 @@ static int read_loose_refs(struct strbuf *path, int name_offset,
 				continue;
 			next = alloc_ref(path->buf + name_offset);
 			if (read_in_full(fd, buffer, 40) != 40 ||
-					get_sha1_hex(buffer, next->old_sha1)) {
+					get_oid_hex(buffer, &next->old_oid)) {
 				close(fd);
 				free(next);
 				continue;
@@ -131,7 +131,7 @@ static void insert_packed_refs(const char *packed_refs, struct ref **list)
 		if (!(*list)->next || cmp < 0) {
 			struct ref *next = alloc_ref(buffer + 41);
 			buffer[40] = '\0';
-			if (get_sha1_hex(buffer, next->old_sha1)) {
+			if (get_oid_hex(buffer, &next->old_oid)) {
 				warning ("invalid SHA-1: %s", buffer);
 				free(next);
 				continue;
@@ -162,7 +162,7 @@ static void set_upstreams(struct transport *transport, struct ref *refs,
 			continue;
 		if (!ref->peer_ref)
 			continue;
-		if (is_null_sha1(ref->new_sha1))
+		if (is_null_oid(&ref->new_oid))
 			continue;
 
 		/* Follow symbolic refs (mainly for HEAD). */
@@ -412,7 +412,7 @@ static struct ref *get_refs_from_bundle(struct transport *transport, int for_pus
 	for (i = 0; i < data->header.references.nr; i++) {
 		struct ref_list_entry *e = data->header.references.list + i;
 		struct ref *ref = alloc_ref(e->name);
-		hashcpy(ref->old_sha1, e->sha1);
+		hashcpy(ref->old_oid.hash, e->sha1);
 		ref->next = result;
 		result = ref;
 	}
@@ -611,7 +611,7 @@ void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int v
 			delete_ref(rs.dst, NULL, 0);
 		} else
 			update_ref("update by push", rs.dst,
-					ref->new_sha1, NULL, 0, 0);
+					ref->new_oid.hash, NULL, 0, 0);
 		free(rs.dst);
 	}
 }
@@ -651,7 +651,7 @@ static void print_ok_ref_status(struct ref *ref, int porcelain)
 {
 	if (ref->deletion)
 		print_ref_status('-', "[deleted]", ref, NULL, NULL, porcelain);
-	else if (is_null_sha1(ref->old_sha1))
+	else if (is_null_oid(&ref->old_oid))
 		print_ref_status('*',
 			(starts_with(ref->name, "refs/tags/") ? "[new tag]" :
 			"[new branch]"),
@@ -661,7 +661,7 @@ static void print_ok_ref_status(struct ref *ref, int porcelain)
 		char type;
 		const char *msg;
 
-		strcpy(quickref, status_abbrev(ref->old_sha1));
+		strcpy(quickref, status_abbrev(ref->old_oid.hash));
 		if (ref->forced_update) {
 			strcat(quickref, "...");
 			type = '+';
@@ -671,7 +671,7 @@ static void print_ok_ref_status(struct ref *ref, int porcelain)
 			type = ' ';
 			msg = NULL;
 		}
-		strcat(quickref, status_abbrev(ref->new_sha1));
+		strcat(quickref, status_abbrev(ref->new_oid.hash));
 
 		print_ref_status(type, quickref, ref, ref->peer_ref, msg, porcelain);
 	}
@@ -1092,8 +1092,8 @@ static int run_pre_push_hook(struct transport *transport,
 
 		strbuf_reset(&buf);
 		strbuf_addf( &buf, "%s %s %s %s\n",
-			 r->peer_ref->name, sha1_to_hex(r->new_sha1),
-			 r->name, sha1_to_hex(r->old_sha1));
+			 r->peer_ref->name, oid_to_hex(&r->new_oid),
+			 r->name, oid_to_hex(&r->old_oid));
 
 		if (write_in_full(proc.in, buf.buf, buf.len) != buf.len) {
 			ret = -1;
@@ -1173,8 +1173,8 @@ int transport_push(struct transport *transport,
 		if ((flags & TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND) && !is_bare_repository()) {
 			struct ref *ref = remote_refs;
 			for (; ref; ref = ref->next)
-				if (!is_null_sha1(ref->new_sha1) &&
-				    !push_unpushed_submodules(ref->new_sha1,
+				if (!is_null_oid(&ref->new_oid) &&
+				    !push_unpushed_submodules(ref->new_oid.hash,
 					    transport->remote->name))
 				    die ("Failed to push all needed submodules!");
 		}
@@ -1185,8 +1185,8 @@ int transport_push(struct transport *transport,
 			struct string_list needs_pushing = STRING_LIST_INIT_DUP;
 
 			for (; ref; ref = ref->next)
-				if (!is_null_sha1(ref->new_sha1) &&
-				    find_unpushed_submodules(ref->new_sha1,
+				if (!is_null_oid(&ref->new_oid) &&
+				    find_unpushed_submodules(ref->new_oid.hash,
 					    transport->remote->name, &needs_pushing))
 					die_with_unpushed_submodules(&needs_pushing);
 		}
@@ -1239,8 +1239,8 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 	for (rm = refs; rm; rm = rm->next) {
 		nr_refs++;
 		if (rm->peer_ref &&
-		    !is_null_sha1(rm->old_sha1) &&
-		    !hashcmp(rm->peer_ref->old_sha1, rm->old_sha1))
+		    !is_null_oid(&rm->old_oid) &&
+		    !oidcmp(&rm->peer_ref->old_oid, &rm->old_oid))
 			continue;
 		ALLOC_GROW(heads, nr_heads + 1, nr_alloc);
 		heads[nr_heads++] = rm;
diff --git a/transport.h b/transport.h
index 18d2cf8..4a4aaac 100644
--- a/transport.h
+++ b/transport.h
@@ -75,15 +75,15 @@ struct transport {
 	/**
 	 * Push the objects and refs. Send the necessary objects, and
 	 * then, for any refs where peer_ref is set and
-	 * peer_ref->new_sha1 is different from old_sha1, tell the
-	 * remote side to update each ref in the list from old_sha1 to
-	 * peer_ref->new_sha1.
+	 * peer_ref->new_oid is different from old_oid, tell the
+	 * remote side to update each ref in the list from old_oid to
+	 * peer_ref->new_oid.
 	 *
 	 * Where possible, set the status for each ref appropriately.
 	 *
 	 * The transport must modify new_sha1 in the ref to the new
 	 * value if the remote accepted the change. Note that this
-	 * could be a different value from peer_ref->new_sha1 if the
+	 * could be a different value from peer_ref->new_oid if the
 	 * process involved generating new commits.
 	 **/
 	int (*push_refs)(struct transport *transport, struct ref *refs, int flags);
diff --git a/walker.c b/walker.c
index 44a936c..14f71c0 100644
--- a/walker.c
+++ b/walker.c
@@ -191,7 +191,7 @@ static int interpret_target(struct walker *walker, char *target, unsigned char *
 	if (!check_refname_format(target, 0)) {
 		struct ref *ref = alloc_ref(target);
 		if (!walker->fetch_ref(walker, ref)) {
-			hashcpy(sha1, ref->old_sha1);
+			hashcpy(sha1, ref->old_oid.hash);
 			free(ref);
 			return 0;
 		}
-- 
2.4.0
