From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/5] t: add tests for diff.renames (true/false/unset)
Date: Tue, 23 Feb 2016 18:44:56 +0100
Message-ID: <1456249498-3232-4-git-send-email-Matthieu.Moy@imag.fr>
References: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 18:45:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYH1W-000164-Uy
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 18:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717AbcBWRpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 12:45:14 -0500
Received: from mx1.imag.fr ([129.88.30.5]:37117 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754639AbcBWRpM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 12:45:12 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u1NHj6Ze004803
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 23 Feb 2016 18:45:07 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1NHj6MW012979;
	Tue, 23 Feb 2016 18:45:08 +0100
X-Mailer: git-send-email 2.7.2.334.g35ed2ae.dirty
In-Reply-To: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 23 Feb 2016 18:45:07 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1NHj6Ze004803
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1456854308.91118@QjWoPjHWXeDMOEMheBX67Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287094>

The underlying machinery is well-tested, but the configuration option
itself was tested only in t3400-rebase.sh.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 t/t4001-diff-rename.sh | 61 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index bfb364c..6844906 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -27,7 +27,7 @@ Line 13
 Line 14
 Line 15
 EOF
-	cat >expected <<\EOF
+	cat >expected <<\EOF &&
 diff --git a/path0 b/path1
 rename from path0
 rename to path1
@@ -43,6 +43,50 @@ rename to path1
  Line 13
  Line 14
 EOF
+	cat >no-rename <<\EOF
+diff --git a/path0 b/path0
+deleted file mode 100644
+index fdbec44..0000000
+--- a/path0
++++ /dev/null
+@@ -1,15 +0,0 @@
+-Line 1
+-Line 2
+-Line 3
+-Line 4
+-Line 5
+-Line 6
+-Line 7
+-Line 8
+-Line 9
+-Line 10
+-line 11
+-Line 12
+-Line 13
+-Line 14
+-Line 15
+diff --git a/path1 b/path1
+new file mode 100644
+index 0000000..752c50e
+--- /dev/null
++++ b/path1
+@@ -0,0 +1,15 @@
++Line 1
++Line 2
++Line 3
++Line 4
++Line 5
++Line 6
++Line 7
++Line 8
++Line 9
++Line 10
++Line 11
++Line 12
++Line 13
++Line 14
++Line 15
+EOF
 '
 
 test_expect_success \
@@ -68,6 +112,21 @@ test_expect_success \
     'validate the output.' \
     'compare_diff_patch current expected'
 
+test_expect_success 'test diff.renames=true' '
+	git -c diff.renames=true diff --cached $tree >current &&
+	compare_diff_patch current expected
+'
+
+test_expect_success 'test diff.renames=false' '
+	git -c diff.renames=false diff --cached $tree >current &&
+	compare_diff_patch current no-rename
+'
+
+test_expect_success 'test diff.renames unset' '
+	git diff --cached $tree >current &&
+	compare_diff_patch current no-rename
+'
+
 test_expect_success 'favour same basenames over different ones' '
 	cp path1 another-path &&
 	git add another-path &&
-- 
2.7.2.334.g35ed2ae.dirty
