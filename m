From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 5/5] reflog expire --fix-stale
Date: Sat, 06 Jan 2007 02:16:19 -0800
Message-ID: <7vodpc5uks.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jan 06 11:16:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H38bJ-0001Uy-Uw
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 11:16:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbXAFKQX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 05:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbXAFKQW
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 05:16:22 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:54967 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbXAFKQV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 05:16:21 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070106101620.JIGH97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Sat, 6 Jan 2007 05:16:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7mGb1W00N1kojtg0000000; Sat, 06 Jan 2007 05:16:36 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36082>

The logic in an earlier round to detect reflog entries that
point at a broken commit was not sufficient.  Just like we do
not trust presense of a commit during pack transfer (we trust
only our refs), we should not trust a commit's presense, even if
the tree of that commit is complete.

A repository that had reflog enabled on some of the refs that
was rewound and then run git-repack or git-prune from older
versions of git can have reflog entries that point at a commit
that still exist but lack commits (or trees and blobs needed for
that commit) between it and some commit that is reachable from
one of the refs.

This revamps the logic -- the definition of "broken commit"
becomes: a commit that is not reachable from any of the refs and
there is a missing object among the commit, tree, or blob
objects reachable from it that is not reachable from any of the
refs.  Entries in the reflog that refer to such a commit are
expired.

Since this computation involves traversing all the reachable
objects, i.e. it has the same cost as 'git prune', it is enabled
only when a new option --fix-stale.  Fortunately, once this is
run, we should not have to ever worry about missing objects,
because the current prune and pack-objects know about reflogs
and protect objects referred by them.

Unfortunately, this will be absolutely necessary to help people
migrate to the newer prune and repack.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-reflog.c  |  159 +++++++++++++++++++++++++++++++++++++++++++-------
 t/t1410-reflog.sh |  170 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 308 insertions(+), 21 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index d3f2f50..1da7da0 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -4,16 +4,34 @@
 #include "refs.h"
 #include "dir.h"
 #include "tree-walk.h"
+#include "diff.h"
+#include "revision.h"
+#include "reachable.h"
+
+/*
+ * reflog expire
+ */
+
+static const char reflog_expire_usage[] =
+"git-reflog expire [--verbose] [--dry-run] [--fix-stale] [--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...";
 
 static unsigned long default_reflog_expire;
 static unsigned long default_reflog_expire_unreachable;
 
+struct cmd_reflog_expire_cb {
+	struct rev_info revs;
+	int dry_run;
+	int stalefix;
+	int verbose;
+	unsigned long expire_total;
+	unsigned long expire_unreachable;
+};
+
 struct expire_reflog_cb {
 	FILE *newlog;
 	const char *ref;
 	struct commit *ref_commit;
-	unsigned long expire_total;
-	unsigned long expire_unreachable;
+	struct cmd_reflog_expire_cb *cmd;
 };
 
 static int tree_is_complete(const unsigned char *sha1)
@@ -43,6 +61,83 @@ static int tree_is_complete(const unsigned char *sha1)
 	return 1;
 }
 
