From: Brad King <brad.king@kitware.com>
Subject: [PATCH 1/2] submodule: Demonstrate failure to add with auto/safecrlf
Date: Wed, 20 Jun 2012 10:43:32 -0400
Message-ID: <7b51d857a351dd0d4972b62b5ba52a7df6bfd988.1340202515.git.brad.king@kitware.com>
References: <cover.1340202515.git.brad.king@kitware.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 20 16:53:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShMI7-0000jb-9c
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 16:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756083Ab2FTOxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 10:53:49 -0400
Received: from 66-194-253-20.static.twtelecom.net ([66.194.253.20]:57609 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755680Ab2FTOxt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 10:53:49 -0400
X-Greylist: delayed 616 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Jun 2012 10:53:49 EDT
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 92B3C711; Wed, 20 Jun 2012 10:43:33 -0400 (EDT)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <cover.1340202515.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200298>

If 'core.autocrlf' and 'core.safecrlf' are both enabled then
'git submodule add' fails with an error such as

 fatal: LF would be replaced by CRLF in .gitmodules
 Failed to register submodule 'submod'

because it generates a '.gitmodules' file with LF newlines that are
rejected by 'git add' under this configuration.  Demonstrate this known
breakage with a new test in t7400-submodule-basic covering the case.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 t/t7400-submodule-basic.sh |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 81827e6..5eaeb04 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -43,6 +43,7 @@ test_expect_success 'setup - hide init subdirectory' '
 
 test_expect_success 'setup - repository to add submodules to' '
 	git init addtest &&
+	git init addtest-crlf &&
 	git init addtest-ignore
 '
 
@@ -98,6 +99,18 @@ test_expect_success 'submodule add' '
 	test_cmp empty untracked
 '
 
+test_expect_failure 'submodule add with core.autocrlf and core.safecrlf' '
+	(
+		cd addtest-crlf &&
+		git config core.autocrlf true &&
+		git config core.safecrlf true &&
+		git submodule add "$submodurl" submod &&
+		echo ".gitmodules" >expect &&
+		git ls-files -- .gitmodules >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'submodule add to .gitignored path fails' '
 	(
 		cd addtest-ignore &&
-- 
1.7.10
