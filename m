From: Max Kellermann <max@duempel.org>
Subject: [stgit PATCH] commands.{new,rename}: verify patch names
Date: Tue, 05 Oct 2010 13:45:41 +0200
Message-ID: <20101005114541.15037.53617.stgit@woodpecker.blarg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 05 13:52:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P364R-0002cj-Lf
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 13:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625Ab0JELwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 07:52:30 -0400
Received: from smtp6.netcologne.de ([194.8.194.26]:44894 "EHLO
	smtp6.netcologne.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514Ab0JELwa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 07:52:30 -0400
X-Greylist: delayed 403 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Oct 2010 07:52:29 EDT
Received: from squirrel.blarg.de (cable-78-35-111-134.netcologne.de [78.35.111.134])
	by smtp6.netcologne.de (Postfix) with ESMTP id 607D62A09AE
	for <git@vger.kernel.org>; Tue,  5 Oct 2010 13:45:45 +0200 (CEST)
Received: from woodpecker.blarg.de (woodpecker.blarg.de [IPv6:2001:4dd0:ff06::7])
	by squirrel.blarg.de (Postfix) with ESMTP id 4089620D3B
	for <git@vger.kernel.org>; Tue,  5 Oct 2010 13:45:45 +0200 (CEST)
User-Agent: StGit/0.15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158190>

Don't allow patches with invalid names.  For example, a patch with a
slash in the name will cause the underlying git command to fail, and
stgit doesn't handle this error condition properly.
---
 stgit/commands/new.py    |    3 +++
 stgit/commands/rename.py |    3 +++
 stgit/utils.py           |    5 +++++
 3 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/stgit/commands/new.py b/stgit/commands/new.py
index d5c5382..6bd7314 100644
--- a/stgit/commands/new.py
+++ b/stgit/commands/new.py
@@ -61,6 +61,9 @@ def func(parser, options, args):
         name = args[0]
         if stack.patches.exists(name):
             raise common.CmdException('%s: patch already exists' % name)
+
+        if not utils.check_patch_name(name):
+            raise common.CmdException('%s: invalid patch name' % name)
     else:
         parser.error('incorrect number of arguments')
 
diff --git a/stgit/commands/rename.py b/stgit/commands/rename.py
index db898cb..7c229be 100644
--- a/stgit/commands/rename.py
+++ b/stgit/commands/rename.py
@@ -51,6 +51,9 @@ def func(parser, options, args):
     else:
         parser.error('incorrect number of arguments')
 
+    if not check_patch_name(new):
+        raise CmdException('%s: invalid patch name' % new)
+
     out.start('Renaming patch "%s" to "%s"' % (old, new))
     crt_series.rename_patch(old, new)
 
diff --git a/stgit/utils.py b/stgit/utils.py
index 2955adf..5c64871 100644
--- a/stgit/utils.py
+++ b/stgit/utils.py
@@ -241,6 +241,11 @@ def make_patch_name(msg, unacceptable, default_name = 'patch'):
         patchname = default_name
     return find_patch_name(patchname, unacceptable)
 
+def check_patch_name(name):
+    """Checks if the specified name is a valid patch name. For
+    technical reasons, we cannot allow a slash and other characters."""
+    return len(name) > 0 and name[0] != '.' and re.search(r'[\x00-\x20]', name) is None
+
 # any and all functions are builtin in Python 2.5 and higher, but not
 # in 2.4.
 if not 'any' in dir(__builtins__):
