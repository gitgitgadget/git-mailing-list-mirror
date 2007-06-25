From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 3/7] Revert part of the reverted commit that we want to
	keep.
Date: Mon, 25 Jun 2007 23:24:36 +0200
Message-ID: <20070625212436.17189.13221.stgit@gandelf.nowhere.earth>
References: <20070625212229.17189.79919.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 23:24:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2w3I-0004lZ-9d
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 23:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbXFYVYs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 17:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752240AbXFYVYs
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 17:24:48 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:51199 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035AbXFYVYr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 17:24:47 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 7A6EF5A29D;
	Mon, 25 Jun 2007 23:24:46 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 6E1E21F150;
	Mon, 25 Jun 2007 23:24:36 +0200 (CEST)
In-Reply-To: <20070625212229.17189.79919.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50922>

- get rid of unused real_rebase parameter
- revive git.all_refs()

This commit can freely be used to demonstrate the usefulness of
_always_ separating different issues in different patches :)

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/common.py |    2 +-
 stgit/commands/pull.py   |    2 +-
 stgit/commands/rebase.py |    2 +-
 stgit/git.py             |    6 ++++++
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 22c78ae..b05979b 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -318,7 +318,7 @@ def address_or_alias(addr_str):
                  for addr in addr_str.split(',')]
     return ', '.join([addr for addr in addr_list if addr])
 
-def prepare_rebase(real_rebase, force=None):
+def prepare_rebase(force=None):
     if not force:
         # Be sure we won't loose results of stg-(un)commit by error.
         # Do not require an existing orig-base for compatibility with 0.12 and earlier.
diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index 5f72f9b..fe3b67d 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -86,7 +86,7 @@ def func(parser, options, args):
     else:
         raise GitConfigException, 'Unsupported pull-policy "%s"' % policy
 
-    applied = prepare_rebase(real_rebase=must_rebase, force=options.force)
+    applied = prepare_rebase(force=options.force)
 
     # pull the remote changes
     if policy == 'pull':
diff --git a/stgit/commands/rebase.py b/stgit/commands/rebase.py
index 2f0e660..e47772c 100644
--- a/stgit/commands/rebase.py
+++ b/stgit/commands/rebase.py
@@ -56,7 +56,7 @@ def func(parser, options, args):
     if git_id(args[0]) == None:
         raise GitException, 'Unknown revision: %s' % git_id
         
-    applied = prepare_rebase(real_rebase=True, force=options.force)
+    applied = prepare_rebase(force=options.force)
     rebase(args[0])
     post_rebase(applied, options.nopush, options.merged)
 
diff --git a/stgit/git.py b/stgit/git.py
index 02590a9..1f57481 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -1070,3 +1070,9 @@ def fetch_head():
 
     # here we are sure to have a single fetch_head
     return fetch_head
+
+def all_refs():
+    """Return a list of all refs in the current repository.
+    """
+
+    return [line.split()[1] for line in _output_lines(['git-show-ref'])]
