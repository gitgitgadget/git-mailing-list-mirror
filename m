From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 08/10] Log conflicts separately for all commands
Date: Mon, 21 Apr 2008 00:11:07 +0200
Message-ID: <20080420221107.5837.46522.stgit@yoghurt>
References: <20080420215625.5837.82896.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 00:12:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnhlZ-000853-J3
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 00:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbYDTWLM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Apr 2008 18:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752529AbYDTWLL
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 18:11:11 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3200 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434AbYDTWLK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 18:11:10 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JnhkX-00083F-00; Sun, 20 Apr 2008 23:11:05 +0100
In-Reply-To: <20080420215625.5837.82896.stgit@yoghurt>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79997>

This takes care of the old-infrastructure commands as well. They'll
all be converted to the new infrastructure eventually, but until then
this patch is necessary to make all the commands behave consistently.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/lib/log.py   |   29 ++++++++++++++++++++++++++++-
 stgit/lib/stack.py |    7 +++++++
 2 files changed, 35 insertions(+), 1 deletions(-)


diff --git a/stgit/lib/log.py b/stgit/lib/log.py
index fac050f..9904941 100644
--- a/stgit/lib/log.py
+++ b/stgit/lib/log.py
@@ -58,10 +58,37 @@ def log_entry(stack, msg):
                                   + [ll.full_log for ll in last_log]))=
)
     stack.repository.refs.set(ref, full_log, msg)
=20
+class Fakestack(object):
+    """Imitates a real Stack, but with the topmost patch popped."""
+    def __init__(self, stack):
+        appl =3D list(stack.patchorder.applied)
+        unappl =3D list(stack.patchorder.unapplied)
+        class patchorder(object):
+            applied =3D appl[:-1]
+            unapplied =3D [appl[-1]] + unappl
+            all =3D appl + unappl
+        self.patchorder =3D patchorder
+        class patches(object):
+            @staticmethod
+            def get(pn):
+                if pn =3D=3D appl[-1]:
+                    class patch(object):
+                        commit =3D stack.patches.get(pn).old_commit
+                    return patch
+                else:
+                    return stack.patches.get(pn)
+        self.patches =3D patches
+        self.head =3D stack.head.data.parent
+        self.name =3D stack.name
+        self.repository =3D stack.repository
 def compat_log_entry(msg):
     repo =3D default_repo()
     stack =3D repo.get_stack(repo.current_branch)
-    log_entry(stack, msg)
+    if repo.default_index.conflicts():
+        log_entry(Fakestack(stack), msg)
+        log_entry(stack, msg + ' (CONFLICT)')
+    else:
+        log_entry(stack, msg)
=20
 class Log(object):
     """Read a log entry."""
diff --git a/stgit/lib/stack.py b/stgit/lib/stack.py
index af1c994..95b817f 100644
--- a/stgit/lib/stack.py
+++ b/stgit/lib/stack.py
@@ -17,6 +17,13 @@ class Patch(object):
     def commit(self):
         return self.__stack.repository.refs.get(self.__ref)
     @property
+    def old_commit(self):
+        """Return the previous commit for this patch."""
+        fn =3D os.path.join(self.__compat_dir, 'top.old')
+        if not os.path.isfile(fn):
+            return None
+        return self.__stack.repository.get_commit(utils.read_string(fn=
))
+    @property
     def __compat_dir(self):
         return os.path.join(self.__stack.directory, 'patches', self.__=
name)
     def __write_compat_files(self, new_commit, msg):
