From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: Re: [PATCH, fixed version] git-fetch, git-branch: Support local --track
 via a special remote `.'
Date: Tue, 13 Mar 2007 13:29:45 +0100
Message-ID: <45F69939.6070909@lu.unisi.ch>
References: <45F58A84.2000503@lu.unisi.ch> <7v4poplceh.fsf@assigned-by-dhcp.cox.net>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: bonzini@gnu.org, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 13 13:30:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HR68n-00066y-BV
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 13:30:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933224AbXCMM3u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 08:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933227AbXCMM3u
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 08:29:50 -0400
Received: from server.usilu.net ([195.176.178.200]:46298 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933224AbXCMM3s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 08:29:48 -0400
Received: from [192.168.68.211] ([192.168.68.211] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 13 Mar 2007 13:29:43 +0100
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <7v4poplceh.fsf@assigned-by-dhcp.cox.net>
X-OriginalArrivalTime: 13 Mar 2007 12:29:43.0035 (UTC) FILETIME=[46FEACB0:01C7656B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42115>

This patch on top of next adds support for a dummy remote `.' to
avoid having to declare a fake remote like

	[remote "local"]
		url = .
		fetch = refs/heads/*:refs/heads/*

Such a builtin remote simplifies the operation of "git-fetch", which
will populate FETCH_HEAD but will not pretend that two repositories are
in use, will not create a thin pack, and will not perform any useless
remapping of names.  The speed improvement is around 20%, and it should
improve more if "git-fetch" is converted to a builtin.

To this end, git-parse-remote is grown with a new kind of remote, `builtin'.
In git-fetch.sh, we treat the builtin remote specially in that it needs no
pack/store operations.  In fact, doing git-fetch on a builtin remote will
simply populate FETCH_HEAD appropriately.

The patch also improves of the --track/--no-track support, extending
it so that branch.<name>.remote items referring `.' can be created.
Finally, it fixes a typo in git-checkout.sh.

The patch was tested including the git-svn tests and has no regression.

Signed-off-by: Paolo Bonzini  <bonzini@gnu.org>
---
 Documentation/config.txt |    4 ++++
 builtin-branch.c         |   39 +++++++++++++++++++++++++--------------
 git-checkout.sh          |    2 +-
 git-fetch.sh             |   30 +++++++++++++++++++-----------
 git-parse-remote.sh      |   22 +++++++++++++++++++++-
 t/t3200-branch.sh        |    6 ++++++
 t/t5520-pull.sh          |   13 +++++++++++++
 t/t9109-git-svn-pull.sh  |   31 +++++++++++++++++++++++++++++++
 8 files changed, 120 insertions(+), 27 deletions(-)

	The failure, which I didn't see because I didn't have svn-perl
	bindings installed, was caused by my usage of "git-show-ref --heads"
	where I should have used plain "git-show-ref".

	I include a smaller testcase for the same problem, t9109.

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5408dd6..28899d9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -272,6 +272,10 @@ branch.<name>.merge::
 	`git fetch`) to lookup the default branch for merging. Without
 	this option, `git pull` defaults to merge the first refspec fetched.
 	Specify multiple values to get an octopus merge.
+	If you wish to setup `git pull` so that it merges into <name> from
+	another branch in the local repository, you can point
+	branch.<name>.merge to the desired branch, and use the special setting
+	`.` (a period) for branch.<name>.remote.
 
 color.branch::
 	A boolean to enable/disable color in the output of
diff --git a/builtin-branch.c b/builtin-branch.c
index 42b1ff1..14c4219 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -372,9 +372,26 @@ static int get_remote_config(const char *key, const char *value)
 	return 0;
 }
 
-static void set_branch_defaults(const char *name, const char *real_ref)
+static void set_branch_merge (const char *name, const char *config_remote,
+			      const char *config_repo)
 {
 	char key[1024];
+	if (sizeof(key) <=
+	    snprintf(key, sizeof(key), "branch.%s.remote", name))
+		die("what a long branch name you have!");
+	git_config_set(key, config_remote);
+
+	/*
+	 * We do not have to check if we have enough space for
+	 * the 'merge' key, since it's shorter than the
+	 * previous 'remote' key, which we already checked.
+	 */
+	snprintf(key, sizeof(key), "branch.%s.merge", name);
+	git_config_set(key, config_repo);
+}
+
+static void set_branch_defaults(const char *name, const char *real_ref)
+{
 	const char *slash = strrchr(real_ref, '/');
 
 	if (!slash)
@@ -384,21 +401,15 @@ static void set_branch_defaults(const char *name, const char *real_ref)
 	start_len = strlen(real_ref);
 	base_len = slash - real_ref;
 	git_config(get_remote_config);
+	if (!config_repo && !config_remote &&
+	    !prefixcmp (real_ref, "refs/heads/")) {
+		set_branch_merge (name, ".", real_ref);
+		printf("Branch %s set up to track local branch %s.\n",
+		       name, real_ref);
+	}
 
 	if (config_repo && config_remote) {
-		if (sizeof(key) <=
-		    snprintf(key, sizeof(key), "branch.%s.remote", name))
-			die("what a long branch name you have!");
-		git_config_set(key, config_remote);
-
-		/*
-		 * We do not have to check if we have enough space for
-		 * the 'merge' key, since it's shorter than the
-		 * previous 'remote' key, which we already checked.
-		 */
-		snprintf(key, sizeof(key), "branch.%s.merge", name);
-		git_config_set(key, config_repo);
-
+		set_branch_merge (name, config_remote, config_repo);
 		printf("Branch %s set up to track remote branch %s.\n",
 		       name, real_ref);
 	}
diff --git a/git-checkout.sh b/git-checkout.sh
index 6caa9fd..b292ff0 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -89,7 +89,7 @@ while [ "$#" != "0" ]; do
     esac
 done
 
-case "$new_branch,$track" in
+case "$newbranch,$track" in
 ,--*)
 	die "git checkout: --track and --no-track require -b"
 esac
