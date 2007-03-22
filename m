From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: [BUG, PATCH] bisect and tags
Date: Thu, 22 Mar 2007 17:18:08 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070322161808.GA18791@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 22 17:18:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUPzi-0008HD-9M
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 17:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934090AbXCVQSQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 22 Mar 2007 12:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934004AbXCVQSP
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 12:18:15 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:49930 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934094AbXCVQSM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2007 12:18:12 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HUPzO-0000Id-Qo
	for git@vger.kernel.org; Thu, 22 Mar 2007 17:18:11 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l2MGI8tN020315
	for <git@vger.kernel.org>; Thu, 22 Mar 2007 17:18:08 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l2MGI8Ph020314
	for git@vger.kernel.org; Thu, 22 Mar 2007 17:18:08 +0100 (MET)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.14+cvs20070315 (2007-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42863>

Hello,

zeisberg@cassiopeia:~/gsrc/test$ git init
Initialized empty Git repository in .git/
zeisberg@cassiopeia:~/gsrc/test$ echo 0 > 0
zeisberg@cassiopeia:~/gsrc/test$ git add 0
zeisberg@cassiopeia:~/gsrc/test$ git commit -m 0
Created initial commit fa8382e1b0a75f2abd5b8961ba88caa65e6e0ddc
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 0
zeisberg@cassiopeia:~/gsrc/test$ echo 1 > 1
zeisberg@cassiopeia:~/gsrc/test$ git add 1
zeisberg@cassiopeia:~/gsrc/test$ git commit -m 1
Created commit bf00881b13efd325f87899f0fd072566629aedb0
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 1
zeisberg@cassiopeia:~/gsrc/test$ git tag -m tag tag
zeisberg@cassiopeia:~/gsrc/test$ git bisect start
zeisberg@cassiopeia:~/gsrc/test$ git bisect good HEAD^
zeisberg@cassiopeia:~/gsrc/test$ git bisect bad tag
Bisecting: 1 revisions left to test after this
[bf00881b13efd325f87899f0fd072566629aedb0] 1

Actually the case is already clear here.  But bisect fails to detect
that because it doesn't see that tag^{commit} is bad, only tag itself.

--- 8< ---
Bisect: convert revs given to good and bad to commits

Without this the rev could be (e.g.) a tag and then the condition to en=
d the
bisect might fail and you have to check the already known to be bad rev=
ision
once more.

Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de>
---
 git-bisect.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index b1c3a6b..dbce0df 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -85,7 +85,7 @@ bisect_bad() {
 	0)
 		rev=3D$(git-rev-parse --verify HEAD) ;;
 	1)
-		rev=3D$(git-rev-parse --verify "$1") ;;
+		rev=3D$(git-rev-parse --verify "$1^{commit}") ;;
 	*)
 		usage ;;
 	esac || exit
@@ -104,7 +104,7 @@ bisect_good() {
 	esac
 	for rev in $revs
 	do
-		rev=3D$(git-rev-parse --verify "$rev") || exit
+		rev=3D$(git-rev-parse --verify "$rev^{commit}") || exit
 		echo "$rev" >"$GIT_DIR/refs/bisect/good-$rev"
 		echo "# good: "$(git-show-branch $rev) >>"$GIT_DIR/BISECT_LOG"
 		echo "git-bisect good $rev" >>"$GIT_DIR/BISECT_LOG"
--=20
1.5.1.rc1.27.g1d848

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D1+newton+in+kg*m+%2F+s%5E2
