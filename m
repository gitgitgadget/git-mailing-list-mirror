From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Fix "stg resolved" to work with new conflict
	representation
Date: Mon, 03 Sep 2007 02:04:05 +0200
Message-ID: <20070903000044.24008.89472.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Mon Sep 03 02:04:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRzQa-0001Al-LO
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 02:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756150AbXICAEY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 2 Sep 2007 20:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbXICAEY
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 20:04:24 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2301 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbXICAEX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 20:04:23 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IRzQG-0008JG-00; Mon, 03 Sep 2007 01:04:08 +0100
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57410>

The actual resolving is done by calling the same subroutine as "git
add".

Instead of using existing *.{ancestor,current,patches} files, the
interactive merge has to create them from the index contents, and
delete them afterwards.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

This goes on top of David's conflict series.

 stgit/commands/common.py   |   16 ++-----
 stgit/commands/resolved.py |   19 ++------
 stgit/gitmergeonefile.py   |   99 ++++++++++++++++++++++++------------=
--------
 3 files changed, 62 insertions(+), 72 deletions(-)


diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index ad94caf..f31c09b 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -137,18 +137,10 @@ def print_crt_patch(branch =3D None):
=20
 def resolved(filename, reset =3D None):
     if reset:
-        reset_file =3D filename + file_extensions()[reset]
-        if os.path.isfile(reset_file):
-            if os.path.isfile(filename):
-                os.remove(filename)
-            os.rename(reset_file, filename)
-
-    git.update_cache([filename], force =3D True)
-
-    for ext in file_extensions().values():
-        fn =3D filename + ext
-        if os.path.isfile(fn):
-            os.remove(fn)
+        stage =3D {'ancestor': 1, 'current': 2, 'patched': 3}[reset]
+        Run('git-checkout-index', '--no-create', '--stage=3D%d' % stag=
e, '--',
+            filename).no_output()
+    git.add([filename])
=20
 def resolved_all(reset =3D None):
     conflicts =3D git.get_conflicts()
diff --git a/stgit/commands/resolved.py b/stgit/commands/resolved.py
index 1130641..de38737 100644
--- a/stgit/commands/resolved.py
+++ b/stgit/commands/resolved.py
@@ -73,18 +73,7 @@ def func(parser, options, args):
                 raise CmdException, 'No conflicts for "%s"' % filename
=20
     # resolved
-    try:
-        for filename in files:
-            if options.interactive:
-                interactive_merge(filename)
-            resolved(filename, options.reset)
-            del conflicts[conflicts.index(filename)]
-    finally:
-        # save or remove the conflicts file. Needs a finally clause to
-        # ensure that already solved conflicts are marked
-        if conflicts =3D=3D []:
-            os.remove(os.path.join(basedir.get(), 'conflicts'))
-        else:
-            f =3D file(os.path.join(basedir.get(), 'conflicts'), 'w+')
-            f.writelines([line + '\n' for line in conflicts])
-            f.close()
+    for filename in files:
+        if options.interactive:
+            interactive_merge(filename)
+        resolved(filename, options.reset)
diff --git a/stgit/gitmergeonefile.py b/stgit/gitmergeonefile.py
index 2aa5ef8..e9bdebb 100644
--- a/stgit/gitmergeonefile.py
+++ b/stgit/gitmergeonefile.py
@@ -96,51 +96,60 @@ def __conflict(path):
=20
=20
 def interactive_merge(filename):
-    """Run the interactive merger on the given file. Note that the
-    index should not have any conflicts.
-    """
-    extensions =3D file_extensions()
-
-    ancestor =3D filename + extensions['ancestor']
-    current =3D filename + extensions['current']
-    patched =3D filename + extensions['patched']
-
-    if os.path.isfile(ancestor):
-        three_way =3D True
-        files_dict =3D {'branch1': current,
-                      'ancestor': ancestor,
-                      'branch2': patched,
-                      'output': filename}
-        imerger =3D config.get('stgit.i3merge')
-    else:
-        three_way =3D False
-        files_dict =3D {'branch1': current,
-                      'branch2': patched,
-                      'output': filename}
-        imerger =3D config.get('stgit.i2merge')
-
-    if not imerger:
-        raise GitMergeException, 'No interactive merge command configu=
red'
-
-    # check whether we have all the files for the merge
-    for fn in [filename, current, patched]:
-        if not os.path.isfile(fn):
-            raise GitMergeException, \
-                  'Cannot run the interactive merge: "%s" missing' % f=
n
-
-    mtime =3D os.path.getmtime(filename)
-
-    out.info('Trying the interactive %s merge'
-             % (three_way and 'three-way' or 'two-way'))
-
-    err =3D os.system(imerger % files_dict)
-    if err !=3D 0:
-        raise GitMergeException, 'The interactive merge failed: %d' % =
err
-    if not os.path.isfile(filename):
-        raise GitMergeException, 'The "%s" file is missing' % filename
-    if mtime =3D=3D os.path.getmtime(filename):
-        raise GitMergeException, 'The "%s" file was not modified' % fi=
lename
-
+    """Run the interactive merger on the given file."""
+    try:
+        extensions =3D file_extensions()
+        line =3D MRun('git-checkout-index', '--stage=3Dall', '--', fil=
ename
+                    ).output_one_line()
+        stages, path =3D line.split('\t')
+        stages =3D dict(zip(['ancestor', 'current', 'patched'],
+                          stages.split(' ')))
+        for stage, fn in stages.iteritems():
+            if stages[stage] =3D=3D '.':
+                stages[stage] =3D None
+            else:
+                newname =3D filename + extensions[stage]
+                if not os.path.exists(newname):
+                    os.rename(stages[stage], newname)
+                    stages[stage] =3D newname
+
+        # Check whether we have all the files for the merge.
+        if not (stages['current'] and stages['patched']):
+            raise GitMergeException('Cannot run the interactive merge'=
)
+
+        if stages['ancestor']:
+            three_way =3D True
+            files_dict =3D {'branch1': stages['current'],
+                          'ancestor': stages['ancestor'],
+                          'branch2': stages['patched'],
+                          'output': filename}
+            imerger =3D config.get('stgit.i3merge')
+        else:
+            three_way =3D False
+            files_dict =3D {'branch1': stages['current'],
+                          'branch2': stages['patched'],
+                          'output': filename}
+            imerger =3D config.get('stgit.i2merge')
+
+        if not imerger:
+            raise GitMergeException, 'No interactive merge command con=
figured'
+
+        mtime =3D os.path.getmtime(filename)
+
+        out.start('Trying the interactive %s merge'
+                  % (three_way and 'three-way' or 'two-way'))
+        err =3D os.system(imerger % files_dict)
+        out.done()
+        if err !=3D 0:
+            raise GitMergeException, 'The interactive merge failed'
+        if not os.path.isfile(filename):
+            raise GitMergeException, 'The "%s" file is missing' % file=
name
+        if mtime =3D=3D os.path.getmtime(filename):
+            raise GitMergeException, 'The "%s" file was not modified' =
% filename
+    finally:
+        for fn in stages.itervalues():
+            if os.path.isfile(fn):
+                os.remove(fn)
=20
 #
 # Main algorithm
