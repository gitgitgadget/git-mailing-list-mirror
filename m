From: Scott Lamb <slamb@slamb.org>
Subject: [PATCH 2/2] git-p4: input to "p4 files" by stdin instead of arguments
Date: Sun, 15 Jul 2007 20:58:11 -0700
Message-ID: <11845582942124-git-send-email-slamb@slamb.org>
References: <11845582912155-git-send-email-slamb@slamb.org>
Cc: git@vger.kernel.org, Scott Lamb <slamb@slamb.org>
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Mon Jul 16 05:58:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAHj7-0004Od-6S
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 05:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760687AbXGPD6S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 23:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760626AbXGPD6S
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 23:58:18 -0400
Received: from hobbes.slamb.org ([208.78.103.243]:48992 "EHLO hobbes.slamb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760582AbXGPD6R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 23:58:17 -0400
Received: from hobbes.slamb.org (localhost [127.0.0.1])
	by hobbes.slamb.org (Postfix) with ESMTP id 8F0F698328;
	Sun, 15 Jul 2007 20:58:14 -0700 (PDT)
X-Spam-Score: -4.4
X-Spam-Checker-Version: SpamAssassin 3.1.9 (2007-02-13) on hobbes.slamb.org
X-Spam-Level: 
X-Spam-Hammy: 0.001-+--H*r:172.16.0, 0.001-+--posix
X-Spam-Status: No, score=-4.4 required=4.5 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.1.9
X-Spam-Spammy: 0.978-1--alex, 0.958-1--bypasses
Received: from localhost.localdomain (rosalyn.vpn.slamb.org [172.16.0.2])
	by hobbes.slamb.org (Postfix) with ESMTP;
	Sun, 15 Jul 2007 20:58:14 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.2.238.g7cbf2f2-dirty
In-Reply-To: <11845582912155-git-send-email-slamb@slamb.org>
X-Envelope-From: <slamb@slamb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52634>

This approach, suggested by Alex Riesen, bypasses the need for xargs-style
argument list handling. The handling in question looks broken in a corner
case with SC_ARG_MAX=4096 and final argument over 96 characters.

Signed-off-by: Scott Lamb <slamb@slamb.org>
---
 contrib/fast-import/git-p4 |   28 +++++++---------------------
 1 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index d93e656..54053e3 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -725,27 +725,13 @@ class P4Sync(Command):
         if not files:
             return
 
-        # We cannot put all the files on the command line
-        # OS have limitations on the max lenght of arguments
-        # POSIX says it's 4096 bytes, default for Linux seems to be 130 K.
-        # and all OS from the table below seems to be higher than POSIX.
-        # See http://www.in-ulm.de/~mascheck/various/argmax/
-        if (self.isWindows):
-            argmax = 2000
-        else:
-            argmax = min(4000, os.sysconf('SC_ARG_MAX'))
-
-        chunk = ''
-        filedata = []
-        for i in xrange(len(files)):
-            f = files[i]
-            chunk += '"%s#%s" ' % (f['path'], f['rev'])
-            if len(chunk) > argmax or i == len(files)-1:
-                data = p4CmdList('print %s' % chunk)
-                if "p4ExitCode" in data[0]:
-                    die("Problems executing p4. Error: [%d]." % (data[0]['p4ExitCode']));
-                filedata.extend(data)
-                chunk = ''
+        filedata = p4CmdList('-x - print',
+                             stdin='\n'.join(['%s#%s' % (f['path'], f['rev'])
+                                              for f in files]),
+                             stdin_mode='w+')
+        if "p4ExitCode" in filedata[0]:
+            die("Problems executing p4. Error: [%d]."
+                % (filedata[0]['p4ExitCode']));
 
         j = 0;
         contents = {}
-- 
1.5.2.2.238.g7cbf2f2-dirty
