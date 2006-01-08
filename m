From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 5/7] Add an optional limit to git-cherry
Date: Sun, 8 Jan 2006 01:40:33 +0100
Message-ID: <20060108004033.GM1113@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jan 08 01:38:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvOZX-0007eK-8H
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 01:38:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161102AbWAHAh5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 19:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161103AbWAHAh4
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 19:37:56 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:4815 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1161102AbWAHAhz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 19:37:55 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id E3F1E17B2E
	for <git@vger.kernel.org>; Sun,  8 Jan 2006 01:37:54 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1EvObq-0003T8-5n
	for git@vger.kernel.org; Sun, 08 Jan 2006 01:40:34 +0100
To: GIT list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14294>

This allows to use another commit than the merge base as a limit for
scanning patches.

Signed-off-by: Yann Dirson <ydirson@altern.org>


---

 git-cherry.sh     |   20 +++++++++++++-------
 t/t3500-cherry.sh |    5 +++++
 2 files changed, 18 insertions(+), 7 deletions(-)

b1e23bf60c069a1f6bd4b8d04afd1fb80005e4ee
diff --git a/git-cherry.sh b/git-cherry.sh
index 5e9bd0c..1a62320 100755
--- a/git-cherry.sh
+++ b/git-cherry.sh
@@ -3,17 +3,17 @@
 # Copyright (c) 2005 Junio C Hamano.
 #
 
-USAGE='[-v] <upstream> [<head>]'
+USAGE='[-v] <upstream> [<head>] [<limit>]'
 LONG_USAGE='             __*__*__*__*__> <upstream>
             /
   fork-point
             \__+__+__+__+__+__+__+__> <head>
 
-Each commit between the fork-point and <head> is examined, and
-compared against the change each commit between the fork-point and
-<upstream> introduces.  If the change seems to be in the upstream,
-it is shown on the standard output with prefix "+".  Otherwise
-it is shown with prefix "-".'
+Each commit between the fork-point (or <limit> if given) and <head> is
+examined, and compared against the change each commit between the
+fork-point and <upstream> introduces.  If the change seems to be in
+the upstream, it is shown on the standard output with prefix "+".
+Otherwise it is shown with prefix "-".'
 . git-sh-setup
 
 case "$1" in -v) verbose=t; shift ;; esac 
@@ -28,9 +28,15 @@ esac
 case "$#" in
 1) upstream=`git-rev-parse --verify "$1"` &&
    ours=`git-rev-parse --verify HEAD` || exit
+   limit="$upstream"
    ;;
 2) upstream=`git-rev-parse --verify "$1"` &&
    ours=`git-rev-parse --verify "$2"` || exit
+   limit="$upstream"
+   ;;
+3) upstream=`git-rev-parse --verify "$1"` &&
+   ours=`git-rev-parse --verify "$2"` &&
+   limit=`git-rev-parse --verify "$3"` || exit
    ;;
 *) usage ;;
 esac
@@ -38,7 +44,7 @@ esac
 # Note that these list commits in reverse order;
 # not that the order in inup matters...
 inup=`git-rev-list ^$ours $upstream` &&
-ours=`git-rev-list $ours ^$upstream` || exit
+ours=`git-rev-list $ours ^$limit` || exit
 
 tmp=.cherry-tmp$$
 patch=$tmp-patch
diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
index f2f9109..7b81377 100755
--- a/t/t3500-cherry.sh
+++ b/t/t3500-cherry.sh
@@ -38,6 +38,11 @@ test_expect_success \
 '
 
 test_expect_success \
+    'check that cherry with limit returns only the top patch'\
+    'expr "$(echo $(git-cherry master my-topic-branch my-topic-branch^1) )" : "+ [^ ]*"
+'
+
+test_expect_success \
     'cherry-pick one of the 2 patches, and check cherry recognized one and only one as new' \
     'git-cherry-pick my-topic-branch^0 &&
      echo $(git-cherry master my-topic-branch) &&
-- 
1.0.6-g8ecb

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
