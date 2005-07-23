From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-clone-script: store where we cloned from in .git/branches/origin
Date: Fri, 22 Jul 2005 19:11:22 -0700
Message-ID: <7v64v26zlh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 04:11:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw9UH-0008RY-Oq
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 04:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbVGWCL1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 22:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbVGWCL1
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 22:11:27 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:41183 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262281AbVGWCLY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 22:11:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050723021123.UOSL17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Jul 2005 22:11:23 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

A bit more usability enhancement, while retaining Cogito
compatibility.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
*** Just after sending I noticed that the first hunk is a pure
*** bugfix.  Hope you do not mind...

 git-clone-script |   41 +++++++++++++++++++++++------------------
 1 files changed, 23 insertions(+), 18 deletions(-)

170214e3ccecc995e4f5c2567f9542a8de8cfc65
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
