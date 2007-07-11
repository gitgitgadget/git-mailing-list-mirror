From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/4] --decorate now decorates ancestors, too
Date: Wed, 11 Jul 2007 02:29:49 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707110229320.4047@racer.site>
References: <Pine.LNX.4.64.0707110220340.4047@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 11 03:37:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8R95-0002Jc-MH
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 03:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754838AbXGKBhd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 21:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754703AbXGKBhc
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 21:37:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:49433 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754544AbXGKBhb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 21:37:31 -0400
Received: (qmail invoked by alias); 11 Jul 2007 01:37:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 11 Jul 2007 03:37:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18xXJxKgUMx9GX8blSMv7AF+OLkSti3DVjiH1OoVW
	/bjc8alkhkTY+U
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707110220340.4047@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52126>


The option --decorate changed default behavior: Earlier, it decorated
commits pointed to by any ref.  The new behavior is this: decorate the
with the given refs and its ancestors, i.e.

	git log --decorate next master

will show "next", "next^", "next~2", ..., "master", "master^", ...
in parenthesis after the commit name.

However, you can still get the old behavior by giving --decorate=<mode>.
The available modes are:

- 'given'	the new default behavior,
- 'given-refs'	only decorate with the given refs, not their ancestors,
- 'tag'		decorate with all tag refs and their ancestors,
- 'tag-refs'	decorate with all tag refs, but not their ancestors,
- 'any'		decorate with all refs and their ancestors,
- 'any-ref'	decorate only with the refs, not their ancestors

The old behavior was 'any-ref'.

NOTE: Calling "git log --decorate=tag <commit>" is _not_ the same as
calling "git log <commit> | git -p name-rev --stdin":

For one, the latter will only try to name 40-character hex sequences
(which the former does not care about), but then it will also try
to name such sequences in the commit messages and the diffs.

More importantly, though, "--decorate=tag" will only build the names
while traversing commits, which makes it faster, but will fail to
correctly identify something like "git log --decorate=tag v0.99~2".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/pretty-options.txt |   17 ++++++++--
 commit.c                         |   68 +++++++++++++++++++++++++++++++++++--
 commit.h                         |    4 ++-
 log-tree.c                       |    4 ++
 revision.c                       |   43 +++++++++++++++++++++++-
 revision.h                       |    9 +++++
 6 files changed, 136 insertions(+), 9 deletions(-)

diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 3b21e0d..f82b1e9 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -21,6 +21,17 @@ people using 80-column terminals.
 	preferred by the user.  For non plumbing commands this
 	defaults to UTF-8.
 
---decorate::
-	When a commit is shown, and it matches a ref, print that ref name
-	in brackets after the commit name.
+--decorate[=<mode>]::
+	When a commit is shown, decorate its commit name with the refs
+	specified on the command line or their ancestors which point to
+	that commit.
++
+You can influence the behaviour by givin a mode:
+- 'given' is the default mode,
+- 'given-refs' skips the decoration for ancestors,
+- 'tag-refs' decorates only the tagged commits,
+- 'tag' decorates tagged commits and their ancestors,
+- 'any-ref' means that those commits are decorated that match any ref
+  exactly, but no ancestors, and
+- 'any' means that all commits that are pointed at by _any_ reachable
+  commit are decorated by the appropriate names.
diff --git a/commit.c b/commit.c
index c0748ed..3aa21cc 100644
--- a/commit.c
+++ b/commit.c
@@ -1554,13 +1554,24 @@ int in_merge_bases(struct commit *commit, struct commit **reference, int num)
 	return ret;
 }
 
-void add_name_decoration(const char *prefix, const char *name, struct object *obj)
+void add_name_decoration(const char *prefix, const char *name, int generation, struct object *obj)
 {
 	int plen = strlen(prefix);
 	int nlen = strlen(name);
-	struct name_decoration *res = xmalloc(sizeof(struct name_decoration) + plen + nlen);
+	struct name_decoration *res, *existing;
+
+	res = xmalloc(sizeof(struct name_decoration) + plen + nlen);
 	memcpy(res->name, prefix, plen);
 	memcpy(res->name + plen, name, nlen + 1);
+
+	for (existing = lookup_decoration(&name_decoration, obj);
+			existing; existing = existing->next)
+		if (!strcmp(existing->name, res->name)) {
+			free(res);
+			return;
+		}
+
+	res->generation = generation;
 	res->next = add_decoration(&name_decoration, obj, res);
 }
 
