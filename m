From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 1/4] Refactor output handling to break circular
	dependency
Date: Sun, 26 Aug 2007 22:33:27 +0200
Message-ID: <20070826203327.16265.62636.stgit@yoghurt>
References: <20070826202724.16265.85821.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 22:33:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPOo1-00083X-Va
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 22:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244AbXHZUd4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 26 Aug 2007 16:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754126AbXHZUdz
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 16:33:55 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4755 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754102AbXHZUdc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 16:33:32 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IPOnY-0005vW-00; Sun, 26 Aug 2007 21:33:28 +0100
In-Reply-To: <20070826202724.16265.85821.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56718>

I ran into problems when trying to use the fancy output handling in a
new module that was (recursively) imported by stgit.util -- I couldn't
use the out object because it wasn't defined yet.

Break out the output handler to its own module to break the circular
dependency.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/applied.py    |    1=20
 stgit/commands/assimilate.py |    1=20
 stgit/commands/branch.py     |    1=20
 stgit/commands/clean.py      |    1=20
 stgit/commands/commit.py     |    1=20
 stgit/commands/common.py     |    1=20
 stgit/commands/delete.py     |    1=20
 stgit/commands/diff.py       |    1=20
 stgit/commands/export.py     |    1=20
 stgit/commands/files.py      |    1=20
 stgit/commands/fold.py       |    1=20
 stgit/commands/hide.py       |    1=20
 stgit/commands/id.py         |    1=20
 stgit/commands/imprt.py      |    1=20
 stgit/commands/log.py        |    1=20
 stgit/commands/mail.py       |    1=20
 stgit/commands/patches.py    |    1=20
 stgit/commands/pick.py       |    1=20
 stgit/commands/pull.py       |    1=20
 stgit/commands/push.py       |    1=20
 stgit/commands/refresh.py    |    1=20
 stgit/commands/rename.py     |    1=20
 stgit/commands/series.py     |    1=20
 stgit/commands/sync.py       |    1=20
 stgit/commands/top.py        |    1=20
 stgit/commands/unapplied.py  |    1=20
 stgit/commands/uncommit.py   |    1=20
 stgit/commands/unhide.py     |    1=20
 stgit/git.py                 |    1=20
 stgit/gitmergeonefile.py     |    3 +
 stgit/main.py                |    2 -
 stgit/out.py                 |  100 ++++++++++++++++++++++++++++++++++=
++++++++
 stgit/stack.py               |    1=20
 stgit/utils.py               |   81 ----------------------------------
 34 files changed, 134 insertions(+), 82 deletions(-)

diff --git a/stgit/commands/applied.py b/stgit/commands/applied.py
index 0925de0..b9bb716 100644
--- a/stgit/commands/applied.py
+++ b/stgit/commands/applied.py
@@ -21,6 +21,7 @@ from optparse import OptionParser, make_option
=20
 from stgit.commands.common import *
 from stgit.utils import *
+from stgit.out import *
 from stgit import stack, git
=20
=20
diff --git a/stgit/commands/assimilate.py b/stgit/commands/assimilate.p=
y
index 5134e34..c5f4340 100644
--- a/stgit/commands/assimilate.py
+++ b/stgit/commands/assimilate.py
@@ -22,6 +22,7 @@ from optparse import OptionParser, make_option
=20
 from stgit.commands.common import *
 from stgit.utils import *
+from stgit.out import *
 from stgit import stack, git
=20
 help =3D 'StGIT-ify any GIT commits made on top of your StGIT stack'
diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index 75a9046..2d491d5 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -23,6 +23,7 @@ from optparse import OptionParser, make_option
=20
 from stgit.commands.common import *
 from stgit.utils import *
+from stgit.out import *
 from stgit import stack, git, basedir
=20
=20
diff --git a/stgit/commands/clean.py b/stgit/commands/clean.py
index 7b57526..2e3b202 100644
--- a/stgit/commands/clean.py
+++ b/stgit/commands/clean.py
@@ -20,6 +20,7 @@ from optparse import OptionParser, make_option
=20
 from stgit.commands.common import *
 from stgit.utils import *
+from stgit.out import *
 from stgit import stack, git
=20
=20
diff --git a/stgit/commands/commit.py b/stgit/commands/commit.py
index 2b8d7ce..0b76c56 100644
--- a/stgit/commands/commit.py
+++ b/stgit/commands/commit.py
@@ -20,6 +20,7 @@ from optparse import OptionParser, make_option
=20
 from stgit.commands.common import *
 from stgit.utils import *
