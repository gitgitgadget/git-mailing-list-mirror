From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/2] Test the new stg delete --spill flag
Date: Sun, 21 Sep 2008 21:07:36 +0200
Message-ID: <20080921190736.4503.80527.stgit@yoghurt>
References: <20080921190708.4503.20574.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 21:09:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhUIr-0001mK-8O
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 21:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284AbYIUTHj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Sep 2008 15:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752215AbYIUTHj
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 15:07:39 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3162 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbYIUTHi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 15:07:38 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KhUcx-0003a0-00; Sun, 21 Sep 2008 20:29:51 +0100
In-Reply-To: <20080921190708.4503.20574.stgit@yoghurt>
User-Agent: StGIT/0.14.3.236.g0c611
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96424>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/t1602-delete-spill.sh |   47 +++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)
 create mode 100755 t/t1602-delete-spill.sh


diff --git a/t/t1602-delete-spill.sh b/t/t1602-delete-spill.sh
new file mode 100755
index 0000000..1ddec53
--- /dev/null
+++ b/t/t1602-delete-spill.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+test_description=3D'Test "stg delete --spill"'
+. ./test-lib.sh
+
+test_expect_success 'Initialize the StGIT repository' '
+    stg init
+'
+
+test_expect_success 'Create five applied and three unapplied patches' =
'
+    for i in 0 1 2 3 4 5 6 7; do
+        echo $i >> foo &&
+        git add foo &&
+        git commit -m p$i
+    done
+    stg uncommit -n 8 &&
+    stg pop -n 3
+'
+
+test_expect_success 'Try to delete --spill an unapplied patch' '
+    command_error stg delete --spill p7 &&
+    test "$(echo $(stg series))" =3D "+ p0 + p1 + p2 + p3 > p4 - p5 - =
p6 - p7" &&
+    test "$(echo $(cat foo))" =3D "0 1 2 3 4" &&
+    test "$(echo $(git diff-files))" =3D ""
+'
+
+test_expect_success 'Try to delete --spill a non-top patch' '
+    command_error stg delete --spill p2 &&
+    test "$(echo $(stg series))" =3D "+ p0 + p1 + p2 + p3 > p4 - p5 - =
p6 - p7" &&
+    test "$(echo $(cat foo))" =3D "0 1 2 3 4" &&
+    test "$(echo $(git diff-files))" =3D ""
+'
+
+test_expect_success 'Delete --spill one patch' '
+    stg delete --spill p4 &&
+    test "$(echo $(stg series))" =3D "+ p0 + p1 + p2 > p3 - p5 - p6 - =
p7" &&
+    test "$(echo $(cat foo))" =3D "0 1 2 3 4" &&
+    test "$(echo $(git diff-files))" =3D ""
+'
+
+test_expect_success 'Delete --spill several patches' '
+    stg delete --spill p2 p3 p1 &&
+    test "$(echo $(stg series))" =3D "> p0 - p5 - p6 - p7" &&
+    test "$(echo $(cat foo))" =3D "0 1 2 3 4" &&
+    test "$(echo $(git diff-files))" =3D ""
+'
+
+test_done
