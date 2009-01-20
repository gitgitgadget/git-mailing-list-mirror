From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] Makefile: use shell for-loop rather than Make's foreach loop during install
Date: Mon, 19 Jan 2009 19:44:03 -0600
Message-ID: <Uv24ZMhFKiA3m2EbqK1HTIXDifezvG8IBTYsEb_OWDUMnDkrzIOUKxq1EaDifYcOfSLwghdle38@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jan 20 02:45:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP5gf-0005DV-MT
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 02:45:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754506AbZATBo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 20:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbZATBo2
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 20:44:28 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55411 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbZATBo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 20:44:27 -0500
Received: by mail.nrlssc.navy.mil id n0K1iOHA019129; Mon, 19 Jan 2009 19:44:24 -0600
X-OriginalArrivalTime: 20 Jan 2009 01:44:12.0723 (UTC) FILETIME=[986A5030:01C97AA0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106424>

The install target uses a foreach loop to generate a single long shell
command line to handle installation of the built-in git commands.  The
maximum length of the argument list varies by platform, and this use of
foreach quickly grows the length of the argument list.  Current git can
exceed the default maximum argument list length on IRIX 6.5 of 20480
depending on the installation path.

Rather than using make's foreach loop to pre-generate the shell command
line, use a shell for-loop and allow the shell to iterate through each of
the built-in commands.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 Makefile |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 2b873fa..fa6c51c 100644
--- a/Makefile
+++ b/Makefile
@@ -1441,10 +1441,12 @@ endif
 	{ $(RM) "$$execdir/git-add$X" && \
 		ln git-add$X "$$execdir/git-add$X" 2>/dev/null || \
 		cp git-add$X "$$execdir/git-add$X"; } && \
-	{ $(foreach p,$(filter-out git-add$X,$(BUILT_INS)), $(RM) "$$execdir/$p" && \
-		ln "$$execdir/git-add$X" "$$execdir/$p" 2>/dev/null || \
-		ln -s "git-add$X" "$$execdir/$p" 2>/dev/null || \
-		cp "$$execdir/git-add$X" "$$execdir/$p" || exit;) } && \
+	{ for p in $(filter-out git-add$X,$(BUILT_INS)); do \
+		$(RM) "$$execdir/$$p" && \
+		ln "$$execdir/git-add$X" "$$execdir/$$p" 2>/dev/null || \
+		ln -s "git-add$X" "$$execdir/$$p" 2>/dev/null || \
+		cp "$$execdir/git-add$X" "$$execdir/$$p" || exit; \
+	  done } && \
 	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
 
 install-doc:
-- 
1.6.1.239.gcf3bf
