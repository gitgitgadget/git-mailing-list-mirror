From: Scott Lamb <slamb@slamb.org>
Subject: [PATCH 1/2] git-p4: use subprocess in p4CmdList
Date: Sun, 15 Jul 2007 20:58:10 -0700
Message-ID: <11845582912155-git-send-email-slamb@slamb.org>
Cc: git@vger.kernel.org, Scott Lamb <slamb@slamb.org>
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Mon Jul 16 05:58:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAHj0-0004OG-3m
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 05:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760521AbXGPD6P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 23:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760570AbXGPD6P
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 23:58:15 -0400
Received: from hobbes.slamb.org ([208.78.103.243]:48987 "EHLO hobbes.slamb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760483AbXGPD6O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 23:58:14 -0400
Received: from hobbes.slamb.org (localhost [127.0.0.1])
	by hobbes.slamb.org (Postfix) with ESMTP id 3E97798105;
	Sun, 15 Jul 2007 20:58:12 -0700 (PDT)
X-Spam-Score: -4.4
X-Spam-Checker-Version: SpamAssassin 3.1.9 (2007-02-13) on hobbes.slamb.org
X-Spam-Level: 
X-Spam-Hammy: 0.001-+--H*r:172.16.0, 0.002-+--H*m:org
X-Spam-Status: No, score=-4.4 required=4.5 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.1.9
X-Spam-Spammy: 0.993-1--cmd, 0.958-1--verbose
Received: from localhost.localdomain (rosalyn.vpn.slamb.org [172.16.0.2])
	by hobbes.slamb.org (Postfix) with ESMTP;
	Sun, 15 Jul 2007 20:58:12 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.2.238.g7cbf2f2-dirty
X-Envelope-From: <slamb@slamb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52633>

This allows bidirectional piping - useful for "-x -" to avoid commandline
arguments - and is a step toward bypassing the shell.

Signed-off-by: Scott Lamb <slamb@slamb.org>
---
 contrib/fast-import/git-p4 |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index d877150..d93e656 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -63,21 +63,34 @@ def system(cmd):
     if os.system(cmd) != 0:
         die("command failed: %s" % cmd)
 
-def p4CmdList(cmd):
+def p4CmdList(cmd, stdin=None, stdin_mode='w+b'):
     cmd = "p4 -G %s" % cmd
     if verbose:
         sys.stderr.write("Opening pipe: %s\n" % cmd)
-    pipe = os.popen(cmd, "rb")
+
+    # Use a temporary file to avoid deadlocks without
+    # subprocess.communicate(), which would put another copy
+    # of stdout into memory.
+    stdin_file = None
+    if stdin is not None:
+        stdin_file = tempfile.TemporaryFile(prefix='p4-stdin', mode=stdin_mode)
+        stdin_file.write(stdin)
+        stdin_file.flush()
+        stdin_file.seek(0)
+
+    p4 = subprocess.Popen(cmd, shell=True,
+                          stdin=stdin_file,
+                          stdout=subprocess.PIPE)
 
     result = []
     try:
         while True:
-            entry = marshal.load(pipe)
+            entry = marshal.load(p4.stdout)
             result.append(entry)
     except EOFError:
         pass
-    exitCode = pipe.close()
-    if exitCode != None:
+    exitCode = p4.wait()
+    if exitCode != 0:
         entry = {}
         entry["p4ExitCode"] = exitCode
         result.append(entry)
-- 
1.5.2.2.238.g7cbf2f2-dirty
