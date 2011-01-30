From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH 2/2] git-p4: Add copy detection support
Date: Sun, 30 Jan 2011 23:19:23 +0000
Message-ID: <1296429563-18390-2-git-send-email-vitor.hda@gmail.com>
References: <1296429563-18390-1-git-send-email-vitor.hda@gmail.com>
Cc: Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 31 00:20:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjgZC-0008WF-6o
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 00:20:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177Ab1A3XUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jan 2011 18:20:05 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40351 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160Ab1A3XUE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jan 2011 18:20:04 -0500
Received: by mail-wy0-f174.google.com with SMTP id 28so4980319wyb.19
        for <git@vger.kernel.org>; Sun, 30 Jan 2011 15:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=kcoHlWxCDWeV/eus4GrQjlW7xQ48YOj+mZ1T25uRK9M=;
        b=x11/MG+CwOzC758iF9scaS5/92wUwBcu9V0oNAG1RpEZR+0jFVKzWPy9rLGSiWIWfa
         GX3eXc0X4mDHbNt96eUUxa5qLhlrsGmwH23LHNKBB5LhFHKzhE1NZcV/2yt9Lwlb3CsZ
         p97ZZ5OA8XbwCrqVdzSkPtlOdOcjxzYhVEaUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AwSJdlETbOFOyCTNfHlt9SFSg7IoS09bIXBAWUchdARkePqkaJIyCfyxMulgPFlfp5
         XSMm06q76SBeVAQAT9PHm3HRoYKWTvJBIEyyzLWdiJDCWs46WUs4hLTw3loLwnFCahLQ
         MSoND8KQlRv598Uw7QDaAuNWcwR0/XiWgTDPM=
Received: by 10.216.145.154 with SMTP id p26mr10216797wej.11.1296429604193;
        Sun, 30 Jan 2011 15:20:04 -0800 (PST)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id t11sm10451540wes.41.2011.01.30.15.20.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 30 Jan 2011 15:20:03 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1296429563-18390-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165709>

Add new config options:
    git-p4.detectCopies         - Enable copy detection.
    git-p4.detectCopiesHarder   - Find copies harder.
The detectCopies option should be set to a true/false value.
The detectCopiesHarder option should be set to true/false value.
P4Submit can now process diff-tree C status and integrate files accordingly.
---
 contrib/fast-import/git-p4 |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 9fb480a..9b67ae2 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -620,6 +620,14 @@ class P4Submit(Command):
         else:
             diffOpts = ("", "-M")[self.detectRename]
 
+        detectCopies = gitConfig("git-p4.detectCopies")
+        if len(detectCopies) and detectCopies.lower() != "false" > 0:
+            diffOpts += " -C"
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
