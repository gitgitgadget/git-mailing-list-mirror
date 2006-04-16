From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 9/9] Look for templates in ~/.stgit/templates as well
Date: Sun, 16 Apr 2006 12:52:46 +0200
Message-ID: <20060416105246.9884.33207.stgit@gandelf.nowhere.earth>
References: <20060416104144.9884.28167.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 12:50:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FV4q0-0001JH-RC
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 12:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWDPKub (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 06:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWDPKub
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 06:50:31 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:58560 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750714AbWDPKu2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 06:50:28 -0400
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 29F0320615;
	Sun, 16 Apr 2006 12:50:27 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by nan92-1-81-57-214-146 with esmtp (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FV4z6-0004Aw-Pb; Sun, 16 Apr 2006 13:00:04 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20060416104144.9884.28167.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18780>


This can be quite useful to avoid adding one's sig again and again to
ever covermail, and to use a patchmail template that insert
Signed-off-by lines, for those of us who prefer this to adding them to
commits.

Also make sure to use os.path.join() instead of hardcoded slashes.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/export.py |    9 ++++++---
 stgit/commands/mail.py   |   18 ++++++++++++------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/stgit/commands/export.py b/stgit/commands/export.py
index e7de902..fbf5690 100644
--- a/stgit/commands/export.py
+++ b/stgit/commands/export.py
@@ -31,8 +31,9 @@ usage = """%prog [options] [<dir>]
 
 Export the applied patches into a given directory (defaults to
 'patches') in a standard unified GNU diff format. A template file
-(defaulting to '.git/patchexport.tmpl or
-/usr/share/stgit/templates/patchexport.tmpl') can be used for the
+(defaulting to '.git/patchexport.tmpl' or
+'~/.stgit/templates/patchexport.tmpl' or
+'/usr/share/stgit/templates/patchexport.tmpl') can be used for the
 patch format. The following variables are supported in the template
 file:
 
@@ -145,8 +146,10 @@ def func(parser, options, args):
         patch_tmpl_list = []
 
     patch_tmpl_list += [os.path.join(basedir.get(), 'patchexport.tmpl'),
+                        os.path.join(os.path.expanduser('~'), '.stgit', 'templates',
+                                     'patchexport.tmpl'),
                         os.path.join(sys.prefix,
-                                     'share/stgit/templates/patchexport.tmpl')]
+                                     'share', 'stgit', 'templates', 'patchexport.tmpl')]
     tmpl = ''
     for patch_tmpl in patch_tmpl_list:
         if os.path.isfile(patch_tmpl):
diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 470cf65..5e01ea1 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -30,16 +30,18 @@ usage = """%prog [options] [<patch> [<pa
 Send a patch or a range of patches (defaulting to the applied patches)
 by e-mail using the 'smtpserver' configuration option. The From
 address and the e-mail format are generated from the template file
-passed as argument to '--template' (defaulting to .git/patchmail.tmpl
-or /usr/share/stgit/templates/patchmail.tmpl). The To/Cc/Bcc addresses
+passed as argument to '--template' (defaulting to
+'.git/patchmail.tmpl' or '~/.stgit/templates/patchmail.tmpl' or or
+'/usr/share/stgit/templates/patchmail.tmpl'). The To/Cc/Bcc addresses
 can either be added to the template file or passed via the
 corresponding command line options.
 
 A preamble e-mail can be sent using the '--cover' and/or '--edit'
 options. The first allows the user to specify a file to be used as a
 template. The latter option will invoke the editor on the specified
-file (defaulting to .git/covermail.tmpl or
-/usr/share/stgit/templates/covermail.tmpl).
+file (defaulting to '.git/covermail.tmpl' or
+'~/.stgit/templates/covermail.tmpl' or
+'/usr/share/stgit/templates/covermail.tmpl').
 
 All the subsequent e-mails appear as replies to the first e-mail sent
 (either the preamble or the first patch). E-mails can be seen as
@@ -444,8 +446,10 @@ def func(parser, options, args):
             tfile_list = [options.cover]
         else:
             tfile_list = [os.path.join(basedir.get(), 'covermail.tmpl'),
+                          os.path.join(os.path.expanduser('~'), '.stgit', 'templates',
+                                       'covermail.tmpl'),
                           os.path.join(sys.prefix,
-                                       'share/stgit/templates/covermail.tmpl')]
+                                       'share', 'stgit', 'templates', 'covermail.tmpl')]
 
         tmpl = None
         for tfile in tfile_list:
@@ -476,8 +480,10 @@ def func(parser, options, args):
         tfile_list = [options.template]
     else:
         tfile_list = [os.path.join(basedir.get(), 'patchmail.tmpl'),
+                      os.path.join(os.path.expanduser('~'), '.stgit', 'templates',
+                                   'patchmail.tmpl'),
                       os.path.join(sys.prefix,
-                                   'share/stgit/templates/patchmail.tmpl')]
+                                   'share', 'stgit', 'templates', 'patchmail.tmpl')]
     tmpl = None
     for tfile in tfile_list:
         if os.path.isfile(tfile):
