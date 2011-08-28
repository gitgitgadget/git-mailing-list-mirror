From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v4 3/4] git-p4: Allow branch definition with git config
Date: Sun, 28 Aug 2011 22:58:29 +0100
Message-ID: <1314568710-6472-4-git-send-email-vitor.hda@gmail.com>
References: <1314568710-6472-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 23:59:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxnOB-0002zE-Tk
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 23:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468Ab1H1V7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 17:59:31 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41197 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410Ab1H1V7a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2011 17:59:30 -0400
Received: by mail-wy0-f174.google.com with SMTP id 24so3635385wyg.19
        for <git@vger.kernel.org>; Sun, 28 Aug 2011 14:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zP2Lz7rxhwhK8rGV7RXE8cD8o5O4sktRB/DJaY0xvaQ=;
        b=Qbz8Tz4oCAUAGX7m74XuVTJyi/b/9HvZVQZOicB+nGcbFGIATEqv5did/5SxMl6tlB
         29IprhpxTOiqhnJ5RcbN9I+NIhM79aqtgz+6YSopUGaPFeINrCy1ywOwZMp0yi/yR/aZ
         cIvybwTIXQuETPZGcEzo/VEzotAdGrZyKqs2M=
Received: by 10.227.206.210 with SMTP id fv18mr3215238wbb.20.1314568769530;
        Sun, 28 Aug 2011 14:59:29 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id fh17sm3211909wbb.3.2011.08.28.14.59.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 28 Aug 2011 14:59:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1314568710-6472-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180286>

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
index 6314c20..2f7b270 100755
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
