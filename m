From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v3 2/4] git-p4: Allow filtering Perforce branches by user
Date: Fri, 19 Aug 2011 00:44:04 +0100
Message-ID: <1313711046-23489-3-git-send-email-vitor.hda@gmail.com>
References: <1313711046-23489-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 01:45:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuCGk-0006mR-CR
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 01:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890Ab1HRXoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 19:44:55 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33240 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814Ab1HRXoy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 19:44:54 -0400
Received: by mail-ww0-f44.google.com with SMTP id 5so2583952wwf.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 16:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=R23TR+cA+ijYg8laSiab7vKnmh3rekQEGs0eYEHap/Y=;
        b=HOCzdEENqxiQ/HvEOqCltIuYWWZSf5hVZLyxFvktBr5waOPbRZDBvjQtPftuqMCied
         y9OLRMuXXPDmMFADac34SXnI80u9w8JlKnJ6mehC+lJVoy3V8ic33S0jzhKk8r2GvfgP
         ml+6vIVfuQHxIS8CxQF+cuOpBO+fgSgmWXhb0=
Received: by 10.216.232.158 with SMTP id n30mr1076752weq.69.1313711093562;
        Thu, 18 Aug 2011 16:44:53 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id u22sm1816046weq.15.2011.08.18.16.44.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 16:44:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1313711046-23489-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179659>

All branches in the Perforce server are downloaded to allow branch detection. If
you have a centralized server on a remote location and there is a big number of
branches this operation can take some time.
This patch adds the configuration option git-p4.branchUser to allow filtering
the branch list by user. Although this limits the branch maintenance in Perforce
to be done by a single user, it might be an advantage when the number of
branches being used in a specific depot is very small when compared with the
branches available in the server.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 contrib/fast-import/git-p4     |    8 +++++++-
 contrib/fast-import/git-p4.txt |    6 ++++++
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 95246e9..8b88f97 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1455,7 +1455,13 @@ class P4Sync(Command, P4UserMap):
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
diff --git a/contrib/fast-import/git-p4.txt b/contrib/fast-import/git-p4.txt
index 2ffbccc..97b66b9 100644
--- a/contrib/fast-import/git-p4.txt
+++ b/contrib/fast-import/git-p4.txt
@@ -257,6 +257,12 @@ Perforce server. Will enable --find-copies-harder git argument.
 
   git config [--global] git-p4.detectCopies true
 
+git-p4.branchUser
+
+Only use branch specifications defined by the selected username.
+
+  git config [--global] git-p4.branchUser username
+
 Implementation Details...
 =========================
 
-- 
1.7.5.4
