From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [patch 09/11] Allow mailing a given patch list
Date: Fri, 16 Sep 2005 21:35:22 +0200
Message-ID: <20050916193522.18681.94911.stgit@zion.home.lan>
References: <20050916193511.18681.24189.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 21:40:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGM2V-0005pe-R1
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 21:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965305AbVIPTiX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 15:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965307AbVIPTiX
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 15:38:23 -0400
Received: from ppp-62-11-79-165.dialup.tiscali.it ([62.11.79.165]:27019 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965305AbVIPTiW
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 15:38:22 -0400
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id B54C628615;
	Fri, 16 Sep 2005 21:35:22 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20050916193511.18681.24189.stgit@zion.home.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8719>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

I tried to mail a cherry-picked subset of my series and that didn't work - using
stg export and quilt was even worse, so I had to code something.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 stgit/commands/mail.py |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -26,7 +26,7 @@ from stgit.config import config
 
 
 help = 'send a patch or series of patches by e-mail'
-usage = """%prog [options] [<patch>]
+usage = """%prog [options] [<patch> [<patch2...]]
 
 Send a patch or a range of patches (defaulting to the applied patches)
 by e-mail using the 'smtpserver' configuration option. The From
@@ -265,9 +265,6 @@ def func(parser, options, args):
     """Send the patches by e-mail using the patchmail.tmpl file as
     a template
     """
-    if len(args) > 1:
-        parser.error('incorrect number of arguments')
-
     if not config.has_option('stgit', 'smtpserver'):
         raise CmdException, 'smtpserver not defined'
     smtpserver = config.get('stgit', 'smtpserver')
@@ -281,11 +278,11 @@ def func(parser, options, args):
 
     applied = crt_series.get_applied()
 
-    if len(args) == 1:
-        if args[0] in applied:
-            patches = [args[0]]
-        else:
-            raise CmdException, 'Patch "%s" not applied' % args[0]
+    if len(args) >= 1:
+        for patch in args:
+            if not patch in applied:
+                raise CmdException, 'Patch "%s" not applied' % patch
+            patches = args
     elif options.all:
         patches = applied
     elif options.range:
