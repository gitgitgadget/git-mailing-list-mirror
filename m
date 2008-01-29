From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 5/5] Let the caller supply the diff text to diffstat()
Date: Tue, 29 Jan 2008 04:06:35 +0100
Message-ID: <20080129030503.926.71863.stgit@yoghurt>
References: <20080129030059.926.29897.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 04:07:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJgot-0004pg-DV
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 04:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755521AbYA2DGj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jan 2008 22:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754727AbYA2DGj
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 22:06:39 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1931 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755495AbYA2DGi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 22:06:38 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JJgnx-0000Yb-00; Tue, 29 Jan 2008 03:06:34 +0000
In-Reply-To: <20080129030059.926.29897.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71932>

Almost all diffstat() callers already have the diff text, so they
might as well pass it to diffstat() instead of letting it recompute
it. In some cases this even makes for a code simplification since the
diff (and thus diffstat) parameters were nontrivial.

Also, diffstat() wasn't as versatile as diff(); for example, it didn't
accept any extra diff options. This patch solves all of those problems
as a side-effect.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

I wanted this for the "stg edit" rewrite. It took some time before I
saw the TODO comment describing exactly the change I was in the
process of making!

 stgit/commands/diff.py   |    9 ++++-----
 stgit/commands/edit.py   |    2 +-
 stgit/commands/export.py |   10 +++++-----
 stgit/commands/files.py  |    2 +-
 stgit/commands/mail.py   |   16 +++++++---------
 stgit/git.py             |    9 +++------
 6 files changed, 21 insertions(+), 27 deletions(-)


diff --git a/stgit/commands/diff.py b/stgit/commands/diff.py
index 7c213d1..fd6be34 100644
--- a/stgit/commands/diff.py
+++ b/stgit/commands/diff.py
@@ -81,12 +81,11 @@ def func(parser, options, args):
         rev1 =3D 'HEAD'
         rev2 =3D None
=20
+    diff_str =3D git.diff(args, git_id(crt_series, rev1),
+                        git_id(crt_series, rev2),
+                        diff_flags =3D options.diff_flags)
     if options.stat:
-        out.stdout_raw(git.diffstat(args, git_id(crt_series, rev1),
-                                    git_id(crt_series, rev2)) + '\n')
+        out.stdout_raw(git.diffstat(diff_str) + '\n')
     else:
-        diff_str =3D git.diff(args, git_id(crt_series, rev1),
-                            git_id(crt_series, rev2),
-                            diff_flags =3D options.diff_flags)
         if diff_str:
             pager(diff_str)
diff --git a/stgit/commands/edit.py b/stgit/commands/edit.py
index da67275..9915e49 100644
--- a/stgit/commands/edit.py
+++ b/stgit/commands/edit.py
@@ -154,9 +154,9 @@ def __generate_file(pname, write_fn, options):
                 '%(diffstat)s\n' \
                 '%(diff)s'
=20
-        tmpl_dict['diffstat'] =3D git.diffstat(rev1 =3D bottom, rev2 =3D=
 top)
         tmpl_dict['diff'] =3D git.diff(rev1 =3D bottom, rev2 =3D top,
                                      diff_flags =3D options.diff_flags=
)
+        tmpl_dict['diffstat'] =3D git.diffstat(tmpl_dict['diff'])
=20
     for key in tmpl_dict:
         # make empty strings if key is not available
diff --git a/stgit/commands/export.py b/stgit/commands/export.py
index 16c64ba..50f6f67 100644
--- a/stgit/commands/export.py
+++ b/stgit/commands/export.py
@@ -138,11 +138,13 @@ def func(parser, options, args):
         long_descr =3D reduce(lambda x, y: x + '\n' + y,
                             descr_lines[1:], '').strip()
