From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 08/16] refs: convert for_each_ref to struct object_id
Date: Wed, 22 Apr 2015 23:24:13 +0000
Message-ID: <1429745061-295908-9-git-send-email-sandals@crustytoothpaste.net>
References: <1429745061-295908-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 01:24:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl40b-0003ew-56
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 01:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbbDVXYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 19:24:41 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:44772 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758565AbbDVXYc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 19:24:32 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id F2231282AD;
	Wed, 22 Apr 2015 23:24:30 +0000 (UTC)
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1429745061-295908-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267655>

Convert for_each_ref, for_each_glob_ref, and for_each_glob_ref_in to use
struct object_id, as the latter two call the former with the function
pointer they are provided.

Convert callers to refer to properly-typed functions.  Convert uses of
the constant 20 to GIT_SHA1_RAWSZ.  Where possible, convert modified
functions to use struct object_id instead of unsigned char [20].

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/checkout.c     |  4 ++--
 builtin/fetch.c        |  6 +++---
 builtin/name-rev.c     |  6 +++---
 builtin/pack-objects.c | 10 +++++-----
 builtin/receive-pack.c |  4 ++--
 builtin/reflog.c       |  6 +++---
 builtin/remote.c       | 14 +++++++-------
 builtin/rev-parse.c    | 10 +++++-----
 builtin/show-branch.c  | 24 ++++++++++++------------
 builtin/show-ref.c     |  4 ++--
 fetch-pack.c           | 18 ++++++++++++++----
 help.c                 |  2 +-
 log-tree.c             |  2 +-
 notes.c                |  2 +-
 reachable.c            |  2 +-
 refs.c                 | 16 ++++++++--------
 refs.h                 |  6 +++---
 remote.c               |  8 ++++----
 revision.c             |  8 ++++----
 server-info.c          |  6 +++---
 sha1_name.c            |  4 ++--
 shallow.c              |  6 +++---
 submodule.c            |  4 ++--
 transport.c            | 10 +++++-----
 walker.c               |  4 ++--
 25 files changed, 98 insertions(+), 88 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2f92328..9b49f0e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -702,10 +702,10 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 }
 
 static int add_pending_uninteresting_ref(const char *refname,
-					 const unsigned char *sha1,
+					 const struct object_id *oid,
 					 int flags, void *cb_data)
 {
-	add_pending_sha1(cb_data, refname, sha1, UNINTERESTING);
+	add_pending_sha1(cb_data, refname, oid->hash, UNINTERESTING);
 	return 0;
 }
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7910419..2e792f3 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -179,13 +179,13 @@ static void add_merge_config(struct ref **head,
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
+	item->util = xmalloc(GIT_SHA1_RAWSZ);
+	hashcpy(item->util, oid->hash);
 	return 0;
 }
 
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 9736d44..248a3eb 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -138,9 +138,9 @@ static int tipcmp(const void *a_, const void *b_)
 	return hashcmp(a->sha1, b->sha1);
 }
 
-static int name_ref(const char *path, const unsigned char *sha1, int flags, void *cb_data)
+static int name_ref(const char *path, const struct object_id *oid, int flags, void *cb_data)
 {
-	struct object *o = parse_object(sha1);
+	struct object *o = parse_object(oid->hash);
 	struct name_ref_data *data = cb_data;
 	int can_abbreviate_output = data->tags_only && data->name_only;
 	int deref = 0;
@@ -160,7 +160,7 @@ static int name_ref(const char *path, const unsigned char *sha1, int flags, void
 		}
 	}
 
