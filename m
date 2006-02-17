From: Karl =?ISO-8859-1?Q?=20Hasselstr=F6m?= <kha@treskal.com>
Subject: [PATCH 2/2] Add 'stg uncommit' command
Date: Fri, 17 Feb 2006 05:31:29 +0100
Message-ID: <20060217043128.14175.60168.stgit@backpacker.hemma.treskal.com>
References: <20060217042728.14175.39928.stgit@backpacker.hemma.treskal.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 05:31:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9xHK-0000Kk-S1
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 05:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWBQEbb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 23:31:31 -0500
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWBQEbb
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 23:31:31 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:42384 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1751360AbWBQEba (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 23:31:30 -0500
Received: from backpacker.hemma.treskal.com ([83.227.180.148] [83.227.180.148])
          by mxfep02.bredband.com with ESMTP
          id <20060217043129.TBHP2008.mxfep02.bredband.com@backpacker.hemma.treskal.com>;
          Fri, 17 Feb 2006 05:31:29 +0100
Received: from backpacker.hemma.treskal.com (localhost.localdomain [127.0.0.1])
	by backpacker.hemma.treskal.com (Postfix) with ESMTP id 12D0B16BE;
	Fri, 17 Feb 2006 05:31:29 +0100 (CET)
To: Catalin Marinas <catalin.marinas@arm.com>
In-Reply-To: <20060217042728.14175.39928.stgit@backpacker.hemma.treskal.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16328>

Add an uncommit command, which is exactly the opposite of 'stg
commit'.

Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>

---

 stgit/commands/commit.py   |    5 ++-
 stgit/commands/uncommit.py |   80 ++++++++++++++++++++++++++++++++++++=
++++++++
 stgit/main.py              |    2 +
 stgit/stack.py             |   12 +++++--
 4 files changed, 94 insertions(+), 5 deletions(-)

diff --git a/stgit/commands/commit.py b/stgit/commands/commit.py
index a3b7277..ed9a0b3 100644
--- a/stgit/commands/commit.py
+++ b/stgit/commands/commit.py
@@ -28,8 +28,9 @@ usage =3D """%prog [options]
 Merge the applied patches into the base of the current stack and
 remove them from the series while advancing the base.
=20
-Use this command only if you want to permanently store the applied
-patches and no longer manage them with StGIT."""
+Use this command if you want to permanently store the applied patches
+and no longer manage them with StGIT. If you should change your mind
+later, use 'stg uncommit'."""
=20
 options =3D []
=20
diff --git a/stgit/commands/uncommit.py b/stgit/commands/uncommit.py
new file mode 100644
index 0000000..4ac0dfb
--- /dev/null
+++ b/stgit/commands/uncommit.py
@@ -0,0 +1,80 @@
+__copyright__ =3D """
+Copyright (C) 2006, Catalin Marinas <catalin.marinas@gmail.com>
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License version 2 as
+published by the Free Software Foundation.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program; if not, write to the Free Software
+Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 US=
A
+"""
+
+import sys, os
+from optparse import OptionParser, make_option
+
+from stgit.commands.common import *
+from stgit.utils import *
+from stgit import stack, git
+
+help =3D 'turn regular git commits into StGIT patches'
+usage =3D """%prog [options] <patchname1> [<patchname2> ... ]
+
+Takes one or more git commits at the base of the current stack, and
+turns them into StGIT patches. These new patches are alreay applied,
+at the bottom of the stack. This is the exact opposite of 'stg
+commit'.
+
+You can either give one patch name for each commit you wish to
+uncommit, or use the --number option and exactly one patch name; StGIT
+will then create numbered patches with the given patch name as prefix.
+
+Only commits with exactly one parent can be uncommitted; in other
+words, you can't uncommmit a merge."""
+
+options =3D [make_option('-n', '--number', type =3D 'int',
+                       help =3D 'uncommit the specified number of comm=
its')]
+
+def func(parser, options, args):
+    if len(args) =3D=3D 0:
+        parser.error('you must specify at least one patch name')
+    if options.number:
+        if len(args) !=3D 1:
+            parser.error('when using --number, specify exactly one pat=
ch name')
+        patchnames =3D ['%s%d' % (args[0], i)
+                      for i in xrange(options.number - 1, -1, -1)]
+    else:
+        patchnames =3D args
+
+    if crt_series.get_protected():
+        raise CmdException, 'This branch is protected. Uncommit is not=
 permitted'
+
+    print 'Uncommitting %d patches...' % len(patchnames),
+    sys.stdout.flush()
+
+    for patchname in patchnames:
+        base_file =3D crt_series.get_base_file()
+        commit_id =3D read_string(base_file)
+        commit =3D git.Commit(commit_id)
+        try:
+            parent, =3D commit.get_parents()
+        except ValueError:
+            raise CmdException, ('Commit %s does not have exactly one =
parent'
+                                 % commit_id)
+        author_name, author_email, author_date =3D name_email_date(
+            commit.get_author())
+        crt_series.new_patch(patchname,
+                             can_edit =3D False, before_existing =3D T=
rue,
+                             top =3D commit_id, bottom =3D parent,
+                             message =3D commit.get_log(),
+                             author_name =3D author_name,
+                             author_email =3D author_email,
+                             author_date =3D author_date)
+        write_string(base_file, parent)
+
+    print 'done'
diff --git a/stgit/main.py b/stgit/main.py
index 6d86ee4..4a48668 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -57,6 +57,7 @@ import stgit.commands.series
 import stgit.commands.status
 import stgit.commands.top
 import stgit.commands.unapplied
+import stgit.commands.uncommit
=20
=20
 #
@@ -92,6 +93,7 @@ commands =3D {
     'status':   stgit.commands.status,
     'top':      stgit.commands.top,
     'unapplied':stgit.commands.unapplied,
+    'uncommit': stgit.commands.uncommit,
     }
=20
 def print_help():
diff --git a/stgit/stack.py b/stgit/stack.py
index bc39d14..05389bb 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -621,7 +621,8 @@ class Series:
                   unapplied =3D False, show_patch =3D False,
                   top =3D None, bottom =3D None,
                   author_name =3D None, author_email =3D None, author_=
date =3D None,
-                  committer_name =3D None, committer_email =3D None):
+                  committer_name =3D None, committer_email =3D None,
+                  before_existing =3D False):
         """Creates a new patch
         """
         if self.__patch_applied(name) or self.__patch_unapplied(name):
@@ -664,8 +665,13 @@ class Series:
             f.writelines([line + '\n' for line in patches])
             f.close()
         else:
-            append_string(self.__applied_file, patch.get_name())
-            self.__set_current(name)
+            if before_existing:
+                insert_string(self.__applied_file, patch.get_name())
+                if not self.get_current():
+                    self.__set_current(name)
+            else:
+                append_string(self.__applied_file, patch.get_name())
+                self.__set_current(name)
=20
     def delete_patch(self, name):
         """Deletes a patch
