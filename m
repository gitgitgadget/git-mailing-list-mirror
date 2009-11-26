From: Avery Pennarun <apenwarr@gmail.com>
Subject: [PATCH 5/8] Teach git-pull to pass -X<option> to git-merge
Date: Wed, 25 Nov 2009 21:23:57 -0500
Message-ID: <1ff0b2f7e3fae4cc6c7610c92711f33df9a3d07c.1259201377.git.apenwarr@gmail.com>
References: <cover.1259201377.git.apenwarr@gmail.com>
 <d243a513ffb8da4272f7a0e13a711f9b65195c25.1259201377.git.apenwarr@gmail.com>
 <905749faf5ccb2c7c54d3318dbc662d69daf8d0e.1259201377.git.apenwarr@gmail.com>
 <7e1f1179fc5fe2f568e2c75f75366fa40d7bbbfb.1259201377.git.apenwarr@gmail.com>
 <73a42e99b4a083c74b017caf2970d1bbf5886b96.1259201377.git.apenwarr@gmail.com>
Cc: gitster@pobox.com, Avery Pennarun <apenwarr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 26 03:43:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDUKM-0004ry-Ha
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 03:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756912AbZKZCmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 21:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754061AbZKZCmv
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 21:42:51 -0500
Received: from mailhost.pwcorp.com ([216.13.111.70]:4746 "EHLO
	mailhost.pwcorp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754091AbZKZCmg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 21:42:36 -0500
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Nov 2009 21:42:31 EST
Received: from weaver.open.versabanq.com ([10.65.1.2]) by mailhost.pwcorp.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 25 Nov 2009 21:27:30 -0500
Received: (qmail 6586 invoked from network); 26 Nov 2009 02:27:24 -0000
Received: from unknown (HELO weaver.open.versabanq.com) (10.65.1.2)
  by weaver.open.versabanq.com with SMTP; 26 Nov 2009 02:27:24 -0000
Received: (qmail 5748 invoked from network); 26 Nov 2009 02:25:48 -0000
Received: from unknown (HELO weaver.open.versabanq.com) (10.65.1.2)
  by weaver.open.versabanq.com with SMTP; 26 Nov 2009 02:25:48 -0000
Received: (qmail 5664 invoked from network); 26 Nov 2009 02:25:45 -0000
Received: from unknown (HELO weaver.open.versabanq.com) (10.65.1.2)
  by weaver.open.versabanq.com with SMTP; 26 Nov 2009 02:25:45 -0000
Received: (qmail 5620 invoked from network); 26 Nov 2009 02:25:44 -0000
Received: from unknown (HELO weaver.open.versabanq.com) (10.65.1.2)
  by weaver.open.versabanq.com with SMTP; 26 Nov 2009 02:25:44 -0000
Received: (qmail 5584 invoked from network); 26 Nov 2009 02:25:42 -0000
Received: from unknown (HELO harmony.mtl.versabanq.com) (10.65.1.133)
  by weaver.open.versabanq.com with SMTP; 26 Nov 2009 02:25:42 -0000
Received: by harmony.mtl.versabanq.com (sSMTP sendmail emulation); Wed, 25 Nov 2009 21:24:17 -0500
X-Mailer: git-send-email 1.6.6.rc0.62.gaccf
In-Reply-To: <73a42e99b4a083c74b017caf2970d1bbf5886b96.1259201377.git.apenwarr@gmail.com>
In-Reply-To: <cover.1259201377.git.apenwarr@gmail.com>
References: <cover.1259201377.git.apenwarr@gmail.com>
X-OriginalArrivalTime: 26 Nov 2009 02:27:30.0715 (UTC) FILETIME=[00FEEEB0:01CA6E40]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133759>

(Patch originally by Junio Hamano <gitster@pobox.com>.)

Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
---
 git-pull.sh                  |   17 +++++++++++++++--
 t/t6034-merge-ours-theirs.sh |    8 ++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index bfeb4a0..6d961b6 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -18,6 +18,7 @@ test -z "$(git ls-files -u)" ||
 
 strategy_args= diffstat= no_commit= squash= no_ff= ff_only=
 log_arg= verbosity=
+merge_args=
 curr_branch=$(git symbolic-ref -q HEAD)
 curr_branch_short=$(echo "$curr_branch" | sed "s|refs/heads/||")
 rebase=$(git config --bool branch.$curr_branch_short.rebase)
@@ -62,6 +63,18 @@ do
 		esac
 		strategy_args="${strategy_args}-s $strategy "
 		;;
+	-X*)
+		case "$#,$1" in
+		1,-X)
+			usage ;;
+		*,-X)
+			xx="-X $2"
+			shift ;;
+		*,*)
+			xx="$1" ;;
+		esac
+		merge_args="$merge_args$xx "
+		;;
 	-r|--r|--re|--reb|--reba|--rebas|--rebase)
 		rebase=true
 		;;
@@ -216,7 +229,7 @@ fi
 
 merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
 test true = "$rebase" &&
-	exec git-rebase $diffstat $strategy_args --onto $merge_head \
+	exec git-rebase $diffstat $strategy_args $merge_args --onto $merge_head \
 	${oldremoteref:-$merge_head}
-exec git-merge $diffstat $no_commit $squash $no_ff $ff_only $log_arg $strategy_args \
+exec git-merge $diffstat $no_commit $squash $no_ff $ff_only $log_arg $strategy_args $merge_args \
 	"$merge_name" HEAD $merge_head $verbosity
diff --git a/t/t6034-merge-ours-theirs.sh b/t/t6034-merge-ours-theirs.sh
index 08c9f79..8ab3d61 100755
--- a/t/t6034-merge-ours-theirs.sh
+++ b/t/t6034-merge-ours-theirs.sh
@@ -53,4 +53,12 @@ test_expect_success 'recursive favouring ours' '
 	! grep 1 file
 '
 
+test_expect_success 'pull with -X' '
+	git reset --hard master && git pull -s recursive -Xours . side &&
+	git reset --hard master && git pull -s recursive -X ours . side &&
+	git reset --hard master && git pull -s recursive -Xtheirs . side &&
+	git reset --hard master && git pull -s recursive -X theirs . side &&
+	git reset --hard master && ! git pull -s recursive -X bork . side
+'
+
 test_done
-- 
1.6.6.rc0.62.gaccf
