From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 02/13] Clear up semantics of tree_status
Date: Sat, 15 Sep 2007 00:31:19 +0200
Message-ID: <20070914223119.7001.23842.stgit@morpheus.local>
References: <20070914222819.7001.55921.stgit@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 15 00:31:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWJhO-0001NS-Ka
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 00:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757958AbXINWb2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Sep 2007 18:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757762AbXINWb2
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 18:31:28 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:56496 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757251AbXINWb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 18:31:27 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 8AE35200A1CE;
	Sat, 15 Sep 2007 00:31:26 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 05544-01-36; Sat, 15 Sep 2007 00:31:23 +0200 (CEST)
Received: from morpheus (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id B003F200A1D3;
	Sat, 15 Sep 2007 00:31:19 +0200 (CEST)
Received: from morpheus.local (morpheus [127.0.0.1])
	by morpheus (Postfix) with ESMTP id 60B8ABFA59;
	Sat, 15 Sep 2007 00:31:19 +0200 (CEST)
In-Reply-To: <20070914222819.7001.55921.stgit@morpheus.local>
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58196>

The tree_status() function does a few slightly different things
depending on the arguments.  This patch adds checks that the arguments
are consistent and that the returned value looks good.

It also changes the semantics slightly.  If the 'files' parameter is
None, it will run status on all files.  If 'files' is a list, it will
run status on only those files.  This changes two things:

 1) If 'files' is the empty list, it will run status on no files.
 2) It 'files' is a list, it will never return the status for other fil=
es

Clearing this up will make it easier to understand code that is using
this function.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

 stgit/commands/status.py |    3 +++
 stgit/git.py             |   44 +++++++++++++++++++++++---------------=
------
 2 files changed, 26 insertions(+), 21 deletions(-)


diff --git a/stgit/commands/status.py b/stgit/commands/status.py
index 156552b..de88ba0 100644
--- a/stgit/commands/status.py
+++ b/stgit/commands/status.py
@@ -82,6 +82,9 @@ def func(parser, options, args):
         else:
             diff_flags =3D []
=20
+        # No args means all files
+        if not args:
+            args =3D None
         git.status(args, options.modified, options.new, options.delete=
d,
                    options.conflict, options.unknown, options.noexclud=
e,
                    diff_flags =3D diff_flags)
diff --git a/stgit/git.py b/stgit/git.py
index 539d699..8dda1ed 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -167,15 +167,20 @@ def exclude_files():
=20
 def tree_status(files =3D None, tree_id =3D 'HEAD', unknown =3D False,
                   noexclude =3D True, verbose =3D False, diff_flags =3D=
 []):
-    """Returns a list of pairs - (status, filename)
+    """Get the status of all changed files, or of a selected set of
+    files. Returns a list of pairs - (status, filename).
+
+    If 'files' is None, it will check all files, and optionally all
+    unknown files.  If 'files' is a list, it will only check the files
+    in the list.
     """
+    assert files =3D=3D None or not unknown
+
     if verbose:
         out.start('Checking for changes in the working directory')
=20
     refresh_index()
=20
-    if not files:
-        files =3D []
     cache_files =3D []
=20
     # unknown files
@@ -197,11 +202,14 @@ def tree_status(files =3D None, tree_id =3D 'HEAD=
', unknown =3D False,
     conflicts =3D get_conflicts()
     if not conflicts:
         conflicts =3D []
-    cache_files +=3D [('C', filename) for filename in conflicts]
+    cache_files +=3D [('C', filename) for filename in conflicts
+                    if files =3D=3D None or filename in files]
=20
     # the rest
-    for line in GRun('git-diff-index', *(diff_flags + [tree_id, '--'] =
+ files)
-                     ).output_lines():
+    args =3D diff_flags + [tree_id]
+    if files !=3D None:
+        args +=3D ['--'] + files
+    for line in GRun('git-diff-index', *args).output_lines():
         fs =3D tuple(line.rstrip().split(' ',4)[-1].split('\t',1))
         if fs[1] not in conflicts:
             cache_files.append(fs)
@@ -209,6 +217,7 @@ def tree_status(files =3D None, tree_id =3D 'HEAD',=
 unknown =3D False,
     if verbose:
         out.done()
=20
+    assert files =3D=3D None or set(f for s,f in cache_files) <=3D set=
(files)
     return cache_files
=20
 def local_changes(verbose =3D True):
@@ -538,9 +547,6 @@ def committer():
 def update_cache(files =3D None, force =3D False):
     """Update the cache information for the given files
     """
-    if not files:
-        files =3D []
-
     cache_files =3D tree_status(files, verbose =3D False)
=20
     # everything is up-to-date
@@ -569,8 +575,6 @@ def commit(message, files =3D None, parents =3D Non=
e, allowempty =3D False,
            committer_name =3D None, committer_email =3D None):
     """Commit the current tree to repository
     """
-    if not files:
-        files =3D []
     if not parents:
         parents =3D []
=20
@@ -712,14 +716,13 @@ def status(files =3D None, modified =3D False, ne=
w =3D False, deleted =3D False,
            diff_flags =3D []):
     """Show the tree status
     """
-    if not files:
-        files =3D []
-
-    cache_files =3D tree_status(files, unknown =3D True, noexclude =3D=
 noexclude,
-                                diff_flags =3D diff_flags)
-    all =3D not (modified or new or deleted or conflict or unknown)
+    cache_files =3D tree_status(files,
+                              unknown =3D (files =3D=3D None),
+                              noexclude =3D noexclude,
+                              diff_flags =3D diff_flags)
+    filtered =3D (modified or new or deleted or conflict or unknown)
=20
-    if not all:
+    if filtered:
         filestat =3D []
         if modified:
             filestat.append('M')
@@ -735,9 +738,8 @@ def status(files =3D None, modified =3D False, new =
=3D False, deleted =3D False,
         cache_files =3D [x for x in cache_files if x[0] in filestat]
=20
     for fs in cache_files:
-        if files and not fs[1] in files:
-            continue
-        if all:
+        assert files =3D=3D None or fs[1] in files
+        if not filtered:
             out.stdout('%s %s' % (fs[0], fs[1]))
         else:
             out.stdout('%s' % fs[1])
