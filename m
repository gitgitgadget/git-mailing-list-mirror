From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 3/6] Added a test case to check what happens when push
	finds a conflict
Date: Sun, 26 Aug 2007 22:42:48 +0200
Message-ID: <20070826204248.16700.30974.stgit@yoghurt>
References: <20070826203745.16700.5655.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Sun Aug 26 22:43:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPOx0-0002Lo-2l
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 22:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbXHZUnL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 26 Aug 2007 16:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbXHZUnK
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 16:43:10 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2221 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbXHZUnI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 16:43:08 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IPOwb-000612-00; Sun, 26 Aug 2007 21:42:49 +0100
In-Reply-To: <20070826203745.16700.5655.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56729>

=46rom: David K=C3=A5gedal <davidk@lysator.liu.se>

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

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
