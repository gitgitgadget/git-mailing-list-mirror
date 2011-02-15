From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH 1/2] git-p4: Add copy detection support
Date: Tue, 15 Feb 2011 23:49:48 +0000
Message-ID: <1297813789-3831-2-git-send-email-vitor.hda@gmail.com>
References: <1297813789-3831-1-git-send-email-vitor.hda@gmail.com>
Cc: Vitor Antunes <vitor.hda@gmail.com>, Pete Wyckoff <pw@padd.com>,
	Tor Arvid Lund <torarvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 16 00:50:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpUfJ-0006PA-Qg
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 00:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756439Ab1BOXuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 18:50:37 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58447 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755772Ab1BOXug (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 18:50:36 -0500
Received: by mail-fx0-f46.google.com with SMTP id 20so773563fxm.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 15:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=8yzUayIwg84PliHY2qTC0idaeRRg2wFbHAGymZLIOZI=;
        b=obk+i/7w+6yp7mLxuwYv46Q/SgztM+cYg8NifstFZklvDVxkNPL0YFvwTDr9A+pYqj
         YoCH+pUYTaye6R+5WYxtHa3Z85Fe5eNKyY/z83nGcYxk4OxUaZ266p5yJVau5Gom6pF8
         jupa3yDozk+iz+JbedBnusgcfXJEa88X26MuU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kdVa6I3J4Rar6BkNLAd9/+cUoNzBpf6Y1uYSaoYuXe9DAeAlFuEHcDyNVNYoppWDWN
         3JkhfirlbGNFgyypubpwqhvUbxGKOlGPkDYlCTArSWtxGG5PNU+P0syE2vFS1uaBuS09
         7bRXTE8SRZl5jsWtZDIULMw1m0DEeAbrRPocA=
Received: by 10.223.79.67 with SMTP id o3mr4801246fak.129.1297813835468;
        Tue, 15 Feb 2011 15:50:35 -0800 (PST)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id f24sm1985515fak.0.2011.02.15.15.50.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Feb 2011 15:50:34 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1297813789-3831-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166903>

Add new config options:
    git-p4.detectCopies         - Enable copy detection.
    git-p4.detectCopiesHarder   - Find copies harder.
The detectCopies option should be set to a true/false value.
The detectCopiesHarder option should be set to true/false value.
P4Submit can now process diff-tree C status and integrate files accordingly.
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
