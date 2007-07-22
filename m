From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Sun, 22 Jul 2007 19:56:31 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707221956210.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jul 22 20:57:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICgcB-0006Ah-BW
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 20:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761524AbXGVS4s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 14:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760298AbXGVS4q
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 14:56:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:54852 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760276AbXGVS4p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 14:56:45 -0400
Received: (qmail invoked by alias); 22 Jul 2007 18:56:42 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 22 Jul 2007 20:56:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18qfL1P0RIqBGV1Hj1jr13yie+BIFXgNuiz+69s8p
	3rYVd5aLUUAvqV
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53292>


Inspired by contrib/workdir/git-new-workdir, the flag --new-workdir (or
its shortcut, -n) can be used to create a new working directory for the
newly created branch.  All information, except which branch is checked
out (and therefore also the index), will be symlinked from the current
repository.

Example:

	$ git branch -n ~/my-new-topic xy-problem

will create a branch called "xy-problem", which is initially identical
to the current branch, and check out the new branch in ~/my-new-topic/.
You will be able to cherry-pick from, log and diff with the branch
"xy-problem" in the current repository, since most of the metadata is
shared.

Conversely, you can access all the branches in the current repository
from ~/my-new-topic/, too.

A word of warning: switching to _same_ branch that is checked out in
the other repository is asking for trouble.  You are really working not
only on the same object database, but also the same (i.e. not copied)
refs namespace.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
	IMHO this is a better syntax than what is in contrib/, and "git
	branch" is probably the right place for such a thing, from a
	user's perspective.

 Documentation/git-branch.txt |    7 +++-
 builtin-branch.c             |   79 +++++++++++++++++++++++++++++++++++++++--
 t/t3200-branch.sh            |   11 ++++++
 3 files changed, 92 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index bc6aa88..a05c795 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 [verse]
 'git-branch' [--color | --no-color] [-r | -a]
 	   [-v [--abbrev=<length> | --no-abbrev]]
-'git-branch' [--track | --no-track] [-l] [-f] <branchname> [<start-point>]
+'git-branch' [--track | --no-track] [-l] [-f] <branchname>
+	   [-n <dir> | --new-workdir <dir>] [<start-point>]
 'git-branch' (-m | -M) [<oldbranch>] <newbranch>
 'git-branch' (-d | -D) [-r] <branchname>...
 
@@ -91,6 +92,10 @@ OPTIONS
 --no-abbrev::
 	Display the full sha1s in output listing rather than abbreviating them.
 
+-n\|--new-workdir <dir>::
+	Set up a new working directory which shares all information with the
+	current repository, except which branch is checked out.
+
 <branchname>::
 	The name of the branch to create or delete.
 	The new branch name must pass all checks defined by
diff --git a/builtin-branch.c b/builtin-branch.c
index 5f5c182..cba5fac 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -11,9 +11,10 @@
 #include "commit.h"
 #include "builtin.h"
 #include "remote.h"
+#include "unpack-trees.h"
 
 static const char builtin_branch_usage[] =
-  "git-branch [-r] (-d | -D) <branchname> | [--track | --no-track] [-l] [-f] <branchname> [<start-point>] | (-m | -M) [<oldbranch>] <newbranch> | [--color | --no-color] [-r | -a] [-v [--abbrev=<length> | --no-abbrev]]";
+  "git-branch [-r] (-d | -D) <branchname> | [--track | --no-track] [-l] [-f] [-n <dir> | --new-workdir <dir>] <branchname> [<start-point>] | (-m | -M) [<oldbranch>] <newbranch> | [--color | --no-color] [-r | -a] [-v [--abbrev=<length> | --no-abbrev]]";
 
 #define REF_UNKNOWN_TYPE    0x00
 #define REF_LOCAL_BRANCH    0x01
@@ -500,6 +501,67 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 		die("Branch is renamed, but update of config-file failed");
 }
 
