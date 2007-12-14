From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 3/5] Set exit code to 3 on merge conflict
Date: Fri, 14 Dec 2007 07:32:24 +0100
Message-ID: <20071214063224.29290.45251.stgit@yoghurt>
References: <20071214062618.29290.70792.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 07:33:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J347G-0003xt-5D
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 07:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761232AbXLNGc3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 01:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761438AbXLNGc3
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 01:32:29 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4231 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758375AbXLNGc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 01:32:27 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1J345v-0002pE-00; Fri, 14 Dec 2007 06:32:23 +0000
In-Reply-To: <20071214062618.29290.70792.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68244>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/coalesce.py |    6 +++---
 stgit/commands/goto.py     |    2 +-
 stgit/lib/transaction.py   |    7 ++++++-
 stgit/main.py              |    4 ++--
 stgit/utils.py             |    1 +
 5 files changed, 13 insertions(+), 7 deletions(-)


diff --git a/stgit/commands/coalesce.py b/stgit/commands/coalesce.py
index 2330231..d2cba3e 100644
--- a/stgit/commands/coalesce.py
+++ b/stgit/commands/coalesce.py
@@ -110,7 +110,7 @@ def _coalesce(stack, iw, name, msg, save_template, =
patches):
         return
     except transaction.TransactionHalted:
         pass
-    trans.run(iw)
+    return trans.run(iw)
=20
 def func(parser, options, args):
     stack =3D directory.repository.current_stack
@@ -118,5 +118,5 @@ def func(parser, options, args):
                                           + list(stack.patchorder.unap=
plied)))
     if len(patches) < 2:
         raise common.CmdException('Need at least two patches')
-    _coalesce(stack, stack.repository.default_iw(),
-              options.name, options.message, options.save_template, pa=
tches)
+    return _coalesce(stack, stack.repository.default_iw(), options.nam=
e,
+                     options.message, options.save_template, patches)
diff --git a/stgit/commands/goto.py b/stgit/commands/goto.py
index d78929d..763a8af 100644
--- a/stgit/commands/goto.py
+++ b/stgit/commands/goto.py
@@ -48,4 +48,4 @@ def func(parser, options, args):
             pass
     else:
         raise common.CmdException('Patch "%s" does not exist' % patch)
-    trans.run(iw)
+    return trans.run(iw)
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 663d393..0ca647e 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -1,4 +1,4 @@
-from stgit import exception
+from stgit import exception, utils
 from stgit.out import *
 from stgit.lib import git
=20
@@ -111,6 +111,11 @@ class StackTransaction(object):
         self.__stack.patchorder.applied =3D self.__applied
         self.__stack.patchorder.unapplied =3D self.__unapplied
=20
+        if self.__error:
+            return utils.STGIT_CONFLICT
+        else:
+            return utils.STGIT_SUCCESS
+
     def __halt(self, msg):
         self.__error =3D msg
         raise TransactionHalted(msg)
diff --git a/stgit/main.py b/stgit/main.py
index a95eeb9..2577693 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -273,7 +273,7 @@ def main():
             else:
                 command.crt_series =3D Series()
=20
-        command.func(parser, options, args)
+        ret =3D command.func(parser, options, args)
     except (StgException, IOError, ParsingError, NoSectionError), err:
         out.error(str(err), title =3D '%s %s' % (prog, cmd))
         if debug_level > 0:
@@ -283,4 +283,4 @@ def main():
     except KeyboardInterrupt:
         sys.exit(utils.STGIT_GENERAL_ERROR)
=20
-    sys.exit(utils.STGIT_SUCCESS)
+    sys.exit(ret or utils.STGIT_SUCCESS)
diff --git a/stgit/utils.py b/stgit/utils.py
index 6568da5..2ff1d74 100644
--- a/stgit/utils.py
+++ b/stgit/utils.py
@@ -317,6 +317,7 @@ def make_message_options():
 STGIT_SUCCESS =3D 0        # everything's OK
 STGIT_GENERAL_ERROR =3D 1  # seems to be non-command-specific error
 STGIT_COMMAND_ERROR =3D 2  # seems to be a command that failed
+STGIT_CONFLICT =3D 3       # merge conflict, otherwise OK
=20
 def strip_leading(prefix, s):
     """Strip leading prefix from a string. Blow up if the prefix isn't
