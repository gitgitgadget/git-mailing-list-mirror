From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/3] stg uncommit should never touch the branch head
Date: Fri, 25 Jul 2008 02:53:00 +0200
Message-ID: <20080725005300.13006.96166.stgit@yoghurt>
References: <20080725005154.13006.8908.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Sandberg <mandolaerik@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 02:54:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMBZQ-0006Hr-12
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 02:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538AbYGYAxK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jul 2008 20:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753524AbYGYAxJ
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 20:53:09 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3156 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368AbYGYAxI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 20:53:08 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KMBts-0005W7-00; Fri, 25 Jul 2008 02:15:16 +0100
In-Reply-To: <20080725005154.13006.8908.stgit@yoghurt>
User-Agent: StGIT/0.14.3.197.gba718
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89988>

However, currently, it will set head to top, potentially losing data
(which can always be recovered via the reflog, but still). See
https://gna.org/bugs/index.php?12043. Add a test to demonstrate the
bad behavior. (Bug discovered by Erik Sandberg
<mandolaerik@gmail.com>.)

stg commit, on the other hand, should refuse to run if top !=3D head,
since the committed patches might otherwise be lost. Add a test to
demonstrate that this is the case.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/t1300-uncommit.sh |   11 +++++++++++
 t/t1303-commit.sh   |   20 ++++++++++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100755 t/t1303-commit.sh


diff --git a/t/t1300-uncommit.sh b/t/t1300-uncommit.sh
index a657ead..d01eaaa 100755
--- a/t/t1300-uncommit.sh
+++ b/t/t1300-uncommit.sh
@@ -83,4 +83,15 @@ test_expect_success 'Uncommit a commit with not prec=
isely one parent' '
     [ "$(echo $(stg series))" =3D "" ]
 '
=20
+# stg uncommit should work even when top !=3D head, and should not tou=
ch
+# the head.
+test_expect_failure 'Uncommit when top !=3D head' '
+    stg new -m foo &&
+    git reset --hard HEAD^ &&
+    h=3D$(git rev-parse HEAD)
+    stg uncommit bar &&
+    test $(git rev-parse HEAD) =3D $h &&
+    test "$(echo $(stg series))" =3D "+ bar > foo"
+'
+
 test_done
diff --git a/t/t1303-commit.sh b/t/t1303-commit.sh
new file mode 100755
index 0000000..d53b9f2
--- /dev/null
+++ b/t/t1303-commit.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+test_description=3D'Test stg commit'
+. ./test-lib.sh
+
+test_expect_success 'Initialize the StGIT repository' '
+    stg init
+'
+
+# stg commit with top !=3D head should not succeed, since the committe=
d
+# patches are poptentially lost.
+test_expect_success 'Commit when top !=3D head (should fail)' '
+    stg new -m foo &&
+    git reset --hard HEAD^ &&
+    h=3D$(git rev-parse HEAD)
+    command_error stg commit &&
+    test $(git rev-parse HEAD) =3D $h &&
+    test "$(echo $(stg series))" =3D "> foo"
+'
+
+test_done
