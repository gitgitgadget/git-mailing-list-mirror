From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH, fixed] git-fetch, git-branch: Support local --track via a
 special remote `.'
Date: Thu, 15 Mar 2007 09:23:20 +0100
Message-ID: <etavpn$ma0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 15 09:23:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRlFU-0006Tl-7Y
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 09:23:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933450AbXCOIXp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 04:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933386AbXCOIXp
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 04:23:45 -0400
Received: from main.gmane.org ([80.91.229.2]:44118 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933450AbXCOIXn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 04:23:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HRlFB-000651-KV
	for git@vger.kernel.org; Thu, 15 Mar 2007 09:23:29 +0100
Received: from usilu-ge.ti-edu.ch ([195.176.176.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Mar 2007 09:23:29 +0100
Received: from bonzini by usilu-ge.ti-edu.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Mar 2007 09:23:29 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: usilu-ge.ti-edu.ch
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42274>

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
 git-fetch.sh             |   29 +++++++++++++++++++----------
 git-parse-remote.sh      |   13 +++++++++++--
 t/t3200-branch.sh        |    6 ++++++
 t/t5520-pull.sh          |   24 ++++++++++++++++++++++++
 7 files changed, 90 insertions(+), 27 deletions(-)

	This patch includes the testcase from Junio -- which now
	passes.  Fixing it is easy but required a curious implementation:
	since all we have to do is append fetched heads to FETCH_HEADS,
	it is simpler to put the handling of builtin `.' into fetch_dumb.

	To make the name of fetch_dumb more consistent with the
	functionality, I renamed it to fetch_heads, as well as
	renaming fetch_native to fetch_packs.

	The patch was regression tested and shows no regression.  I added
	to t5520-pull.sh the testcase that was failing in the first respin.


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
index 42b1ff1..a4494ee 100644
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
index ebe6c33..3b01f06 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -161,7 +161,7 @@ then
 	fi
 fi
 
-fetch_native () {
+fetch_packs () {
 
   eval=$(echo "$1" | git-fetch--tool parse-reflist "-")
   eval "$eval"
@@ -192,7 +192,7 @@ fetch_native () {
 
 }
 
-fetch_dumb () {
+fetch_heads () {
   reflist="$1"
   refs=
   rref=
@@ -286,6 +286,10 @@ fetch_dumb () {
 	      rsync_slurped_objects=t
 	  }
 	  ;;
+      .)
+	  local_name=$remote_name
+	  head=$(git-rev-parse --verify "$local_name")
+	  ;;
       esac
 
       append_fetch_head "$head" "$remote" \
@@ -296,14 +300,19 @@ fetch_dumb () {
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
+	data_source=$(get_data_source "$remote_nick")
+	if test "$data_source" = builtin; then
+		fetch_heads "$@"
+	else
+		case "$remote" in
+		http://* | https://* | ftp://* | rsync://* )
+			fetch_heads "$@"
+			;;
+		*)
+			fetch_packs "$@"
+			;;
+		esac
+	fi
 }
 
 fetch_main "$reflist" || exit
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index c46131f..a94215d 100755
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
@@ -163,6 +169,9 @@ get_remote_default_refs_for_fetch () {
 	case "$data_source" in
 	'')
 		echo "HEAD:" ;;
+	builtin)
+	        canon_refs_list_for_fetch -d "$1" \
+			$(git-show-ref | sed -n 's,.*[      ]\(refs/.*\),\1:,p') ;;
 	config)
 		canon_refs_list_for_fetch -d "$1" \
 			$(git-config --get-all "remote.$1.fetch") ;;
@@ -177,7 +186,7 @@ get_remote_default_refs_for_fetch () {
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
index 7eb3783..243212d 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -29,5 +29,29 @@ test_expect_success 'checking the results' '
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
+test_expect_success 'the default remote . should not break explicit pull' '
+	git checkout -b second master^ &&
+	echo modified >file &&
+	git commit -a -m modified &&
+	git checkout copy &&
+	git reset --hard HEAD^ &&
+	test `cat file` = file &&
+	git pull . second &&
+	test `cat file` = modified
+'
+
 test_done
 
