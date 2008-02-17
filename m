From: Onno Kortmann <onno@gmx.net>
Subject: [StGit PATCH] Allow renaming of the top-most branch by just calling stg rename <new-patch-name>
Date: Sun, 17 Feb 2008 22:03:55 +0100
Message-ID: <200802172203.55533.onno@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 22:04:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQqgr-0007v2-7r
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 22:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893AbYBQVD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 16:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752831AbYBQVD7
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 16:03:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:33339 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752790AbYBQVD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 16:03:58 -0500
Received: (qmail invoked by alias); 17 Feb 2008 21:03:56 -0000
Received: from 151-245-dsl.kielnet.net (EHLO noodle.okhome) [89.27.245.151]
  by mail.gmx.net (mp044) with SMTP; 17 Feb 2008 22:03:56 +0100
X-Authenticated: #482760
X-Provags-ID: V01U2FsdGVkX19CMV4ySzdCrS2YWaV2GiHLB1cmUcAT2St8hfptep
	gQWo9f0VelB2OD
User-Agent: StGIT/0.14.1
X-TUID: 1f5d5ce872e339f3
X-Length: 2106
X-UID: 5
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74183>

instead of stg rename <old> <new>.
This is for example helpful for those people who always have a typo or two in 
their
patch names.
---

 stgit/commands/rename.py |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/stgit/commands/rename.py b/stgit/commands/rename.py
index e2b0fa4..acdf962 100644
--- a/stgit/commands/rename.py
+++ b/stgit/commands/rename.py
@@ -25,9 +25,10 @@ from stgit import stack, git
 
 
 help = 'rename a patch in the series'
-usage = """%prog [options] <oldpatch> <newpatch>
+usage = """%prog [options] [oldpatch] <newpatch>
 
-Rename <oldpatch> into <newpatch> in a series."""
+Rename <oldpatch> into <newpatch> in a series. If <oldpatch> is not given, 
the
+top-most patch will be renamed. """
 
 directory = DirectoryHasRepository()
 options = [make_option('-b', '--branch',
@@ -37,9 +38,18 @@ options = [make_option('-b', '--branch',
 def func(parser, options, args):
     """Rename a patch in the series
     """
-    if len(args) != 2:
-        parser.error('incorrect number of arguments')
+    crt=crt_series.get_current()
+
+    if len(args) == 2:
+        out.start('Renaming patch "%s" to "%s"' % (args[0], args[1]))
+
+    elif len(args) == 1:
+        if not crt:
+            raise CmdException, "No applied top patch to rename exists."
+        args=[crt]+args
+        out.start('Renaming top-most patch "%s" to "%s"' % (args[0], 
args[1]))
+    
+    else: parser.error('incorrect number of arguments')
 
-    out.start('Renaming patch "%s" to "%s"' % (args[0], args[1]))
     crt_series.rename_patch(args[0], args[1])
     out.done()
