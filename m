From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 3/3] Make hidden patches visible to various commands
	(notably log, show, pick).
Date: Thu, 28 Jun 2007 23:44:15 +0200
Message-ID: <20070628214415.26983.73520.stgit@gandelf.nowhere.earth>
References: <20070628214242.26983.99859.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 23:44:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I41nL-0002wS-D9
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 23:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764912AbXF1Vob (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 17:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762925AbXF1Vob
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 17:44:31 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:42522 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760384AbXF1Voa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 17:44:30 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 71A215A244;
	Thu, 28 Jun 2007 23:44:29 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 584901F084;
	Thu, 28 Jun 2007 23:44:15 +0200 (CEST)
In-Reply-To: <20070628214242.26983.99859.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51133>

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/common.py |    3 ++-
 stgit/commands/log.py    |    3 ++-
 stgit/commands/show.py   |    3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index b05979b..14dbf67 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -89,7 +89,8 @@ def git_id(rev):
             patch = series.get_current()
             if not patch:
                 raise CmdException, 'No patches applied'
-        if patch in series.get_applied() or patch in series.get_unapplied():
+        if patch in series.get_applied() or patch in series.get_unapplied() or \
+               patch in series.get_hidden():
             if patch_id in ['top', '', None]:
                 return series.get_patch(patch).get_top()
             elif patch_id == 'bottom':
diff --git a/stgit/commands/log.py b/stgit/commands/log.py
index e3e17f9..9259290 100644
--- a/stgit/commands/log.py
+++ b/stgit/commands/log.py
@@ -90,7 +90,8 @@ def func(parser, options, args):
             raise CmdException, 'No patches applied'
     elif len(args) == 1:
         name = args[0]
-        if not name in crt_series.get_applied() + crt_series.get_unapplied():
+        if not name in crt_series.get_applied() + crt_series.get_unapplied() + \
+           crt_series.get_hidden():
             raise CmdException, 'Unknown patch "%s"' % name
     else:
         parser.error('incorrect number of arguments')
diff --git a/stgit/commands/show.py b/stgit/commands/show.py
index 3bf4f20..2b22744 100644
--- a/stgit/commands/show.py
+++ b/stgit/commands/show.py
@@ -55,7 +55,8 @@ def func(parser, options, args):
     elif len(args) == 0:
         patches = ['HEAD']
     else:
-        patches = parse_patches(args, applied + unapplied, len(applied))
+        patches = parse_patches(args, applied + unapplied +\
+                                crt_series.get_hidden(), len(applied))
 
     if options.diff_opts:
         diff_flags = options.diff_opts.split()
