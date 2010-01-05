From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Documentation: reset: add some missing tables
Date: Tue, 05 Jan 2010 06:58:30 +0100
Message-ID: <20100105055831.3539.26382.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 07:01:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS2U9-0002po-Kt
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 07:01:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872Ab0AEGB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 01:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196Ab0AEGB2
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 01:01:28 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:50835 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751154Ab0AEGB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 01:01:27 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B90A281806B;
	Tue,  5 Jan 2010 07:01:17 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 42EF3818023;
	Tue,  5 Jan 2010 07:01:13 +0100 (CET)
X-git-sha1: 5eebae999f210d41aed59bbf44c6fcf71e599bc3 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136166>

and while at it also explain why --merge option is disallowed in some
cases.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-reset.txt |   35 +++++++++++++++++++++++++++++------
 1 files changed, 29 insertions(+), 6 deletions(-)

I must say that I find it a bit strange (and difficult to explain) that
we have:

      working index HEAD target         working index HEAD
      ----------------------------------------------------
       B       C     C    C     --merge   B       C     C

while in the other cases, when it is allowed, --merge is like --hard.

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index dc73dca..1f35278 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -79,6 +79,13 @@ git reset --option target
 to reset the HEAD to another commit (`target`) with the different
 reset options depending on the state of the files.
 
+In these tables, A, B, C and D are some different states of a
+file. For example, the first line of the first table means that if a
+file is in state A in the working tree, in state B in the index, in
+state C in HEAD and in state D in the target, then "git reset --soft
+target" will put the file in state A in the working tree, in state B
+in the index and in state D in HEAD.
+
       working index HEAD target         working index HEAD
       ----------------------------------------------------
        A       B     C    D     --soft   A       B     D
@@ -107,12 +114,28 @@ reset options depending on the state of the files.
 				--hard   C       C     C
 				--merge  C       C     C
 
-In these tables, A, B, C and D are some different states of a
-file. For example, the last line of the last table means that if a
-file is in state B in the working tree and the index, and in a
-different state C in HEAD and in the target, then "git reset
---merge target" will put the file in state C in the working tree,
-in the index and in HEAD.
+      working index HEAD target         working index HEAD
+      ----------------------------------------------------
+       B       C     C    D     --soft   B       C     D
+                                --mixed  B       D     D
+                                --hard   D       D     D
+                                --merge (disallowed)
+
+      working index HEAD target         working index HEAD
+      ----------------------------------------------------
+       B       C     C    C     --soft   B       C     C
+                                --mixed  B       C     C
+                                --hard   C       C     C
+                                --merge  B       C     C
+
+"reset --merge" is meant to be used when resetting out of a conflicted
+merge. Any mergy operation guarantees that the work tree file that is
+involved in the merge does not have local change wrt the index before
+it starts, and that it writes the result out to the work tree. So if
+we see some difference between the index and the target and also
+between the index and the work tree, then it means that we are not
+resetting out from a state that a mergy operation left after failing
+with a conflict. That is why we disallow --merge option in this case.
 
 The following tables show what happens when there are unmerged
 entries:
-- 
1.6.6.rc2.5.g49666
