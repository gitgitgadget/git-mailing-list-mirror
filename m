From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] A new merge stragety 'subtree'.
Date: Fri, 16 Feb 2007 17:49:14 -0800
Message-ID: <7vfy95y2n9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 17 02:49:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIEhc-0008D4-Rq
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 02:49:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946365AbXBQBtW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 20:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946368AbXBQBtW
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 20:49:22 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:41234 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946365AbXBQBtV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 20:49:21 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070217014921.OIYC1349.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 16 Feb 2007 20:49:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QRpL1W0041kojtg0000000; Fri, 16 Feb 2007 20:49:20 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39963>

I've explained how I initially merged from Shawn's git-gui, but
some people might have wondered how I continue to pull from
him.  I published the secret on 'pu' last night, but here is an
update that I currently have in my tree (still in 'pu').

The new merge strategy 'subtree' is a slightly modified
'recursive'.  It merges current branch A with other branch
B using common merge base O (and if there are more than one
common merge bases, they are recursively merged), but it can 
"shift" trees while doing so.

I did the initial git-gui merge in commit b4d2b0.  Later, I
needed to get some updates so I created commit 67c7575.


                 b4d2b0  d63ea11
 git.git    ----o---*-------o---* 67c7575
                   /           /
 git-gui.git   ---o------o----o fdf6cfc
            0960f7d

The commit before the merge (d63ea11) has slightly older tree
contents from git-gui repository, but all renamed to be under
git-gui/ directory.

        $ git diff --numstat d63ea11:git-gui fdf6cfc^{tree}
        43	12	GIT-VERSION-GEN
        14	6	Makefile
        1	1	git-gui.sh

What merge-subtree does, when doing tree-level three-way merge
between A and B based on O (that is, merge-subtree O -- A B) is
to 'shift' B to match the tree shape of A.

The tree-shifting is a fun operation, as it sometimes needs to
shift up and sometimes shift down.  When B looks like a subtree
in A, we create a copy of A's tree, and replace the subtree that
corresponds to B with B's tree.  When A looks like a subtree in
B, then we just pick the subtree that corresponds to A's tree
out of B (discarding the other parts of it).

The same tree-shifting is done for the merge base to make it
look like A.  Then merge-recursive does its job just as usual.
The commit 67c7575 was made by shifting Shawn's tree down,
replacing the tree at git-gui in d63ea11 with fdf6cfc.

It works the other way as well.  Shawn can pull d63ea11 from me
to his tree with subtree strategy.  In this case, he will be
shifting my tree up, using only the tree that corresponds to
git-gui/ subdirectory.

What's interesting is that this makes merge an asymmetric
operation.  The resulting tree from such a pull will not look
like what I have in 67c7575; it will be only the git-gui subtree
of it.

For normal merge strategies, if you are on branch A and merge
branch B into it, what you will get is exactly the same as what
you would get by merging branch A while being on branch A
(modulo the direction of conflict markers).  With the subtree
merge, it is not the case anymore.  If I pull from git-gui.git,
the resulting tree look like git.git with Shawn's updates.  If
Shawn pulls from git.git, even after I did some changes on my
own to git-gui subdirectory, bypassing his tree, he will get a
merged result pertaining to git-gui.git repository
(i.e. git-gui/ subdirectory of what I have).  This way, we can
continue merging from each other.

Although I do not plan to commit anything in git-gui/ part of my
tree myself, bypassing Shawn, it is nice to know that it will
not introduce problems down the road.

The subtree merge strategy is inherently incompatible with
fast-forward, so the patch teaches git-merge about it.

-- >8 --

This merge strategy largely piggy-backs on git-merge-recursive.
When merging trees A and B, if B corresponds to a subtree of A,
B is first adjusted to match the tree structure of A, instead of
reading the trees at the same level.  This adjustment is also
done to the common ancestor tree.

If you are pulling updates from git-gui repository into git.git
repository, the root level of the former corresponds to git-gui/
subdirectory of the latter.  The tree object of git-gui's toplevel
is wrapped in a fake tree object, whose sole entry has name 'git-gui'
and records object name of the true tree, before being used by
the 3-way merge code.

