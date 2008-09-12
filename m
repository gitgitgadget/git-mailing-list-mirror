From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGit PATCH] Autosign newly created patches
Date: Fri, 12 Sep 2008 22:55:56 +0100
Message-ID: <20080912215515.10270.32667.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 13 00:03:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeGjU-0001Uv-CV
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 00:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755626AbYILWCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 18:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758212AbYILWCF
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 18:02:05 -0400
Received: from queueout04-winn.ispmail.ntl.com ([81.103.221.58]:7614 "EHLO
	queueout04-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758128AbYILWCD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Sep 2008 18:02:03 -0400
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com with ESMTP
          id <20080912215558.DPOJ777.mtaout01-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Fri, 12 Sep 2008 22:55:58 +0100
Received: from localhost.localdomain ([86.9.203.187])
          by aamtaout02-winn.ispmail.ntl.com with ESMTP
          id <20080912215558.CHG19289.aamtaout02-winn.ispmail.ntl.com@localhost.localdomain>;
          Fri, 12 Sep 2008 22:55:58 +0100
User-Agent: StGIT/0.14.3.225.g09cf8
X-Cloudmark-Analysis: v=1.0 c=1 a=-DC0vdt7Pe0A:10 a=H9FbovSsfqkA:10 a=a997HNTs75FmMc34-BYA:9 a=YTpbExu9G1ZLcBEUXnducsMv7hoA:4 a=MSl-tDqOz04A:10 a=t51ySBQuod0A:10 a=XF7b4UCPwd8A:10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95778>

This patch adds the autosign configuration variable which is checked by
the "new" command to automatically sign the patch message.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

BTW, what happened to the patchdescr.tmpl file? It doesn't seem to be
used anymore, however one can save a template file

 examples/gitconfig    |    3 +++
 stgit/commands/new.py |    8 +++++++-
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/examples/gitconfig b/examples/gitconfig
index 4a36202..9efc089 100644
--- a/examples/gitconfig
+++ b/examples/gitconfig
@@ -14,6 +14,9 @@
 	# Automatically Bcc the address below
 	#autobcc = your.name@yourcompany.com
 
+	# Automatically sign newly created patches
+	#autosign = Signed-off-by
+
 	# Set to 'yes' if you don't want to use the 'resolved' command.
 	# 'refresh' will automatically mark the conflicts as resolved
 	#autoresolved = no
diff --git a/stgit/commands/new.py b/stgit/commands/new.py
index eb45e1b..4a58d52 100644
--- a/stgit/commands/new.py
+++ b/stgit/commands/new.py
@@ -21,6 +21,7 @@ from optparse import make_option
 from stgit import argparse, utils
 from stgit.commands import common
 from stgit.lib import git as gitlib, transaction
+from stgit.config import config
 
 help = 'create a new patch and make it the topmost one'
 usage = """%prog [options] [name]
@@ -72,8 +73,13 @@ def func(parser, options, args):
 
     # Add Signed-off-by: or similar.
     if options.sign_str != None:
+        sign_str = options.sign_str
+    else:
+        sign_str = config.get("stgit.autosign")
+
+    if sign_str != None:
         cd = cd.set_message(
-            utils.add_sign_line(cd.message, options.sign_str,
+            utils.add_sign_line(cd.message, sign_str,
                                 cd.committer.name, cd.committer.email))
 
     if options.save_template:
