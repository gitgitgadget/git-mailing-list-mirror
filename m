From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 05/16] refs: convert head_ref to struct object_id
Date: Wed, 22 Apr 2015 23:24:10 +0000
Message-ID: <1429745061-295908-6-git-send-email-sandals@crustytoothpaste.net>
References: <1429745061-295908-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 01:25:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl413-000415-RX
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 01:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965579AbbDVXZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 19:25:09 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:44752 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758557AbbDVXYa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 19:24:30 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 88F8D282A8;
	Wed, 22 Apr 2015 23:24:29 +0000 (UTC)
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1429745061-295908-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267665>

Convert head_ref and head_ref_submodule to use struct object_id.
Introduce some wrappers in some of the callers to handle
incompatibilities between each_ref_fn and each_ref_fn_oid.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/show-ref.c |  7 ++++++-
 log-tree.c         |  7 ++++++-
 reachable.c        |  7 ++++++-
 refs.c             | 16 ++++++++--------
 refs.h             |  4 ++--
 revision.c         |  2 +-
 shallow.c          | 19 ++++++++++++++++---
 7 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index afb1030..c6c5939 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -88,6 +88,11 @@ match:
 	return 0;
 }
 
+static int show_ref_oid(const char *refname, const struct object_id *oid, int flag, void *cbdata)
+{
+	return show_ref(refname, oid->hash, flag, cbdata);
+}
+
 static int add_existing(const char *refname, const unsigned char *sha1, int flag, void *cbdata)
 {
 	struct string_list *list = (struct string_list *)cbdata;
@@ -225,7 +230,7 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 	}
 
 	if (show_head)
-		head_ref(show_ref, NULL);
+		head_ref(show_ref_oid, NULL);
 	for_each_ref(show_ref, NULL);
 	if (!found_match) {
 		if (verify && !quiet)
diff --git a/log-tree.c b/log-tree.c
index cf4646b..a29c17e 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -135,6 +135,11 @@ static int add_ref_decoration(const char *refname, const unsigned char *sha1, in
 	return 0;
 }
 
+static int add_ref_decoration_oid(const char *refname, const struct object_id *oid, int flags, void *cb_data)
+{
+	return add_ref_decoration(refname, oid->hash, flags, cb_data);
+}
+
 static int add_graft_decoration(const struct commit_graft *graft, void *cb_data)
 {
 	struct commit *commit = lookup_commit(graft->oid.hash);
@@ -150,7 +155,7 @@ void load_ref_decorations(int flags)
 	if (!loaded) {
 		loaded = 1;
 		for_each_ref(add_ref_decoration, &flags);
-		head_ref(add_ref_decoration, &flags);
+		head_ref(add_ref_decoration_oid, &flags);
 		for_each_commit_graft(add_graft_decoration, NULL);
 	}
 }
diff --git a/reachable.c b/reachable.c
index 69fa685..110ce92 100644
--- a/reachable.c
+++ b/reachable.c
@@ -32,6 +32,11 @@ static int add_one_ref(const char *path, const unsigned char *sha1, int flag, vo
 	return 0;
 }
 
+static int add_one_ref_oid(const char *path, const struct object_id *oid, int flag, void *cb_data)
+{
+	return add_one_ref(path, oid->hash, flag, cb_data);
+}
+
 /*
  * The traversal will have already marked us as SEEN, so we
  * only need to handle any progress reporting here.
@@ -171,7 +176,7 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 	for_each_ref(add_one_ref, revs);
 
 	/* detached HEAD is not included in the list above */
-	head_ref(add_one_ref, revs);
+	head_ref(add_one_ref_oid, revs);
 
 	/* Add all reflog info */
 	if (mark_reflog)
diff --git a/refs.c b/refs.c
index aa13cc2..7a8b579 100644
--- a/refs.c
+++ b/refs.c
@@ -1981,30 +1981,30 @@ static int do_for_each_ref_oid(struct ref_cache *refs, const char *base,
 	return do_for_each_entry(refs, base, do_one_ref, &data);
 }
 
-static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
+static int do_head_ref(const char *submodule, each_ref_fn_oid fn, void *cb_data)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	int flag;
 
 	if (submodule) {
-		if (resolve_gitlink_ref(submodule, "HEAD", sha1) == 0)
-			return fn("HEAD", sha1, 0, cb_data);
+		if (resolve_gitlink_ref(submodule, "HEAD", oid.hash) == 0)
+			return fn("HEAD", &oid, 0, cb_data);
 
 		return 0;
 	}
 
-	if (!read_ref_full("HEAD", RESOLVE_REF_READING, sha1, &flag))
-		return fn("HEAD", sha1, flag, cb_data);
+	if (!read_ref_full("HEAD", RESOLVE_REF_READING, oid.hash, &flag))
+		return fn("HEAD", &oid, flag, cb_data);
 
 	return 0;
 }
 