+from stgit.out import *
 from stgit import stack, git
=20
 help =3D 'permanently store the applied patches into stack base'
diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index dddee85..f3fa89d 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -22,6 +22,7 @@ import sys, os, os.path, re
 from optparse import OptionParser, make_option
=20
 from stgit.utils import *
+from stgit.out import *
 from stgit import stack, git, basedir
 from stgit.config import config, file_extensions
=20
diff --git a/stgit/commands/delete.py b/stgit/commands/delete.py
index a9e2744..2121015 100644
--- a/stgit/commands/delete.py
+++ b/stgit/commands/delete.py
@@ -21,6 +21,7 @@ from optparse import OptionParser, make_option
=20
 from stgit.commands.common import *
 from stgit.utils import *
+from stgit.out import *
 from stgit import stack, git
=20
=20
diff --git a/stgit/commands/diff.py b/stgit/commands/diff.py
index f8b19f8..aeca4ab 100644
--- a/stgit/commands/diff.py
+++ b/stgit/commands/diff.py
@@ -22,6 +22,7 @@ from pydoc import pager
=20
 from stgit.commands.common import *
 from stgit.utils import *
+from stgit.out import *
 from stgit import stack, git
=20
=20
diff --git a/stgit/commands/export.py b/stgit/commands/export.py
index 8424f9d..5ca07d3 100644
--- a/stgit/commands/export.py
+++ b/stgit/commands/export.py
@@ -23,6 +23,7 @@ from optparse import OptionParser, make_option
=20
 from stgit.commands.common import *
 from stgit.utils import *
+from stgit.out import *
 from stgit import stack, git, templates
=20
=20
diff --git a/stgit/commands/files.py b/stgit/commands/files.py
index 659a82b..1a10023 100644
--- a/stgit/commands/files.py
+++ b/stgit/commands/files.py
@@ -21,6 +21,7 @@ from optparse import OptionParser, make_option
=20
 from stgit.commands.common import *
 from stgit.utils import *
+from stgit.out import *
 from stgit import stack, git
=20
=20
diff --git a/stgit/commands/fold.py b/stgit/commands/fold.py
index 297dfbf..d97185e 100644
--- a/stgit/commands/fold.py
+++ b/stgit/commands/fold.py
@@ -20,6 +20,7 @@ from optparse import OptionParser, make_option
=20
 from stgit.commands.common import *
 from stgit.utils import *
+from stgit.out import *
 from stgit import stack, git
=20
=20
diff --git a/stgit/commands/hide.py b/stgit/commands/hide.py
index 39cbd67..de19c19 100644
--- a/stgit/commands/hide.py
+++ b/stgit/commands/hide.py
@@ -20,6 +20,7 @@ from optparse import OptionParser, make_option
=20
 from stgit.commands.common import *
 from stgit.utils import *
+from stgit.out import *
 from stgit import stack, git
=20
=20
diff --git a/stgit/commands/id.py b/stgit/commands/id.py
index 8c717e8..f72d2f3 100644
--- a/stgit/commands/id.py
+++ b/stgit/commands/id.py
@@ -20,6 +20,7 @@ from optparse import OptionParser, make_option
=20
 from stgit.commands.common import *
 from stgit.utils import *
+from stgit.out import *
 from stgit import stack, git
=20
=20
diff --git a/stgit/commands/imprt.py b/stgit/commands/imprt.py
index 98fe708..57bf2c8 100644
--- a/stgit/commands/imprt.py
+++ b/stgit/commands/imprt.py
@@ -23,6 +23,7 @@ from optparse import OptionParser, make_option
=20
 from stgit.commands.common import *
 from stgit.utils import *
+from stgit.out import *
 from stgit import stack, git
=20
=20
diff --git a/stgit/commands/log.py b/stgit/commands/log.py
index ebd8cab..4d6b022 100644
--- a/stgit/commands/log.py
+++ b/stgit/commands/log.py
@@ -20,6 +20,7 @@ from optparse import OptionParser, make_option
 from pydoc import pager
 from stgit.commands.common import *
 from stgit import stack, git