-	add_to_tip_table(sha1, path, can_abbreviate_output);
+	add_to_tip_table(oid->hash, path, can_abbreviate_output);
 
 	while (o && o->type == OBJ_TAG) {
 		struct tag *t = (struct tag *) o;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0c69b0c..80fe8c7 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2097,14 +2097,14 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 #define ll_find_deltas(l, s, w, d, p)	find_deltas(l, &s, w, d, p)
 #endif
 
-static int add_ref_tag(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int add_ref_tag(const char *path, const struct object_id *oid, int flag, void *cb_data)
 {
-	unsigned char peeled[20];
+	struct object_id peeled;
 
 	if (starts_with(path, "refs/tags/") && /* is a tag? */
-	    !peel_ref(path, peeled)        && /* peelable? */
-	    packlist_find(&to_pack, peeled, NULL))      /* object packed? */
-		add_object_entry(sha1, OBJ_TAG, NULL, 0);
+	    !peel_ref(path, peeled.hash)    && /* peelable? */
+	    packlist_find(&to_pack, peeled.hash, NULL))      /* object packed? */
+		add_object_entry(oid->hash, OBJ_TAG, NULL, 0);
 	return 0;
 }
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d2ec52b..85e60e2 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -197,7 +197,7 @@ static void show_ref(const char *path, const unsigned char *sha1)
 	}
 }
 
-static int show_ref_cb(const char *path, const unsigned char *sha1, int flag, void *unused)
+static int show_ref_cb(const char *path, const struct object_id *oid, int flag, void *unused)
 {
 	path = strip_namespace(path);
 	/*
@@ -210,7 +210,7 @@ static int show_ref_cb(const char *path, const unsigned char *sha1, int flag, vo
 	 */
 	if (!path)
 		path = ".have";
-	show_ref(path, sha1);
+	show_ref(path, oid->hash);
 	return 0;
 }
 
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 8182b64..f3f9201 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -313,14 +313,14 @@ static int should_expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	return 0;
 }
 
