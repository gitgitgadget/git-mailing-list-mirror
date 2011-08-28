From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH v4 2/4] git-p4: Allow filtering Perforce branches by user
Date: Sun, 28 Aug 2011 22:58:28 +0100
Message-ID: <1314568710-6472-3-git-send-email-vitor.hda@gmail.com>
References: <1314568710-6472-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 23:59:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxnO5-0002xH-11
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 23:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394Ab1H1V7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 17:59:25 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41197 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363Ab1H1V7X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2011 17:59:23 -0400
Received: by wyg24 with SMTP id 24so3635385wyg.19
        for <git@vger.kernel.org>; Sun, 28 Aug 2011 14:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=VxwsYavSuZhJgrJBxvrQy11kWQLYrOiyXhc/4H1HvC8=;
        b=SUMlhq9LTIsAq9eB5rIRr6PTiFiwtdqOKrlsGHdepR+usUhYw353Y8khnHrGrJjPnn
         biDmiN9ZY4/7BsRZ+nZ/lkMoQgjlGp/gh9CqzrQerL0ZCU3gTJRvCpsbdiy7k6EdQRxL
         eyNqLbBQ80Xn3AYrNgmMmidX2be9mSivG/Fi8=
Received: by 10.227.147.5 with SMTP id j5mr3084262wbv.109.1314568762456;
        Sun, 28 Aug 2011 14:59:22 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id fh17sm3211909wbb.3.2011.08.28.14.59.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 28 Aug 2011 14:59:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1314568710-6472-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180285>

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
index 72a5b6c..6314c20 100755
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
