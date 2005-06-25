From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-merge-one-file-script: do not misinterpret rm failure
Date: Fri, 24 Jun 2005 23:20:33 -0700
Message-ID: <7vpsub555a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 25 08:20:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dm420-0002Mf-CQ
	for gcvg-git@gmane.org; Sat, 25 Jun 2005 08:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263358AbVFYGZ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Jun 2005 02:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263352AbVFYGXp
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jun 2005 02:23:45 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:29621 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S263348AbVFYGUf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2005 02:20:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050625062035.FEPO16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Jun 2005 02:20:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When a merge adds a file DF and removes a directory there by
deleting a path DF/DF, git-merge-one-file-script can be called
for the removal of DF/DF when the path DF is already created by
"git-read-tree -m -u".  When this happens, we get confused by a
failure return from 'rm -f -- "$4"' (where $4 is DF/DF); finding
file DF there the "rm -f" command complains that DF is not a
directory.

What we want to ensure is that there is no file DF/DF in this
case. Avoid getting ourselves confused by first checking if
there is a file, and only then try to remove it (and check for
failure from the "rm" command). 

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
cd /opt/packrat/playpen/public/in-place/git/git.junio/
jit-diff : git-merge-one-file-script
# - master: Add more tests for read-tree --emu23.
# + (working tree)

diff --git a/git-merge-one-file-script b/git-merge-one-file-script
--- a/git-merge-one-file-script
+++ b/git-merge-one-file-script
@@ -22,8 +22,11 @@ case "${1:-.}${2:-.}${3:-.}" in
 #
 "$1.." | "$1.$1" | "$1$1.")
 	echo "Removing $4"
-	rm -f -- "$4" &&
-		exec git-update-cache --remove -- "$4"
+	if test -f "$4"
+	then
+		rm -f -- "$4"
+	fi &&
+	exec git-update-cache --remove -- "$4"
 	;;
 
 #



