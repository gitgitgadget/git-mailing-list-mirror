From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: [RFC PATCH 1/2] Add failing test for "git pull" in symlinked directory
Date: Sat, 15 Nov 2008 07:11:34 -0800
Message-ID: <096bfa3393a6c5ccaa550ae6363e7fcfc90867d1.1226759762.git.marcel@oak.homeunix.org>
References: <cover.1226759762.git.marcel@oak.homeunix.org>
Cc: "Marcel M. Cary" <marcel@oak.homeunix.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 15 16:19:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1MwB-0002IV-RI
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 16:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbYKOPS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 10:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbYKOPS1
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 10:18:27 -0500
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:32916 "HELO
	smtp104.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751426AbYKOPS0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Nov 2008 10:18:26 -0500
Received: (qmail 61903 invoked from network); 15 Nov 2008 15:11:46 -0000
Received: from unknown (HELO ordinateur.home.org) (marcel@76.231.190.99 with plain)
  by smtp104.sbc.mail.mud.yahoo.com with SMTP; 15 Nov 2008 15:11:45 -0000
X-YMail-OSG: U3qc568VM1kKfMRANSHUqsuiWCyyCTup4JNCpWzdjmNWzNtqXsUkYSnvowhAjFN2etsKRk6P7gHtptGo71ZocX7oXmgRjrB11K4wVlfUNz1UEEGw9szcu.QuxO0fHRV.vXOKVxU6_Oqt_CQTUpCmK7FUoDBLYfUJIIJ7.C8NAT1xWZXe
X-Yahoo-Newman-Property: ymail-5
Received: from polliwog.home.org ([192.168.0.18] helo=localhost.localdomain)
	by ordinateur.home.org with esmtp (Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1L1MoC-0006gV-6U; Sat, 15 Nov 2008 07:11:36 -0800
X-Mailer: git-send-email 1.6.0.3
In-Reply-To: <cover.1226759762.git.marcel@oak.homeunix.org>
In-Reply-To: <cover.1226759762.git.marcel@oak.homeunix.org>
References: <cover.1226759762.git.marcel@oak.homeunix.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101072>

* Illustrate the scenario of interest and show how it breaks
* Show a contrasting working "git pull" without the symlink
* Show a contrasting working "git push" with the symlink

Signed-off-by: Marcel M. Cary <marcel@oak.homeunix.org>
---
 t/t5521-pull-symlink.sh |   67 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/t/t5521-pull-symlink.sh b/t/t5521-pull-symlink.sh
new file mode 100644
index 0000000..683784d
--- /dev/null
+++ b/t/t5521-pull-symlink.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+
+test_description='pulling from symlinked subdir'
+
+. ./test-lib.sh
+
+D=`pwd`
+
+# The scenario we are building:
+#
+#   trash\ directory/
+#     clone-repo/
+#       subdir/
+#         bar
+#     subdir-link -> clone-repo/subdir/
+#
+# The working directory is subdir-link.
+#
+test_expect_success setup '
+
+    mkdir subdir &&
+    touch subdir/bar &&
+    git add subdir/bar &&
+    git commit -m empty &&
+    git clone . clone-repo &&
+    # demonstrate that things work without the symlink
+    test_debug "cd clone-repo/subdir/ && git pull; cd ../.." &&
+    ln -s clone-repo/subdir/ subdir-link &&
+    cd subdir-link/ &&
+    test_debug "set +x"
+'
+
+# From subdir-link, pulling should work as it does from
+# clone-repo/subdir/.
+#
+# Instead, the error pull gave was:
+#
+#   fatal: 'origin': unable to chdir or not a git archive
+#   fatal: The remote end hung up unexpectedly
+#
+# bacause git would find the .git/config for the trash\ directory
+# repo, not for the clone-repo repo.  The trash\ directory repo
+# had no entry for origin.  Git found the wrong .git because
+# git rev-parse --show-cdup printed a path relative to
+# clone-repo/subdir/, not subdir-link/.  Git rev-parse --show-cdup
+# used the correct .git, but when the git pull shell script did
+# "cd `git rev-parse --show-cdup`", it ended up in the wrong
+# directory.  Shell "cd" works a little different from chdir() in C.
+# Bash's "cd -P" works like chdir() in C.
+#
+test_expect_failure 'pulling from symlinked subdir' '
+
+    git pull
+'
+
+# Prove that the remote end really is a repo, and other commands
+# work fine in this context.
+#
+test_debug "
+    test_expect_success 'pushing from symlinked subdir' '
+
+        git push
+    '
+"
+cd "$D"
+
+test_done
-- 
1.6.0.3
