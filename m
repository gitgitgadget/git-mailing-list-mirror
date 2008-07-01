From: Sylvain Joyeux <sylvain.joyeux@dfki.de>
Subject: [PATCH] better git-submodule status output
Date: Tue, 1 Jul 2008 17:01:19 +0200
Message-ID: <20080701150119.GE5852@joyeux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 17:08:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDhSq-0000Ws-Rd
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 17:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758701AbYGAPHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 11:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758309AbYGAPHT
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 11:07:19 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:38970 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757916AbYGAPHR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 11:07:17 -0400
X-Greylist: delayed 411 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Jul 2008 11:07:17 EDT
Received: from [134.102.219.50] (helo=joyeux)
	by smtprelay02.ispgateway.de with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <sylvain.joyeux@dfki.de>)
	id 1KDhM7-0006Dc-AD
	for git@vger.kernel.org; Tue, 01 Jul 2008 17:01:19 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Df-Sender: [pbs]640670
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87042>

Oups.. sorry for the patch-as-attachment in the previous mail

This patch makes the output of git-submodule more useful to handle the
management of a repository using multiple submodules. Namely, it
displays informations about how the current checked out version relates
to the registered one (i.e. direct parent, direct child, "just
different", registered revision does not exist), and displays if the
submodules contain uncommitted changes.

This (among other things) allows to do git-submodule update while
knowing exactly what will happen.
--
Sylvain

>From 16553a9b210a956b0af961d55a9cf06f1b9b8114 Mon Sep 17 00:00:00 2001
From: Sylvain Joyeux <sylvain.joyeux@dfki.de>
Date: Tue, 1 Jul 2008 16:01:01 +0200
Subject: [PATCH] more information in git-submodule status output

This commit adds more information in the 'status' output of
git-submodule. More specifically, it displays different flags if the
submodule and the registered revision are direct parents (> and <,
depending on which is the ancestor), if they are not direct parents (+)
or if the registered revision cannot be found (i.e. if submodule update
would fail, '!')

Finally, it shows if the submodule contains uncommitted changes (M flag)

Signed-off-by: Sylvain Joyeux <sylvain.joyeux@dfki.de>
---
 Documentation/git-submodule.txt |   23 ++++++++++++++++++-----
 git-submodule.sh                |   32 ++++++++++++++++++++++++++++----
 t/t7400-submodule-basic.sh      |   20 +++++++++++++-------
 3 files changed, 59 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 441ae14..3820002 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -33,10 +33,23 @@ status::
 	Show the status of the submodules. This will print the SHA-1 of the
 	currently checked out commit for each submodule, along with the
 	submodule path and the output of linkgit:git-describe[1] for the
-	SHA-1. Each SHA-1 will be prefixed with `-` if the submodule is not
-	initialized and `+` if the currently checked out submodule commit
-	does not match the SHA-1 found in the index of the containing
-	repository. This command is the default command for git-submodule.
+	SHA-1. Each SHA-1 will be prefixed with the following codes:
+	* `-` if the submodule is not initialized
+	* `<` if the current submodule HEAD is a direct ancestor of the
+	    revision registered in the containing repository.  I.e. a `git
+	    submodule update` would lead to a fast forward.
+	* `>` if the current submodule HEAD is a direct ancestor of the
+	    revision registered in the containing repository.
+	* `+` if the current submodule HEAD and the revision registered in
+	    the containing repository do not match, and there is no direct
+	    relationship between the two commits.
+	* `!` if the SHA-1 found in the index of the containing repository is
+	    not present in the the currently checked out submodule commit,
+	    nor be fetched from the associated remote.
+	
+	Additionally, a 'M' is displayed if the currently checked out
+	submodule contains uncommitted changes.
+	This command is the default command for git-submodule.
 
 init::
 	Initialize the submodules, i.e. register in .git/config each submodule
@@ -97,7 +110,7 @@ for details.
 
 AUTHOR
 ------
-Written by Lars Hjemli <hjemli@gmail.com>
+Written by Lars Hjemli <hjemli@gmail.com> and Sylvain Joyeux <sylvain.joyeux@m4x.org>
 
 GIT
 ---
diff --git a/git-submodule.sh b/git-submodule.sh
index 3eb78cc..e2b91f6 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -522,7 +522,11 @@ cmd_summary() {
 #
 # List all submodules, prefixed with:
 #  - submodule not initialized
-#  + different revision checked out
+#  > the checked out version is in advance with the current version (fast-forward)
+#  < the checked out version is late w.r.t the current version (fast-forward)
+#  + different revisions checked out, no fast-forward relationship
+#  ! the checked out version does not exist and cannot be fetched
+#  M submodule contains uncommitted changes
 #
 # If --cached was specified the revision in the index will be printed
 # instead of the currently checked out revision.
@@ -562,20 +566,40 @@ cmd_status()
 		url=$(git config submodule."$name".url)
 		if test -z "$url" || ! test -d "$path"/.git -o -f "$path"/.git
 		then
-			say "-$sha1 $path"
+			say "-  $sha1 $path"
 			continue;
 		fi
+                unclean=" "
+                if ! ( unset GIT_DIR; cd "$path" && git diff --quiet HEAD ); then
+                    unclean="M"
+                fi
 		set_name_rev "$path" "$sha1"
 		if git diff-files --quiet -- "$path"
 		then
-			say " $sha1 $path$revname"
+			say " $unclean $sha1 $path$revname"
 		else
+                        head=$(unset GIT_DIR; cd "$path" && git rev-parse --verify HEAD)
+                        common=$(unset GIT_DIR; cd "$path" && git merge-base HEAD $sha1)
+                        if test -z "$common"; then
+                            common=$(unset GIT_DIR; cd "$path" && git-fetch -q &&
+                                    git merge-base HEAD $sha1)
+                        fi
+                        if test "$common" = "$sha1"; then
+                            modflag=">"
+                        elif test "$common" = "$head"; then
+                            modflag="<"
+                        elif test "$common" = ""; then
+                            modflag="!"
+                        else
+                            modflag="+"
+                        fi
+
 			if test -z "$cached"
 			then
 				sha1=$(unset GIT_DIR; cd "$path" && git rev-parse --verify HEAD)
 				set_name_rev "$path" "$sha1"
 			fi
-			say "+$sha1 $path$revname"
+			say "$modflag$unclean $sha1 $path$revname"
 		fi
 	done
 }
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 6c7b902..ffaa932 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -65,7 +65,7 @@ test_expect_success 'status should only print one line' '
 '
 
 test_expect_success 'status should initially be "missing"' '
-	git-submodule status | grep "^-$rev1"
+	git-submodule status | grep "^-  $rev1"
 '
 
 test_expect_success 'init should register submodule url in .git/config' '
@@ -130,13 +130,19 @@ test_expect_success 'update should work when path is an empty dir' '
 '
 
 test_expect_success 'status should be "up-to-date" after update' '
-	git-submodule status | grep "^ $rev1"
+	git-submodule status | grep "^   $rev1"
 '
 
-test_expect_success 'status should be "modified" after submodule commit' '
+test_expect_success 'status should be "modified" after submodule change' '
 	cd init &&
 	echo b >b &&
-	git add b &&
+        git add b &&
+        cd .. &&
+	git-submodule status | grep "^ M $rev1"
+'
+
+test_expect_success 'status should be "in advance" after submodule commit' '
+	cd init &&
 	git-commit -m "submodule commit 2" &&
 	rev2=$(git rev-parse HEAD) &&
 	cd .. &&
@@ -145,11 +151,11 @@ test_expect_success 'status should be "modified" after submodule commit' '
 		echo "[OOPS] submodule git rev-parse returned nothing"
 		false
 	fi &&
-	git-submodule status | grep "^+$rev2"
+	git-submodule status | grep "^>  $rev2"
 '
 
 test_expect_success 'the --cached sha1 should be rev1' '
-	git-submodule --cached status | grep "^+$rev1"
+	git-submodule --cached status | grep "^>  $rev1"
 '
 
 test_expect_success 'git diff should report the SHA1 of the new submodule commit' '
@@ -171,7 +177,7 @@ test_expect_success 'update should checkout rev1' '
 '
 
 test_expect_success 'status should be "up-to-date" after update' '
-	git-submodule status | grep "^ $rev1"
+	git-submodule status | grep "^   $rev1"
 '
 
 test_expect_success 'checkout superproject with subproject already present' '
-- 
1.5.6
