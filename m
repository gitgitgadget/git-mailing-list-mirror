From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH] Test the new DAG appliedness machinery
Date: Sun, 13 May 2007 22:05:50 +0200
Message-ID: <20070513200505.25119.53604.stgit@yoghurt>
References: <20070513184558.19482.51776.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 13 22:06:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnKKO-0006PS-NS
	for gcvg-git@gmane.org; Sun, 13 May 2007 22:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756594AbXEMUFz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 13 May 2007 16:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757069AbXEMUFz
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 16:05:55 -0400
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:51995 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756594AbXEMUFz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 May 2007 16:05:55 -0400
Received: from c83-250-140-11.bredband.comhem.se ([83.250.140.11]:41744 helo=yoghurt)
	by ch-smtp02.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <kha@treskal.com>)
	id 1HnKKH-0002JG-6y; Sun, 13 May 2007 22:05:53 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.62)
	(envelope-from <kha@treskal.com>)
	id 1HnKKE-0006Y6-7n; Sun, 13 May 2007 22:05:50 +0200
In-Reply-To: <20070513184558.19482.51776.stgit@yoghurt>
User-Agent: StGIT/0.12
X-Scan-Result: No virus found in message 1HnKKH-0002JG-6y.
X-Scan-Signature: ch-smtp02.sth.basefarm.net 1HnKKH-0002JG-6y 028d5b592aad62480ac66fabaeaa498c
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47178>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

And here's a test that demonstrates situations where it's useful.

 t/t3000-git-interop.sh |   60 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/t/t3000-git-interop.sh b/t/t3000-git-interop.sh
new file mode 100755
index 0000000..44414b9
--- /dev/null
+++ b/t/t3000-git-interop.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+# Copyright (c) 2007 Karl Hasselstr=C3=B6m
+test_description=3D'Test git/StGIT interoperability'
+. ./test-lib.sh
+
+test_expect_success \
+    'Create some git-only history' '
+    echo foo > foo.txt &&
+    git add foo.txt &&
+    git commit -a -m foo &&
+    git tag foo-tag &&
+    for i in 0 1 2 3 4; do
+        echo foo$i >> foo.txt &&
+        git commit -a -m foo$i;
+    done
+'
+
+test_expect_success \
+    'Initialize the StGIT repository' '
+    stg init
+'
+
+test_expect_success \
+    'Create five patches' '
+    for i in 0 1 2 3 4; do
+        stg new p$i -m p$i;
+    done &&
+    [ "$(echo $(stg applied))" =3D "p0 p1 p2 p3 p4" ] &&
+    [ "$(echo $(stg unapplied))" =3D "" ]
+'
+
+test_expect_success \
+    'Pop two patches with git-reset' '
+    git reset --hard HEAD~2 &&
+    [ "$(echo $(stg applied))" =3D "p0 p1 p2" ] &&
+    [ "$(echo $(stg unapplied))" =3D "p3 p4" ]
+'
+
+test_expect_success \
+    'Create a new patch' '
+    stg new q0 -m q0 &&
+    [ "$(echo $(stg applied))" =3D "p0 p1 p2 q0" ] &&
+    [ "$(echo $(stg unapplied))" =3D "p3 p4" ]
+'
+
+test_expect_success \
+    'Go to an unapplied patch with with git-reset' '
+    git reset --hard $(stg id p3) &&
+    [ "$(echo $(stg applied))" =3D "p0 p1 p2 p3" ] &&
+    [ "$(echo $(stg unapplied))" =3D "q0 p4" ]
+'
+
+test_expect_success \
+    'Go back to below the stack base with git-reset' '
+    git reset --hard foo-tag &&
+    [ "$(echo $(stg applied))" =3D "" ] &&
+    [ "$(echo $(stg unapplied))" =3D "p0 p1 p2 q0 p3 p4" ]
+'
+
+test_done
