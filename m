From: David Brown <git@davidb.org>
Subject: [PATCH] [git-p4] Detect exec bit in more cases.
Date: Wed, 19 Sep 2007 13:12:48 -0700
Message-ID: <1190232768445-git-send-email-git@davidb.org>
References: <119022570352-git-send-email-git@davidb.org>
Cc: David Brown <git@davidb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 19 22:13:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IY5uw-0003qN-Kw
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 22:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbXISUM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 16:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbXISUM5
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 16:12:57 -0400
Received: from mail.davidb.org ([66.93.32.219]:32785 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750943AbXISUM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 16:12:57 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1IY5ui-0006T1-Kc; Wed, 19 Sep 2007 13:12:48 -0700
X-Mailer: git-send-email 1.5.3
In-Reply-To: <119022570352-git-send-email-git@davidb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58730>

git-p4 was missing the execute bit setting if the file had other attribute
bits set.
---
 contrib/fast-import/git-p4 |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index adaaae6..557649a 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -63,6 +63,14 @@ def system(cmd):
     if os.system(cmd) != 0:
         die("command failed: %s" % cmd)
 
+def isP4Exec(kind):
+    """Determine if a Perforce 'kind' should have execute permission
+
+    'p4 help filetypes' gives a list of the types.  If it starts with 'x',
+    or x follows one of a few letters.  Otherwise, if there is an 'x' after
+    a plus sign, it is also executable"""
+    return (re.search(r"(^[cku]?x)|\+.*x", kind) != None)
+
 def p4CmdList(cmd, stdin=None, stdin_mode='w+b'):
     cmd = "p4 -G %s" % cmd
     if verbose:
@@ -932,7 +940,7 @@ class P4Sync(Command):
                 data = file['data']
 
                 mode = "644"
-                if file["type"].startswith("x"):
+                if isP4Exec(file["type"]):
                     mode = "755"
                 elif file["type"] == "symlink":
                     mode = "120000"
-- 
1.5.3
