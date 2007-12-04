From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Do not rely on the exit status of "unset" for unset variables
Date: Tue, 4 Dec 2007 22:45:16 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712042242310.27959@racer.site>
References: <20071204130922.731c407a@pc09.procura.nl>
 <Pine.LNX.4.64.0712041343040.27959@racer.site> <20071204140326.14d9e7a0@pc09.procura.nl>
 <Pine.LNX.4.64.0712041439590.27959@racer.site> <20071204150102.7f3ec3e9@pc09.procura.nl>
 <47556EE2.6040105@op5.se> <20071204152240.6cb6018e@pc09.procura.nl>
 <Pine.LNX.4.64.0712041536180.27959@racer.site> <20071204155655.053f4fb4@pc09.procura.nl>
 <7vve7e49or.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 23:46:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzgWk-0002Va-Ih
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 23:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbXLDWpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 17:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbXLDWpo
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 17:45:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:35523 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751750AbXLDWpn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 17:45:43 -0500
Received: (qmail invoked by alias); 04 Dec 2007 22:45:41 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp051) with SMTP; 04 Dec 2007 23:45:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Elop8OLWEYhZcXRV04C+VgoS/fddxIiUiGxZtdR
	Xt4VvqK4l/wqM6
X-X-Sender: gene099@racer.site
In-Reply-To: <7vve7e49or.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67095>


From: H.Merijn Brand <h.m.brand@xs4all.nl>

POSIX says that exit status "0" means that "unset" successfully unset
the variable.  However, it is kind of ambiguous if an environment
variable which was not set could be successfully unset.

At least the default shell on HP-UX insists on reporting an error in
such a case, so just ignore the exit status of "unset".

[Dscho: extended the patch to git-submodule.sh, as Junio realized that
 this is the only other place where we check the exit status of "unset".]

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Tue, 4 Dec 2007, Junio C Hamano wrote:

	> "H.Merijn Brand" <h.m.brand@xs4all.nl> writes:
	> 
	> > On Tue, 4 Dec 2007 15:39:47 +0000 (GMT), Johannes Schindelin
	> > ...
	> > I found it! unset returns false
	> > ...
	> > I must leave now.
	> 
	> Thanks, you two.
	> 
	> I do not see "unset VAR... &&" outside t0001 test, but there are
	> instances of "unset VAR... &&" in git-submodule implementations 
	> as well.
	> 
	> In short, not too many places to fix.

	You're right.  I grepped for "unset" in t/*.sh, but that catches 
	only false positives other than t0001.

	Merijn, maybe you want to have your sign-off in the commit 
	message?

 git-submodule.sh |   10 +++++-----
 t/t0001-init.sh  |   16 ++++++++--------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 82ac28f..ad9fe62 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -158,7 +158,7 @@ module_add()
 	die "'$path' already exists in the index"
 
 	module_clone "$path" "$realrepo" || exit
-	(unset GIT_DIR && cd "$path" && git checkout -q ${branch:+-b "$branch" "origin/$branch"}) ||
+	(unset GIT_DIR; cd "$path" && git checkout -q ${branch:+-b "$branch" "origin/$branch"}) ||
 	die "Unable to checkout submodule '$path'"
 	git add "$path" ||
 	die "Failed to add submodule '$path'"
@@ -228,14 +228,14 @@ modules_update()
 			module_clone "$path" "$url" || exit
 			subsha1=
 		else