=20
+        diff =3D git.diff(rev1 =3D patch.get_bottom(),
+                        rev2 =3D patch.get_top(),
+                        diff_flags =3D options.diff_flags)
         tmpl_dict =3D {'description': patch.get_description().rstrip()=
,
                      'shortdescr': short_descr,
                      'longdescr': long_descr,
-                     'diffstat': git.diffstat(rev1 =3D patch.get_botto=
m(),
-                                              rev2 =3D patch.get_top()=
),
+                     'diffstat': git.diffstat(diff),
                      'authname': patch.get_authname(),
                      'authemail': patch.get_authemail(),
                      'authdate': patch.get_authdate(),
@@ -172,9 +174,7 @@ def func(parser, options, args):
             print '-'*79
=20
         f.write(descr)
-        f.write(git.diff(rev1 =3D patch.get_bottom(),
-                         rev2 =3D patch.get_top(),
-                         diff_flags =3D options.diff_flags))
+        f.write(diff)
         if not options.stdout:
             f.close()
         patch_no +=3D 1
diff --git a/stgit/commands/files.py b/stgit/commands/files.py
index ab1f6a3..b43b12f 100644
--- a/stgit/commands/files.py
+++ b/stgit/commands/files.py
@@ -60,7 +60,7 @@ def func(parser, options, args):
     rev2 =3D git_id(crt_series, '%s//top' % patch)
=20
     if options.stat:
-        out.stdout_raw(git.diffstat(rev1 =3D rev1, rev2 =3D rev2) + '\=
n')
+        out.stdout_raw(git.diffstat(git.diff(rev1 =3D rev1, rev2 =3D r=
ev2)) + '\n')
     elif options.bare:
         out.stdout_raw(git.barefiles(rev1, rev2) + '\n')
     else:
diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 4aa16fb..7d19eca 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -360,9 +360,9 @@ def __build_cover(tmpl, patches, msg_id, options):
                  'number':       number_str,
                  'shortlog':     stack.shortlog(crt_series.get_patch(p=
)
                                                 for p in patches),
-                 'diffstat':     git.diffstat(
+                 'diffstat':     git.diffstat(git.diff(
                      rev1 =3D git_id(crt_series, '%s//bottom' % patche=
s[0]),
-                     rev2 =3D git_id(crt_series, '%s//top' % patches[-=
1]))}
+                     rev2 =3D git_id(crt_series, '%s//top' % patches[-=
1])))}
=20
     try:
         msg_string =3D tmpl % tmpl_dict
@@ -433,6 +433,9 @@ def __build_message(tmpl, patch, patch_nr, total_nr=
, msg_id, ref_id, options):
     else:
         number_str =3D ''
=20
+    diff =3D git.diff(rev1 =3D git_id(crt_series, '%s//bottom' % patch=
),
+                    rev2 =3D git_id(crt_series, '%s//top' % patch),
+                    diff_flags =3D options.diff_flags)
     tmpl_dict =3D {'patch':        patch,
                  'sender':       sender,
                  # for backward template compatibility
@@ -441,13 +444,8 @@ def __build_message(tmpl, patch, patch_nr, total_n=
r, msg_id, ref_id, options):
                  'longdescr':    long_descr,
                  # for backward template compatibility
                  'endofheaders': '',
-                 'diff':         git.diff(
-                     rev1 =3D git_id(crt_series, '%s//bottom' % patch)=
,
-                     rev2 =3D git_id(crt_series, '%s//top' % patch),
-                     diff_flags =3D options.diff_flags),
-                 'diffstat':     git.diffstat(
-                     rev1 =3D git_id(crt_series, '%s//bottom'%patch),
-                     rev2 =3D git_id(crt_series, '%s//top' % patch)),
+                 'diff':         diff,
+                 'diffstat':     git.diffstat(diff),
                  # for backward template compatibility
                  'date':         '',
                  'version':      version_str,
diff --git a/stgit/git.py b/stgit/git.py
index 85cceb0..4dc4dcf 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -640,12 +640,9 @@ def diff(files =3D None, rev1 =3D 'HEAD', rev2 =3D=
 None, diff_flags =3D [],
     else:
         return ''
=20
-# TODO: take another parameter representing a diff string as we
-# usually invoke git.diff() form the calling functions
-def diffstat(files =3D None, rev1 =3D 'HEAD', rev2 =3D None):
-    """Return the diffstat between rev1 and rev2."""
-    return GRun('apply', '--stat', '--summary'
-                ).raw_input(diff(files, rev1, rev2)).raw_output()
+def diffstat(diff):
+    """Return the diffstat of the supplied diff."""
+    return GRun('apply', '--stat', '--summary').raw_input(diff).raw_ou=
tput()
=20
 def files(rev1, rev2, diff_flags =3D []):
     """Return the files modified between rev1 and rev2