If you are merging the other way, only the git-gui/ subtree of
git.git is extracted and merged into git-gui's toplevel.

The detection of corresponding subtree is done by comparing the
pathnames and types in the toplevel of the tree.

Heuristics galore!  That's the git way ;-).

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 .gitignore         |    2 +
 Makefile           |   10 ++-
 cache.h            |    3 +
 git-merge.sh       |    4 +-
 match-trees.c      |  301 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 merge-recursive.c  |   29 +++++
 test-match-trees.c |   24 ++++
 7 files changed, 370 insertions(+), 3 deletions(-)
 create mode 100644 match-trees.c
 create mode 100644 test-match-trees.c

diff --git a/.gitignore b/.gitignore
index f15155d..8f732b4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -74,6 +74,7 @@ git-merge-ours
 git-merge-recursive
 git-merge-resolve
 git-merge-stupid
+git-merge-subtree
 git-mktag
 git-mktree
 git-name-rev
@@ -142,6 +143,7 @@ gitweb/gitweb.cgi
 test-date
 test-delta
 test-dump-cache-tree
+test-match-trees
 common-cmds.h
 *.tar.gz
 *.dsc
diff --git a/Makefile b/Makefile
index ebecbbd..e255a0d 100644
--- a/Makefile
+++ b/Makefile
@@ -221,6 +221,8 @@ BUILT_INS = \
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SCRIPTS)
 
+ALL_PROGRAMS += git-merge-subtree$X
+
 # Backward compatibility -- to be removed after 1.0
 PROGRAMS += git-ssh-pull$X git-ssh-push$X
 
@@ -260,7 +262,7 @@ LIB_OBJS = \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
 	revision.o pager.o tree-walk.o xdiff-interface.o \
-	write_or_die.o trace.o list-objects.o grep.o \
+	write_or_die.o trace.o list-objects.o grep.o match-trees.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o
 
@@ -627,6 +629,9 @@ git$X: git.c common-cmds.h $(BUILTIN_OBJS) $(GITLIBS) GIT-CFLAGS
 
 help.o: common-cmds.h
 
+git-merge-subtree$X: git-merge-recursive$X
+	rm -f $@ && ln git-merge-recursive$X $@
+
 $(BUILT_INS): git$X
 	rm -f $@ && ln git$X $@
 
@@ -827,6 +832,9 @@ test-dump-cache-tree$X: dump-cache-tree.o $(GITLIBS)
 test-sha1$X: test-sha1.o $(GITLIBS)
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
+test-match-trees$X: test-match-trees.o $(GITLIBS)
+	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
+
 check-sha1:: test-sha1$X
 	./test-sha1.sh
 
diff --git a/cache.h b/cache.h
index c62b0b0..d1e5035 100644
--- a/cache.h
+++ b/cache.h
@@ -468,4 +468,7 @@ extern int nfvasprintf(char **str, const char *fmt, va_list va);
 extern void trace_printf(const char *format, ...);
 extern void trace_argv_printf(const char **argv, int count, const char *format, ...);
 
+/* match-trees.c */
+void shift_tree(const unsigned char *, const unsigned char *, unsigned char *, int);
+
 #endif /* CACHE_H */
diff --git a/git-merge.sh b/git-merge.sh
index 498c938..f406795 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -16,10 +16,10 @@ test -z "$(git ls-files -u)" ||
 LF='
 '
 
-all_strategies='recur recursive octopus resolve stupid ours'
+all_strategies='recur recursive octopus resolve stupid ours subtree'
 default_twohead_strategies='recursive'
 default_octopus_strategies='octopus'
-no_trivial_merge_strategies='ours'
+no_trivial_merge_strategies='ours subtree'
 use_strategies=
 
 index_merge=t
