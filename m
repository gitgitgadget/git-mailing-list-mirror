From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/2] Refactor stgit.commands.edit
Date: Fri, 04 Jul 2008 08:40:30 +0200
Message-ID: <20080704064030.9637.95802.stgit@yoghurt>
References: <20080704063755.9637.23750.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 08:42:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEezb-0001RJ-9m
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 08:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832AbYGDGlI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jul 2008 02:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752293AbYGDGlH
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 02:41:07 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2096 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbYGDGlF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 02:41:05 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KEey5-0000OV-00; Fri, 04 Jul 2008 07:40:29 +0100
In-Reply-To: <20080704063755.9637.23750.stgit@yoghurt>
User-Agent: StGIT/0.14.3.185.gb9e85
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87366>

Reorganize a few existing functions, and break out stuff from the main
function into subroutines.

While we're at it, move one of the old and all of the new functions to
stgit.lib.edit, so that we can use them in a later patch to implement
"stg refresh --edit".

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/common.py |    9 +++-
 stgit/commands/edit.py   |   79 +++++--------------------------------
 stgit/commands/imprt.py  |    2 -
 stgit/lib/edit.py        |   99 ++++++++++++++++++++++++++++++++++++++=
++++++++
 4 files changed, 117 insertions(+), 72 deletions(-)
 create mode 100644 stgit/lib/edit.py


diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 2689a42..c92554d 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -453,12 +453,15 @@ def parse_mail(msg):
=20
     return (descr, authname, authemail, authdate, diff)
=20
-def parse_patch(text):
+def parse_patch(text, contains_diff):
     """Parse the input text and return (description, authname,
     authemail, authdate, diff)
     """
-    descr, diff =3D __split_descr_diff(text)
-    descr, authname, authemail, authdate =3D __parse_description(descr=
)
+    if contains_diff:
+        (text, diff) =3D __split_descr_diff(text)
+    else:
+        diff =3D None
+    (descr, authname, authemail, authdate) =3D __parse_description(tex=
t)
=20
     # we don't yet have an agreed place for the creation date.
     # Just return None
diff --git a/stgit/commands/edit.py b/stgit/commands/edit.py
index a8499c6..a9e8991 100644
--- a/stgit/commands/edit.py
+++ b/stgit/commands/edit.py
@@ -22,7 +22,7 @@ from optparse import make_option
=20
 from stgit import git, utils
 from stgit.commands import common
-from stgit.lib import git as gitlib, transaction
+from stgit.lib import git as gitlib, transaction, edit
 from stgit.out import *
=20
 help =3D 'edit a patch description or diff'
