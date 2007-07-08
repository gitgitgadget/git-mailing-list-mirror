From: skimo@liacs.nl
Subject: [PATCH 4/4] Add git-rewrite-commits
Date: Sun,  8 Jul 2007 18:23:27 +0200
Message-ID: <1183911808787-git-send-email-skimo@liacs.nl>
References: <11839118073186-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 18:24:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7ZYM-0003RT-Gh
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 18:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754590AbXGHQXr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 12:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754560AbXGHQXr
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 12:23:47 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:60199 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754345AbXGHQXi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 12:23:38 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l68GNSse031443;
	Sun, 8 Jul 2007 18:23:33 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id B2B893C00E; Sun,  8 Jul 2007 18:23:28 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc0.63.gc956
In-Reply-To: <11839118073186-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51892>

From: Sven Verdoolaege <skimo@kotnet.org>

This builtin is similar to git-filter-branch (and cg-admin-rewritehist).
The main difference is that git-rewrite-commits will automatically
rewrite any SHA1 in a commit message to the rewritten SHA1 as
well as any reference (in .git/refs/) that points to a rewritten commit.

It's also a lot faster than git-filter-branch if no external command
is called.  For example, running either to eliminating a commit specified
as a graft results in the following timings, both being performed
on a freshly cloned copy of a small repo:

	bash-3.00$ time git-filter-branch test
	Rewrite 274fe3dfb8e8c7d0a6ce05138bdb650de7b459ea (425/425)
	Rewritten history saved to the test branch

	real    0m30.845s
	user    0m13.400s
	sys     0m19.640s

	bash-3.00$ time git-rewrite-commits

	real    0m0.223s
	user    0m0.080s
	sys     0m0.140s

The command line is more reminiscent of git-log.
For example you can say

	git-rewrite-commits --all

to incorporate grafts in all branches, or

	git rewrite-commits --author='!Darl McBribe' --all

to remove all commits by Darl McBribe.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 .gitignore                            |    1 +
 Documentation/cmd-list.perl           |    1 +
 Documentation/git-rewrite-commits.txt |  147 +++++++++++
 Makefile                              |    1 +
 builtin-rewrite-commits.c             |  451 +++++++++++++++++++++++++++++++++
 builtin.h                             |    1 +
 git.c                                 |    1 +
 t/t7005-rewrite-commits.sh            |   74 ++++++
 8 files changed, 677 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-rewrite-commits.txt
 create mode 100644 builtin-rewrite-commits.c
 create mode 100755 t/t7005-rewrite-commits.sh

diff --git a/.gitignore b/.gitignore
index 20ee642..bcd95a9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -109,6 +109,7 @@ git-reset
 git-rev-list
 git-rev-parse
 git-revert
+git-rewrite-commits
 git-rm
 git-runstatus
 git-send-email
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 2143995..63911b7 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -166,6 +166,7 @@ git-reset                               mainporcelain
 git-revert                              mainporcelain
 git-rev-list                            plumbinginterrogators
 git-rev-parse                           ancillaryinterrogators
+git-rewrite-commits                     mainporcelain
 git-rm                                  mainporcelain
 git-runstatus                           ancillaryinterrogators
 git-send-email                          foreignscminterface
