From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 06/10] Let "stg applied" and "stg unapplied" use the new
	infrastructure
Date: Sun, 25 Nov 2007 21:51:34 +0100
Message-ID: <20071125205134.7823.74925.stgit@yoghurt>
References: <20071125203717.7823.70046.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 21:52:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwOSP-0003hQ-Uw
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 21:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756653AbXKYUvj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Nov 2007 15:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756645AbXKYUvj
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 15:51:39 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3571 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756637AbXKYUvi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 15:51:38 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IwORy-0007ag-00; Sun, 25 Nov 2007 20:51:34 +0000
In-Reply-To: <20071125203717.7823.70046.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65994>

This is a trivial change since these commands are so simple, but
because these are the commands used by t4000-upgrade, we now test that
the new infrastructure can upgrade old stacks.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/applied.py   |   27 +++++++++++++--------------
 stgit/commands/unapplied.py |   23 +++++++++++------------
 2 files changed, 24 insertions(+), 26 deletions(-)


diff --git a/stgit/commands/applied.py b/stgit/commands/applied.py
index 45d0926..522425b 100644
--- a/stgit/commands/applied.py
+++ b/stgit/commands/applied.py
@@ -16,25 +16,21 @@ along with this program; if not, write to the Free =
Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 US=
A
 """
=20
-import sys, os
-from optparse import OptionParser, make_option
-
-from stgit.commands.common import *
-from stgit.utils import *
+from optparse import make_option
 from stgit.out import *
-from stgit import stack, git
+from stgit.commands import common
=20
=20
 help =3D 'print the applied patches'
 usage =3D """%prog [options]
=20
-List the patches from the series which were already pushed onto the
-stack.  They are listed in the order in which they were pushed, the
+List the patches from the series which have already been pushed onto
+the stack. They are listed in the order in which they were pushed, the
 last one being the current (topmost) patch."""
=20
-directory =3D DirectoryHasRepository()
+directory =3D common.DirectoryHasRepositoryLib()
 options =3D [make_option('-b', '--branch',
-                       help =3D 'use BRANCH instead of the default one=
'),
+                       help =3D 'use BRANCH instead of the default bra=
nch'),
            make_option('-c', '--count',
                        help =3D 'print the number of applied patches',
                        action =3D 'store_true')]
@@ -46,10 +42,13 @@ def func(parser, options, args):
     if len(args) !=3D 0:
         parser.error('incorrect number of arguments')
=20
-    applied =3D crt_series.get_applied()
+    if options.branch:
+        s =3D directory.repository.get_stack(options.branch)
+    else:
+        s =3D directory.repository.current_stack
=20
     if options.count:
-        out.stdout(len(applied))
+        out.stdout(len(s.patchorder.applied))
     else:
-        for p in applied:
-            out.stdout(p)
+        for pn in s.patchorder.applied:
+            out.stdout(pn)
diff --git a/stgit/commands/unapplied.py b/stgit/commands/unapplied.py
index d5bb43e..7702207 100644
--- a/stgit/commands/unapplied.py
+++ b/stgit/commands/unapplied.py
@@ -16,13 +16,9 @@ along with this program; if not, write to the Free S=
oftware
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 US=
A
 """
=20
-import sys, os
-from optparse import OptionParser, make_option
-
-from stgit.commands.common import *
-from stgit.utils import *
+from optparse import make_option
 from stgit.out import *
-from stgit import stack, git
+from stgit.commands import common
=20
=20
 help =3D 'print the unapplied patches'
@@ -31,9 +27,9 @@ usage =3D """%prog [options]
 List the patches from the series which are not pushed onto the stack.
 They are listed in the reverse order in which they were popped."""
=20
-directory =3D DirectoryHasRepository()
+directory =3D common.DirectoryHasRepositoryLib()
 options =3D [make_option('-b', '--branch',
-                       help =3D 'use BRANCH instead of the default one=
'),
+                       help =3D 'use BRANCH instead of the default bra=
nch'),
            make_option('-c', '--count',
                        help =3D 'print the number of unapplied patches=
',
                        action =3D 'store_true')]
@@ -45,10 +41,13 @@ def func(parser, options, args):
     if len(args) !=3D 0:
         parser.error('incorrect number of arguments')
=20
-    unapplied =3D crt_series.get_unapplied()
+    if options.branch:
+        s =3D directory.repository.get_stack(options.branch)
+    else:
+        s =3D directory.repository.current_stack
=20
     if options.count:
-        out.stdout(len(unapplied))
+        out.stdout(len(s.patchorder.unapplied))
     else:
-        for p in unapplied:
-            out.stdout(p)
+        for pn in s.patchorder.unapplied:
+            out.stdout(pn)
