From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH 2/2] git-p4: Added copy detection support
Date: Fri, 19 Nov 2010 01:38:13 +0000
Message-ID: <1290130693-30855-3-git-send-email-vitor.hda@gmail.com>
References: <1290130693-30855-1-git-send-email-vitor.hda@gmail.com>
Cc: Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 19 02:38:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJFvx-0005yJ-GC
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 02:38:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756480Ab0KSBiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 20:38:23 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34306 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160Ab0KSBiV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 20:38:21 -0500
Received: by mail-wy0-f174.google.com with SMTP id 28so3920772wyb.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 17:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=+si0DDycrIdhsmVC5L86aos5UOxPprXX0jTGTwjK2j8=;
        b=LiLkTUyCZD68AbQH6IIJ6QyzLtgILuMhJYc4Ch1nNuvVT7TR3pnlR3p5x3xHbc7RA+
         DUKXaw24zyslNDtruSwqK6bkMGngLpbFTYkXUQ/wiEX8td0OqjfDnkEHKBFytyjOixPY
         SZlsD8g9lhcSNWrn/pLnWzKSxW+EBzubPgxt0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OwNAzQhMonSxHAeD7dJX+WG/yQFLLiedukWLLjzQNtWLP+X7/ut9xSM3XRa4VE78kk
         VJjdPIskguygDDa9Pr9Ukgy3gXaxqkAS+0mT0PCYav1lY1LYSzWPf7BxQ/oEaDV12eDa
         0A26Pbdo70ZA75mcCpqXAmI9rfbaaBB2Wne9Q=
Received: by 10.216.161.147 with SMTP id w19mr1175276wek.88.1290130700766;
        Thu, 18 Nov 2010 17:38:20 -0800 (PST)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id a2sm540988wer.17.2010.11.18.17.38.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Nov 2010 17:38:20 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1290130693-30855-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161722>

Added new config options:
    git-p4.detectCopies         - Enable copy detection.
    git-p4.detectCopiesHarder   - Find copies harder.
The detectCopies option should be set to the desired threshold value.
The detectCopiesHarder option receives a simple true/false value.
P4Submit is now able to process diff-tree C status.
---
 contrib/fast-import/git-p4 |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index ba18512..0ea3a44 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -620,6 +620,14 @@ class P4Submit(Command):
         else:
             diffOpts = ("", "-M")[self.detectRenames]
 
+        detectCopies = gitConfig("git-p4.detectCopies")
+        if len(detectCopies) > 0:
+            diffOpts += " -C%s" % detectCopies
+
+        detectCopiesHarder = gitConfig("git-p4.detectCopiesHarder")
+        if len(detectCopiesHarder) > 0 and detectCopiesHarder.lower() != "false":
+            diffOpts += " --find-copies-harder"
+
         diff = read_pipe_lines("git diff-tree -r %s \"%s^\" \"%s\"" % (diffOpts, id, id))
         filesToAdd = set()
         filesToDelete = set()
@@ -643,6 +651,15 @@ class P4Submit(Command):
                 filesToDelete.add(path)
                 if path in filesToAdd:
                     filesToAdd.remove(path)
+            elif modifier == "C":
+                src, dest = diff['src'], diff['dst']
+                p4_system("integrate -Dt \"%s\" \"%s\"" % (src, dest))
+                if diff['src_sha1'] != diff['dst_sha1']:
+                    p4_system("edit \"%s\"" % (dest))
+                if isModeExecChanged(diff['src_mode'], diff['dst_mode']):
+                    filesToChangeExecBit[dest] = diff['dst_mode']
+                os.unlink(dest)
+                editedFiles.add(dest)
             elif modifier == "R":
                 src, dest = diff['src'], diff['dst']
                 p4_system("integrate -Dt \"%s\" \"%s\"" % (src, dest))
-- 
1.7.2.3