diff --git a/Documentation/git-rewrite-commits.txt b/Documentation/git-rewrite-commits.txt
new file mode 100644
index 0000000..d82b777
--- /dev/null
+++ b/Documentation/git-rewrite-commits.txt
@@ -0,0 +1,147 @@
+git-rewrite-commits(1)
+======================
+
+NAME
+----
+git-rewrite-commits - Rewrite commits
+
+SYNOPSIS
+--------
+'git-rewrite-commits' [--index-map <command>] [--commit-map <command>]
+	[<rev-list options>...]
+
+DESCRIPTION
+-----------
+Lets you rewrite the commits selected by the gitlink:git-rev-list[1]
+options, optionally applying custom maps on each of them.
+These maps either modify the tree associated to a commit
+(through manipulations of the index) or the (raw) commit itself.
+Any commit within the specified range that is filtered out
+through a pattern is removed from its children (assuming they
+are in range) and replaced by the closest ancestors that
+are either not being rewritten or not filtered out.
+
+Any branch pointing to any of the rewritten commits is replaced
+by a pointer to the new commit.  The original pointers are saved
+in the refs/rewritten hierarchy.  Any SHA1 in the commit message
+of any of the rewritten commits that points to (another) rewritten
+commit is replaced by the SHA1 of the corresponding new commit.
+
+Besides the actions specified by the maps, the new commits
+will also reflect any grafts that may apply to any of the selected commits.
+
+*WARNING*! The rewritten history will have different object names for all
+the objects and will not converge with the original branch.  You will not
+be able to easily push and distribute the rewritten branch on top of the
+original branch.  Please do not use this command if you do not know the
+full implications, and avoid using it anyway, if a simple single commit
+would suffice to fix your problem.
+
+Maps
+~~~~
+
+The maps are applied in the order as listed below.  The <command>
+argument is run as "sh -c '<command'>".
+
+
+OPTIONS
+-------
+
+--index-map <command>::
+	This map should only modify the index specified by 'GIT_INDEX_FILE'.
+	Prior to running the map, this temporary index is populated
+	with the tree of the commit that is being rewritten.
+	This tree will be replaced according to the new state of this
+	temporary index after the map finishes.
+
+--commit-map <command>::
+	This map receives the (raw) commit on stdin and should produce
+	the (possibly) modified commit on stdout.  In the input commit,
+	the tree has already been modified by the index map (if any)
+	and has all references to older commits (including the parents)
+	changed to the possibly rewritten commits.
+
+<rev-list-options>::
+	Selects the commits to be rewritten, defaulting to the history
+	that lead to HEAD.  If commits are filtered using a (negative)
+	pattern then all the commits filtered out will be removed
+	from the history of the selected commits.
+
+
+Examples
+--------
+
+Suppose you want to remove a file (containing confidential information
+or copyright violation) from all commits:
+
+--------------------------------------------------------------------
+git rewrite-commits --index-map 'git update-index --remove filename'
+--------------------------------------------------------------------
+
+Now, you will get the rewritten history saved in your current branch
+(the old branch is saved in refs/rewritten).
+
+To set a commit "$graft-id" (which typically is at the tip of another
+history) to be the parent of the current initial commit "$commit-id", in
+order to paste the other history behind the current history:
+
+-----------------------------------------------
+echo "$commit-id $graft-id" >> .git/info/grafts
+git rewrite-commits
+-----------------------------------------------
+
+To remove commits authored by "Darl McBribe" from the history:
+
+--------------------------------------------
+git rewrite-commits --author='!Darl McBribe'
+--------------------------------------------
+
+Note that the changes introduced by the commits, and not reverted by
+subsequent commits, will still be in the rewritten branch. If you want
+to throw out _changes_ together with the commits, you should use the
+interactive mode of gitlink:git-rebase[1].
+
+Consider this history:
+
+------------------
+     D--E--F--G--H
+    /     /
+A--B-----C
+------------------
+
+To rewrite only commits D,E,F,G,H, but leave A, B and C alone, use:
+
+--------------------------------
+git rewrite-commits ... C..H
+--------------------------------
+
+To rewrite commits E,F,G,H, use one of these:
+
+----------------------------------------
+git rewrite-commits ... C..H --not D
+git rewrite-commits ... D..H --not C
+----------------------------------------
+
+To move the whole tree into a subdirectory, or remove it from there:
+
+---------------------------------------------------------------
+git rewrite-commits --index-map \
+	'git ls-files -s | sed "s-\t-&newsubdir/-" |
+		GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
+			git update-index --index-info &&
+	 mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE'
+---------------------------------------------------------------
+
+
+Author
+------
+Written by Sven Verdoolaege.
+Inspired by cg-admin-rewritehist by Petr "Pasky" Baudis <pasky@suse.cz>.
+
+Documentation
+--------------
+Documentation by Petr Baudis, Sven Verdoolaege and the git list.
+
+GIT
+---
+Part of the gitlink:git[7] suite
diff --git a/Makefile b/Makefile
index 5b30e5c..f84bcd7 100644
--- a/Makefile
+++ b/Makefile
@@ -370,6 +370,7 @@ BUILTIN_OBJS = \
 	builtin-rev-list.o \
 	builtin-rev-parse.o \
 	builtin-revert.o \
