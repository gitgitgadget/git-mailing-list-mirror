From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 5/5] Add --binary flag to commands that generate diffs
Date: Sat, 19 May 2007 02:10:12 +0200
Message-ID: <20070519001012.4906.86287.stgit@yoghurt>
References: <20070519000451.4906.87089.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 02:10:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpCWf-0002J4-4U
	for gcvg-git@gmane.org; Sat, 19 May 2007 02:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755123AbXESAKT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 18 May 2007 20:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755323AbXESAKT
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 20:10:19 -0400
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:51724 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755123AbXESAKQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2007 20:10:16 -0400
Received: from c83-250-140-11.bredband.comhem.se ([83.250.140.11]:54515 helo=yoghurt)
	by ch-smtp01.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <kha@treskal.com>)
	id 1HpCWV-0006rm-3n; Sat, 19 May 2007 02:10:15 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.62)
	(envelope-from <kha@treskal.com>)
	id 1HpCWS-0001Kg-F3; Sat, 19 May 2007 02:10:12 +0200
In-Reply-To: <20070519000451.4906.87089.stgit@yoghurt>
User-Agent: StGIT/0.12
X-Scan-Result: No virus found in message 1HpCWV-0006rm-3n.
X-Scan-Signature: ch-smtp01.sth.basefarm.net 1HpCWV-0006rm-3n 81c3c73ffe74801f11f449aa0b7893ea
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47690>

This just passes the --binary option to git-diff-*, which causes the
generated diffs to contain an applyable diff even when binary files
differ. It's necessary to do this if you want to mail patches to
binary files.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 stgit/commands/diff.py   |    6 +++++-
 stgit/commands/export.py |    5 ++++-
 stgit/commands/mail.py   |    6 +++++-
 stgit/git.py             |   16 ++++++++++++----
 4 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/stgit/commands/diff.py b/stgit/commands/diff.py
index 8678a0a..d3e1190 100644
--- a/stgit/commands/diff.py
+++ b/stgit/commands/diff.py
@@ -44,6 +44,9 @@ shows the specified patch (defaulting to the current =
one)."""
 options =3D [make_option('-r', '--range',
                        metavar =3D 'rev1[..[rev2]]', dest =3D 'revs',
                        help =3D 'show the diff between revisions'),
+           make_option('--binary',
+                       help =3D 'output a diff even for binary files',
+                       action =3D 'store_true'),
            make_option('-s', '--stat',
                        help =3D 'show the stat instead of the diff',
                        action =3D 'store_true')]
@@ -79,6 +82,7 @@ def func(parser, options, args):
     if options.stat:
         print git.diffstat(args, git_id(rev1), git_id(rev2))
     else:
-        diff_str =3D git.diff(args, git_id(rev1), git_id(rev2))
+        diff_str =3D git.diff(args, git_id(rev1), git_id(rev2),
+                            binary =3D options.binary)
         if diff_str:
             pager(diff_str)
diff --git a/stgit/commands/export.py b/stgit/commands/export.py
index 79b8630..20d8f67 100644
--- a/stgit/commands/export.py
+++ b/stgit/commands/export.py
@@ -62,6 +62,9 @@ options =3D [make_option('-d', '--dir',
                        help =3D 'Use FILE as a template'),
            make_option('-b', '--branch',
                        help =3D 'use BRANCH instead of the default one=
'),
+           make_option('--binary',
+                       help =3D 'output a diff even for binary files',
+                       action =3D 'store_true'),
            make_option('-s', '--stdout',
                        help =3D 'dump the patches to the standard outp=
ut',
                        action =3D 'store_true')]
@@ -172,7 +175,7 @@ def func(parser, options, args):
         # write the diff
         git.diff(rev1 =3D patch.get_bottom(),
                  rev2 =3D patch.get_top(),
-                 out_fd =3D f)
+                 out_fd =3D f, binary =3D options.binary)
         if not options.stdout:
             f.close()
         patch_no +=3D 1
diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 151a408..2fcaa5f 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -120,6 +120,9 @@ options =3D [make_option('-a', '--all',
                        help =3D 'username for SMTP authentication'),
            make_option('-b', '--branch',
                        help =3D 'use BRANCH instead of the default one=
'),
+           make_option('--binary',
+                       help =3D 'output a diff even for binary files',
+                       action =3D 'store_true'),
            make_option('-m', '--mbox',
                        help =3D 'generate an mbox file instead of send=
ing',
                        action =3D 'store_true')]
@@ -390,7 +393,8 @@ def __build_message(tmpl, patch, patch_nr, total_nr=
, msg_id, ref_id, options):
                  # for backward template compatibility
                  'endofheaders': '',
                  'diff':         git.diff(rev1 =3D git_id('%s//bottom'=
 % patch),
-                                          rev2 =3D git_id('%s//top' % =
patch)),
+                                          rev2 =3D git_id('%s//top' % =
patch),
+                                          binary =3D options.binary),
                  'diffstat':     git.diffstat(rev1 =3D git_id('%s//bot=
tom'%patch),
                                               rev2 =3D git_id('%s//top=
' % patch)),
                  # for backward template compatibility
diff --git a/stgit/git.py b/stgit/git.py
index 837f927..86630ce 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -771,20 +771,28 @@ def status(files =3D None, modified =3D False, ne=
w =3D False, deleted =3D False,
         else:
             print '%s' % fs[1]
=20
-def diff(files =3D None, rev1 =3D 'HEAD', rev2 =3D None, out_fd =3D No=
ne):
+def diff(files =3D None, rev1 =3D 'HEAD', rev2 =3D None, out_fd =3D No=
ne,
+         binary =3D False):
     """Show the diff between rev1 and rev2
     """
     if not files:
         files =3D []
=20
+    args =3D []
+    if binary:
+        args.append('--binary')
+
     if rev1 and rev2:
-        diff_str =3D _output(['git-diff-tree', '-p', rev1, rev2, '--']=
 + files)
+        diff_str =3D _output(['git-diff-tree', '-p'] + args
+                           + [rev1, rev2, '--'] + files)
     elif rev1 or rev2:
         refresh_index()
         if rev2:
-            diff_str =3D _output(['git-diff-index', '-p', '-R', rev2, =
'--'] + files)
+            diff_str =3D _output(['git-diff-index', '-p', '-R']
+                               + args + [rev2, '--'] + files)
         else:
-            diff_str =3D _output(['git-diff-index', '-p', rev1, '--'] =
+ files)
+            diff_str =3D _output(['git-diff-index', '-p']
+                               + args + [rev1, '--'] + files)
     else:
         diff_str =3D ''
=20