-			subsha1=$(unset GIT_DIR && cd "$path" &&
+			subsha1=$(unset GIT_DIR; cd "$path" &&
 				git rev-parse --verify HEAD) ||
 			die "Unable to find current revision in submodule path '$path'"
 		fi
 
 		if test "$subsha1" != "$sha1"
 		then
-			(unset GIT_DIR && cd "$path" && git-fetch &&
+			(unset GIT_DIR; cd "$path" && git-fetch &&
 				git-checkout -q "$sha1") ||
 			die "Unable to checkout '$sha1' in submodule path '$path'"
 
@@ -246,7 +246,7 @@ modules_update()
 
 set_name_rev () {
 	revname=$( (
-		unset GIT_DIR &&
+		unset GIT_DIR
 		cd "$1" && {
 			git describe "$2" 2>/dev/null ||
 			git describe --tags "$2" 2>/dev/null ||
@@ -285,7 +285,7 @@ modules_list()
 		else
 			if test -z "$cached"
 			then
-				sha1=$(unset GIT_DIR && cd "$path" && git rev-parse --verify HEAD)
+				sha1=$(unset GIT_DIR; cd "$path" && git rev-parse --verify HEAD)
 				set_name_rev "$path" "$sha1"
 			fi
 			say "+$sha1 $path$revname"
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index b14b3ec..c015405 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -25,7 +25,7 @@ check_config () {
 
 test_expect_success 'plain' '
 	(
-		unset GIT_DIR GIT_WORK_TREE &&
+		unset GIT_DIR GIT_WORK_TREE
 		mkdir plain &&
 		cd plain &&
 		git init
@@ -35,7 +35,7 @@ test_expect_success 'plain' '
 
 test_expect_success 'plain with GIT_WORK_TREE' '
 	if (
-		unset GIT_DIR &&
+		unset GIT_DIR
 		mkdir plain-wt &&
 		cd plain-wt &&
 		GIT_WORK_TREE=$(pwd) git init
@@ -48,7 +48,7 @@ test_expect_success 'plain with GIT_WORK_TREE' '
 
 test_expect_success 'plain bare' '
 	(
-		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG &&
+		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG
 		mkdir plain-bare-1 &&
 		cd plain-bare-1 &&
 		git --bare init
@@ -58,7 +58,7 @@ test_expect_success 'plain bare' '
 
 test_expect_success 'plain bare with GIT_WORK_TREE' '
 	if (
-		unset GIT_DIR GIT_CONFIG &&
+		unset GIT_DIR GIT_CONFIG
 		mkdir plain-bare-2 &&
 		cd plain-bare-2 &&
 		GIT_WORK_TREE=$(pwd) git --bare init
@@ -72,7 +72,7 @@ test_expect_success 'plain bare with GIT_WORK_TREE' '
 test_expect_success 'GIT_DIR bare' '
 
 	(
-		unset GIT_CONFIG &&
+		unset GIT_CONFIG
 		mkdir git-dir-bare.git &&
 		GIT_DIR=git-dir-bare.git git init
 	) &&
@@ -82,7 +82,7 @@ test_expect_success 'GIT_DIR bare' '
 test_expect_success 'GIT_DIR non-bare' '
 
 	(
-		unset GIT_CONFIG &&
+		unset GIT_CONFIG
 		mkdir non-bare &&
 		cd non-bare &&
 		GIT_DIR=.git git init
@@ -93,7 +93,7 @@ test_expect_success 'GIT_DIR non-bare' '
 test_expect_success 'GIT_DIR & GIT_WORK_TREE (1)' '
 
 	(
-		unset GIT_CONFIG &&
+		unset GIT_CONFIG
 		mkdir git-dir-wt-1.git &&
 		GIT_WORK_TREE=$(pwd) GIT_DIR=git-dir-wt-1.git git init
 	) &&
@@ -103,7 +103,7 @@ test_expect_success 'GIT_DIR & GIT_WORK_TREE (1)' '
 test_expect_success 'GIT_DIR & GIT_WORK_TREE (2)' '
 
 	if (
-		unset GIT_CONFIG &&
+		unset GIT_CONFIG
 		mkdir git-dir-wt-2.git &&
 		GIT_WORK_TREE=$(pwd) GIT_DIR=git-dir-wt-2.git git --bare init
 	)
-- 
1.5.3.7.2139.g2a5a3