@@ -1569,12 +1580,61 @@ int add_ref_decoration(const char *refname, const unsigned char *sha1, int flags
 	struct object *obj = parse_object(sha1);
 	if (!obj)
 		return 0;
-	add_name_decoration("", refname, obj);
+	if (!prefixcmp(refname, "refs/heads/"))
+		refname += 11;
+	else if (!prefixcmp(refname, "refs/tags/"))
+		refname += 10;
+	else if (!prefixcmp(refname, "refs/remotes/"))
+		refname += 13;
+	else if (!prefixcmp(refname, "refs/"))
+		refname += 5;
+	add_name_decoration("", refname, 0, obj);
 	while (obj->type == OBJ_TAG) {
 		obj = ((struct tag *)obj)->tagged;
 		if (!obj)
 			break;
-		add_name_decoration("tag: ", refname, obj);
+		add_name_decoration("tag: ", refname, 0, obj);
 	}
 	return 0;
 }
+
+void add_name_decoration_to_parents(struct commit *commit)
+{
+	struct name_decoration *decoration, *decor;
+	struct commit_list *parents;
+	int parent_nr;
+
+	parents = commit->parents;
+	if (!parents)
+		return;
+
+	decoration = lookup_decoration(&name_decoration, &commit->object);
+	if (!decoration)
+		return;
+
+	for (decor = decoration; decor; decor = decor->next)
+		add_name_decoration("", decor->name, decor->generation + 1,
+				&parents->item->object);
+
+	parent_nr = 1;
+	while (parents->next) {
+		char buffer[PATH_MAX];
+		parents = parents->next;
+		parent_nr++;
+		for (decor = decoration; decor; decor = decor->next) {
+			if (decor->generation < 2)
+				snprintf(buffer, sizeof(buffer),
+						"%s%s^%d", decor->name,
+						decor->generation ? "^" : "",
+						parent_nr);
+			else
+				snprintf(buffer, sizeof(buffer),
+						"%s~%d^%d", decor->name,
+						decor->generation, parent_nr);
+			add_name_decoration("", buffer, 0,
+					&parents->item->object);
+		}
+	}
+}
+
+
diff --git a/commit.h b/commit.h
index 787ae5e..8dafc7b 100644
--- a/commit.h
+++ b/commit.h
@@ -26,11 +26,13 @@ extern const char *commit_type;
 extern struct decoration name_decoration;
 struct name_decoration {
 	struct name_decoration *next;
+	int generation;
 	char name[1];
 };
 
-void add_name_decoration(const char *prefix, const char *name, struct object *obj);
+void add_name_decoration(const char *prefix, const char *name, int generation, struct object *obj);
 int add_ref_decoration(const char *refname, const unsigned char *sha1, int flags, void *cb_data);
+void add_name_decoration_to_parents(struct commit *commit);
 
 struct commit *lookup_commit(const unsigned char *sha1);
 struct commit *lookup_commit_reference(const unsigned char *sha1);
diff --git a/log-tree.c b/log-tree.c
index 8624d5a..eb7641a 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -26,6 +26,10 @@ static void show_decorations(struct commit *commit)
 	prefix = " (";
 	while (decoration) {
 		printf("%s%s", prefix, decoration->name);
+		if (decoration->generation == 1)
+			putchar('^');
+		else if (decoration->generation > 1)
+			printf("~%d", decoration->generation);
 		prefix = ", ";
 		decoration = decoration->next;
 	}
diff --git a/revision.c b/revision.c
index 7683d0a..79880b4 100644
--- a/revision.c
+++ b/revision.c
@@ -641,6 +641,10 @@ static int add_parents_only(struct rev_info *revs, const char *arg, int flags)
 	if (it->type != OBJ_COMMIT)
 		return 0;
 	commit = (struct commit *)it;
