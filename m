From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [PATCH 1/2] reflog test: add more tests for 'reflog delete'
Date: Sun, 10 Aug 2008 01:33:29 +0200
Message-ID: <1218324810-35376-1-git-send-email-pdebie@ai.rug.nl>
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailinglist <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 10 01:35:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRxyE-0008CG-Lx
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 01:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847AbYHIXdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 19:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753108AbYHIXdl
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 19:33:41 -0400
Received: from smtp-1.orange.nl ([193.252.22.241]:13955 "EHLO smtp-1.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752847AbYHIXdj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 19:33:39 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6007.online.nl (SMTP Server) with ESMTP id 8FE097000083;
	Sun, 10 Aug 2008 01:33:37 +0200 (CEST)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6007.online.nl (SMTP Server) with ESMTP id 2FE007000081;
	Sun, 10 Aug 2008 01:33:31 +0200 (CEST)
X-ME-UUID: 20080809233337196.2FE007000081@mwinf6007.online.nl
X-Mailer: git-send-email 1.6.0.rc1.288.g5b89f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91793>

This adds more tests for 'reflog delete' and marks it as
broken, as currently a call to 'git reflog delete HEAD@{1}'
deletes entries in the currently checked out branch's log,
not the HEAD log.

Noticed by John Wiegley

Signed-off-by: Pieter de Bie <pdebie@ai.rug.nl>
---

	johnw on IRC noticed this. This adds a test that shows the
	problem. The next patch fixes the issue but I'm not sure of
	the implementation. Perhaps we just shouldn't resolve symbolic
	refs? I'm not really sure which functions to use then.

 t/t1410-reflog.sh |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 73f830d..3b9860e 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -175,7 +175,7 @@ test_expect_success 'recover and check' '
 
 '
 
-test_expect_success 'delete' '
+test_expect_failure 'delete' '
 	echo 1 > C &&
 	test_tick &&
 	git commit -m rat C &&
@@ -188,16 +188,30 @@ test_expect_success 'delete' '
 	test_tick &&
 	git commit -m tiger C &&
 
-	test 5 = $(git reflog | wc -l) &&
+	HEAD_entry_count=$(git reflog | wc -l)
+	master_entry_count=$(git reflog show master | wc -l)
+
+	test $HEAD_entry_count = 5 &&
+	test $master_entry_count = 5 &&
+
 
 	git reflog delete master@{1} &&
 	git reflog show master > output &&
-	test 4 = $(wc -l < output) &&
+	test $(($master_entry_count - 1)) = $(wc -l < output) &&
+	test $HEAD_entry_count = $(git reflog | wc -l) &&
 	! grep ox < output &&
 
+	master_entry_count=$(wc -l < output)
+
+	git reflog delete HEAD@{1} &&
+	test $(($HEAD_entry_count -1)) = $(git reflog | wc -l) &&
+	test $master_entry_count = $(git reflog show master | wc -l) &&
+
+	HEAD_entry_count=$(git reflog | wc -l)
+
 	git reflog delete master@{07.04.2005.15:15:00.-0700} &&
 	git reflog show master > output &&
-	test 3 = $(wc -l < output) &&
+	test $(($master_entry_count - 1)) = $(wc -l < output) &&
 	! grep dragon < output
 
 '
-- 
1.6.0.rc0.320.g49281
