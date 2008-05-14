From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/2] Better StGit version tracking
Date: Wed, 14 May 2008 03:47:00 +0200
Message-ID: <20080514014502.7043.44236.stgit@yoghurt>
References: <20080514014309.GA17955@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 03:47:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw661-0004ap-Dh
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 03:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176AbYENBrI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2008 21:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbYENBrH
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 21:47:07 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4088 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbYENBrG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 21:47:06 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1Jw655-0004iY-00; Wed, 14 May 2008 02:46:59 +0100
In-Reply-To: <20080514014309.GA17955@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.14.2.152.g77bd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82062>

Instead of claiming to be the latest released version (really, a
hardcoded string that we hope is the latest released version), run git
describe to figure out what version we are, just like git does. Fall
back to a hardcoded value that is generated at install time, or
supplied in a release tarball.

Currently, we have to give git describe the --tags flag, since StGit
release tags are lightweight tags. This means we're going to pick up
any lightweight tags the user makes, which isn't ideal. The solution
is to start making annotated release tags, and then remove that flag.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

Catalin, you might want to pay extra attention the first time you
release something with this in it. Making sure that
stgit/builtin_version.py is included in the tarball, for example.

 setup.py         |    2 ++
 stgit/.gitignore |    1 +
 stgit/version.py |   52 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
 3 files changed, 54 insertions(+), 1 deletions(-)


diff --git a/setup.py b/setup.py
index 04ca821..40022a7 100755
--- a/setup.py
+++ b/setup.py
@@ -48,6 +48,8 @@ if sys.argv[1] in ['install', 'build']:
     __check_python_version()
     __check_git_version()
=20
+version.write_builtin_version()
+
 # ensure readable template files
 old_mask =3D os.umask(0022)
=20
diff --git a/stgit/.gitignore b/stgit/.gitignore
index 0d20b64..4f9c8f1 100644
--- a/stgit/.gitignore
+++ b/stgit/.gitignore
@@ -1 +1,2 @@
 *.pyc
+/builtin_version.py
diff --git a/stgit/version.py b/stgit/version.py
index 06ac723..8ee5009 100644
--- a/stgit/version.py
+++ b/stgit/version.py
@@ -1,4 +1,54 @@
-version =3D '0.14.2'
+from stgit.exception import StgException
+from stgit import run, utils
+import os.path, re, sys
+
+class VersionUnavailable(StgException):
+    pass
+
+def git_describe_version():
+    path =3D sys.path[0]
+    try:
+        v =3D run.Run('git', 'describe', '--tags', '--abbrev=3D4'
+                    ).cwd(path).output_one_line()
+    except run.RunException, e:
+        raise VersionUnavailable(str(e))
+    if not re.match(r'^v[0-9]', v):
+        raise VersionUnavailable('%s: bad version' % v)
+    try:
+        dirty =3D run.Run('git', 'diff-index', '--name-only', 'HEAD'
+                        ).cwd(path).raw_output()
+    except run.RunException, e:
+        raise VersionUnavailable(str(e))
+    if dirty:
+        v +=3D '-dirty'
+    return re.sub('-', '.', utils.strip_prefix('v', v))
+
+def builtin_version():
+    try:
+        import builtin_version as bv
+    except ImportError:
+        raise VersionUnavailable()
+    else:
+        return bv.version
+
+def write_builtin_version():
+    try:
+        v =3D git_describe_version()
+    except VersionUnavailable:
+        return
+    f =3D file(os.path.join(sys.path[0], 'stgit', 'builtin_version.py'=
), 'w')
+    f.write('# This file was generated automatically. Do not edit by h=
and.\n'
+            'version =3D %r\n' % v)
+
+def get_version():
+    for v in [git_describe_version, builtin_version]:
+        try:
+            return v()
+        except VersionUnavailable:
+            pass
+    return 'unknown-version'
+
+version =3D get_version()
=20
 # minimum version requirements
 git_min_ver =3D '1.5.2'
