From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 03/11] git-p4: clone does not use --git-dir
Date: Sat, 17 Dec 2011 13:52:14 -0500
Message-ID: <1324147942-21558-4-git-send-email-pw@padd.com>
References: <1324147942-21558-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 19:54:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbzOV-0002e8-Gv
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 19:54:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683Ab1LQSyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 13:54:00 -0500
Received: from honk.padd.com ([74.3.171.149]:48981 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752677Ab1LQSxz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 13:53:55 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id 2C38F1C89;
	Sat, 17 Dec 2011 10:53:52 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 2743C314AB; Sat, 17 Dec 2011 13:53:23 -0500 (EST)
X-Mailer: git-send-email 1.7.8.283.g3bcee.dirty
In-Reply-To: <1324147942-21558-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187391>

Complain if --git-dir is given during a clone.  It has no
effect.  Only --destination and --bare can change where the newly
cloned git dir will be.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |    3 ++-
 t/t9806-options.sh         |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletions(-)
 create mode 100755 t/t9806-options.sh

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 7d8e74b..14d6d7d 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -2331,7 +2331,8 @@ def main():
     args = sys.argv[2:]
 
     if len(options) > 0:
-        options.append(optparse.make_option("--git-dir", dest="gitdir"))
+        if cmd.needsGit:
+            options.append(optparse.make_option("--git-dir", dest="gitdir"))
 
         parser = optparse.OptionParser(cmd.usage.replace("%prog", "%prog " + cmdName),
                                        options,
diff --git a/t/t9806-options.sh b/t/t9806-options.sh
new file mode 100755
index 0000000..8044fb0
--- /dev/null
+++ b/t/t9806-options.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+
+test_description='git-p4 options'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'init depot' '
+	(
+		cd "$cli" &&
+		echo file1 >file1 &&
+		p4 add file1 &&
+		p4 submit -d "change 1" &&
+		echo file2 >file2 &&
+		p4 add file2 &&
+		p4 submit -d "change 2" &&
+		echo file3 >file3 &&
+		p4 add file3 &&
+		p4 submit -d "change 3"
+	)
+'
+
+test_expect_success 'clone no --git-dir' '
+	test_must_fail "$GITP4" clone --git-dir=xx //depot
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
1.7.8.258.g45cc3c
