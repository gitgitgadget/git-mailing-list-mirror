From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 7/7] Add an optional limit to git-rebase
Date: Sun, 8 Jan 2006 01:41:20 +0100
Message-ID: <20060108004120.GO1113@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jan 08 01:38:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvOa5-0007mw-Bt
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 01:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161104AbWAHAim (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 19:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161105AbWAHAim
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 19:38:42 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:9104 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1161104AbWAHAim (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 19:38:42 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 4371C17DED
	for <git@vger.kernel.org>; Sun,  8 Jan 2006 01:38:41 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1EvOca-0003TU-Hn
	for git@vger.kernel.org; Sun, 08 Jan 2006 01:41:20 +0100
To: GIT list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14297>

This patch adds a limit to restrict the list of patches to rebase.

This is useful when a set of patches were done against a given head,
but needs to be ported to a different head, as opposed to being ported
to a descendant of the original head.  In such a case we only want to
port our own patches, not those that make the two branches different
upstream.

Signed-off-by: Yann Dirson <ydirson@altern.org>


---

 git-rebase.sh |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

bf833136c7c4cc17e7e45b959b56cda11528c33a
diff --git a/git-rebase.sh b/git-rebase.sh
index 16d4359..06c7e1a 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -3,10 +3,10 @@
 # Copyright (c) 2005 Junio C Hamano.
 #
 
-USAGE='<upstream> [<head>]'
+USAGE='<upstream> [<head>] [<limit>]'
 . git-sh-setup
 
-case $# in 1|2) ;; *) usage ;; esac
+case $# in 1|2|3) ;; *) usage ;; esac
 
 # Make sure we do not have .dotest
 if mkdir .dotest
@@ -36,6 +36,14 @@ other=$(git-rev-parse --verify "$1^0") |
 # Make sure the branch to rebase is valid.
 head=$(git-rev-parse --verify "${2-HEAD}^0") || exit
 
+# Set limit
+case "$#" in
+3)
+	limit=$(git-rev-parse --verify "$3^0") || usage ;;
+*)
+	limit= ;;
+esac
+
 # If the branch to rebase is given, first switch to it.
 case "$#" in
 2)
@@ -62,5 +70,5 @@ then
 	exit 0
 fi
 
-git-format-patch -k --stdout --full-index "$other" ORIG_HEAD |
+git-format-patch -k --stdout --full-index "$other" ORIG_HEAD $limit |
 git am --binary -3 -k
-- 
1.0.6-g8ecb

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
