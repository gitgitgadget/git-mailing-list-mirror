From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2] remote-bzr: support the new 'force' option
Date: Tue, 12 Nov 2013 02:03:28 -0500
Message-ID: <1384239808-19065-1-git-send-email-rhansen@bbn.com>
References: <1384210507-26561-2-git-send-email-felipe.contreras@gmail.com>
Cc: felipe.contreras@gmail.com, srabbelier@gmail.com,
	Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 08:04:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg81Q-0005I7-O0
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 08:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754939Ab3KLHEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 02:04:16 -0500
Received: from smtp.bbn.com ([128.33.0.80]:63467 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754705Ab3KLHDx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 02:03:53 -0500
Received: from socket.bbn.com ([192.1.120.102]:57722)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Vg80t-000Mhm-HM; Tue, 12 Nov 2013 02:03:51 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id A9F323FF72
X-Mailer: git-send-email 1.8.5.rc1.208.g8ff7964
In-Reply-To: <1384210507-26561-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237699>

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---

This is a reroll of:
  http://article.gmane.org/gmane.comp.version-control.git/237607
based on feedback from Felipe:
  http://article.gmane.org/gmane.comp.version-control.git/237615

This patch is an optional extension to Felipe's "transport-helper:
updates" patch series:
  http://thread.gmane.org/gmane.comp.version-control.git/237663
and it requires those changes to work.

 contrib/remote-helpers/git-remote-bzr | 32 +++++++++++++++++++++++++++++++-
 contrib/remote-helpers/test-bzr.sh    | 22 +++++++++++++++++++++-
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 7e34532..2f481e9 100755
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
@@ -718,8 +720,32 @@ def do_capabilities(parser):
         print "*import-marks %s" % path
     print "*export-marks %s" % path
 
+    print "option"
     print
 
+class InvalidOptionValue(Exception):
+    pass
+
+def get_bool_option(val):
+    if val == 'true':
+        return True
+    elif val == 'false':
+        return False
+    else:
+        raise InvalidOptionValue()
+
+def do_option(parser):
+    global force
+    (opt, val) = parser[1:3]
+    try:
+        if opt == 'force':
+            force = get_bool_option(val)
+            print 'ok'
+        else:
+            print 'unsupported'
+    except InvalidOptionValue:
+        print "error '%s' is not a valid value for option '%s'" % (val, opt)
+
 def ref_is_valid(name):
     return not True in [c in name for c in '~^: \\']
 
@@ -882,6 +908,7 @@ def main(args):
     global is_tmp
     global branches, peers
     global transports
+    global force
 
     alias = args[1]
     url = args[2]
@@ -895,6 +922,7 @@ def main(args):
     branches = {}
     peers = {}
     transports = []
+    force = False
 
     if alias[5:] == url:
         is_tmp = True
@@ -930,6 +958,8 @@ def main(args):
             do_import(parser)
         elif parser.check('export'):
             do_export(parser)
+        elif parser.check('option'):
+            do_option(parser)
         else:
             die('unhandled command: %s' % line)
         sys.stdout.flush()
diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
index 1e53ff9..4f379c2 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -66,13 +66,33 @@ test_expect_success 'pushing' '
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
1.8.5.rc1.208.g8ff7964
