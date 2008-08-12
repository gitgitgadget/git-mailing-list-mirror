From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH (1b)] merge-recursive.c: Add more generic merge_recursive_generic()
Date: Tue, 12 Aug 2008 22:13:59 +0200
Message-ID: <1218572040-23362-1-git-send-email-s-beyer@gmx.net>
References: <1218559514-16890-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 22:15:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT0Gw-0001OX-CW
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 22:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbYHLUOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 16:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752191AbYHLUOK
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 16:14:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:46055 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752174AbYHLUOG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 16:14:06 -0400
Received: (qmail invoked by alias); 12 Aug 2008 20:14:03 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp015) with SMTP; 12 Aug 2008 22:14:03 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19tJawUpj5tJediZfMLHUn6BimR3NGD+7TFy0KXUr
	JqL6+RfG4VIeXu
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KT0Fk-00065C-8U; Tue, 12 Aug 2008 22:14:00 +0200
X-Mailer: git-send-email 1.6.0.rc2.281.g6f6cf
In-Reply-To: <1218559514-16890-1-git-send-email-vmiklos@frugalware.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92134>

merge_recursive_generic() takes, in comparison to to merge_recursive(),
no commit ("struct commit *") arguments but SHA ids ("unsigned char *"),
and no commit list of bases but an array of refs ("const char **").

This makes it more generic in the case that it can also take the SHA
of a tree to merge trees without commits, for the bases, the head
and the remote.

merge_recursive_generic() also handles locking and updating of the
index, which is a common use case of merge_recursive().

This patch also rewrites builtin-merge-recursive.c to make use of
merge_recursive_generic().  By doing this, I stumbled over the
limitation of 20 bases and I've added a warning if this limitation
is exceeded.

This patch qualifies make_virtual_commit() as static again because
this function is not needed anymore outside merge-recursive.c.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
	Hi,

	so this patch is marked as (1b) since it is based on Miklos'
	patch that I called (1a) in my mind :-)
	I'm unsure if it's good to squash both, but that's the decision
	of the maintainer - if taken at all.

	Some further remark that I thought about when writig the commit
	message:
	 1. It could be cleaner to choose a "struct string_list" for the
	    base_list in merge_recursive_generic()
	 2. If we do so, we've had lifted the limitation to 20 bases
	    automatically.
	 2. Since the patchset that is in work in this thread is for
	    post 1.6.0, I wonder if there should be a patch for the
	    20 bases limitation in git-merge-recursive for 1.6.0.
	    Either lifting it (ALLOC_GROW foo bar) or printing a warning.
	
	Regards,
	  Stephan

 builtin-merge-recursive.c |   64 +++++++++++++-------------------------------
 merge-recursive.c         |   53 +++++++++++++++++++++++++++++++++++++
 merge-recursive.h         |    4 ++-
 3 files changed, 75 insertions(+), 46 deletions(-)

diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 8bf2fa5..25f540b 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -15,36 +15,13 @@ static const char *better_branch_name(const char *branch)
 	return name ? name : branch;
 }
 
