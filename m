From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH 2/2] git-p4: Improve branch support
Date: Tue, 15 Feb 2011 23:49:49 +0000
Message-ID: <1297813789-3831-3-git-send-email-vitor.hda@gmail.com>
References: <1297813789-3831-1-git-send-email-vitor.hda@gmail.com>
Cc: Vitor Antunes <vitor.hda@gmail.com>, Pete Wyckoff <pw@padd.com>,
	Tor Arvid Lund <torarvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 16 00:50:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpUfb-0006an-4O
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 00:50:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755396Ab1BOXuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 18:50:55 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58447 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756488Ab1BOXux (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 18:50:53 -0500
Received: by mail-fx0-f46.google.com with SMTP id 20so773563fxm.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 15:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=n0CIpWQugwQAmhmI5DtTiSgShrPWQMm4ZR3601u5pA4=;
        b=L5jjy9A9Be5QN8nMWvztaOzSQvGewJWHGGLqus3D5vuh7T9pvMclyql5MwGzcIgaDX
         eto3QFaufWwazUXk4PAxmFLZ4L3eArQLnXtuhNydZGEz9tlQkM05GQK2YduQDO8E2FtN
         XLi/Z/juiMWyXQyqJs4zar3LZdbifbMn6UHkM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XBKwMiLI5Iq3y5e1yAcFl82slubo8LVaqjOQGZj4lJunxZIPoL5n0ejy6Gf6AstN38
         wDx7X35eJNiGGHbllatRrhR95hM3TDMy8wpb3yDwplHabI9CT4pxgEW7BvrAQKijMNeu
         4gAQLP1P8oEMEWBciOYtNG6M1781Ln+hcgUYo=
Received: by 10.223.73.202 with SMTP id r10mr7325671faj.133.1297813853051;
        Tue, 15 Feb 2011 15:50:53 -0800 (PST)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id f24sm1985515fak.0.2011.02.15.15.50.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Feb 2011 15:50:52 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1297813789-3831-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166904>

Add new config option branchUser to allow filtering P4 branch list by user.
Allow defining the branch list through branchList config option.
Correct base branch directory detection to use '/' as the split character.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 contrib/fast-import/git-p4 |   27 +++++++++++++++++++++++----
 1 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 1b1fc76..93a0b6e 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -338,6 +338,11 @@ def gitConfig(key):
         _gitConfig[key] = read_pipe("git config %s" % key, ignore_error=True).strip()
     return _gitConfig[key]
 
+def gitConfigList(key):
+    if not _gitConfig.has_key(key):
+        _gitConfig[key] = read_pipe("git config --get-all %s" % key, ignore_error=True).strip().split(os.linesep)
+    return _gitConfig[key]
+
 def p4BranchesInGit(branchesAreInRemotes = True):
     branches = {}
 
@@ -1272,7 +1277,13 @@ class P4Sync(Command):
     def getBranchMapping(self):
         lostAndFoundBranches = set()
 
-        for info in p4CmdList("branches"):
+        user = gitConfig("git-p4.branchUser")
+        if len(user) > 0:
+            command = "branches -u %s" % user
+        else:
+            command = "branches"
+
+        for info in p4CmdList(command):
             details = p4Cmd("branch -o %s" % info["branch"])
             viewIdx = 0
             while details.has_key("View%s" % viewIdx):
@@ -1305,6 +1316,12 @@ class P4Sync(Command):
         for branch in lostAndFoundBranches:
             self.knownBranches[branch] = branch
 
+        configBranches = gitConfigList("git-p4.branchList")
+        for branch in configBranches:
+            if branch:
+                (source, destination) = branch.split(":")
+                self.knownBranches[destination] = source
+
     def getBranchMappingFromGitBranches(self):
         branches = p4BranchesInGit(self.importIntoRemotes)
         for branch in branches.keys():
@@ -1626,12 +1643,14 @@ class P4Sync(Command):
                     else:
                         paths = []
                         for (prev, cur) in zip(self.previousDepotPaths, depotPaths):
-                            for i in range(0, min(len(cur), len(prev))):
-                                if cur[i] <> prev[i]:
+                            prev_list = prev.split("/")
+                            cur_list = cur.split("/")
+                            for i in range(0, min(len(cur_list), len(prev_list))):
+                                if cur_list[i] <> prev_list[i]:
                                     i = i - 1
                                     break
 
-                            paths.append (cur[:i + 1])
+                            paths.append ("/".join(cur_list[:i + 1]))
 
                         self.previousDepotPaths = paths
 
-- 
1.7.2.3