-int head_ref(each_ref_fn fn, void *cb_data)
+int head_ref(each_ref_fn_oid fn, void *cb_data)
 {
 	return do_head_ref(NULL, fn, cb_data);
 }
 
-int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+int head_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data)
 {
 	return do_head_ref(submodule, fn, cb_data);
 }
diff --git a/refs.h b/refs.h
index 62eb553..a14e7ef 100644
--- a/refs.h
+++ b/refs.h
@@ -86,7 +86,7 @@ typedef int each_ref_fn_oid(const char *refname,
  * modifies the reference also returns a nonzero value to immediately
  * stop the iteration.
  */
-extern int head_ref(each_ref_fn, void *);
+extern int head_ref(each_ref_fn_oid, void *);
 extern int for_each_ref(each_ref_fn, void *);
 extern int for_each_ref_in(const char *, each_ref_fn_oid, void *);
 extern int for_each_tag_ref(each_ref_fn_oid, void *);
@@ -96,7 +96,7 @@ extern int for_each_replace_ref(each_ref_fn, void *);
 extern int for_each_glob_ref(each_ref_fn, const char *pattern, void *);
 extern int for_each_glob_ref_in(each_ref_fn, const char *pattern, const char* prefix, void *);
 
-extern int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
+extern int head_ref_submodule(const char *submodule, each_ref_fn_oid fn, void *cb_data);
 extern int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
 extern int for_each_ref_in_submodule(const char *submodule, const char *prefix,
 		each_ref_fn_oid fn, void *cb_data);
diff --git a/revision.c b/revision.c
index 93d9311..19005e8 100644
--- a/revision.c
+++ b/revision.c
@@ -2117,7 +2117,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	 */
 	if (!strcmp(arg, "--all")) {
 		handle_refs(submodule, revs, *flags, for_each_ref_submodule);
-		handle_refs(submodule, revs, *flags, head_ref_submodule);
+		handle_refs_oid(submodule, revs, *flags, head_ref_submodule);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--branches")) {
 		handle_refs_oid(submodule, revs, *flags, for_each_branch_ref_submodule);
diff --git a/shallow.c b/shallow.c
index d08d264..0343b16 100644
--- a/shallow.c
+++ b/shallow.c
@@ -487,6 +487,13 @@ static int mark_uninteresting(const char *refname,
 	return 0;
 }
 
+static int mark_uninteresting_oid(const char *refname,
+				const struct object_id *oid,
+				int flags, void *cb_data)
+{
+	return mark_uninteresting(refname, oid->hash, flags, cb_data);
+}
+
 static void post_assign_shallow(struct shallow_info *info,
 				struct ref_bitmap *ref_bitmap,
 				int *ref_status);
@@ -542,7 +549,7 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
 	 * connect to old refs. If not (e.g. force ref updates) it'll
 	 * have to go down to the current shallow commits.
 	 */
-	head_ref(mark_uninteresting, NULL);
+	head_ref(mark_uninteresting_oid, NULL);
 	for_each_ref(mark_uninteresting, NULL);
 
 	/* Mark potential bottoms so we won't go out of bound */
@@ -595,6 +602,12 @@ static int add_ref(const char *refname,
 	return 0;
 }
 
+static int add_ref_oid(const char *refname,
+		   const struct object_id *oid, int flags, void *cb_data)
+{
+	return add_ref(refname, oid->hash, flags, cb_data);
+}
+
 static void update_refstatus(int *ref_status, int nr, uint32_t *bitmap)
 {
 	int i;
@@ -641,7 +654,7 @@ static void post_assign_shallow(struct shallow_info *info,
 	info->nr_theirs = dst;
 
 	memset(&ca, 0, sizeof(ca));
-	head_ref(add_ref, &ca);
+	head_ref(add_ref_oid, &ca);
 	for_each_ref(add_ref, &ca);
 
 	/* Remove unreachable shallow commits from "ours" */
@@ -675,7 +688,7 @@ int delayed_reachability_test(struct shallow_info *si, int c)
 		if (!si->commits) {
 			struct commit_array ca;
 			memset(&ca, 0, sizeof(ca));
-			head_ref(add_ref, &ca);
+			head_ref(add_ref_oid, &ca);
 			for_each_ref(add_ref, &ca);
 			si->commits = ca.commits;
 			si->nr_commits = ca.nr;
-- 
2.3.5
