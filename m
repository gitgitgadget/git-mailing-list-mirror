From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 6/6] Handle failed pushes differently depending on cause
Date: Thu, 20 Mar 2008 01:32:02 +0100
Message-ID: <20080320003202.13102.54792.stgit@yoghurt>
References: <20080320002604.13102.53757.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Sandberg <mandolaerik@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 01:32:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc8iF-0006sd-1f
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 01:32:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163279AbYCTAcR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Mar 2008 20:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935593AbYCTAcN
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 20:32:13 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2865 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757796AbYCTAcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 20:32:09 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1Jc8hO-0004t1-00; Thu, 20 Mar 2008 00:32:02 +0000
In-Reply-To: <20080320002604.13102.53757.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77600>

Specifically, if the push failed because of a merge conflict, the
patch should be applied but empty; and if it fails for any other
reason (such as a too-dirty worktree), the patch should not be
applied.

This fixes the data loss bug tested for by t3000.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/lib/git.py         |   21 ++++++++++++++-------
 stgit/lib/transaction.py |    4 +++-
 t/t3000-dirty-merge.sh   |    2 +-
 3 files changed, 18 insertions(+), 9 deletions(-)


diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index cdfe885..35b9bbf 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -433,6 +433,9 @@ class Repository(RunWithEnv):
 class MergeException(exception.StgException):
     pass
=20
+class MergeConflictException(MergeException):
+    pass
+
 class Index(RunWithEnv):
     def __init__(self, repository, filename):
         self.__repository =3D repository
@@ -517,14 +520,18 @@ class IndexAndWorktree(RunWithEnv):
         assert isinstance(ours, Tree)
         assert isinstance(theirs, Tree)
         try:
-            self.run(['git', 'merge-recursive', base.sha1, '--', ours.=
sha1,
-                      theirs.sha1],
-                     env =3D { 'GITHEAD_%s' % base.sha1: 'ancestor',
-                             'GITHEAD_%s' % ours.sha1: 'current',
-                             'GITHEAD_%s' % theirs.sha1: 'patched'}
-                     ).cwd(self.__worktree.directory).discard_output()
+            r =3D self.run(['git', 'merge-recursive', base.sha1, '--',=
 ours.sha1,
+                          theirs.sha1],
+                         env =3D { 'GITHEAD_%s' % base.sha1: 'ancestor=
',
+                                 'GITHEAD_%s' % ours.sha1: 'current',
+                                 'GITHEAD_%s' % theirs.sha1: 'patched'=
}
+                         ).cwd(self.__worktree.directory)
+            r.discard_output()
         except run.RunException, e:
-            raise MergeException('Index/worktree dirty')
+            if r.exitcode =3D=3D 1:
+                raise MergeConflictException()
+            else:
+                raise MergeException('Index/worktree dirty')
     def changed_files(self):
         return self.run(['git', 'diff-files', '--name-only']).output_l=
ines()
     def update_index(self, files):
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 3613b15..2946a67 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -197,10 +197,12 @@ class StackTransaction(object):
                 tree =3D iw.index.write_tree()
                 self.__current_tree =3D tree
                 s =3D ' (modified)'
-            except git.MergeException:
+            except git.MergeConflictException:
                 tree =3D ours
                 merge_conflict =3D True
                 s =3D ' (conflict)'
+            except git.MergeException, e:
+                self.__halt(str(e))
         cd =3D cd.set_tree(tree)
         self.patches[pn] =3D self.__stack.repository.commit(cd)
         del self.unapplied[self.unapplied.index(pn)]
diff --git a/t/t3000-dirty-merge.sh b/t/t3000-dirty-merge.sh
index dd81c9e..d87bba1 100755
--- a/t/t3000-dirty-merge.sh
+++ b/t/t3000-dirty-merge.sh
@@ -22,7 +22,7 @@ test_expect_success 'Pop one patch and update the oth=
er' '
     stg refresh
 '
=20
-test_expect_failure 'Push with dirty worktree' '
+test_expect_success 'Push with dirty worktree' '
     echo 4 > a &&
     [ "$(echo $(stg applied))" =3D "p1" ] &&
     [ "$(echo $(stg unapplied))" =3D "p2" ] &&
