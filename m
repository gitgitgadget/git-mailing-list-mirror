From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH] Add rebase test for when upstream has deleted a non-ASCII file
Date: Mon, 02 Jun 2008 22:23:21 +0200
Message-ID: <20080602202148.24899.55294.stgit@yoghurt>
References: <200806011046.51872.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 22:25:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3GaU-000356-5u
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 22:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756548AbYFBUXg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Jun 2008 16:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756517AbYFBUXf
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 16:23:35 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3895 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287AbYFBUXd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 16:23:33 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1K3GYx-0000uG-00; Mon, 02 Jun 2008 21:23:27 +0100
In-Reply-To: <200806011046.51872.jnareb@gmail.com>
User-Agent: StGIT/0.14.2.156.gbabd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83563>

Test that stg rebase can handle upstream deleting a file with a
non-ASCII name. It currently can't.

Bug spotted by Jakub Narebski <jnareb@gmail.com>.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

Here's a little something for the test suite. Note that it's enough
that upstream deletes the file -- no patch in the StGit stack needs to
touch it.

 t/t2201-rebase-nonascii.sh |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)
 create mode 100755 t/t2201-rebase-nonascii.sh


diff --git a/t/t2201-rebase-nonascii.sh b/t/t2201-rebase-nonascii.sh
new file mode 100755
index 0000000..42c062f
--- /dev/null
+++ b/t/t2201-rebase-nonascii.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+test_description=3D'Rebase onto changed non-ASCII file'
+
+. ./test-lib.sh
+
+test_expect_success 'Setup' '
+    echo "Fj=C3=A4derholmarna" > sk=C3=A4rg=C3=A5rds=C3=B6.txt &&
+    git add sk=C3=A4rg=C3=A5rds=C3=B6.txt &&
+    git commit -m "Create island" &&
+    stg init &&
+    echo foo > unrelated.txt &&
+    git add unrelated.txt &&
+    stg new -m "Unrelated file" &&
+    stg refresh &&
+    stg pop &&
+    rm sk=C3=A4rg=C3=A5rds=C3=B6.txt &&
+    git commit -a -m "Remove island" &&
+    git tag upstream &&
+    git reset --hard HEAD^ &&
+    stg push
+'
+
+test_expect_failure 'Rebase onto changed non-ASCII file' '
+    stg rebase upstream
+'
+
+test_done
