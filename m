From: Bryan Donlan <bdonlan@fushizen.net>
Subject: [PATCH] Silence cpio's "N blocks" output when cloning locally
Date: Fri, 28 Mar 2008 02:19:46 -0400
Message-ID: <1206685186-10352-1-git-send-email-bdonlan@fushizen.net>
Cc: gitster@pobox.com, Bryan Donlan <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 07:29:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jf85J-0000wE-TU
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 07:29:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330AbYC1G2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 02:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754107AbYC1G2W
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 02:28:22 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:40264 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753813AbYC1G2V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 02:28:21 -0400
X-Greylist: delayed 511 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Mar 2008 02:28:21 EDT
Received: from bryan-donlan.um.maine.edu ([130.111.184.216] helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bd@fushizen.net>)
	id 1Jf7wG-0006n2-3K; Fri, 28 Mar 2008 06:19:44 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bd@shion.is.fushizen.net>)
	id 1Jf7wI-0002hI-9h; Fri, 28 Mar 2008 02:19:46 -0400
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <>
References: <>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78388>

Pass --quiet to cpio in git-clone to hide the (confusing) "0 blocks" message.
For compatibility with operating systems which might not support GNUisms,
the presence of --quiet is probed for by grepping cpio's --help output.

Signed-off-by: Bryan Donlan <bdonlan@fushizen.net>
---
 git-clone.sh |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index e981122..2636159 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -310,6 +310,9 @@ yes)
 		mkdir -p "$GIT_DIR/objects/info"
 		echo "$repo/objects" >>"$GIT_DIR/objects/info/alternates"
 	else
+		cpio_quiet_flag=""
+		cpio --help 2>&1 | grep -- --quiet >/dev/null && \
+			cpio_quiet_flag=--quiet
 		l= &&
 		if test "$use_local_hardlink" = yes
 		then
@@ -330,7 +333,8 @@ yes)
 			fi
 		fi &&
 		cd "$repo" &&
-		find objects -depth -print | cpio -pumd$l "$GIT_DIR/" || exit 1
+		find objects -depth -print | cpio $cpio_quiet_flag -pumd$l "$GIT_DIR/" || \
+			exit 1
 	fi
 	git-ls-remote "$repo" >"$GIT_DIR/CLONE_HEAD" || exit 1
 	;;
-- 
1.5.4.3
