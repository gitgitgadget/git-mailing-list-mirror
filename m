From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: [PATCH, nitpickingly final version] git-branch, git-checkout: autosetup
 for remote branch tracking
Date: Thu, 08 Mar 2007 10:58:35 +0100
Message-ID: <45EFDE4B.3010408@lu.unisi.ch>
References: <45EFB205.4000604@lu.unisi.ch> <7vzm6o9ie1.fsf@assigned-by-dhcp.cox.net>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: bonzini@gnu.org, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 08 10:58:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPFOY-0005Rs-50
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 10:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030576AbXCHJ6m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 04:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030578AbXCHJ6m
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 04:58:42 -0500
Received: from server.usilu.net ([195.176.178.200]:37454 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030576AbXCHJ6k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 04:58:40 -0500
Received: from [192.168.76.141] ([192.168.76.141] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 8 Mar 2007 10:58:36 +0100
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <7vzm6o9ie1.fsf@assigned-by-dhcp.cox.net>
X-OriginalArrivalTime: 08 Mar 2007 09:58:36.0285 (UTC) FILETIME=[56B9AAD0:01C76168]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41729>

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
branch --track mytopic origin/topic" performs the latter two actions
when creating your 'mytopic' branch.

If the configuration variable branch.autosetupmerge is set to true, you
do not have to pass the --track option explicitly; further patches in
this series allow setting the variable with a "git remote add" option.
The configuration variable is off by default, and there is a --no-track
option to countermand it even if the variable is set.

Signed-off-by: Paolo Bonzini  <bonzini@gnu.org>
---
 Documentation/git-branch.txt   |    9 ++
 Documentation/git-checkout.txt |   15 +++-
 builtin-branch.c               |  137 ++++++++++++++++++++++++++++++++++++++---
 cache.h                        |    1
 git-checkout.sh                |   17 +++--
 t/t3200-branch.sh              |   65 ++++++++++++++++---
 trace.c                        |   18 ++---
 7 files changed, 226 insertions(+), 36 deletions(-)

	This fixes all the nits you pointed out. :-D

	Now, this was an experience to make...


diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 3ea3b80..603f87f 100644
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
+the default using the global `branch.autosetupmerge` configuration
+flag.  Otherwise, it can be chosen per-branch using the `--track`
+and `--no-track` options.
+
 With a '-m' or '-M' option, <oldbranch> will be renamed to <newbranch>.
 If <oldbranch> had a corresponding reflog, it is renamed to match
 <newbranch>, and a reflog entry is created to remember the branch
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 1ae77be..f5b2d50 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -8,7 +8,7 @@ git-checkout - Checkout and switch to a branch
 SYNOPSIS
 --------
 [verse]
-'git-checkout' [-q] [-f] [-b <new_branch> [-l]] [-m] [<branch>]
+'git-checkout' [-q] [-f] [-b [--track | --no-track] <new_branch> [-l]] [-m] [<branch>]
 'git-checkout' [<tree-ish>] <paths>...
 
 DESCRIPTION
@@ -18,7 +18,8 @@ When <paths> are not given, this command switches branches by
 updating the index and working tree to reflect the specified
 branch, <branch>, and updating HEAD to be <branch> or, if
 specified, <new_branch>.  Using -b will cause <new_branch> to
-be created.
+be created; in this case you can use the --track or --no-track
+options, which will be passed to `git branch`.
 
 When <paths> are given, this command does *not* switch
 branches.  It updates the named paths in the working tree from
@@ -45,6 +46,16 @@ OPTIONS
 	by gitlink:git-check-ref-format[1].  Some of these checks
 	may restrict the characters allowed in a branch name.
 
+--track::
+	When -b is given and a branch is created off a remote branch,
+	setup so that git-pull will automatically retrieve data from
+	the remote branch.
+
+--no-track::
+	When -b is given and a branch is created off a remote branch,
+	force that git-pull will automatically retrieve data from
+	the remote branch independent of the configuration settings.
+
 -l::
 	Create the new branch's ref log.  This activates recording of
 	all changes to made the branch ref, enabling use of date
diff --git a/builtin-branch.c b/builtin-branch.c
index d371849..43140c4 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -12,7 +12,7 @@
 #include "builtin.h"
 
 static const char builtin_branch_usage[] =
-  "git-branch [-r] (-d | -D) <branchname> | [-l] [-f] <branchname> [<start-point>] | (-m | -M) [<oldbranch>] <newbranch> | [--color | --no-color] [-r | -a] [-v [--abbrev=<length> | --no-abbrev]]";
+  "git-branch [-r] (-d | -D) <branchname> | [--track | --no-track] [-l] [-f] <branchname> [<start-point>] | (-m | -M) [<oldbranch>] <newbranch> | [--color | --no-color] [-r | -a] [-v [--abbrev=<length> | --no-abbrev]]";
 
 #define REF_UNKNOWN_TYPE    0x00
 #define REF_LOCAL_BRANCH    0x01
@@ -22,6 +22,8 @@ static const char builtin_branch_usage[] =
 static const char *head;
 static unsigned char head_sha1[20];
 
+static int branch_track_remotes;
+
 static int branch_use_color;
 static char branch_colors[][COLOR_MAXLEN] = {
 	"\033[m",	/* reset */
@@ -64,6 +66,9 @@ int git_branch_config(const char *var, const char *value)
 		color_parse(value, var, branch_colors[slot]);
 		return 0;
 	}
+	if (!strcmp(var, "branch.autosetupmerge"))
+		branch_track_remotes = git_config_bool(var, value);
+
 	return git_default_config(var, value);
 }
 
@@ -308,14 +313,107 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev)
 	free_ref_list(&ref_list);
 }
 
