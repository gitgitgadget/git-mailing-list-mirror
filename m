From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGIT PATCH 1/5] Allow stack.patchorder.all to return hidden patches
Date: Wed, 04 Jun 2008 22:13:17 +0100
Message-ID: <20080604211316.32531.84226.stgit@localhost.localdomain>
References: <20080604210655.32531.82580.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: kha@treskal.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 23:14:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K40JC-0002NH-EW
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 23:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255AbYFDVNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 17:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753231AbYFDVNV
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 17:13:21 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:36974 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752627AbYFDVNU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jun 2008 17:13:20 -0400
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com with ESMTP
          id <20080604211835.EFWK16629.mtaout03-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>;
          Wed, 4 Jun 2008 22:18:35 +0100
Received: from localhost.localdomain ([86.7.22.36])
          by aamtaout01-winn.ispmail.ntl.com with ESMTP
          id <20080604211844.GGJI16854.aamtaout01-winn.ispmail.ntl.com@localhost.localdomain>;
          Wed, 4 Jun 2008 22:18:44 +0100
In-Reply-To: <20080604210655.32531.82580.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.2.152.g3f19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83828>

A new property, patchorder.all_visible, was added to return only the
applied + unapplied patches. This is used in the "commit" command to
avoid automatically committing the hidden patches.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 stgit/commands/commit.py  |    4 ++--
 stgit/lib/stack.py        |    4 ++--
 stgit/lib/stackupgrade.py |    7 +++++++
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/stgit/commands/commit.py b/stgit/commands/commit.py
index cc2f13a..1bdbeea 100644
--- a/stgit/commands/commit.py
+++ b/stgit/commands/commit.py
@@ -45,11 +45,11 @@ options = [make_option('-n', '--number', type = 'int',
 def func(parser, options, args):
     """Commit a number of patches."""
     stack = directory.repository.current_stack
-    args = common.parse_patches(args, list(stack.patchorder.all))
+    args = common.parse_patches(args, list(stack.patchorder.all_visible))
     if len([x for x in [args, options.number != None, options.all] if x]) > 1:
         parser.error('too many options')
     if args:
-        patches = [pn for pn in stack.patchorder.all if pn in args]
+        patches = [pn for pn in stack.patchorder.all_visible if pn in args]
         bad = set(args) - set(patches)
         if bad:
             raise common.CmdException('Bad patch names: %s'
diff --git a/stgit/lib/stack.py b/stgit/lib/stack.py
index f9e750e..bdd21b1 100644
--- a/stgit/lib/stack.py
+++ b/stgit/lib/stack.py
@@ -102,8 +102,8 @@ class PatchOrder(object):
                          lambda self, val: self.__set_list('unapplied', val))
     hidden = property(lambda self: self.__get_list('hidden'),
                       lambda self, val: self.__set_list('hidden', val))
-    # don't return the hidden patches, these have to be returned explicitly
-    all = property(lambda self: self.applied + self.unapplied)
+    all = property(lambda self: self.applied + self.unapplied + self.hidden)
+    all_visible = property(lambda self: self.applied + self.unapplied)
 
 class Patches(object):
     """Creates L{Patch} objects. Makes sure there is only one such object
diff --git a/stgit/lib/stackupgrade.py b/stgit/lib/stackupgrade.py
index 96ccb79..4b437dc 100644
--- a/stgit/lib/stackupgrade.py
+++ b/stgit/lib/stackupgrade.py
@@ -90,6 +90,13 @@ def update_to_current_format_version(repository, branch):
         rm_ref('refs/bases/%s' % branch)
         set_format_version(2)
 
+    # compatibility with the new infrastructure. The changes here do not
+    # affect the compatibility with the old infrastructure (format version 2)
+    if get_format_version() == 2:
+        hidden_file = os.path.join(branch_dir, 'hidden')
+        if not os.path.isfile(hidden_file):
+            utils.create_empty_file(hidden_file)
+
     # Make sure we're at the latest version.
     fv = get_format_version()
     if not fv in [None, FORMAT_VERSION]:
