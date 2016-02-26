From: Mathias Nyman <mathias.nyman@iki.fi>
Subject: [PATCH v2] contrib/subtree: add repo url to commit messages
Date: Fri, 26 Feb 2016 10:43:57 +0200
Message-ID: <20160226084357.GA25889@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, npaolucci@atlassian.com, sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 09:44:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZE0N-0002gU-KY
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 09:44:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbcBZIoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 03:44:01 -0500
Received: from mail.kapsi.fi ([217.30.184.167]:56040 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932567AbcBZIn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 03:43:59 -0500
Received: from lakka.kapsi.fi ([2001:1bc8:1004::1] ident=Debian-exim)
	by mail.kapsi.fi with esmtps (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <lem@kapsi.fi>)
	id 1aZE0D-0007HP-IA; Fri, 26 Feb 2016 10:43:57 +0200
Received: from lem by lakka.kapsi.fi with local (Exim 4.80)
	(envelope-from <lem@lakka.kapsi.fi>)
	id 1aZE0D-000463-EL; Fri, 26 Feb 2016 10:43:57 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:1bc8:1004::1
X-SA-Exim-Mail-From: lem@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287555>

For recalling where a subtree came from; git-subtree operations 'add'
and 'pull', when called with the <repository> parameter add this to the
commit message:
    git-subtree-repo: <repo_url>

Other operations that don't have the <repository> information, like
'merge' and 'add' without <repository>, are unchanged. Users with such a
workflow will continue to be on their own with the --message parameter,
if they'd like to record where the subtree came from.

Signed-off-by: Mathias Nyman <mathias.nyman@iki.fi>
Based-on-patch-by: Nicola Paolucci <npaolucci@atlassian.com>
Thanks-to: Aleksi Aalto <aga@iki.fi>
---
 contrib/subtree/git-subtree.sh | 54 ++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 7a39b30..dd1f70e 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -335,6 +335,7 @@ add_msg()
 	dir="$1"
 	latest_old="$2"
 	latest_new="$3"
+	repo="$4" # optional
 	if [ -n "$message" ]; then
 		commit_message="$message"
 	else
@@ -347,6 +348,11 @@ add_msg()
 		git-subtree-mainline: $latest_old
 		git-subtree-split: $latest_new
 	EOF
+
+	if [ -n "$repo" ]; then
+		repo_url=$(get_repository_url "$repo")
+		echo "git-subtree-repo: $repo_url"
+	fi
 }
 
 add_squashed_msg()
@@ -382,6 +388,7 @@ squash_msg()
 	dir="$1"
 	oldsub="$2"
 	newsub="$3"
+	repo="$4" # optional
 	newsub_short=$(git rev-parse --short "$newsub")
 	
 	if [ -n "$oldsub" ]; then
@@ -397,6 +404,10 @@ squash_msg()
 	echo
 	echo "git-subtree-dir: $dir"
 	echo "git-subtree-split: $newsub"
+	if [ -n "$repo" ]; then
+		repo_url=$(get_repository_url "$repo")
+		echo "git-subtree-repo: $repo_url"
+	fi
 }
 
 toptree_for_commit()
@@ -440,12 +451,13 @@ new_squash_commit()
 	old="$1"
 	oldsub="$2"
 	newsub="$3"
+	repo="$4" # optional
 	tree=$(toptree_for_commit $newsub) || exit $?
 	if [ -n "$old" ]; then
-		squash_msg "$dir" "$oldsub" "$newsub" | 
+		squash_msg "$dir" "$oldsub" "$newsub" "$repo" |
 			git commit-tree "$tree" -p "$old" || exit $?
 	else
-		squash_msg "$dir" "" "$newsub" |
+		squash_msg "$dir" "" "$newsub" "$repo" |
 			git commit-tree "$tree" || exit $?
 	fi
 }
@@ -517,6 +529,16 @@ ensure_valid_ref_format()
 	    die "'$1' does not look like a ref"
 }
 
+get_repository_url()
+{
+	repo=$1
+	repo_url=$(git config --get remote.$repo.url)
+	if [ -z "$repo_url" ]; then
+		repo_url=$repo
+	fi
+	echo $repo_url
+}
+
 cmd_add()
 {
 	if [ -e "$dir" ]; then
@@ -548,17 +570,18 @@ cmd_add()
 cmd_add_repository()
 {
 	echo "git fetch" "$@"
-	repository=$1
+	repo=$1
 	refspec=$2
 	git fetch "$@" || exit $?
 	revs=FETCH_HEAD
-	set -- $revs
+	set -- $revs $repo
 	cmd_add_commit "$@"
 }
 
 cmd_add_commit()
 {
-	revs=$(git rev-parse $default --revs-only "$@") || exit $?
+	revs=$(git rev-parse $default --revs-only "$1") || exit $?
+	repo="$2" # optional
 	set -- $revs
 	rev="$1"
 	
@@ -575,12 +598,12 @@ cmd_add_commit()
 	fi
 	
 	if [ -n "$squash" ]; then
-		rev=$(new_squash_commit "" "" "$rev") || exit $?
+		rev=$(new_squash_commit "" "" "$rev" "$repo") || exit $?
 		commit=$(add_squashed_msg "$rev" "$dir" |
 			 git commit-tree $tree $headp -p "$rev") || exit $?
 	else
 		revp=$(peel_committish "$rev") &&
-		commit=$(add_msg "$dir" "$headrev" "$rev" |
+		commit=$(add_msg "$dir" "$headrev" "$rev" "$repo" |
 			 git commit-tree $tree $headp -p "$revp") || exit $?
 	fi
 	git reset "$commit" || exit $?
@@ -610,6 +633,7 @@ cmd_split()
 		unrevs="$(find_existing_splits "$dir" "$revs")"
 	fi
 	
+	rev="$1"
 	# We can't restrict rev-list to only $dir here, because some of our
 	# parents have the $dir contents the root, and those won't match.
 	# (and rev-list --follow doesn't seem to solve this)
@@ -683,14 +707,19 @@ cmd_split()
 
 cmd_merge()
 {
-	revs=$(git rev-parse $default --revs-only "$@") || exit $?
+	revs=$(git rev-parse $default --revs-only "$1") || exit $?
 	ensure_clean
-	
 	set -- $revs
 	if [ $# -ne 1 ]; then
 		die "You must provide exactly one revision.  Got: '$revs'"
 	fi
+	do_merge "$@"
+}
+
+do_merge()
+{
 	rev="$1"
+	repo="$2" # optional
 	
 	if [ -n "$squash" ]; then
 		first_split="$(find_latest_squash "$dir")"
@@ -704,7 +733,7 @@ cmd_merge()
 			say "Subtree is already at commit $rev."
 			exit 0
 		fi
-		new=$(new_squash_commit "$old" "$sub" "$rev") || exit $?
+		new=$(new_squash_commit "$old" "$sub" "$rev" "$repo") || exit $?
 		debug "New squash commit: $new"
 		rev="$new"
 	fi
@@ -730,12 +759,13 @@ cmd_pull()
 	if [ $# -ne 2 ]; then
 	    die "You must provide <repository> <ref>"
 	fi
+	repo=$1
 	ensure_clean
 	ensure_valid_ref_format "$2"
 	git fetch "$@" || exit $?
 	revs=FETCH_HEAD
-	set -- $revs
-	cmd_merge "$@"
+	set -- $revs $repo
+	do_merge "$@"
 }
 
 cmd_push()
-- 
2.7.1
