From: Luke Diamand <luke@diamand.org>
Subject: [PATCH] git-p4: small improvements to user-preservation
Date: Sat,  7 May 2011 11:19:43 +0100
Message-ID: <1304763583-17425-2-git-send-email-luke@diamand.org>
References: <1304763583-17425-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 12:20:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIecc-0007Nl-8Z
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 12:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570Ab1EGKUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 06:20:20 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63141 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754486Ab1EGKUS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2011 06:20:18 -0400
Received: by wwa36 with SMTP id 36so4274908wwa.1
        for <git@vger.kernel.org>; Sat, 07 May 2011 03:20:17 -0700 (PDT)
Received: by 10.216.12.146 with SMTP id 18mr532062wez.63.1304763617044;
        Sat, 07 May 2011 03:20:17 -0700 (PDT)
Received: from localhost.localdomain ([212.183.128.32])
        by mx.google.com with ESMTPS id m14sm620928wes.14.2011.05.07.03.20.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 May 2011 03:20:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1304763583-17425-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173045>

. Slightly more paranoid checking of results from 'p4 change'
. Remove superfluous "-G"
. Don't modify the username if it is unchanged.
. Add a comment in the change template to show what is
  going to be done.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 contrib/fast-import/git-p4 |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 36e3d87..e66a7df 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -690,10 +690,15 @@ class P4Submit(Command, P4UserMap):
     def modifyChangelistUser(self, changelist, newUser):
         # fixup the user field of a changelist after it has been submitted.
         changes = p4CmdList("change -o %s" % changelist)
-        for c in changes:
-            if c.has_key('User'):
-                c['User'] = newUser
-        input = marshal.dumps(changes[0])
+        if len(changes) != 1:
+            die("Bad output from p4 change modifying %s to user %s" %
+                (changelist, newUser))
+
+        c = changes[0]
+        if c['User'] == newUser: return   # nothing to do
+        c['User'] = newUser
+        input = marshal.dumps(c)
+
         result = p4CmdList("change -f -i", stdin=input)
         for r in result:
             if r.has_key('code'):
@@ -707,7 +712,7 @@ class P4Submit(Command, P4UserMap):
     def canChangeChangelists(self):
         # check to see if we have p4 admin or super-user permissions, either of
         # which are required to modify changelists.
-        results = p4CmdList("-G protects %s" % self.depotPath)
+        results = p4CmdList("protects %s" % self.depotPath)
         for r in results:
             if r.has_key('perm'):
                 if r['perm'] == 'admin':
@@ -865,6 +870,10 @@ class P4Submit(Command, P4UserMap):
 
         if self.interactive:
             submitTemplate = self.prepareLogMessage(template, logMessage)
+
+            if self.preserveUser:
+               submitTemplate = submitTemplate + ("\n######## Actual user %s, modified after commit\n" % p4User)
+
             if os.environ.has_key("P4DIFF"):
                 del(os.environ["P4DIFF"])
             diff = ""
-- 
1.7.1
