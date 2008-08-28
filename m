From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Invoke the correct interactive editor
Date: Thu, 28 Aug 2008 02:19:43 +0200
Message-ID: <20080828001843.5510.76140.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 02:21:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYVG9-0003iZ-IP
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 02:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756857AbYH1ATx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Aug 2008 20:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756775AbYH1ATx
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 20:19:53 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1733 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756694AbYH1ATv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 20:19:51 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KYVaL-0008LA-00; Thu, 28 Aug 2008 01:42:01 +0100
User-Agent: StGIT/0.14.3.232.g9dfa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93999>

The order is supposed to be GIT_EDITOR, stgit.editor, core.editor,
VISUAL, EDITOR, vi. This patch makes it so.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/utils.py  |   22 +++++++++++++---------
 t/t3300-edit.sh |    8 ++++----
 t/test-lib.sh   |    5 ++---
 3 files changed, 19 insertions(+), 16 deletions(-)


diff --git a/stgit/utils.py b/stgit/utils.py
index 864975d..d1409cc 100644
--- a/stgit/utils.py
+++ b/stgit/utils.py
@@ -170,17 +170,21 @@ def rename(basedir, file1, file2):
 class EditorException(StgException):
     pass
=20
+def get_editor():
+    for editor in [os.environ.get('GIT_EDITOR'),
+                   config.get('stgit.editor'), # legacy
+                   config.get('core.editor'),
+                   os.environ.get('VISUAL'),
+                   os.environ.get('EDITOR'),
+                   'vi']:
+        if editor:
+            return editor
+
 def call_editor(filename):
     """Run the editor on the specified filename."""
-
-    # the editor
-    editor =3D config.get('stgit.editor')
-    if not editor:
-        editor =3D os.environ.get('EDITOR', 'vi')
-    editor +=3D ' %s' % filename
-
-    out.start('Invoking the editor: "%s"' % editor)
-    err =3D os.system(editor)
+    cmd =3D '%s %s' % (get_editor(), filename)
+    out.start('Invoking the editor: "%s"' % cmd)
+    err =3D os.system(cmd)
     if err:
         raise EditorException, 'editor failed, exit code: %d' % err
     out.done()
diff --git a/t/t3300-edit.sh b/t/t3300-edit.sh
index 5c2d32e..ad3b23f 100755
--- a/t/t3300-edit.sh
+++ b/t/t3300-edit.sh
@@ -99,7 +99,7 @@ EOF
 }
=20
 mkeditor vi
-test_expect_failure 'Edit commit message interactively (vi)' '
+test_expect_success 'Edit commit message interactively (vi)' '
     m=3D$(msg HEAD) &&
     PATH=3D.:$PATH stg edit p2 &&
     test "$(msg HEAD)" =3D "$m/vi"
@@ -114,14 +114,14 @@ test_expect_success 'Edit commit message interact=
ively (EDITOR)' '
 '
=20
 mkeditor e2
-test_expect_failure 'Edit commit message interactively (VISUAL)' '
+test_expect_success 'Edit commit message interactively (VISUAL)' '
     m=3D$(msg HEAD) &&
     VISUAL=3D./e2 EDITOR=3D./e1 PATH=3D.:$PATH stg edit p2 &&
     test "$(msg HEAD)" =3D "$m/e2"
 '
=20
 mkeditor e3
-test_expect_failure 'Edit commit message interactively (core.editor)' =
'
+test_expect_success 'Edit commit message interactively (core.editor)' =
'
     m=3D$(msg HEAD) &&
     git config core.editor e3 &&
     VISUAL=3D./e2 EDITOR=3D./e1 PATH=3D.:$PATH stg edit p2 &&
@@ -137,7 +137,7 @@ test_expect_success 'Edit commit message interactiv=
ely (stgit.editor)' '
 '
=20
 mkeditor e5
-test_expect_failure 'Edit commit message interactively (GIT_EDITOR)' '
+test_expect_success 'Edit commit message interactively (GIT_EDITOR)' '
     m=3D$(msg HEAD) &&
     GIT_EDITOR=3D./e5 VISUAL=3D./e2 EDITOR=3D./e1 PATH=3D.:$PATH stg e=
dit p2 &&
     test "$(msg HEAD)" =3D "$m/e5"
diff --git a/t/test-lib.sh b/t/test-lib.sh
index ad8da68..c1fb1b3 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -14,8 +14,8 @@ PAGER=3Dcat
 TZ=3DUTC
 TERM=3Ddumb
 export LANG LC_ALL PAGER TERM TZ
-EDITOR=3D:
-VISUAL=3D:
+unset EDITOR
+unset VISUAL
 unset GIT_EDITOR
 unset AUTHOR_DATE
 unset AUTHOR_EMAIL
@@ -42,7 +42,6 @@ GIT_MERGE_VERBOSITY=3D5
 export GIT_MERGE_VERBOSITY
 export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
-export EDITOR VISUAL
 GIT_TEST_CMP=3D${GIT_TEST_CMP:-diff -u}
=20
 # Protect ourselves from common misconfiguration to export
