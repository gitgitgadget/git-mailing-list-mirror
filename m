From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v3] remote-bzr: support the new 'force' option
Date: Mon, 18 Nov 2013 00:08:39 -0500
Message-ID: <1384751319-18798-1-git-send-email-rhansen@bbn.com>
References: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Cc: git@vger.kernel.org, felipe.contreras@gmail.com,
	srabbelier@gmail.com, Richard Hansen <rhansen@bbn.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 18 06:09:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViH5B-000777-NT
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 06:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754Ab3KRFJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 00:09:06 -0500
Received: from smtp.bbn.com ([128.33.0.80]:53483 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703Ab3KRFJE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 00:09:04 -0500
Received: from socket.bbn.com ([192.1.120.102]:57945)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1ViH52-000A2e-3z; Mon, 18 Nov 2013 00:09:00 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 429883FFEF
X-Mailer: git-send-email 1.8.5.rc2.10.g50cf47a
In-Reply-To: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237975>

Signed-off-by: Richard Hansen <rhansen@bbn.com>
Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>
---

This is a reroll of:
  http://article.gmane.org/gmane.comp.version-control.git/237699
based on feedback from Felipe:
  http://article.gmane.org/gmane.comp.version-control.git/237756

This patch is an optional extension to Felipe's "transport-helper:
updates" patch series:
  http://thread.gmane.org/gmane.comp.version-control.git/237738
and it requires those changes to work.

Changes from v2:
  * remove 'import types' (no longer necessary)
  * change '(opt, val) = parser[1:3]' to 'opt, val = parser[1:3]'
  * add 'Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>'
    to commit message based on Felipe's comment in:
    http://article.gmane.org/gmane.comp.version-control.git/237756

 contrib/remote-helpers/git-remote-bzr | 31 ++++++++++++++++++++++++++++++-
 contrib/remote-helpers/test-bzr.sh    | 22 +++++++++++++++++++++-
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 7e34532..ea0e82a 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -684,7 +684,8 @@ def do_export(parser):
                 peer = bzrlib.branch.Branch.open(peers[name],
                                                  possible_transports=transports)
                 try:
-                    peer.bzrdir.push_branch(branch, revision_id=revid)
+                    peer.bzrdir.push_branch(branch, revision_id=revid,
+                                            overwrite=force)
                 except bzrlib.errors.DivergedBranches:
                     print "error %s non-fast forward" % ref
                     continue
@@ -718,8 +719,32 @@ def do_capabilities(parser):
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
+    opt, val = parser[1:3]
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
 
@@ -882,6 +907,7 @@ def main(args):
     global is_tmp
     global branches, peers
     global transports
+    global force
 
     alias = args[1]
     url = args[2]
@@ -895,6 +921,7 @@ def main(args):
     branches = {}
     peers = {}
     transports = []
+    force = False
 
     if alias[5:] == url:
         is_tmp = True
@@ -930,6 +957,8 @@ def main(args):
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
1.8.5.rc2.10.g50cf47a
