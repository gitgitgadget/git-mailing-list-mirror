From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 15/16] Remove unneeded *_oid functions.
Date: Fri, 20 Mar 2015 19:28:35 +0000
Message-ID: <1426879716-47835-16-git-send-email-sandals@crustytoothpaste.net>
References: <1426879716-47835-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 20:29:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ2bR-0001gd-OT
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 20:29:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbbCTT3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 15:29:01 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50652 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751470AbbCTT27 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2015 15:28:59 -0400
Received: from vauxhall.crustytoothpaste.net (wsip-184-177-1-73.no.no.cox.net [184.177.1.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D2DA628092;
	Fri, 20 Mar 2015 19:28:57 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1426879716-47835-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: 0.163 () BAYES_00,RDNS_DYNAMIC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265942>

While these functions were needed during the intermediate steps of
converting for_each_ref and friends to struct object_id, there is no
longer any need to have these wrapper functions.  Update each of the
functions that the wrapper functions call and remove the _oid wrapper
functions themselves.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/rev-parse.c | 27 +++++++++++----------------
 builtin/show-ref.c  | 23 +++++++++--------------
 log-tree.c          | 19 +++++++------------
 reachable.c         | 13 ++++---------
 shallow.c           | 33 ++++++++++-----------------------
 5 files changed, 41 insertions(+), 74 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 74eae6a..d6a6599 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -190,19 +190,14 @@ static int show_default(void)
 	return 0;
 }
 
-static int show_reference(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int show_reference(const char *refname, const struct object_id *oid, int flag, void *cb_data)
 {
 	if (ref_excluded(ref_excludes, refname))
 		return 0;
-	show_rev(NORMAL, sha1, refname);
+	show_rev(NORMAL, oid->hash, refname);
 	return 0;
 }
 
-static int show_reference_oid(const char *refname, const struct object_id *oid, int flag, void *cb_data)
-{
-	return show_reference(refname, oid->hash, flag, cb_data);
-}
-
 static int anti_reference(const char *refname, const struct object_id *oid, int flag, void *cb_data)
 {
 	show_rev(REVERSED, oid->hash, refname);
@@ -650,7 +645,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--all")) {
-				for_each_ref(show_reference_oid, NULL);
+				for_each_ref(show_reference, NULL);
 				continue;
 			}
 			if (starts_with(arg, "--disambiguate=")) {
@@ -658,45 +653,45 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--bisect")) {
-				for_each_ref_in("refs/bisect/bad", show_reference_oid, NULL);
+				for_each_ref_in("refs/bisect/bad", show_reference, NULL);
 				for_each_ref_in("refs/bisect/good", anti_reference, NULL);
 				continue;
 			}
 			if (starts_with(arg, "--branches=")) {
-				for_each_glob_ref_in(show_reference_oid, arg + 11,
+				for_each_glob_ref_in(show_reference, arg + 11,
 					"refs/heads/", NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
 			if (!strcmp(arg, "--branches")) {
-				for_each_branch_ref(show_reference_oid, NULL);
+				for_each_branch_ref(show_reference, NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
 			if (starts_with(arg, "--tags=")) {
-				for_each_glob_ref_in(show_reference_oid, arg + 7,
+				for_each_glob_ref_in(show_reference, arg + 7,
 					"refs/tags/", NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
 			if (!strcmp(arg, "--tags")) {
-				for_each_tag_ref(show_reference_oid, NULL);
+				for_each_tag_ref(show_reference, NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
 			if (starts_with(arg, "--glob=")) {
-				for_each_glob_ref(show_reference_oid, arg + 7, NULL);
+				for_each_glob_ref(show_reference, arg + 7, NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
 			if (starts_with(arg, "--remotes=")) {
-				for_each_glob_ref_in(show_reference_oid, arg + 10,
+				for_each_glob_ref_in(show_reference, arg + 10,
 					"refs/remotes/", NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
 			if (!strcmp(arg, "--remotes")) {
-				for_each_remote_ref(show_reference_oid, NULL);
+				for_each_remote_ref(show_reference, NULL);
 				clear_ref_exclusion(&ref_excludes);
 				continue;
 			}
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 136c9b9..4bbc4f3 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -26,10 +26,10 @@ static void show_one(const char *refname, const unsigned char *sha1)
 		printf("%s %s\n", hex, refname);
 }
 
-static int show_ref(const char *refname, const unsigned char *sha1, int flag, void *cbdata)
+static int show_ref(const char *refname, const struct object_id *oid, int flag, void *cbdata)
 {
 	const char *hex;
-	unsigned char peeled[20];
+	struct object_id peeled;
 
 	if (show_head && !strcmp(refname, "HEAD"))
 		goto match;
@@ -69,30 +69,25 @@ match:
 	 * detect and return error if the repository is corrupt and
 	 * ref points at a nonexistent object.
 	 */
-	if (!has_sha1_file(sha1))
+	if (!has_sha1_file(oid->hash))
 		die("git show-ref: bad ref %s (%s)", refname,
-		    sha1_to_hex(sha1));
+		    oid_to_hex(oid));
 
 	if (quiet)
 		return 0;
 
-	show_one(refname, sha1);
+	show_one(refname, oid->hash);
 
 	if (!deref_tags)
 		return 0;
 
-	if (!peel_ref(refname, peeled)) {
-		hex = find_unique_abbrev(peeled, abbrev);
+	if (!peel_ref(refname, peeled.hash)) {
+		hex = find_unique_abbrev(peeled.hash, abbrev);
 		printf("%s %s^{}\n", hex, refname);
 	}
 	return 0;
 }
 
-static int show_ref_oid(const char *refname, const struct object_id *oid, int flag, void *cbdata)
-{
-	return show_ref(refname, oid->hash, flag, cbdata);
-}
-
 static int add_existing(const char *refname, const struct object_id *oid, int flag, void *cbdata)
 {
 	struct string_list *list = (struct string_list *)cbdata;
@@ -230,8 +225,8 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 	}
 
 	if (show_head)
-		head_ref(show_ref_oid, NULL);
-	for_each_ref(show_ref_oid, NULL);
+		head_ref(show_ref, NULL);
+	for_each_ref(show_ref, NULL);
 	if (!found_match) {
 		if (verify && !quiet)
 			die("No match");
diff --git a/log-tree.c b/log-tree.c
index ff15bcb..a7e8191 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -87,26 +87,26 @@ const struct name_decoration *get_name_decoration(const struct object *obj)
 	return lookup_decoration(&name_decoration, obj);
 }
 
-static int add_ref_decoration(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
+static int add_ref_decoration(const char *refname, const struct object_id *oid, int flags, void *cb_data)
 {
 	struct object *obj;
 	enum decoration_type type = DECORATION_NONE;
 
 	if (starts_with(refname, "refs/replace/")) {
-		unsigned char original_sha1[20];
+		struct object_id original_oid;
 		if (!check_replace_refs)
 			return 0;
-		if (get_sha1_hex(refname + 13, original_sha1)) {
+		if (get_oid_hex(refname + 13, &original_oid)) {
 			warning("invalid replace ref %s", refname);
 			return 0;
 		}
-		obj = parse_object(original_sha1);
+		obj = parse_object(original_oid.hash);
 		if (obj)
 			add_name_decoration(DECORATION_GRAFTED, "replaced", obj);
 		return 0;
 	}
 
-	obj = parse_object(sha1);
+	obj = parse_object(oid->hash);
 	if (!obj)
 		return 0;
 
@@ -135,11 +135,6 @@ static int add_ref_decoration(const char *refname, const unsigned char *sha1, in
 	return 0;
 }
 
-static int add_ref_decoration_oid(const char *refname, const struct object_id *oid, int flags, void *cb_data)
-{
-	return add_ref_decoration(refname, oid->hash, flags, cb_data);
-}
-
 static int add_graft_decoration(const struct commit_graft *graft, void *cb_data)
 {
 	struct commit *commit = lookup_commit(graft->oid.hash);
@@ -154,8 +149,8 @@ void load_ref_decorations(int flags)
 	static int loaded;
 	if (!loaded) {
 		loaded = 1;
-		for_each_ref(add_ref_decoration_oid, &flags);
-		head_ref(add_ref_decoration_oid, &flags);
+		for_each_ref(add_ref_decoration, &flags);
+		head_ref(add_ref_decoration, &flags);
 		for_each_commit_graft(add_graft_decoration, NULL);
 	}
 }
diff --git a/reachable.c b/reachable.c
index f808e2f..92a1993 100644
--- a/reachable.c
+++ b/reachable.c
@@ -22,9 +22,9 @@ static void update_progress(struct connectivity_progress *cp)
 		display_progress(cp->progress, cp->count);
 }
 
-static int add_one_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+static int add_one_ref(const char *path, const struct object_id *oid, int flag, void *cb_data)
 {
-	struct object *object = parse_object_or_die(sha1, path);
+	struct object *object = parse_object_or_die(oid->hash, path);
 	struct rev_info *revs = (struct rev_info *)cb_data;
 
 	add_pending_object(revs, object, "");
@@ -32,11 +32,6 @@ static int add_one_ref(const char *path, const unsigned char *sha1, int flag, vo
 	return 0;
 }
 
-static int add_one_ref_oid(const char *path, const struct object_id *oid, int flag, void *cb_data)
-{
-	return add_one_ref(path, oid->hash, flag, cb_data);
-}
-
 /*
  * The traversal will have already marked us as SEEN, so we
  * only need to handle any progress reporting here.
@@ -171,10 +166,10 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 	add_index_objects_to_pending(revs, 0);
 
 	/* Add all external refs */
-	for_each_ref(add_one_ref_oid, revs);
+	for_each_ref(add_one_ref, revs);
 
 	/* detached HEAD is not included in the list above */
-	head_ref(add_one_ref_oid, revs);
+	head_ref(add_one_ref, revs);
 
 	/* Add all reflog info */
 	if (mark_reflog)
diff --git a/shallow.c b/shallow.c
index af61162..c1b166f 100644
--- a/shallow.c
+++ b/shallow.c
@@ -476,10 +476,10 @@ static void paint_down(struct paint_info *info, const unsigned char *sha1,
 }
 
 static int mark_uninteresting(const char *refname,
-			      const unsigned char *sha1,
+			      const struct object_id *oid,
 			      int flags, void *cb_data)
 {
-	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
+	struct commit *commit = lookup_commit_reference_gently(oid->hash, 1);
 	if (!commit)
 		return 0;
 	commit->object.flags |= UNINTERESTING;
@@ -487,13 +487,6 @@ static int mark_uninteresting(const char *refname,
 	return 0;
 }
 
-static int mark_uninteresting_oid(const char *refname,
-				const struct object_id *oid,
-				int flags, void *cb_data)
-{
-	return mark_uninteresting(refname, oid->hash, flags, cb_data);
-}
-
 static void post_assign_shallow(struct shallow_info *info,
 				struct ref_bitmap *ref_bitmap,
 				int *ref_status);
@@ -549,8 +542,8 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
 	 * connect to old refs. If not (e.g. force ref updates) it'll
 	 * have to go down to the current shallow commits.
 	 */
-	head_ref(mark_uninteresting_oid, NULL);
-	for_each_ref(mark_uninteresting_oid, NULL);
+	head_ref(mark_uninteresting, NULL);
+	for_each_ref(mark_uninteresting, NULL);
 
 	/* Mark potential bottoms so we won't go out of bound */
 	for (i = 0; i < nr_shallow; i++) {
@@ -592,22 +585,16 @@ struct commit_array {
 };
 
 static int add_ref(const char *refname,
-		   const unsigned char *sha1, int flags, void *cb_data)
+		   const struct object_id *oid, int flags, void *cb_data)
 {
 	struct commit_array *ca = cb_data;
 	ALLOC_GROW(ca->commits, ca->nr + 1, ca->alloc);
-	ca->commits[ca->nr] = lookup_commit_reference_gently(sha1, 1);
+	ca->commits[ca->nr] = lookup_commit_reference_gently(oid->hash, 1);
 	if (ca->commits[ca->nr])
 		ca->nr++;
 	return 0;
 }
 
-static int add_ref_oid(const char *refname,
-		   const struct object_id *oid, int flags, void *cb_data)
-{
-	return add_ref(refname, oid->hash, flags, cb_data);
-}
-
 static void update_refstatus(int *ref_status, int nr, uint32_t *bitmap)
 {
 	int i;
@@ -654,8 +641,8 @@ static void post_assign_shallow(struct shallow_info *info,
 	info->nr_theirs = dst;
 
 	memset(&ca, 0, sizeof(ca));
-	head_ref(add_ref_oid, &ca);
-	for_each_ref(add_ref_oid, &ca);
+	head_ref(add_ref, &ca);
+	for_each_ref(add_ref, &ca);
 
 	/* Remove unreachable shallow commits from "ours" */
 	for (i = dst = 0; i < info->nr_ours; i++) {
@@ -688,8 +675,8 @@ int delayed_reachability_test(struct shallow_info *si, int c)
 		if (!si->commits) {
 			struct commit_array ca;
 			memset(&ca, 0, sizeof(ca));
-			head_ref(add_ref_oid, &ca);
-			for_each_ref(add_ref_oid, &ca);
+			head_ref(add_ref, &ca);
+			for_each_ref(add_ref, &ca);
 			si->commits = ca.commits;
 			si->nr_commits = ca.nr;
 		}
-- 
2.2.1.209.g41e5f3a
