From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH 1/3] git-p4: Improve rename detection support
Date: Fri, 18 Feb 2011 00:23:20 +0000
Message-ID: <1297988600-7002-1-git-send-email-vitor.hda@gmail.com>
Cc: Vitor Antunes <vitor.hda@gmail.com>, Pete Wyckoff <pw@padd.com>,
	Tor Arvid Lund <torarvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 18 01:23:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqE8D-0004k8-Tx
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 01:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757499Ab1BRAX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 19:23:29 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57232 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873Ab1BRAX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 19:23:28 -0500
Received: by bwz15 with SMTP id 15so248473bwz.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 16:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=mn0F6uMTqPAEi+M8MhW4r/6GIRZ3SrjRKA+FB+CZgT8=;
        b=XXQA6zCW88CabFMVDX2nDUj7cJEoLquOW9EAiHuT4nYCl+DiD4QH197x7H43YlCVxA
         SXaVQDL4DO7iXmOoJQdNCFOo5B+DUuc5zE41XZtTn9GY5ZhCRUdl8DfjRwEG3CsgFDk0
         +5a7jhZmQr7hLdXru8DcCKQmDv4O02dtJUu9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Ueuf+g75d1+29b8IE3atUTCZK6yPdKZftAKtzL6Iz7nZhDFi/Zofxf6onkSFStWEZt
         kngODjcm6Swx0QVA1fyFIysKGqdY9rrUiacyhiz56Z4LGtwkQFvHvK1/WQFw/B7sIFjU
         WA8T6gnjfVUrbwvy71rNwhRmjCTDLSaj2E4v8=
Received: by 10.204.123.7 with SMTP id n7mr71170bkr.33.1297988606674;
        Thu, 17 Feb 2011 16:23:26 -0800 (PST)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id l3sm8926fan.2.2011.02.17.16.23.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 16:23:25 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167138>

Only open files for edit after integrating if the SHA1 of source and destination
differ from each other.
Add git config option detectRenames to allow permanent rename detection. This
options should be set to a true/false value.
Rename "detectRename" variable to "detectRenames" to make it more coherent with
the description in git man pages, which always use plural.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 contrib/fast-import/git-p4 |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index a92beb6..b0da28a 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -543,13 +543,13 @@ class P4Submit(Command):
         self.options = [
                 optparse.make_option("--verbose", dest="verbose", action="store_true"),
                 optparse.make_option("--origin", dest="origin"),
-                optparse.make_option("-M", dest="detectRename", action="store_true"),
+                optparse.make_option("-M", dest="detectRenames", action="store_true"),
         ]
         self.description = "Submit changes from git to the perforce depot."
         self.usage += " [name of git branch to submit into perforce depot]"
         self.interactive = True
         self.origin = ""
-        self.detectRename = False
+        self.detectRenames = False
         self.verbose = False
         self.isWindows = (platform.system() == "Windows")
 
@@ -613,7 +613,16 @@ class P4Submit(Command):
 
     def applyCommit(self, id):
         print "Applying %s" % (read_pipe("git log --max-count=1 --pretty=oneline %s" % id))
-        diffOpts = ("", "-M")[self.detectRename]
+
+        if not self.detectRenames:
+            # If not explicitly set check the config variable
+            self.detectRenames = gitConfig("git-p4.detectRenames").lower() == "true"
+
+        if self.detectRenames:
+            diffOpts = "-M"
+        else:
+            diffOpts = ""
+
         diff = read_pipe_lines("git diff-tree -r %s \"%s^\" \"%s\"" % (diffOpts, id, id))
         filesToAdd = set()
         filesToDelete = set()
@@ -640,8 +649,10 @@ class P4Submit(Command):
             elif modifier == "R":
                 src, dest = diff['src'], diff['dst']
                 p4_system("integrate -Dt \"%s\" \"%s\"" % (src, dest))
-                p4_system("edit \"%s\"" % (dest))
+                if diff['src_sha1'] != diff['dst_sha1']:
+                    p4_system("edit \"%s\"" % (dest))
                 if isModeExecChanged(diff['src_mode'], diff['dst_mode']):
+                    p4_system("edit \"%s\"" % (dest))
                     filesToChangeExecBit[dest] = diff['dst_mode']
                 os.unlink(dest)
                 editedFiles.add(dest)
-- 
1.7.2.3