+static struct lock_file lockfile;
+
+/* This function free()s path */
+static int create_new_workdir(char *path, const char *branch_name)
+{
+	static const char *links[] = {
+		"config", "refs", "logs/refs", "objects", "info", "hooks",
+		"packed-refs", "remotes", "rr-cache", NULL
+	};
+	const char *git_dir = get_git_dir(), *absolute;
+	struct stat st;
+	unsigned char sha1[20];
+	char *ref;
+	struct object *object;
+	struct unpack_trees_options opts;
+	struct object_list trees;
+	int i, fd;
+
+	if (!has_symlinks)
+		return error("New workdir not possible without symlinks");
+	/* make sure that GIT_DIR is an absolute path */
+	if ((absolute = make_absolute_path(git_dir)) != git_dir &&
+			setup_new_git_dir(absolute))
+		return 1;
+	if (!lstat(git_path("config"), &st) && S_ISLNK(st.st_mode))
+		return error("Will not create a workdir from a workdir");
+	if (safe_create_leading_directories(path) ||
+			mkdir(path, 0777) || chdir(path))
+		return error("Could not create '%s'", path);
+	if (mkdir(DEFAULT_GIT_DIR_ENVIRONMENT, 0777) ||
+			chdir(DEFAULT_GIT_DIR_ENVIRONMENT) ||
+			mkdir("logs", 0777))
+		return error("Could not set up '%s/%s'",
+				path, DEFAULT_GIT_DIR_ENVIRONMENT);
+	for (i = 0; links[i]; i++)
+		if (symlink(git_path(links[i]), links[i]))
+			return error("Could not link '%s'", links[i]);
+	if (chdir("..") || setup_new_git_dir(DEFAULT_GIT_DIR_ENVIRONMENT))
+		return error("Error setting up new workdir");
+	fd = hold_locked_index(&lockfile, 1);
+	if (fd < 0)
+		return error("Could not lock index");
+	if (dwim_ref(branch_name, strlen(branch_name), sha1, &ref) != 1 ||
+			create_symref("HEAD", ref, "new workdir") ||
+			!(object = parse_object(sha1)) ||
+			object->type != OBJ_COMMIT)
+		return error("Could not checkout HEAD");
+	free(ref);
+	trees.item = &((struct commit *)object)->tree->object;
+	trees.next = NULL;
+
+	memset(&opts, 0, sizeof(opts));
+	opts.update = 1;
+	opts.merge = 1;
+	opts.head_idx = 1;
+	opts.fn = oneway_merge;
+	return unpack_trees(&trees, &opts) ||
+		write_cache(fd, active_cache, active_nr) ||
+		close(fd) || commit_locked_index(&lockfile);
+}
+
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, force_delete = 0, force_create = 0;
@@ -507,6 +569,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	int verbose = 0, abbrev = DEFAULT_ABBREV, detached = 0;
 	int reflog = 0, track;
 	int kinds = REF_LOCAL_BRANCH;
+	char *new_workdir = NULL;
 	int i;
 
 	git_config(git_branch_config);
@@ -587,11 +650,17 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			branch_use_color = 0;
 			continue;
 		}
+		if (!strcmp(arg, "--new-workdir") || !strcmp(arg, "-n")) {
+			if (++i >= argc)
+				usage(builtin_branch_usage);
+			new_workdir = xstrdup(argv[i]);
+			continue;
+		}
 		usage(builtin_branch_usage);
 	}
 
 	if ((delete && rename) || (delete && force_create) ||
-	    (rename && force_create))
+	    (rename && force_create) || (new_workdir && (delete || rename)))
 		usage(builtin_branch_usage);
 
 	head = resolve_ref("HEAD", head_sha1, 0, NULL);
@@ -615,10 +684,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		rename_branch(head, argv[i], force_rename);
 	else if (rename && (i == argc - 2))
 		rename_branch(argv[i], argv[i + 1], force_rename);
-	else if (i == argc - 1 || i == argc - 2)
+	else if (i == argc - 1 || i == argc - 2) {
 		create_branch(argv[i], (i == argc - 2) ? argv[i+1] : head,
 			      force_create, reflog, track);
-	else
+		if (new_workdir)
+			return create_new_workdir(new_workdir, argv[i]);
+	} else
 		usage(builtin_branch_usage);
 
 	return 0;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index ef1eeb7..d9ec82a 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -202,4 +202,15 @@ test_expect_success \
 	 test -f .git/logs/refs/heads/g/h/i &&
 	 diff expect .git/logs/refs/heads/g/h/i'
 
+test_expect_success 'create new workdir' '
+	git branch -n new-workdir forked &&
+	test -d new-workdir &&
+	(cd new-workdir &&
+	 test $HEAD = $(git rev-parse HEAD) &&
+	 test refs/heads/forked = $(git symbolic-ref HEAD) &&
+	 git fsck &&
+	 git diff-files --quiet &&
+	 git diff-index --quiet --cached HEAD)
+'
+
 test_done
-- 
1.5.3.rc2.29.gc4640f
