From: Michael Gebetsroither <michael.geb@gmx.at>
Subject: [PATCH] hg-to-git speedup through selectable repack intervals
Date: Sat,  6 Oct 2007 23:16:51 +0200
Message-ID: <1191705411-18139-1-git-send-email-michael.geb@gmx.at>
Cc: Michael Gebetsroither <michael.geb@gmx.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 06 23:17:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeH1D-00047f-Qa
	for gcvg-git-2@gmane.org; Sat, 06 Oct 2007 23:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764456AbXJFVQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2007 17:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763854AbXJFVQy
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Oct 2007 17:16:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:42850 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763667AbXJFVQy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2007 17:16:54 -0400
Received: (qmail invoked by alias); 06 Oct 2007 21:16:52 -0000
Received: from 83-65-235-226.dynamic.xdsl-line.inode.at (EHLO localhost) [83.65.235.226]
  by mail.gmx.net (mp045) with SMTP; 06 Oct 2007 23:16:52 +0200
X-Authenticated: #11472313
X-Provags-ID: V01U2FsdGVkX19iRMF4875ibKK+TcLcLoygcTUxKsi4WmcVkQnSfd
	ki3h1DvhqqF5od
X-Mailer: git-send-email 1.5.3.4
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60158>

---
 contrib/hg-to-git/hg-to-git.py |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
index 37337ff..7a1c3e4 100755
--- a/contrib/hg-to-git/hg-to-git.py
+++ b/contrib/hg-to-git/hg-to-git.py
@@ -29,6 +29,8 @@ hgvers = {}
 hgchildren = {}
 # Current branch for each hg revision
 hgbranch = {}
+# Number of new changesets converted from hg
+hgnewcsets = 0
 
 #------------------------------------------------------------------------------
 
@@ -40,6 +42,8 @@ def usage():
 options:
     -s, --gitstate=FILE: name of the state to be saved/read
                          for incrementals
+    -n, --nrepack=INT:   number of changesets that will trigger
+                         a repack (default=0, -1 to deactivate)
 
 required:
     hgprj:  name of the HG project to import (directory)
@@ -68,14 +72,16 @@ def getgitenv(user, date):
 #------------------------------------------------------------------------------
 
 state = ''
+opt_nrepack = 0
 
 try:
-    opts, args = getopt.getopt(sys.argv[1:], 's:t:', ['gitstate=', 'tempdir='])
+    opts, args = getopt.getopt(sys.argv[1:], 's:t:n:', ['gitstate=', 'tempdir=', 'nrepack='])
     for o, a in opts:
         if o in ('-s', '--gitstate'):
             state = a
             state = os.path.abspath(state)
-
+        if o in ('-n', '--nrepack'):
+            opt_nrepack = int(a)
     if len(args) != 1:
         raise('params')
 except:
@@ -138,6 +144,7 @@ for cset in range(int(tip) + 1):
     # incremental, already seen
     if hgvers.has_key(str(cset)):
         continue
+    hgnewcsets += 1
 
     # get info
     prnts = os.popen('hg log -r %d | grep ^parent: | cut -f 2 -d :' % cset).readlines()
@@ -222,7 +229,8 @@ for cset in range(int(tip) + 1):
     print 'record', cset, '->', vvv
     hgvers[str(cset)] = vvv
 
-os.system('git-repack -a -d')
+if hgnewcsets >= opt_nrepack and opt_nrepack != -1:
+    os.system('git-repack -a -d')
 
 # write the state for incrementals
 if state:
-- 
1.5.3.4
