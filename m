From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [StGIT PATCH 1/3] Command to move a patch to the top
Date: Tue, 03 Oct 2006 23:34:53 +0200
Message-ID: <20061003213453.26195.54830.stgit@lathund.dewire.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Oct 03 23:34:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUruT-0003OJ-BE
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 23:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030561AbWJCVei (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 17:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030563AbWJCVei
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 17:34:38 -0400
Received: from [83.140.172.130] ([83.140.172.130]:18206 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S1030561AbWJCVef
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 Oct 2006 17:34:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id EA6968028A2
	for <git@vger.kernel.org>; Tue,  3 Oct 2006 23:31:38 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 22597-09 for <git@vger.kernel.org>; Tue,  3 Oct 2006 23:31:38 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.3])
	by torino.dewire.com (Postfix) with ESMTP id 4883D800782
	for <git@vger.kernel.org>; Tue,  3 Oct 2006 23:31:36 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 9E7FC28F58
	for <git@vger.kernel.org>; Tue,  3 Oct 2006 23:34:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id VHzJ-cCFAAK0 for <git@vger.kernel.org>;
	Tue,  3 Oct 2006 23:34:53 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 88E9E28AF4
	for <git@vger.kernel.org>; Tue,  3 Oct 2006 23:34:53 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: StGIT/0.10
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28305>

From: Robin Rosenberg <robin.rosenberg@dewire.com>


---

 stgit/main.py    |    3 +++
 t/t1500-float.sh |   44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/stgit/main.py b/stgit/main.py
index f59bce6..e9cc6cd 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -38,6 +38,7 @@ import stgit.commands.clone
 import stgit.commands.commit
 import stgit.commands.export
 import stgit.commands.files
+import stgit.commands.float
 import stgit.commands.fold
 import stgit.commands.goto
 import stgit.commands.id
@@ -77,6 +78,7 @@ commands = {
     'commit':   stgit.commands.commit,
     'export':   stgit.commands.export,
     'files':    stgit.commands.files,
+    'float':    stgit.commands.float,
     'fold':     stgit.commands.fold,
     'goto':     stgit.commands.goto,
     'id':       stgit.commands.id,
@@ -113,6 +115,7 @@ stackcommands = (
     'applied',
     'clean',
     'commit',
+    'float',
     'goto',
     'init',
     'pop',
diff --git a/t/t1500-float.sh b/t/t1500-float.sh
new file mode 100755
index 0000000..670050f
--- /dev/null
+++ b/t/t1500-float.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Robin Rosenberg
+#
+
+test_description='Test floating a number of patches to the top of the stack
+
+'
+
+. ./test-lib.sh
+
+test_expect_success \
+	'Initialize the StGIT repository' \
+	'stg init &&
+	 stg new A -m "a" && echo A >a.txt && stg add a.txt && stg refresh &&
+	 stg new B -m "b" && echo B >b.txt && stg add b.txt && stg refresh &&
+	 stg new C -m "c" && echo C >c.txt && stg add c.txt && stg refresh &&
+	 stg new D -m "d" && echo D >d.txt && stg add d.txt && stg refresh &&
+	 stg new E -m "e" && echo E >e.txt && stg add e.txt && stg refresh &&
+	 stg new F -m "f" && echo F >f.txt && stg add f.txt && stg refresh &&
+	 test "`echo \`cat .git/patches/master/applied\``" = "A B C D E F"
+	'
+
+test_expect_success \
+	'Float A to top' \
+	'stg float A &&
+	 test "`echo \`cat .git/patches/master/applied\``" = "B C D E F A"
+	'
+test_expect_success \
+	'Float A to top (noop)' \
+	'stg float A &&
+	 test "`echo \`cat .git/patches/master/applied\``" = "B C D E F A"
+	'
+test_expect_success \
+	'Float B C to top (noop)' \
+	'stg float B C &&
+	 test "`echo \`cat .git/patches/master/applied\``" = "D E F A B C"
+	'
+test_expect_success \
+	'Float E A to top (noop)' \
+	'stg float E A &&
+	 test "`echo \`cat .git/patches/master/applied\``" = "D F B C E A"
+	'
+test_done
