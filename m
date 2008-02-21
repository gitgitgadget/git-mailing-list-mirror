From: Onno Kortmann <onno@gmx.net>
Subject: [PATCH 1/2] Simple rename of top-most patch
Date: Thu, 21 Feb 2008 22:42:51 +0100
Message-ID: <200802212242.51866.onno@gmx.net>
References: <20080218140005.GA18668@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 21 22:43:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSJCV-0000Kq-H5
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 22:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756140AbYBUVmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 16:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755507AbYBUVmz
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 16:42:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:53310 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755149AbYBUVmy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 16:42:54 -0500
Received: (qmail invoked by alias); 21 Feb 2008 21:42:52 -0000
Received: from 14-235-dsl.kielnet.net (EHLO noodle.okhome) [89.27.235.14]
  by mail.gmx.net (mp058) with SMTP; 21 Feb 2008 22:42:52 +0100
X-Authenticated: #482760
X-Provags-ID: V01U2FsdGVkX1++TTZk66i+OcVQ5HKwTlzwVxw8bqZxit8gYNlkLo
	UkYZGssolaYSYp
In-Reply-To: <20080218140005.GA18668@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.14.1
X-TUID: 2c521aa475b247e9
X-Length: 2264
X-UID: 17
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74664>

Allow renaming of the top-most patch just by calling stg rename <new-patch-name>,
instead of stg rename <old> <new>. This is for example helpful for those people who
always have a typo or two in their patch names.

Signed-off-by: Onno Kortmann <onno@gmx.net>
---

 stgit/commands/rename.py |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/stgit/commands/rename.py b/stgit/commands/rename.py
index e2b0fa4..c687455 100644
--- a/stgit/commands/rename.py
+++ b/stgit/commands/rename.py
@@ -25,9 +25,10 @@ from stgit import stack, git
 
 
 help = 'rename a patch in the series'
-usage = """%prog [options] <oldpatch> <newpatch>
+usage = """%prog [options] [oldpatch] <newpatch>
 
-Rename <oldpatch> into <newpatch> in a series."""
+Rename <oldpatch> into <newpatch> in a series. If <oldpatch> is not given, the
+top-most patch will be renamed. """
 
 directory = DirectoryHasRepository()
 options = [make_option('-b', '--branch',
@@ -37,9 +38,17 @@ options = [make_option('-b', '--branch',
 def func(parser, options, args):
     """Rename a patch in the series
     """
-    if len(args) != 2:
-        parser.error('incorrect number of arguments')
-
-    out.start('Renaming patch "%s" to "%s"' % (args[0], args[1]))
-    crt_series.rename_patch(args[0], args[1])
+    crt=crt_series.get_current()
+
+    if len(args) == 2:
+        old, new=args
+    elif len(args) == 1:
+        if not crt:
+            raise CmdException, "No applied top patch to rename exists."
+        old, [new]=crt, args
+    else: parser.error('incorrect number of arguments')
+
+    out.start('Renaming patch "%s" to "%s"' % (old, new))
+    crt_series.rename_patch(old, new)
+    
     out.done()
