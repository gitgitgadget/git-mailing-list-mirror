From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 2/5] git-submodule: remember to checkout after clone
Date: Mon, 11 Jun 2007 21:12:22 +0200
Message-ID: <1181589146478-git-send-email-hjemli@gmail.com>
References: <11815891453464-git-send-email-hjemli@gmail.com>
 <11815891451258-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 21:10:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxpHJ-0007ab-Dd
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 21:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbXFKTKB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 15:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752484AbXFKTKB
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 15:10:01 -0400
Received: from mail49.e.nsc.no ([193.213.115.49]:40954 "EHLO mail49.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093AbXFKTJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 15:09:59 -0400
Received: from localhost.localdomain (ti231210a341-2365.bb.online.no [85.166.53.63])
	by mail49.nsc.no (8.13.8/8.13.5) with ESMTP id l5BJ9pBR025419;
	Mon, 11 Jun 2007 21:09:51 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.1.914.gbd3a7
In-Reply-To: <11815891451258-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49872>

After the initial clone of a submodule, no files would be checked out in
the submodule directory if the submodule HEAD was equal to the SHA-1
specified in the index of the containing repository. This fixes the problem
by simply ignoring submodule HEAD for a fresh clone.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 git-submodule.sh |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 8bdd99a..4a6d64d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -100,12 +100,13 @@ modules_update()
 		if ! test -d "$path"/.git
 		then
 			module_clone "$path" "$url" || exit
+			subsha1=
+		else
+			subsha1=$(unset GIT_DIR && cd "$path" &&
+				git-rev-parse --verify HEAD) ||
+			die "Unable to find current revision of submodule '$path'"
 		fi
 
-		subsha1=$(unset GIT_DIR && cd "$path" &&
-			git-rev-parse --verify HEAD) ||
-		die "Unable to find current revision of submodule '$path'"
-
 		if test "$subsha1" != "$sha1"
 		then
 			(unset GIT_DIR && cd "$path" && git-fetch &&
-- 
1.5.2.1.914.gbd3a7