+from stgit.out import *
=20
 help =3D 'display the patch changelog'
 usage =3D """%prog [options] [patch]
diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 71a6e4e..6202fc5 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -21,6 +21,7 @@ from optparse import OptionParser, make_option
=20
 from stgit.commands.common import *
 from stgit.utils import *
+from stgit.out import *
 from stgit import stack, git, version, templates
 from stgit.config import config
=20
diff --git a/stgit/commands/patches.py b/stgit/commands/patches.py
index 23b3aa7..b3defb6 100644
--- a/stgit/commands/patches.py
+++ b/stgit/commands/patches.py
@@ -21,6 +21,7 @@ from pydoc import pager
=20
 from stgit.commands.common import *
 from stgit.utils import *
+from stgit.out import *
 from stgit import stack, git
=20
=20
diff --git a/stgit/commands/pick.py b/stgit/commands/pick.py
index 27fdf9c..1c3ef11 100644
--- a/stgit/commands/pick.py
+++ b/stgit/commands/pick.py
@@ -20,6 +20,7 @@ from optparse import OptionParser, make_option
=20
 from stgit.commands.common import *
 from stgit.utils import *
+from stgit.out import *
 from stgit import stack, git
 from stgit.stack import Series
=20
diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index fe3b67d..ad485a5 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -20,6 +20,7 @@ from optparse import OptionParser, make_option
=20
 from stgit.commands.common import *
 from stgit.utils import *
+from stgit.out import *
 from stgit.config import GitConfigException
 from stgit import stack, git
=20
diff --git a/stgit/commands/push.py b/stgit/commands/push.py
index 17b32f6..53cdb8f 100644
--- a/stgit/commands/push.py
+++ b/stgit/commands/push.py
@@ -21,6 +21,7 @@ from optparse import OptionParser, make_option
=20
 from stgit.commands.common import *
 from stgit.utils import *
+from stgit.out import *
 from stgit import stack, git
=20
=20
diff --git a/stgit/commands/refresh.py b/stgit/commands/refresh.py
index 8277388..218075b 100644
--- a/stgit/commands/refresh.py
+++ b/stgit/commands/refresh.py
@@ -21,6 +21,7 @@ from optparse import OptionParser, make_option
=20
 from stgit.commands.common import *
 from stgit.utils import *
+from stgit.out import *
 from stgit import stack, git
 from stgit.config import config
=20
diff --git a/stgit/commands/rename.py b/stgit/commands/rename.py
index d6c53be..2830e72 100644
--- a/stgit/commands/rename.py
+++ b/stgit/commands/rename.py
@@ -20,6 +20,7 @@ from optparse import OptionParser, make_option
=20
 from stgit.commands.common import *
 from stgit.utils import *
+from stgit.out import *
 from stgit import stack, git
=20
=20
diff --git a/stgit/commands/series.py b/stgit/commands/series.py
index 9e0b0ff..00a3372 100644
--- a/stgit/commands/series.py
+++ b/stgit/commands/series.py
@@ -22,6 +22,7 @@ from optparse import OptionParser, make_option
 import stgit.commands.common
 from stgit.commands.common import *
 from stgit.utils import *
+from stgit.out import *
 from stgit import stack, git
=20
=20
diff --git a/stgit/commands/sync.py b/stgit/commands/sync.py
index 5e33324..580b5bd 100644
--- a/stgit/commands/sync.py
+++ b/stgit/commands/sync.py
@@ -21,6 +21,7 @@ from optparse import OptionParser, make_option
 import stgit.commands.common
 from stgit.commands.common import *
 from stgit.utils import *
+from stgit.out import *
 from stgit import stack, git
=20
=20
diff --git a/stgit/commands/top.py b/stgit/commands/top.py
index 7cc92ca..1a9267a 100644
--- a/stgit/commands/top.py
+++ b/stgit/commands/top.py
@@ -21,6 +21,7 @@ from optparse import OptionParser, make_option
=20
 from stgit.commands.common import *
 from stgit.utils import *
+from stgit.out import *
 from stgit import stack, git
=20
=20
diff --git a/stgit/commands/unapplied.py b/stgit/commands/unapplied.py
index 0d330a1..c6408a3 100644
--- a/stgit/commands/unapplied.py
+++ b/stgit/commands/unapplied.py
@@ -21,6 +21,7 @@ from optparse import OptionParser, make_option
=20
 from stgit.commands.common import *
 from stgit.utils import *
+from stgit.out import *
 from stgit import stack, git
=20
=20
diff --git a/stgit/commands/uncommit.py b/stgit/commands/uncommit.py
index f611d29..e3bf0d8 100644
--- a/stgit/commands/uncommit.py
+++ b/stgit/commands/uncommit.py
@@ -22,6 +22,7 @@ from optparse import OptionParser, make_option
=20
 from stgit.commands.common import *
 from stgit.utils import *
+from stgit.out import *
 from stgit import stack, git
=20
 help =3D 'turn regular GIT commits into StGIT patches'
diff --git a/stgit/commands/unhide.py b/stgit/commands/unhide.py
index b6a2297..0a1dcaf 100644
--- a/stgit/commands/unhide.py
+++ b/stgit/commands/unhide.py
@@ -20,6 +20,7 @@ from optparse import OptionParser, make_option
=20
 from stgit.commands.common import *
 from stgit.utils import *
+from stgit.out import *
 from stgit import stack, git
=20
=20
diff --git a/stgit/git.py b/stgit/git.py
index 14b4c81..827bd61 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -23,6 +23,7 @@ from shutil import copyfile
=20
 from stgit import basedir
 from stgit.utils import *
+from stgit.out import *
 from stgit.config import config
 from sets import Set
=20
diff --git a/stgit/gitmergeonefile.py b/stgit/gitmergeonefile.py
index 5e51b8a..e76f9b1 100644
--- a/stgit/gitmergeonefile.py
+++ b/stgit/gitmergeonefile.py
@@ -21,7 +21,8 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston,=
 MA 02111-1307 USA
 import sys, os
 from stgit import basedir
 from stgit.config import config, file_extensions, ConfigOption
-from stgit.utils import append_string, out
+from stgit.utils import append_string
+from stgit.out import *
=20
=20
 class GitMergeException(Exception):
diff --git a/stgit/main.py b/stgit/main.py
index 2390110..5b9d7c4 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -22,7 +22,7 @@ import sys, os
 from optparse import OptionParser
=20
 import stgit.commands
-from stgit.utils import out
+from stgit.out import *
=20
 #
 # The commands map
diff --git a/stgit/out.py b/stgit/out.py
new file mode 100644
index 0000000..f80daf2
--- /dev/null
+++ b/stgit/out.py
@@ -0,0 +1,100 @@
+# -*- coding: utf-8 -*-
+
+__copyright__ =3D """
+Copyright (C) 2007, Karl Hasselstr=C3=B6m <kha@treskal.com>
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
+import sys
+
+class MessagePrinter(object):
+    def __init__(self):
+        class Output(object):
+            def __init__(self, write, flush):
+                self.write =3D write
+                self.flush =3D flush
+                self.at_start_of_line =3D True
+                self.level =3D 0
+            def new_line(self):
+                """Ensure that we're at the beginning of a line."""
+                if not self.at_start_of_line:
+                    self.write('\n')
+                    self.at_start_of_line =3D True
+            def single_line(self, msg, print_newline =3D True,
+                            need_newline =3D True):
+                """Write a single line. Newline before and after are
+                separately configurable."""
+                if need_newline:
+                    self.new_line()
+                if self.at_start_of_line:
+                    self.write('  '*self.level)
+                self.write(msg)
+                if print_newline:
+                    self.write('\n')
+                    self.at_start_of_line =3D True
+                else:
+                    self.flush()
+                    self.at_start_of_line =3D False
+            def tagged_lines(self, tag, lines):
+                tag +=3D ': '
+                for line in lines:
+                    self.single_line(tag + line)
+                    tag =3D ' '*len(tag)
+            def write_line(self, line):
+                """Write one line of text on a lines of its own, not
+                indented."""
+                self.new_line()
+                self.write('%s\n' % line)
+                self.at_start_of_line =3D True
+            def write_raw(self, string):
+                """Write an arbitrary string, possibly containing
+                newlines."""
+                self.new_line()
+                self.write(string)
+                self.at_start_of_line =3D string.endswith('\n')
+        self.__stdout =3D Output(sys.stdout.write, sys.stdout.flush)
+        if sys.stdout.isatty():
+            self.__out =3D self.__stdout
+        else:
+            self.__out =3D Output(lambda msg: None, lambda: None)
+    def stdout(self, line):
+        """Write a line to stdout."""
+        self.__stdout.write_line(line)
+    def stdout_raw(self, string):
+        """Write a string possibly containing newlines to stdout."""
+        self.__stdout.write_raw(string)
+    def info(self, *msgs):
+        for msg in msgs:
+            self.__out.single_line(msg)
+    def note(self, *msgs):
+        self.__out.tagged_lines('Notice', msgs)
+    def warn(self, *msgs):
+        self.__out.tagged_lines('Warning', msgs)
+    def error(self, *msgs):
+        self.__out.tagged_lines('Error', msgs)
+    def start(self, msg):
+        """Start a long-running operation."""
+        self.__out.single_line('%s ... ' % msg, print_newline =3D Fals=
e)
+        self.__out.level +=3D 1
+    def done(self, extramsg =3D None):
+        """Finish long-running operation."""
+        self.__out.level -=3D 1
+        if extramsg:
+            msg =3D 'done (%s)' % extramsg
+        else:
+            msg =3D 'done'
+        self.__out.single_line(msg, need_newline =3D False)
+
+out =3D MessagePrinter()
diff --git a/stgit/stack.py b/stgit/stack.py
index 1ab10c5..12c5091 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -21,6 +21,7 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston,=
 MA 02111-1307 USA
 import sys, os, re
