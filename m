From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [PATCH 2/2] builtin-reflog: fix deletion of HEAD entries
Date: Sun, 10 Aug 2008 01:33:30 +0200
Message-ID: <1218324810-35376-2-git-send-email-pdebie@ai.rug.nl>
References: <1218324810-35376-1-git-send-email-pdebie@ai.rug.nl>
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailinglist <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 10 01:35:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRxyE-0008CG-0l
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 01:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270AbYHIXdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 19:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753183AbYHIXdk
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 19:33:40 -0400
Received: from smtp-1.orange.nl ([193.252.22.241]:13965 "EHLO smtp-1.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753070AbYHIXdj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 19:33:39 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6007.online.nl (SMTP Server) with ESMTP id 0402E7000081;
	Sun, 10 Aug 2008 01:33:38 +0200 (CEST)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6007.online.nl (SMTP Server) with ESMTP id 9E3CD7000086;
	Sun, 10 Aug 2008 01:33:37 +0200 (CEST)
X-ME-UUID: 20080809233337648.9E3CD7000086@mwinf6007.online.nl
X-Mailer: git-send-email 1.6.0.rc1.288.g5b89f
In-Reply-To: <1218324810-35376-1-git-send-email-pdebie@ai.rug.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91794>

dwim_ref() used to resolve HEAD to its symlink (like refs/heads/master),
making a call to 'git reflog delete HEAD@{1}' to actually delete the second
entry in the master reflog.

This patch makes a special case for HEAD (as that's the only non-branch
reflog we keep), fixing the issue.

Signed-off-by: Pieter de Bie <pdebie@ai.rug.nl>
---
 builtin-reflog.c  |   15 ++++++++++++---
 t/t1410-reflog.sh |    2 +-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index 0c34e37..5af3f28 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -604,9 +604,18 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (!dwim_ref(argv[i], spec - argv[i], sha1, &ref)) {
-			status |= error("%s points nowhere!", argv[i]);
-			continue;
+		if (!strncmp(argv[i], "HEAD", 4)) {
+			ref = xstrdup("HEAD");
+			if (!resolve_ref(ref, sha1, 1, NULL)) {
+				status |= error("%s points nowhere!", argv[i]);
+				continue;
+			}
+		}
+		else {
+			if (!dwim_ref(argv[i], spec - argv[i], sha1, &ref)) {
+				status |= error("%s points nowhere!", argv[i]);
+				continue;
+			}
 		}
 
 		recno = strtoul(spec + 2, &ep, 10);
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 3b9860e..5b24f05 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -175,7 +175,7 @@ test_expect_success 'recover and check' '
 
 '
 
-test_expect_failure 'delete' '
+test_expect_success 'delete' '
 	echo 1 > C &&
 	test_tick &&
 	git commit -m rat C &&
-- 
1.6.0.rc0.320.g49281