@@ -64,45 +64,6 @@ options =3D [make_option('-d', '--diff',
                 + utils.make_author_committer_options()
                 + utils.make_diff_opts_option())
=20
-def patch_diff(repository, cd, diff, diff_flags):
-    if diff:
-        diff =3D repository.diff_tree(cd.parent.data.tree, cd.tree, di=
ff_flags)
-        return '\n'.join([git.diffstat(diff), diff])
-    else:
-        return None
-
-def patch_description(cd, diff):
-    """Generate a string containing the description to edit."""
-
-    desc =3D ['From: %s <%s>' % (cd.author.name, cd.author.email),
-            'Date: %s' % cd.author.date.isoformat(),
-            '',
-            cd.message]
-    if diff:
-        desc +=3D ['---',
-                 '',
-                diff]
-    return '\n'.join(desc)
-
-def patch_desc(repository, cd, failed_diff, diff, diff_flags):
-    return patch_description(cd, failed_diff or patch_diff(
-            repository, cd, diff, diff_flags))
-
-def update_patch_description(repository, cd, text):
-    message, authname, authemail, authdate, diff =3D common.parse_patc=
h(text)
-    cd =3D (cd.set_message(message)
-            .set_author(cd.author.set_name(authname)
-                                 .set_email(authemail)
-                                 .set_date(gitlib.Date.maybe(authdate)=
)))
-    failed_diff =3D None
-    if diff:
-        tree =3D repository.apply(cd.parent.data.tree, diff)
-        if tree =3D=3D None:
-            failed_diff =3D diff
-        else:
-            cd =3D cd.set_tree(tree)
-    return cd, failed_diff
-
 def func(parser, options, args):
     """Edit the given patch or the current one.
     """
@@ -122,44 +83,26 @@ def func(parser, options, args):
=20
     cd =3D orig_cd =3D stack.patches.get(patchname).commit.data
=20
-    # Read patch from user-provided description.
-    if options.message =3D=3D None:
-        failed_diff =3D None
-    else:
-        cd, failed_diff =3D update_patch_description(stack.repository,=
 cd,
-                                                   options.message)
-
-    # Modify author and committer data.
-    a, c =3D options.author(cd.author), options.committer(cd.committer=
)
-    if (a, c) !=3D (cd.author, cd.committer):
-        cd =3D cd.set_author(a).set_committer(c)
-
-    # Add Signed-off-by: or similar.
-    if options.sign_str !=3D None:
-        cd =3D cd.set_message(utils.add_sign_line(
-                cd.message, options.sign_str, gitlib.Person.committer(=
).name,
-                gitlib.Person.committer().email))
+    cd, failed_diff =3D edit.auto_edit_patch(
+        stack.repository, cd, msg =3D options.message, contains_diff =3D=
 True,
+        author =3D options.author, committer =3D options.committer,
+        sign_str =3D options.sign_str)
=20
     if options.save_template:
         options.save_template(
-            patch_desc(stack.repository, cd, failed_diff,
-                       options.diff, options.diff_flags))
+            patch_desc(stack.repository, cd,
+                       options.diff, options.diff_flags, failed_diff))
         return utils.STGIT_SUCCESS
=20
-    # Let user edit the patch manually.
     if cd =3D=3D orig_cd or options.edit:
-        fn =3D '.stgit-edit.' + ['txt', 'patch'][bool(options.diff)]
-        cd, failed_diff =3D update_patch_description(
-            stack.repository, cd, utils.edit_string(
-                patch_desc(stack.repository, cd, failed_diff,
-                           options.diff, options.diff_flags),
-                fn))
+        cd, failed_diff =3D edit.interactive_edit_patch(
+            stack.repository, cd, options.diff, options.diff_flags, fa=
iled_diff)
=20
     def failed():
         fn =3D '.stgit-failed.patch'
         f =3D file(fn, 'w')
-        f.write(patch_desc(stack.repository, cd, failed_diff,
-                           options.diff, options.diff_flags))
+        f.write(patch_desc(stack.repository, cd,
+                           options.diff, options.diff_flags, failed_di=
ff))
         f.close()
         out.error('Edited patch did not apply.',
                   'It has been saved to "%s".' % fn)
diff --git a/stgit/commands/imprt.py b/stgit/commands/imprt.py
index 5fb4da3..b958412 100644
--- a/stgit/commands/imprt.py
+++ b/stgit/commands/imprt.py
@@ -220,7 +220,7 @@ def __import_file(filename, options, patch =3D None=
):
                  parse_mail(msg)
     else:
         message, author_name, author_email, author_date, diff =3D \
-                 parse_patch(f.read())
+                 parse_patch(f.read(), contains_diff =3D True)
=20
     if filename:
         f.close()