+#define INCOMPLETE	(1u<<10)
+#define STUDYING	(1u<<11)
+
+static int commit_is_complete(struct commit *commit)
+{
+	struct object_array study;
+	struct object_array found;
+	int is_incomplete = 0;
+	int i;
+
+	/* early return */
+	if (commit->object.flags & SEEN)
+		return 1;
+	if (commit->object.flags & INCOMPLETE)
+		return 0;
+	/*
+	 * Find all commits that are reachable and are not marked as
+	 * SEEN.  Then make sure the trees and blobs contained are
+	 * complete.  After that, mark these commits also as SEEN.
+	 * If some of the objects that are needed to complete this
+	 * commit are missing, mark this commit as INCOMPLETE.
+	 */
+	memset(&study, 0, sizeof(study));
+	memset(&found, 0, sizeof(found));
+	add_object_array(&commit->object, NULL, &study);
+	add_object_array(&commit->object, NULL, &found);
+	commit->object.flags |= STUDYING;
+	while (study.nr) {
+		struct commit *c;
+		struct commit_list *parent;
+
+		c = (struct commit *)study.objects[--study.nr].item;
+		if (!c->object.parsed && !parse_object(c->object.sha1))
+			c->object.flags |= INCOMPLETE;
+
+		if (c->object.flags & INCOMPLETE) {
+			is_incomplete = 1;
+			break;
+		}
+		else if (c->object.flags & SEEN)
+			continue;
+		for (parent = c->parents; parent; parent = parent->next) {
+			struct commit *p = parent->item;
+			if (p->object.flags & STUDYING)
+				continue;
+			p->object.flags |= STUDYING;
+			add_object_array(&p->object, NULL, &study);
+			add_object_array(&p->object, NULL, &found);
+		}
+	}
+	if (!is_incomplete) {
+		/* make sure all commits in found have all the
+		 * necessary objects.
+		 */
+		for (i = 0; !is_incomplete && i < found.nr; i++) {
+			struct commit *c =
+				(struct commit *)found.objects[i].item;
+			if (!tree_is_complete(c->tree->object.sha1))
+				is_incomplete = 1;
+		}
+		if (!is_incomplete) {
+			/* mark all found commits as complete, iow SEEN */
+			for (i = 0; i < found.nr; i++)
+				found.objects[i].item->flags |= SEEN;
+		}
+	}
+	/* clear flags from the objects we traversed */
+	for (i = 0; i < found.nr; i++)
+		found.objects[i].item->flags &= ~STUDYING;
+	if (is_incomplete)
+		commit->object.flags |= INCOMPLETE;
+	/* free object arrays */
+	free(study.objects);
+	free(found.objects);
+	return !is_incomplete;
+}
+
 static int keep_entry(struct commit **it, unsigned char *sha1)
 {
 	struct commit *commit;
@@ -54,9 +149,15 @@ static int keep_entry(struct commit **it, unsigned char *sha1)
 	if (!commit)
 		return 0;
 
-	/* Make sure everything in this commit exists. */
-	parse_object(commit->object.sha1);
-	if (!tree_is_complete(commit->tree->object.sha1))
+	/*
+	 * Make sure everything in this commit exists.
+	 *
+	 * We have walked all the objects reachable from the refs
+	 * and cache earlier.  The commits reachable by this commit
+	 * must meet SEEN commits -- and then we should mark them as
+	 * SEEN as well.
+	 */
+	if (!commit_is_complete(commit))
 		return 0;
 	*it = commit;
 	return 1;
@@ -76,13 +177,14 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	timestamp = strtoul(cp, &ep, 10);
 	if (*ep != ' ')
 		goto prune;
-	if (timestamp < cb->expire_total)
+	if (timestamp < cb->cmd->expire_total)
 		goto prune;
 
-	if (!keep_entry(&old, osha1) || !keep_entry(&new, nsha1))
+	if (cb->cmd->stalefix &&
+	    (!keep_entry(&old, osha1) || !keep_entry(&new, nsha1)))
 		goto prune;
 
-	if ((timestamp < cb->expire_unreachable) &&
+	if ((timestamp < cb->cmd->expire_unreachable) &&
 	    (!cb->ref_commit ||
 	     (old && !in_merge_bases(old, cb->ref_commit)) ||
 	     (new && !in_merge_bases(new, cb->ref_commit))))
@@ -91,19 +193,15 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	if (cb->newlog)
 		fprintf(cb->newlog, "%s %s %s",
 			sha1_to_hex(osha1), sha1_to_hex(nsha1), data);
+	if (cb->cmd->verbose)
+		printf("keep %s", data);
 	return 0;
  prune:
-	if (!cb->newlog)
-		fprintf(stderr, "would prune %s", data);
+	if (!cb->newlog || cb->cmd->verbose)
+		printf("%sprune %s", cb->newlog ? "" : "would ", data);
 	return 0;
 }
 
-struct cmd_reflog_expire_cb {
-	int dry_run;
-	unsigned long expire_total;
-	unsigned long expire_unreachable;
-};
-
 static int expire_reflog(const char *ref, const unsigned char *sha1, int unused, void *cb_data)
 {
 	struct cmd_reflog_expire_cb *cmd = cb_data;
@@ -134,8 +232,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 		fprintf(stderr,
 			"warning: ref '%s' does not point at a commit\n", ref);
 	cb.ref = ref;
-	cb.expire_total = cmd->expire_total;
-	cb.expire_unreachable = cmd->expire_unreachable;
+	cb.cmd = cmd;
 	for_each_reflog_ent(ref, expire_reflog_ent, &cb);
  finish:
 	if (cb.newlog) {
@@ -164,9 +261,6 @@ static int reflog_expire_config(const char *var, const char *value)
 	return 0;
 }
 
-static const char reflog_expire_usage[] =
-"git-reflog expire [--dry-run] [--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...";
-
 static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 {
 	struct cmd_reflog_expire_cb cb;
@@ -186,6 +280,12 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	cb.expire_total = default_reflog_expire;
 	cb.expire_unreachable = default_reflog_expire_unreachable;
 
+	/*
+	 * We can trust the commits and objects reachable from refs
+	 * even in older repository.  We cannot trust what's reachable
+	 * from reflog if the repository was pruned with older git.
+	 */
+
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
@@ -194,8 +294,12 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 			cb.expire_total = approxidate(arg + 9);
 		else if (!strncmp(arg, "--expire-unreachable=", 21))
 			cb.expire_unreachable = approxidate(arg + 21);
+		else if (!strcmp(arg, "--stale-fix"))
+			cb.stalefix = 1;
 		else if (!strcmp(arg, "--all"))
 			do_all = 1;
+		else if (!strcmp(arg, "--verbose"))
+			cb.verbose = 1;
 		else if (!strcmp(arg, "--")) {
 			i++;
 			break;
@@ -205,6 +309,15 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		else
 			break;
 	}
+	if (cb.stalefix) {
+		init_revisions(&cb.revs, prefix);
+		if (cb.verbose)
+			printf("Marking reachable objects...");
+		mark_reachable_objects(&cb.revs, 0);
+		if (cb.verbose)
+			putchar('\n');
+	}
+
 	if (do_all)
 		status |= for_each_ref(expire_reflog, &cb);
 	while (i < argc) {
@@ -219,6 +332,10 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	return status;
 }
 
+/*
+ * main "reflog"
+ */
+
 static const char reflog_usage[] =
 "git-reflog (expire | ...)";
 
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
new file mode 100755
index 0000000..60d2f91
--- /dev/null
+++ b/t/t1410-reflog.sh
@@ -0,0 +1,170 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Junio C Hamano
+#
+
+test_description='Test prune and reflog expiration'
+. ./test-lib.sh
+
+check_have () {
+	gaah= &&
+	for N in "$@"
+	do
+		eval "o=\$$N" && git cat-file -t $o || {
+			echo Gaah $N
+			gaah=$N
+			break
+		}
+	done &&
+	test -z "$gaah"
+}
+
+check_fsck () {
+	output=$(git fsck-objects --full)
+	case "$1" in
+	'')
+		test -z "$output" ;;
+	*)
+		echo "$output" | grep "$1" ;;
+	esac
+}
+
+corrupt () {
+	aa=${1%??????????????????????????????????????} zz=${1#??}
+	mv .git/objects/$aa/$zz .git/$aa$zz
+}
+
+recover () {
+	aa=${1%??????????????????????????????????????} zz=${1#??}
+	mkdir -p .git/objects/$aa
+	mv .git/$aa$zz .git/objects/$aa/$zz
+}
+
+check_dont_have () {
+	gaah= &&
+	for N in "$@"
+	do
+		eval "o=\$$N"
+		git cat-file -t $o && {
+			echo Gaah $N
+			gaah=$N
+			break
+		}
+	done
+	test -z "$gaah"
+}
+
+test_expect_success setup '
+	mkdir -p A/B &&
+	echo rat >C &&
+	echo ox >A/D &&
+	echo tiger >A/B/E &&
+	git add . &&
+
+	test_tick && git commit -m rabbit &&
+	H=`git rev-parse --verify HEAD` &&
+	A=`git rev-parse --verify HEAD:A` &&
+	B=`git rev-parse --verify HEAD:A/B` &&
+	C=`git rev-parse --verify HEAD:C` &&
+	D=`git rev-parse --verify HEAD:A/D` &&
+	E=`git rev-parse --verify HEAD:A/B/E` &&
+	check_fsck &&
+
+	rm -f C A/B/E &&
+	echo dragon >F &&
+	echo snake >A/G &&
+	git add F A/G &&
+	test_tick && git commit -a -m horse &&
+	F=`git rev-parse --verify HEAD:F` &&
+	G=`git rev-parse --verify HEAD:A/G` &&
+	I=`git rev-parse --verify HEAD:A` &&
+	J=`git rev-parse --verify HEAD` &&
+	check_fsck &&
+
+	rm -f A/G &&
+	test_tick && git commit -a -m sheep &&
+	K=`git rev-parse --verify HEAD` &&
+	check_fsck &&
+
+	check_have A B C D E F G H I J K &&
+
+	git prune &&
+
+	check_have A B C D E F G H I J K &&
+
+	check_fsck &&
+
+	loglen=$(wc -l <.git/logs/refs/heads/master) &&
+	test $loglen = 3
+'
+
+test_expect_success rewind '
+	test_tick && git reset --hard HEAD~2 &&
+	test -f C &&
+	test -f A/B/E &&
+	! test -f F &&
+	! test -f A/G &&
+
+	check_have A B C D E F G H I J K &&
+
+	git prune &&
+
+	check_have A B C D E F G H I J K &&
+
+	loglen=$(wc -l <.git/logs/refs/heads/master) &&
+	test $loglen = 4
+'
+
+test_expect_success 'corrupt and check' '
+
+	corrupt $F &&
+	check_fsck "missing blob $F"
+
+'
+
+test_expect_success 'reflog expire --dry-run should not touch reflog' '
+
+	git reflog expire --dry-run \
+		--expire=$(($test_tick - 10000)) \
+		--expire-unreachable=$(($test_tick - 10000)) \
+		--stale-fix \
+		--all &&
+
+	loglen=$(wc -l <.git/logs/refs/heads/master) &&
+	test $loglen = 4 &&
+
+	check_fsck "missing blob $F"
+'
+
+test_expect_success 'reflog expire' '
+
+	git reflog expire --verbose \
+		--expire=$(($test_tick - 10000)) \
+		--expire-unreachable=$(($test_tick - 10000)) \
+		--stale-fix \
+		--all &&
+
+	loglen=$(wc -l <.git/logs/refs/heads/master) &&
+	test $loglen = 1 &&
+
+	check_fsck "dangling commit $K"
+'
+
+test_expect_success 'prune and fsck' '
+
+	git prune &&
+	check_fsck &&
+
+	check_have A B C D E H &&
+	check_dont_have F G I J K
+
+'
+
+test_expect_success 'recover and check' '
+
+	recover $F &&
+	check_fsck "dangling blob $F"
+
+'
+
+test_done
-- 
1.5.0.rc0.ge0f6
