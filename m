From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 5/6] New test: conflicting push in dirty worktree
Date: Thu, 20 Mar 2008 01:31:57 +0100
Message-ID: <20080320003157.13102.10350.stgit@yoghurt>
References: <20080320002604.13102.53757.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Sandberg <mandolaerik@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 01:32:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc8iD-0006sd-En
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 01:32:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763171AbYCTAcG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Mar 2008 20:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163279AbYCTAcF
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 20:32:05 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2861 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163278AbYCTAcD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 20:32:03 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1Jc8hI-0004so-00; Thu, 20 Mar 2008 00:31:56 +0000
In-Reply-To: <20080320002604.13102.53757.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77598>

When the result of a conflicting push can't be represented in the
worktree because the worktree is dirty, the push should be aborted.
Similarly, the push should be aborted if we have to do the merge in
the worktree, but can't because the worktree is dirty.

Add a new test that tests for this. It currently fails, in a bad way:
the contents of the pushed patch is lost.

(The test uses goto instead of push, because push doesn't use the new
infrastructure yet. And old-infrastructure commands never have this
bug, because they refuse to run with a dirty worktree.)

This bug was found by Erik Sandberg <mandolaerik@gmail.com>, who also
came up with the minimal test case that I turned into this new test.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/t3000-dirty-merge.sh |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)
 create mode 100755 t/t3000-dirty-merge.sh


diff --git a/t/t3000-dirty-merge.sh b/t/t3000-dirty-merge.sh
new file mode 100755
index 0000000..dd81c9e
--- /dev/null
+++ b/t/t3000-dirty-merge.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+
+test_description=3D'Try a push that requires merging a file that is di=
rty'
+
+. ./test-lib.sh
+
+test_expect_success 'Initialize StGit stack with two patches' '
+    stg init &&
+    touch a &&
+    git add a &&
+    git commit -m a &&
+    echo 1 > a &&
+    git commit -a -m p1 &&
+    echo 2 > a &&
+    git commit -a -m p2 &&
+    stg uncommit -n 2
+'
+
+test_expect_success 'Pop one patch and update the other' '
+    stg goto p1 &&
+    echo 3 > a &&
+    stg refresh
+'
+
+test_expect_failure 'Push with dirty worktree' '
+    echo 4 > a &&
+    [ "$(echo $(stg applied))" =3D "p1" ] &&
+    [ "$(echo $(stg unapplied))" =3D "p2" ] &&
+    ! stg goto p2 &&
+    [ "$(echo $(stg applied))" =3D "p1" ] &&
+    [ "$(echo $(stg unapplied))" =3D "p2" ] &&
+    [ "$(echo $(cat a))" =3D "4" ]
+'
+
+test_done
