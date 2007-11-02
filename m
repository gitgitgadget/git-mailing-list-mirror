From: Chris Pettitt <cpettitt@gmail.com>
Subject: [PATCH] git-p4: Add a helper function to parse the full git diff-tree output.
Date: Thu,  1 Nov 2007 20:43:13 -0700
Message-ID: <1193974994-19211-1-git-send-email-cpettitt@gmail.com>
Cc: Chris Pettitt <cpettitt@gmail.com>
To: Simon Hausmann <simon@lst.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 04:43:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InnRW-0000Bb-3D
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 04:43:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbXKBDnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 23:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752336AbXKBDnU
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 23:43:20 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:60425 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbXKBDnT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 23:43:19 -0400
Received: by wa-out-1112.google.com with SMTP id v27so805091wah
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 20:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=u9hz+7t7deehd6jmtOOfBVP4S1VhVOO/xDxz//AdiQ0=;
        b=L8z11rLqiqz+4KuBPpopBffcMsRxsG1eSJX/kw/yHoybw7Ryuot7ThO3De05sI2pQckYNfyrzxwUj4dok6ZhtBK7FkS/A4CHOQ61lT2DSxDo3b5Od/5aJUHetQMGf44Tv7sftxBM5IiSXa0d06cMiMItyql8P4z9JFjlnWCiz1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=UlexCYH1WhPVstlQCeT1PHuI55tYeOsDJTfeDxjjrCyaQq3LnHvN/CSXHtbKOYXEmcHHRSdMv9a7MVxsi6+hsMfueHlS37IzUXOn1+Nqyt6oVKs8xqEixocXlxmk3EAAhOvbM3r0nT5ux83G0n7BYSdfgp5iJl+KzEBnmz2k7OY=
Received: by 10.115.108.1 with SMTP id k1mr1398202wam.1193974999018;
        Thu, 01 Nov 2007 20:43:19 -0700 (PDT)
Received: from localhost ( [76.236.71.63])
        by mx.google.com with ESMTPS id j28sm3434860waf.2007.11.01.20.43.15
        (version=SSLv3 cipher=OTHER);
        Thu, 01 Nov 2007 20:43:16 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.498.g9c514
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63055>


Signed-off-by: Chris Pettitt <cpettitt@gmail.com>
---
 contrib/fast-import/git-p4 |   49 ++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index bf33f74..c7fc564 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -71,6 +71,46 @@ def isP4Exec(kind):
     a plus sign, it is also executable"""
     return (re.search(r"(^[cku]?x)|\+.*x", kind) != None)
 
+def diffTreePattern():
+    # This is a simple generator for the diff tree regex pattern. This could be
+    # a class variable if this and parseDiffTreeEntry were a part of a class.
+    pattern = re.compile(':(\d+) (\d+) (\w+) (\w+) ([A-Z])(\d+)?\t(.*?)((\t(.*))|$)')
+    while True:
+        yield pattern
+
+def parseDiffTreeEntry(entry):
+    """Parses a single diff tree entry into its component elements.
+
+    See git-diff-tree(1) manpage for details about the format of the diff
+    output. This method returns a dictionary with the following elements:
+
+    src_mode - The mode of the source file
+    dst_mode - The mode of the destination file
+    src_sha1 - The sha1 for the source file
+    dst_sha1 - The sha1 fr the destination file
+    status - The one letter status of the diff (i.e. 'A', 'M', 'D', etc)
+    status_score - The score for the status (applicable for 'C' and 'R'
+                   statuses). This is None if there is no score.
+    src - The path for the source file.
+    dst - The path for the destination file. This is only present for
+          copy or renames. If it is not present, this is None.
+
+    If the pattern is not matched, None is returned."""
+
+    match = diffTreePattern().next().match(entry)
+    if match:
+        return {
+            'src_mode': match.group(1),
+            'dst_mode': match.group(2),
+            'src_sha1': match.group(3),
+            'dst_sha1': match.group(4),
+            'status': match.group(5),
+            'status_score': match.group(6),
+            'src': match.group(7),
+            'dst': match.group(10)
+        }
+    return None
+
 def p4CmdList(cmd, stdin=None, stdin_mode='w+b'):
     cmd = "p4 -G %s" % cmd
     if verbose:
@@ -494,13 +534,14 @@ class P4Submit(Command):
         else:
             print "Applying %s" % (read_pipe("git log --max-count=1 --pretty=oneline %s" % id))
             diffOpts = ("", "-M")[self.detectRename]
-            diff = read_pipe_lines("git diff-tree -r --name-status %s \"%s^\" \"%s\"" % (diffOpts, id, id))
+            diff = read_pipe_lines("git diff-tree -r %s \"%s^\" \"%s\"" % (diffOpts, id, id))
         filesToAdd = set()
         filesToDelete = set()
         editedFiles = set()
         for line in diff:
-            modifier = line[0]
-            path = line[1:].strip()
+            diff = parseDiffTreeEntry(line)
+            modifier = diff['status']
+            path = diff['src']
             if modifier == "M":
                 system("p4 edit \"%s\"" % path)
                 editedFiles.add(path)
@@ -513,7 +554,7 @@ class P4Submit(Command):
                 if path in filesToAdd:
                     filesToAdd.remove(path)
             elif modifier == "R":
-                src, dest = line.strip().split("\t")[1:3]
+                src, dest = diff['src'], diff['dst']
                 system("p4 integrate -Dt \"%s\" \"%s\"" % (src, dest))
                 system("p4 edit \"%s\"" % (dest))
                 os.unlink(dest)
-- 
1.5.3.4.498.g9c514
