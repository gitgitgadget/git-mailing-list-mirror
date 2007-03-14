From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: [PATCH, respin] git-fetch, git-branch: Support local --track via
 a special remote `.'
Date: Wed, 14 Mar 2007 13:52:33 +0100
Message-ID: <45F7F011.5080308@lu.unisi.ch>
References: <45F58A84.2000503@lu.unisi.ch>	<7v4poplceh.fsf@assigned-by-dhcp.cox.net>	<45F69939.6070909@lu.unisi.ch> <7vird4ax66.fsf@assigned-by-dhcp.cox.net>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 14 13:53:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRSyg-0007en-Be
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 13:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161227AbXCNMxK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 08:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161252AbXCNMxK
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 08:53:10 -0400
Received: from server.usilu.net ([195.176.178.200]:47205 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161227AbXCNMxI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 08:53:08 -0400
Received: from [192.168.76.141] ([192.168.76.141] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 14 Mar 2007 13:52:29 +0100
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <7vird4ax66.fsf@assigned-by-dhcp.cox.net>
X-OriginalArrivalTime: 14 Mar 2007 12:52:29.0733 (UTC) FILETIME=[A005FD50:01C76637]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42206>

This patch adds support for a dummy remote `.' to avoid having to declare
a fake remote like

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

Signed-off-by: Paolo Bonzini  <bonzini@gnu.org>
---
 Documentation/config.txt |    4 ++++
 builtin-branch.c         |   39 +++++++++++++++++++++++++--------------
 git-checkout.sh          |    2 +-
 git-fetch.sh             |   28 ++++++++++++++++++++--------
 git-parse-remote.sh      |   12 ++++++++++--
 t/t3200-branch.sh        |    6 ++++++
 t/t5520-pull.sh          |   13 +++++++++++++
 7 files changed, 79 insertions(+), 25 deletions(-)

	> I'd prefer dropping the t9109 test, as it seems to be redundant.

	As you wish.

	> Also I'll be reverting a couple of patches from 'next', so this
	> no longer applies.  Would appreciate a re-spin.
	> 
	> Sorry about that.

	No problem.

	I must say that from a clarity point of view I preferred the
	older code.  It did encapsulate fetching in a pretty easy to
	understand way.  OTOH, my patch is smaller now.

	Just my 0.02 cents, or something to remember once the
	git-fetch--tool conversion proceeds and possibly the merge logic
	is written in C.


diff --git a/Documentation/config.txt b/Documentation/config.txt
index aaae9ac..953acae 100644
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
+static void set_branch_merge(const char *name, const char *config_remote,
+			     const char *config_repo)
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
+	    !prefixcmp(real_ref, "refs/heads/")) {
+		set_branch_merge(name, ".", real_ref);
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
+		set_branch_merge(name, config_remote, config_repo);
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
index ebe6c33..88bf64d 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -161,6 +161,14 @@ then
 	fi
 fi
 
+fetch_builtin () {
+    for ref in $(get_remote_default_refs_for_fetch "$remote_nick"); do
+      name=$(expr "z$ref" : 'z\([^:]*\):')
+      append_fetch_head $(git-rev-parse "$name") "$remote" \
+	  "$name" "$remote_nick" "$name" "" || exit
+    done
+}
+
 fetch_native () {
   eval=$(echo "$1" | git-fetch--tool parse-reflist "-")
   eval "$eval"
@@ -296,14 +303,18 @@ fetch_dumb () {
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
+		fetch_builtin
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
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index c46131f..1b96ec6 100755
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
@@ -163,6 +169,8 @@ get_remote_default_refs_for_fetch () {
 	case "$data_source" in
 	'')
 		echo "HEAD:" ;;
+	builtin)
+	        git-show-ref | sed -n 's,.*[      ]\(refs/.*\),\1:,p' ;;
 	config)
 		canon_refs_list_for_fetch -d "$1" \
 			$(git-config --get-all "remote.$1.fetch") ;;
@@ -177,7 +185,7 @@ get_remote_default_refs_for_fetch () {
 					}' "$GIT_DIR/remotes/$1")
 		;;
 	*)
-		die "internal error: get-remote-default-ref-for-push $1" ;;
+		die "internal error: get-remote-default-ref-for-fetch $1" ;;
 	esac
 }
 
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
@@ -29,5 +29,17 @@ test_expect_success 'checking the results' '
 	diff file cloned/file
 '
 
+test_expect_success 'test . as a remote' '
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
 
