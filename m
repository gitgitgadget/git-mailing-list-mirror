From: Simon Sasburg <simon.sasburg@gmail.com>
Subject: [PATCH 2/3] Implement --dirty for git-rebase--interactive.
Date: Thu,  1 Nov 2007 22:30:23 +0100
Message-ID: <1193952624-608-3-git-send-email-Simon.Sasburg@gmail.com>
References: <1193952624-608-1-git-send-email-Simon.Sasburg@gmail.com>
 <1193952624-608-2-git-send-email-Simon.Sasburg@gmail.com>
Cc: git@vger.kernel.org, Simon Sasburg <Simon.Sasburg@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 01 22:33:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InhfA-0001oX-M1
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 22:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924AbXKAVcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 17:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753821AbXKAVcn
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 17:32:43 -0400
Received: from hu-out-0506.google.com ([72.14.214.236]:16289 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621AbXKAVcm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 17:32:42 -0400
Received: by hu-out-0506.google.com with SMTP id 19so265852hue
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 14:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        bh=fgbdYIjiSEYEZoGBLi859vQJhpf8ssZrf0eiySFZ2nw=;
        b=fUV94rZo8QCTiaoUJ3cUwflA+n7oDyLvvKwX88f/QgPw1JvYRB6N+VC5kwcBtxsPxQ1H5lgt/L6tTW5UXDo8nD8QQPOEZPqAli5usX1IsmEei1ajY8SE/rGcaM4iWtv0BOle5okY4DaayUPLERyF2b6HYfQuLwDB9YBWtmROr4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=R4vh0+wTNaeUSK36cP6h2B358wCf4ePplstjFca9hDPsDtnHnCNYjuFLOn8/oxQ/o5MK3Ud3UmYcHUCYjZxX+2TF+sYe989E+meU8qPug0NRoDOybkkYTiOCjr3EXtWVq2zWlWvTV/nMJSIF+N3iZTM4wphTNqWKpTSnjBzCayA=
Received: by 10.82.175.17 with SMTP id x17mr2201359bue.1193952759585;
        Thu, 01 Nov 2007 14:32:39 -0700 (PDT)
Received: from localhost ( [86.85.232.104])
        by mx.google.com with ESMTPS id f3sm2302439nfh.2007.11.01.14.32.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2007 14:32:38 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.503.gbcee6f4
In-Reply-To: <1193952624-608-2-git-send-email-Simon.Sasburg@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63008>

Signed-off-by: Simon Sasburg <Simon.Sasburg@gmail.com>
---
 git-rebase--interactive.sh |   42 ++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 76dc679..326076b 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -25,6 +25,7 @@ REWRITTEN="$DOTEST"/rewritten
 PRESERVE_MERGES=
 STRATEGY=
 VERBOSE=
+FIX_DIRTY=
 test -d "$REWRITTEN" && PRESERVE_MERGES=t
 test -f "$DOTEST"/strategy && STRATEGY="$(cat "$DOTEST"/strategy)"
 test -f "$DOTEST"/verbose && VERBOSE=t
@@ -56,6 +57,35 @@ require_clean_work_tree () {
 	die "Working tree is dirty"
 }
 
+store_dirty_state () {
+	echo "Storing dirty index/working tree"
+	diff=$(git diff --cached)
+	case "$diff" in
+	?*)	git commit -m "REBASE--dirty: store HEAD..index diff"
+		;;
+	esac
+	diff=$(git diff)
+	case "$diff" in
+	?*)	git commit -a -m "REBASE--dirty: store index..workingtree diff"
+		;;
+	esac
+}
+
+restore_dirty_state () {
+	lastmsg=$(git-rev-list HEAD^..HEAD --pretty=oneline | sed "s:[^ ]* ::")
+	if test "$lastmsg" = "REBASE--dirty: store index..workingtree diff"
+	then
+		echo "Restoring dirty index state"
+		git reset --mixed HEAD^
+	fi
+	lastmsg=$(git-rev-list HEAD^..HEAD --pretty=oneline | sed "s:[^ ]* ::")
+	if test "$lastmsg" = "REBASE--dirty: store HEAD..index diff"
+	then
+		echo "Restoring dirty working dir state"
+		git reset --soft HEAD^
+	fi
+}
+
 ORIG_REFLOG_ACTION="$GIT_REFLOG_ACTION"
 
 comment_for_reflog () {
@@ -329,6 +359,7 @@ do_next () {
 		test ! -f "$DOTEST"/verbose ||
 			git diff-tree --stat $(cat "$DOTEST"/head)..HEAD
 	} &&
+	restore_dirty_state &&
 	rm -rf "$DOTEST" &&
 	git gc --auto &&
 	warn "Successfully rebased and updated $HEADNAME."
@@ -378,6 +409,7 @@ do
 			;;
 		esac &&
 		output git reset --hard $HEAD &&
+		restore_dirty_state &&
 		rm -rf "$DOTEST"
 		exit
 		;;
@@ -417,6 +449,9 @@ do
 	''|-h)
 		usage
 		;;
+	--dirty)
+		FIX_DIRTY=t
+		;;
 	*)
 		test -d "$DOTEST" &&
 			die "Interactive rebase already started"
@@ -435,7 +470,7 @@ do
 			;;
 		esac
 
-		require_clean_work_tree
+		test "$FIX_DIRTY" = "t" || require_clean_work_tree
 
 		if test ! -z "$2"
 		then
@@ -445,9 +480,12 @@ do
 				die "Could not checkout $2"
 		fi
 
-		HEAD=$(git rev-parse --verify HEAD) || die "No HEAD?"
 		UPSTREAM=$(git rev-parse --verify "$1") || die "Invalid base"
 
+		test "$FIX_DIRTY" = "t" && store_dirty_state
+
+		HEAD=$(git rev-parse --verify HEAD) || die "No HEAD?"
+
 		mkdir "$DOTEST" || die "Could not create temporary $DOTEST"
 
 		test -z "$ONTO" && ONTO=$UPSTREAM
-- 
1.5.3.4.502.g37c97
