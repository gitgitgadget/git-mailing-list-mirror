From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/5] Write metadata files used by the old infrastructure
Date: Mon, 05 Nov 2007 04:14:42 +0100
Message-ID: <20071105031442.6108.19781.stgit@yoghurt>
References: <20071105030847.6108.44653.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 04:15:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IosQo-0002iZ-Hw
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 04:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712AbXKEDOr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Nov 2007 22:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753679AbXKEDOr
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 22:14:47 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2133 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652AbXKEDOq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 22:14:46 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IosQD-0003GI-00; Mon, 05 Nov 2007 03:14:41 +0000
In-Reply-To: <20071105030847.6108.44653.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63474>

The new infrastructure doesn't use them, but they're needed to support
the old infrastructure during the transition when both of them are in
use.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/lib/stack.py |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)


diff --git a/stgit/lib/stack.py b/stgit/lib/stack.py
index b4d99ba..ce514d6 100644
--- a/stgit/lib/stack.py
+++ b/stgit/lib/stack.py
@@ -9,10 +9,45 @@ class Patch(object):
     name =3D property(lambda self: self.__name)
     def __ref(self):
         return 'refs/patches/%s/%s' % (self.__stack.name, self.__name)
+    def __log_ref(self):
+        return self.__ref() + '.log'
     @property
     def commit(self):
         return self.__stack.repository.refs.get(self.__ref())
+    def __write_compat_files(self, new_commit, msg):
+        """Write files used by the old infrastructure."""
+        fdir =3D os.path.join(self.__stack.directory, 'patches', self.=
__name)
+        def write(name, val, multiline =3D False):
+            fn =3D os.path.join(fdir, name)
+            if val:
+                utils.write_string(fn, val, multiline)
+            elif os.path.isfile(fn):
+                os.remove(fn)
+        def write_patchlog():
+            try:
+                old_log =3D [self.__stack.repository.refs.get(self.__l=
og_ref())]
+            except KeyError:
+                old_log =3D []
+            cd =3D git.Commitdata(tree =3D new_commit.data.tree, paren=
ts =3D old_log,
+                                message =3D '%s\t%s' % (msg, new_commi=
t.sha1))
+            c =3D self.__stack.repository.commit(cd)
+            self.__stack.repository.refs.set(self.__log_ref(), c, msg)
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
     def set_commit(self, commit, msg):
+        self.__write_compat_files(commit, msg)
         self.__stack.repository.refs.set(self.__ref(), commit, msg)
     def delete(self):
         self.__stack.repository.refs.delete(self.__ref())