diff --git a/match-trees.c b/match-trees.c
new file mode 100644
index 0000000..fe7813c
--- /dev/null
+++ b/match-trees.c
@@ -0,0 +1,301 @@
+#include "cache.h"
+#include "tree.h"
+#include "tree-walk.h"
+
+static int score_missing(unsigned mode, const char *path)
+{
+	int score;
+
+	if (S_ISDIR(mode))
+		score = -1000;
+	else if (S_ISLNK(mode))
+		score = -500;
+	else
+		score = -50;
+	return score;
+}
+
+static int score_differs(unsigned mode1, unsigned mode2, const char *path)
+{
+	int score;
+
+	if (S_ISDIR(mode1) != S_ISDIR(mode2))
+		score = -100;
+	else if (S_ISLNK(mode1) != S_ISLNK(mode2))
+		score = -50;
+	else
+		score = -5;
+	return score;
+}
+
+static int score_matches(unsigned mode1, unsigned mode2, const char *path)
+{
+	int score;
+
+	/* Heh, we found SHA-1 collisions between different kind of objects */
+	if (S_ISDIR(mode1) != S_ISDIR(mode2))
+		score = -100;
+	else if (S_ISLNK(mode1) != S_ISLNK(mode2))
+		score = -50;
+
+	else if (S_ISDIR(mode1))
+		score = 1000;
+	else if (S_ISLNK(mode1))
+		score = 500;
+	else
+		score = 250;
+	return score;
+}
+
+/*
+ * Inspect two trees, and give a score that tells how similar they are.
+ */
+static int score_trees(const unsigned char *hash1, const unsigned char *hash2)
+{
+	struct tree_desc one;
+	struct tree_desc two;
+	void *one_buf, *two_buf;
+	int score = 0;
+	char type[10];
+
+	one_buf = read_sha1_file(hash1, type, &one.size);
+	if (!one_buf)
+		die("unable to read tree (%s)", sha1_to_hex(hash1));
+	if (strcmp(type, tree_type))
+		die("%s is not a tree", sha1_to_hex(hash1));
+	two_buf = read_sha1_file(hash2, type, &two.size);
+	if (!two_buf)
+		die("unable to read tree (%s)", sha1_to_hex(hash2));
+	if (strcmp(type, tree_type))
+		die("%s is not a tree", sha1_to_hex(hash2));
+	one.buf = one_buf;
+	two.buf = two_buf;
+	while (one.size | two.size) {
+		const unsigned char *elem1 = elem1;
+		const unsigned char *elem2 = elem2;
+		const char *path1, *path2;
+		unsigned mode1, mode2;
+		int cmp;
+
+		if (one.size)
+			elem1 = tree_entry_extract(&one, &path1, &mode1);
+		if (two.size)
+			elem2 = tree_entry_extract(&two, &path2, &mode2);
+
+		if (!one.size) {
+			/* two has more entries */
+			score += score_missing(mode2, path2);
+			update_tree_entry(&two);
+			continue;
+		}
+		if (!two.size) {
+			/* two lacks this entry */
+			score += score_missing(mode1, path1);
+			update_tree_entry(&one);
+			continue;
+		}
+		cmp = base_name_compare(path1, strlen(path1), mode1,
+					path2, strlen(path2), mode2);
+		if (cmp < 0) {
+			/* path1 does not appear in two */
+			score += score_missing(mode1, path1);
+			update_tree_entry(&one);
+			continue;
+		}
+		else if (cmp > 0) {
+			/* path2 does not appear in one */
+			score += score_missing(mode2, path2);
+			update_tree_entry(&two);
+			continue;
+		}
+		else if (hashcmp(elem1, elem2))
+			/* they are different */
+			score += score_differs(mode1, mode2, path1);
+		else
+			/* same subtree or blob */
+			score += score_matches(mode1, mode2, path1);
+		update_tree_entry(&one);
+		update_tree_entry(&two);
+	}
+	free(one_buf);
+	free(two_buf);
+	return score;
+}
+
+/*
+ * Match one itself and its subtrees with two and pick the best match.
+ */
+static void match_trees(const unsigned char *hash1,
+			const unsigned char *hash2,
+			int *best_score,
+			char **best_match,
+			char *base,
+			int recurse_limit)
+{
+	struct tree_desc one;
+	void *one_buf;
+	char type[10];
+
+	one_buf = read_sha1_file(hash1, type, &one.size);
+	if (!one_buf)
+		die("unable to read tree (%s)", sha1_to_hex(hash1));
+	if (strcmp(type, tree_type))
+		die("%s is not a tree", sha1_to_hex(hash1));
+	one.buf = one_buf;
+
+	while (one.size) {
+		const char *path;
+		const unsigned char *elem;
+		unsigned mode;
+		int score;
+
+		elem = tree_entry_extract(&one, &path, &mode);
+		if (!S_ISDIR(mode))
+			goto next;
+		score = score_trees(elem, hash2);
+		if (*best_score < score) {
+			char *newpath;
+			newpath = xmalloc(strlen(base) + strlen(path) + 1);
+			sprintf(newpath, "%s%s", base, path);
+			free(*best_match);
+			*best_match = newpath;
+			*best_score = score;
+		}
+		if (recurse_limit) {
+			char *newbase;
+			newbase = xmalloc(strlen(base) + strlen(path) + 2);
+			sprintf(newbase, "%s%s/", base, path);
+			match_trees(elem, hash2, best_score, best_match,
+				    newbase, recurse_limit - 1);
+			free(newbase);
+		}
+
+	next:
+		update_tree_entry(&one);
+	}
+	free(one_buf);
+}
+
+/*
+ * A tree "hash1" has a subdirectory at "prefix".  Come up with a
+ * tree object by replacing it with another tree "hash2".
+ */
+static int splice_tree(const unsigned char *hash1,
+		       char *prefix,
+		       const unsigned char *hash2,
+		       unsigned char *result)
+{
+	char *subpath;
+	int toplen;
+	char *buf;
+	unsigned long sz;
+	struct tree_desc desc;
+	unsigned char *rewrite_here;
+	const unsigned char *rewrite_with;
+	unsigned char subtree[20];
+	char type[20];
+	int status;
+
+	subpath = strchr(prefix, '/');
+	if (!subpath)
+		toplen = strlen(prefix);
+	else {
+		toplen = subpath - prefix;
+		subpath++;
+	}
+
+	buf = read_sha1_file(hash1, type, &sz);
+	if (!buf)
+		die("cannot read tree %s", sha1_to_hex(hash1));
+	desc.buf = buf;
+	desc.size = sz;
+
+	rewrite_here = NULL;
+	while (desc.size) {
+		const char *name;
+		unsigned mode;
+		const unsigned char *sha1;
+
+		sha1 = tree_entry_extract(&desc, &name, &mode);
+		if (strlen(name) == toplen &&
+		    !memcmp(name, prefix, toplen)) {
+			if (!S_ISDIR(mode))
+				die("entry %s in tree %s is not a tree",
+				    name, sha1_to_hex(hash1));
+			rewrite_here = (unsigned char *) sha1;
+			break;
+		}
+		update_tree_entry(&desc);
+	}
+	if (!rewrite_here)
+		die("entry %.*s not found in tree %s",
+		    toplen, prefix, sha1_to_hex(hash1));
+	if (subpath) {
+		status = splice_tree(rewrite_here, subpath, hash2, subtree);
+		if (status)
+			return status;
+		rewrite_with = subtree;
+	}
+	else
+		rewrite_with = hash2;
+	hashcpy(rewrite_here, rewrite_with);
+	status = write_sha1_file(buf, sz, tree_type, result);
+	free(buf);
+	return status;
+}
+
+/*
+ * We are trying to come up with a merge between one and two that
+ * results in a tree shape similar to one.  The tree two might
+ * correspond to a subtree of one, in which case it needs to be
+ * shifted down by prefixing otherwise empty directories.  On the
+ * other hand, it could cover tree one and we might need to pick a
+ * subtree of it.
+ */
+void shift_tree(const unsigned char *hash1,
+		const unsigned char *hash2,
+		unsigned char *shifted,
+		int depth_limit)
+{
+	char *add_prefix;
+	char *del_prefix;
+	int add_score, del_score;
+
+	add_score = del_score = score_trees(hash1, hash2);
+	add_prefix = xcalloc(1, 1);
+	del_prefix = xcalloc(1, 1);
+
+	/*
+	 * See if one's subtree resembles two; if so we need to prefix
+	 * two with a few fake trees to match the prefix.
+	 */
+	match_trees(hash1, hash2, &add_score, &add_prefix, "", depth_limit);
+
+	/*
+	 * See if two's subtree resembles one; if so we need to
+	 * pick only subtree of two.
+	 */
+	match_trees(hash2, hash1, &del_score, &del_prefix, "", depth_limit);
+
+	/* Assume we do not have to do any shifting */
+	hashcpy(shifted, hash2);
+
+	if (add_score < del_score) {
+		/* We need to pick a subtree of two */
+		unsigned mode;
+
+		if (!*del_prefix)
+			return;
+
+		if (get_tree_entry(hash2, del_prefix, shifted, &mode))
+			die("cannot find path %s in tree %s",
+			    del_prefix, sha1_to_hex(hash2));
+		return;
+	}
+
+	if (!*add_prefix)
+		return;
+
+	splice_tree(hash1, add_prefix, hash2, shifted);
+}
+
diff --git a/merge-recursive.c b/merge-recursive.c
index 5898942..7b4e339 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -16,6 +16,22 @@
 #include "path-list.h"
 #include "xdiff-interface.h"
 
