From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/2] Don't clean away patches with conflicts
Date: Tue, 29 Jan 2008 04:12:44 +0100
Message-ID: <20080129031118.1095.79802.stgit@yoghurt>
References: <20080129030752.1095.27968.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 04:13:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJguV-000606-Ms
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 04:13:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754906AbYA2DMs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jan 2008 22:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753588AbYA2DMs
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 22:12:48 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4638 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483AbYA2DMr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 22:12:47 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JJgtv-0000ci-00; Tue, 29 Jan 2008 03:12:43 +0000
In-Reply-To: <20080129030752.1095.27968.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71938>

If we have conflicts, it means that the topmost patch is empty because
of those conflicts (since StGit explicitly makes a conflicting patch
empty), so don't let "stg clean" touch it.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

I considered fixing this by way of a check in the shared
new-infrastructure code, but came to the conclusion that the check
really does belong in "stg clean".

 stgit/commands/clean.py |    7 +++++++
 stgit/lib/git.py        |    8 ++++++++
 t/t2500-clean.sh        |    2 +-
 3 files changed, 16 insertions(+), 1 deletions(-)


diff --git a/stgit/commands/clean.py b/stgit/commands/clean.py
index a0a0dca..889c1dc 100644
--- a/stgit/commands/clean.py
+++ b/stgit/commands/clean.py
@@ -40,6 +40,13 @@ def _clean(stack, clean_applied, clean_unapplied):
     trans =3D transaction.StackTransaction(stack, 'stg clean')
     def del_patch(pn):
         if pn in stack.patchorder.applied:
+            if pn =3D=3D stack.patchorder.applied[-1]:
+                # We're about to clean away the topmost patch. Don't
+                # do that if we have conflicts, since that means the
+                # patch is only empty because the conflicts have made
+                # us dump its contents into the index and worktree.
+                if stack.repository.default_index.conflicts():
+                    return False
             return clean_applied and trans.patches[pn].data.is_nochang=
e()
         elif pn in stack.patchorder.unapplied:
             return clean_unapplied and trans.patches[pn].data.is_nocha=
nge()
diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 2af1844..6cd7450 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -353,6 +353,14 @@ class Index(RunWithEnv):
     def delete(self):
         if os.path.isfile(self.__filename):
             os.remove(self.__filename)
+    def conflicts(self):
+        """The set of conflicting paths."""
+        paths =3D set()
+        for line in self.run(['git', 'ls-files', '-z', '--unmerged']
+                             ).raw_output().split('\0')[:-1]:
+            stat, path =3D line.split('\t', 1)
+            paths.add(path)
+        return paths
=20
 class Worktree(object):
     def __init__(self, directory):
diff --git a/t/t2500-clean.sh b/t/t2500-clean.sh
index b38d868..ad8f892 100755
--- a/t/t2500-clean.sh
+++ b/t/t2500-clean.sh
@@ -35,7 +35,7 @@ test_expect_success 'Create a conflict' '
     ! stg push
 '
=20
-test_expect_failure 'Make sure conflicting patches are preserved' '
+test_expect_success 'Make sure conflicting patches are preserved' '
     stg clean &&
     [ "$(echo $(stg applied))" =3D "p0 p2 p1" ] &&
     [ "$(echo $(stg unapplied))" =3D "" ]
