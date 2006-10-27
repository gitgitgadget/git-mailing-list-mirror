X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen@helsinki.fi>
Subject: [PATCH] Fixes "stg goto `stg top`" to no-op & test
Date: Sat, 28 Oct 2006 02:15:42 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0610280156320.26765@kivilampi-30.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; boundary="-696243703-1865763695-1161990640=:26765"
NNTP-Posting-Date: Fri, 27 Oct 2006 23:15:53 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-X-Sender: ijjarvin@kivilampi-30.cs.helsinki.fi
Content-ID: <Pine.LNX.4.64.0610280210530.26765@kivilampi-30.cs.helsinki.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30352>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdavU-00005b-0z for gcvg-git@gmane.org; Sat, 28 Oct
 2006 01:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751045AbWJ0XPp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 19:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWJ0XPo
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 19:15:44 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:45217 "EHLO
 mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S1751045AbWJ0XPo
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 19:15:44 -0400
Received: from kivilampi-30.cs.helsinki.fi (kivilampi-30.cs.helsinki.fi
 [128.214.9.42]) (AUTH: PLAIN cs-relay, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
 by mail.cs.helsinki.fi with esmtp; Sat, 28 Oct 2006 02:15:43 +0300 id
 000AFD7D.4542931F.00002D39
Received: by kivilampi-30.cs.helsinki.fi (Postfix, from userid 50795) id
 E1552EAE9D; Sat, 28 Oct 2006 02:15:42 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1]) by
 kivilampi-30.cs.helsinki.fi (Postfix) with ESMTP id DA92BEAE9C; Sat, 28 Oct
 2006 02:15:42 +0300 (EEST)
To: catalin.marinas@gmail.com
Sender: git-owner@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---696243703-1865763695-1161990640=:26765
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0610280210531.26765@kivilampi-30.cs.helsinki.fi>

StGIT tried to access index that is not valid when goto'ing to
the current patch. Adds also a test for it.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@helsinki.fi>
---
 stgit/commands/common.py |   17 ++++++++++-------
 t/t1600-goto-top.sh      |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 1ea6025..88b1b94 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -200,16 +200,19 @@ def pop_patches(patches, keep = False):
     """Pop the patches in the list from the stack. It is assumed that
     the patches are listed in the stack reverse order.
     """
-    p = patches[-1]
-    if len(patches) == 1:
-        print 'Popping patch "%s"...' % p,
+    if len(patches) == 0:
+        print 'nothing to push/pop'
     else:
-        print 'Popping "%s" - "%s" patches...' % (patches[0], p),
-    sys.stdout.flush()
+        p = patches[-1]
+        if len(patches) == 1:
+            print 'Popping patch "%s"...' % p,
+        else:
+            print 'Popping "%s" - "%s" patches...' % (patches[0], p),
+        sys.stdout.flush()
 
-    crt_series.pop_patch(p, keep)
+        crt_series.pop_patch(p, keep)
 
-    print 'done'
+        print 'done'
 
 def parse_patches(patch_args, patch_list):
     """Parse patch_args list for patch names in patch_list and return
diff --git a/t/t1600-goto-top.sh b/t/t1600-goto-top.sh
new file mode 100755
index 0000000..94a88cf
--- /dev/null
+++ b/t/t1600-goto-top.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Catalin Marinas
+#
+
+test_description='Test the uncommit command.
+
+'
+
+. ./test-lib.sh
+
+test_expect_success \
+	'Initialize the StGIT repository' \
+	'stg init
+'
+
+test_expect_success \
+	'Create the first patch' \
+	'
+	stg new foo -m "Foo Patch" &&
+	echo foo > test &&
+	stg add test &&
+	stg refresh
+	'
+
+test_expect_success \
+	'Goto current patch' \
+	'
+	stg goto `stg top`
+	'
+
+test_done
-- 
1.4.2

