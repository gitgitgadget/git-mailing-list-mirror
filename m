From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/5] Convert "stg new" to the new infrastructure
Date: Sun, 10 Feb 2008 21:43:53 +0100
Message-ID: <20080210204331.17683.84608.stgit@yoghurt>
References: <20080210203846.17683.43153.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 21:45:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOJ2q-0005Gg-Lp
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 21:45:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754621AbYBJUn6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 15:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754526AbYBJUn6
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 15:43:58 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4230 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754355AbYBJUn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 15:43:57 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JOJ1k-0005Cn-00; Sun, 10 Feb 2008 20:43:53 +0000
In-Reply-To: <20080210203846.17683.43153.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73406>

This results in considerable code expansion, which is a sure sign that
something needs to be abstracted away -- but to keep things simple,
those transformations come as separate patches.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/new.py |   85 ++++++++++++++++++++++++++++++++---------=
--------
 stgit/lib/git.py      |    8 ++---
 2 files changed, 60 insertions(+), 33 deletions(-)


diff --git a/stgit/commands/new.py b/stgit/commands/new.py
index 6a8f086..dd9f93e 100644
--- a/stgit/commands/new.py
+++ b/stgit/commands/new.py
@@ -16,13 +16,11 @@ along with this program; if not, write to the Free =
Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 US=
A
 """
=20
-import sys, os
-from optparse import OptionParser, make_option
-
-from stgit.commands.common import *
-from stgit.utils import *
-from stgit import stack, git
+from optparse import make_option
=20
+from stgit import utils
+from stgit.commands import common
+from stgit.lib import git as gitlib, transaction
=20
 help =3D 'create a new patch and make it the topmost one'
 usage =3D """%prog [options] [name]
@@ -38,12 +36,9 @@ this.
 If no name is given for the new patch, one is generated from the first
 line of the commit message."""
=20
-directory =3D DirectoryGotoToplevel()
+directory =3D common.DirectoryHasRepositoryLib()
 options =3D [make_option('-m', '--message',
                        help =3D 'use MESSAGE as the patch description'=
),
-           make_option('-s', '--showpatch',
-                       help =3D 'show the patch content in the editor =
buffer',
-                       action =3D 'store_true'),
            make_option('-a', '--author', metavar =3D '"NAME <EMAIL>"',
                        help =3D 'use "NAME <EMAIL>" as the author deta=
ils'),
            make_option('--authname',
@@ -56,30 +51,62 @@ options =3D [make_option('-m', '--message',
                        help =3D 'use COMMNAME as the committer name'),
            make_option('--commemail',
                        help =3D 'use COMMEMAIL as the committer e-mail=
')
-           ] + make_sign_options()
-
+           ] + utils.make_sign_options()
=20
 def func(parser, options, args):
-    """Creates a new patch
-    """
+    """Create a new patch."""
+    stack =3D directory.repository.current_stack
+    if stack.repository.default_index.conflicts():
+        raise common.CmdException(
+            'Cannot create a new patch -- resolve conflicts first')
+
+    # Choose a name for the new patch -- or None, which means make one
+    # up later when we've gotten hold of the commit message.
     if len(args) =3D=3D 0:
-        name =3D None # autogenerate a name
+        name =3D None
     elif len(args) =3D=3D 1:
         name =3D args[0]
+        if stack.patches.exists(name):
+            raise common.CmdException('%s: patch already exists' % nam=
e)
     else:
         parser.error('incorrect number of arguments')
=20
-    check_conflicts()
-    check_head_top_equal(crt_series)
-
-    if options.author:
-        options.authname, options.authemail =3D name_email(options.aut=
hor)
-
-    crt_series.new_patch(name, message =3D options.message,
-                         show_patch =3D options.showpatch,
-                         author_name =3D options.authname,
-                         author_email =3D options.authemail,
-                         author_date =3D options.authdate,
-                         committer_name =3D options.commname,
-                         committer_email =3D options.commemail,
-                         sign_str =3D options.sign_str)
+    head =3D directory.repository.refs.get(directory.repository.head)
+    cd =3D gitlib.Commitdata(tree =3D head.data.tree, parents =3D [hea=
d],
+                           message =3D '')
+
+    # Set patch commit message from commandline.
+    if options.message !=3D None:
+        cd =3D cd.set_message(options.message)
+
+    # Specify author and committer data.
+    if options.author !=3D None:
+        options.authname, options.authemail =3D common.name_email(opti=
ons.author)
+    for p, f, val in [('author', 'name', options.authname),
+                      ('author', 'email', options.authemail),
+                      ('author', 'date', gitlib.Date.maybe(options.aut=
hdate)),
+                      ('committer', 'name', options.commname),
+                      ('committer', 'email', options.commemail)]:
+        if val !=3D None:
+            cd =3D getattr(cd, 'set_' + p)(
+                getattr(getattr(cd, p), 'set_' + f)(val))
+
+    # Add Signed-off-by: or similar.
+    if options.sign_str !=3D None:
+        cd =3D cd.set_message(utils.add_sign_line(
+                cd.message, options.sign_str, gitlib.Person.committer(=
).name,
+                gitlib.Person.committer().email))
+
+    # Let user edit the commit message manually.
+    if not options.message:
+        cd =3D cd.set_message(utils.edit_string(cd.message, '.stgit-ne=
w.txt'))
+    if name =3D=3D None:
+        name =3D utils.make_patch_name(cd.message,
+                                     lambda name: stack.patches.exists=
(name))
+
+    # Write the new patch.
+    iw =3D stack.repository.default_iw
+    trans =3D transaction.StackTransaction(stack, 'stg new')
+    trans.patches[name] =3D stack.repository.commit(cd)
+    trans.applied.append(name)
+    return trans.run()
diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 50dc4f1..6ee8a71 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -24,13 +24,13 @@ class NoValue(object):
     pass
=20
 def make_defaults(defaults):
-    def d(val, attr):
+    def d(val, attr, default_fun =3D lambda: None):
         if val !=3D NoValue:
             return val
         elif defaults !=3D NoValue:
             return getattr(defaults, attr)
         else:
-            return None
+            return default_fun()
     return d
=20
 class TimeZone(tzinfo, Repr):
@@ -161,8 +161,8 @@ class Commitdata(Repr):
         d =3D make_defaults(defaults)
         self.__tree =3D d(tree, 'tree')
         self.__parents =3D d(parents, 'parents')
-        self.__author =3D d(author, 'author')
-        self.__committer =3D d(committer, 'committer')
+        self.__author =3D d(author, 'author', Person.author)
+        self.__committer =3D d(committer, 'committer', Person.committe=
r)
         self.__message =3D d(message, 'message')
     tree =3D property(lambda self: self.__tree)
     parents =3D property(lambda self: self.__parents)
