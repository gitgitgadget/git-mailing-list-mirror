From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 1/6] Split git.merge into two functions
Date: Sun, 26 Aug 2007 22:42:37 +0200
Message-ID: <20070826204237.16700.21445.stgit@yoghurt>
References: <20070826203745.16700.5655.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Sun Aug 26 22:42:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPOwg-0002EK-JW
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 22:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbXHZUmv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 26 Aug 2007 16:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbXHZUmu
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 16:42:50 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2205 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbXHZUmt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 16:42:49 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IPOwP-00060S-00; Sun, 26 Aug 2007 21:42:38 +0100
In-Reply-To: <20070826203745.16700.5655.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56725>

=46rom: David K=C3=A5gedal <davidk@lysator.liu.se>

This only prepares for later simplifications.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/pick.py |    2 +
 stgit/git.py           |   92 +++++++++++++++++++++++++++++++++++++---=
--------
 stgit/stack.py         |    2 +
 3 files changed, 73 insertions(+), 23 deletions(-)

diff --git a/stgit/commands/pick.py b/stgit/commands/pick.py
index 1c3ef11..871879c 100644
--- a/stgit/commands/pick.py
+++ b/stgit/commands/pick.py
@@ -99,7 +99,7 @@ def func(parser, options, args):
=20
         # try a direct git-apply first
         if not git.apply_diff(bottom, top):
-            git.merge(bottom, git.get_head(), top, recursive =3D True)
+            git.merge_recursive(bottom, git.get_head(), top)
=20
         out.done()
     elif options.update:
diff --git a/stgit/git.py b/stgit/git.py
index 7962cdb..87551ee 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -634,36 +634,86 @@ def apply_diff(rev1, rev2, check_index =3D True, =
files =3D None):
=20
     return True
=20
-def merge(base, head1, head2, recursive =3D False):
+stages_re =3D re.compile('^([0-7]+) ([0-9a-f]{40}) ([1-3])\t(.*)$', re=
=2ES)
+
+def merge_recursive(base, head1, head2):
     """Perform a 3-way merge between base, head1 and head2 into the
     local tree
     """
     refresh_index()
=20
     err_output =3D None
-    if recursive:
-        # this operation tracks renames but it is slower (used in
-        # general when pushing or picking patches)
-        try:
-            # discard output to mask the verbose prints of the tool
-            GRun('git-merge-recursive', base, '--', head1, head2
-                 ).discard_output()
-        except GitRunException, ex:
-            err_output =3D str(ex)
-            pass
-    else:
-        # the fast case where we don't track renames (used when the
-        # distance between base and heads is small, i.e. folding or
-        # synchronising patches)
-        try:
-            GRun('git-read-tree', '-u', '-m', '--aggressive',
-                 base, head1, head2).run()
-        except GitRunException:
-            raise GitException, 'git-read-tree failed (local changes m=
aybe?)'
+    # this operation tracks renames but it is slower (used in
+    # general when pushing or picking patches)
+    try:
+        # discard output to mask the verbose prints of the tool
+        GRun('git-merge-recursive', base, '--', head1, head2).discard_=
output()
+    except GitRunException, ex:
+        err_output =3D str(ex)
+        pass
+
+    # check the index for unmerged entries
+    files =3D {}
+
+    for line in GRun('git-ls-files', '--unmerged', '--stage', '-z'
+                     ).raw_output().split('\0'):
+        if not line:
+            continue
+
+        mode, hash, stage, path =3D stages_re.findall(line)[0]
+
+        if not path in files:
+            files[path] =3D {}
+            files[path]['1'] =3D ('', '')
+            files[path]['2'] =3D ('', '')
+            files[path]['3'] =3D ('', '')
+
+        files[path][stage] =3D (mode, hash)
+
+    if err_output and not files:
+        # if no unmerged files, there was probably a different type of
+        # error and we have to abort the merge
+        raise GitException, err_output
+
+    # merge the unmerged files
+    errors =3D False
+    for path in files:
+        # remove additional files that might be generated for some
+        # newer versions of GIT
+        for suffix in [base, head1, head2]:
+            if not suffix:
+                continue
+            fname =3D path + '~' + suffix
+            if os.path.exists(fname):
+                os.remove(fname)
+
+        stages =3D files[path]
+        if gitmergeonefile.merge(stages['1'][1], stages['2'][1],
+                                 stages['3'][1], path, stages['1'][0],
+                                 stages['2'][0], stages['3'][0]) !=3D =
0:
+            errors =3D True
+
+    if errors:
+        raise GitException, 'GIT index merging failed (possible confli=
cts)'
+
+def merge(base, head1, head2):
+    """Perform a 3-way merge between base, head1 and head2 into the
+    local tree
+    """
+    refresh_index()
+
+    err_output =3D None
+    # the fast case where we don't track renames (used when the
+    # distance between base and heads is small, i.e. folding or
+    # synchronising patches)
+    try:
+        GRun('git-read-tree', '-u', '-m', '--aggressive', base, head1,=
 head2
+             ).run()
+    except GitRunException:
+        raise GitException, 'git-read-tree failed (local changes maybe=
?)'
=20
     # check the index for unmerged entries
     files =3D {}
-    stages_re =3D re.compile('^([0-7]+) ([0-9a-f]{40}) ([1-3])\t(.*)$'=
, re.S)
=20
     for line in GRun('git-ls-files', '--unmerged', '--stage', '-z'
                      ).raw_output().split('\0'):
diff --git a/stgit/stack.py b/stgit/stack.py
index 12c5091..a82392f 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -1066,7 +1066,7 @@ class Series(PatchSet):
=20
                 # merge can fail but the patch needs to be pushed
                 try:
-                    git.merge(bottom, head, top, recursive =3D True)
+                    git.merge_recursive(bottom, head, top)
                 except git.GitException, ex:
                     out.error('The merge failed during "push".',
                               'Use "refresh" after fixing the conflict=
s or'
