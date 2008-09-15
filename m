From: Dhruva Krishnamurthy <dhruva@ymail.com>
Subject: [PATCH] Optional shrinking of RCS keywords in git-p4
Date: Mon, 15 Sep 2008 11:28:51 +0530
Message-ID: <1221458331-8804-1-git-send-email-dhruva@ymail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Dhruva Krishnamurthy <dhruva@ymail.com>
To: GIT SCM <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 15 08:00:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kf78P-0004le-0M
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 08:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbYIOF7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 01:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbYIOF7T
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 01:59:19 -0400
Received: from mx2.netapp.com ([216.240.18.37]:28916 "EHLO mx2.netapp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750873AbYIOF7T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 01:59:19 -0400
X-IronPort-AV: E=Sophos;i="4.32,399,1217833200"; 
   d="scan'208";a="53852765"
Received: from smtp2.corp.netapp.com ([10.57.159.114])
  by mx2-out.netapp.com with ESMTP; 14 Sep 2008 22:59:15 -0700
Received: from svlexrs01.hq.netapp.com (svlexrs01.corp.netapp.com [10.57.156.158])
	by smtp2.corp.netapp.com (8.13.1/8.13.1/NTAP-1.6) with ESMTP id m8F5xE86024296;
	Sun, 14 Sep 2008 22:59:14 -0700 (PDT)
Received: from exsvlrb02.hq.netapp.com ([10.56.8.63]) by svlexrs01.hq.netapp.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 14 Sep 2008 22:59:13 -0700
Received: from exbtc01.hq.netapp.com ([10.72.128.65]) by exsvlrb02.hq.netapp.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 14 Sep 2008 22:59:13 -0700
Received: from cycl01.eng.btc.netapp.in ([10.72.8.51]) by exbtc01.hq.netapp.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 15 Sep 2008 11:29:10 +0530
Received: from localhost.localdomain (localhost [127.0.0.1])
	by cycl01.eng.btc.netapp.in (8.13.1/8.13.1) with ESMTP id m8F5wp0H008850;
	Mon, 15 Sep 2008 11:29:05 +0530
X-Mailer: git-send-email 1.6.0.1.454.g63d55
X-OriginalArrivalTime: 15 Sep 2008 05:59:10.0639 (UTC) FILETIME=[2C38CBF0:01C916F8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95876>

Modifying RCS keywords prevents submitting to p4 from git due to missing hunks.
New option git-p4.kwstrip set to true or false controls the behavior.

Signed-off-by: Dhruva Krishnamurthy <dhruva@ymail.com>
---
 contrib/fast-import/git-p4 |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 2216cac..ac8b7f7 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -16,6 +16,9 @@ from sets import Set;
 
 verbose = False
 
+# Handling of RCS keyowrds. To ensure backward compatibility, the default
+# is to strip keywords. Default behavior is controlled here
+kwstrip = True
 
 def p4_build_cmd(cmd):
     """Build a suitable p4 command line.
@@ -975,7 +978,9 @@ class P4Sync(Command):
                 sys.stderr.write("p4 print fails with: %s\n" % repr(stat))
                 continue
 
-            if stat['type'] in ('text+ko', 'unicode+ko', 'binary+ko'):
+            if not kwstrip:
+		pass
+            elif stat['type'] in ('text+ko', 'unicode+ko', 'binary+ko'):
                 text = re.sub(r'(?i)\$(Id|Header):[^$]*\$',r'$\1$', text)
             elif stat['type'] in ('text+k', 'ktext', 'kxtext', 'unicode+k', 'binary+k'):
                 text = re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$]*\$',r'$\1$', text)
@@ -1850,6 +1855,16 @@ def main():
         (cmd, args) = parser.parse_args(sys.argv[2:], cmd);
     global verbose
     verbose = cmd.verbose
+
+    global kwstrip
+    kwval = gitConfig("git-p4.kwstrip")
+    if len(kwval) > 0:
+	kwval = kwval.lower();
+        if kwval == "false":
+            kwstrip = False
+        elif kwval == "true":
+            kwstrip = True
+
     if cmd.needsGit:
         if cmd.gitdir == None:
             cmd.gitdir = os.path.abspath(".git")
-- 
1.6.0.1.454.g63d55
