From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH] git-p4: Improve branch support.
Date: Thu,  3 Feb 2011 01:01:53 +0000
Message-ID: <1296694913-7844-2-git-send-email-vitor.hda@gmail.com>
References: <1296694913-7844-1-git-send-email-vitor.hda@gmail.com>
Cc: Thomas Berg <merlin66b@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 03 02:02:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pknat-00066V-OY
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 02:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755371Ab1BCBCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 20:02:31 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48957 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474Ab1BCBCa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 20:02:30 -0500
Received: by mail-ww0-f44.google.com with SMTP id 36so667822wwa.1
        for <git@vger.kernel.org>; Wed, 02 Feb 2011 17:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=onA/YxzKivbUyuEHkAd1Iq9Jcn6FOgKzSdZcWZEnO8k=;
        b=YEIVkFdaCsd/qVvTCTyhDkrnwbeQ4UCGVYkJ+h5CNDujKF+z6GDvNoPFw5ASllY7An
         hxOy77ISfRCDBcYpyxXs8Lp98eDKxa085jZiOYC9cJHk7BZEng71NYjKcaTF+nfDK/UZ
         jqs7ow0qt1HGf6/d5RDG53J0t22VX/DV27VHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jbqjfTUPHjzNu3EEUsxgYJcvgx8BG2QURgWBQ89Up4ddX2H/AQqWKpNJtKSo6pYXx6
         LS5jkB1113YicvAZUICEDeTSzMglKwiaSdbvmQeY5blpAVtzws4irwojy0FRitdbT6aS
         Ss93IJczgBlOnoNLmhLwtaXhXDj5/tGpXH/ww=
Received: by 10.227.144.200 with SMTP id a8mr9949015wbv.217.1296694950046;
        Wed, 02 Feb 2011 17:02:30 -0800 (PST)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id f35sm171094wbf.20.2011.02.02.17.02.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Feb 2011 17:02:29 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1296694913-7844-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165945>

Add new config option branchUser to allow filtering P4 branch list by user.
Allow defining the branch list through branchList config option.
Correct base branch directory detection to use '/' as the split character.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 contrib/fast-import/git-p4 |   27 +++++++++++++++++++++++----
 1 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 9b67ae2..af1ba43 100755
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
 
@@ -1253,7 +1258,13 @@ class P4Sync(Command):
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
@@ -1286,6 +1297,12 @@ class P4Sync(Command):
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
@@ -1581,12 +1598,14 @@ class P4Sync(Command):
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
