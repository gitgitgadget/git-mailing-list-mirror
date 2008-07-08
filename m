From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/2] Don't allow extra diff options with "stg status"
Date: Tue, 08 Jul 2008 21:54:31 +0200
Message-ID: <20080708195431.24866.46141.stgit@yoghurt>
References: <20080708195214.24866.61663.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jon Smirl <jonsmirl@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 21:55:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGJHh-0004zL-3S
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 21:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754346AbYGHTyi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jul 2008 15:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754369AbYGHTyi
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 15:54:38 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1613 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754309AbYGHTyh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 15:54:37 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KGJGh-0003xg-00; Tue, 08 Jul 2008 20:54:31 +0100
In-Reply-To: <20080708195214.24866.61663.stgit@yoghurt>
User-Agent: StGIT/0.14.3.194.gbf3df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87791>

The only extra diff options (given either with -O/--diff-opts) that
would affect "stg status" were -C and -M, and those made it crash
because it couldn't handle them. So remove those options.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/status.py |   16 +++-------------
 stgit/git.py             |    9 ++++++---
 t/t0002-status.sh        |    5 -----
 3 files changed, 9 insertions(+), 21 deletions(-)


diff --git a/stgit/commands/status.py b/stgit/commands/status.py
index 20614b0..94d0b57 100644
--- a/stgit/commands/status.py
+++ b/stgit/commands/status.py
@@ -59,22 +59,18 @@ options =3D [make_option('-m', '--modified',
            make_option('-x', '--noexclude',
                        help =3D 'do not exclude any files from listing=
',
                        action =3D 'store_true'),
-           make_option('-O', '--diff-opts',
-                       help =3D 'options to pass to git-diff'),
            make_option('--reset',
                        help =3D 'reset the current tree changes',
                        action =3D 'store_true')]
=20
=20
 def status(files =3D None, modified =3D False, new =3D False, deleted =
=3D False,
-           conflict =3D False, unknown =3D False, noexclude =3D False,
-           diff_flags =3D []):
+           conflict =3D False, unknown =3D False, noexclude =3D False)=
:
     """Show the tree status
     """
     cache_files =3D git.tree_status(files,
                                   unknown =3D (not files),
-                                  noexclude =3D noexclude,
-                                  diff_flags =3D diff_flags)
+                                  noexclude =3D noexclude)
     filtered =3D (modified or new or deleted or conflict or unknown)
=20
     if filtered:
@@ -116,11 +112,5 @@ def func(parser, options, args):
             resolved_all()
             git.reset()
     else:
-        if options.diff_opts:
-            diff_flags =3D options.diff_opts.split()
-        else:
-            diff_flags =3D []
-
         status(args, options.modified, options.new, options.deleted,
-               options.conflict, options.unknown, options.noexclude,
-               diff_flags =3D diff_flags)
+               options.conflict, options.unknown, options.noexclude)
diff --git a/stgit/git.py b/stgit/git.py
index 8e6bdf4..35579d4 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -192,6 +192,9 @@ def ls_files(files, tree =3D 'HEAD', full_name =3D =
True):
             'Some of the given paths are either missing or not known t=
o GIT'
=20
 def parse_git_ls(output):
+    """Parse the output of git diff-index, diff-files, etc. Doesn't ha=
ndle
+    rename/copy output, so don't feed it output generated with the -M
+    or -C flags."""
     t =3D None
     for line in output.split('\0'):
         if not line:
@@ -205,7 +208,7 @@ def parse_git_ls(output):
             t =3D None
=20
 def tree_status(files =3D None, tree_id =3D 'HEAD', unknown =3D False,
-                  noexclude =3D True, verbose =3D False, diff_flags =3D=
 []):
+                  noexclude =3D True, verbose =3D False):
     """Get the status of all changed files, or of a selected set of
     files. Returns a list of pairs - (status, filename).
=20
@@ -252,7 +255,7 @@ def tree_status(files =3D None, tree_id =3D 'HEAD',=
 unknown =3D False,
     # specified when calling the function (i.e. report all files) or
     # files were specified but already found in the previous step
     if not files or files_left:
-        args =3D diff_flags + [tree_id]
+        args =3D [tree_id]
         if files_left:
             args +=3D ['--'] + files_left
         for t, fn in parse_git_ls(GRun('diff-index', '-z', *args).raw_=
output()):
@@ -268,7 +271,7 @@ def tree_status(files =3D None, tree_id =3D 'HEAD',=
 unknown =3D False,
     # function (i.e. report all files) or files were specified but
     # already found in the previous step
     if not files or files_left:
-        args =3D list(diff_flags)
+        args =3D []
         if files_left:
             args +=3D ['--'] + files_left
         for t, fn in parse_git_ls(GRun('diff-files', '-z', *args).raw_=
output()):
diff --git a/t/t0002-status.sh b/t/t0002-status.sh
index 69c29a0..a030739 100755
--- a/t/t0002-status.sh
+++ b/t/t0002-status.sh
@@ -182,9 +182,4 @@ test_expect_success 'Status after renaming a file' =
'
     diff -u expected.txt output.txt
 '
=20
-test_expect_failure 'Status after renaming a file (with rename detecti=
on)' '
-    stg status --diff-opts=3D-M > output.txt &&
-    diff -u expected.txt output.txt
-'
-
 test_done