=20
 from stgit.utils import *
+from stgit.out import *
 from stgit import git, basedir, templates
 from stgit.config import config
 from shutil import copyfile
diff --git a/stgit/utils.py b/stgit/utils.py
index 039b433..38dd474 100644
--- a/stgit/utils.py
+++ b/stgit/utils.py
@@ -3,6 +3,7 @@
=20
 import errno, os, os.path, re, sys
 from stgit.config import config
+from stgit.out import *
=20
 __copyright__ =3D """
 Copyright (C) 2005, Catalin Marinas <catalin.marinas@gmail.com>
@@ -21,86 +22,6 @@ along with this program; if not, write to the Free S=
oftware
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 US=
A
 """
=20
-class MessagePrinter(object):
-    def __init__(self):
-        class Output(object):
-            def __init__(self, write, flush):
-                self.write =3D write
-                self.flush =3D flush
-                self.at_start_of_line =3D True
-                self.level =3D 0
-            def new_line(self):
-                """Ensure that we're at the beginning of a line."""
-                if not self.at_start_of_line:
-                    self.write('\n')
-                    self.at_start_of_line =3D True
-            def single_line(self, msg, print_newline =3D True,
-                            need_newline =3D True):
-                """Write a single line. Newline before and after are
-                separately configurable."""
-                if need_newline:
-                    self.new_line()
-                if self.at_start_of_line:
-                    self.write('  '*self.level)
-                self.write(msg)
-                if print_newline:
-                    self.write('\n')
-                    self.at_start_of_line =3D True
-                else:
-                    self.flush()
-                    self.at_start_of_line =3D False
-            def tagged_lines(self, tag, lines):
-                tag +=3D ': '
-                for line in lines:
-                    self.single_line(tag + line)
-                    tag =3D ' '*len(tag)
-            def write_line(self, line):
-                """Write one line of text on a lines of its own, not
-                indented."""
-                self.new_line()
-                self.write('%s\n' % line)
-                self.at_start_of_line =3D True
-            def write_raw(self, string):
-                """Write an arbitrary string, possibly containing
-                newlines."""
-                self.new_line()
-                self.write(string)
-                self.at_start_of_line =3D string.endswith('\n')
-        self.__stdout =3D Output(sys.stdout.write, sys.stdout.flush)
-        if sys.stdout.isatty():
-            self.__out =3D self.__stdout
-        else:
-            self.__out =3D Output(lambda msg: None, lambda: None)
-    def stdout(self, line):
-        """Write a line to stdout."""
-        self.__stdout.write_line(line)
-    def stdout_raw(self, string):
-        """Write a string possibly containing newlines to stdout."""
-        self.__stdout.write_raw(string)
-    def info(self, *msgs):
-        for msg in msgs:
-            self.__out.single_line(msg)
-    def note(self, *msgs):
-        self.__out.tagged_lines('Notice', msgs)
-    def warn(self, *msgs):
-        self.__out.tagged_lines('Warning', msgs)
-    def error(self, *msgs):
-        self.__out.tagged_lines('Error', msgs)
-    def start(self, msg):
-        """Start a long-running operation."""
-        self.__out.single_line('%s ... ' % msg, print_newline =3D Fals=
e)
-        self.__out.level +=3D 1
-    def done(self, extramsg =3D None):
-        """Finish long-running operation."""
-        self.__out.level -=3D 1
-        if extramsg:
-            msg =3D 'done (%s)' % extramsg
-        else:
-            msg =3D 'done'
-        self.__out.single_line(msg, need_newline =3D False)
-
-out =3D MessagePrinter()
-
 def mkdir_file(filename, mode):
     """Opens filename with the given mode, creating the directory it's
     in if it doesn't already exist."""