+static int subtree_merge;
+
+static struct tree *shift_tree_object(struct tree *one, struct tree *two)
+{
+	unsigned char shifted[20];
+
+	/*
+	 * NEEDSWORK: this limits the recursion depth to hardcoded
+	 * value '2' to avoid excessive overhead.
+	 */
+	shift_tree(one->object.sha1, two->object.sha1, shifted, 2);
+	if (!hashcmp(two->object.sha1, shifted))
+		return two;
+	return lookup_tree(shifted);
+}
+
 /*
  * A virtual commit has
  * - (const char *)commit->util set to the name, and
@@ -1111,6 +1127,12 @@ static int merge_trees(struct tree *head,
 		       struct tree **result)
 {
 	int code, clean;
+
+	if (subtree_merge) {
+		merge = shift_tree_object(head, merge);
+		common = shift_tree_object(head, common);
+	}
+
 	if (sha_eq(common->object.sha1, merge->object.sha1)) {
 		output(0, "Already uptodate!");
 		*result = head;
@@ -1316,6 +1338,13 @@ int main(int argc, char *argv[])
 	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 	int index_fd;
 
+	if (argv[0]) {
+		int namelen = strlen(argv[0]);
+		if (8 < namelen &&
+		    !strcmp(argv[0] + namelen - 8, "-subtree"))
+			subtree_merge = 1;
+	}
+
 	git_config(merge_config);
 	if (getenv("GIT_MERGE_VERBOSITY"))
 		verbosity = strtol(getenv("GIT_MERGE_VERBOSITY"), NULL, 10);
diff --git a/test-match-trees.c b/test-match-trees.c
new file mode 100644
index 0000000..a3c4688
--- /dev/null
+++ b/test-match-trees.c
@@ -0,0 +1,24 @@
+#include "cache.h"
+#include "tree.h"
+
+int main(int ac, char **av)
+{
+	unsigned char hash1[20], hash2[20], shifted[20];
+	struct tree *one, *two;
+
+	if (get_sha1(av[1], hash1))
+		die("cannot parse %s as an object name", av[1]);
+	if (get_sha1(av[2], hash2))
+		die("cannot parse %s as an object name", av[2]);
+	one = parse_tree_indirect(hash1);
+	if (!one)
+		die("not a treeish %s", av[1]);
+	two = parse_tree_indirect(hash2);
+	if (!two)
+		die("not a treeish %s", av[2]);
+
+	shift_tree(one->object.sha1, two->object.sha1, shifted, -1);
+	printf("shifted: %s\n", sha1_to_hex(shifted));
+
+	exit(0);
+}
-- 
1.5.0.552.ge1b1c
