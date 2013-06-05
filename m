From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] upload-archive: restrict remote objects with
 reachability check
Date: Wed, 5 Jun 2013 18:39:45 -0400
Message-ID: <20130605223945.GB15607@sigill.intra.peff.net>
References: <20130605223551.GF8664@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ian Harvey <iharvey@good.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 00:39:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkMMz-0006GQ-OW
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 00:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758054Ab3FEWjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 18:39:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:54341 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758036Ab3FEWjs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 18:39:48 -0400
Received: (qmail 16995 invoked by uid 102); 5 Jun 2013 22:40:34 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Jun 2013 17:40:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jun 2013 18:39:45 -0400
Content-Disposition: inline
In-Reply-To: <20130605223551.GF8664@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226473>

When serving a remote request, git-upload-archive tries to
restrict access to unreachable objects, which matches the
behavior of upload-pack. However, we did so by restricting
the requested tree to "<ref>[:<path>]", because it is fast.
That covers the common cases, but does not allow requesting
items by a specific sha1 (either a tree or a commit sha1).

Instead, let's do the correct-but-slower method of actually
walking back from the tips to see if the requested object is
reachable. The performance impact of this is roughly:

  1. For a recent commit, the speed is about the same (we
     traverse in reverse chronological order, so we see it
     almost immediately).

  2. For an older commit, even one pointed at directly by a
     ref (e.g., an old tag), we are slower, because we
     traverse from the more recent tips. We are bounded in
     this case by the time to look at all commits (i.e.,
     "time git rev-list --all").

  3. When we see "$ref:$path", we typically perform much
     worse, because our traversal looks at all commits
     first, followed by all trees.

  4. The worst case (which we hit for an unreachable object)
     is equivalent to "time rev-list --objects --all", which
     is about the same amount of time pack-objects spends
     preparing a full clone (which can be in the tens of
     seconds for a large repository).

The implementation is a fairly straightforward application
of the traverse_commit_list function. Using the
mark_objects_reachable function would seem more appropriate,
but it has no mechanism for looking for a specific object,
which lets us end the traversal early in common cases.

Signed-off-by: Jeff King <peff@peff.net>
---
The slowdown from points (2) and (3) makes me hesitate on this. We can
address (2) by checking if the get_sha1 lookup used a refname
explicitly, but I'm no sure about (3).

 archive.c                     | 70 +++++++++++++++++++++++++++------
 t/t5005-archive-resolution.sh | 91 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 150 insertions(+), 11 deletions(-)
 create mode 100755 t/t5005-archive-resolution.sh

diff --git a/archive.c b/archive.c
index d254fa5..4d77624 100644
--- a/archive.c
+++ b/archive.c
@@ -5,6 +5,9 @@
 #include "archive.h"
 #include "parse-options.h"
 #include "unpack-trees.h"
+#include "diff.h"
+#include "revision.h"
+#include "list-objects.h"
 
 static char const * const archive_usage[] = {
 	N_("git archive [options] <tree-ish> [<path>...]"),
@@ -241,6 +244,59 @@ static void parse_pathspec_arg(const char **pathspec,
 	}
 }
 
+struct reachable_object_data {
+	struct rev_info revs;
+	struct object *obj;
+};
+
+static void check_object(struct object *obj, const struct name_path *path,
+			 const char *name, void *vdata)
+{
+	struct reachable_object_data *data = vdata;
+	/*
+	 * We found it; the caller will take care of marking it SEEN,
+	 * but we can end the traversal early.
+	 */
+	if (obj == data->obj) {
+		free_commit_list(data->revs.commits);
+		data->revs.commits = NULL;
+
+		free(data->revs.pending.objects);
+		data->revs.pending.nr = 0;
+		data->revs.pending.alloc = 0;
+		data->revs.pending.objects = NULL;
+	}
+}
+
+static void check_commit(struct commit *commit, void *vdata)
+{
+	check_object(&commit->object, NULL, NULL, vdata);
+}
+
+static int object_is_reachable(const unsigned char *sha1)
+{
+	static const char *argv[] = {
+		"rev-list",
+		"--objects",
+		"--all",
+		NULL
+	};
+	struct reachable_object_data data;
+
+	data.obj = parse_object(sha1);
+	if (!data.obj)
+		return 0;
+
+	save_commit_buffer = 0;
+	init_revisions(&data.revs, NULL);
+	setup_revisions(ARRAY_SIZE(argv) - 1, argv, &data.revs, NULL);
+	if (prepare_revision_walk(&data.revs))
+		return 0;
+
+	traverse_commit_list(&data.revs, check_commit, check_object, &data);
+	return data.obj->flags & SEEN;
+}
+
 static void parse_treeish_arg(const char **argv,
 		struct archiver_args *ar_args, const char *prefix,
 		int remote)
