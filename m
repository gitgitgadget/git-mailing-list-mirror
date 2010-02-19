From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/4] Add a testcase for ACL with restrictive umask.
Date: Fri, 19 Feb 2010 17:33:24 +0100
Message-ID: <1266597207-32036-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1266597207-32036-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 19 17:37:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiVrF-00085l-0s
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 17:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383Ab0BSQhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 11:37:32 -0500
Received: from imag.imag.fr ([129.88.30.1]:40395 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752126Ab0BSQhc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 11:37:32 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o1JGXc25021254
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 19 Feb 2010 17:33:38 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NiVnO-0006F3-FX; Fri, 19 Feb 2010 17:33:38 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NiVnO-0008Lb-EK; Fri, 19 Feb 2010 17:33:38 +0100
X-Mailer: git-send-email 1.7.0.rc2.4.gc602c4
In-Reply-To: <1266597207-32036-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 19 Feb 2010 17:33:38 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140463>

Right now, Git creates unreadable pack files on non-shared
repositories when the user has a umask of 077, even when the default
ACLs for the directory would give read/write access to a specific
user.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 t/t1304-default-acl.sh |   49 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)
 create mode 100755 t/t1304-default-acl.sh

diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
new file mode 100755
index 0000000..4ee44a1
--- /dev/null
+++ b/t/t1304-default-acl.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Matthieu Moy
+#
+
+test_description='Test repository with default ACL'
+
+. ./test-lib.sh
+
+# We need an arbitrary other user give permission to using ACLs. root
+# is a good candidate: exists on all unices, and it has permission
+# anyway, so we don't create a security hole running the testsuite.
+
+if ! setfacl -Rm u:root:rwx .; then
+    say "Skipping ACL tests: unable to use setfacl"
+    test_done
+fi
+
+setfacl -Rm d:u:"$LOGNAME":rwx .
+setfacl -Rm d:u:root:rwx .
+
+touch file.txt
+git add file.txt
+git commit -m "init"
+
+modebits () {
+	ls -l "$1" | sed -e 's|^\(..........\).*|\1|'
+}
+
+test_expect_failure 'git gc does not break ACLs with restrictive umask' '
+	umask 077 &&
+	git gc &&
+	actual=$(modebits .git/objects/pack/*.pack) &&
+	case "$actual" in
+	-r--r-----*)
+		: happy
+		;;
+	*)
+		false
+		;;
+	esac &&
+	getfacl .git/objects/pack/*.pack > actual &&
+	grep -q "user:root:rwx" actual &&
+	grep -q "user:${LOGNAME}:rwx" actual &&
+	grep -q "mask::r--" actual &&
+	grep -q "group::---" actual
+'
+
+test_done
-- 
1.7.0.rc2.4.gc602c4
