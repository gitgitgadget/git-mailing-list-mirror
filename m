From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Teach 'git pull' the '--rebase' option
Date: Thu, 25 Oct 2007 23:54:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710252351130.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Oct 26 00:54:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlBbC-0005Qm-U7
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 00:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759419AbXJYWyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 18:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759040AbXJYWye
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 18:54:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:38810 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758342AbXJYWyd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 18:54:33 -0400
Received: (qmail invoked by alias); 25 Oct 2007 22:54:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 26 Oct 2007 00:54:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX198Q7JJ8nd8u8eek5fNqdq6ebof2KDN4azQeU1icn
	u/GW7y29pYeqnN
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62382>


When calling 'git pull' with the '--rebase' option, it performs a
fetch + rebase instead of a fetch + pull.

This behavior is more desirable than fetch + pull when a topic branch
is ready to be submitted.

fetch + rebase might also be considered a better workflow with shared
repositories in any case, or for contributors to a centrally managed
project, such as Wine -- or Git.

For your convenience, you can set the default behavior for a branch by
defining the config variable branch.<name>.rebase, which is
interpreted as a bool.  This setting can be overridden on the command
line by --rebase and --no-rebase.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-pull.txt |    6 ++++++
 git-pull.sh                |   11 ++++++++++-
 t/t5520-pull.sh            |   22 ++++++++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index e1eb2c1..c3ce8ee 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -33,6 +33,12 @@ include::urls-remotes.txt[]
 
 include::merge-strategies.txt[]
 
+\--rebase::
+	Instead of a merge, perform a rebase after fetching.
+
+\--no-rebase::
+	Override earlier \--rebase.
+
 DEFAULT BEHAVIOUR
 -----------------
 
diff --git a/git-pull.sh b/git-pull.sh
index 74bfc16..b5ecb80 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -16,6 +16,9 @@ test -z "$(git ls-files -u)" ||
 	die "You are in the middle of a conflicted merge."
 
 strategy_args= no_summary= no_commit= squash=
+curr_branch=$(git symbolic-ref -q HEAD)
+curr_branch_short=$(echo "$curr_branch" | sed "s|refs/heads/||")
+rebase=$(git config --bool branch.$curr_branch_short.rebase)
 while :
 do
 	case "$1" in
@@ -43,6 +46,12 @@ do
 		esac
 		strategy_args="${strategy_args}-s $strategy "
 		;;
+	-r|--r|--re|--reb|--reba|--rebas|--rebase)
+		rebase=true
+		;;
+	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
+		rebase=false
+		;;
 	-h|--h|--he|--hel|--help)
 		usage
 		;;
@@ -86,7 +95,6 @@ merge_head=$(sed -e '/	not-for-merge	/d' \
 
 case "$merge_head" in
 '')
-	curr_branch=$(git symbolic-ref -q HEAD)
 	case $? in
 	  0) ;;
 	  1) echo >&2 "You are not currently on a branch; you must explicitly"
@@ -133,5 +141,6 @@ then
 fi
 
 merge_name=$(git fmt-merge-msg <"$GIT_DIR/FETCH_HEAD") || exit
+test true = "$rebase" && exec git-rebase $merge_head
 exec git-merge $no_summary $no_commit $squash $strategy_args \
 	"$merge_name" HEAD $merge_head
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 93eaf2c..52b3a0c 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -53,4 +53,26 @@ test_expect_success 'the default remote . should not break explicit pull' '
 	test `cat file` = modified
 '
 
+test_expect_success '--rebase' '
+	git branch to-rebase &&
+	echo modified again > file &&
+	git commit -m file file &&
+	git checkout to-rebase &&
+	echo new > file2 &&
+	git add file2 &&
+	git commit -m "new file" &&
+	git tag before-rebase &&
+	git pull --rebase . copy &&
+	test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
+	test new = $(git show HEAD:file2)
+'
+
+test_expect_success 'branch.to-rebase.rebase' '
+	git reset --hard before-rebase &&
+	git config branch.to-rebase.rebase 1 &&
+	git pull . copy &&
+	test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
+	test new = $(git show HEAD:file2)
+'
+
 test_done
-- 
1.5.3.4.1351.gee906
