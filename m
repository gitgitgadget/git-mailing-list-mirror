From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/2] Teach "stg assimilate" to repair patch reachability
Date: Wed, 26 Sep 2007 04:15:08 +0200
Message-ID: <20070926021508.1202.35075.stgit@yoghurt>
References: <20070926020911.1202.2580.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 04:15:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaMRB-00054R-AS
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 04:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780AbXIZCPQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Sep 2007 22:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753795AbXIZCPQ
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 22:15:16 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2547 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917AbXIZCPN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 22:15:13 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IaMQf-0006ii-00; Wed, 26 Sep 2007 03:15:09 +0100
In-Reply-To: <20070926020911.1202.2580.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59210>

Rewrite "stg assimilate" so that it in addition to assimilating
commits made on top of the patch stack also will rewrite the
applied/unapplied files to reflect reality. A patch is considered to
be applied if it is reachable from HEAD without passing through a
merge, and unreachable otherwise.

Performance is adequate: On my laptop, it takes less than four seconds
to process the Linux tree (with hot caches).

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/assimilate.py |  190 ++++++++++++++++++++++++++++++++--=
--------
 stgit/commands/common.py     |    6 +
 stgit/stack.py               |    6 +
 t/t1301-assimilate.sh        |   12 +--
 4 files changed, 157 insertions(+), 57 deletions(-)


diff --git a/stgit/commands/assimilate.py b/stgit/commands/assimilate.p=
y
index c5f4340..ab2264a 100644
--- a/stgit/commands/assimilate.py
+++ b/stgit/commands/assimilate.py
@@ -23,21 +23,80 @@ from optparse import OptionParser, make_option
 from stgit.commands.common import *
 from stgit.utils import *
 from stgit.out import *
+from stgit.run import *
 from stgit import stack, git
