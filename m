From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 3/3] Generate command lists automatically
Date: Mon, 08 Sep 2008 23:08:11 +0200
Message-ID: <20080908210811.1957.16419.stgit@yoghurt>
References: <20080908210302.1957.44280.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 23:09:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcnzO-000063-LZ
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 23:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098AbYIHVI3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Sep 2008 17:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754154AbYIHVI3
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 17:08:29 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1927 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754081AbYIHVI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 17:08:26 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KcoJX-0003dO-00; Mon, 08 Sep 2008 22:30:27 +0100
In-Reply-To: <20080908210302.1957.44280.stgit@yoghurt>
User-Agent: StGIT/0.14.3.236.g0c611
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95304>

Instead of hard-coding the list of stg subcommands everywhere,
generate them automatically. That way, they never get outdated (like
the list in stg.txt).

In order to not make StGit slower, we cache the list of commands; run
"make build" to update that cache (other make targets, such as "all"
and "test", imply "build"). If the cache doesn't exist, the code falls
back to importing all the command modules, which adds quite a bit of
overhead to each stg command (about 100 ms on my laptop).

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 Documentation/Makefile      |    9 ++-
 Documentation/asciidoc.conf |   17 +++++
 Documentation/stg.txt       |  136 -----------------------------------=
--------
 Makefile                    |   18 ++++--
 stg-build                   |   15 ++++-
 stgit/commands/.gitignore   |    1=20
 stgit/commands/__init__.py  |   78 +++++++++++++++++++++++++
 stgit/commands/branch.py    |    1=20
 stgit/commands/clean.py     |    1=20
 stgit/commands/clone.py     |    1=20
 stgit/commands/coalesce.py  |    1=20
 stgit/commands/commit.py    |    1=20
 stgit/commands/delete.py    |    1=20
 stgit/commands/diff.py      |    1=20
 stgit/commands/edit.py      |    1=20
 stgit/commands/export.py    |    1=20
 stgit/commands/files.py     |    1=20
 stgit/commands/float.py     |    1=20
 stgit/commands/fold.py      |    1=20
 stgit/commands/goto.py      |    1=20
 stgit/commands/hide.py      |    1=20
 stgit/commands/id.py        |    1=20
 stgit/commands/imprt.py     |    1=20
 stgit/commands/init.py      |    1=20
 stgit/commands/log.py       |    1=20
 stgit/commands/mail.py      |    1=20
 stgit/commands/new.py       |    1=20
 stgit/commands/patches.py   |    1=20
 stgit/commands/pick.py      |    1=20
 stgit/commands/pop.py       |    1=20
 stgit/commands/pull.py      |    1=20
 stgit/commands/push.py      |    1=20
 stgit/commands/rebase.py    |    1=20
 stgit/commands/refresh.py   |    1=20
 stgit/commands/rename.py    |    1=20
 stgit/commands/repair.py    |    1=20
 stgit/commands/resolved.py  |    1=20
 stgit/commands/series.py    |    1=20
 stgit/commands/show.py      |    1=20
 stgit/commands/sink.py      |    1=20
 stgit/commands/status.py    |    1=20
 stgit/commands/sync.py      |    1=20
 stgit/commands/top.py       |    1=20
 stgit/commands/uncommit.py  |    1=20
 stgit/commands/unhide.py    |    1=20
 stgit/main.py               |  129 ++---------------------------------=
------
 46 files changed, 173 insertions(+), 268 deletions(-)
 create mode 100644 stgit/commands/.gitignore


diff --git a/Documentation/Makefile b/Documentation/Makefile
index 1c14fe3..85e9600 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -60,11 +60,16 @@ doc.dep : $(wildcard *.txt) build-docdep.perl
 -include doc.dep
=20
 clean:
-	rm -f *.xml *.html *.pdf *.1 doc.dep $(COMMANDS_TXT)
+	rm -f *.xml *.html *.pdf *.1 doc.dep $(COMMANDS_TXT) stg-cmd-list.txt
=20
-$(COMMANDS_TXT): $(shell find .. -name '*.py')
+ALL_PY =3D $(shell find ../stgit -name '*.py')
+
+$(COMMANDS_TXT): $(ALL_PY)
 	../stg-build --asciidoc $(basename $(subst stg-,,$@)) > $@
=20
+stg-cmd-list.txt: $(ALL_PY)
+	../stg-build --cmd-list > $@
+
 %.html : %.txt
 	$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf $(ASCIIDOC_EXTRA) =
$<
=20
diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 69447ab..5f7a7af 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -84,3 +84,20 @@ ifdef::backend-xhtml11[]
 [stglink-inlinemacro]
 <a href=3D"stg-{target}.html">stg {target}</a>
 endif::backend-xhtml11[]
