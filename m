From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 02/10] Write metadata files used by the old
	infrastructure
Date: Sun, 25 Nov 2007 21:51:06 +0100
Message-ID: <20071125205105.7823.50417.stgit@yoghurt>
References: <20071125203717.7823.70046.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 21:52:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwOSN-0003hQ-2p
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 21:51:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756594AbXKYUvM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Nov 2007 15:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756462AbXKYUvM
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 15:51:12 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4109 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756587AbXKYUvK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 15:51:10 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IwORX-0007ZM-00; Sun, 25 Nov 2007 20:51:07 +0000
In-Reply-To: <20071125203717.7823.70046.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65996>

The new infrastructure doesn't use them, but they're needed to support
the old infrastructure during the transition when both of them are in
use.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/lib/stack.py |   52 ++++++++++++++++++++++++++++++++++++++++++++=
+++++---
 1 files changed, 49 insertions(+), 3 deletions(-)


diff --git a/stgit/lib/stack.py b/stgit/lib/stack.py
index d5bd488..5a34592 100644
--- a/stgit/lib/stack.py
+++ b/stgit/lib/stack.py
@@ -7,15 +7,61 @@ class Patch(object):
         self.__stack =3D stack
         self.__name =3D name
     name =3D property(lambda self: self.__name)
+    @property
     def __ref(self):
         return 'refs/patches/%s/%s' % (self.__stack.name, self.__name)
     @property
+    def __log_ref(self):
+        return self.__ref + '.log'
+    @property
     def commit(self):
-        return self.__stack.repository.refs.get(self.__ref())
+        return self.__stack.repository.refs.get(self.__ref)
+    @property
+    def __compat_dir(self):
+        return os.path.join(self.__stack.directory, 'patches', self.__=
name)
+    def __write_compat_files(self, new_commit, msg):
+        """Write files used by the old infrastructure."""
+        def write(name, val, multiline =3D False):
+            fn =3D os.path.join(self.__compat_dir, name)
+            if val:
+                utils.write_string(fn, val, multiline)
+            elif os.path.isfile(fn):
+                os.remove(fn)
+        def write_patchlog():
+            try:
+                old_log =3D [self.__stack.repository.refs.get(self.__l=
og_ref)]
+            except KeyError:
+                old_log =3D []
+            cd =3D git.Commitdata(tree =3D new_commit.data.tree, paren=
ts =3D old_log,
+                                message =3D '%s\t%s' % (msg, new_commi=
t.sha1))
+            c =3D self.__stack.repository.commit(cd)
+            self.__stack.repository.refs.set(self.__log_ref, c, msg)
+            return c
+        d =3D new_commit.data
+        write('authname', d.author.name)
+        write('authemail', d.author.email)
+        write('authdate', d.author.date)
+        write('commname', d.committer.name)
+        write('commemail', d.committer.email)
+        write('description', d.message)
+        write('log', write_patchlog().sha1)
+        try:
+            old_commit_sha1 =3D self.commit
+        except KeyError:
+            old_commit_sha1 =3D None
+        write('top.old', old_commit_sha1)
+    def __delete_compat_files(self):
+        if os.path.isdir(self.__compat_dir):
+            for f in os.listdir(self.__compat_dir):
+                os.remove(os.path.join(self.__compat_dir, f))
+            os.rmdir(self.__compat_dir)
+        self.__stack.repository.refs.delete(self.__log_ref)
     def set_commit(self, commit, msg):
-        self.__stack.repository.refs.set(self.__ref(), commit, msg)
+        self.__write_compat_files(commit, msg)
+        self.__stack.repository.refs.set(self.__ref, commit, msg)
     def delete(self):
-        self.__stack.repository.refs.delete(self.__ref())
+        self.__delete_compat_files()
+        self.__stack.repository.refs.delete(self.__ref)
     def is_applied(self):
         return self.name in self.__stack.patchorder.applied
     def is_empty(self):
