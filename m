From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 1/4] git-init: autodetect core.ignorecase
Date: Sun, 11 May 2008 18:16:39 +0200
Message-ID: <1210522602-4724-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 11 18:18:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvEFY-0008VV-Mu
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 18:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265AbYEKQRD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 12:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753671AbYEKQQz
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 12:16:55 -0400
Received: from mailer.zib.de ([130.73.108.11]:62452 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753697AbYEKQQx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 12:16:53 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.14.2/8.14.2) with ESMTP id m4BGGhMn004669;
	Sun, 11 May 2008 18:16:43 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m4BGGgDU019981;
	Sun, 11 May 2008 18:16:42 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81784>

From: Dmitry Potapov <dpotapov@gmail.com>

We already detect if symbolic links are supported by the filesystem.
This patch adds autodetect for case-insensitive filesystems, such
as VFAT and others.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 builtin-init-db.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 2854868..3721bd2 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -255,8 +255,8 @@ static int create_default_files(const char *git_dir, const char *template_path)
 			git_config_set("core.worktree", work_tree);
 	}
 
-	/* Check if symlink is supported in the work tree */
 	if (!reinit) {
+		/* Check if symlink is supported in the work tree */
 		path[len] = 0;
 		strcpy(path + len, "tXXXXXX");
 		if (!close(xmkstemp(path)) &&
@@ -267,6 +267,12 @@ static int create_default_files(const char *git_dir, const char *template_path)
 			unlink(path); /* good */
 		else
 			git_config_set("core.symlinks", "false");
+
+		/* Check if the filesystem is case-insensitive */
+		path[len] = 0;
+		strcpy(path + len, "CoNfIg");
+		if (!access(path, F_OK))
+			git_config_set("core.ignorecase", "true");
 	}
 
 	return reinit;
-- 
1.5.5.1.313.g9decb
