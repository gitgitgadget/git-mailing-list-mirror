From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/2] Implement "stg refresh --edit" again
Date: Fri, 04 Jul 2008 08:40:36 +0200
Message-ID: <20080704064036.9637.52951.stgit@yoghurt>
References: <20080704063755.9637.23750.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 08:42:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEezq-0001WJ-A1
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 08:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbYGDGlN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jul 2008 02:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752805AbYGDGlN
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 02:41:13 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2097 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836AbYGDGlK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 02:41:10 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KEeyB-0000Oi-00; Fri, 04 Jul 2008 07:40:35 +0100
In-Reply-To: <20080704063755.9637.23750.stgit@yoghurt>
User-Agent: StGIT/0.14.3.185.gb9e85
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87367>

The -e/--edit flag to "stg refresh" was dropped between v0.13 and
v0.14, causing severe user dissatisfaction. This patch restores it,
along with -m/--message, -f/--file, --sign, --ack, --author,
--authname, --authemail, and --authdate.

I omitted the --committer options on purpose; I think they are a
mistake. Falsifying the committer info is not a common operation, and
if one wishes to do it for some reason, one can always set the
GIT_COMMITTER_* environment variables.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/coalesce.py |    2 +-
 stgit/commands/edit.py     |    3 ++-
 stgit/commands/new.py      |    3 ++-
 stgit/commands/refresh.py  |   44 +++++++++++++++++++++++++++++++++---=
--------
 stgit/utils.py             |   18 ++++++++++++------
 5 files changed, 50 insertions(+), 20 deletions(-)


diff --git a/stgit/commands/coalesce.py b/stgit/commands/coalesce.py
index 1a34934..f3954ce 100644
--- a/stgit/commands/coalesce.py
+++ b/stgit/commands/coalesce.py
@@ -35,7 +35,7 @@ done a sequence of pushes and pops yourself."""
=20
 directory =3D common.DirectoryHasRepositoryLib()
 options =3D [make_option('-n', '--name', help =3D 'name of coalesced p=
atch')
-           ] + utils.make_message_options()
+           ] + utils.make_message_options(save_template =3D True)
=20
 class SaveTemplateDone(Exception):
     pass
diff --git a/stgit/commands/edit.py b/stgit/commands/edit.py
index a9e8991..a83ec9c 100644
--- a/stgit/commands/edit.py
+++ b/stgit/commands/edit.py
@@ -60,7 +60,8 @@ options =3D [make_option('-d', '--diff',
                        action =3D 'store_true'),
            make_option('-e', '--edit', action =3D 'store_true',
                        help =3D 'invoke interactive editor'),
-           ] + (utils.make_sign_options() + utils.make_message_options=
()
+           ] + (utils.make_sign_options()
+                + utils.make_message_options(save_template =3D True)
                 + utils.make_author_committer_options()
                 + utils.make_diff_opts_option())
=20
diff --git a/stgit/commands/new.py b/stgit/commands/new.py
index c4ee4e1..f468ab0 100644
--- a/stgit/commands/new.py
+++ b/stgit/commands/new.py
@@ -38,7 +38,8 @@ line of the commit message."""
=20
 directory =3D common.DirectoryHasRepositoryLib()
 options =3D (utils.make_author_committer_options()
-           + utils.make_message_options() + utils.make_sign_options())
+           + utils.make_message_options(save_template =3D True)
+           + utils.make_sign_options())
=20
 def func(parser, options, args):
     """Create a new patch."""
diff --git a/stgit/commands/refresh.py b/stgit/commands/refresh.py
index 7afc55e..37cb559 100644
--- a/stgit/commands/refresh.py
+++ b/stgit/commands/refresh.py
@@ -20,7 +20,7 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston,=
 MA 02111-1307 USA
=20
 from optparse import make_option
 from stgit.commands import common
-from stgit.lib import git, transaction
+from stgit.lib import git, transaction, edit
 from stgit import utils
=20
 help =3D 'generate a new commit for the current patch'
