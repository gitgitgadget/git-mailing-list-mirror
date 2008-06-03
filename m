From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH v2 3/4] Test for another filename quoting issue in
	tree_status()
Date: Tue, 03 Jun 2008 02:41:51 +0200
Message-ID: <20080603004151.25028.99694.stgit@yoghurt>
References: <20080603003846.25028.49353.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 02:43:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3KcM-0000YO-O1
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 02:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbYFCAmF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Jun 2008 20:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752537AbYFCAmE
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 20:42:04 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3963 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659AbYFCAlz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 20:41:55 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1K3Kb1-0001mf-00; Tue, 03 Jun 2008 01:41:51 +0100
In-Reply-To: <20080603003846.25028.49353.stgit@yoghurt>
User-Agent: StGIT/0.14.2.171.g5c0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83606>

stgit.git.tree_status() had another filename quoting issue, similar to
the one just fixed. Test for that one too.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/t3200-non-ascii-filenames.sh |   34 ++++++++++++++++++++++++++++++++=
+-
 1 files changed, 33 insertions(+), 1 deletions(-)


diff --git a/t/t3200-non-ascii-filenames.sh b/t/t3200-non-ascii-filenam=
es.sh
index a04ead8..3146b8d 100755
--- a/t/t3200-non-ascii-filenames.sh
+++ b/t/t3200-non-ascii-filenames.sh
@@ -3,6 +3,12 @@ test_description=3D'Handle files with non-ASCII charac=
ters in their names'
=20
 . ./test-lib.sh
=20
+# Ignore our own output files.
+cat > .git/info/exclude <<EOF
+/expected.txt
+/output.txt
+EOF
+
 test_expect_success 'Setup' '
     echo "Fj=C3=A4derholmarna" > sk=C3=A4rg=C3=A5rds=C3=B6.txt &&
     git add sk=C3=A4rg=C3=A5rds=C3=B6.txt &&
@@ -10,7 +16,7 @@ test_expect_success 'Setup' '
     stg init &&
     echo foo > unrelated.txt &&
     git add unrelated.txt &&
-    stg new -m "Unrelated file" &&
+    stg new p0 -m "Unrelated file" &&
     stg refresh &&
     stg pop &&
     rm sk=C3=A4rg=C3=A5rds=C3=B6.txt &&
@@ -24,4 +30,30 @@ test_expect_success 'Rebase onto changed non-ASCII f=
ile' '
     stg rebase upstream
 '
=20
+test_expect_success 'Setup' '
+    stg delete p0 &&
+    git reset --hard HEAD^ &&
+    echo "-- ett liv mitt ute i vattnet" >> sk=C3=A4rg=C3=A5rds=C3=B6.=
txt &&
+    stg new p1 -m "Describe island"
+'
+
+cat > expected.txt <<EOF
+M sk=C3=A4rg=C3=A5rds=C3=B6.txt
+EOF
+test_expect_failure 'Status of modified non-ASCII file' '
+    stg status > output.txt &&
+    diff -u expected.txt output.txt
+'
+
+test_expect_success 'Refresh changes to non-ASCII file' '
+    stg refresh
+'
+
+cat > expected.txt <<EOF
+EOF
+test_expect_success 'Status after refresh' '
+    stg status > output.txt &&
+    diff -u expected.txt output.txt
+'
+
 test_done
