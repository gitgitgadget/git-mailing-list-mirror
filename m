From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] Makefile: use shell for-loop rather than Make's foreach loop during install
Date: Mon, 19 Jan 2009 19:41:40 -0600
Message-ID: <IabvnnitcJMS2DjNwgzy1-XPpTZ5XUD1yCbZhuv3bgnTXi4eLY33JtDkQKLr5q3lh1kyMtC3WfU@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <casey@nrlssc.navy.mil>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jan 20 03:02:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP5wq-0000K2-Iv
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 03:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758660AbZATCBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 21:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756348AbZATCBL
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 21:01:11 -0500
Received: from mail2.nrlssc.navy.mil ([128.160.25.4]:43374 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204AbZATCBK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 21:01:10 -0500
X-Greylist: delayed 1126 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jan 2009 21:01:10 EST
Received: by mail.nrlssc.navy.mil id n0K1gMOf025860; Mon, 19 Jan 2009 19:42:22 -0600
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106425>

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
