From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH] Teach StGIT about core.excludesfile
Date: Tue, 07 Aug 2007 04:40:37 +0200
Message-ID: <20070807024037.11009.14569.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 04:40:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIF02-00041o-Bm
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 04:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765273AbXHGCkn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 6 Aug 2007 22:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765534AbXHGCkn
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 22:40:43 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4508 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765208AbXHGCkn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 22:40:43 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IIEzu-0002SI-00; Tue, 07 Aug 2007 03:40:38 +0100
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55201>

If there is a core.excludesfile option specified, let StGIT take
exclude patterns from that file, since that's what the docs say, and
what everyone else is already doing.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/git.py |   27 +++++++++++++++------------
 1 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/stgit/git.py b/stgit/git.py
index 72bf889..57c156e 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -216,6 +216,13 @@ def __run(cmd, args=3DNone):
         return r
     return 0
=20
+def exclude_files():
+    files =3D [os.path.join(basedir.get(), 'info', 'exclude')]
+    user_exclude =3D config.get('core.excludesfile')
+    if user_exclude:
+        files.append(user_exclude)
+    return files
+
 def tree_status(files =3D None, tree_id =3D 'HEAD', unknown =3D False,
                   noexclude =3D True, verbose =3D False, diff_flags =3D=
 []):
     """Returns a list of pairs - [status, filename]
@@ -231,20 +238,16 @@ def tree_status(files =3D None, tree_id =3D 'HEAD=
', unknown =3D False,
=20
     # unknown files
     if unknown:
-        exclude_file =3D os.path.join(basedir.get(), 'info', 'exclude'=
)
-        base_exclude =3D ['--exclude=3D%s' % s for s in
-                        ['*.[ao]', '*.pyc', '.*', '*~', '#*', 'TAGS', =
'tags']]
-        base_exclude.append('--exclude-per-directory=3D.gitignore')
-
-        if os.path.exists(exclude_file):
-            extra_exclude =3D ['--exclude-from=3D%s' % exclude_file]
-        else:
-            extra_exclude =3D []
         if noexclude:
-            extra_exclude =3D base_exclude =3D []
-
+            exclude =3D []
+        else:
+            exclude =3D (['--exclude=3D%s' % s for s in
+                        ['*.[ao]', '*.pyc', '.*', '*~', '#*', 'TAGS', =
'tags']]
+                       + ['--exclude-per-directory=3D.gitignore']
+                       + ['--exclude-from=3D%s' % fn for fn in exclude=
_files()
+                          if os.path.exists(fn)])
         lines =3D _output_lines(['git-ls-files', '--others', '--direct=
ory']
-                        + base_exclude + extra_exclude)
+                              + exclude)
         cache_files +=3D [('?', line.strip()) for line in lines]
=20
     # conflicted files
