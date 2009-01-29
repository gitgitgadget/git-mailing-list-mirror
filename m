From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] Fix 'git diff --no-index' with a non-existing symlink
 target
Date: Thu, 29 Jan 2009 17:30:51 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901291730210.3586@pacific.mpi-cbg.de>
References: <cover.1233246616u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 17:32:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSZo8-0001lt-VG
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 17:32:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbZA2Qae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 11:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753310AbZA2Qae
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 11:30:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:37012 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752339AbZA2Qad (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 11:30:33 -0500
Received: (qmail invoked by alias); 29 Jan 2009 16:30:31 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 29 Jan 2009 17:30:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1806kIs8q40woLZI4mc3z+yYWkrSETRfO8OKRuHJV
	j0XRCc2KwUPbMe
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1233246616u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107702>

When trying to find out mode changes, we should not access the symlink
targets using stat(); instead we use lstat() so that the diff does
not fail trying to find a non-existing symlink target.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff-no-index.c         |    2 +-
 t/t4011-diff-symlink.sh |    7 +++++++
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 60ed174..0dbd9da 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -40,7 +40,7 @@ static int get_mode(const char *path, int *mode)
 		*mode = 0;
 	else if (!strcmp(path, "-"))
 		*mode = create_ce_mode(0666);
-	else if (stat(path, &st))
+	else if (lstat(path, &st))
 		return error("Could not access '%s'", path);
 	else
 		*mode = st.st_mode;
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index 02efeca..9055c8b 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -82,4 +82,11 @@ test_expect_success \
     git diff-index -M -p $tree > current &&
     compare_diff_patch current expected'
 
+test_expect_success \
+    'diff symlinks with non-existing targets' \
+    'ln -s narf pinky &&
+    ln -s take\ over brain &&
+    test_must_fail git diff --no-index pinky brain > output 2> output.err &&
+    grep narf output &&
+    ! grep error output.err'
 test_done
-- 
1.6.1.2.531.g6f52
