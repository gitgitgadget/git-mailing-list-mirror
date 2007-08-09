From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-merge: do up-to-date check also for strategies ours, subtree.
Date: Thu, 9 Aug 2007 12:08:31 +0000
Message-ID: <20070809120831.19319.qmail@a61af064a2a242.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 14:08:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ6oN-00010G-II
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 14:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759279AbXHIMIP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 08:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756201AbXHIMIP
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 08:08:15 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:54583 "HELO a.mx.smarden.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with SMTP
	id S1751251AbXHIMIN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 08:08:13 -0400
Received: (qmail 19320 invoked by uid 1000); 9 Aug 2007 12:08:31 -0000
Mail-Followup-To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55443>

If called with one argument, check also for no_trivial_merge_strategies
whether all the merge can already be reached by HEAD.  Otherwise git-merge
creates an unnecessary commit, e.g.:

 $ (git init && touch foo && git add foo && git commit -m foo) >/dev/null
 $ git merge -s ours master
 Merge made by ours.
 $ git log --pretty=oneline
 d941346f022b7cb70c51d8122de4ae82657ae943 Merge branch 'master'
 68a1d32229917d5d1f4c8f64096d1abde84e9f6b foo
 $

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 git-merge.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 5ccf282..e90f62a 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -287,9 +287,6 @@ esac
 echo "$head" >"$GIT_DIR/ORIG_HEAD"
 
 case "$index_merge,$#,$common,$no_commit" in
-f,*)
-	# We've been told not to try anything clever.  Skip to real merge.
-	;;
 ?,*,'',*)
 	# No common ancestors found. We need a real merge.
 	;;
@@ -299,6 +296,9 @@ f,*)
 	finish_up_to_date "Already up-to-date."
 	exit 0
 	;;
+f,*)
+	# We've been told not to try anything clever.  Skip to real merge.
+	;;
 ?,1,"$head",*)
 	# Again the most common case of merging one remote.
 	echo "Updating $(git rev-parse --short $head)..$(git rev-parse --short $1)"
-- 
debian.1.5.3_rc4.1-dirty