diff --git a/git-fetch.sh b/git-fetch.sh
index b9d7a75..f06fa59 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -163,8 +163,13 @@ then
 	fi
 fi
 
-fetch_native () {
+fetch_builtin () {
+    for name in $(get_remote_fetch_branches "$remote_nick"); do
+      append_fetch_head $(git-rev-parse "$name") . "$name" "$name" || exit
+    done
+}
 
+fetch_native () {
   eval=$(echo "$1" | git-fetch--tool parse-reflist "-")
   eval "$eval"
 
@@ -291,14 +296,18 @@ fetch_dumb () {
 }
 
 fetch_main () {
-	case "$remote" in
-	http://* | https://* | ftp://* | rsync://* )
-		fetch_dumb "$@"
-		;;
-	*)
-		fetch_native "$@"
-		;;
-	esac
+	if test "$(get_data_source $remote_nick)" = builtin; then
+		fetch_builtin "$@"
+	else
+		case "$remote" in
+		http://* | https://* | ftp://* | rsync://* )
+			fetch_dumb "$@"
+			;;
+		*)
+			fetch_native "$@"
+			;;
+		esac
+	fi
 }
 
 fetch_main "$reflist" || exit
@@ -353,8 +362,7 @@ case ",$#,$remote_nick," in
 	curr_branch=$(git-symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')
 	merge_branches=$(git-config \
 		--get-all "branch.${curr_branch}.merge" | sort -u)
-	fetch_branches=$(get_remote_default_refs_for_fetch -n $remote_nick |
-		sed -e 's/:.*$//g' -e 's/^+//' | sort -u)
+	fetch_branches=$(get_remote_fetch_branches $remote_nick)
 	test -n "$merge_branches" && test -n "$fetch_branches" &&
 	merge_branches=$(printf '%s\n%s' "$merge_branches" "$fetch_branches" |
 		sort | uniq -d)
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 99e7184..4964810 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -9,6 +9,9 @@ get_data_source () {
 	*/*)
 		echo ''
 		;;
+	.)
+		echo builtin
+		;;
 	*)
 		if test "$(git-config --get "remote.$1.url")"
 		then
@@ -31,6 +34,9 @@ get_remote_url () {
 	'')
 		echo "$1"
 		;;
+	builtin)
+		echo "$1"
+		;;
 	config)
 		git-config --get "remote.$1.url"
 		;;
@@ -57,7 +63,7 @@ get_default_remote () {
 get_remote_default_refs_for_push () {
 	data_source=$(get_data_source "$1")
 	case "$data_source" in
-	'' | branches)
+	'' | branches | builtin)
 		;; # no default push mapping, just send matching refs.
 	config)
 		git-config --get-all "remote.$1.push" ;;
@@ -128,6 +134,8 @@ get_remote_default_refs_for_fetch () {
 	case "$data_source" in
 	'')
 		set explicit "HEAD:" ;;
+	builtin)
+		set explicit ;;
 	config)
 		set $(expand_refs_wildcard "$1" \
 			$(git-config --get-all "remote.$1.fetch")) ;;
@@ -154,6 +162,18 @@ get_remote_default_refs_for_fetch () {
 	fi
 }
 
+# Returns list of sources
+get_remote_fetch_branches () {
+	data_source=$(get_data_source "$1")
+	case "$data_source" in
+	builtin)
+	        git-show-ref | sed -n 's,.*[      ]refs/,refs/,p' ;;
+	*)
+		get_remote_default_refs_for_fetch -n "$1" | \
+			sed -e 's/:.*$//g' -e 's/^+//' | sort -u ;;
+	esac
+}
+
 get_remote_refs_for_push () {
 	case "$#" in
 	0) die "internal error: get-remote-refs-for-push." ;;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 75c000a..9558bdb 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -145,9 +145,15 @@ test_expect_success 'test overriding tracking setup via --no-track' \
      git-config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
      (git-show-ref -q refs/remotes/local/master || git-fetch local) &&
      git-branch --no-track my2 local/master &&
+     git-config branch.autosetupmerge false &&
      ! test $(git-config branch.my2.remote) = local &&
      ! test $(git-config branch.my2.merge) = refs/heads/master'
 
+test_expect_success 'test local tracking setup' \
+    'git branch --track my6 s &&
+     test $(git-config branch.my6.remote) = . &&
+     test $(git-config branch.my6.merge) = refs/heads/s'
+
 # Keep this test last, as it changes the current branch
 cat >expect <<EOF
 0000000000000000000000000000000000000000 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 7eb3783..c424e5b 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -29,5 +29,18 @@ test_expect_success 'checking the results' '
 	diff file cloned/file
 '
 
+test_expect_success 'test . as a remote' '
+
+	git branch copy master &&
+	git config branch.copy.remote . &&
+	git config branch.copy.merge refs/heads/master &&
+	echo updated >file &&
+	git commit -a -m updated &&
+	git checkout copy &&
+	test `cat file` = file &&
+	git pull &&
+	test `cat file` = updated
+'
+
 test_done
 
diff --git a/t/t9109-git-svn-pull.sh b/t/t9109-git-svn-pull.sh
new file mode 100755
index 0000000..4d59f60
--- /dev/null
+++ b/t/t9109-git-svn-pull.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Paolo Bonzini
+#
+
+test_description='git-svn pull test'
+. ./lib-git-svn.sh
+
+mkdir import
+
+cd import
+	echo Hello World > motd
+	svn import -m 'import for git-svn' . "$svnrepo" >/dev/null
+cd ..
+
+test_expect_success 'initialize git-svn and fetch' "
+	git-svn init $svnrepo
+	git-svn fetch"
+
+svn co $svnrepo test_wc > /dev/null
+cd test_wc
+	echo Goodbye World > motd
+	svn commit -m "another svn commit" > /dev/null
+cd ..
+
+test_expect_success 'fetch and pull latest from svn' \
+	'git-svn fetch &&
+	 git pull . remotes/git-svn &&
+	 grep Goodbye motd'
+
+test_done