+static char *config_repo;
+static char *config_remote;
+static const char *start_ref;
+static int start_len;
+static int base_len;
+
+static int get_remote_branch_name(const char *value)
+{
+	const char *colon;
+	const char *end;
+
+	if (*value == '+')
+		value++;
+
+	colon = strchr(value, ':');
+        if (!colon)
+		return 0;
+
+	end = value + strlen(value);
+
+	/* Try an exact match first.  */
+	if (!strcmp(colon + 1, start_ref)) {
+		/* Truncate the value before the colon.  */
+		nfasprintf(&config_repo, "%.*s", colon - value, value);
+		return 1;
+	}
+
+	/* Try with a wildcard match now.  */
+	if (end - value > 2 && end[-2] == '/' && end[-1] == '*' &&
+	    colon - value > 2 && colon[-2] == '/' && colon[-1] == '*' &&
+	    (end - 2) - (colon + 1) == base_len &&
+	    !strncmp(colon + 1, start_ref, base_len)) {
+		/* Replace the star with the remote branch name.  */
+		nfasprintf(&config_repo, "%.*s%s",
+			   (colon - 2) - value, value,
+			   start_ref + base_len);
+		return 1;
+	}
+
+	return 0;
+}
+
+static int get_remote_config(const char *key, const char *value)
+{
+	const char *var;
+        if (prefixcmp(key, "remote."))
+		return 0;
+
+	var = strrchr(key, '.');
+	if (var == key + 6)
+		return 0;
+
+	if (!strcmp(var, ".fetch") && get_remote_branch_name(value))
+		nfasprintf(&config_remote, "%.*s", var - (key + 7), key + 7);
+
+        return 0;
+}
+
+static void set_branch_defaults(const char *name, const char *real_ref)
+{
+	char key[1024];
+	const char *slash = strrchr(real_ref, '/');
+
+	if (!slash)
+		return;
+
+	start_ref = real_ref;
+	start_len = strlen(real_ref);
+	base_len = slash - real_ref;
+	git_config(get_remote_config);
+
+	/* Change to != 0 to enable this feature by default.  */
+	if (config_repo && config_remote) {
+		if (snprintf(key, sizeof(key), "branch.%s.remote", name)
+		    > sizeof(key))
+			die("what a long branch name you have!");
+		git_config_set(key, config_remote);
+
+		/* We must have space for the key, since it's shorter than
+		   the previous one.  */
+		snprintf(key, sizeof(key), "branch.%s.merge", name);
+		git_config_set(key, config_repo);
+
+		printf("Branch %s set up to track remote branch %s.\n",
+		       name, real_ref);
+	}
+
+	if (config_repo)
+		free(config_repo);
+	if (config_remote)
+		free(config_remote);
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
+	char *real_ref, ref[PATH_MAX], msg[PATH_MAX + 20];
 	int forcing = 0;
 
 	snprintf(ref, sizeof ref, "refs/heads/%s", name);
@@ -330,10 +428,13 @@ static void create_branch(const char *name, const char *start_name,
 		forcing = 1;
 	}
 
-	if (start_sha1)
+	if (start_sha1) {
 		/* detached HEAD */
 		hashcpy(sha1, start_sha1);
-	else if (get_sha1(start_name, sha1))
+		real_ref = NULL;
+	} else if (dwim_ref(start_name, strlen(start_name), sha1, &real_ref) > 1)
+		die("Ambiguous object name: '%s'.", start_name);
+	else if (real_ref == NULL)
 		die("Not a valid object name: '%s'.", start_name);
 
 	if ((commit = lookup_commit_reference(sha1)) == NULL)
@@ -354,8 +455,17 @@ static void create_branch(const char *name, const char *start_name,
 		snprintf(msg, sizeof msg, "branch: Created from %s",
 			 start_name);
 
+	/* When branching off a remote branch, set up so that git-pull
+	   automatically merges from there.  So far, this is only done for
+	   remotes registered via .git/config.  */
+	if (real_ref && track)
+		set_branch_defaults(name, real_ref);
+
 	if (write_ref_sha1(lock, sha1, msg) < 0)
 		die("Failed to write ref: %s.", strerror(errno));
+
+	if (real_ref)
+		free(real_ref);
 }
 
 static void rename_branch(const char *oldname, const char *newname, int force)
@@ -397,11 +507,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	int delete = 0, force_delete = 0, force_create = 0;
 	int rename = 0, force_rename = 0;
 	int verbose = 0, abbrev = DEFAULT_ABBREV, detached = 0;
-	int reflog = 0;
+	int reflog = 0, track;
 	int kinds = REF_LOCAL_BRANCH;
 	int i;
 
 	git_config(git_branch_config);
+	track = branch_track_remotes;
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -412,6 +523,14 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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
@@ -498,9 +617,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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
 
diff --git a/cache.h b/cache.h
index 4b5a754..cb4fbfd 100644
--- a/cache.h
+++ b/cache.h
@@ -480,6 +480,7 @@ extern struct tag *alloc_tag_node(void);
 extern void alloc_report(void);
 
 /* trace.c */
+extern int nfasprintf(char **str, const char *fmt, ...);
 extern int nfvasprintf(char **str, const char *fmt, va_list va);
 extern void trace_printf(const char *format, ...);
 extern void trace_argv_printf(const char **argv, int count, const char *format, ...);
diff --git a/git-checkout.sh b/git-checkout.sh
index 14835a4..6caa9fd 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -12,6 +12,7 @@ new=
 new_name=
 force=
 branch=
+track=
 newbranch=
 newbranch_log=
 merge=
@@ -33,7 +34,10 @@ while [ "$#" != "0" ]; do
 			die "git checkout: we do not like '$newbranch' as a branch name."
 		;;
 	"-l")
