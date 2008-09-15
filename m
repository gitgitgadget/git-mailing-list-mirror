From: Dhruva Krishnamurthy <dhruva@ymail.com>
Subject: [PATCH] Modifying RCS keywords prevents submitting to p4 from git due to missing hunks. Optional shrinking of RCS keywords in git-p4. New option git-p4.kwstrip set to true or false controls the behavior
Date: Mon, 15 Sep 2008 09:46:47 +0530
Message-ID: <1221452207-27495-1-git-send-email-dhruva@ymail.com>
Cc: Dhruva Krishnamurthy <dhruva@ymail.com>
To: "GIT SCM <git@vger.kernel.org>; Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 06:18:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kf5XM-0005Kr-Ih
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 06:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbYIOEQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 00:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbYIOEQw
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 00:16:52 -0400
Received: from mx2.netapp.com ([216.240.18.37]:24737 "EHLO mx2.netapp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbYIOEQv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 00:16:51 -0400
X-IronPort-AV: E=Sophos;i="4.32,399,1217833200"; 
   d="scan'208";a="53811762"
Received: from smtp1.corp.netapp.com ([10.57.156.124])
  by mx2-out.netapp.com with ESMTP; 14 Sep 2008 21:16:50 -0700
Received: from localhost.localdomain (cycl01.eng.btc.netapp.in [10.72.8.51])
	by smtp1.corp.netapp.com (8.13.1/8.13.1/NTAP-1.6) with ESMTP id m8F4Gmo6013319;
	Sun, 14 Sep 2008 21:16:49 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.1.454.g63d55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95872>


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