-static int push_tip_to_list(const char *refname, const unsigned char *sha1,
-			    int flags, void *cb_data)
+static int push_tip_to_list(const char *refname, const struct object_id *oid,
+				int flags, void *cb_data)
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
diff --git a/builtin/remote.c b/builtin/remote.c
index ad57fc9..67307ed 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -509,7 +509,7 @@ struct branches_for_remote {
 };
 
 static int add_branch_for_removal(const char *refname,
-	const unsigned char *sha1, int flags, void *cb_data)
+	const struct object_id *oid, int flags, void *cb_data)
 {
 	struct branches_for_remote *branches = cb_data;
 	struct refspec refspec;
@@ -544,8 +544,8 @@ static int add_branch_for_removal(const char *refname,
 		return unlink(git_path("%s", refname));
 
 	item = string_list_append(branches->branches, refname);
-	item->util = xmalloc(20);
-	hashcpy(item->util, sha1);
+	item->util = xmalloc(GIT_SHA1_RAWSZ);
+	hashcpy(item->util, oid->hash);
 
 	return 0;
 }
@@ -557,20 +557,20 @@ struct rename_info {
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
@@ -867,7 +867,7 @@ static void free_remote_ref_states(struct ref_states *states)
 }
 
 static int append_ref_to_tracked_list(const char *refname,
-	const unsigned char *sha1, int flags, void *cb_data)
+	const struct object_id *oid, int flags, void *cb_data)
 {
 	struct ref_states *states = cb_data;
 	struct refspec refspec;
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index c9f2c93..4aa7a25 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -657,7 +657,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--all")) {
-				for_each_ref(show_reference, NULL);
+				for_each_ref(show_reference_oid, NULL);
 				continue;
 			}
 			if (starts_with(arg, "--disambiguate=")) {
@@ -670,7 +670,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (starts_with(arg, "--branches=")) {
-				for_each_glob_ref_in(show_reference, arg + 11,
+				for_each_glob_ref_in(show_reference_oid, arg + 11,
 					"refs/heads/", NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
@@ -681,7 +681,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (starts_with(arg, "--tags=")) {
-				for_each_glob_ref_in(show_reference, arg + 7,
+				for_each_glob_ref_in(show_reference_oid, arg + 7,
 					"refs/tags/", NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
@@ -692,12 +692,12 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (starts_with(arg, "--glob=")) {
-				for_each_glob_ref(show_reference, arg + 7, NULL);
+				for_each_glob_ref(show_reference_oid, arg + 7, NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
 			if (starts_with(arg, "--remotes=")) {
-				for_each_glob_ref_in(show_reference, arg + 10,
+				for_each_glob_ref_in(show_reference_oid, arg + 10,
 					"refs/remotes/", NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index e69fb7c..e04fa8e 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -394,32 +394,32 @@ static int append_ref(const char *refname, const unsigned char *sha1,
 	return 0;
 }
 
-static int append_head_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int append_head_ref(const char *refname, const struct object_id *oid, int flag, void *cb_data)
 {
-	unsigned char tmp[20];
+	struct object_id tmp;
 	int ofs = 11;
 	if (!starts_with(refname, "refs/heads/"))
 		return 0;
 	/* If both heads/foo and tags/foo exists, get_sha1 would
 	 * get confused.
 	 */
-	if (get_sha1(refname + ofs, tmp) || hashcmp(tmp, sha1))
+	if (get_sha1(refname + ofs, tmp.hash) || oidcmp(&tmp, oid))
 		ofs = 5;
-	return append_ref(refname + ofs, sha1, 0);
+	return append_ref(refname + ofs, oid->hash, 0);
 }
 
-static int append_remote_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int append_remote_ref(const char *refname, const struct object_id *oid, int flag, void *cb_data)
 {
-	unsigned char tmp[20];
+	struct object_id tmp;
 	int ofs = 13;
 	if (!starts_with(refname, "refs/remotes/"))
 		return 0;
 	/* If both heads/foo and tags/foo exists, get_sha1 would
 	 * get confused.
 	 */
-	if (get_sha1(refname + ofs, tmp) || hashcmp(tmp, sha1))
+	if (get_sha1(refname + ofs, tmp.hash) || oidcmp(&tmp, oid))
 		ofs = 5;
-	return append_ref(refname + ofs, sha1, 0);
+	return append_ref(refname + ofs, oid->hash, 0);
 }
 
 static int append_tag_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
@@ -440,7 +440,7 @@ static int count_slash(const char *s)
 	return cnt;
 }
 
-static int append_matching_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int append_matching_ref(const char *refname, const struct object_id *oid, int flag, void *cb_data)
 {
 	/* we want to allow pattern hold/<asterisk> to show all
 	 * branches under refs/heads/hold/, and v0.99.9? to show
@@ -456,10 +456,10 @@ static int append_matching_ref(const char *refname, const unsigned char *sha1, i
 	if (wildmatch(match_ref_pattern, tail, 0, NULL))
 		return 0;
 	if (starts_with(refname, "refs/heads/"))
-		return append_head_ref(refname, sha1, flag, cb_data);
+		return append_head_ref(refname, oid, flag, cb_data);
 	if (starts_with(refname, "refs/tags/"))
-		return append_tag_ref(refname, sha1, flag, cb_data);
-	return append_ref(refname, sha1, 0);
+		return append_tag_ref(refname, oid->hash, flag, cb_data);
+	return append_ref(refname, oid->hash, 0);
 }
 
 static void snarf_refs(int head, int remotes)
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index c6c5939..6731721 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -93,7 +93,7 @@ static int show_ref_oid(const char *refname, const struct object_id *oid, int fl
 	return show_ref(refname, oid->hash, flag, cbdata);
 }
 
-static int add_existing(const char *refname, const unsigned char *sha1, int flag, void *cbdata)
+static int add_existing(const char *refname, const struct object_id *oid, int flag, void *cbdata)
 {
 	struct string_list *list = (struct string_list *)cbdata;
 	string_list_insert(list, refname);
@@ -231,7 +231,7 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 
 	if (show_head)
 		head_ref(show_ref_oid, NULL);
-	for_each_ref(show_ref, NULL);
+	for_each_ref(show_ref_oid, NULL);
 	if (!found_match) {
 		if (verify && !quiet)
 			die("No match");
diff --git a/fetch-pack.c b/fetch-pack.c
index 48526aa..65a57e1 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -70,9 +70,14 @@ static int rev_list_insert_ref(const char *refname, const unsigned char *sha1, i
 	return 0;
 }
 
-static int clear_marks(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int rev_list_insert_ref_oid(const char *refname, const struct object_id *oid, int flag, void *cb_data)
 {
-	struct object *o = deref_tag(parse_object(sha1), refname, 0);
+	return rev_list_insert_ref(refname, oid->hash, flag, cb_data);
+}
+
+static int clear_marks(const char *refname, const struct object_id *oid, int flag, void *cb_data)
+{
+	struct object *o = deref_tag(parse_object(oid->hash), refname, 0);
 
 	if (o && o->type == OBJ_COMMIT)
 		clear_commit_marks((struct commit *)o,
@@ -263,7 +268,7 @@ static int find_common(struct fetch_pack_args *args,
 		for_each_ref(clear_marks, NULL);
 	marked = 1;
 
-	for_each_ref(rev_list_insert_ref, NULL);
+	for_each_ref(rev_list_insert_ref_oid, NULL);
 	for_each_alternate_ref(insert_one_alternate_ref, NULL);
 
 	fetching = 0;
@@ -487,6 +492,11 @@ static int mark_complete(const char *refname, const unsigned char *sha1, int fla
 	return 0;
 }
 
+static int mark_complete_oid(const char *refname, const struct object_id *oid, int flag, void *cb_data)
+{
+	return mark_complete(refname, oid->hash, flag, cb_data);
+}
+
 static void mark_recent_complete_commits(struct fetch_pack_args *args,
 					 unsigned long cutoff)
 {
@@ -599,7 +609,7 @@ static int everything_local(struct fetch_pack_args *args,
 	}
 
 	if (!args->depth) {
-		for_each_ref(mark_complete, NULL);
+		for_each_ref(mark_complete_oid, NULL);
 		for_each_alternate_ref(mark_alternate_complete, NULL);
 		commit_list_sort_by_date(&complete);
 		if (cutoff)
diff --git a/help.c b/help.c
index 2072a87..6f3415b 100644
--- a/help.c
+++ b/help.c
@@ -407,7 +407,7 @@ struct similar_ref_cb {
 	struct string_list *similar_refs;
 };
 
-static int append_similar_ref(const char *refname, const unsigned char *sha1,
+static int append_similar_ref(const char *refname, const struct object_id *oid,
 			      int flags, void *cb_data)
 {
 	struct similar_ref_cb *cb = (struct similar_ref_cb *)(cb_data);
diff --git a/log-tree.c b/log-tree.c
index a29c17e..acbc859 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -154,7 +154,7 @@ void load_ref_decorations(int flags)
 	static int loaded;
 	if (!loaded) {
 		loaded = 1;
-		for_each_ref(add_ref_decoration, &flags);
+		for_each_ref(add_ref_decoration_oid, &flags);
 		head_ref(add_ref_decoration_oid, &flags);
 		for_each_commit_graft(add_graft_decoration, NULL);
 	}
diff --git a/notes.c b/notes.c
index 2be4d7f..df08209 100644
--- a/notes.c
+++ b/notes.c
@@ -918,7 +918,7 @@ out:
 	return ret;
 }
 
-static int string_list_add_one_ref(const char *refname, const unsigned char *sha1,
+static int string_list_add_one_ref(const char *refname, const struct object_id *oid,
 				   int flag, void *cb)
 {
 	struct string_list *refs = cb;
diff --git a/reachable.c b/reachable.c
index 110ce92..b2ca0c3 100644
--- a/reachable.c
+++ b/reachable.c
@@ -173,7 +173,7 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 	add_index_objects_to_pending(revs, 0);
 
 	/* Add all external refs */
-	for_each_ref(add_one_ref, revs);
+	for_each_ref(add_one_ref_oid, revs);
 
 	/* detached HEAD is not included in the list above */
 	head_ref(add_one_ref_oid, revs);
diff --git a/refs.c b/refs.c
index 68d0af8..6bf7abc 100644
--- a/refs.c
+++ b/refs.c
@@ -1675,7 +1675,7 @@ char *resolve_refdup(const char *ref, int resolve_flags, unsigned char *sha1, in
 /* The argument to filter_refs */
 struct ref_filter {
 	const char *pattern;
-	each_ref_fn *fn;
+	each_ref_fn_oid *fn;
 	void *cb_data;
 };
 
@@ -1697,13 +1697,13 @@ int ref_exists(const char *refname)
 	return !!resolve_ref_unsafe(refname, RESOLVE_REF_READING, sha1, NULL);
 }
 
-static int filter_refs(const char *refname, const unsigned char *sha1, int flags,
-		       void *data)
+static int filter_refs(const char *refname, const struct object_id *oid,
+			   int flags, void *data)
 {
 	struct ref_filter *filter = (struct ref_filter *)data;
 	if (wildmatch(filter->pattern, refname, 0, NULL))
 		return 0;
-	return filter->fn(refname, sha1, flags, filter->cb_data);
+	return filter->fn(refname, oid, flags, filter->cb_data);
 }
 
 enum peel_status {
@@ -2009,9 +2009,9 @@ int head_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data)
 	return do_head_ref(submodule, fn, cb_data);
 }
 
-int for_each_ref(each_ref_fn fn, void *cb_data)
+int for_each_ref(each_ref_fn_oid fn, void *cb_data)
 {
-	return do_for_each_ref(&ref_cache, "", fn, 0, 0, cb_data);
+	return do_for_each_ref_oid(&ref_cache, "", fn, 0, 0, cb_data);
 }
 
 int for_each_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data)
@@ -2090,7 +2090,7 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 	return ret;
 }
 
-int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
+int for_each_glob_ref_in(each_ref_fn_oid fn, const char *pattern,
 	const char *prefix, void *cb_data)
 {
 	struct strbuf real_pattern = STRBUF_INIT;
@@ -2120,7 +2120,7 @@ int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 	return ret;
 }
 
-int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data)
+int for_each_glob_ref(each_ref_fn_oid fn, const char *pattern, void *cb_data)
 {
 	return for_each_glob_ref_in(fn, pattern, NULL, cb_data);
 }
diff --git a/refs.h b/refs.h
index 2476951..c041cd1 100644
--- a/refs.h
+++ b/refs.h
@@ -87,14 +87,14 @@ typedef int each_ref_fn_oid(const char *refname,
  * stop the iteration.
  */
 extern int head_ref(each_ref_fn_oid, void *);
-extern int for_each_ref(each_ref_fn, void *);
+extern int for_each_ref(each_ref_fn_oid, void *);
 extern int for_each_ref_in(const char *, each_ref_fn_oid, void *);
 extern int for_each_tag_ref(each_ref_fn_oid, void *);
 extern int for_each_branch_ref(each_ref_fn_oid, void *);
 extern int for_each_remote_ref(each_ref_fn_oid, void *);
 extern int for_each_replace_ref(each_ref_fn, void *);
-extern int for_each_glob_ref(each_ref_fn, const char *pattern, void *);
-extern int for_each_glob_ref_in(each_ref_fn, const char *pattern, const char* prefix, void *);
+extern int for_each_glob_ref(each_ref_fn_oid, const char *pattern, void *);
+extern int for_each_glob_ref_in(each_ref_fn_oid, const char *pattern, const char* prefix, void *);
 
 extern int head_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data);
 extern int for_each_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data);
diff --git a/remote.c b/remote.c
index 68901b0..b544997 100644
--- a/remote.c
+++ b/remote.c
@@ -2024,7 +2024,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 	return 1;
 }
 
-static int one_local_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int one_local_ref(const char *refname, const struct object_id *oid, int flag, void *cb_data)
 {
 	struct ref ***local_tail = cb_data;
 	struct ref *ref;
@@ -2036,7 +2036,7 @@ static int one_local_ref(const char *refname, const unsigned char *sha1, int fla
 
 	len = strlen(refname) + 1;
 	ref = xcalloc(1, sizeof(*ref) + len);
-	hashcpy(ref->new_sha1, sha1);
+	hashcpy(ref->new_sha1, oid->hash);
 	memcpy(ref->name, refname, len);
 	**local_tail = ref;
 	*local_tail = &ref->next;
@@ -2099,7 +2099,7 @@ struct stale_heads_info {
 };
 
 static int get_stale_heads_cb(const char *refname,
-	const unsigned char *sha1, int flags, void *cb_data)
+	const struct object_id *oid, int flags, void *cb_data)
 {
 	struct stale_heads_info *info = cb_data;
 	struct string_list matches = STRING_LIST_INIT_DUP;
@@ -2128,7 +2128,7 @@ static int get_stale_heads_cb(const char *refname,
 
 	if (stale) {
 		struct ref *ref = make_linked_ref(refname, &info->stale_refs_tail);
-		hashcpy(ref->new_sha1, sha1);
+		hashcpy(ref->new_sha1, oid->hash);
 	}
 
 clean_exit:
diff --git a/revision.c b/revision.c
index 6fb499f..29af759 100644
--- a/revision.c
+++ b/revision.c
@@ -2127,7 +2127,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	} else if ((argcount = parse_long_opt("glob", argv, &optarg))) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref(handle_one_ref, optarg, &cb);
+		for_each_glob_ref(handle_one_ref_oid, optarg, &cb);
 		clear_ref_exclusion(&revs->ref_excludes);
 		return argcount;
 	} else if ((argcount = parse_long_opt("exclude", argv, &optarg))) {
@@ -2136,17 +2136,17 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	} else if (starts_with(arg, "--branches=")) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(handle_one_ref, arg + 11, "refs/heads/", &cb);
+		for_each_glob_ref_in(handle_one_ref_oid, arg + 11, "refs/heads/", &cb);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (starts_with(arg, "--tags=")) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(handle_one_ref, arg + 7, "refs/tags/", &cb);
+		for_each_glob_ref_in(handle_one_ref_oid, arg + 7, "refs/tags/", &cb);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (starts_with(arg, "--remotes=")) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(handle_one_ref, arg + 10, "refs/remotes/", &cb);
+		for_each_glob_ref_in(handle_one_ref_oid, arg + 10, "refs/remotes/", &cb);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--reflog")) {
 		add_reflogs_to_pending(revs, *flags);
diff --git a/server-info.c b/server-info.c
index 34b0253..11f21bd 100644
--- a/server-info.c
+++ b/server-info.c
@@ -47,14 +47,14 @@ out:
 	return ret;
 }
 
-static int add_info_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int add_info_ref(const char *path, const struct object_id *oid, int flag, void *cb_data)
 {
 	FILE *fp = cb_data;
-	struct object *o = parse_object(sha1);
+	struct object *o = parse_object(oid->hash);
 	if (!o)
 		return -1;
 
-	if (fprintf(fp, "%s	%s\n", sha1_to_hex(sha1), path) < 0)
+	if (fprintf(fp, "%s	%s\n", oid_to_hex(oid), path) < 0)
 		return -1;
 
 	if (o->type == OBJ_TAG) {
diff --git a/sha1_name.c b/sha1_name.c
index 6d10f05..959e6c1 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -832,10 +832,10 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned l
 #define ONELINE_SEEN (1u<<20)
 
 static int handle_one_ref(const char *path,
-		const unsigned char *sha1, int flag, void *cb_data)
+		const struct object_id *oid, int flag, void *cb_data)
 {
 	struct commit_list **list = cb_data;
-	struct object *object = parse_object(sha1);
+	struct object *object = parse_object(oid->hash);
 	if (!object)
 		return 0;
 	if (object->type == OBJ_TAG) {
diff --git a/shallow.c b/shallow.c
index 0343b16..6511bbb 100644
--- a/shallow.c
+++ b/shallow.c
@@ -550,7 +550,7 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
 	 * have to go down to the current shallow commits.
 	 */
 	head_ref(mark_uninteresting_oid, NULL);
-	for_each_ref(mark_uninteresting, NULL);
+	for_each_ref(mark_uninteresting_oid, NULL);
 
 	/* Mark potential bottoms so we won't go out of bound */
 	for (i = 0; i < nr_shallow; i++) {
@@ -655,7 +655,7 @@ static void post_assign_shallow(struct shallow_info *info,
 
 	memset(&ca, 0, sizeof(ca));
 	head_ref(add_ref_oid, &ca);
-	for_each_ref(add_ref, &ca);
+	for_each_ref(add_ref_oid, &ca);
 
 	/* Remove unreachable shallow commits from "ours" */
 	for (i = dst = 0; i < info->nr_ours; i++) {
@@ -689,7 +689,7 @@ int delayed_reachability_test(struct shallow_info *si, int c)
 			struct commit_array ca;
 			memset(&ca, 0, sizeof(ca));
 			head_ref(add_ref_oid, &ca);
-			for_each_ref(add_ref, &ca);
+			for_each_ref(add_ref_oid, &ca);
 			si->commits = ca.commits;
 			si->nr_commits = ca.nr;
 		}
diff --git a/submodule.c b/submodule.c
index 97e74c5..b284444 100644
--- a/submodule.c
+++ b/submodule.c
@@ -616,10 +616,10 @@ static void submodule_collect_changed_cb(struct diff_queue_struct *q,
 	}
 }
 
-static int add_sha1_to_array(const char *ref, const unsigned char *sha1,
+static int add_sha1_to_array(const char *ref, const struct object_id *oid,
 			     int flags, void *data)
 {
-	sha1_array_append(data, sha1);
+	sha1_array_append(data, oid->hash);
 	return 0;
 }
 
diff --git a/transport.c b/transport.c
index f080e93..c13108b 100644
--- a/transport.c
+++ b/transport.c
@@ -278,7 +278,7 @@ static int fetch_objs_via_rsync(struct transport *transport,
 	return run_command(&rsync);
 }
 
-static int write_one_ref(const char *name, const unsigned char *sha1,
+static int write_one_ref(const char *name, const struct object_id *oid,
 		int flags, void *data)
 {
 	struct strbuf *buf = data;
@@ -291,7 +291,7 @@ static int write_one_ref(const char *name, const unsigned char *sha1,
 
 	strbuf_addstr(buf, name);
 	if (safe_create_leading_directories(buf->buf) ||
-	    write_file(buf->buf, 0, "%s\n", sha1_to_hex(sha1)))
+	    write_file(buf->buf, 0, "%s\n", oid_to_hex(oid)))
 		return error("problems writing temporary file %s: %s",
 			     buf->buf, strerror(errno));
 	strbuf_setlen(buf, len);
@@ -304,13 +304,13 @@ static int write_refs_to_temp_dir(struct strbuf *temp_dir,
 	int i;
 
 	for (i = 0; i < refspec_nr; i++) {
-		unsigned char sha1[20];
+		struct object_id oid;
 		char *ref;
 
-		if (dwim_ref(refspec[i], strlen(refspec[i]), sha1, &ref) != 1)
+		if (dwim_ref(refspec[i], strlen(refspec[i]), oid.hash, &ref) != 1)
 			return error("Could not get ref %s", refspec[i]);
 
-		if (write_one_ref(ref, sha1, 0, temp_dir)) {
+		if (write_one_ref(ref, &oid, 0, temp_dir)) {
 			free(ref);
 			return -1;
 		}
diff --git a/walker.c b/walker.c
index 58ffeca..033c8f2 100644
--- a/walker.c
+++ b/walker.c
@@ -200,9 +200,9 @@ static int interpret_target(struct walker *walker, char *target, unsigned char *
 	return -1;
 }
 
-static int mark_complete(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int mark_complete(const char *path, const struct object_id *oid, int flag, void *cb_data)
 {
-	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
+	struct commit *commit = lookup_commit_reference_gently(oid->hash, 1);
 	if (commit) {
 		commit->object.flags |= COMPLETE;
 		commit_list_insert(commit, &complete);
-- 
2.3.5