+
+## stgsublink: macro
+#
+# Usage: stgsublink:command[]
+#
+# Show StGit link as: <command> in man pages, stg <command> in
+# html.
+
+ifdef::backend-docbook[]
+[stgsublink-inlinemacro]
+{target}
+endif::backend-docbook[]
+
+ifdef::backend-xhtml11[]
+[stgsublink-inlinemacro]
+<a href=3D"stg-{target}.html">{target}</a>
+endif::backend-xhtml11[]
diff --git a/Documentation/stg.txt b/Documentation/stg.txt
index a0b2176..b4184b2 100644
--- a/Documentation/stg.txt
+++ b/Documentation/stg.txt
@@ -105,141 +105,7 @@ description is available in individual command ma=
npages.  Those
 manpages are named 'stg-<command>(1)'.
 endif::backend-docbook[]
=20
-Generic commands
-~~~~~~~~~~~~~~~~
-
-User-support commands not touching the repository.
-
-stg help::
-	stgdesc:help[]
-stg version::
-	stgdesc:version[]
-stg copyright::
-	stgdesc:copyright[]
-
-Repository commands
-~~~~~~~~~~~~~~~~~~~
-
-stglink:clone[]::
-	stgdesc:clone[]
-stglink:id[]::
-	stgdesc:id[]
-
-Stack commands
-~~~~~~~~~~~~~~
-
-Stack management
-^^^^^^^^^^^^^^^^
-
-stglink:branch[]::
-	stgdesc:branch[]
-stglink:init[]::
-	stgdesc:init[]
-stglink:clean[]::
-	stgdesc:clean[]
-stglink:pull[]::
-	stgdesc:pull[]
-stglink:rebase[]::
-	stgdesc:rebase[]
-
-stglink:commit[]::
-	stgdesc:commit[]
-stglink:uncommit[]::
-	stgdesc:uncommit[]
-stglink:repair[]::
-	stgdesc:repair[]
-
-Controlling what patches are applied
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-stglink:series[]::
-	stgdesc:series[]
-stglink:push[]::
-	stgdesc:push[]
-stglink:pop[]::
-	stgdesc:pop[]
-stglink:goto[]::
-	stgdesc:goto[]
-stglink:float[]::
-	stgdesc:float[]
-stglink:sink[]::
-	stgdesc:sink[]
-stglink:applied[]::
-	stgdesc:applied[]
-stglink:unapplied[]::
-	stgdesc:unapplied[]
-stglink:top[]::
-	stgdesc:top[]
-
-stglink:hide[]::
-	stgdesc:hide[]
-stglink:unhide[]::
-	stgdesc:unhide[]
-
-Miscellaneous stack commands
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-stglink:patches[]::
-	stgdesc:patches[]
-
-
-Patch commands
-~~~~~~~~~~~~~~
-
-Patch management
-^^^^^^^^^^^^^^^^
-
-stglink:new[]::
-	stgdesc:new[]
-stglink:delete[]::
-	stgdesc:delete[]
-stglink:rename[]::
-	stgdesc:rename[]
-stglink:log[]::
-	stgdesc:log[]
-
-Controlling patch contents
-^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-stglink:files[]::
-	stgdesc:files[]
-stglink:show[]::
-	stgdesc:show[]
-stglink:refresh[]::
-	stgdesc:refresh[]
-stglink:fold[]::
-	stgdesc:fold[]
-stglink:pick[]::
-	stgdesc:pick[]
-stglink:sync[]::
-	stgdesc:sync[]
-
-Interaction with the rest of the world
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-stglink:export[]::
-	stgdesc:export[]
-stglink:import[]::
-	stgdesc:import[]
-stglink:mail[]::
-	stgdesc:mail[]
-
-
-Working-copy commands
-~~~~~~~~~~~~~~~~~~~~~
-
-stglink:add[]::
-	stgdesc:add[]
-stglink:rm[]::
-	stgdesc:rm[]
-stglink:cp[]::
-	stgdesc:cp[]
-stglink:status[]::
-	stgdesc:status[]
-stglink:diff[]::
-	stgdesc:diff[]
-stglink:resolved[]::
-	stgdesc:resolved[]
+include::stg-cmd-list.txt[]
=20
 CONFIGURATION MECHANISM
 -----------------------
diff --git a/Makefile b/Makefile
index 9322fe0..288622a 100644
--- a/Makefile
+++ b/Makefile
@@ -4,10 +4,17 @@ PYTHON	?=3D python
=20
 TEST_PATCHES ?=3D ..
=20
-all:
+all: build
 	$(PYTHON) setup.py build
=20
-install:
+build: stgit/commands/cmdlist.py
+
+ALL_PY =3D $(shell find stgit -name '*.py')
+
+stgit/commands/cmdlist.py: $(ALL_PY)
+	$(PYTHON) stg-build --py-cmd-list > $@
+
+install: build
 	$(PYTHON) setup.py install --prefix=3D$(prefix) --root=3D$(DESTDIR) -=
-force
=20
 doc:
@@ -19,10 +26,10 @@ install-doc:
 install-html:
 	$(MAKE) -C Documentation install-html
=20
-test:
+test: build
 	cd t && $(MAKE) all
=20
-test_patches:
+test_patches: build
 	for patch in $$(stg series --noprefix $(TEST_PATCHES)); do \
 		stg goto $$patch && $(MAKE) test || break; \
 	done
@@ -35,8 +42,9 @@ clean:
 	rm -f stgit/*.pyc
 	rm -f stgit/commands/*.pyc
 	rm -f TAGS
+	rm -f stgit/commands/cmdlist.py
=20
 tags:
 	ctags -e -R stgit/*
=20
-.PHONY: all install doc install-doc install-html test test_patches cle=
an
+.PHONY: all build install doc install-doc install-html test test_patch=
es clean
diff --git a/stg-build b/stg-build
index 8c39a6f..3c9dbfa 100755
--- a/stg-build
+++ b/stg-build
@@ -2,7 +2,7 @@
 # -*- python -*-
 import optparse, sys
 import stgit.main
-from stgit import argparse
+from stgit import argparse, commands
=20
 def main():
     op =3D optparse.OptionParser()
@@ -10,6 +10,10 @@ def main():
                   help =3D 'Print asciidoc documentation for a command=
')
     op.add_option('--commands', action =3D 'store_true',
                   help =3D 'Print list of all stg subcommands')
+    op.add_option('--cmd-list', action =3D 'store_true',
+                  help =3D 'Print asciidoc command list')
+    op.add_option('--py-cmd-list', action =3D 'store_true',
+                  help =3D 'Write Python command list')
     options, args =3D op.parse_args()
     if args:
         op.error('Wrong number of arguments')
@@ -17,8 +21,15 @@ def main():
         argparse.write_asciidoc(stgit.main.commands[options.asciidoc],
                                 sys.stdout)
     elif options.commands:
-        for cmd in sorted(stgit.main.commands.iterkeys()):
+        for cmd in sorted(commands.get_commands(
+                allow_cached =3D False).iterkeys()):
             print cmd
+    elif options.cmd_list:
+        commands.asciidoc_command_list(
+            commands.get_commands(allow_cached =3D False), sys.stdout)
+    elif options.py_cmd_list:
+        commands.py_commands(commands.get_commands(allow_cached =3D Fa=
lse),
+                             sys.stdout)
     else:
         op.error('No command')
=20
diff --git a/stgit/commands/.gitignore b/stgit/commands/.gitignore
new file mode 100644
index 0000000..eff10ee
--- /dev/null
+++ b/stgit/commands/.gitignore
@@ -0,0 +1 @@
+/cmdlist.py
diff --git a/stgit/commands/__init__.py b/stgit/commands/__init__.py
index 4b03e3a..b8e1ba5 100644
--- a/stgit/commands/__init__.py
+++ b/stgit/commands/__init__.py
@@ -1,5 +1,8 @@
+# -*- coding: utf-8 -*-
+
 __copyright__ =3D """
 Copyright (C) 2005, Catalin Marinas <catalin.marinas@gmail.com>
+Copyright (C) 2008, Karl Hasselstr=C3=B6m <kha@treskal.com>
=20
 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License version 2 as
@@ -14,3 +17,78 @@ You should have received a copy of the GNU General P=
ublic License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 US=
A
 """
+
+import os
+from stgit import utils
+
+def get_command(mod):
+    """Import and return the given command module."""
+    return __import__(__name__ + '.' + mod, fromlist =3D ['*'])
+
+_kinds =3D [('repo', 'Repository commands'),
+          ('stack', 'Stack (branch) commands'),
+          ('patch', 'Patch commands'),
+          ('wc', 'Index/worktree commands')]
+_kind_order =3D [kind for kind, desc in _kinds]
+_kinds =3D dict(_kinds)
+
+def _find_commands():
+    for p in __path__:
+        for fn in os.listdir(p):
+            if not fn.endswith('.py'):
+                continue
+            mod =3D utils.strip_suffix('.py', fn)
+            m =3D get_command(mod)
+            if not hasattr(m, 'usage'):
+                continue
+            yield mod, m
+
+def get_commands(allow_cached =3D True):
+    """Return a map from command name to a tuple of module name, comma=
nd
+    type, and one-line command help."""
+    if allow_cached:
+        try:
+            from stgit.commands.cmdlist import command_list
+            return command_list
+        except ImportError:
+            # cmdlist.py doesn't exist, so do it the expensive way.
+            pass
+    return dict((getattr(m, 'name', mod), (mod, _kinds[m.kind], m.help=
))
+                for mod, m in _find_commands())
+
+def py_commands(commands, f):
+    f.write('command_list =3D {\n')
+    for key, val in sorted(commands.iteritems()):
+        f.write('    %r: %r,\n' % (key, val))
+    f.write('    }\n')
+
+def _command_list(commands):
+    kinds =3D {}
+    for cmd, (mod, kind, help) in commands.iteritems():
+        kinds.setdefault(kind, {})[cmd] =3D help
+    for kind in _kind_order:
+        kind =3D _kinds[kind]
+        yield kind, sorted(kinds[kind].iteritems())
+
+def pretty_command_list(commands, f):
+    cmd_len =3D max(len(cmd) for cmd in commands.iterkeys())
+    sep =3D ''
+    for kind, cmds in _command_list(commands):
+        f.write(sep)
+        sep =3D '\n'
+        f.write('%s:\n' % kind)
+        for cmd, help in cmds:
+            f.write('  %*s  %s\n' % (-cmd_len, cmd, help))
+
+def _write_underlined(s, u, f):
+    f.write(s + '\n')
+    f.write(u*len(s) + '\n')
+
+def asciidoc_command_list(commands, f):
+    for kind, cmds in _command_list(commands):
+        _write_underlined(kind, '~', f)
+        f.write('\n')
+        for cmd, help in cmds:
+            f.write('stgsublink:%s[]::\n' % cmd)
+            f.write('    %s\n' % help)
+        f.write('\n')
diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index 33a8afe..1b1b98f 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -23,6 +23,7 @@ from stgit.out import *
 from stgit import stack, git, basedir
=20
 help =3D 'Branch operations: switch, list, create, rename, delete, ...=
'
+kind =3D 'stack'
 usage =3D ['',
          '<branch>',
          '--list',
diff --git a/stgit/commands/clean.py b/stgit/commands/clean.py
index 5334704..27a7716 100644
--- a/stgit/commands/clean.py
+++ b/stgit/commands/clean.py
@@ -21,6 +21,7 @@ from stgit.commands import common
 from stgit.lib import transaction
=20
 help =3D 'Delete the empty patches in the series'
+kind =3D 'stack'
 usage =3D ['']
 description =3D """
 Delete the empty patches in the whole series or only those applied or
diff --git a/stgit/commands/clone.py b/stgit/commands/clone.py
index b83169e..28500c5 100644
--- a/stgit/commands/clone.py
+++ b/stgit/commands/clone.py
@@ -21,6 +21,7 @@ from stgit.utils import *
 from stgit import stack, git
=20
 help =3D 'Make a local clone of a remote repository'
+kind =3D 'repo'
 usage =3D ['<repository> <dir>']
 description =3D """
 Clone a git repository into the local directory <dir> (using
diff --git a/stgit/commands/coalesce.py b/stgit/commands/coalesce.py
index b390584..024668a 100644
--- a/stgit/commands/coalesce.py
+++ b/stgit/commands/coalesce.py
@@ -24,6 +24,7 @@ from stgit.commands import common
 from stgit.lib import git, transaction
=20
 help =3D 'Coalesce two or more patches into one'
+kind =3D 'stack'
 usage =3D ['[options] <patches>']
 description =3D """
 Coalesce two or more patches, creating one big patch that contains all
diff --git a/stgit/commands/commit.py b/stgit/commands/commit.py
index 7d46724..99b7b5d 100644
--- a/stgit/commands/commit.py
+++ b/stgit/commands/commit.py
@@ -21,6 +21,7 @@ from stgit.lib import transaction
 from stgit.out import *
=20
 help =3D 'Permanently store the applied patches into the stack base'
+kind =3D 'stack'
 usage =3D ['',
          '<patchnames>',
          '-n NUM',
diff --git a/stgit/commands/delete.py b/stgit/commands/delete.py
index 3ba7fc2..b92a039 100644
--- a/stgit/commands/delete.py
+++ b/stgit/commands/delete.py
@@ -21,6 +21,7 @@ from stgit.commands import common
 from stgit.lib import transaction
=20
 help =3D 'Delete patches'
+kind =3D 'patch'
 usage =3D ['[options] <patch1> [<patch2>] [<patch3>..<patch4>]']
 description =3D """
 Delete the patches passed as arguments.
diff --git a/stgit/commands/diff.py b/stgit/commands/diff.py
index 47e2e7f..e0078f9 100644
--- a/stgit/commands/diff.py
+++ b/stgit/commands/diff.py
@@ -25,6 +25,7 @@ from stgit.out import *
 from stgit import argparse, stack, git
=20
 help =3D 'Show the tree diff'
+kind =3D 'wc'
 usage =3D ['[options] [<files or dirs>]']
 description =3D """
 Show the diff (default) or diffstat between the current working copy
diff --git a/stgit/commands/edit.py b/stgit/commands/edit.py
index 0db3254..b6ef6c7 100644
--- a/stgit/commands/edit.py
+++ b/stgit/commands/edit.py
@@ -25,6 +25,7 @@ from stgit.lib import git as gitlib, transaction
 from stgit.out import *
=20
 help =3D 'edit a patch description or diff'
+kind =3D 'patch'
 usage =3D ['[options] [<patch>]']
 description =3D """
 Edit the description and author information of the given patch (or the
diff --git a/stgit/commands/export.py b/stgit/commands/export.py
index 3d74cc8..8d05996 100644
--- a/stgit/commands/export.py
+++ b/stgit/commands/export.py
@@ -26,6 +26,7 @@ from stgit.out import out
 from stgit.lib import git as gitlib
=20
 help =3D 'Export patches to a directory'
+kind =3D 'patch'
 usage =3D ['[options] [<patch1>] [<patch2>] [<patch3>..<patch4>]']
 description =3D """
 Export a range of applied patches to a given directory (defaults to
diff --git a/stgit/commands/files.py b/stgit/commands/files.py
index 08f882c..318a4a3 100644
--- a/stgit/commands/files.py
+++ b/stgit/commands/files.py
@@ -24,6 +24,7 @@ from stgit.out import *
 from stgit import argparse, stack, git
=20
 help =3D 'Show the files modified by a patch (or the current patch)'
+kind =3D 'patch'
 usage =3D ['[options] [[<branch>:]<patch>]']
 description =3D """
 List the files modified by the given patch (defaulting to the current
diff --git a/stgit/commands/float.py b/stgit/commands/float.py
index ac8eaea..1ca4ed3 100644
--- a/stgit/commands/float.py
+++ b/stgit/commands/float.py
@@ -23,6 +23,7 @@ from stgit.utils import *
 from stgit import stack, git
=20
 help =3D 'Push patches to the top, even if applied'
+kind =3D 'stack'
 usage =3D ['<patches>',
          '-s <series>']
 description =3D """
diff --git a/stgit/commands/fold.py b/stgit/commands/fold.py
index 6ddaea9..0f1486a 100644
--- a/stgit/commands/fold.py
+++ b/stgit/commands/fold.py
@@ -23,6 +23,7 @@ from stgit.out import *
 from stgit import stack, git
=20
 help =3D 'Integrate a GNU diff patch into the current patch'
+kind =3D 'patch'
 usage =3D ['[options] [<file>]']
 description =3D """
 Apply the given GNU diff file (or the standard input) onto the top of
diff --git a/stgit/commands/goto.py b/stgit/commands/goto.py
index 33b20ed..2bfef0f 100644
--- a/stgit/commands/goto.py
+++ b/stgit/commands/goto.py
@@ -19,6 +19,7 @@ from stgit.commands import common
 from stgit.lib import transaction
=20
 help =3D 'Push or pop patches to the given one'
+kind =3D 'stack'
 usage =3D ['<patch-name>']
 description =3D """
 Push/pop patches to/from the stack until the one given on the command
diff --git a/stgit/commands/hide.py b/stgit/commands/hide.py
index 488ea18..bee2162 100644
--- a/stgit/commands/hide.py
+++ b/stgit/commands/hide.py
@@ -23,6 +23,7 @@ from stgit.out import *
 from stgit import stack, git
=20
 help =3D 'Hide a patch in the series'
+kind =3D 'stack'
 usage =3D ['[options] <patch-range>']
 description =3D """
 Hide a range of unapplied patches so that they are no longer shown in
diff --git a/stgit/commands/id.py b/stgit/commands/id.py
index 18bab97..857ec33 100644
--- a/stgit/commands/id.py
+++ b/stgit/commands/id.py
@@ -20,6 +20,7 @@ from stgit.commands import common
 from stgit.lib import stack
=20
 help =3D 'Print the git hash value of a StGit reference'
+kind =3D 'repo'
 usage =3D ['[options] [id]']
 description =3D """
 Print the SHA1 value of a Git id (defaulting to HEAD). In addition to
diff --git a/stgit/commands/imprt.py b/stgit/commands/imprt.py
index 1f813a2..e81475d 100644
--- a/stgit/commands/imprt.py
+++ b/stgit/commands/imprt.py
@@ -26,6 +26,7 @@ from stgit import argparse, stack, git
=20
 name =3D 'import'
 help =3D 'Import a GNU diff file as a new patch'
+kind =3D 'patch'
 usage =3D ['[options] [<file>|<url>]']
 description =3D """
 Create a new patch and apply the given GNU diff file (or the standard
diff --git a/stgit/commands/init.py b/stgit/commands/init.py
index f7f7a21..67d20d1 100644
--- a/stgit/commands/init.py
+++ b/stgit/commands/init.py
@@ -20,6 +20,7 @@ from stgit.commands import common
 from stgit.lib import stack
=20
 help =3D 'Initialise the current branch for use with StGIT'
+kind =3D 'stack'
 usage =3D ['']
 description =3D """
 Initialise the current git branch to be used as an StGIT stack. The
diff --git a/stgit/commands/log.py b/stgit/commands/log.py
index b505ed5..de210ea 100644
--- a/stgit/commands/log.py
+++ b/stgit/commands/log.py
@@ -24,6 +24,7 @@ from stgit.out import *
 from stgit.run import Run
=20
 help =3D 'Display the patch changelog'
+kind =3D 'patch'
 usage =3D ['[options] [patch]']
 description =3D """
 List all the current and past commit ids of the given patch. The
diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 83acc86..caf8f9e 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -26,6 +26,7 @@ from stgit.config import config
 from stgit.run import Run
=20
 help =3D 'Send a patch or series of patches by e-mail'
+kind =3D 'patch'
 usage =3D [' [options] [<patch1>] [<patch2>] [<patch3>..<patch4>]']
 description =3D r"""
 Send a patch or a range of patches by e-mail using the SMTP server
diff --git a/stgit/commands/new.py b/stgit/commands/new.py
index 5e9d4ec..c1457bd 100644
--- a/stgit/commands/new.py
+++ b/stgit/commands/new.py
@@ -21,6 +21,7 @@ from stgit.commands import common
 from stgit.lib import git as gitlib, transaction
=20
 help =3D 'Create a new, empty patch'
+kind =3D 'patch'
 usage =3D ['[options] [<name>]']
 description =3D """
 Create a new, empty patch on the current stack. The new patch is
diff --git a/stgit/commands/patches.py b/stgit/commands/patches.py
index 656a4a1..0cbc275 100644
--- a/stgit/commands/patches.py
+++ b/stgit/commands/patches.py
@@ -24,6 +24,7 @@ from stgit.out import *
 from stgit import stack, git
=20
 help =3D 'Show the applied patches modifying a file'
+kind =3D 'stack'
 usage =3D ['[options] [<files or dirs>]']
 description =3D """
 Show the applied patches modifying the given files. Without arguments,
diff --git a/stgit/commands/pick.py b/stgit/commands/pick.py
index 72b2359..8a88262 100644
--- a/stgit/commands/pick.py
+++ b/stgit/commands/pick.py
@@ -24,6 +24,7 @@ from stgit import stack, git
 from stgit.stack import Series
=20
 help =3D 'Import a patch from a different branch or a commit object'
+kind =3D 'patch'
 usage =3D ['[options] ([<patch1>] [<patch2>] [<patch3>..<patch4>])|<co=
mmit>']
 description =3D """
 Import one or more patches from a different branch or a commit object
diff --git a/stgit/commands/pop.py b/stgit/commands/pop.py
index b3c4008..cf89846 100644
--- a/stgit/commands/pop.py
+++ b/stgit/commands/pop.py
@@ -23,6 +23,7 @@ from stgit.utils import *
 from stgit import stack, git
=20
 help =3D 'Pop one or more patches from the stack'
+kind =3D 'stack'
 usage =3D ['[options] [<patch1>] [<patch2>] [<patch3>..<patch4>]']
 description =3D """
 Pop the topmost patch or a range of patches from the stack. The
diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index 3801bf2..c989b5d 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -24,6 +24,7 @@ from stgit.config import GitConfigException
 from stgit import stack, git
=20
 help =3D 'Pull changes from a remote repository'
+kind =3D 'stack'
 usage =3D ['[options] [<repository>]']
 description =3D """
 Pull the latest changes from the given remote repository (defaulting
diff --git a/stgit/commands/push.py b/stgit/commands/push.py
index ee7b56e..c6056cc 100644
--- a/stgit/commands/push.py
+++ b/stgit/commands/push.py
@@ -24,6 +24,7 @@ from stgit.out import *
 from stgit import stack, git
=20
 help =3D 'Push one or more patches onto the stack'
+kind =3D 'stack'
 usage =3D ['[options] [<patch1>] [<patch2>] [<patch3>..<patch4>]']
 description =3D """
 Push one or more patches (defaulting to the first unapplied one) onto
diff --git a/stgit/commands/rebase.py b/stgit/commands/rebase.py
index ffec329..b09204e 100644
--- a/stgit/commands/rebase.py
+++ b/stgit/commands/rebase.py
@@ -22,6 +22,7 @@ from stgit.utils import *
 from stgit import stack, git
=20
 help =3D 'Move the stack base to another point in history'
+kind =3D 'stack'
 usage =3D ['[options] <new-base-id>']
 description =3D """
 Pop all patches from current stack, move the stack base to the given
diff --git a/stgit/commands/refresh.py b/stgit/commands/refresh.py
index e30085b..a20fcc5 100644
--- a/stgit/commands/refresh.py
+++ b/stgit/commands/refresh.py
@@ -25,6 +25,7 @@ from stgit import stack, git
 from stgit.config import config
=20
 help =3D 'Generate a new commit for the current patch'
+kind =3D 'patch'
 usage =3D ['[options] [<files or dirs>]']
 description =3D """
 Include the latest tree changes in the current patch. This command
diff --git a/stgit/commands/rename.py b/stgit/commands/rename.py
index b978ecf..fdb31ee 100644
--- a/stgit/commands/rename.py
+++ b/stgit/commands/rename.py
@@ -23,6 +23,7 @@ from stgit.out import *
 from stgit import stack, git
=20
 help =3D 'Rename a patch'
+kind =3D 'patch'
 usage =3D ['[options] [oldpatch] <newpatch>']
 description =3D """
 Rename <oldpatch> into <newpatch> in a series. If <oldpatch> is not
diff --git a/stgit/commands/repair.py b/stgit/commands/repair.py
index a5156cd..6218caa 100644
--- a/stgit/commands/repair.py
+++ b/stgit/commands/repair.py
@@ -26,6 +26,7 @@ from stgit.run import *
 from stgit import stack, git
=20
 help =3D 'Fix StGit metadata if branch was modified with git commands'
+kind =3D 'stack'
 usage =3D ['']
 description =3D """
 If you modify an StGit stack (branch) with some git commands -- such
diff --git a/stgit/commands/resolved.py b/stgit/commands/resolved.py
index 5643da8..d8dacd6 100644
--- a/stgit/commands/resolved.py
+++ b/stgit/commands/resolved.py
@@ -25,6 +25,7 @@ from stgit.config import config, file_extensions
 from stgit.gitmergeonefile import interactive_merge
=20
 help =3D 'Mark a file conflict as solved'
+kind =3D 'wc'
 usage =3D ['[options] [<files...>]']
 description =3D """
 Mark a merge conflict as resolved. The conflicts can be seen with the
diff --git a/stgit/commands/series.py b/stgit/commands/series.py
index 6579a8a..492a3aa 100644
--- a/stgit/commands/series.py
+++ b/stgit/commands/series.py
@@ -22,6 +22,7 @@ from stgit.commands.common import parse_patches
 from stgit.out import out
=20
 help =3D 'Print the patch series'
+kind =3D 'stack'
 usage =3D ['[options] [<patch-range>]']
 description =3D """
 Show all the patches in the series or just those in the given
diff --git a/stgit/commands/show.py b/stgit/commands/show.py
index c12793f..41cb31e 100644
--- a/stgit/commands/show.py
+++ b/stgit/commands/show.py
@@ -22,6 +22,7 @@ from stgit.commands.common import *
 from stgit import argparse, git
=20
 help =3D 'Show the commit corresponding to a patch'
+kind =3D 'patch'
 usage =3D ['[options] [<patch1>] [<patch2>] [<patch3>..<patch4>]']
 description =3D """
 Show the commit log and the diff corresponding to the given patches.
diff --git a/stgit/commands/sink.py b/stgit/commands/sink.py
index 11fae3a..2090cd4 100644
--- a/stgit/commands/sink.py
+++ b/stgit/commands/sink.py
@@ -23,6 +23,7 @@ from stgit.utils import *
 from stgit import stack, git
=20
 help =3D 'Send patches deeper down the stack'
+kind =3D 'stack'
 usage =3D ['[-t <target patch>] [-n] [<patches>]']
 description =3D """
 This is the opposite operation of stglink:float[]: move the specified
diff --git a/stgit/commands/status.py b/stgit/commands/status.py
index eadb507..7c68ba6 100644
--- a/stgit/commands/status.py
+++ b/stgit/commands/status.py
@@ -23,6 +23,7 @@ from stgit.utils import *
 from stgit import stack, git
=20
 help =3D 'Show the tree status'
+kind =3D 'wc'
 usage =3D ['[options] [<files or dirs>]']
 description =3D """
 Show the status of the whole working copy or the given files. The
diff --git a/stgit/commands/sync.py b/stgit/commands/sync.py
index ef94439..767b4d2 100644
--- a/stgit/commands/sync.py
+++ b/stgit/commands/sync.py
@@ -24,6 +24,7 @@ from stgit.out import *
 from stgit import stack, git
=20
 help =3D 'Synchronise patches with a branch or a series'
+kind =3D 'patch'
 usage =3D ['[options] [<patch1>] [<patch2>] [<patch3>..<patch4>]']
 description =3D """
 For each of the specified patches perform a three-way merge with the
diff --git a/stgit/commands/top.py b/stgit/commands/top.py
index f4962e7..523afa4 100644
--- a/stgit/commands/top.py
+++ b/stgit/commands/top.py
@@ -21,6 +21,7 @@ from stgit.commands import common
 from stgit.out import out
=20
 help =3D 'Print the name of the top patch'
+kind =3D 'stack'
 usage =3D ['']
 description =3D """
 Print the name of the current (topmost) patch."""
diff --git a/stgit/commands/uncommit.py b/stgit/commands/uncommit.py
index 19ec3c9..c44385d 100644
--- a/stgit/commands/uncommit.py
+++ b/stgit/commands/uncommit.py
@@ -24,6 +24,7 @@ from stgit.out import *
 from stgit import utils
=20
 help =3D 'Turn regular git commits into StGit patches'
+kind =3D 'stack'
 usage =3D ['<patch-name-1> [<patch-name-2> ...]',
          '-n NUM [<prefix>]',
          '-t <committish> [-x]']
diff --git a/stgit/commands/unhide.py b/stgit/commands/unhide.py
index 6c624d0..c34bc1d 100644
--- a/stgit/commands/unhide.py
+++ b/stgit/commands/unhide.py
@@ -23,6 +23,7 @@ from stgit.out import *
 from stgit import stack, git
=20
 help =3D 'Unhide a hidden patch'
+kind =3D 'stack'
 usage =3D ['[options] <patch-range>']
 description =3D """
 Unhide a hidden range of patches so that they are shown in the plain
diff --git a/stgit/main.py b/stgit/main.py
index 55c467c..48d8dbb 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -48,107 +48,13 @@ class Commands(dict):
         return candidates[0]
        =20
     def __getitem__(self, key):
-        """Return the command python module name based.
-        """
-        global prog
-
         cmd_mod =3D self.get(key) or self.get(self.canonical_cmd(key))
-           =20
-        __import__('stgit.commands.' + cmd_mod)
-        return getattr(stgit.commands, cmd_mod)
-
-commands =3D Commands({
-    'branch':           'branch',
-    'delete':           'delete',
-    'diff':             'diff',
-    'clean':            'clean',
-    'clone':            'clone',
-    'coalesce':         'coalesce',
-    'commit':           'commit',
-    'edit':             'edit',
-    'export':           'export',
-    'files':            'files',
-    'float':            'float',
-    'fold':             'fold',
-    'goto':             'goto',
-    'hide':             'hide',
-    'id':               'id',
-    'import':           'imprt',
-    'init':             'init',
-    'log':              'log',
-    'mail':             'mail',
-    'new':              'new',
-    'patches':          'patches',
-    'pick':             'pick',
-    'pop':              'pop',
-    'pull':             'pull',
-    'push':             'push',
-    'rebase':           'rebase',
-    'refresh':          'refresh',
-    'rename':           'rename',
-    'repair':           'repair',
-    'resolved':         'resolved',
-    'series':           'series',
-    'show':             'show',
-    'sink':             'sink',
-    'status':           'status',
-    'sync':             'sync',
-    'top':              'top',
-    'uncommit':         'uncommit',
-    'unhide':           'unhide'
-    })
+        return stgit.commands.get_command(cmd_mod)
=20
-# classification: repository, stack, patch, working copy
-repocommands =3D (
-    'clone',
-    'id',
-    )
-stackcommands =3D (
-    'branch',
-    'clean',
-    'coalesce',
-    'commit',
-    'float',
-    'goto',
-    'hide',
-    'init',
-    'patches',
-    'pop',
-    'pull',
-    'push',
-    'rebase',
-    'repair',
-    'series',
-    'sink',
-    'top',
-    'uncommit',
-    'unhide',
-    )
-patchcommands =3D (
-    'delete',
-    'edit',
-    'export',
-    'files',
-    'fold',
-    'import',
-    'log',
-    'mail',
-    'new',
-    'pick',
-    'refresh',
-    'rename',
-    'show',
-    'sync',
-    )
-wccommands =3D (
-    'diff',
-    'resolved',
-    'status',
-    )
+cmd_list =3D stgit.commands.get_commands()
+commands =3D Commands((cmd, mod) for cmd, (mod, kind, help)
+                    in cmd_list.iteritems())
=20
-def _print_helpstring(cmd):
-    print '  ' + cmd + ' ' * (12 - len(cmd)) + commands[cmd].help
-   =20
 def print_help():
     print 'usage: %s <command> [options]' % os.path.basename(sys.argv[=
0])
     print
@@ -156,33 +62,8 @@ def print_help():
     print '  help        print the detailed command usage'
     print '  version     display version information'
     print '  copyright   display copyright information'
-    # unclassified commands if any
-    cmds =3D commands.keys()
-    cmds.sort()
-    for cmd in cmds:
-        if not cmd in repocommands and not cmd in stackcommands \
-               and not cmd in patchcommands and not cmd in wccommands:
-            _print_helpstring(cmd)
-    print
-
-    print 'Repository commands:'
-    for cmd in repocommands:
-        _print_helpstring(cmd)
     print
-   =20
-    print 'Stack commands:'
-    for cmd in stackcommands:
-        _print_helpstring(cmd)
-    print
-
-    print 'Patch commands:'
-    for cmd in patchcommands:
-        _print_helpstring(cmd)
-    print
-
-    print 'Working-copy commands:'
-    for cmd in wccommands:
-        _print_helpstring(cmd)
+    stgit.commands.pretty_command_list(cmd_list, sys.stdout)
=20
 #
 # The main function (command dispatcher)