-		newbranch_log=1
+		newbranch_log=-l
+		;;
+	"--track"|"--no-track")
+		track="$arg"
 		;;
 	"-f")
 		force=1
@@ -85,6 +89,11 @@ while [ "$#" != "0" ]; do
     esac
 done
 
+case "$new_branch,$track" in
+,--*)
+	die "git checkout: --track and --no-track require -b"
+esac
+
 case "$force$merge" in
 11)
 	die "git checkout: -f and -m are incompatible"
@@ -235,11 +244,7 @@ fi
 #
 if [ "$?" -eq 0 ]; then
 	if [ "$newbranch" ]; then
-		if [ "$newbranch_log" ]; then
-			mkdir -p $(dirname "$GIT_DIR/logs/refs/heads/$newbranch")
-			touch "$GIT_DIR/logs/refs/heads/$newbranch"
-		fi
-		git-update-ref -m "checkout: Created from $new_name" "refs/heads/$newbranch" $new || exit
+		git-branch $track $newbranch_log "$newbranch" "$new_name" || exit
 		branch="$newbranch"
 	fi
 	if test -n "$branch"
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 5565c27..75c000a 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -47,17 +47,6 @@ test_expect_success \
 	 test ! -f .git/refs/heads/d/e/f &&
 	 test ! -f .git/logs/refs/heads/d/e/f'
 
-cat >expect <<EOF
-0000000000000000000000000000000000000000 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	checkout: Created from master
-EOF
-test_expect_success \
-    'git checkout -b g/h/i -l should create a branch and a log' \
-	'GIT_COMMITTER_DATE="2005-05-26 23:30" \
-     git-checkout -b g/h/i -l master &&
-	 test -f .git/refs/heads/g/h/i &&
-	 test -f .git/logs/refs/heads/g/h/i &&
-	 diff expect .git/logs/refs/heads/g/h/i'
-
 test_expect_success \
     'git branch j/k should work after branch j has been deleted' \
        'git-branch j &&
