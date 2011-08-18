From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v3 3/4] git-p4: Allow branch definition with git config
Date: Fri, 19 Aug 2011 00:44:05 +0100
Message-ID: <1313711046-23489-4-git-send-email-vitor.hda@gmail.com>
References: <1313711046-23489-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 01:45:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuCGk-0006mR-Ur
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 01:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945Ab1HRXo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 19:44:57 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39570 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894Ab1HRXoz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 19:44:55 -0400
Received: by mail-wy0-f174.google.com with SMTP id 24so1758306wyg.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 16:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=LqjWk1AI0tnVFReaWGwDdj+BhxvWQwAMDXVekHzfaqA=;
        b=RepsFhztRLJkM1KWRUowtAHu8S9CbEwjU3MxEBF6bk9SGspUMWSqSbxHXrhLi71qHn
         dP7FHUqWdPJv3V6fFAMzKX/HR1e3bOK9FzPzOI+6gtUb2bvk/FizwQbqjrmvKKzknEuY
         3VhmSPiQJUyYf22Ax1/dQ3DM9AzojR+mL1OEY=
Received: by 10.216.80.96 with SMTP id j74mr1018127wee.72.1313711095169;
        Thu, 18 Aug 2011 16:44:55 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id u22sm1816046weq.15.2011.08.18.16.44.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 16:44:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1313711046-23489-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179662>

Perforce does not strictly require the usage of branch specifications to create
branches. In these cases the branch detection code of git-p4 will not be able to
import them.
This patch adds support for git-p4.branchList configuration option, allowing
branches to be defined in git config.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 contrib/fast-import/git-p4     |   24 ++++++++++++++++++++++++
 contrib/fast-import/git-p4.txt |    7 +++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 8b88f97..f622a38 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -342,6 +342,11 @@ def gitConfig(key, args = None): # set args to "--bool", for instance
         _gitConfig[key] = read_pipe(cmd, ignore_error=True).strip()
     return _gitConfig[key]
 
+def gitConfigList(key):
+    if not _gitConfig.has_key(key):
+        _gitConfig[key] = read_pipe("git config --get-all %s" % key, ignore_error=True).strip().split(os.linesep)
+    return _gitConfig[key]
+
 def p4BranchesInGit(branchesAreInRemotes = True):
     branches = {}
 
@@ -1490,6 +1495,25 @@ class P4Sync(Command, P4UserMap):
                     if source not in self.knownBranches:
                         lostAndFoundBranches.add(source)
 
+        # Perforce does not strictly require branches to be defined, so we also
+        # check git config for a branch list.
+        #
+        # Example of branch definition in git config file:
+        # [git-p4]
+        #   branchList=main:branchA
+        #   branchList=main:branchB
+        #   branchList=branchA:branchC
+        configBranches = gitConfigList("git-p4.branchList")
+        for branch in configBranches:
+            if branch:
+                (source, destination) = branch.split(":")
+                self.knownBranches[destination] = source
+
+                lostAndFoundBranches.discard(destination)
+
+                if source not in self.knownBranches:
+                    lostAndFoundBranches.add(source)
+
 
         for branch in lostAndFoundBranches:
             self.knownBranches[branch] = branch
diff --git a/contrib/fast-import/git-p4.txt b/contrib/fast-import/git-p4.txt
index 97b66b9..52003ae 100644
--- a/contrib/fast-import/git-p4.txt
+++ b/contrib/fast-import/git-p4.txt
@@ -263,6 +263,13 @@ Only use branch specifications defined by the selected username.
 
   git config [--global] git-p4.branchUser username
 
+git-p4.branchList
+
+List of branches to be imported when branch detection is enabled.
+
+  git config [--global] git-p4.branchList main:branchA
+  git config [--global] --add git-p4.branchList main:branchB
+
 Implementation Details...
 =========================
 
-- 
1.7.5.4
