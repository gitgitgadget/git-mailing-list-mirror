From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/5] New test: Try "stg push" in a subdirectory
Date: Mon, 08 Oct 2007 01:24:48 +0200
Message-ID: <20071007232447.13070.53630.stgit@yoghurt>
References: <20071007231949.13070.49517.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:25:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IefVU-0004S3-QB
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755235AbXJGXYx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Oct 2007 19:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755913AbXJGXYx
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:24:53 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4888 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754987AbXJGXYw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:24:52 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IefUO-0000QH-00; Mon, 08 Oct 2007 00:24:48 +0100
In-Reply-To: <20071007231949.13070.49517.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60252>

This currently fails for the non-fast-forward cases.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/t1205-push-subdir.sh |   55 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)
 create mode 100755 t/t1205-push-subdir.sh


diff --git a/t/t1205-push-subdir.sh b/t/t1205-push-subdir.sh
new file mode 100755
index 0000000..6502c20
--- /dev/null
+++ b/t/t1205-push-subdir.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+test_description=3D'Test the push command from a subdirectory'
+. ./test-lib.sh
+stg init
+
+test_expect_success 'Create some patches' '
+    mkdir foo
+    for i in 0 1 2; do
+        stg new p$i -m p$i &&
+        echo x$i >> x.txt &&
+        echo y$i >> foo/y.txt &&
+        stg add x.txt foo/y.txt &&
+        stg refresh
+    done &&
+    [ "$(echo $(stg applied))" =3D "p0 p1 p2" ] &&
+    [ "$(echo $(stg unapplied))" =3D "" ]
+'
+
+test_expect_success 'Fast-forward push from a subdir' '
+    stg pop &&
+    [ "$(echo $(cat x.txt))" =3D "x0 x1" ] &&
+    [ "$(echo $(cat foo/y.txt))" =3D "y0 y1" ] &&
+    cd foo &&
+    stg push &&
+    cd .. &&
+    [ "$(echo $(cat x.txt))" =3D "x0 x1 x2" ] &&
+    [ "$(echo $(cat foo/y.txt))" =3D "y0 y1 y2" ]
+'
+
+test_expect_failure 'Modifying push from a subdir' '
+    stg pop &&
+    [ "$(echo $(cat x.txt))" =3D "x0 x1" ] &&
+    [ "$(echo $(cat foo/y.txt))" =3D "y0 y1" ] &&
+    stg new extra -m extra &&
+    echo extra >> extra.txt &&
+    stg add extra.txt &&
+    stg refresh &&
+    cd foo &&
+    stg push &&
+    cd .. &&
+    [ "$(echo $(cat x.txt))" =3D "x0 x1 x2" ] &&
+    [ "$(echo $(cat foo/y.txt))" =3D "y0 y1 y2" ]
+'
+
+test_expect_failure 'Conflicting push from subdir' '
+    stg pop p1 p2 &&
+    [ "$(echo $(cat x.txt))" =3D "x0" ] &&
+    [ "$(echo $(cat foo/y.txt))" =3D "y0" ] &&
+    cd foo &&
+    ! stg push p2 &&
+    cd .. &&
+    [ "$(echo $(stg status --conflict))" =3D "foo/y.txt x.txt" ]
+'
+
+test_done
