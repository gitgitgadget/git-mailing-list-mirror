From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [StGIT PATCH] Command to move a patch to the top
Date: Thu, 05 Oct 2006 23:14:28 +0200
Message-ID: <20061005211428.17126.50031.stgit@lathund.dewire.com>
References: <20061005211414.17126.64563.stgit@lathund.dewire.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Oct 05 23:15:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVaXn-0001zH-Us
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 23:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWJEVOK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 17:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWJEVOJ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 17:14:09 -0400
Received: from [83.140.172.130] ([83.140.172.130]:20584 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S1751340AbWJEVOD
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 5 Oct 2006 17:14:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id C3DBD8028A6
	for <git@vger.kernel.org>; Thu,  5 Oct 2006 23:11:06 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 15161-02 for <git@vger.kernel.org>; Thu,  5 Oct 2006 23:11:06 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.3])
	by torino.dewire.com (Postfix) with ESMTP id 3CACB802676
	for <git@vger.kernel.org>; Thu,  5 Oct 2006 23:11:06 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id C56F129006
	for <git@vger.kernel.org>; Thu,  5 Oct 2006 23:14:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id Xo0-DSohOXXG for <git@vger.kernel.org>;
	Thu,  5 Oct 2006 23:14:28 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id D46DF28F96
	for <git@vger.kernel.org>; Thu,  5 Oct 2006 23:14:28 +0200 (CEST)
To: git@vger.kernel.org
In-Reply-To: <20061005211414.17126.64563.stgit@lathund.dewire.com>
User-Agent: StGIT/0.10
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28371>

From: Robin Rosenberg <robin.rosenberg@dewire.com>


---

 stgit/commands/float.py |   78 +++++++++++++++++++++++++++++++++++++++++++++++
 stgit/main.py           |    3 ++
 t/t1500-float.sh        |   56 ++++++++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+), 0 deletions(-)

diff --git a/stgit/commands/float.py b/stgit/commands/float.py
new file mode 100644
index 0000000..3e39b35
--- /dev/null
+++ b/stgit/commands/float.py
@@ -0,0 +1,78 @@
+
+__copyright__ = """
+Copyright (C) 2006, Robin Rosenberg <robin.rosenberg@dewire.com>
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License version 2 as
+published by the Free Software Foundation.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program; if not, write to the Free Software
+Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+"""
+
+import sys, os
+from optparse import OptionParser, make_option
+
+from stgit.commands.common import *
+from stgit.utils import *
+from stgit import stack, git
+
+help = 'push a patch to the top, even if applied'
+usage = """%prog [options]
+
+Push a patch to the top even if applied. The necessary
+pop and push operations will be performed to accomplish
+this. """
+
+#options = [make_option('-b', '--branch',
+#                       help = 'use BRANCH instead of the default one')].
+
+options = [make_option('-a', '--all',
+                       help = 'push all the unapplied patches',
+                       action = 'store_true'),
+           make_option('--keep',
+                       help = 'keep the current working directory',
+                       action = 'store_true'),
+           make_option('-m', '--merged',
+                       help = 'check for patches merged upstream',
+                       action = 'store_true') ]
+           
+def func(parser, options, args):
+    """Pops and pushed to make the named patch the topmost patch
+    """
+
+    if not options.keep:
+        check_local_changes()
+        check_conflicts()
+        check_head_top_equal()
+
+    unapplied = crt_series.get_unapplied()
+    applied = crt_series.get_applied()
+    all = []
+    all.extend(unapplied)
+    all.extend(applied)
+
+    patches = parse_patches(args, all)
+
+    topush=[]
+    topop=[]
+
+    for p in patches:
+        while p in applied:
+            top = applied[-1]
+            print applied
+            if not top in patches:
+                topush.insert(0,top)
+            topop.append(top)
+            x = applied.pop()
+    for p in patches:
+        topush.append(p)
+
+    pop_patches(topop, options.keep)
+    push_patches(topush, options.merged)
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
index 0000000..dbcd8ce
--- /dev/null
+++ b/t/t1500-float.sh
@@ -0,0 +1,56 @@
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
+	 stg new G -m "g" && echo G >g.txt && stg add g.txt && stg refresh &&
+	 stg pop &&
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
+	'Float B C to top' \
+	'stg float B C &&
+	 test "`echo \`cat .git/patches/master/applied\``" = "D E F A B C"
+	'
+test_expect_success \
+	'Float E A to top' \
+	'stg float E A &&
+	 test "`echo \`cat .git/patches/master/applied\``" = "D F B C E A"
+	'
+test_expect_success \
+	'Float E to top' \
+	'stg float E &&
+	 test "`echo \`cat .git/patches/master/applied\``" = "D F B C A E"
+	'
+test_expect_success \
+	'Float G F to top' \
+	'stg float G F &&
+	 test "`echo \`cat .git/patches/master/applied\``" = "D B C A E G F"
+	'
+test_done