@@ -252,20 +308,12 @@ static void parse_treeish_arg(const char **argv,
 	const struct commit *commit;
 	unsigned char sha1[20];
 
-	/* Remotes are only allowed to fetch actual refs */
-	if (remote) {
-		char *ref = NULL;
-		const char *colon = strchr(name, ':');
-		int refnamelen = colon ? colon - name : strlen(name);
-
-		if (!dwim_ref(name, refnamelen, sha1, &ref))
-			die("no such ref: %.*s", refnamelen, name);
-		free(ref);
-	}
-
 	if (get_sha1(name, sha1))
 		die("Not a valid object name");
 
+	if (remote && !object_is_reachable(sha1))
+		die("Not a valid object name");
+
 	commit = lookup_commit_reference_gently(sha1, 1);
 	if (commit) {
 		commit_sha1 = commit->object.sha1;
diff --git a/t/t5005-archive-resolution.sh b/t/t5005-archive-resolution.sh
new file mode 100755
index 0000000..2e7ee1e
--- /dev/null
+++ b/t/t5005-archive-resolution.sh
@@ -0,0 +1,91 @@
+#!/bin/sh
+
+test_description='test object resolution methods for local and remote archive'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo one >one && git add one && git commit -m one &&
+	sha1_referenced=`git rev-parse HEAD` &&
+	git tag tagged &&
+	echo two >two && git add two && git commit -m two &&
+	sha1_unreferenced=`git rev-parse HEAD` &&
+	git reset --hard HEAD^ &&
+	echo three >three && git add three && git commit -m three &&
+	git tag tagged-tree HEAD^{tree} &&
+	git reset --hard HEAD^ &&
+	mkdir subdir &&
+	echo four >subdir/four && git add subdir && git commit -m four &&
+	sha1_subtree=`git rev-parse HEAD:subdir`
+'
+
+# check that archiving $what from $where produces expected paths
+check() {
+	desc=$1; shift; # human-readable description
+	where=$1; shift; # local|remote
+	what=$1; shift; # the commit/tree id
+	expect="$*"; # expected paths or "deny"
+
+	cmd="git archive --format=tar -o result.tar"
+	test "$where" = "remote" && cmd="$cmd --remote=."
+	cmd="$cmd $what"
+
+	if test "$expect" = "deny"; then
+		test_expect_success "archive $desc ($where, should deny)" "
+			test_must_fail $cmd
+		"
+	else
+		test_expect_success "archive $desc ($where, should work)" '
+			'"$cmd"' &&
+			for i in '"$expect"'; do
+				echo "$i:`basename $i`"
+			done >expect &&
+			rm -rf result &&
+			mkdir result &&
+			(cd result &&
+			tar xf ../result.tar &&
+			for i in `find * -type f -print`; do
+				echo "$i:`cat $i`"
+			done >../actual
+			) &&
+			test_cmp expect actual
+		'
+	fi
+}
+
+check 'ref'  local master one subdir/four
+check 'ref' remote master one subdir/four
+
+check 'relative ref'  local master^ one
+check 'relative ref' remote master^ one
+
+check 'reachable sha1'  local $sha1_referenced one
+check 'reachable sha1' remote $sha1_referenced one
+
+check 'unreachable sha1'  local $sha1_unreferenced one two
+check 'unreachable sha1' remote $sha1_unreferenced deny
+
+check 'reachable reflog'  local master@{0} one subdir/four
+check 'reachable reflog' remote master@{0} one subdir/four
+
+check 'unreachable reflog'  local master@{4} one two
+check 'unreachable reflog' remote master@{4} deny
+
+check 'tree via ref^{tree}'  local master^{tree} one subdir/four
+check 'tree via ref^{tree}' remote master^{tree} one subdir/four
+
+check 'tree via ref:'  local master: one subdir/four
+check 'tree via ref:' remote master: one subdir/four
+
+check 'subtree via ref:sub'  local master:subdir four
+check 'subtree via ref:sub' remote master:subdir four
+
+check 'subtree via sha1'  local $sha1_subtree four
+check 'subtree via sha1' remote $sha1_subtree four
+
+check 'tagged commit'  local tagged one
+check 'tagged commit' remote tagged one
+
+check 'tagged tree'  local tagged-tree one three
+check 'tagged tree' remote tagged-tree one three
+
+test_done
-- 
1.8.3.rc2.14.g7eee6b3
