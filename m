From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/6] Add a testcase for ACL with restrictive umask.
Date: Mon, 22 Feb 2010 23:32:11 +0100
Message-ID: <1266877936-13537-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1266597207-32036-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: nhat minh le <nhat.minh.le@huoc.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 22 23:33:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njgq9-0000Ua-Bn
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 23:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754821Ab0BVWdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 17:33:16 -0500
Received: from mx1.imag.fr ([129.88.30.5]:50677 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754365Ab0BVWdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 17:33:16 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o1MMU78Z027772
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 22 Feb 2010 23:30:07 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NjgpI-0007kb-W3; Mon, 22 Feb 2010 23:32:29 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NjgpI-0003XH-Ux; Mon, 22 Feb 2010 23:32:28 +0100
X-Mailer: git-send-email 1.7.0.54.gb6a04.dirty
In-Reply-To: <1266597207-32036-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 22 Feb 2010 23:30:07 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140725>

Right now, Git creates unreadable pack files on non-shared
repositories when the user has a umask of 077, even when the default
ACLs for the directory would give read/write access to a specific
user.

Loose object files are created world-readable, which doesn't break ACLs,
but isn't necessarily desirable.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 t/t1304-default-acl.sh |   67 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)
 create mode 100755 t/t1304-default-acl.sh

diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
new file mode 100755
index 0000000..07dd6af
--- /dev/null
+++ b/t/t1304-default-acl.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Matthieu Moy
+#
+
+test_description='Test repository with default ACL'
+
+# Create the test repo with restrictive umask
+# => this must come before . ./test-lib.sh
+umask 077
+
+. ./test-lib.sh
+
+# We need an arbitrary other user give permission to using ACLs. root
+# is a good candidate: exists on all unices, and it has permission
+# anyway, so we don't create a security hole running the testsuite.
+
+if ! setfacl -m u:root:rwx .; then
+    say "Skipping ACL tests: unable to use setfacl"
+    test_done
+fi
+
+modebits () {
+	ls -l "$1" | sed -e 's|^\(..........\).*|\1|'
+}
+
+check_perms_and_acl () {
+	actual=$(modebits "$1") &&
+	case "$actual" in
+	-r--r-----*)
+		: happy
+		;;
+	*)
+		echo "Got permission '$actual', expected '-r--r-----'"
+		false
+		;;
+	esac &&
+	getfacl "$1" > actual &&
+	grep -q "user:root:rwx" actual &&
+	grep -q "user:${LOGNAME}:rwx" actual &&
+	grep -q "mask::r--" actual &&
+	grep -q "group::---" actual || false
+}
+
+dirs_to_set="./ .git/ .git/objects/ .git/objects/pack/"
+
+test_expect_success 'Setup test repo' '
+	setfacl -m u:root:rwx          $dirs_to_set &&
+	setfacl -d -m u:"$LOGNAME":rwx $dirs_to_set &&
+	setfacl -d -m u:root:rwx       $dirs_to_set &&
+
+	touch file.txt &&
+	git add file.txt &&
+	git commit -m "init"
+'
+
+test_expect_failure 'Objects creation does not break ACLs with restrictive umask' '
+	# SHA1 for empty blob
+	check_perms_and_acl .git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391
+'
+
+test_expect_failure 'git gc does not break ACLs with restrictive umask' '
+	git gc &&
+	check_perms_and_acl .git/objects/pack/*.pack
+'
+
+test_done
-- 
1.7.0.54.gb6a04.dirty
