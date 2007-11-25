From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 10/10] Convert "stg uncommit" to the new infrastructure
Date: Sun, 25 Nov 2007 21:51:58 +0100
Message-ID: <20071125205158.7823.37687.stgit@yoghurt>
References: <20071125203717.7823.70046.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 21:52:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwOSy-0003t1-LD
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 21:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756739AbXKYUwG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Nov 2007 15:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756737AbXKYUwE
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 15:52:04 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3590 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756689AbXKYUwD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 15:52:03 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IwOSN-0007cX-00; Sun, 25 Nov 2007 20:51:59 +0000
In-Reply-To: <20071125203717.7823.70046.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66003>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/uncommit.py |   79 +++++++++++++++++++-----------------=
--------
 1 files changed, 34 insertions(+), 45 deletions(-)


diff --git a/stgit/commands/uncommit.py b/stgit/commands/uncommit.py
index ba3448f..8422952 100644
--- a/stgit/commands/uncommit.py
+++ b/stgit/commands/uncommit.py
@@ -17,13 +17,11 @@ along with this program; if not, write to the Free =
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
+from optparse import make_option
+from stgit.commands import common
+from stgit.lib import transaction
 from stgit.out import *
-from stgit import stack, git
+from stgit import utils
=20
 help =3D 'turn regular GIT commits into StGIT patches'
 usage =3D """%prog [<patchnames>] | -n NUM [<prefix>]] | -t <committis=
h> [-x]
@@ -48,7 +46,7 @@ given commit should be uncommitted.
 Only commits with exactly one parent can be uncommitted; in other
 words, you can't uncommit a merge."""
=20
-directory =3D DirectoryGotoToplevel()
+directory =3D common.DirectoryHasRepositoryLib()
 options =3D [make_option('-n', '--number', type =3D 'int',
                        help =3D 'uncommit the specified number of comm=
its'),
            make_option('-t', '--to',
@@ -60,19 +58,18 @@ options =3D [make_option('-n', '--number', type =3D=
 'int',
 def func(parser, options, args):
     """Uncommit a number of patches.
     """
+    stack =3D directory.repository.current_stack
     if options.to:
         if options.number:
             parser.error('cannot give both --to and --number')
         if len(args) !=3D 0:
             parser.error('cannot specify patch name with --to')
         patch_nr =3D patchnames =3D None
-        to_commit =3D git_id(crt_series, options.to)
+        to_commit =3D stack.repository.rev_parse(options.to)
     elif options.number:
         if options.number <=3D 0:
             parser.error('invalid value passed to --number')
-
         patch_nr =3D options.number
-
         if len(args) =3D=3D 0:
             patchnames =3D None
         elif len(args) =3D=3D 1:
@@ -88,53 +85,45 @@ def func(parser, options, args):
         patchnames =3D args
         patch_nr =3D len(patchnames)
=20
-    if crt_series.get_protected():
-        raise CmdException, \
-              'This branch is protected. Uncommit is not permitted'
-
-    def get_commit(commit_id):
-        commit =3D git.Commit(commit_id)
-        try:
-            parent, =3D commit.get_parents()
-        except ValueError:
-            raise CmdException('Commit %s does not have exactly one pa=
rent'
-                               % commit_id)
-        return (commit, commit_id, parent)
-
     commits =3D []
-    next_commit =3D crt_series.get_base()
+    next_commit =3D stack.base
     if patch_nr:
         out.start('Uncommitting %d patches' % patch_nr)
         for i in xrange(patch_nr):
-            commit, commit_id, parent =3D get_commit(next_commit)
-            commits.append((commit, commit_id, parent))
-            next_commit =3D parent
+            commits.append(next_commit)
+            next_commit =3D next_commit.data.parent
     else:
         if options.exclusive:
             out.start('Uncommitting to %s (exclusive)' % to_commit)
         else:
             out.start('Uncommitting to %s' % to_commit)
         while True:
-            commit, commit_id, parent =3D get_commit(next_commit)
-            if commit_id =3D=3D to_commit:
+            if next_commit =3D=3D to_commit:
                 if not options.exclusive:
-                    commits.append((commit, commit_id, parent))
+                    commits.append(next_commit)
                 break
-            commits.append((commit, commit_id, parent))
-            next_commit =3D parent
+            commits.append(next_commit)
+            next_commit =3D next_commit.data.parent
         patch_nr =3D len(commits)
=20
-    for (commit, commit_id, parent), patchname in \
-        zip(commits, patchnames or [None for i in xrange(len(commits))=
]):
-        author_name, author_email, author_date =3D \
-                     name_email_date(commit.get_author())
-        crt_series.new_patch(patchname,
-                             can_edit =3D False, before_existing =3D T=
rue,
-                             commit =3D False,
-                             top =3D commit_id, bottom =3D parent,
-                             message =3D commit.get_log(),
-                             author_name =3D author_name,
-                             author_email =3D author_email,
-                             author_date =3D author_date)
-
+    taken_names =3D set(stack.patchorder.applied + stack.patchorder.un=
applied)
+    if patchnames:
+        for pn in patchnames:
+            if pn in taken_names:
+                raise common.CmdException('Patch name "%s" already tak=
en' % pn)
+            taken_names.add(pn)
+    else:
+        patchnames =3D []
+        for c in reversed(commits):
+            pn =3D utils.make_patch_name(c.data.message,
+                                       lambda pn: pn in taken_names)
+            patchnames.append(pn)
+            taken_names.add(pn)
+        patchnames.reverse()
+
+    trans =3D transaction.StackTransaction(stack, 'stg uncommit')
+    for commit, pn in zip(commits, patchnames):
+        trans.patches[pn] =3D commit
+    trans.applied =3D list(reversed(patchnames)) + trans.applied
+    trans.run()
     out.done()
