From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 2/4] t4120-apply-popt: help systems with core.filemode=false
Date: Thu,  3 Feb 2011 15:31:43 +0000
Message-ID: <1296747105-1663-3-git-send-email-patthoyts@users.sourceforge.net>
References: <1296747105-1663-1-git-send-email-patthoyts@users.sourceforge.net>
Cc: msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 03 16:32:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl1B3-00069T-8U
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 16:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191Ab1BCPci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 10:32:38 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:43655 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756424Ab1BCPch (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Feb 2011 10:32:37 -0500
Received: from [172.23.170.142] (helo=anti-virus02-09)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Pl1AZ-0004gB-Os; Thu, 03 Feb 2011 15:32:27 +0000
Received: from [77.100.97.230] (helo=fox.patthoyts.tk)
	by asmtp-out6.blueyonder.co.uk with esmtpa (Exim 4.72)
	(envelope-from <pat@patthoyts.tk>)
	id 1Pl1AC-00065h-1Y; Thu, 03 Feb 2011 15:32:04 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id A8743202DC; Thu,  3 Feb 2011 15:32:03 +0000 (GMT)
X-Mailer: git-send-email 1.7.4
In-Reply-To: <1296747105-1663-1-git-send-email-patthoyts@users.sourceforge.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165977>

From: Johannes Sixt <j6t@kdbg.org>

A test case verifies that filemode-only patches work as expected. Help
systems where "test -x" does not work by applying the test patch also to
the index, where the effects can be verified even on such systems.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 t/t4120-apply-popt.sh |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/t4120-apply-popt.sh b/t/t4120-apply-popt.sh
index 579c9e6..a33d510 100755
--- a/t/t4120-apply-popt.sh
+++ b/t/t4120-apply-popt.sh
@@ -6,6 +6,7 @@
 test_description='git apply -p handling.'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-prereq-FILEMODE.sh
 
 test_expect_success setup '
 	mkdir sub &&
@@ -62,8 +63,12 @@ test_expect_success 'apply (-p2) diff, mode change only' '
 	old mode 100644
 	new mode 100755
 	EOF
-	chmod 644 file1 &&
-	git apply -p2 patch.chmod &&
+	test_chmod -x file1 &&
+	git apply --index -p2 patch.chmod &&
+	case $(git ls-files -s file1) in 100755*) : good;; *) false;; esac
+'
+
+test_expect_success FILEMODE 'file mode was changed' '
 	test -x file1
 '
 
-- 
1.7.4.msysgit.0