+	if (revs->decorate & DECORATE_GIVEN_REFS)
+		add_name_decoration("", arg, 0, it);
+	if (revs->decorate & DECORATE_RECURSIVE)
+		add_name_decoration_to_parents(commit);
 	for (parents = commit->parents; parents; parents = parents->next) {
 		it = &parents->item->object;
 		it->flags |= flags;
@@ -778,6 +782,11 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 				verify_non_filename(revs->prefix, arg);
 			}
 
+			if (revs->decorate & DECORATE_GIVEN_REFS) {
+				add_name_decoration("", this, 0, &a->object);
+				add_name_decoration("", next, 0, &b->object);
+			}
+
 			if (symmetric) {
 				exclude = get_merge_bases(a, b, 1);
 				add_pending_commit_list(revs, exclude,
@@ -817,6 +826,8 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 	if (!cant_be_filename)
 		verify_non_filename(revs->prefix, arg);
 	object = get_reference(revs, arg, sha1, flags ^ local_flags);
+	if (revs->decorate & DECORATE_GIVEN_REFS)
+		add_name_decoration("", arg, 0, object);
 	add_pending_object_with_mode(revs, object, arg, mode);
 	return 0;
 }
@@ -1177,7 +1188,29 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				continue;
 			}
 			if (!strcmp(arg, "--decorate")) {
-				for_each_ref(add_ref_decoration, NULL);
+				revs->decorate = DECORATE_GIVEN_REFS |
+					DECORATE_RECURSIVE;
+				continue;
+			}
+			if (!prefixcmp(arg, "--decorate=")) {
+				if (!strcmp(arg + 11, "any-ref"))
+					revs->decorate = DECORATE_ALL_REFS;
+				else if (!strcmp(arg + 11, "given-refs"))
+					revs->decorate = DECORATE_GIVEN_REFS;
+				else if (!strcmp(arg + 11, "given"))
+					revs->decorate = DECORATE_GIVEN_REFS |
+						DECORATE_RECURSIVE;
+				else if (!strcmp(arg + 11, "any"))
+					revs->decorate = DECORATE_GIVEN_REFS |
+						DECORATE_ALL_REFS |
+						DECORATE_RECURSIVE;
+				else if (!strcmp(arg + 11, "tag-refs"))
+					revs->decorate = DECORATE_TAG_REFS;
+				else if (!strcmp(arg + 11, "tag"))
+					revs->decorate = DECORATE_TAG_REFS |
+						DECORATE_RECURSIVE;
+				else
+					die("Unknown argument: %s", arg);
 				continue;
 			}
 
@@ -1213,6 +1246,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		}
 	}
 
+	if (revs->decorate & DECORATE_ALL_REFS)
+		for_each_ref(add_ref_decoration, NULL);
+	if (revs->decorate & DECORATE_TAG_REFS)
+		for_each_tag_ref(add_ref_decoration, NULL);
+
 	if (revs->grep_filter)
 		revs->grep_filter->regflags |= regflags;
 
@@ -1372,6 +1410,9 @@ static struct commit *get_revision_1(struct rev_info *revs)
 		revs->commits = entry->next;
 		free(entry);
 
+		if (revs->decorate & DECORATE_RECURSIVE)
+			add_name_decoration_to_parents(commit);
+
 		if (revs->reflog_info)
 			fake_reflog_parent(revs->reflog_info, commit);
 
diff --git a/revision.h b/revision.h
index f46b4d5..0c3dc67 100644
--- a/revision.h
+++ b/revision.h
@@ -16,6 +16,14 @@ struct log_info;
 
 typedef void (prune_fn_t)(struct rev_info *revs, struct commit *commit);
 
+enum decorate {
+	DECORATE_NONE = 0,
+	DECORATE_RECURSIVE = 1,
+	DECORATE_ALL_REFS = 2,
+	DECORATE_TAG_REFS = 4,
+	DECORATE_GIVEN_REFS = 8,
+};
+
 struct rev_info {
 	/* Starting list */
 	struct commit_list *commits;
@@ -65,6 +73,7 @@ struct rev_info {
 	unsigned int	shown_one:1,
 			abbrev_commit:1;
 	enum date_mode date_mode;
+	enum decorate	decorate;
 
 	const char **ignore_packed; /* pretend objects in these are unpacked */
 	int num_ignore_packed;
-- 
1.5.3.rc0.2783.gf3f7