-static struct commit *get_ref(const char *ref)
-{
-	unsigned char sha1[20];
-	struct object *object;
-
-	if (get_sha1(ref, sha1))
-		die("Could not resolve ref '%s'", ref);
-	object = deref_tag(parse_object(sha1), ref, strlen(ref));
-	if (!object)
-		return NULL;
-	if (object->type == OBJ_TREE)
-		return make_virtual_commit((struct tree*)object,
-			better_branch_name(ref));
-	if (object->type != OBJ_COMMIT)
-		return NULL;
-	if (parse_commit((struct commit *)object))
-		die("Could not parse commit '%s'", sha1_to_hex(object->sha1));
-	return (struct commit *)object;
-}
-
 int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 {
-	static const char *bases[20];
-	static unsigned bases_count = 0;
-	int i, clean;
+	const char *bases[21];
+	unsigned bases_count = 0;
+	int i, failed;
 	const char *branch1, *branch2;
-	struct commit *result, *h1, *h2;
-	struct commit_list *ca = NULL;
-	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
-	int index_fd;
+	unsigned char h1[20], h2[20];
 	int subtree_merge = 0;
 
 	if (argv[0]) {
@@ -60,10 +37,15 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 		die("Usage: %s <base>... -- <head> <remote> ...\n", argv[0]);
 
 	for (i = 1; i < argc; ++i) {
-		if (!strcmp(argv[i], "--"))
+		if (!strcmp(argv[i], "--")) {
+			bases[bases_count] = NULL;
 			break;
-		if (bases_count < sizeof(bases)/sizeof(*bases))
+		}
+		if (bases_count < ARRAY_SIZE(bases)-1)
 			bases[bases_count++] = argv[i];
+		else
+			warning("Cannot handle more than %zu bases. "
+				"Ignoring %s.", ARRAY_SIZE(bases)-1, argv[i]);
 	}
 	if (argc - i != 3) /* "--" "<head>" "<remote>" */
 		die("Not handling anything other than two heads merge.");
@@ -71,8 +53,10 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 	branch1 = argv[++i];
 	branch2 = argv[++i];
 
-	h1 = get_ref(branch1);
-	h2 = get_ref(branch2);
+	if (get_sha1(branch1, h1))
+		die("Could not resolve ref '%s'", branch1);
+	if (get_sha1(branch2, h2))
+		die("Could not resolve ref '%s'", branch2);
 
 	branch1 = better_branch_name(branch1);
 	branch2 = better_branch_name(branch2);
@@ -80,18 +64,8 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 	if (merge_recursive_verbosity >= 3)
 		printf("Merging %s with %s\n", branch1, branch2);
 
-	index_fd = hold_locked_index(lock, 1);
-
-	for (i = 0; i < bases_count; i++) {
-		struct commit *ancestor = get_ref(bases[i]);
-		ca = commit_list_insert(ancestor, &ca);
-	}
-	clean = merge_recursive(h1, h2, branch1, branch2, ca, &result);
-
-	if (active_cache_changed &&
-	    (write_cache(index_fd, active_cache, active_nr) ||
-	     commit_locked_index(lock)))
-			die ("unable to write %s", get_index_file());
-
-	return clean ? 0: 1;
+	failed = merge_recursive_generic(bases, h1, branch1, h2, branch2);
+	if (failed < 0)
+		return 128; /* die() error code */
+	return failed;
 }
diff --git a/merge-recursive.c b/merge-recursive.c
index c3a57ac..74a9fdc 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1303,6 +1303,59 @@ int merge_recursive(struct commit *h1,
 	return clean;
 }
 
+static struct commit *get_ref(const unsigned char *sha1, const char *name)
+{
+	struct object *object;
+
+	object = deref_tag(parse_object(sha1), name, strlen(name));
+	if (!object)
+		return NULL;
+	if (object->type == OBJ_TREE)
+		return make_virtual_commit((struct tree*)object, name);
+	if (object->type != OBJ_COMMIT)
+		return NULL;
+	if (parse_commit((struct commit *)object))
+		return NULL;
+	return (struct commit *)object;
+}
+
+int merge_recursive_generic(const char **base_list,
+		const unsigned char *head_sha1, const char *head_name,
+		const unsigned char *next_sha1, const char *next_name)
+{
+	int clean, index_fd;
+	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
+	struct commit *result;
+	struct commit *head_commit = get_ref(head_sha1, head_name);
+	struct commit *next_commit = get_ref(next_sha1, next_name);
+	struct commit_list *ca = NULL;
+
+	if (base_list) {
+		int i;
+		for (i = 0; base_list[i]; ++i) {
+			unsigned char sha[20];
+			struct commit *base;
+			if (get_sha1(base_list[i], sha))
+				return error("Could not resolve ref '%s'",
+								base_list[i]);
+			if (!(base = get_ref(sha, base_list[i])))
+				return error("Could not parse object '%s'",
+								base_list[i]);
+			commit_list_insert(base, &ca);
+		}
+	}
+
+	index_fd = hold_locked_index(lock, 1);
+	clean = merge_recursive(head_commit, next_commit,
+				head_name, next_name, ca, &result);
+	if (active_cache_changed &&
+			(write_cache(index_fd, active_cache, active_nr) ||
+			 commit_locked_index(lock)))
+		return error("Unable to write index.");
+
+	return clean ? 0 : 1;
+}
+
 int merge_recursive_config(const char *var, const char *value, void *cb)
 {
 	if (!strcasecmp(var, "merge.verbosity")) {
diff --git a/merge-recursive.h b/merge-recursive.h
index 73e4413..4dd6476 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -14,7 +14,9 @@ int merge_trees(struct tree *head,
 		const char *branch1,
 		const char *branch2,
 		struct tree **result);
-struct commit *make_virtual_commit(struct tree *tree, const char *comment);
+extern int merge_recursive_generic(const char **base_list,
+		const unsigned char *head_sha1, const char *head_name,
+		const unsigned char *next_sha1, const char *next_name);
 int merge_recursive_config(const char *var, const char *value, void *cb);
 void merge_recursive_setup(int is_subtree_merge);
 struct tree *write_tree_from_memory(void);
-- 
1.6.0.rc2.281.g6f6cf
