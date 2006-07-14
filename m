From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH 2/2] Record rebase changes as 'rebase' in the reflog.
Date: Fri, 14 Jul 2006 00:47:23 -0400
Message-ID: <20060714044723.GB1982@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jul 14 06:47:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1FaU-0007mO-IU
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 06:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161261AbWGNEr2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 00:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161263AbWGNEr1
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 00:47:27 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56762 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1161261AbWGNEr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jul 2006 00:47:27 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G1FaH-0001of-Vp
	for git@vger.kernel.org; Fri, 14 Jul 2006 00:47:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E7D1F20E462; Fri, 14 Jul 2006 00:47:23 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23871>


Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-am.sh     |    6 +++++-
 git-rebase.sh |    9 ++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index db9a20a..3a129e0 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -91,6 +91,7 @@ fall_back_3way () {
 }
 
 prec=4
+rloga=am
 dotest=.dotest sign= utf8= keep= skip= interactive= resolved= binary= ws= resolvemsg=
 
 while case "$#" in 0) break;; esac
@@ -130,6 +131,9 @@ do
 	--resolvemsg=*)
 	resolvemsg=$(echo "$1" | sed -e "s/^--resolvemsg=//"); shift ;;
 
+	--reflog-action=*)
+	rloga=`expr "z$1" : 'z-[^=]*=\(.*\)'`; shift ;;
+
 	--)
 	shift; break ;;
 	-*)
@@ -413,7 +417,7 @@ do
 	parent=$(git-rev-parse --verify HEAD) &&
 	commit=$(git-commit-tree $tree -p $parent <"$dotest/final-commit") &&
 	echo Committed: $commit &&
-	git-update-ref -m "am: $SUBJECT" HEAD $commit $parent ||
+	git-update-ref -m "$rloga: $SUBJECT" HEAD $commit $parent ||
 	stop_here $this
 
 	if test -x "$GIT_DIR"/hooks/post-applypatch
diff --git a/git-rebase.sh b/git-rebase.sh
index 6d06665..14d7ed9 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -131,7 +131,8 @@ do
 			finish_rb_merge
 			exit
 		fi
-		git-am --resolved --3way --resolvemsg="$RESOLVEMSG"
+		git-am --resolved --3way --resolvemsg="$RESOLVEMSG" \
+			--reflog-action=rebase
 		exit
 		;;
 	--skip)
@@ -150,7 +151,8 @@ do
 			finish_rb_merge
 			exit
 		fi
-		git-am -3 --skip --resolvemsg="$RESOLVEMSG"
+		git-am -3 --skip --resolvemsg="$RESOLVEMSG" \
+			--reflog-action=rebase
 		exit
 		;;
 	--abort)
@@ -288,7 +290,8 @@ fi
 if test -z "$do_merge"
 then
 	git-format-patch -k --stdout --full-index "$upstream"..ORIG_HEAD |
-	git-am --binary -3 -k --resolvemsg="$RESOLVEMSG"
+	git-am --binary -3 -k --resolvemsg="$RESOLVEMSG" \
+		--reflog-action=rebase
 	exit $?
 fi
 
-- 
1.4.1.gd3d5
