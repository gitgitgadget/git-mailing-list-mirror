From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 03/13] Moved that status function to the status command
	file
Date: Sat, 15 Sep 2007 00:31:24 +0200
Message-ID: <20070914223124.7001.29374.stgit@morpheus.local>
References: <20070914222819.7001.55921.stgit@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 15 00:31:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWJhP-0001NS-6y
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 00:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757756AbXINWbc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Sep 2007 18:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757762AbXINWba
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 18:31:30 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:56498 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757756AbXINWb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 18:31:28 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id DCBD1200A1D8;
	Sat, 15 Sep 2007 00:31:27 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 02165-01-79; Sat, 15 Sep 2007 00:31:26 +0200 (CEST)
Received: from morpheus (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id CA8AE200A1B8;
	Sat, 15 Sep 2007 00:31:24 +0200 (CEST)
Received: from morpheus.local (morpheus [127.0.0.1])
	by morpheus (Postfix) with ESMTP id 6F988BFA59;
	Sat, 15 Sep 2007 00:31:24 +0200 (CEST)
In-Reply-To: <20070914222819.7001.55921.stgit@morpheus.local>
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58194>

The git.status() was more of a command than a library function, and
was only used in one place.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

 stgit/commands/status.py |   39 ++++++++++++++++++++++++++++++++++++--=
-
 stgit/git.py             |   33 ---------------------------------
 t/t0002-status.sh        |    8 ++++++++
 3 files changed, 44 insertions(+), 36 deletions(-)


diff --git a/stgit/commands/status.py b/stgit/commands/status.py
index de88ba0..bbfb5df 100644
--- a/stgit/commands/status.py
+++ b/stgit/commands/status.py
@@ -65,6 +65,39 @@ options =3D [make_option('-m', '--modified',
                        action =3D 'store_true')]
=20
=20
+def status(files =3D None, modified =3D False, new =3D False, deleted =
=3D False,
+           conflict =3D False, unknown =3D False, noexclude =3D False,
+           diff_flags =3D []):
+    """Show the tree status
+    """
+    cache_files =3D git.tree_status(files,
+                                  unknown =3D (files =3D=3D None),
+                                  noexclude =3D noexclude,
+                                  diff_flags =3D diff_flags)
+    filtered =3D (modified or new or deleted or conflict or unknown)
+
+    if filtered:
+        filestat =3D []
+        if modified:
+            filestat.append('M')
+        if new:
+            filestat.append('A')
+            filestat.append('N')
+        if deleted:
+            filestat.append('D')
+        if conflict:
+            filestat.append('C')
+        if unknown:
+            filestat.append('?')
+        cache_files =3D [x for x in cache_files if x[0] in filestat]
+
+    for fs in cache_files:
+        assert files =3D=3D None or fs[1] in files
+        if not filtered:
+            out.stdout('%s %s' % (fs[0], fs[1]))
+        else:
+            out.stdout('%s' % fs[1])
+
 def func(parser, options, args):
     """Show the tree status
     """
@@ -85,6 +118,6 @@ def func(parser, options, args):
         # No args means all files
         if not args:
             args =3D None
-        git.status(args, options.modified, options.new, options.delete=
d,
-                   options.conflict, options.unknown, options.noexclud=
e,
-                   diff_flags =3D diff_flags)
+        status(args, options.modified, options.new, options.deleted,
+               options.conflict, options.unknown, options.noexclude,
+               diff_flags =3D diff_flags)
diff --git a/stgit/git.py b/stgit/git.py
index 8dda1ed..b112787 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -711,39 +711,6 @@ def merge(base, head1, head2, recursive =3D False)=
:
     if errors:
         raise GitException, 'GIT index merging failed (possible confli=
cts)'
=20
-def status(files =3D None, modified =3D False, new =3D False, deleted =
=3D False,
-           conflict =3D False, unknown =3D False, noexclude =3D False,
-           diff_flags =3D []):
-    """Show the tree status
-    """
-    cache_files =3D tree_status(files,
-                              unknown =3D (files =3D=3D None),
-                              noexclude =3D noexclude,
-                              diff_flags =3D diff_flags)
-    filtered =3D (modified or new or deleted or conflict or unknown)
-
-    if filtered:
-        filestat =3D []
-        if modified:
-            filestat.append('M')
-        if new:
-            filestat.append('A')
-            filestat.append('N')
-        if deleted:
-            filestat.append('D')
-        if conflict:
-            filestat.append('C')
-        if unknown:
-            filestat.append('?')
-        cache_files =3D [x for x in cache_files if x[0] in filestat]
-
-    for fs in cache_files:
-        assert files =3D=3D None or fs[1] in files
-        if not filtered:
-            out.stdout('%s %s' % (fs[0], fs[1]))
-        else:
-            out.stdout('%s' % fs[1])
-
 def diff(files =3D None, rev1 =3D 'HEAD', rev2 =3D None, diff_flags =3D=
 []):
     """Show the diff between rev1 and rev2
     """
diff --git a/t/t0002-status.sh b/t/t0002-status.sh
index 790b9fb..d0c31b2 100755
--- a/t/t0002-status.sh
+++ b/t/t0002-status.sh
@@ -60,6 +60,14 @@ test_expect_success 'Status with an added file' '
 '
=20
 cat > expected.txt <<EOF
+foo/bar
+EOF
+test_expect_success 'Status with an added file and -n option' '
+    stg status -n > output.txt &&
+    diff -u expected.txt output.txt
+'
+
+cat > expected.txt <<EOF
 EOF
 test_expect_success 'Status after refresh' '
     stg new -m "first patch" &&
