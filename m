From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 6/9] git-merge-one-file-script: do not misinterpret rm
 failure.
Date: Sat, 25 Jun 2005 02:24:50 -0700
Message-ID: <7vll4y3i1p.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vaclgfynv.fsf@assigned-by-dhcp.cox.net>
	<7vvf439vdl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506241755280.11175@ppc970.osdl.org>
	<7vaclf6tw7.fsf@assigned-by-dhcp.cox.net>
	<7vmzpe4x08.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 25 11:21:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dm6q8-0002H3-CC
	for gcvg-git@gmane.org; Sat, 25 Jun 2005 11:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263377AbVFYJ1K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Jun 2005 05:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbVFYJ1K
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jun 2005 05:27:10 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:49402 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S263377AbVFYJYw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2005 05:24:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050625092451.WBUS23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Jun 2005 05:24:51 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vmzpe4x08.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 25 Jun 2005 02:16:23 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
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

 git-merge-one-file-script |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

7edbb24f69809eb41de865701bc4f17774348043
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
------------

