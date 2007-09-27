From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Let "stg assimilate" handle missing patches
Date: Thu, 27 Sep 2007 07:50:42 +0200
Message-ID: <20070927055012.26131.33252.stgit@yoghurt>
References: <20070927054833.GA12207@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 07:51:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IamHK-0005E4-UK
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 07:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656AbXI0Fu5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Sep 2007 01:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752662AbXI0Fu5
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 01:50:57 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3866 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbXI0Fu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 01:50:56 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IamGp-0003EJ-00; Thu, 27 Sep 2007 06:50:44 +0100
In-Reply-To: <20070927054833.GA12207@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59266>

If a patch was not mentioned in the applied/unapplied files,
"assimilate" used to ignore it. Now it won't. The only information
loss ensuing from this sequence of commands

  $ rm .git/patches/<branch>/{un,}applied
  $ touch .git/patches/<branch>/{un,}applied
  $ stg assimilate

is now the order of the unapplied patches.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/assimilate.py |   32 ++++++++++++++++++++------------
 1 files changed, 20 insertions(+), 12 deletions(-)


diff --git a/stgit/commands/assimilate.py b/stgit/commands/assimilate.p=
y
index ab2264a..43672fd 100644
--- a/stgit/commands/assimilate.py
+++ b/stgit/commands/assimilate.py
@@ -90,7 +90,7 @@ def read_commit_dag(branch):
     for line in Run('git-show-ref').output_lines():
         id, ref =3D line.split()
         m =3D re.match(r'^refs/patches/%s/(.+)$' % branch, ref)
-        if m:
+        if m and not m.group(1).endswith('.log'):
             c =3D commits[id]
             c.patch =3D m.group(1)
             patches.add(c)
@@ -173,17 +173,25 @@ def func(parser, options, args):
=20
     # Write the applied/unapplied files.
     out.start('Checking patch appliedness')
+    unapplied =3D patches - set(applied)
     applied_name_set =3D set(p.patch for p in applied)
-    unapplied_names =3D []
-    for name in orig_applied:
-        if not name in applied_name_set:
-            out.info('%s is now unapplied' % name)
-            unapplied_names.append(name)
-    for name in orig_unapplied:
-        if name in applied_name_set:
-            out.info('%s is now applied' % name)
-        else:
-            unapplied_names.append(name)
+    unapplied_name_set =3D set(p.patch for p in unapplied)
+    patches_name_set =3D set(p.patch for p in patches)
+    orig_patches =3D orig_applied + orig_unapplied
+    orig_applied_name_set =3D set(orig_applied)
+    orig_unapplied_name_set =3D set(orig_unapplied)
+    orig_patches_name_set =3D set(orig_patches)
+    for name in orig_patches_name_set - patches_name_set:
+        out.info('%s is gone' % name)
+    for name in applied_name_set - orig_applied_name_set:
+        out.info('%s is now applied' % name)
+    for name in unapplied_name_set - orig_unapplied_name_set:
+        out.info('%s is now unapplied' % name)
+    orig_order =3D dict(zip(orig_patches, xrange(len(orig_patches))))
+    def patchname_cmp(p1, p2):
+        i1 =3D orig_order.get(p1, len(orig_order))
+        i2 =3D orig_order.get(p2, len(orig_order))
+        return cmp((i1, p1), (i2, p2))
     crt_series.set_applied(p.patch for p in applied)
-    crt_series.set_unapplied(unapplied_names)
+    crt_series.set_unapplied(sorted(unapplied_name_set, cmp =3D patchn=
ame_cmp))
     out.done()