diff --git a/stgit/lib/edit.py b/stgit/lib/edit.py
new file mode 100644
index 0000000..6874355
--- /dev/null
+++ b/stgit/lib/edit.py
@@ -0,0 +1,99 @@
+"""This module contains utility functions for patch editing."""
+
+from stgit import utils
+from stgit.commands import common
+from stgit.lib import git
+
+def update_patch_description(repo, cd, text, contains_diff):
+    """Update the given L{CommitData<stgit.lib.git.CommitData>} with t=
he
+    given text description, which may contain author name and time
+    stamp in addition to a new commit message. If C{contains_diff} is
+    true, it may also contain a replacement diff.
+
+    Return a pair: the new L{CommitData<stgit.lib.git.CommitData>};
+    and the diff text if it didn't apply, or C{None} otherwise."""
+    (message, authname, authemail, authdate, diff
+     ) =3D common.parse_patch(text, contains_diff)
+    a =3D cd.author
+    for val, setter in [(authname, 'set_name'), (authemail, 'set_email=
'),
+                        (git.Date.maybe(authdate), 'set_date')]:
+        if val !=3D None:
+            a =3D getattr(a, setter)(val)
+    cd =3D cd.set_message(message).set_author(a)
+    failed_diff =3D None
+    if diff:
+        tree =3D repo.apply(cd.parent.data.tree, diff)
+        if tree =3D=3D None:
+            failed_diff =3D diff
+        else:
+            cd =3D cd.set_tree(tree)
+    return cd, failed_diff
+
+def patch_desc(repo, cd, append_diff, diff_flags, replacement_diff):
+    """Return a description text for the patch, suitable for editing
+    and/or reimporting with L{update_patch_description()}.
+
+    @param cd: The L{CommitData<stgit.lib.git.CommitData>} to generate
+               a description of
+    @param append_diff: Whether to append the patch diff to the
+                        description
+    @type append_diff: C{bool}
+    @param diff_flags: Extra parameters to pass to C{git diff}
+    @param replacement_diff: Diff text to use; or C{None} if it should
+                             be computed from C{cd}
+    @type replacement_diff: C{str} or C{None}"""
+    desc =3D ['From: %s <%s>' % (cd.author.name, cd.author.email),
+            'Date: %s' % cd.author.date.isoformat(),
+            '',
+            cd.message]
+    if append_diff:
+        if replacement_diff:
+            diff =3D replacement_diff
+        else:
+            just_diff =3D repo.diff_tree(cd.parent.data.tree, cd.tree,=
 diff_flags)
+            diff =3D '\n'.join([git.diffstat(just_diff), just_diff])
+        desc +=3D ['---', '', diff]
+    return '\n'.join(desc)
+
+def interactive_edit_patch(repo, cd, edit_diff, diff_flags, replacemen=
t_diff):
+    """Edit the patch interactively. If C{edit_diff} is true, edit the
+    diff as well. If C{replacement_diff} is not C{None}, it contains a
+    diff to edit instead of the patch's real diff.
+
+    Return a pair: the new L{CommitData<stgit.lib.git.CommitData>};
+    and the diff text if it didn't apply, or C{None} otherwise."""
+    return update_patch_description(
+        repo, cd, utils.edit_string(
+            patch_desc(repo, cd, edit_diff, diff_flags, replacement_di=
ff),
+            '.stgit-edit.' + ['txt', 'patch'][bool(edit_diff)]),
+        edit_diff)
+
+def auto_edit_patch(repo, cd, msg, contains_diff, author, committer, s=
ign_str):
+    """Edit the patch noninteractively in a couple of ways:
+
+         - If C{msg} is not C{None}, parse it to find a replacement
+           message, and possibly also replacement author and
+           timestamp. If C{contains_diff} is true, also look for a
+           replacement diff.
+
+         - C{author} and C{committer} are two functions that take the
+           original L{Person<stgit.lib.git.Person>} value as argument,
+           and return the new one.
+
+         - C{sign_str}, if not C{None}, is a sign string to append to
+           the message.
+
+    Return a pair: the new L{CommitData<stgit.lib.git.CommitData>};
+    and the diff text if it didn't apply, or C{None} otherwise."""
+    if msg =3D=3D None:
+        failed_diff =3D None
+    else:
+        cd, failed_diff =3D update_patch_description(repo, cd, msg, co=
ntains_diff)
+    a, c =3D author(cd.author), committer(cd.committer)
+    if (a, c) !=3D (cd.author, cd.committer):
+        cd =3D cd.set_author(a).set_committer(c)
+    if sign_str !=3D None:
+        cd =3D cd.set_message(utils.add_sign_line(
+                cd.message, sign_str, git.Person.committer().name,
+                git.Person.committer().email))
+    return cd, failed_diff
