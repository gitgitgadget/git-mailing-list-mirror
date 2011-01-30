From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH 1/2] git-p4: Improve rename detection support.
Date: Sun, 30 Jan 2011 23:19:22 +0000
Message-ID: <1296429563-18390-1-git-send-email-vitor.hda@gmail.com>
Cc: Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 31 00:20:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjgZ0-0008Pd-2N
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 00:20:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755131Ab1A3XUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jan 2011 18:20:01 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40351 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754797Ab1A3XUA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jan 2011 18:20:00 -0500
Received: by wyb28 with SMTP id 28so4980319wyb.19
        for <git@vger.kernel.org>; Sun, 30 Jan 2011 15:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=5yGEB/N1ZTQBjuiCeSMAE2abNYtYHVUDKjFoUI96Vs0=;
        b=PjG1su3eioCmz0gSgLQNC0/uCG0JS/w+UX+GuCCm8Mz0500MMBj5OLvJuncBHNF0ci
         KMijKfyERiKR4IXl2q+a/p+kzdDQuh31P7NmU7i7rnjNIHq+B8HlKPLCHT02k9T/wtZi
         WbJNBAlhOl+a5cQx5CTKaFhe1Ni81TjhVMK6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=l4DDvI0mWlqvoNXrz4c1klV2j5Aq5AVuTqdo+NoBmVPIBcLAgPxhypIdoNdR1GHQcX
         xWnTQeFC/YrmDo+0pNUxk4ZOFAkrEI1xRMG/0QbozefUsfA/nNqg3j2rgajhRCjO7UMR
         DiF5OnlGXpfjZKAn2+4IIttnGtZmTqtptng2k=
Received: by 10.227.155.66 with SMTP id r2mr5353574wbw.73.1296429599189;
        Sun, 30 Jan 2011 15:19:59 -0800 (PST)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id t11sm10451540wes.41.2011.01.30.15.19.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 30 Jan 2011 15:19:58 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165708>

Only open files for edit after integrating if the SHA1 of source and destination
differ from each other.
Add git config option detectRenames to allow permanent rename detection. This
options should be set to a true/false value.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 contrib/fast-import/git-p4 |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 04ce7e3..9fb480a 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -613,7 +613,13 @@ class P4Submit(Command):
 
     def applyCommit(self, id):
         print "Applying %s" % (read_pipe("git log --max-count=1 --pretty=oneline %s" % id))
-        diffOpts = ("", "-M")[self.detectRename]
+
+        detectRenames = gitConfig("git-p4.detectRenames")
+        if len(detectRenames) and detectRenames.lower() != "false" > 0:
+            diffOpts = "-M"
+        else:
+            diffOpts = ("", "-M")[self.detectRename]
+
         diff = read_pipe_lines("git diff-tree -r %s \"%s^\" \"%s\"" % (diffOpts, id, id))
         filesToAdd = set()
         filesToDelete = set()
@@ -640,7 +646,8 @@ class P4Submit(Command):
             elif modifier == "R":
                 src, dest = diff['src'], diff['dst']
                 p4_system("integrate -Dt \"%s\" \"%s\"" % (src, dest))
-                p4_system("edit \"%s\"" % (dest))
+                if diff['src_sha1'] != diff['dst_sha1']:
+                    p4_system("edit \"%s\"" % (dest))
                 if isModeExecChanged(diff['src_mode'], diff['dst_mode']):
                     filesToChangeExecBit[dest] = diff['dst_mode']
                 os.unlink(dest)
-- 
1.7.2.3
