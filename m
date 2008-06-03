From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH v2 4/4] Handle refresh of changed files with non-ASCII
	names
Date: Tue, 03 Jun 2008 02:41:57 +0200
Message-ID: <20080603004157.25028.65176.stgit@yoghurt>
References: <20080603003846.25028.49353.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 02:43:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3KcN-0000YO-B0
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 02:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295AbYFCAmJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Jun 2008 20:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752537AbYFCAmG
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 20:42:06 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3966 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696AbYFCAmC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 20:42:02 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1K3Kb7-0001ms-00; Tue, 03 Jun 2008 01:41:57 +0100
In-Reply-To: <20080603003846.25028.49353.stgit@yoghurt>
User-Agent: StGIT/0.14.2.171.g5c0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83604>

Without -z, git diff-files was quoting them for us.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/git.py                   |   43 +++++++++++++++++++++-----------=
--------
 t/t3200-non-ascii-filenames.sh |    2 +-
 2 files changed, 24 insertions(+), 21 deletions(-)


diff --git a/stgit/git.py b/stgit/git.py
index 8c637d5..8e6bdf4 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -191,6 +191,19 @@ def ls_files(files, tree =3D 'HEAD', full_name =3D=
 True):
         raise GitException, \
             'Some of the given paths are either missing or not known t=
o GIT'
=20
+def parse_git_ls(output):
+    t =3D None
+    for line in output.split('\0'):
+        if not line:
+            # There's a zero byte at the end of the output, which
+            # gives us an empty string as the last "line".
+            continue
+        if t =3D=3D None:
+            mode_a, mode_b, sha1_a, sha1_b, t =3D line.split(' ')
+        else:
+            yield (t, line)
+            t =3D None
+
 def tree_status(files =3D None, tree_id =3D 'HEAD', unknown =3D False,
                   noexclude =3D True, verbose =3D False, diff_flags =3D=
 []):
     """Get the status of all changed files, or of a selected set of
@@ -242,21 +255,12 @@ def tree_status(files =3D None, tree_id =3D 'HEAD=
', unknown =3D False,
         args =3D diff_flags + [tree_id]
         if files_left:
             args +=3D ['--'] + files_left
-        t =3D None
-        for line in GRun('diff-index', '-z', *args).raw_output().split=
('\0'):
-            if not line:
-                # There's a zero byte at the end of the output, which
-                # gives us an empty string as the last "line".
-                continue
-            if t =3D=3D None:
-                mode_a, mode_b, sha1_a, sha1_b, t =3D line.split(' ')
-            else:
-                # the condition is needed in case files is emtpy and
-                # diff-index lists those already reported
-                if not line in reported_files:
-                    cache_files.append((t, line))
-                    reported_files.add(line)
-                t =3D None
+        for t, fn in parse_git_ls(GRun('diff-index', '-z', *args).raw_=
output()):
+            # the condition is needed in case files is emtpy and
+            # diff-index lists those already reported
+            if not fn in reported_files:
+                cache_files.append((t, fn))
+                reported_files.add(fn)
         files_left =3D [f for f in files if f not in reported_files]
=20
     # files in the index but changed on (or removed from) disk. Only
@@ -267,13 +271,12 @@ def tree_status(files =3D None, tree_id =3D 'HEAD=
', unknown =3D False,
         args =3D list(diff_flags)
         if files_left:
             args +=3D ['--'] + files_left
-        for line in GRun('diff-files', *args).output_lines():
-            fs =3D tuple(line.rstrip().split(' ',4)[-1].split('\t',1))
+        for t, fn in parse_git_ls(GRun('diff-files', '-z', *args).raw_=
output()):
             # the condition is needed in case files is empty and
             # diff-files lists those already reported
-            if fs[1] not in reported_files:
-                cache_files.append(fs)
-                reported_files.add(fs[1])
+            if not fn in reported_files:
+                cache_files.append((t, fn))
+                reported_files.add(fn)
=20
     if verbose:
         out.done()
diff --git a/t/t3200-non-ascii-filenames.sh b/t/t3200-non-ascii-filenam=
es.sh
index 3146b8d..1aa78ed 100755
--- a/t/t3200-non-ascii-filenames.sh
+++ b/t/t3200-non-ascii-filenames.sh
@@ -40,7 +40,7 @@ test_expect_success 'Setup' '
 cat > expected.txt <<EOF
 M sk=C3=A4rg=C3=A5rds=C3=B6.txt
 EOF
-test_expect_failure 'Status of modified non-ASCII file' '
+test_expect_success 'Status of modified non-ASCII file' '
     stg status > output.txt &&
     diff -u expected.txt output.txt
 '
