From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 5/6] Use the output from merge-recursive to list
	conflicts
Date: Sun, 26 Aug 2007 22:42:59 +0200
Message-ID: <20070826204259.16700.55770.stgit@yoghurt>
References: <20070826203745.16700.5655.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Sun Aug 26 22:43:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPOwy-0002Lo-UN
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 22:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbXHZUnG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 26 Aug 2007 16:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbXHZUnF
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 16:43:05 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2214 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbXHZUnE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 16:43:04 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IPOwm-00061d-00; Sun, 26 Aug 2007 21:43:00 +0100
In-Reply-To: <20070826203745.16700.5655.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56728>

=46rom: David K=C3=A5gedal <davidk@lysator.liu.se>

merge-recursive already has useful information about what the conflicts
were, so we reuse that when pushing.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/git.py   |   22 +++++++++++++++++-----
 stgit/stack.py |    2 ++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/stgit/git.py b/stgit/git.py
index 173cc4b..a185f19 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -39,6 +39,14 @@ class GitRunException(GitException):
 class GRun(Run):
     exc =3D GitRunException
=20
+class GitConflictException(GitException):
+    def __init__(self, conflicts):
+        GitException.__init__(self)
+        self.conflicts =3D conflicts
+    def __str__(self):
+        return "%d conflicts" % len(self.conflicts)
+    def list(self):
+        out.info(*self.conflicts)
=20
 #
 # Classes
@@ -642,11 +650,15 @@ def merge_recursive(base, head1, head2):
     """
     refresh_index()
=20
-    try:
-        # discard output to mask the verbose prints of the tool
-        GRun('git-merge-recursive', base, '--', head1, head2).discard_=
output()
-    except GitRunException:
-        raise GitException, 'GIT index merging failed (possible confli=
cts)'
+    p =3D GRun('git-merge-recursive', base, '--', head1, head2).return=
s([0, 1])
+    output =3D p.output_lines()
+    if p.exitcode =3D=3D 0:
+        # No problems
+        return
+    else: # exitcode =3D=3D 1
+        # There were conflicts
+        conflicts =3D [l for l in output if l.startswith('CONFLICT')]
+        raise GitConflictException(conflicts)
=20
 def merge(base, head1, head2):
     """Perform a 3-way merge between base, head1 and head2 into the
diff --git a/stgit/stack.py b/stgit/stack.py
index eb0114e..d2ca0e2 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -1075,6 +1075,8 @@ class Series(PatchSet):
                 # merge can fail but the patch needs to be pushed
                 try:
                     git.merge_recursive(bottom, head, top)
+                except git.GitConflictException, ex:
+                    ex.list()
                 except git.GitException, ex:
                     out.error('The merge failed during "push".',
                               'Use "refresh" after fixing the conflict=
s or'
