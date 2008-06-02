From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 1/4] Add rebase test for when upstream has deleted a non-ASCII
	file
Date: Mon, 02 Jun 2008 23:46:19 +0200
Message-ID: <20080602214618.18768.63334.stgit@yoghurt>
References: <20080602214212.18768.63775.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 23:47:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3HsB-0004o3-FF
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 23:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbYFBVqc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Jun 2008 17:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbYFBVqc
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 17:46:32 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4635 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920AbYFBVqb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 17:46:31 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1K3Hr9-0001DL-00; Mon, 02 Jun 2008 22:46:20 +0100
In-Reply-To: <20080602214212.18768.63775.stgit@yoghurt>
User-Agent: StGIT/0.14.2.156.gbabd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83579>

Test that stg rebase can handle upstream deleting a file with a
non-ASCII name. It currently can't.

Bug spotted by Jakub Narebski <jnareb@gmail.com>.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/t3200-non-ascii-filenames.sh |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)
 create mode 100755 t/t3200-non-ascii-filenames.sh


diff --git a/t/t3200-non-ascii-filenames.sh b/t/t3200-non-ascii-filenam=
es.sh
new file mode 100755
index 0000000..1d82a9f
--- /dev/null
+++ b/t/t3200-non-ascii-filenames.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+test_description=3D'Handle files with non-ASCII characters in their na=
mes'
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
