From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v5 12/10] remote-bzr: support the new 'force' option
Date: Mon, 11 Nov 2013 00:10:56 -0500
Message-ID: <1384146656-11811-1-git-send-email-rhansen@bbn.com>
References: <1383212197-14259-2-git-send-email-felipe.contreras@gmail.com>
Cc: felipe.contreras@gmail.com, srabbelier@gmail.com,
	Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 11 06:11:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfjmJ-0006hV-A3
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 06:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392Ab3KKFLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 00:11:07 -0500
Received: from smtp.bbn.com ([128.33.1.81]:27784 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135Ab3KKFLF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 00:11:05 -0500
Received: from socket.bbn.com ([192.1.120.102]:44768)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VfjmB-000Jj8-UD; Mon, 11 Nov 2013 00:11:04 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 0FA2A3FFDE
X-Mailer: git-send-email 1.8.5.rc1.207.gc17dd22
In-Reply-To: <1383212197-14259-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237607>

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 contrib/remote-helpers/git-remote-bzr | 34 +++++++++++++++++++++++++++++++++-
 contrib/remote-helpers/test-bzr.sh    | 22 +++++++++++++++++++++-
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 7e34532..ba693d1 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -42,6 +42,7 @@ import json
 import re
 import StringIO
 import atexit, shutil, hashlib, urlparse, subprocess
+import types
 
 NAME_RE = re.compile('^([^<>]+)')
 AUTHOR_RE = re.compile('^([^<>]+?)? ?[<>]([^<>]*)(?:$|>)')
@@ -684,7 +685,8 @@ def do_export(parser):
                 peer = bzrlib.branch.Branch.open(peers[name],
                                                  possible_transports=transports)
                 try:
-                    peer.bzrdir.push_branch(branch, revision_id=revid)
+                    peer.bzrdir.push_branch(branch, revision_id=revid,
+                                            overwrite=force)
                 except bzrlib.errors.DivergedBranches:
                     print "error %s non-fast forward" % ref
                     continue
@@ -718,8 +720,34 @@ def do_capabilities(parser):
         print "*import-marks %s" % path
     print "*export-marks %s" % path
 
+    print "option"
     print
 
+class InvalidOptionValue(Exception):
+    pass
+
+def do_option(parser):
+    (opt, val) = parser[1:3]
+    handler = globals().get('do_option_' + opt)
+    if handler and type(handler) == types.FunctionType:
+        try:
+            handler(val)
+        except InvalidOptionValue:
+            print "error '%s' is not a valid value for option '%s'" % (val, opt)
+    else:
+        print "unsupported"
+
+def do_bool_option(val):
+    if val == 'true': ret = True
+    elif val == 'false': ret = False
+    else: raise InvalidOptionValue()
+    print "ok"
+    return ret
+
+def do_option_force(val):
+    global force
+    force = do_bool_option(val)
+
 def ref_is_valid(name):
     return not True in [c in name for c in '~^: \\']
 
@@ -882,6 +910,7 @@ def main(args):
     global is_tmp
     global branches, peers
     global transports
+    global force
 
     alias = args[1]
     url = args[2]
@@ -895,6 +924,7 @@ def main(args):
     branches = {}
     peers = {}
     transports = []
+    force = False
 
     if alias[5:] == url:
         is_tmp = True
@@ -930,6 +960,8 @@ def main(args):
             do_import(parser)
         elif parser.check('export'):
             do_export(parser)
+        elif parser.check('option'):
+            do_option(parser)
         else:
             die('unhandled command: %s' % line)
         sys.stdout.flush()
diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
index ea597b0..7d7778f 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -69,13 +69,33 @@ test_expect_success 'pushing' '
 	test_cmp expected actual
 '
 
+test_expect_success 'forced pushing' '
+	(
+	cd gitrepo &&
+	echo three-new >content &&
+	git commit -a --amend -m three-new &&
+	git push -f
+	) &&
+
+	(
+	cd bzrrepo &&
+	# the forced update overwrites the bzr branch but not the bzr
+	# working directory (it tries to merge instead)
+	bzr revert
+	) &&
+
+	echo three-new >expected &&
+	cat bzrrepo/content >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'roundtrip' '
 	(
 	cd gitrepo &&
 	git pull &&
 	git log --format="%s" -1 origin/master >actual
 	) &&
-	echo three >expected &&
+	echo three-new >expected &&
 	test_cmp expected actual &&
 
 	(cd gitrepo && git push && git pull) &&
-- 
1.8.5.rc1.207.gc17dd22
