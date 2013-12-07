From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v8 6/6] remote-bzr: support the new 'force' option
Date: Sat,  7 Dec 2013 15:08:12 -0600
Message-ID: <1386450492-22348-7-git-send-email-felipe.contreras@gmail.com>
References: <1386450492-22348-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 07 22:16:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpPEN-0002zd-Fl
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 22:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759097Ab3LGVQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 16:16:04 -0500
Received: from mail-ob0-f171.google.com ([209.85.214.171]:59502 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758934Ab3LGVP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 16:15:59 -0500
Received: by mail-ob0-f171.google.com with SMTP id wp18so2255095obc.30
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 13:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E69U+IllsIVgOljOv38i54lrNVqAV4Q3DjxQew6y1t4=;
        b=BsabI4wcL72I9sXedOqqCfm8Rx2xya8O9n9cA9r0hJuPQp9w/oU4Dbn1hjfrFeOqMH
         OPlduCUq0YW+r6GqusJ1ZXxlVpOXuYRou6caZ/dOy/J8eDPjbY8d3dT1680equgwJYbG
         BMPue5bS3vi7zPjXxOY68TVMi1i71ecJ3Qe2T8gxckiTRmd1lpbHHX0qnhEeScmbkZtP
         oDUY1NmOtQUjSry8orYws02e5gs4wfRUpKbhC/Pw+E75dc8NVvfUEqYcddZQoqry5pZQ
         cz9L17oemhz4V7cr9/Bj3gMDUB1uwIEp1/FmddRLteMy43Qz441+nx1XTLJ4yVrUh22T
         AyyQ==
X-Received: by 10.60.47.228 with SMTP id g4mr7634638oen.10.1386450959462;
        Sat, 07 Dec 2013 13:15:59 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id m4sm7801938oen.7.2013.12.07.13.15.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2013 13:15:58 -0800 (PST)
X-Mailer: git-send-email 1.8.5.1+fc1
In-Reply-To: <1386450492-22348-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239026>

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
index 054161a..f1ba477 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -685,7 +685,8 @@ def do_export(parser):
                 peer = bzrlib.branch.Branch.open(peers[name],
                                                  possible_transports=transports)
                 try:
-                    peer.bzrdir.push_branch(branch, revision_id=revid)
+                    peer.bzrdir.push_branch(branch, revision_id=revid,
+                                            overwrite=force)
                 except bzrlib.errors.DivergedBranches:
                     print "error %s non-fast forward" % ref
                     continue
@@ -719,8 +720,32 @@ def do_capabilities(parser):
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
 
@@ -883,6 +908,7 @@ def main(args):
     global is_tmp
     global branches, peers
     global transports
+    global force
 
     alias = args[1]
     url = args[2]
@@ -896,6 +922,7 @@ def main(args):
     branches = {}
     peers = {}
     transports = []
+    force = False
 
     if alias[5:] == url:
         is_tmp = True
@@ -931,6 +958,8 @@ def main(args):
             do_import(parser)
         elif parser.check('export'):
             do_export(parser)
+        elif parser.check('option'):
+            do_option(parser)
         else:
             die('unhandled command: %s' % line)
         sys.stdout.flush()
diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
index 5c50251..ae26dbb 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -65,13 +65,33 @@ test_expect_success 'pushing' '
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
1.8.5.1+fc1