+	builtin-rewrite-commits.o \
 	builtin-rm.o \
 	builtin-runstatus.o \
 	builtin-shortlog.o \
diff --git a/builtin-rewrite-commits.c b/builtin-rewrite-commits.c
new file mode 100644
index 0000000..eebf816
--- /dev/null
+++ b/builtin-rewrite-commits.c
@@ -0,0 +1,451 @@
+#include "cache.h"
+#include "refs.h"
+#include "builtin.h"
+#include "commit.h"
+#include "diff.h"
+#include "revision.h"
+#include "list-objects.h"
+#include "run-command.h"
+#include "cache-tree.h"
+#include "grep.h"
+
+struct decoration rewrite_decoration = { "rewritten as" };
+static const char *rewritten_prefix = "rewritten";
+static const char *commit_map;
+static const char *index_map;
+
+struct rewrite_decoration {
+	struct rewrite_decoration *next;
+	unsigned char sha1[20];
+};
+
+static void add_rewrite_decoration(struct object *obj, unsigned char *sha1)
+{
+	struct rewrite_decoration *deco = xmalloc(sizeof(struct rewrite_decoration));
+	hashcpy(deco->sha1, sha1);
+	deco->next = add_decoration(&rewrite_decoration, obj, deco);
+}
+
+static int get_rewritten_sha1(unsigned char *sha1)
+{
+	struct rewrite_decoration *deco;
+	struct object *obj = lookup_object(sha1);
+
+	if (!obj)
+		return 1;
+
+	deco = lookup_decoration(&rewrite_decoration, obj);
+	if (!deco)
+		return 1;
+
+	hashcpy(sha1, deco->sha1);
+	return 0;
+}
+
+static char *add_parents(char *dest, struct commit_list *parents)
+{
+	unsigned char sha1[20];
+	struct commit_list *list;
+
+	for (list = parents; list; list = list->next) {
+		hashcpy(sha1, list->item->object.sha1);
+		get_rewritten_sha1(sha1);
+		memcpy(dest, "parent ", 7);
+		dest += 7;
+		memcpy(dest, sha1_to_hex(sha1), 40);
+		dest += 40;
+		*dest++ = '\n';
+	}
+	return dest;
+}
+
+static int get_one_line(char *buf, unsigned long len)
+{
+	char *end = memchr(buf, '\n', len);
+	if (end)
+		return end - buf + 1;
+	return len;
+}
+
+static char *map_index(char *orig_hex)
+{
+	int argc;
+	const char *argv[10];
+	static char index_env[16+PATH_MAX];
+	char *tmp_index = git_path("rewrite_index");
+	const char *env[] = { index_env, NULL };
+	char *hex;
+
+	memcpy(index_env, "GIT_INDEX_FILE=", 15);
+	strcpy(index_env+15, tmp_index);
+	tmp_index = index_env+15;
+
+	/* First write out tree to temporary index */
+	argc = 0;
+	argv[argc++] = "read-tree";
+	argv[argc++] = orig_hex;
+	argv[argc] = NULL;
+	if (run_command_v_opt_cd_env(argv, RUN_GIT_CMD, NULL, env))
+		die("Cannot write index '%s' for map", tmp_index);
+
+	/* Then map the index */
+	argc = 0;
+	argv[argc++] = "sh";
+	argv[argc++] = "-c";
+	argv[argc++] = index_map;
+	argv[argc] = NULL;
+	if (run_command_v_opt_cd_env(argv, 0, NULL, env))
+		die("Index map '%s' failed", index_map);
+
+	/* Finally read it back in */
+	if (read_cache_from(tmp_index) < 0)
+		die("Error reading index '%s'", tmp_index);
+	active_cache_tree = cache_tree();
+	if (cache_tree_update(active_cache_tree, active_cache, active_nr,
+			      0, 0) < 0)
+		die("Error building trees");
+	hex = sha1_to_hex(active_cache_tree->sha1);
+	discard_cache();
+
+	unlink(tmp_index);
+
+	return hex;
+}
+
+static char *rewrite_header(char *dest, unsigned long *len_p, char **buf_p,
+			    struct commit_list *parents)
+{
+	int linelen;
+	do {
+		char *line = *buf_p;
+		linelen = get_one_line(*buf_p, *len_p);
+
+		if (!linelen)
+			return dest;
+		*buf_p += linelen;
+		*len_p -= linelen;
+
+		if (index_map && !memcmp(line, "tree ", 5)) {
+			if (linelen != 46)
+				die("bad tree line in commit");
+			memcpy(dest, "tree ", 5);
+			line[45] = '\0';
+			memcpy(dest+5, map_index(line+5), 40);
+			line[45] = '\n';
+			dest[45] = '\n';
+			dest += 46;
+			continue;
+		}
+
+		/* drop old parents */
+		if (!memcmp(line, "parent ", 7)) {
+			if (linelen != 48)
+				die("bad parent line in commit");
+			continue;
+		}
+
+		/* insert new parents before author */
+		if (!memcmp(line, "author ", 7))
+			dest = add_parents(dest, parents);
+
+		memcpy(dest, line, linelen);
+		dest += linelen;
+	} while (linelen > 1);
+	return dest;
+}
+
+static size_t memspn(const char *s, const char *accept, size_t n)
+{
+	size_t offset;
+
+	for (offset = 0; offset < n; ++offset)
+		if (!strchr(accept, s[offset]))
+			break;
+	return offset;
+}
+
+static size_t memcspn(const char *s, const char *accept, size_t n)
+{
+	size_t offset;
+
+	for (offset = 0; offset < n; ++offset)
+		if (strchr(accept, s[offset]))
+			break;
+	return offset;
+}
+
+/* Replace any (short) sha1 of a rewritten commit by the new (short) sha1 */
+static char *rewrite_body(char *dest, unsigned long len, char *buf)
+{
+	static const char hex[] = "0123456789abcdef";
+	unsigned char sha1[20];
+
+	while (len) {
+		size_t ll = memcspn(buf, hex, len);
+		memcpy(dest, buf, ll);
+		dest += ll;
+		buf += ll;
+		len -= ll;
+
+		ll = memspn(buf, hex, len);
+		if (ll >= 8 && ll <= 40 &&
+		    !get_short_sha1(buf, ll, sha1, 1) &&
+		    !get_rewritten_sha1(sha1))
+			memcpy(dest, sha1_to_hex(sha1), ll);
+		else
+			memcpy(dest, buf, ll);
+		dest += ll;
+		buf += ll;
+		len -= ll;
+	}
+	return dest;
+}
+
+static void write_ref_sha1_or_die(const char *ref, const unsigned char *old_sha1,
+				  const unsigned char *new_sha1,
+				  const char *logmsg, int flags)
+{
+	struct ref_lock *lock;
+
+	lock = lock_any_ref_for_update(ref, old_sha1, flags);
+	if (!lock)
+		die("%s: cannot lock the ref", ref);
+	if (write_ref_sha1(lock, new_sha1, logmsg) < 0)
+		die("%s: cannot update the ref", ref);
+}
+
+static int is_ref_to_be_rewritten(const char *ref)
+{
+	unsigned char sha1[20];
+	int flag;
+
+	if (prefixcmp(ref, "refs/"))
+		return 0;
+	if (!prefixcmp(ref, "refs/remotes/"))
+		return 0;
+
+	resolve_ref(ref, sha1, 0, &flag);
+	if (flag & REF_ISSYMREF)
+		return 0;
+
+	return 1;
+}
+
+static void rewrite_sha1(struct object *obj, unsigned char *new_sha1)
+{
+	struct name_decoration *deco;
+	int prefix_len;
+
+	if (!hashcmp(obj->sha1, new_sha1))
+		return;
+
+	add_rewrite_decoration(obj, new_sha1);
+
+	prefix_len = strlen(rewritten_prefix);
+	deco = lookup_decoration(&name_decoration, obj);
+	for (; deco; deco = deco->next) {
+		char buffer[256];
+		char *p;
+		int len = strlen(deco->name);
+
+		if (!is_ref_to_be_rewritten(deco->name))
+			continue;
+		if (len + prefix_len + 1 + 1 > sizeof(buffer))
+			die("rewrite ref of '%s' too long", deco->name);
+		p = buffer;
+		memcpy(p, "refs/", 5);
+		p += 5;
+		memcpy(p, rewritten_prefix, prefix_len);
+		p += prefix_len;
+		memcpy(p, deco->name+4, len-4 + 1);
+
+		write_ref_sha1_or_die(buffer, NULL, obj->sha1,
+					"copied during rewrite", 0);
+
+		if (is_null_sha1(new_sha1))
+			delete_ref(deco->name, obj->sha1);
+		else
+			write_ref_sha1_or_die(deco->name, obj->sha1, new_sha1,
+						"rewritten", 0);
+	}
+}
+
+static void map_and_write_commit(char *commit, size_t len, unsigned char *sha1)
+{
+	char commit_path[PATH_MAX];
+	struct child_process cmd;
+	int argc;
+	const char *argv[10];
+	int fd;
+
+	fd = git_mkstemp(commit_path, sizeof(commit_path), ".commit_XXXXXX");;
+	write_or_die(fd, commit, len);
+
+	argc = 0;
+	argv[argc++] = "sh";
+	argv[argc++] = "-c";
+	argv[argc++] = commit_map;
+	argv[argc] = NULL;
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.in = open(commit_path, O_RDONLY);
+	if (cmd.in < 0)
+		die("Unable to read commit from file '%s'", commit_path);
+	unlink(commit_path);
+	cmd.out = -1;
+	cmd.argv = argv;
+	if (start_command(&cmd))
+		die("Commit map '%s' failed to start", commit_map);
+	if (index_pipe(sha1, cmd.out, commit_type, 1))
+		die("Unable to write new commit");
+	if (finish_command(&cmd))
+		die("Commit map '%s' failed", commit_map);
+	close(cmd.in);
+}
+
+/*
+ * Replace any parent that has been removed by its parents
+ * and return the number of new parents.
+ * We directly modify the parent list, so any libification
+ * should probably adapt this function.
+ */
+static int rewrite_parents(struct commit *commit)
+{
+	int n;
+	struct commit_list *list, *parents, **prev;
+	unsigned char sha1[20];
+
+	for (n = 0, prev = &commit->parents; *prev; ++n) {
+		list = *prev;
+
+		if (!(list->item->object.flags & PRUNED)) {
+			prev = &list->next;
+			continue;
+		}
+
+		hashcpy(sha1, list->item->object.sha1);
+		get_rewritten_sha1(sha1);
+		if (!is_null_sha1(sha1)) {
+			hashclr(sha1);
+			rewrite_sha1(&list->item->object, sha1);
+		}
+
+		parents = list->item->parents;
+		if (!parents) {
+			*prev = list->next;
+			free(list);
+			--n;
+			continue;
+		}
+		list->item = parents->item;
+		prev = &list->next;
+		list = list->next;
+		while ((parents = parents->next)) {
+			commit_list_insert(parents->item, prev);
+			prev = &(*prev)->next;
+			++n;
+		}
+		*prev = list;
+	}
+
+	return n;
+}
+
+static void rewrite_commit(struct commit *commit)
+{
+	char *buf, *p;
+	int n;
+	char *orig_buf = commit->buffer;
+	unsigned long orig_len = strlen(orig_buf);
+	unsigned char sha1[20];
+
+	n = rewrite_parents(commit);
+
+	/* Make enough remove for n (possibly extra) parents */
+	p = buf = xmalloc(orig_len + n*48);
+	p = rewrite_header(p, &orig_len, &orig_buf, commit->parents);
+	p = rewrite_body(p, orig_len, orig_buf);
+	if (!commit_map) {
+		if (write_sha1_file(buf, p-buf, commit_type, sha1))
+			die("Unable to write new commit");
+	} else
+		map_and_write_commit(buf, p-buf, sha1);
+	free(buf);
+
+	rewrite_sha1(&commit->object, sha1);
+}
+
+static void move_head_forward(char *ref, unsigned char *old_sha1, int detached)
+{
+	unsigned char new_sha1[20];
+	int rewritten;
+
+	hashcpy(new_sha1, old_sha1);
+	rewritten = !get_rewritten_sha1(new_sha1);
+	if (rewritten && !is_bare_repository()) {
+		int argc;
+		const char *argv[10];
+
+		argc = 0;
+		argv[argc++] = "read-tree";
+		argv[argc++] = "-m";
+		argv[argc++] = "-u";
+		argv[argc++] = sha1_to_hex(old_sha1);
+		argv[argc++] = sha1_to_hex(new_sha1);
+		argv[argc] = NULL;
+		if (run_command_v_opt(argv, RUN_GIT_CMD))
+			die("Cannot move HEAD forward");
+	}
+	if (!detached)
+		create_symref("HEAD", ref, "reattached after rewrite");
+	else if (rewritten)
+		write_ref_sha1_or_die("HEAD", NULL, new_sha1,
+				    "rewritten", REF_NODEREF);
+}
+
+int cmd_rewrite_commits(int argc, const char **argv, const char *prefix)
+{
+	struct rev_info rev;
+	struct commit *commit;
+	unsigned char HEAD_sha1[20];
+	char *HEAD_ref;
+	int flag;
+	int i, j;
+
+	init_revisions(&rev, prefix);
+
+	for (i = 1, j = 1; i < argc; ++i) {
+		if (!strcmp(argv[i], "--index-map")) {
+			if (++i == argc)
+				die("Argument required for --index-map");
+			index_map = argv[i];
+		} else if (!strcmp(argv[i], "--commit-map")) {
+			if (++i == argc)
+				die("Argument required for --commit-map");
+			commit_map = argv[i];
+		} else
+			argv[j++] = argv[i];
+	}
+	argc = j;
+	argc = setup_revisions(argc, argv, &rev, "HEAD");
+	rev.ignore_merges = 0;
+	rev.topo_order = 1;
+	rev.reverse = 1;
+
+	for_each_ref(add_ref_decoration, NULL);
+
+	HEAD_ref = xstrdup(resolve_ref("HEAD", HEAD_sha1, 1, &flag));
+	if (flag & REF_ISSYMREF) {
+		/* Detach HEAD at its current position */
+		write_ref_sha1_or_die("HEAD", NULL, HEAD_sha1,
+					"detached for rewrite", REF_NODEREF);
+	}
+
+	prepare_revision_walk(&rev);
+	while ((commit = get_revision(&rev)) != NULL) {
+		rewrite_commit(commit);
+	}
+
+	move_head_forward(HEAD_ref, HEAD_sha1, !(flag & REF_ISSYMREF));
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 661a92f..e01d337 100644
--- a/builtin.h
+++ b/builtin.h
@@ -63,6 +63,7 @@ extern int cmd_rerere(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_list(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_parse(int argc, const char **argv, const char *prefix);
 extern int cmd_revert(int argc, const char **argv, const char *prefix);
+extern int cmd_rewrite_commits(int argc, const char **argv, const char *prefix);
 extern int cmd_rm(int argc, const char **argv, const char *prefix);
 extern int cmd_runstatus(int argc, const char **argv, const char *prefix);
 extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index a647f9c..ce02b0b 100644
--- a/git.c
+++ b/git.c
@@ -356,6 +356,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "rev-list", cmd_rev_list, RUN_SETUP },
 		{ "rev-parse", cmd_rev_parse, RUN_SETUP },
 		{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
+		{ "rewrite-commits", cmd_rewrite_commits, RUN_SETUP },
 		{ "rm", cmd_rm, RUN_SETUP | NEED_WORK_TREE },
 		{ "runstatus", cmd_runstatus, RUN_SETUP | NEED_WORK_TREE },
 		{ "shortlog", cmd_shortlog, RUN_SETUP | USE_PAGER },
diff --git a/t/t7005-rewrite-commits.sh b/t/t7005-rewrite-commits.sh
new file mode 100755
index 0000000..93f438f
--- /dev/null
+++ b/t/t7005-rewrite-commits.sh
@@ -0,0 +1,74 @@
+#!/bin/sh
+
+test_description='git-rewrite-commits'
+. ./test-lib.sh
+
+make_commit () {
+	lower=$(echo $1 | tr A-Z a-z)
+	echo $lower > $lower
+	git add $lower
+	test_tick
+	git commit -m $1
+	git tag $1
+}
+
+test_expect_success 'setup' '
+	make_commit A
+	make_commit B
+	git checkout -b branch B
+	make_commit D
+	make_commit E
+	git checkout master
+	make_commit C
+	git checkout branch
+	git merge C
+	git tag F
+	make_commit G
+	make_commit H
+'
+
+orig_H=$(git rev-parse H)
+test_expect_success 'rewrite identically' '
+	git-rewrite-commits
+'
+
+test_expect_success 'result is really identical' '
+	test $orig_H = $(git rev-parse H)
+'
+
+# for lack of 'git-mv --cached d doh'
+test_expect_success 'rewrite, renaming a specific file' '
+	git-rewrite-commits --index-map \
+		"git-ls-files -s | sed \"s-\\td\\\$-\\tdoh-\" |
+	         GIT_INDEX_FILE=\$GIT_INDEX_FILE.new \
+		     git-update-index --index-info &&
+		 mv \$GIT_INDEX_FILE.new \$GIT_INDEX_FILE"
+'
+
+test_expect_success 'test that the file was renamed' '
+	test d = $(git-show H:doh) &&
+	! git-show H:d --
+'
+
+orig_H=$(git rev-parse H)
+test_expect_success 'use index-map to move into a subdirectory' '
+	git-rewrite-commits --index-map \
+		 "git ls-files -s | sed \"s-\\t-&newsubdir/-\" |
+	          GIT_INDEX_FILE=\$GIT_INDEX_FILE.new \
+			git update-index --index-info &&
+		  mv \$GIT_INDEX_FILE.new \$GIT_INDEX_FILE" &&
+	test -z "$(git diff $orig_H H:newsubdir)"'
+
+test_expect_success 'remove merge commit' '
+	git-rewrite-commits --grep="!Merge" &&
+	test 2 = `git-log ^G^@ G --pretty=format:%P | wc -w`'
+
+test_expect_success 'remove first commit' '
+	git-rewrite-commits --grep="!A"'
+
+test_expect_success 'stops when index map fails' '
+	! git-rewrite-commits --index-map false &&
+	git-checkout branch
+'
+
+test_done
-- 
1.5.3.rc0.68.geec71-dirty
