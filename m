From: =?utf-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 1/6] Split git.merge into two functions
Date: Mon, 20 Aug 2007 10:11:58 +0200
Message-ID: <1187597523433-git-send-email-davidk@lysator.liu.se>
References: <11875975232619-git-send-email-davidk@lysator.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>
To: catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 10:36:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN2kb-0000iq-JG
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 10:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755798AbXHTIgi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 04:36:38 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755721AbXHTIgi
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 04:36:38 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:52180 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755411AbXHTIge (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 04:36:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 2EA69200A21C;
	Mon, 20 Aug 2007 10:12:10 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 13727-01-35; Mon, 20 Aug 2007 10:12:03 +0200 (CEST)
Received: from morpheus (c83-253-22-183.bredband.comhem.se [83.253.22.183])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id D6E1F200A1FC;
	Mon, 20 Aug 2007 10:12:03 +0200 (CEST)
Received: by morpheus (Postfix, from userid 1000)
	id 49910BFC89; Mon, 20 Aug 2007 10:12:03 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc3.119.g1812
In-Reply-To: <11875975232619-git-send-email-davidk@lysator.liu.se>
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56194>

=46rom: David K=C3=A5gedal <davidk@lysator.liu.se>

This only prepares for later simplifications.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---
 stgit/commands/pick.py |    2 +-
 stgit/git.py           |   86 ++++++++++++++++++++++++++++++++++++++--=
--------
 stgit/stack.py         |    2 +-
 3 files changed, 70 insertions(+), 20 deletions(-)

diff --git a/stgit/commands/pick.py b/stgit/commands/pick.py
index 27fdf9c..9913e63 100644
--- a/stgit/commands/pick.py
+++ b/stgit/commands/pick.py
@@ -98,7 +98,7 @@ def func(parser, options, args):
=20
         # try a direct git-apply first
         if not git.apply_diff(bottom, top):
-            git.merge(bottom, git.get_head(), top, recursive =3D True)
+            git.merge_recursive(bottom, git.get_head(), top)
=20
         out.done()
     elif options.update:
diff --git a/stgit/git.py b/stgit/git.py
index 72bf889..9d8da5d 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -667,33 +667,83 @@ def apply_diff(rev1, rev2, check_index =3D True, =
files =3D None):
=20
     return True
=20
-def merge(base, head1, head2, recursive =3D False):
+stages_re =3D re.compile('^([0-7]+) ([0-9a-f]{40}) ([1-3])\t(.*)$', re=
=2ES)
+
+def merge_recursive(base, head1, head2):
     """Perform a 3-way merge between base, head1 and head2 into the
     local tree
     """
     refresh_index()
=20
     err_output =3D None
-    if recursive:
-        # this operation tracks renames but it is slower (used in
-        # general when pushing or picking patches)
-        try:
-            # use _output() to mask the verbose prints of the tool
-            _output(['git-merge-recursive', base, '--', head1, head2])
-        except GitException, ex:
-            err_output =3D str(ex)
-            pass
-    else:
-        # the fast case where we don't track renames (used when the
-        # distance between base and heads is small, i.e. folding or
-        # synchronising patches)
-        if __run('git-read-tree -u -m --aggressive',
-                 [base, head1, head2]) !=3D 0:
-            raise GitException, 'git-read-tree failed (local changes m=
aybe?)'
+    # this operation tracks renames but it is slower (used in
+    # general when pushing or picking patches)
+    try:
+        # use _output() to mask the verbose prints of the tool
+        _output(['git-merge-recursive', base, '--', head1, head2])
+    except GitException, ex:
+        err_output =3D str(ex)
+        pass
+
+    # check the index for unmerged entries
+    files =3D {}
+
+    for line in _output(['git-ls-files', '--unmerged', '--stage', '-z'=
]).split('\0'):
+        if not line:
+            continue
+
+        mode, hash, stage, path =3D stages_re.findall(line)[0]
+
+        if not path in files:
+            files[path] =3D {}
+            files[path]['1'] =3D ('', '')
+            files[path]['2'] =3D ('', '')
+            files[path]['3'] =3D ('', '')
+
+        files[path][stage] =3D (mode, hash)
+
+    if err_output and not files:
+        # if no unmerged files, there was probably a different type of
+        # error and we have to abort the merge
+        raise GitException, err_output
+
+    # merge the unmerged files
+    errors =3D False
+    for path in files:
+        # remove additional files that might be generated for some
+        # newer versions of GIT
+        for suffix in [base, head1, head2]:
+            if not suffix:
+                continue
+            fname =3D path + '~' + suffix
+            if os.path.exists(fname):
+                os.remove(fname)
+
+        stages =3D files[path]
+        if gitmergeonefile.merge(stages['1'][1], stages['2'][1],
+                                 stages['3'][1], path, stages['1'][0],
+                                 stages['2'][0], stages['3'][0]) !=3D =
0:
+            errors =3D True
+
+    if errors:
+        raise GitException, 'GIT index merging failed (possible confli=
cts)'
+
+def merge(base, head1, head2):
+    """Perform a 3-way merge between base, head1 and head2 into the
+    local tree
+    """
+    refresh_index()
+
+    err_output =3D None
+    # the fast case where we don't track renames (used when the
+    # distance between base and heads is small, i.e. folding or
+    # synchronising patches)
+    if __run('git-read-tree -u -m --aggressive',
+             [base, head1, head2]) !=3D 0:
+        raise GitException, 'git-read-tree failed (local changes maybe=
?)'
=20
     # check the index for unmerged entries
     files =3D {}
-    stages_re =3D re.compile('^([0-7]+) ([0-9a-f]{40}) ([1-3])\t(.*)$'=
, re.S)
=20
     for line in _output(['git-ls-files', '--unmerged', '--stage', '-z'=
]).split('\0'):
         if not line:
diff --git a/stgit/stack.py b/stgit/stack.py
index dbd7ea4..8b77943 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -1061,7 +1061,7 @@ class Series(PatchSet):
=20
                 # merge can fail but the patch needs to be pushed
                 try:
-                    git.merge(bottom, head, top, recursive =3D True)
+                    git.merge_recursive(bottom, head, top)
                 except git.GitException, ex:
                     out.error('The merge failed during "push".',
                               'Use "refresh" after fixing the conflict=
s or'
--=20
1.5.3.rc3.119.g1812