@@ -53,7 +53,11 @@ options =3D [make_option('-u', '--update', action =3D=
 'store_true',
                        help =3D ('only include changes from the index,=
 not'
                                ' from the work tree')),
            make_option('-p', '--patch',
-                       help =3D 'refresh PATCH instead of the topmost =
patch')]
+                       help =3D 'refresh PATCH instead of the topmost =
patch'),
+           make_option('-e', '--edit', action =3D 'store_true',
+                       help =3D 'invoke an editor for the patch descri=
ption')
+           ] + (utils.make_message_options(save_template =3D False)
+                + utils.make_sign_options() + utils.make_author_option=
s())
=20
 def get_patch(stack, given_patch):
     """Get the name of the patch we are to refresh."""
@@ -116,9 +120,12 @@ def make_temp_patch(stack, patch_name, paths, temp=
_index):
     return trans.run(stack.repository.default_iw,
                      print_current_patch =3D False), temp_name
=20
-def absorb_applied(trans, iw, patch_name, temp_name):
+def absorb_applied(trans, iw, patch_name, temp_name, edit_fun):
     """Absorb the temp patch (C{temp_name}) into the given patch
-    (C{patch_name}), which must be applied.
+    (C{patch_name}), which must be applied. If the absorption
+    succeeds, call C{edit_fun} on the resulting
+    L{CommitData<stgit.lib.git.CommitData>} before committing it and
+    commit the return value.
=20
     @return: C{True} if we managed to absorb the temp patch, C{False}
              if we had to leave it for the user to deal with."""
@@ -136,7 +143,7 @@ def absorb_applied(trans, iw, patch_name, temp_name=
):
         temp_cd =3D trans.patches[temp_name].data
         assert trans.patches[patch_name] =3D=3D temp_cd.parent
         trans.patches[patch_name] =3D trans.stack.repository.commit(
-            trans.patches[patch_name].data.set_tree(temp_cd.tree))
+            edit_fun(trans.patches[patch_name].data.set_tree(temp_cd.t=
ree)))
         popped =3D trans.delete_patches(lambda pn: pn =3D=3D temp_name=
, quiet =3D True)
         assert not popped # the temp patch was topmost
         temp_absorbed =3D True
@@ -148,9 +155,12 @@ def absorb_applied(trans, iw, patch_name, temp_nam=
e):
         pass
     return temp_absorbed
=20
-def absorb_unapplied(trans, iw, patch_name, temp_name):
+def absorb_unapplied(trans, iw, patch_name, temp_name, edit_fun):
     """Absorb the temp patch (C{temp_name}) into the given patch
-    (C{patch_name}), which must be unapplied.
+    (C{patch_name}), which must be unapplied. If the absorption
+    succeeds, call C{edit_fun} on the resulting
+    L{CommitData<stgit.lib.git.CommitData>} before committing it and
+    commit the return value.
=20
     @param iw: Not used.
     @return: C{True} if we managed to absorb the temp patch, C{False}
@@ -174,7 +184,7 @@ def absorb_unapplied(trans, iw, patch_name, temp_na=
me):
         # It worked. Refresh the patch with the new tree, and delete
         # the temp patch.
         trans.patches[patch_name] =3D trans.stack.repository.commit(
-            patch_cd.set_tree(new_tree))
+            edit_fun(patch_cd.set_tree(new_tree)))
         popped =3D trans.delete_patches(lambda pn: pn =3D=3D temp_name=
, quiet =3D True)
         assert not popped # the temp patch was not applied
         return True
@@ -183,13 +193,13 @@ def absorb_unapplied(trans, iw, patch_name, temp_=
name):
         # leave the temp patch for the user.
         return False
=20
-def absorb(stack, patch_name, temp_name):
+def absorb(stack, patch_name, temp_name, edit_fun):
     """Absorb the temp patch into the target patch."""
     trans =3D transaction.StackTransaction(stack, 'refresh')
     iw =3D stack.repository.default_iw
     f =3D { True: absorb_applied, False: absorb_unapplied
           }[patch_name in trans.applied]
-    if f(trans, iw, patch_name, temp_name):
+    if f(trans, iw, patch_name, temp_name, edit_fun):
         def info_msg(): pass
     else:
         def info_msg():
@@ -223,4 +233,16 @@ def func(parser, options, args):
         stack, patch_name, paths, temp_index =3D path_limiting)
     if retval !=3D utils.STGIT_SUCCESS:
         return retval
-    return absorb(stack, patch_name, temp_name)
+    def edit_fun(cd):
+        cd, failed_diff =3D edit.auto_edit_patch(
+            stack.repository, cd, msg =3D options.message, contains_di=
ff =3D False,
+            author =3D options.author, committer =3D lambda p: p,
+            sign_str =3D options.sign_str)
+        assert not failed_diff
+        if options.edit:
+            cd, failed_diff =3D edit.interactive_edit_patch(
+                stack.repository, cd, edit_diff =3D False,
+                diff_flags =3D [], replacement_diff =3D None)
+            assert not failed_diff
+        return cd
+    return absorb(stack, patch_name, temp_name, edit_fun)
diff --git a/stgit/utils.py b/stgit/utils.py
index 2983ea8..c40e666 100644
--- a/stgit/utils.py
+++ b/stgit/utils.py
@@ -264,13 +264,13 @@ def add_sign_line(desc, sign_str, name, email):
         desc =3D desc + '\n'
     return '%s\n%s\n' % (desc, sign_str)
=20
-def make_message_options():
+def make_message_options(save_template):
     def no_dup(parser):
         if parser.values.message !=3D None:
             raise optparse.OptionValueError(
                 'Cannot give more than one --message or --file')
     def no_combine(parser):
-        if (parser.values.message !=3D None
+        if (save_template and parser.values.message !=3D None
             and parser.values.save_template !=3D None):
             raise optparse.OptionValueError(
                 'Cannot give both --message/--file and --save-template=
')
@@ -299,15 +299,18 @@ def make_message_options():
         parser.values.save_template =3D w
         no_combine(parser)
     m =3D optparse.make_option
-    return [m('-m', '--message', action =3D 'callback', callback =3D m=
sg_callback,
+    opts =3D [m('-m', '--message', action =3D 'callback', callback =3D=
 msg_callback,
               dest =3D 'message', type =3D 'string',
               help =3D 'use MESSAGE instead of invoking the editor'),
             m('-f', '--file', action =3D 'callback', callback =3D file=
_callback,
               dest =3D 'message', type =3D 'string', metavar =3D 'FILE=
',
-              help =3D 'use FILE instead of invoking the editor'),
+              help =3D 'use FILE instead of invoking the editor')]
+    if save_template:
+        opts.append(
             m('--save-template', action =3D 'callback', callback =3D t=
empl_callback,
               metavar =3D 'FILE', dest =3D 'save_template', type =3D '=
string',
-              help =3D 'save the message template to FILE and exit')]
+              help =3D 'save the message template to FILE and exit'))
+    return opts
=20
 def make_diff_opts_option():
     def diff_opts_callback(option, opt_str, value, parser):
@@ -368,8 +371,11 @@ def make_person_options(person, short):
                 callback_args =3D (f,), help =3D 'set the %s %s' % (pe=
rson, f))
                for f in ['name', 'email', 'date']])
=20
+def make_author_options():
+    return make_person_options('author', 'auth')
+
 def make_author_committer_options():
-    return (make_person_options('author', 'auth')
+    return (make_author_options()
             + make_person_options('committer', 'comm'))
=20
 # Exit codes.
