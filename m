From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v9 6/6] remote-bzr: support the new 'force' option
Date: Sat, 12 Apr 2014 15:12:55 -0500
Message-ID: <1397333575-11614-7-git-send-email-felipe.contreras@gmail.com>
References: <1397333575-11614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>, Max Horn <max@quendi.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 22:23:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ4Sw-0007aI-KC
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 22:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756283AbaDLUXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 16:23:46 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:51067 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756221AbaDLUXT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 16:23:19 -0400
Received: by mail-oa0-f51.google.com with SMTP id i4so7754203oah.10
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 13:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X7tXtd4erxNzUsdUAfUfPoYcZriE+QjzD9Tlarc938g=;
        b=rWHRAIoUtgzvheFfu1b56cEjsIrchvPJlCCl2xPb4QQAWPbnryuUz3sTs8WcIDB/wz
         vtRcEdRcVjZ4FOM/RM1pQBXapqgfEV2mTu/hR/7bSceWbd2qRAOeeELFgSoBzBSbpME8
         yC0YNiz2kYjrIpFvcWvcd7IIT/tID8AUXSe7Lebj0/aQ9vagG2i6xmJWrMCkk51rLmZQ
         PkExBDpjZeo16OzFV30MMH1Y9O/mEeRDPHKCbAMPjDvcF2YyBtdEPzhAiZzAJxf50Ex5
         6OdiVWEyVSU7uYK55eVn2fYvipyj2sdDgi1miFUR3ho4yx4ZJneqsxGjFU/oIKf2Uptj
         H0mQ==
X-Received: by 10.182.120.40 with SMTP id kz8mr26429857obb.6.1397334199243;
        Sat, 12 Apr 2014 13:23:19 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id h3sm19177932obh.8.2014.04.12.13.23.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Apr 2014 13:23:17 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
In-Reply-To: <1397333575-11614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246183>

From: Richard Hansen <rhansen@bbn.com>

Signed-off-by: Richard Hansen <rhansen@bbn.com>
Acked-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 31 ++++++++++++++++++++++++++++++-
 contrib/remote-helpers/test-bzr.sh    | 22 +++++++++++++++++++++-
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 332aba7..5f4b2e3 100755
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
 
     marks = None
     is_tmp = False
@@ -904,6 +930,7 @@ def main(args):
     branches = {}
     peers = {}
     transports = []
+    force = False
 
     if alias[5:] == url:
         is_tmp = True
@@ -936,6 +963,8 @@ def main(args):
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
1.9.1+fc3.9.gc73078e
