From: Scott Lamb <slamb@slamb.org>
Subject: [PATCH 4/4] git-p4import: partial history
Date: Sat,  2 Jun 2007 20:58:46 -0700
Message-ID: <11808431401213-git-send-email-slamb@slamb.org>
References: <4ACE2ABC-8D73-4097-87AC-F3B27EDA97DE@slamb.org>
 <1180843126948-git-send-email-slamb@slamb.org>
 <11808431291938-git-send-email-slamb@slamb.org>
 <11808431364066-git-send-email-slamb@slamb.org>
Cc: Scott Lamb <slamb@slamb.org>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jun 03 05:59:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuhFM-0000FV-9h
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 05:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763452AbXFCD7F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 23:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763449AbXFCD7F
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 23:59:05 -0400
Received: from hobbes.slamb.org ([208.78.103.243]:33673 "EHLO hobbes.slamb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763452AbXFCD7D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 23:59:03 -0400
Received: from hobbes.slamb.org (localhost [127.0.0.1])
	by hobbes.slamb.org (Postfix) with ESMTP id CCF90980B0;
	Sat,  2 Jun 2007 20:59:00 -0700 (PDT)
X-Spam-Score: -4.3
X-Spam-Checker-Version: SpamAssassin 3.1.8 (2007-02-13) on hobbes.slamb.org
X-Spam-Level: 
X-Spam-Hammy: 0.000-+--H*RT:rdns, 0.000-+--H*RT:intl
X-Spam-Status: No, score=-4.3 required=4.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.1.8
X-Spam-Spammy: 0.987-+--H*r:sk:hobbes.,
	0.976-+--HX-Spam-Relays-External:sk:hobbes.
Received: from localhost.localdomain (slamb-linux.vpn.slamb.org [172.16.0.6])
	by hobbes.slamb.org (Postfix) with ESMTP;
	Sat,  2 Jun 2007 20:59:00 -0700 (PDT)
X-Mailer: git-send-email 1.5.2
In-Reply-To: <11808431364066-git-send-email-slamb@slamb.org>
X-Envelope-From: <slamb@slamb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48973>

Allow importing partial history, which is quicker and may be necessary with
a low Perforce MaxScanRows limit.

Signed-off-by: Scott Lamb <slamb@slamb.org>
---
 Documentation/git-p4import.txt |    6 ++++++
 git-p4import.py                |   14 ++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-p4import.txt b/Documentation/git-p4import.txt
index 714abbe..bf40b5a 100644
--- a/Documentation/git-p4import.txt
+++ b/Documentation/git-p4import.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 `git-p4import` [-q|-v] [--notags] [--authors <file>] [-t <timezone>]
+               [--start-with <change>]
                <//p4repo/path> <branch>
 `git-p4import` --stitch <//p4repo/path>
 `git-p4import`
@@ -59,6 +60,11 @@ OPTIONS
 	etc.  You only need to specify this once, it will be saved in
 	the git config file for the repository.
 
+\--start-with::
+	Start the import with the given Perforce change. A partial history can
+	be much faster to generate and is possible even with a low MaxScanRows
+	limit.
+
 <//p4repo/path>::
 	The Perforce path that will be imported into the specified branch.
 
diff --git a/git-p4import.py b/git-p4import.py
index e7a52b3..c7a2033 100644
--- a/git-p4import.py
+++ b/git-p4import.py
@@ -33,7 +33,12 @@ def die(msg, *args):
     sys.exit(1)
 
 def usage():
-    print "USAGE: git-p4import [-q|-v]  [--authors=<file>]  [-t <timezone>]  [//p4repo/path <branch>]"
+    print "usage:"
+    print "  git-p4import [-q|-v] [--notags] [--authors <file>] [-t <timezone>]"
+    print "               [--start-with <change>]"
+    print "               <//p4repo/path> <branch>"
+    print "  git-p4import --stitch <//p4repo/path>"
+    print "  git-p4import"
     sys.exit(1)
 
 verbosity = 1
@@ -41,6 +46,7 @@ logfile = file("/dev/null", "a")
 ignore_warnings = False
 stitch = 0
 tagall = True
+start_with = 0
 
 def report(level, msg, *args):
     global verbosity
@@ -299,7 +305,8 @@ class git_command:
 
 try:
     opts, args = getopt.getopt(sys.argv[1:], "qhvt:",
-            ["authors=","help","stitch=","timezone=","log=","ignore","notags"])
+            ["authors=","help","stitch=","timezone=","log=","ignore","notags",
+             "start-with="])
 except getopt.GetoptError:
     usage()
 
@@ -316,6 +323,8 @@ for o, a in opts:
         usage()
     if o in ("--ignore"):
         ignore_warnings = True
+    if o in ("--start-with"):
+        start_with = int(a)
 
 git = git_command()
 branch=git.current_branch()
@@ -361,6 +370,7 @@ if stitch == 0:
     top = git.top_change(branch)
 else:
     top = 0
+top = max(top, start_with)
 changes = p4.changes(top)
 count = len(changes)
 if count == 0:
-- 
1.5.2
