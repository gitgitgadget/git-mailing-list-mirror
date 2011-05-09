From: Luke Diamand <luke@diamand.org>
Subject: [PATCH/RFC v2 1/2] git-p4: small improvements to user-preservation
Date: Mon,  9 May 2011 07:40:02 +0100
Message-ID: <1304923203-26278-2-git-send-email-luke@diamand.org>
References: <1304923203-26278-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Pete Wyckoff <pw@padd.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 08:40:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJK9A-0007BY-0Z
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 08:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379Ab1EIGki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 02:40:38 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38087 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322Ab1EIGki (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 02:40:38 -0400
Received: by wya21 with SMTP id 21so3626985wya.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 23:40:37 -0700 (PDT)
Received: by 10.227.174.14 with SMTP id r14mr4188319wbz.30.1304923236994;
        Sun, 08 May 2011 23:40:36 -0700 (PDT)
Received: from localhost.localdomain (cpc4-cmbg14-2-0-cust166.5-4.cable.virginmedia.com [86.30.143.167])
        by mx.google.com with ESMTPS id w25sm3545638wbd.5.2011.05.08.23.40.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 May 2011 23:40:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1304923203-26278-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173198>

. Slightly more paranoid checking of results from 'p4 change'
. Remove superfluous "-G"
. Don't modify the username if it is unchanged.
. Reword git-p4.txt to point out that the initial commit will
  be submitted with you as the author.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 contrib/fast-import/git-p4     |   16 +++++++++++-----
 contrib/fast-import/git-p4.txt |    9 +++++----
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 36e3d87..bd8c761 100755
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
@@ -865,6 +870,7 @@ class P4Submit(Command, P4UserMap):
 
         if self.interactive:
             submitTemplate = self.prepareLogMessage(template, logMessage)
+
             if os.environ.has_key("P4DIFF"):
                 del(os.environ["P4DIFF"])
             diff = ""
diff --git a/contrib/fast-import/git-p4.txt b/contrib/fast-import/git-p4.txt
index b6986f0..d46b7a5 100644
--- a/contrib/fast-import/git-p4.txt
+++ b/contrib/fast-import/git-p4.txt
@@ -111,10 +111,11 @@ is not your current git branch you can also pass that as an argument:
 You can override the reference branch with the --origin=mysourcebranch option.
 
 The Perforce changelists will be created with the user who ran git-p4. If you
-use --preserve-user then git-p4 will attempt to create Perforce changelists
-with the Perforce user corresponding to the git commit author. You need to
-have sufficient permissions within Perforce, and the git users need to have
-Perforce accounts. Permissions can be granted using 'p4 protect'.
+use --preserve-user then git-p4 will modify the Perforce change's user field
+to match that of the git commit author after it has been submitted (the change
+will still initially be submitted with you as the author). You need to have
+sufficient permissions within Perforce, and the git users need to have Perforce
+accounts. Permissions can be granted using 'p4 protect'.
 
 If a submit fails you may have to "p4 resolve" and submit manually. You can
 continue importing the remaining changes with
-- 
1.7.1