=20
-help =3D 'StGIT-ify any GIT commits made on top of your StGIT stack'
+help =3D 'StGit-ify any git commits made on top of your StGit stack'
 usage =3D """%prog [options]
=20
-If you have made GIT commits on top of your stack of StGIT patches,
-many StGIT commands will refuse to work. This command converts any
-such commits to StGIT patches, preserving their contents.
+"assimilate" will repair three kinds of inconsistencies in your StGit
+stack, all of them caused by using plain git commands on the branch:
=20
-Only GIT commits with exactly one parent can be assimilated; in other
-words, if you have committed a merge on top of your stack, this
-command cannot help you."""
+  1. If you have made regular git commits on top of your stack of
+     StGit patches, "assimilate" converts them to StGit patches,
+     preserving their contents.
+
+  2. Merge commits cannot become patches; if you have committed a
+     merge on top of your stack, "assimilate" will simply mark all
+     patches below the merge unapplied, since they are no longer
+     reachable. If this is not what you want, use "git reset" to get
+     rid of the merge and run "assimilate" again.
+
+  3. The applied patches are supposed to be precisely those that are
+     reachable from the branch head. If you have used e.g. "git reset"
+     to move the head, some applied patches may no longer be
+     reachable, and some unapplied patches may have become reachable.
+     "assimilate" will correct the appliedness of such patches.
+
+Note that these are "inconsistencies", not "errors"; furthermore,
+"assimilate" will repair them reliably. As long as you are satisfied
+with the way "assimilate" handles them, you have no reason to avoid
+causing them in the first place if that is convenient for you."""
=20
 options =3D []
=20
+class Commit(object):
+    def __init__(self, id):
+        self.id =3D id
+        self.parents =3D set()
+        self.children =3D set()
+        self.patch =3D None
+        self.__commit =3D None
+    def __get_commit(self):
+        if not self.__commit:
+            self.__commit =3D git.get_commit(self.id)
+        return self.__commit
+    commit =3D property(__get_commit)
+    def __str__(self):
+        if self.patch:
+            return '%s (%s)' % (self.id, self.patch)
+        else:
+            return self.id
+    def __repr__(self):
+        return '<%s>' % str(self)
+
+def read_commit_dag(branch):
+    out.start('Reading commit DAG')
+    commits =3D {}
+    patches =3D set()
+    for line in Run('git-rev-list', '--parents', '--all').output_lines=
():
+        cs =3D line.split()
+        for id in cs:
+            if not id in commits:
+                commits[id] =3D Commit(id)
+        for id in cs[1:]:
+            commits[cs[0]].parents.add(commits[id])
+            commits[id].children.add(commits[cs[0]])
+    for line in Run('git-show-ref').output_lines():
+        id, ref =3D line.split()
+        m =3D re.match(r'^refs/patches/%s/(.+)$' % branch, ref)
+        if m:
+            c =3D commits[id]
+            c.patch =3D m.group(1)
+            patches.add(c)
+    out.done()
+    return commits, patches
+
 def func(parser, options, args):
     """Assimilate a number of patches.
     """
@@ -45,49 +104,86 @@ def func(parser, options, args):
     def nothing_to_do():
         out.info('No commits to assimilate')
=20
-    top_patch =3D crt_series.get_current_patch()
-    if not top_patch:
-        return nothing_to_do()
+    orig_applied =3D crt_series.get_applied()
+    orig_unapplied =3D crt_series.get_unapplied()
=20
-    victims =3D []
-    victim =3D git.get_commit(git.get_head())
-    while victim.get_id_hash() !=3D top_patch.get_top():
-        victims.append(victim)
-        parents =3D victim.get_parents()
-        if not parents:
-            raise CmdException, 'Commit %s has no parents, aborting' %=
 victim
-        elif len(parents) > 1:
-            raise CmdException, 'Commit %s is a merge, aborting' % vic=
tim
-        victim =3D git.get_commit(parents[0])
-
-    if not victims:
+    # If head =3D=3D top, we're done.
+    head =3D git.get_commit(git.get_head()).get_id_hash()
+    top =3D crt_series.get_current_patch()
+    if top and head =3D=3D top.get_top():
         return nothing_to_do()
=20
     if crt_series.get_protected():
         raise CmdException(
-            'This branch is protected. Modification is not permitted')
-
-    patch2name =3D {}
-    name2patch =3D {}
-
+            'This branch is protected. Modification is not permitted.'=
)
+
+    # Find commits to assimilate, and applied patches.
+    commits, patches =3D read_commit_dag(crt_series.get_name())
+    c =3D commits[head]
+    patchify =3D []
+    applied =3D []
+    while len(c.parents) =3D=3D 1:
+        parent, =3D c.parents
+        if c.patch:
+            applied.append(c)
+        elif not applied:
+            patchify.append(c)
+        c =3D parent
+    applied.reverse()
+    patchify.reverse()
+
+    # Find patches hidden behind a merge.
+    merge =3D c
+    todo =3D set([c])
+    seen =3D set()
+    hidden =3D set()
+    while todo:
+        c =3D todo.pop()
+        seen.add(c)
+        todo |=3D c.parents - seen
+        if c.patch:
+            hidden.add(c)
+    if hidden:
+        out.warn(('%d patch%s are hidden below the merge commit'
+                  % (len(hidden), ['es', ''][len(hidden) =3D=3D 1])),
+                 '%s,' % merge.id, 'and will be considered unapplied.'=
)
+
+    # Assimilate any linear sequence of commits on top of a patch.
+    names =3D set(p.patch for p in patches)
     def name_taken(name):
-        return name in name2patch or crt_series.patch_exists(name)
-
-    for victim in victims:
-        patchname =3D make_patch_name(victim.get_log(), name_taken)
-        patch2name[victim] =3D patchname
-        name2patch[patchname] =3D victim
-
-    victims.reverse()
-    for victim in victims:
-        out.info('Creating patch "%s" from commit %s'
-                 % (patch2name[victim], victim))
-        aname, amail, adate =3D name_email_date(victim.get_author())
-        cname, cmail, cdate =3D name_email_date(victim.get_committer()=
)
-        crt_series.new_patch(
-            patch2name[victim],
-            can_edit =3D False, before_existing =3D False, commit =3D =
=46alse,
-            top =3D victim.get_id_hash(), bottom =3D victim.get_parent=
(),
-            message =3D victim.get_log(),
-            author_name =3D aname, author_email =3D amail, author_date=
 =3D adate,
-            committer_name =3D cname, committer_email =3D cmail)
+        return name in names
+    if applied and patchify:
+        out.start('Creating %d new patch%s'
+                  % (len(patchify), ['es', ''][len(patchify) =3D=3D 1]=
))
+        for p in patchify:
+            name =3D make_patch_name(p.commit.get_log(), name_taken)
+            out.info('Creating patch %s from commit %s' % (name, p.id)=
)
+            aname, amail, adate =3D name_email_date(p.commit.get_autho=
r())
+            cname, cmail, cdate =3D name_email_date(p.commit.get_commi=
tter())
+            parent, =3D p.parents
+            crt_series.new_patch(
+                name, can_edit =3D False, commit =3D False,
+                top =3D p.id, bottom =3D parent.id, message =3D p.comm=
it.get_log(),
+                author_name =3D aname, author_email =3D amail, author_=
date =3D adate,
+                committer_name =3D cname, committer_email =3D cmail)
+            p.patch =3D name
+            applied.append(p)
+            names.add(name)
+        out.done()
+
+    # Write the applied/unapplied files.
+    out.start('Checking patch appliedness')
+    applied_name_set =3D set(p.patch for p in applied)
+    unapplied_names =3D []
+    for name in orig_applied:
+        if not name in applied_name_set:
+            out.info('%s is now unapplied' % name)
+            unapplied_names.append(name)
+    for name in orig_unapplied:
+        if name in applied_name_set:
+            out.info('%s is now applied' % name)
+        else:
+            unapplied_names.append(name)
+    crt_series.set_applied(p.patch for p in applied)
+    crt_series.set_unapplied(unapplied_names)
+    out.done()
diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 8ed47ca..79576fa 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -114,9 +114,9 @@ def check_local_changes():
 def check_head_top_equal():
     if not crt_series.head_top_equal():
         raise CmdException(
-            'HEAD and top are not the same. You probably committed\n'
-            '  changes to the tree outside of StGIT. To bring them\n'
-            '  into StGIT, use the "assimilate" command')
+"""HEAD and top are not the same. This can happen if you
+   modify a branch with git. The "assimilate" command can
+   fix this situation.""")
=20
 def check_conflicts():
     if os.path.exists(os.path.join(basedir.get(), 'conflicts')):
diff --git a/stgit/stack.py b/stgit/stack.py
index bd08b35..d889f37 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -509,11 +509,17 @@ class Series(PatchSet):
             raise StackException, 'Branch "%s" not initialised' % self=
=2Eget_name()
         return read_strings(self.__applied_file)
=20
+    def set_applied(self, applied):
+        write_strings(self.__applied_file, applied)
+
     def get_unapplied(self):
         if not os.path.isfile(self.__unapplied_file):
             raise StackException, 'Branch "%s" not initialised' % self=
=2Eget_name()
         return read_strings(self.__unapplied_file)
=20
+    def set_unapplied(self, unapplied):
+        write_strings(self.__unapplied_file, unapplied)
+
     def get_hidden(self):
         if not os.path.isfile(self.__hidden_file):
             return []
diff --git a/t/t1301-assimilate.sh b/t/t1301-assimilate.sh
index 906f5bb..7f47c31 100755
--- a/t/t1301-assimilate.sh
+++ b/t/t1301-assimilate.sh
@@ -5,7 +5,7 @@ test_description=3D'Test the assimilate command.'
=20
 test_expect_success \
     'Assimilate in a non-initialized repository' \
-    'stg assimilate'
+    '! stg assimilate'
=20
 test_expect_success \
     'Initialize the StGIT repository' \
@@ -75,12 +75,10 @@ test_expect_success \
     git pull . br
     '
=20
-test_expect_success \
-    'Try (and fail) to assimilate the merge commit' \
-    '
+test_expect_success 'Assimilate in the presence of a merge commit' '
     [ $(stg applied | wc -l) -eq 5 ] &&
-    ! stg assimilate &&
-    [ $(stg applied | wc -l) -eq 5 ]
-    '
+    stg assimilate &&
+    [ $(stg applied | wc -l) -eq 0 ]
+'
=20
 test_done
