From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] bisect: allow starting with a detached HEAD
Date: Sun, 10 Feb 2008 13:59:50 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802101358440.11591@racer.site>
References: <3f4fd2640802100301y436bda41kcca1b1eb8ec0ea10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git <git@vger.kernel.org>, gitster@pobox.com
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 15:01:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOCk6-0006Qx-PT
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 15:01:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbYBJN7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 08:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbYBJN7u
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 08:59:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:58399 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751924AbYBJN7t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 08:59:49 -0500
Received: (qmail invoked by alias); 10 Feb 2008 13:59:47 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp006) with SMTP; 10 Feb 2008 14:59:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+5q5xbjnW5+528SIZBplZ+rFhwARr3qfwh0HyZOP
	nA9YFTACrDAvyV
X-X-Sender: gene099@racer.site
In-Reply-To: <3f4fd2640802100301y436bda41kcca1b1eb8ec0ea10@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73356>


Instead of insisting on a symbolic ref, bisect now accepts detached
HEADs, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Sun, 10 Feb 2008, Reece Dunn wrote:

	> When hunting bugs with the wine source code
	> (git://source.winehq.org/git/wine.git), both Dan Kegel and I have
	> found the following berhaviour with git bisect:
	> 
	> $ git checkout wine-0.9.54
	> HEAD is now at 8f954cc... Release 0.9.54.
	> $ git bisect start
	> fatal: ref HEAD is not a symbolic ref
	> Bad HEAD - I need a symbolic ref

	Woohoo!  test_expect_failure is nice... it tells you about
	a fixed behaviour, too!

	(Of course, I changed it to test_expect_success now...)

 git-bisect.sh               |    8 ++++++--
 t/t6030-bisect-porcelain.sh |   12 ++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 5385249..393fa35 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -26,6 +26,9 @@ OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree
 
+_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
+_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
+
 sq() {
 	@@PERL@@ -e '
 		for (@ARGV) {
@@ -60,7 +63,8 @@ bisect_start() {
 	# top-of-line master first!
 	#
 	head=$(GIT_DIR="$GIT_DIR" git symbolic-ref HEAD) ||
-	die "Bad HEAD - I need a symbolic ref"
+	head=$(GIT_DIR="$GIT_DIR" git rev-parse --verify HEAD) ||
+	die "Bad HEAD - I need a HEAD"
 	case "$head" in
 	refs/heads/bisect)
 		if [ -s "$GIT_DIR/head-name" ]; then
@@ -70,7 +74,7 @@ bisect_start() {
 		fi
 		git checkout $branch || exit
 		;;
-	refs/heads/*)
+	refs/heads/*|$_x40)
 		[ -s "$GIT_DIR/head-name" ] && die "won't bisect on seeked tree"
 		echo "${head#refs/heads/}" >"$GIT_DIR/head-name"
 		;;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 2ba4b00..ec71123 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -254,6 +254,18 @@ test_expect_success 'bisect run & skip: find first bad' '
 	grep "$HASH6 is first bad commit" my_bisect_log.txt
 '
 
+test_expect_success 'bisect starting with a detached HEAD' '
+
+	git bisect reset &&
+	git checkout master^ &&
+	HEAD=$(git rev-parse --verify HEAD) &&
+	git bisect start &&
+	test $HEAD = $(cat .git/head-name) &&
+	git bisect reset &&
+	test $HEAD = $(git rev-parse --verify HEAD)
+
+'
+
 #
 #
 test_done
-- 
1.5.4.1264.gb53928
