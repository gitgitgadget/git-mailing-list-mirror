From: Kevin Green <Kevin.T.Green@morganstanley.com>
Subject: [PATCH] git-p4: Fix race between p4_edit and p4_change
Date: Tue, 1 Apr 2008 18:28:56 -0400
Message-ID: <20080401222856.GA22542@morganstanley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Simon Hausmann <simon@lst.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 02 00:39:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jgp8l-0007La-PA
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 00:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756856AbYDAWiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 18:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758916AbYDAWiv
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 18:38:51 -0400
Received: from pimtabh4.ms.com ([199.89.64.104]:58957 "EHLO pimtabh4.ms.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756856AbYDAWit (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 18:38:49 -0400
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Apr 2008 18:38:49 EDT
Received: from pimtabh4 (localhost.ms.com [127.0.0.1])
	by pimtabh4.ms.com (output Postfix) with ESMTP id AE57248366;
	Tue,  1 Apr 2008 18:28:57 -0400 (EDT)
Received: from ny0030as01 (unknown [144.203.194.92])
	by pimtabh4.ms.com (internal Postfix) with ESMTP id 1BDE44A801B;
	Tue,  1 Apr 2008 18:28:57 -0400 (EDT)
Received: from hn315c1n6 (localhost [127.0.0.1])
	by ny0030as01 (msa-out Postfix) with ESMTP id 09F91AE4164;
	Tue,  1 Apr 2008 18:28:57 -0400 (EDT)
Received: from menevado.ms.com (unknown [144.203.222.190])
	by ny0030as01 (msa-in Postfix) with ESMTP id DCEE88A002E;
	Tue,  1 Apr 2008 18:28:56 -0400 (EDT)
Received: (kgreen@localhost) by menevado.ms.com (8.12.11.20060308/sendmail.cf.client v1.05) id m31MSuL1022622; Tue, 1 Apr 2008 18:28:56 -0400
X-Authentication-Warning: menevado.ms.com: kgreen set sender to Kevin.T.Green@morganstanley.com using -f
Mail-Followup-To: Simon Hausmann <simon@lst.de>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Anti-Virus: Kaspersky Anti-Virus for MailServers 5.5.15/RELEASE, bases: 01042008 #607456, status: clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78666>


Hi,

Ran into a nasty race today with git-p4.  The changelist Files: section was
showing up empty and it turned out to be a race between the p4_edit and
p4_change -o, e.g.

$ p4 edit $file && p4 change -o

will show no files in the Files: section.

I attach a patch after my .sig as a suggested fix.  It simply loops over the
p4_changes -o as long as we're not finding any files (and we always should
since we just did a p4_edit!); sleeping for 3 secs in between to allow
Perforce to catch up with itself.

Thanks

--Kevin


>From 9b3b151f46dc30b9087010bb06defad9d06dfc72 Mon Sep 17 00:00:00 2001
From: Kevin Green <Kevin.Green@morganstanley.com>
Date: Tue, 1 Apr 2008 18:11:32 -0400
Subject: [PATCH] git-p4: Fix race between p4_edit and p4_change

While generating the changelist from 'p4 change -o' it's possible
that perforce hasn't caught up from the preceding 'p4 edit $file'.
This leaves us with a Files: section that is completely empty and
subsequently the p4_submit fails.

This fix loops over a flag for finding something in the Files: section.
We just did a p4_edit so there must be something there.  If nothing's
found, then sleep for a short time (3 secs) and try all over again.

Signed-off-by: Kevin Green <Kevin.Green@morganstanley.com>
---
 contrib/fast-import/git-p4 |   46 +++++++++++++++++++++++++------------------
 1 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index d8de9f6..5ae71ad 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -510,27 +510,35 @@ class P4Submit(Command):
 
     def prepareSubmitTemplate(self):
         # remove lines in the Files section that show changes to files outside the depot path we're committing into
-        template = ""
-        inFilesSection = False
-        for line in read_pipe_lines("p4 change -o"):
-            if line.endswith("\r\n"):
-                line = line[:-2] + "\n"
-            if inFilesSection:
-                if line.startswith("\t"):
-                    # path starts and ends with a tab
-                    path = line[1:]
-                    lastTab = path.rfind("\t")
-                    if lastTab != -1:
-                        path = path[:lastTab]
-                        if not path.startswith(self.depotPath):
-                            continue
+        notdone = True
+        while notdone:
+            template = ""
+            inFilesSection = False
+            for line in read_pipe_lines("p4 change -o"):
+                if line.endswith("\r\n"):
+                    line = line[:-2] + "\n"
+                if inFilesSection:
+                    if line.startswith("\t"):
+                        # path starts and ends with a tab
+                        path = line[1:]
+                        lastTab = path.rfind("\t")
+                        if lastTab != -1:
+                            path = path[:lastTab]
+                            if not path.startswith(self.depotPath):
+                                continue
+                            else:
+                                notdone = False
+                    else:
+                        inFilesSection = False
                 else:
-                    inFilesSection = False
-            else:
-                if line.startswith("Files:"):
-                    inFilesSection = True
+                    if line.startswith("Files:"):
+                        inFilesSection = True
+
+                template += line
 
-            template += line
+            # Perforce hasn't caught up with itself yet, so wait a bit and try again
+            print "Waiting for Perforce to catch up"
+            time.sleep(3)
 
         return template
 
-- 
1.5.4.2
