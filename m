From: =?utf-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 4/6] Added a test case to check what happens when push finds a conflict
Date: Mon, 20 Aug 2007 10:12:01 +0200
Message-ID: <1187597523884-git-send-email-davidk@lysator.liu.se>
References: <11875975232619-git-send-email-davidk@lysator.liu.se>
 <1187597523433-git-send-email-davidk@lysator.liu.se>
 <11875975232734-git-send-email-davidk@lysator.liu.se>
 <11875975232606-git-send-email-davidk@lysator.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>
To: catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 10:37:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN2l1-0000t4-U5
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 10:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756049AbXHTIgl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 04:36:41 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756034AbXHTIgl
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 04:36:41 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:52187 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755692AbXHTIge (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 04:36:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id A71C1200A1F4;
	Mon, 20 Aug 2007 10:12:05 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 18059-01; Mon, 20 Aug 2007 10:12:04 +0200 (CEST)
Received: from morpheus (c83-253-22-183.bredband.comhem.se [83.253.22.183])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 362DA200A205;
	Mon, 20 Aug 2007 10:12:04 +0200 (CEST)
Received: by morpheus (Postfix, from userid 1000)
	id 64059BFC92; Mon, 20 Aug 2007 10:12:03 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc3.119.g1812
In-Reply-To: <11875975232606-git-send-email-davidk@lysator.liu.se>
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56197>

=46rom: David K=C3=A5gedal <davidk@lysator.liu.se>


Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---
 t/t1203-push-conflict.sh |   64 ++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/t/t1203-push-conflict.sh b/t/t1203-push-conflict.sh
new file mode 100755
index 0000000..57fb477
--- /dev/null
+++ b/t/t1203-push-conflict.sh
@@ -0,0 +1,64 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 David K=C3=A5gedal
+#
+
+test_description=3D'Exercise push conflicts.
+
+Test that the index has no modifications after a push with conflicts.
+'
+
+. ./test-lib.sh
+
+test_expect_success \
+	'Initialize the StGIT repository' \
+	'stg init
+'
+
+test_expect_success \
+	'Create the first patch' \
+	'
+	stg new foo -m foo &&
+	echo foo > test &&
+	echo fie > test2 &&
+	stg add test test2 &&
+	stg refresh &&
+        stg pop
+	'
+
+test_expect_success \
+	'Create the second patch' \
+	'
+	stg new bar -m bar &&
+	echo bar > test &&
+	stg add test &&
+	stg refresh
+	'
+
+test_expect_failure \
+	'Push the first patch with conflict' \
+	'
+	stg push foo
+	'
+
+test_expect_failure \
+	'Show the, now empty, first patch' \
+	'
+	stg show foo | grep -q -e "^diff "
+	'
+
+test_expect_success \
+	'Check that the index has the non-conflict updates' \
+	'
+	git diff --cached --stat | grep -q -e "^ test2 | *1 "
+	'
+
+test_expect_success \
+	'Resolve the conflict' \
+	'
+	echo resolved > test &&
+	git add test &&
+	stg refresh
+	'
+
+test_done
--=20
1.5.3.rc3.119.g1812
