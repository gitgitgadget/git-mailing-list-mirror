From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 1/3] git-branch: add --track and --no-track options
Date: Mon, 05 Mar 2007 09:57:26 +0100
Message-ID: <esgm1m$33f$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 09:58:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO915-00074U-55
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 09:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbXCEI54 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 03:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752721AbXCEI5z
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 03:57:55 -0500
Received: from main.gmane.org ([80.91.229.2]:49095 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752173AbXCEI5y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 03:57:54 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HO90m-0006aT-G0
	for git@vger.kernel.org; Mon, 05 Mar 2007 09:57:40 +0100
Received: from usilu-ge.ti-edu.ch ([195.176.176.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Mar 2007 09:57:40 +0100
Received: from bonzini by usilu-ge.ti-edu.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Mar 2007 09:57:40 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: usilu-ge.ti-edu.ch
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41427>

In order to track and build on top of a branch 'topic' you track from
your upstream repository, you often would end up doing this sequence:

  git checkout -b mytopic origin/topic
  git config --add branch.mytopic.remote origin
  git config --add branch.mytopic.merge refs/heads/topic

This would first fork your own 'mytopic' branch from the 'topic'
branch you track from the 'origin' repository; then it would set up two
configuration variables so that 'git pull' without parameters does the
right thing while you are on your own 'mytopic' branch.

This commit adds a --track option to git-branch, so that "git
branch --track topic origin/topic" performs the latter two actions
when creating your 'topic' branch.  By setting configuration variable
'remote.REMOTENAME.trackintolocalbranches' to true, you do not have to
pass the --track option explicitly (the configuration variable is off
by default, and there is a --no-track option to countermand it even if
the variable is set).

Signed-off-by: Paolo Bonzini  <bonzini@gnu.org>
---
 Documentation/git-branch.txt |    9 ++-
 builtin-branch.c             |  126 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 127 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 3ea3b80..bd65b98 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git-branch' [--color | --no-color] [-r | -a]
 	   [-v [--abbrev=<length> | --no-abbrev]]
-'git-branch' [-l] [-f] <branchname> [<start-point>]
+'git-branch' [--track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git-branch' (-m | -M) [<oldbranch>] <newbranch>
 'git-branch' (-d | -D) [-r] <branchname>...
 
@@ -26,6 +26,13 @@ It will start out with a head equal to the one given as <start-point>.
 If no <start-point> is given, the branch will be created with a head
 equal to that of the currently checked out branch.
 
+When a local branch is started off a remote branch, git can setup the
+branch so that gitlink:git-pull[1] will appropriately merge from that
+remote branch.  If this behavior is desired, it is possible to make it
+the default using the `trackintolocalbranches` option of the
+corresponding remote.  Otherwise, it can be chosen per-branch using
+the `--track` and `--no-track` options.
+
 With a '-m' or '-M' option, <oldbranch> will be renamed to <newbranch>.
 If <oldbranch> had a corresponding reflog, it is renamed to match
 <newbranch>, and a reflog entry is created to remember the branch
diff --git a/builtin-branch.c b/builtin-branch.c
index d371849..f39759b 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -12,7 +12,7 @@
 #include "builtin.h"
 
 static const char builtin_branch_usage[] =
-  "git-branch [-r] (-d | -D) <branchname> | [-l] [-f] <branchname> [<start-point>] | (-m | -M) [<oldbranch>] <newbranch> | [--color | --no-color] [-r | -a] [-v [--abbrev=<length> | --no-abbrev]]";
+  "git-branch [-r] (-d | -D) <branchname> | [--track | --no-track] [-l] [-f] <branchname> [<start-point>] | (-m | -M) [<oldbranch>] <newbranch> | [--color | --no-color] [-r | -a] [-v [--abbrev=<length> | --no-abbrev]]";
 
 #define REF_UNKNOWN_TYPE    0x00
 #define REF_LOCAL_BRANCH    0x01
@@ -308,14 +308,105 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev)
 	free_ref_list(&ref_list);
 }
 
+
+static int config_track;
+static char *config_repo;
+static const char *start_ref;
+static int start_len;
+static int remote_len;
+
+static void get_remote_branch_name(const char* value)
+{
+	int len_first = -1, len_second = -1;
+	if (*value == '+')
+		value++;
+
+	/* Try an exact match first.  */
+	sscanf(value, "refs/%*[^:]:%n", &len_first);
+	if (len_first != -1
+	    && !strcmp(value + len_first, start_ref)) {
+		/* Truncate the value before the colon.  */
+		asprintf(&config_repo, "%.*s", len_first - 1, value);
+		return;
+	}
+
+	/* Try with a wildcard match now.  */
+	sscanf(value, "refs/%*[^/]/*:%nrefs/remotes/%*[^/]/*%n",
+	       &len_first, &len_second);
+	if (len_first != -1 && len_second != -1
+	    && (len_second - 2) - len_first == remote_len + 13
+	    && !strncmp(value + len_first, start_ref, remote_len + 13)) {
+		/* Replace the star with the remote branch name.  */
+		asprintf(&config_repo, "%.*s%s",
+			 len_first - 3, value,
+			 start_ref + remote_len + 13);
+	}
+}
+
+static int get_remote_config(const char* key, const char* value)
+{
+        if (!prefixcmp(key, "remote.") &&
+            !strncmp(key + 7, start_ref + 13, remote_len)) {
+		if (config_track == -1
+		    && !strcmp(key + 7 + remote_len, ".trackintolocalbranches"))
+			config_track = git_config_bool(key, value);
+
+		else if (!strcmp(key + 7 + remote_len, ".fetch"))
+			get_remote_branch_name(value);
+        }
+        return 0;
+}
+
+static void register_pull(const char *name, const char *real_ref, int track)
+{
+	char key[1024], value[1024];
+	const char *remote_name = real_ref + 13;
+	const char *slash = strchr(remote_name, '/');
+
+	if (!slash)
+		return;
+
+	start_ref = real_ref;
+	start_len = strlen(real_ref);
+	remote_len = slash - remote_name;
+	config_track = track;
+	git_config(get_remote_config);
+
+	/* Change to != 0 to enable this feature by default.  */
+	if (config_track == 1 && config_repo) {
+		if (snprintf(key, sizeof(key), "branch.%s.remote", name)
+		    > sizeof(key)) {
+			die("what a long branch name you have!");
+			goto out;
+		}
+		if (snprintf(value, sizeof(value), "%.*s", remote_len, remote_name)
+		    > sizeof(value)) {
+			die("what a long branch name you have!");
+			goto out;
+		}
+
+		git_config_set(key, value);
+
+		snprintf(key, sizeof(key), "branch.%s.merge", name);
+		git_config_set(key, config_repo);
+
+		printf("Branch %s set up to track remote branch %s.\n",
+		       name, real_ref);
+	}
+
+ out:
+	if (config_repo)
+		free(config_repo);
+}
+
 static void create_branch(const char *name, const char *start_name,
 			  unsigned char *start_sha1,
-			  int force, int reflog)
+			  int force, int reflog, int track)
 {
 	struct ref_lock *lock;
 	struct commit *commit;
 	unsigned char sha1[20];
-	char ref[PATH_MAX], msg[PATH_MAX + 20];
+	char *real_ref = NULL, ref[PATH_MAX], msg[PATH_MAX + 20];
 	int forcing = 0;
 
 	snprintf(ref, sizeof ref, "refs/heads/%s", name);
@@ -333,7 +424,9 @@ static void create_branch(const char *name, const char *start_name,
 	if (start_sha1)
 		/* detached HEAD */
 		hashcpy(sha1, start_sha1);
-	else if (get_sha1(start_name, sha1))
+	else if (dwim_ref(start_name, strlen(start_name), sha1, &real_ref) > 1)
+		die("Ambiguous object name: '%s'.", start_name);
+	else if (real_ref == NULL)
 		die("Not a valid object name: '%s'.", start_name);
 
 	if ((commit = lookup_commit_reference(sha1)) == NULL)
@@ -354,8 +447,17 @@ static void create_branch(const char *name, const char *start_name,
 		snprintf(msg, sizeof msg, "branch: Created from %s",
 			 start_name);
 
+	/* When branching off a remote branch, set up so that git-pull
+	   automatically merges from there.  So far, this is only done for
+	   branches registered using git-remote.  */
+	if (!prefixcmp(real_ref, "refs/remotes/"))
+		register_pull(name, real_ref, track);
+
 	if (write_ref_sha1(lock, sha1, msg) < 0)
 		die("Failed to write ref: %s.", strerror(errno));
+
+	if (real_ref)
+		free(real_ref);
 }
 
 static void rename_branch(const char *oldname, const char *newname, int force)
@@ -397,7 +499,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	int delete = 0, force_delete = 0, force_create = 0;
 	int rename = 0, force_rename = 0;
 	int verbose = 0, abbrev = DEFAULT_ABBREV, detached = 0;
-	int reflog = 0;
+	int reflog = 0, track = -1;
 	int kinds = REF_LOCAL_BRANCH;
 	int i;
 
@@ -412,6 +514,14 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			i++;
 			break;
 		}
+		if (!strcmp(arg, "--track")) {
+			track = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--no-track")) {
+			track = 0;
+			continue;
+		}
 		if (!strcmp(arg, "-d")) {
 			delete = 1;
 			continue;
@@ -498,9 +608,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	else if (rename && (i == argc - 2))
 		rename_branch(argv[i], argv[i + 1], force_rename);
 	else if (i == argc - 1)
-		create_branch(argv[i], head, head_sha1, force_create, reflog);
+		create_branch(argv[i], head, head_sha1, force_create, reflog,
+			      track);
 	else if (i == argc - 2)
-		create_branch(argv[i], argv[i+1], NULL, force_create, reflog);
+		create_branch(argv[i], argv[i+1], NULL, force_create, reflog,
+			      track);
 	else
 		usage(builtin_branch_usage);
 