@@ -117,4 +106,58 @@ test_expect_failure \
      ln -s real-u .git/logs/refs/heads/u &&
      git-branch -m u v'
 
+test_expect_success 'test tracking setup via --track' \
+    'git-config remote.local.url . &&
+     git-config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+     (git-show-ref -q refs/remotes/local/master || git-fetch local) &&
+     git-branch --track my1 local/master &&
+     test $(git-config branch.my1.remote) = local &&
+     test $(git-config branch.my1.merge) = refs/heads/master'
+
+test_expect_success 'test tracking setup (non-wildcard, matching)' \
+    'git-config remote.local.url . &&
+     git-config remote.local.fetch refs/heads/master:refs/remotes/local/master &&
+     (git-show-ref -q refs/remotes/local/master || git-fetch local) &&
+     git-branch --track my4 local/master &&
+     test $(git-config branch.my4.remote) = local &&
+     test $(git-config branch.my4.merge) = refs/heads/master'
+
+test_expect_success 'test tracking setup (non-wildcard, not matching)' \
+    'git-config remote.local.url . &&
+     git-config remote.local.fetch refs/heads/s:refs/remotes/local/s &&
+     (git-show-ref -q refs/remotes/local/master || git-fetch local) &&
+     git-branch --track my5 local/master &&
+     ! test $(git-config branch.my5.remote) = local &&
+     ! test $(git-config branch.my5.merge) = refs/heads/master'
+
+test_expect_success 'test tracking setup via config' \
+    'git-config branch.autosetupmerge true &&
+     git-config remote.local.url . &&
+     git-config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+     (git-show-ref -q refs/remotes/local/master || git-fetch local) &&
+     git-branch my3 local/master &&
+     test $(git-config branch.my3.remote) = local &&
+     test $(git-config branch.my3.merge) = refs/heads/master'
+
+test_expect_success 'test overriding tracking setup via --no-track' \
+    'git-config branch.autosetupmerge true &&
+     git-config remote.local.url . &&
+     git-config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+     (git-show-ref -q refs/remotes/local/master || git-fetch local) &&
+     git-branch --no-track my2 local/master &&
+     ! test $(git-config branch.my2.remote) = local &&
+     ! test $(git-config branch.my2.merge) = refs/heads/master'
+
+# Keep this test last, as it changes the current branch
+cat >expect <<EOF
+0000000000000000000000000000000000000000 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
+EOF
+test_expect_success \
+    'git checkout -b g/h/i -l should create a branch and a log' \
+	'GIT_COMMITTER_DATE="2005-05-26 23:30" \
+     git-checkout -b g/h/i -l master &&
+	 test -f .git/refs/heads/g/h/i &&
+	 test -f .git/logs/refs/heads/g/h/i &&
+	 diff expect .git/logs/refs/heads/g/h/i'
+
 test_done
diff --git a/trace.c b/trace.c
index 27fef86..27b2e85 100644
--- a/trace.c
+++ b/trace.c
@@ -26,14 +26,14 @@
 #include "quote.h"
 
 /* Stolen from "imap-send.c". */
-static int git_vasprintf(char **strp, const char *fmt, va_list ap)
+int nfvasprintf(char **strp, const char *fmt, va_list ap)
 {
 	int len;
 	char tmp[1024];
 
 	if ((len = vsnprintf(tmp, sizeof(tmp), fmt, ap)) < 0 ||
 	    !(*strp = xmalloc(len + 1)))
-		return -1;
+		die("Fatal: Out of memory\n");
 	if (len >= (int)sizeof(tmp))
 		vsprintf(*strp, fmt, ap);
 	else
@@ -41,13 +41,15 @@ static int git_vasprintf(char **strp, const char *fmt, va_list ap)
 	return len;
 }
 
-/* Stolen from "imap-send.c". */
-int nfvasprintf(char **str, const char *fmt, va_list va)
+int nfasprintf(char **str, const char *fmt, ...)
 {
-	int ret = git_vasprintf(str, fmt, va);
-	if (ret < 0)
-		die("Fatal: Out of memory\n");
-	return ret;
+	int rc;
+	va_list args;
+
+	va_start(args, fmt);
+	rc = nfvasprintf(str, fmt, args);
+	va_end(args);
+	return args;
 }
 
 /* Get a trace file descriptor from GIT_TRACE env variable. */
