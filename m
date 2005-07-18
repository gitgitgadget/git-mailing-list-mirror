From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-clone-script: store where we cloned from in .git/branches/origin
Date: Mon, 18 Jul 2005 10:28:50 -0700
Message-ID: <7v1x5wt44t.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vbr55kgq2.fsf@assigned-by-dhcp.cox.net>
	<7vzmsots7t.fsf@assigned-by-dhcp.cox.net>
	<7voe93rbmu.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507151529590.19183@g5.osdl.org>
	<7virzbnruf.fsf_-_@assigned-by-dhcp.cox.net>
	<7vek9yn1f5.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507161032410.19183@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 19:29:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuZQH-0006kf-Fv
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 19:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVGRR2x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jul 2005 13:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVGRR2x
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jul 2005 13:28:53 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:43465 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261155AbVGRR2w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2005 13:28:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050718172850.CWQJ16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 18 Jul 2005 13:28:50 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507161032410.19183@g5.osdl.org> (Linus Torvalds's message of "Sat, 16 Jul 2005 10:33:30 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

A bit more usability enhancement related to the recent URL
short-hand support in .git/branches, while retaining Cogito
compatibility.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 git-clone-script |   41 +++++++++++++++++++++++------------------
 1 files changed, 23 insertions(+), 18 deletions(-)

cb70e0d83c336e0fc3485b6c823b948c07d15a12
diff --git a/git-clone-script b/git-clone-script
--- a/git-clone-script
+++ b/git-clone-script
@@ -20,12 +20,12 @@ upload_pack=
 while
 	case "$#,$1" in
 	0,*) break ;;
-        *,-l|*,--l|*,--lo|*,--loc|*,--loca|*,--local) use_local=yes ;;
+	*,-l|*,--l|*,--lo|*,--loc|*,--loca|*,--local) use_local=yes ;;
 	*,-q|*,--quiet) quiet=-q ;;
-	1,-u|*,--upload-pack) usage ;;
+	1,-u|1,--upload-pack) usage ;;
 	*,-u|*,--upload-pack)
 		shift
-		upload_pack="--exec=$2" ;;
+		upload_pack="--exec=$1" ;;
 	*,-*) usage ;;
 	*) break ;;
 	esac
@@ -81,23 +81,28 @@ yes,yes)
 		HEAD=HEAD
 	fi
 	tar Ccf "$repo" - refs $HEAD | tar Cxf "$D/.git" - || exit 1
-	exit 0
-	;;
-esac
-
-case "$repo" in
-rsync://*)
-	rsync $quiet -avz --ignore-existing "$repo/objects/" "$D/.git/objects/" &&
-	rsync $quiet -avz --ignore-existing "$repo/refs/" "$D/.git/refs/"
-	;;
-http://*)
-	echo "Somebody should add http fetch" >&2
-	exit 1
 	;;
 *)
-	cd "$D" && case "$upload_pack" in
-	'') git-clone-pack $quiet "$repo" ;;
-	*) git-clone-pack $quiet "$upload_pack" "$repo" ;;
+	case "$repo" in
+	rsync://*)
+		rsync $quiet -avz --ignore-existing "$repo/objects/" "$D/.git/objects/" &&
+		rsync $quiet -avz --ignore-existing "$repo/refs/" "$D/.git/refs/"
+		;;
+	http://*)
+		echo "Somebody should add http fetch" >&2
+		exit 1
+		;;
+	*)
+		cd "$D" && case "$upload_pack" in
+		'') git-clone-pack $quiet "$repo" ;;
+		*) git-clone-pack $quiet "$upload_pack" "$repo" ;;
+		esac
+		;;
 	esac
 	;;
 esac
+
+# Update origin.
+mkdir -p "$D/.git/branches/" &&
+rm -f "$D/.git/branches/origin" &&
+echo "$repo" >"$D/.git/branches/origin"
