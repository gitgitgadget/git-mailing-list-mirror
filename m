From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Try the built-in version string before git-describe
Date: Tue, 20 May 2008 23:39:43 +0200
Message-ID: <20080520213844.13410.32757.stgit@yoghurt>
References: <20080520210249.GA19465@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 23:41:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyZZb-0006sV-QM
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 23:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760939AbYETVjx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 May 2008 17:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760857AbYETVjw
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 17:39:52 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3726 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757492AbYETVjv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 17:39:51 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JyZYe-0005HR-00; Tue, 20 May 2008 22:39:44 +0100
In-Reply-To: <20080520210249.GA19465@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.14.2.157.g9114
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82506>

Try to get the built-in version string first, and fall back to git
describe if there is no built-in string, instead of the other way
around. This makes computing the version string much cheaper in the
common case (whenever StGit is not run directly from a git-controlled
tree).

In order for this to work when StGit _is_ run directly from a
git-controlled tree, setup.py has to delete the builtin version file
once the installation process is over. (Otherwise, the StGit version
in a git-controlled tree would be frozen at whatever value it happened
to have when setup.py was last run.)

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

On 2008-05-20 23:02:49 +0200, Karl Hasselstr=C3=B6m wrote:

> Nah, easier to just change the order of the checks (try r2 before r1)
> as I outlined. I'll whip up a patch.


 setup.py         |   45 +++++++++++++++++++++++++--------------------
 stgit/.gitignore |    1 -
 stgit/version.py |   15 ++++++++++++---
 3 files changed, 37 insertions(+), 24 deletions(-)


diff --git a/setup.py b/setup.py
index 40022a7..8d8f7a8 100755
--- a/setup.py
+++ b/setup.py
@@ -43,34 +43,39 @@ def __check_git_version():
               % (version.git_min_ver, gitver)
         sys.exit(1)
=20
+def __run_setup():
+    setup(name =3D 'stgit',
+          version =3D version.version,
+          license =3D 'GPLv2',
+          author =3D 'Catalin Marinas',
+          author_email =3D 'catalin.marinas@gmail.com',
+          url =3D 'http://www.procode.org/stgit/',
+          description =3D 'Stacked GIT',
+          long_description =3D 'Push/pop utility on top of GIT',
+          scripts =3D ['stg'],
+          packages =3D ['stgit', 'stgit.commands', 'stgit.lib'],
+          data_files =3D [
+            ('share/stgit/templates', glob.glob('templates/*.tmpl')),
+            ('share/stgit/examples', glob.glob('examples/*.tmpl')),
+            ('share/stgit/examples', ['examples/gitconfig']),
+            ('share/stgit/contrib', ['contrib/diffcol.sh',
+                                     'contrib/stgbashprompt.sh',
+                                     'contrib/stgit-completion.bash'])=
,
+            ('share/doc/stgit', glob.glob('doc/*.txt'))])
+
 # Check the minimum versions required
 if sys.argv[1] in ['install', 'build']:
     __check_python_version()
     __check_git_version()
=20
-version.write_builtin_version()
-
 # ensure readable template files
 old_mask =3D os.umask(0022)
=20
-setup(name =3D 'stgit',
-      version =3D version.version,
-      license =3D 'GPLv2',
-      author =3D 'Catalin Marinas',
-      author_email =3D 'catalin.marinas@gmail.com',
-      url =3D 'http://www.procode.org/stgit/',
-      description =3D 'Stacked GIT',
-      long_description =3D 'Push/pop utility on top of GIT',
-      scripts =3D ['stg'],
-      packages =3D ['stgit', 'stgit.commands', 'stgit.lib'],
-      data_files =3D [('share/stgit/templates', glob.glob('templates/*=
=2Etmpl')),
-                    ('share/stgit/examples', glob.glob('examples/*.tmp=
l')),
-                    ('share/stgit/examples', ['examples/gitconfig']),
-                    ('share/stgit/contrib', ['contrib/diffcol.sh',
-                                             'contrib/stgbashprompt.sh=
',
-                                             'contrib/stgit-completion=
=2Ebash']),
-                    ('share/doc/stgit', glob.glob('doc/*.txt'))]
-      )
+try:
+    version.write_builtin_version()
+    __run_setup()
+finally:
+    version.delete_builtin_version()
=20
 # restore the old mask
 os.umask(old_mask)
diff --git a/stgit/.gitignore b/stgit/.gitignore
index 4f9c8f1..0d20b64 100644
--- a/stgit/.gitignore
+++ b/stgit/.gitignore
@@ -1,2 +1 @@
 *.pyc
-/builtin_version.py
diff --git a/stgit/version.py b/stgit/version.py
index 8ee5009..d57053d 100644
--- a/stgit/version.py
+++ b/stgit/version.py
@@ -1,6 +1,6 @@
 from stgit.exception import StgException
 from stgit import run, utils
-import os.path, re, sys
+import os, os.path, re, sys
=20
 class VersionUnavailable(StgException):
     pass
@@ -31,17 +31,26 @@ def builtin_version():
     else:
         return bv.version
=20
+def _builtin_version_file(ext =3D 'py'):
+    return os.path.join(sys.path[0], 'stgit', 'builtin_version.%s' % e=
xt)
+
 def write_builtin_version():
     try:
         v =3D git_describe_version()
     except VersionUnavailable:
         return
-    f =3D file(os.path.join(sys.path[0], 'stgit', 'builtin_version.py'=
), 'w')
+    f =3D file(_builtin_version_file(), 'w')
     f.write('# This file was generated automatically. Do not edit by h=
and.\n'
             'version =3D %r\n' % v)
=20
+def delete_builtin_version():
+    for ext in ['py', 'pyc', 'pyo']:
+        fn =3D _builtin_version_file(ext)
+        if os.path.exists(fn):
+            os.remove(fn)
+
 def get_version():
-    for v in [git_describe_version, builtin_version]:
+    for v in [builtin_version, git_describe_version]:
         try:
             return v()
         except VersionUnavailable:
