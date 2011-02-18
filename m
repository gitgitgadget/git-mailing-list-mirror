From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH] git-p4: Add copy detection support
Date: Fri, 18 Feb 2011 00:20:12 +0000
Message-ID: <1297988412-6754-1-git-send-email-vitor.hda@gmail.com>
Cc: Vitor Antunes <vitor.hda@gmail.com>, Pete Wyckoff <pw@padd.com>,
	Tor Arvid Lund <torarvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 18 01:21:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqE5j-00032M-8Y
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 01:20:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757729Ab1BRAU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 19:20:29 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50580 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757677Ab1BRAU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 19:20:27 -0500
Received: by fxm20 with SMTP id 20so3236838fxm.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 16:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=08C5Hq3hjeVYqOziKRodCEmeJcEL0bgLoVaRJk0BVPk=;
        b=eYbpDWYVEssIwbH4l4kWUtD69W4O6m8W7l5Tswsvug3+ZhYJw2aY1VEAUtSJl2C5y4
         qAwrG/sYWXFCi4G8z/BAty5Z/jlOV8rWBET0nGMNr9ykjBCQqmk7IM7KKqd0by4fTjAd
         WVmF9ccwudVC09P8cGw5Q3M0UOSjxPTcfl3fM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=bU7c/E+qFCoxGXjpHs1jGuqUH2IOQtVrDqEHC/DrsF0A2zbsnPJY8eeX8fUGNBwaSI
         HPiHiCbB4poysTP1QdeeYifvEfLCuuSUvtx/4o4JAG3FZkYgjy0RLjl8F370nGiwJXpl
         asm6VQm8XyvGtUxpsP1VveDUQBPaUUogn/iCY=
Received: by 10.223.72.14 with SMTP id k14mr66903faj.45.1297988426000;
        Thu, 17 Feb 2011 16:20:26 -0800 (PST)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id n1sm799766fam.16.2011.02.17.16.20.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 16:20:24 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167137>

Add new config options:
    git-p4.detectCopies         - Enable copy detection.
    git-p4.detectCopiesHarder   - Find copies harder.
The detectCopies option should be set to a true/false value.
The detectCopiesHarder option should be set to true/false value.
P4Submit can now process diff-tree C status and integrate files accordingly.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
Acked-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index b0da28a..1b1fc76 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -623,6 +623,12 @@ class P4Submit(Command):
         else:
             diffOpts = ""
 
+        if gitConfig("git-p4.detectCopies").lower() == "true":
+            diffOpts += " -C"
+
+        if gitConfig("git-p4.detectCopiesHarder").lower() == "true":
+            diffOpts += " --find-copies-harder"
+
         diff = read_pipe_lines("git diff-tree -r %s \"%s^\" \"%s\"" % (diffOpts, id, id))
         filesToAdd = set()
         filesToDelete = set()
@@ -646,6 +652,16 @@ class P4Submit(Command):
                 filesToDelete.add(path)
                 if path in filesToAdd:
                     filesToAdd.remove(path)
+            elif modifier == "C":
+                src, dest = diff['src'], diff['dst']
+                p4_system("integrate -Dt \"%s\" \"%s\"" % (src, dest))
+                if diff['src_sha1'] != diff['dst_sha1']:
+                    p4_system("edit \"%s\"" % (dest))
+                if isModeExecChanged(diff['src_mode'], diff['dst_mode']):
+                    p4_system("edit \"%s\"" % (dest))
+                    filesToChangeExecBit[dest] = diff['dst_mode']
+                os.unlink(dest)
+                editedFiles.add(dest)
             elif modifier == "R":
                 src, dest = diff['src'], diff['dst']
                 p4_system("integrate -Dt \"%s\" \"%s\"" % (src, dest))
-- 
1.7.2.3
