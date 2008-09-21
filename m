From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Automatic bash completion
Date: Sun, 21 Sep 2008 17:17:42 +0200
Message-ID: <20080921151725.11942.27640.stgit@yoghurt>
References: <20080921153757.GA9098@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 17:23:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhQm1-0001ZJ-KP
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 17:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbYIUPRx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Sep 2008 11:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbYIUPRx
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 11:17:53 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1975 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbYIUPRu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 11:17:50 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KhR2U-0002qk-00; Sun, 21 Sep 2008 16:39:58 +0100
In-Reply-To: <20080921153757.GA9098@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.14.3.236.g0c611
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96400>

Teach the build process to create a bash tab completion script. This
has three benefits:

  1. The tab completion gets faster, since it no longer has to run stg
     to figure out the set of available flags for each command.

  2. The tab completion script used to encode the list of stg
     subcommands, and the kind of arguments each subcommand expected.
     This information now lives in just one place: the subcommand's
     module.

  3. The tab completion script now knows what kind of argument each
     flag wants, and can tab complete those as well. So "stg refresh
     <tab>" will complete dirty files, but "stg refresh -p <tab>" will
     complete patch names.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 .gitignore                    |    1=20
 Makefile                      |    5 +
 contrib/stgit-completion.bash |  270 ---------------------------------=
--------
 setup.py                      |    4 -
 stg-build                     |    6 +
 stgit/argparse.py             |   92 ++++++++++++--
 stgit/commands/branch.py      |    3=20
 stgit/commands/clean.py       |    1=20
 stgit/commands/clone.py       |    3=20
 stgit/commands/coalesce.py    |    2=20
 stgit/commands/commit.py      |    3=20
 stgit/commands/delete.py      |    5 +
 stgit/commands/diff.py        |    4 +
 stgit/commands/edit.py        |    2=20
 stgit/commands/export.py      |    9 +
 stgit/commands/files.py       |    2=20
 stgit/commands/float.py       |    4 -
 stgit/commands/fold.py        |    5 -
 stgit/commands/goto.py        |    2=20
 stgit/commands/hide.py        |    6 +
 stgit/commands/id.py          |    3=20
 stgit/commands/imprt.py       |    3=20
 stgit/commands/init.py        |    1=20
 stgit/commands/log.py         |    7 +
 stgit/commands/mail.py        |    5 +
 stgit/commands/new.py         |    1=20
 stgit/commands/patches.py     |    5 -
 stgit/commands/pick.py        |    9 +
 stgit/commands/pop.py         |    3=20
 stgit/commands/pull.py        |    3=20
 stgit/commands/push.py        |    3=20
 stgit/commands/rebase.py      |    3=20
 stgit/commands/redo.py        |    1=20
 stgit/commands/refresh.py     |    4 -
 stgit/commands/rename.py      |    6 +
 stgit/commands/repair.py      |    1=20
 stgit/commands/reset.py       |    4 +
 stgit/commands/resolved.py    |    4 -
 stgit/commands/series.py      |    8 +
 stgit/commands/show.py        |    5 +
 stgit/commands/sink.py        |    6 +
 stgit/commands/status.py      |    3=20
 stgit/commands/sync.py        |    8 +
 stgit/commands/top.py         |    4 -
 stgit/commands/uncommit.py    |    6 +
 stgit/commands/undo.py        |    1=20
 stgit/commands/unhide.py      |    5 -
 stgit/completion.py           |  140 +++++++++++++++++++++
 48 files changed, 354 insertions(+), 327 deletions(-)
 delete mode 100644 contrib/stgit-completion.bash
 create mode 100644 stgit/completion.py


diff --git a/.gitignore b/.gitignore
index 91dbad2..e7fffb0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -6,3 +6,4 @@ patches-*
 release.sh
 setup.cfg.rpm
 snapshot.sh
+stgit-completion.bash
diff --git a/Makefile b/Makefile
index 288622a..7183670 100644
--- a/Makefile
+++ b/Makefile
@@ -7,13 +7,16 @@ TEST_PATCHES ?=3D ..
 all: build
 	$(PYTHON) setup.py build
=20
-build: stgit/commands/cmdlist.py
+build: stgit/commands/cmdlist.py stgit-completion.bash
=20
 ALL_PY =3D $(shell find stgit -name '*.py')
=20
 stgit/commands/cmdlist.py: $(ALL_PY)
 	$(PYTHON) stg-build --py-cmd-list > $@
=20
+stgit-completion.bash: $(ALL_PY)
+	$(PYTHON) stg-build --bash-completion > $@
+
 install: build
 	$(PYTHON) setup.py install --prefix=3D$(prefix) --root=3D$(DESTDIR) -=
-force
=20
diff --git a/contrib/stgit-completion.bash b/contrib/stgit-completion.b=
ash
deleted file mode 100644
index 1467c28..0000000
--- a/contrib/stgit-completion.bash
+++ /dev/null
@@ -1,270 +0,0 @@
-# bash completion support for StGIT                        -*- shell-s=
cript -*-
-#
-# Copyright (C) 2006, Karl Hasselstr=C3=B6m <kha@treskal.com>
-# Based on git-completion.sh
-#
-# To use these routines:
-#
-#    1. Copy this file to somewhere (e.g. ~/.stgit-completion.bash).
-#
-#    2. Add the following line to your .bashrc:
-#         . ~/.stgit-completion.bash
-
-_stg_commands=3D"
-    branch
-    delete
-    diff
-    clean
-    clone
-    coalesce
-    commit
-    edit
-    export
-    files
-    float
-    fold
-    goto
-    hide
-    id
-    import
-    init
-    log
-    mail
-    new
-    patches
-    pick
-    pop
-    pull
-    push
-    rebase
-    refresh
-    rename
-    repair
-    resolved
-    series
-    show
-    sink
-    status
-    sync
-    top
-    uncommit
-    unhide
-"
-
-# The path to .git, or empty if we're not in a repository.
-_gitdir ()
-{
-    echo "$(git rev-parse --git-dir 2>/dev/null)"
-}
-
-# Name of the current branch, or empty if there isn't one.
-_current_branch ()
-{
-    local b=3D$(git symbolic-ref HEAD 2>/dev/null)
-    echo ${b#refs/heads/}
-}
-
-# List of all applied patches.
-_applied_patches ()
-{
-    local g=3D$(_gitdir)
-    [ "$g" ] && cat "$g/patches/$(_current_branch)/applied"
-}
-
-# List of all unapplied patches.
-_unapplied_patches ()
-{
-    local g=3D$(_gitdir)
-    [ "$g" ] && cat "$g/patches/$(_current_branch)/unapplied"
-}
-
-# List of all applied patches.
-_hidden_patches ()
-{
-    local g=3D$(_gitdir)
-    [ "$g" ] && cat "$g/patches/$(_current_branch)/hidden"
-}
-
-# List of all patches.
-_all_patches ()
-{
-    local b=3D$(_current_branch)
-    local g=3D$(_gitdir)
-    [ "$g" ] && cat "$g/patches/$b/applied" "$g/patches/$b/unapplied"
-}
-
-# List of all patches except the current patch.
-_all_other_patches ()
-{
-    local b=3D$(_current_branch)
-    local g=3D$(_gitdir)
-    [ "$g" ] && cat "$g/patches/$b/applied" "$g/patches/$b/unapplied" =
\
-        | grep -v "^$(cat $g/patches/$b/current 2> /dev/null)$"
-}
-
-_all_branches ()
-{
-    local g=3D$(_gitdir)
-    [ "$g" ] && (cd $g/patches/ && echo *)
-}
-
-_conflicting_files ()
-{
-    local g=3D$(_gitdir)
-    [ "$g" ] && stg status --conflict
-}
-
-_dirty_files ()
-{
-    local g=3D$(_gitdir)
-    [ "$g" ] && stg status --modified --new --deleted
-}
-
-_unknown_files ()
-{
-    local g=3D$(_gitdir)
-    [ "$g" ] && stg status --unknown
-}
-
-_known_files ()
-{
-    local g=3D$(_gitdir)
-    [ "$g" ] && git ls-files
-}
-
-# List the command options
-_cmd_options ()
-{
-    stg $1 --help 2>/dev/null | grep -e " --[A-Za-z]" | sed -e "s/.*\(=
--[^ =3D]\+\).*/\1/"
-}
-
-# Generate completions for patches and patch ranges from the given
-# patch list function, and options from the given list.
-_complete_patch_range ()
-{
-    local patchlist=3D"$1" options=3D"$2"
-    local pfx cur=3D"${COMP_WORDS[COMP_CWORD]}"
-    case "$cur" in
-        *..*)
-            pfx=3D"${cur%..*}.."
-            cur=3D"${cur#*..}"
-            COMPREPLY=3D($(compgen -P "$pfx" -W "$($patchlist)" -- "$c=
ur"))
-            ;;
-        *)
-            COMPREPLY=3D($(compgen -W "$options $($patchlist)" -- "$cu=
r"))
-            ;;
-    esac
-}
-
-_complete_patch_range_options ()
-{
-    local patchlist=3D"$1" options=3D"$2" patch_options=3D"$3"
-    local prev=3D"${COMP_WORDS[COMP_CWORD-1]}"
-    local cur=3D"${COMP_WORDS[COMP_CWORD]}"
-    local popt
-    for popt in $patch_options; do
-        if [ $prev =3D=3D $popt ]; then
-            _complete_patch_range $patchlist
-            return
-        fi
-    done
-    COMPREPLY=3D($(compgen -W "$options" -- "$cur"))
-}
-
-_complete_branch ()
-{
-     COMPREPLY=3D($(compgen -W "$(_cmd_options $1) $($2)" -- "${COMP_W=
ORDS[COMP_CWORD]}"))
-}
-
-# Generate completions for options from the given list.
-_complete_options ()
-{
-    local options=3D"$1"
-    COMPREPLY=3D($(compgen -W "$options" -- "${COMP_WORDS[COMP_CWORD]}=
"))
-}
-
-_complete_files ()
-{
-    COMPREPLY=3D($(compgen -W "$(_cmd_options $1) $2" -- "${COMP_WORDS=
[COMP_CWORD]}"))
-}
-
-_stg_common ()
-{
-    _complete_options "$(_cmd_options $1)"
-}
-
-_stg_patches ()
-{
-    _complete_patch_range "$2" "$(_cmd_options $1)"
-}
-
-_stg_patches_options ()
-{
-    _complete_patch_range_options "$2" "$(_cmd_options $1)" "$3"
-}
-
-_stg_help ()
-{
-    _complete_options "$_stg_commands"
-}
-
-_stg ()
-{
-    local i c=3D1 command
-
-    while [ $c -lt $COMP_CWORD ]; do
-        if [ $c =3D=3D 1 ]; then
-            command=3D"${COMP_WORDS[c]}"
-        fi
-        c=3D$((++c))
-    done
-
-    # Complete name of subcommand.
-    if [ $c -eq $COMP_CWORD -a -z "$command" ]; then
-        COMPREPLY=3D($(compgen \
-            -W "--help --version copyright help $_stg_commands" \
-            -- "${COMP_WORDS[COMP_CWORD]}"))
-        return;
-    fi
-
-    # Complete arguments to subcommands.
-    case "$command" in
-        # generic commands
-        help)   _stg_help ;;
-        # repository commands
-        id)     _stg_patches $command _all_patches ;;
-        # stack commands
-        coalesce) _stg_patches $command _applied_patches ;;
-        float)  _stg_patches $command _all_patches ;;
-        goto)   _stg_patches $command _all_other_patches ;;
-        hide)   _stg_patches $command _unapplied_patches ;;
-        pop)    _stg_patches $command _applied_patches ;;
-        push)   _stg_patches $command _unapplied_patches ;;
-        series) _stg_patches $command _all_patches ;;
-        sink)   _stg_patches $command _all_patches ;;
-        unhide) _stg_patches $command _hidden_patches ;;
-        # patch commands
-        delete) _stg_patches $command _all_patches ;;
-        edit)   _stg_patches $command _applied_patches ;;
-        export) _stg_patches $command _all_patches ;;
-        files)  _stg_patches $command _all_patches ;;
-        log)    _stg_patches $command _all_patches ;;
-        mail)   _stg_patches $command _all_patches ;;
-        pick)   _stg_patches $command _unapplied_patches ;;
-#	refresh)_stg_patches_options $command _applied_patches "-p --patch" =
;;
-        refresh) _complete_files $command "$(_dirty_files)" ;;
-        rename) _stg_patches $command _all_patches ;;
-        show)   _stg_patches $command _all_patches ;;
-        sync)   _stg_patches $command _applied_patches ;;
-        # working-copy commands
-        diff)   _stg_patches_options $command _applied_patches "-r --r=
ange" ;;
-	resolved) _complete_files $command "$(_conflicting_files)" ;;
-	# commands that usually raher accept branches
-	branch) _complete_branch $command _all_branches ;;
-	rebase) _complete_branch $command _all_branches ;;
-        # all the other commands
-        *)      _stg_common $command ;;
-    esac
-}
-
-complete -o default -F _stg stg
diff --git a/setup.py b/setup.py
index 81854d3..fb67958 100755
--- a/setup.py
+++ b/setup.py
@@ -59,8 +59,8 @@ def __run_setup():
             ('share/stgit/examples', glob.glob('examples/*.tmpl')),
             ('share/stgit/examples', ['examples/gitconfig']),
             ('share/stgit/contrib', ['contrib/diffcol.sh',
-                                     'contrib/stgbashprompt.sh',
-                                     'contrib/stgit-completion.bash'])=
,
+                                     'contrib/stgbashprompt.sh']),
+            ('share/stgit/completion', ['stgit-completion.bash'])
             ])
=20
 # Check the minimum versions required
diff --git a/stg-build b/stg-build
index 3c9dbfa..2af6523 100755
--- a/stg-build
+++ b/stg-build
@@ -2,7 +2,7 @@
 # -*- python -*-
 import optparse, sys
 import stgit.main
-from stgit import argparse, commands
+from stgit import argparse, commands, completion
=20
 def main():
     op =3D optparse.OptionParser()
@@ -14,6 +14,8 @@ def main():
                   help =3D 'Print asciidoc command list')
     op.add_option('--py-cmd-list', action =3D 'store_true',
                   help =3D 'Write Python command list')
+    op.add_option('--bash-completion', action =3D 'store_true',
+                  help =3D 'Write bash completion code')
     options, args =3D op.parse_args()
     if args:
         op.error('Wrong number of arguments')
@@ -30,6 +32,8 @@ def main():
     elif options.py_cmd_list:
         commands.py_commands(commands.get_commands(allow_cached =3D Fa=
lse),
                              sys.stdout)
+    elif options.bash_completion:
+        completion.write_completion(sys.stdout)
     else:
         op.error('No command')
=20
diff --git a/stgit/argparse.py b/stgit/argparse.py
index bd71817..406ada3 100644
--- a/stgit/argparse.py
+++ b/stgit/argparse.py
@@ -26,28 +26,27 @@ def _paragraphs(s):
=20
 class opt(object):
     """Represents a command-line flag."""
-    def __init__(self, *args, **kwargs):
-        self.args =3D args
+    def __init__(self, *pargs, **kwargs):
+        self.pargs =3D pargs
         self.kwargs =3D kwargs
     def get_option(self):
         kwargs =3D dict(self.kwargs)
         kwargs['help'] =3D kwargs['short']
-        del kwargs['short']
-        if 'long' in kwargs:
-            del kwargs['long']
-        return optparse.make_option(*self.args, **kwargs)
+        for k in ['short', 'long', 'args']:
+            kwargs.pop(k, None)
+        return optparse.make_option(*self.pargs, **kwargs)
     def metavar(self):
         o =3D self.get_option()
         if not o.nargs:
             return None
         if o.metavar:
             return o.metavar
-        for flag in self.args:
+        for flag in self.pargs:
             if flag.startswith('--'):
                 return utils.strip_prefix('--', flag).upper()
         raise Exception('Cannot determine metavar')
     def write_asciidoc(self, f):
-        for flag in self.args:
+        for flag in self.pargs:
             f.write(flag)
             m =3D self.metavar()
             if m:
@@ -60,6 +59,16 @@ class opt(object):
             f.write('+\n')
             for line in para:
                 f.write(line + '\n')
+    @property
+    def flags(self):
+        return self.pargs
+    @property
+    def args(self):
+        if self.kwargs.get('action', None) in ['store_true', 'store_fa=
lse']:
+            default =3D []
+        else:
+            default =3D [files]
+        return self.kwargs.get('args', default)
=20
 def _cmd_name(cmd_mod):
     return getattr(cmd_mod, 'name', cmd_mod.__name__.split('.')[-1])
@@ -103,11 +112,11 @@ def sign_options():
                 '--ack and --sign were both specified')
         parser.values.sign_str =3D sign_str
     return [
-        opt('--sign', action =3D 'callback', dest =3D 'sign_str',
+        opt('--sign', action =3D 'callback', dest =3D 'sign_str', args=
 =3D [],
             callback =3D callback, callback_args =3D ('Signed-off-by',=
),
             short =3D 'Add "Signed-off-by:" line', long =3D """
             Add a "Signed-off-by:" to the end of the patch."""),
-        opt('--ack', action =3D 'callback', dest =3D 'sign_str',
+        opt('--ack', action =3D 'callback', dest =3D 'sign_str', args =
=3D [],
             callback =3D callback, callback_args =3D ('Acked-by',),
             short =3D 'Add "Acked-by:" line', long =3D """
             Add an "Acked-by:" line to the end of the patch.""")]
@@ -151,7 +160,7 @@ def message_options(save_template):
             callback =3D msg_callback, dest =3D 'message', type =3D 's=
tring',
             short =3D 'Use MESSAGE instead of invoking the editor'),
         opt('-f', '--file', action =3D 'callback', callback =3D file_c=
allback,
-            dest =3D 'message', type =3D 'string',
+            dest =3D 'message', type =3D 'string', args =3D [files],
             short =3D 'Use FILE instead of invoking the editor', long =
=3D """
             Use the contents of FILE instead of invoking the editor.
             (If FILE is "-", write to stdout.)""")]
@@ -181,6 +190,7 @@ def diff_opts_option():
             default =3D (config.get('stgit.diff-opts') or '').split(),
             action =3D 'callback', callback =3D diff_opts_callback,
             type =3D 'string', metavar =3D 'OPTIONS',
+            args =3D [strings('-M', '-C')],
             short =3D 'Extra options to pass to "git diff"')]
=20
 def _person_opts(person, short):
@@ -212,3 +222,63 @@ def author_options():
=20
 def author_committer_options():
     return _person_opts('author', 'auth') + _person_opts('committer', =
'comm')
+
+class CompgenBase(object):
+    def actions(self, var): return set()
+    def words(self, var): return set()
+    def command(self, var):
+        cmd =3D ['compgen']
+        for act in self.actions(var):
+            cmd +=3D ['-A', act]
+        words =3D self.words(var)
+        if words:
+            cmd +=3D ['-W', '"%s"' % ' '.join(words)]
+        cmd +=3D ['--', '"%s"' % var]
+        return ' '.join(cmd)
+
+class CompgenJoin(CompgenBase):
+    def __init__(self, a, b):
+        assert isinstance(a, CompgenBase)
+        assert isinstance(b, CompgenBase)
+        self.__a =3D a
+        self.__b =3D b
+    def words(self, var): return self.__a.words(var) | self.__b.words(=
var)
+    def actions(self, var): return self.__a.actions(var) | self.__b.ac=
tions(var)
+
+class Compgen(CompgenBase):
+    def __init__(self, words =3D frozenset(), actions =3D frozenset())=
:
+        self.__words =3D set(words)
+        self.__actions =3D set(actions)
+    def actions(self, var): return self.__actions
+    def words(self, var): return self.__words
+
+def compjoin(compgens):
+    comp =3D Compgen()
+    for c in compgens:
+        comp =3D CompgenJoin(comp, c)
+    return comp
+
+all_branches =3D Compgen(['$(_all_branches)'])
+stg_branches =3D Compgen(['$(_stg_branches)'])
+applied_patches =3D Compgen(['$(_applied_patches)'])
+other_applied_patches =3D Compgen(['$(_other_applied_patches)'])
+unapplied_patches =3D Compgen(['$(_unapplied_patches)'])
+hidden_patches =3D Compgen(['$(_hidden_patches)'])
+commit =3D Compgen(['$(_all_branches) $(_tags) $(_remotes)'])
+conflicting_files =3D Compgen(['$(_conflicting_files)'])
+dirty_files =3D Compgen(['$(_dirty_files)'])
+unknown_files =3D Compgen(['$(_unknown_files)'])
+known_files =3D Compgen(['$(_known_files)'])
+repo =3D Compgen(actions =3D ['directory'])
+dir =3D Compgen(actions =3D ['directory'])
+files =3D Compgen(actions =3D ['file'])
+def strings(*ss): return Compgen(ss)
+class patch_range(CompgenBase):
+    def __init__(self, *endpoints):
+        self.__endpoints =3D endpoints
+    def words(self, var):
+        words =3D set()
+        for e in self.__endpoints:
+            assert not e.actions(var)
+            words |=3D e.words(var)
+        return set(['$(_patch_range "%s" "%s")' % (' '.join(words), va=
r)])
diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index ef71547..3d912fc 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -20,7 +20,7 @@ from stgit.argparse import opt
 from stgit.commands.common import *
 from stgit.utils import *
 from stgit.out import *
-from stgit import stack, git, basedir
+from stgit import argparse, stack, git, basedir
 from stgit.lib import log
=20
 help =3D 'Branch operations: switch, list, create, rename, delete, ...=
'
@@ -45,6 +45,7 @@ within a git repository.
 'stg branch' <branch>::
         Switch to the given branch."""
=20
+args =3D [argparse.all_branches]
 options =3D [
     opt('-l', '--list', action =3D 'store_true',
         short =3D 'List the branches contained in this repository', lo=
ng =3D """
diff --git a/stgit/commands/clean.py b/stgit/commands/clean.py
index 27a7716..9b48e7b 100644
--- a/stgit/commands/clean.py
+++ b/stgit/commands/clean.py
@@ -28,6 +28,7 @@ Delete the empty patches in the whole series or only =
those applied or
 unapplied. A patch is considered empty if the two commit objects
 representing its boundaries refer to the same tree object."""
=20
+args =3D []
 options =3D [
     opt('-a', '--applied', action =3D 'store_true',
         short =3D 'Delete the empty applied patches'),
diff --git a/stgit/commands/clone.py b/stgit/commands/clone.py
index 659712d..efb7198 100644
--- a/stgit/commands/clone.py
+++ b/stgit/commands/clone.py
@@ -18,7 +18,7 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston,=
 MA 02111-1307 USA
 import sys, os
 from stgit.commands.common import *
 from stgit.utils import *
-from stgit import stack, git
+from stgit import argparse, stack, git
=20
 help =3D 'Make a local clone of a remote repository'
 kind =3D 'repo'
@@ -35,6 +35,7 @@ commands of stglink:branch[].
 The target directory <dir> will be created by this command, and must
 not already exist."""
=20
+args =3D [argparse.repo, argparse.dir]
 options =3D []
=20
 directory =3D DirectoryAnywhere(needs_current_series =3D False, log =3D=
 False)
diff --git a/stgit/commands/coalesce.py b/stgit/commands/coalesce.py
index ef8e912..4b5c00a 100644
--- a/stgit/commands/coalesce.py
+++ b/stgit/commands/coalesce.py
@@ -34,6 +34,8 @@ If there are conflicts when reordering the patches to=
 match the order
 you specify, you will have to resolve them manually just as if you had
 done a sequence of pushes and pops yourself."""
=20
+args =3D [argparse.patch_range(argparse.applied_patches,
+                             argparse.unapplied_patches)]
 options =3D [opt('-n', '--name', short =3D 'Name of coalesced patch')
            ] + argparse.message_options(save_template =3D True)
=20
diff --git a/stgit/commands/commit.py b/stgit/commands/commit.py
index 99b7b5d..dd8d6e6 100644
--- a/stgit/commands/commit.py
+++ b/stgit/commands/commit.py
@@ -19,6 +19,7 @@ from stgit.argparse import opt
 from stgit.commands import common
 from stgit.lib import transaction
 from stgit.out import *
+from stgit import argparse
=20
 help =3D 'Permanently store the applied patches into the stack base'
 kind =3D 'stack'
@@ -40,6 +41,8 @@ The -n/--number option specifies the number of applie=
d patches to
 commit (counting from the bottom of the stack). If -a/--all is given,
 all applied patches are committed."""
=20
+args =3D [argparse.patch_range(argparse.applied_patches,
+                             argparse.unapplied_patches)]
 options =3D [
     opt('-n', '--number', type =3D 'int',
         short =3D 'Commit the specified number of patches'),
diff --git a/stgit/commands/delete.py b/stgit/commands/delete.py
index b92a039..40cef3f 100644
--- a/stgit/commands/delete.py
+++ b/stgit/commands/delete.py
@@ -19,6 +19,7 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston,=
 MA 02111-1307 USA
 from stgit.argparse import opt
 from stgit.commands import common
 from stgit.lib import transaction
+from stgit import argparse
=20
 help =3D 'Delete patches'
 kind =3D 'patch'
@@ -28,8 +29,10 @@ Delete the patches passed as arguments.
=20
 Note that the 'delete' operation is irreversible."""
=20
+args =3D [argparse.patch_range(argparse.applied_patches,
+                             argparse.unapplied_patches)]
 options =3D [
-    opt('-b', '--branch',
+    opt('-b', '--branch', args =3D [argparse.stg_branches],
         short =3D 'Use BRANCH instead of the default branch')]
=20
 directory =3D common.DirectoryHasRepositoryLib()
diff --git a/stgit/commands/diff.py b/stgit/commands/diff.py
index 05f4f4c..7d2f719 100644
--- a/stgit/commands/diff.py
+++ b/stgit/commands/diff.py
@@ -38,8 +38,12 @@ representing the bottom of the current stack.
=20
 rev =3D '[branch:](<patch>|{base}) | <tree-ish>'"""
=20
+args =3D [argparse.known_files, argparse.dirty_files]
 options =3D [
     opt('-r', '--range', metavar =3D 'rev1[..[rev2]]', dest =3D 'revs'=
,
+        args =3D [argparse.patch_range(argparse.applied_patches,
+                                     argparse.unapplied_patches,
+                                     argparse.hidden_patches)],
         short =3D 'Show the diff between revisions'),
     opt('-s', '--stat', action =3D 'store_true',
         short =3D 'Show the stat instead of the diff'),
diff --git a/stgit/commands/edit.py b/stgit/commands/edit.py
index b370f5c..4904f68 100644
--- a/stgit/commands/edit.py
+++ b/stgit/commands/edit.py
@@ -54,6 +54,8 @@ If the patch diff is edited but does not apply, no ch=
anges are made to
 the patch at all. The edited patch is saved to a file which you can
 feed to "stg edit --file", once you have made sure it does apply."""
=20
+args =3D [argparse.applied_patches, argparse.unapplied_patches,
+        argparse.hidden_patches]
 options =3D [
     opt('-d', '--diff', action =3D 'store_true',
         short =3D 'Edit the patch diff'),
diff --git a/stgit/commands/export.py b/stgit/commands/export.py
index c7ed802..dfdcea1 100644
--- a/stgit/commands/export.py
+++ b/stgit/commands/export.py
@@ -47,8 +47,11 @@ file:
   %(commname)s    - committer's name
   %(commemail)s   - committer's e-mail"""
=20
+args =3D [argparse.patch_range(argparse.applied_patches,
+                             argparse.unapplied_patches,
+                             argparse.hidden_patches)]
 options =3D [
-    opt('-d', '--dir',
+    opt('-d', '--dir', args =3D [argparse.dir],
         short =3D 'Export patches to DIR instead of the default'),
     opt('-p', '--patch', action =3D 'store_true',
         short =3D 'Append .patch to the patch names'),
@@ -56,9 +59,9 @@ options =3D [
         short =3D 'Append .EXTENSION to the patch names'),
     opt('-n', '--numbered', action =3D 'store_true',
         short =3D 'Prefix the patch names with order numbers'),
-    opt('-t', '--template', metavar =3D 'FILE',
+    opt('-t', '--template', metavar =3D 'FILE', args =3D [argparse.fil=
es],
         short =3D 'Use FILE as a template'),
-    opt('-b', '--branch',
+    opt('-b', '--branch', args =3D [argparse.stg_branches],
         short =3D 'Use BRANCH instead of the default branch'),
     opt('-s', '--stdout', action =3D 'store_true',
         short =3D 'Dump the patches to the standard output'),
diff --git a/stgit/commands/files.py b/stgit/commands/files.py
index d63a33e..46d43c1 100644
--- a/stgit/commands/files.py
+++ b/stgit/commands/files.py
@@ -34,6 +34,8 @@ given patch. Note that this command doesn't show the =
files modified in
 the working tree and not yet included in the patch by a 'refresh'
 command. Use the 'diff' or 'status' commands for these files."""
=20
+args =3D [argparse.applied_patches, argparse.unapplied_patches,
+        argparse.hidden_patches]
 options =3D [
     opt('-s', '--stat', action =3D 'store_true',
         short =3D 'Show the diffstat'),
diff --git a/stgit/commands/float.py b/stgit/commands/float.py
index 93bb69b..7c3dcdf 100644
--- a/stgit/commands/float.py
+++ b/stgit/commands/float.py
@@ -20,7 +20,7 @@ import sys, os
 from stgit.argparse import opt
 from stgit.commands.common import *
 from stgit.utils import *
-from stgit import stack, git
+from stgit import argparse, stack, git
=20
 help =3D 'Push patches to the top, even if applied'
 kind =3D 'stack'
@@ -32,6 +32,8 @@ necessary pop and push operations will be performed t=
o accomplish
 this. The '--series' option can be used to rearrange the (top) patches
 as specified by the given series file (or the standard input)."""
=20
+args =3D [argparse.patch_range(argparse.applied_patches,
+                             argparse.unapplied_patches)]
 options =3D [
     opt('-s', '--series', action =3D 'store_true',
         short =3D 'Rearrange according to a series file')]
diff --git a/stgit/commands/fold.py b/stgit/commands/fold.py
index 165ff52..66a2dd9 100644
--- a/stgit/commands/fold.py
+++ b/stgit/commands/fold.py
@@ -20,7 +20,7 @@ from stgit.argparse import opt
 from stgit.commands.common import *
 from stgit.utils import *
 from stgit.out import *
-from stgit import stack, git
+from stgit import argparse, stack, git
=20
 help =3D 'Integrate a GNU diff patch into the current patch'
 kind =3D 'patch'
@@ -33,10 +33,11 @@ performed with the current top. With the --base opt=
ion, the patch is
 applied onto the specified base and a three-way merged is performed
 with the current top."""
=20
+args =3D [argparse.files]
 options =3D [
     opt('-t', '--threeway', action =3D 'store_true',
         short =3D 'Perform a three-way merge with the current patch'),
-    opt('-b', '--base',
+    opt('-b', '--base', args =3D [argparse.commit],
         short =3D 'Use BASE instead of HEAD applying the patch')]
=20
 directory =3D DirectoryHasRepository(log =3D True)
diff --git a/stgit/commands/goto.py b/stgit/commands/goto.py
index 0d4cd29..60a917e 100644
--- a/stgit/commands/goto.py
+++ b/stgit/commands/goto.py
@@ -17,6 +17,7 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston,=
 MA 02111-1307 USA
=20
 from stgit.commands import common
 from stgit.lib import transaction
+from stgit import argparse
=20
 help =3D 'Push or pop patches to the given one'
 kind =3D 'stack'
@@ -25,6 +26,7 @@ description =3D """
 Push/pop patches to/from the stack until the one given on the command
 line becomes current."""
=20
+args =3D [argparse.other_applied_patches, argparse.unapplied_patches]
 options =3D []
=20
 directory =3D common.DirectoryHasRepositoryLib()
diff --git a/stgit/commands/hide.py b/stgit/commands/hide.py
index 1bcb5f1..014febb 100644
--- a/stgit/commands/hide.py
+++ b/stgit/commands/hide.py
@@ -20,7 +20,7 @@ from stgit.argparse import opt
 from stgit.commands.common import *
 from stgit.utils import *
 from stgit.out import *
-from stgit import stack, git
+from stgit import argparse, stack, git
=20
 help =3D 'Hide a patch in the series'
 kind =3D 'stack'
@@ -29,8 +29,10 @@ description =3D """
 Hide a range of unapplied patches so that they are no longer shown in
 the plain 'series' command output."""
=20
+args =3D [argparse.patch_range(argparse.applied_patches,
+                             argparse.unapplied_patches)]
 options =3D [
-    opt('-b', '--branch',
+    opt('-b', '--branch', args =3D [argparse.stg_branches],
         short =3D 'Use BRANCH instead of the default branch')]
=20
 directory =3D DirectoryHasRepository(log =3D True)
diff --git a/stgit/commands/id.py b/stgit/commands/id.py
index 857ec33..566edcc 100644
--- a/stgit/commands/id.py
+++ b/stgit/commands/id.py
@@ -18,6 +18,7 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston,=
 MA 02111-1307 USA
 from stgit.out import out
 from stgit.commands import common
 from stgit.lib import stack
+from stgit import argparse
=20
 help =3D 'Print the git hash value of a StGit reference'
 kind =3D 'repo'
@@ -30,6 +31,8 @@ or the base of the stack. If no branch is specified, =
it defaults to the
 current one. The bottom of a patch is accessible with the
 '[<branch>:]<patch>^' format."""
=20
+args =3D [argparse.applied_patches, argparse.unapplied_patches,
+        argparse.hidden_patches]
 options =3D []
=20
 directory =3D common.DirectoryHasRepositoryLib()
diff --git a/stgit/commands/imprt.py b/stgit/commands/imprt.py
index 9f2df05..de5e9a5 100644
--- a/stgit/commands/imprt.py
+++ b/stgit/commands/imprt.py
@@ -44,6 +44,7 @@ stack.
 The patch description has to be separated from the data with a '---'
 line."""
=20
+args =3D [argparse.files]
 options =3D [
     opt('-m', '--mail', action =3D 'store_true',
         short =3D 'Import the patch from a standard e-mail file'),
@@ -61,7 +62,7 @@ options =3D [
         short =3D 'Ignore the applied patches in the series'),
     opt('--replace', action =3D 'store_true',
         short =3D 'Replace the unapplied patches in the series'),
-    opt('-b', '--base',
+    opt('-b', '--base', args =3D [argparse.commit],
         short =3D 'Use BASE instead of HEAD for file importing'),
     opt('-e', '--edit', action =3D 'store_true',
         short =3D 'Invoke an editor for the patch description'),
diff --git a/stgit/commands/init.py b/stgit/commands/init.py
index 67d20d1..6ffb93e 100644
--- a/stgit/commands/init.py
+++ b/stgit/commands/init.py
@@ -27,6 +27,7 @@ Initialise the current git branch to be used as an St=
GIT stack. The
 branch (and the git repository it is in) must already exist and
 contain at least one commit."""
=20
+args =3D []
 options =3D []
=20
 directory =3D common.DirectoryHasRepositoryLib()
diff --git a/stgit/commands/log.py b/stgit/commands/log.py
index 1f63ef5..39cdfe7 100644
--- a/stgit/commands/log.py
+++ b/stgit/commands/log.py
@@ -20,7 +20,7 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston,=
 MA 02111-1307 USA
=20
 import os.path
 from optparse import make_option
-from stgit import run
+from stgit import argparse, run
 from stgit.argparse import opt
 from stgit.commands import common
 from stgit.lib import log
@@ -37,8 +37,11 @@ the named patches.
 "stg undo" and "stg redo" let you step back and forth in the patch
 stack. "stg reset" lets you go directly to any state."""
=20
+args =3D [argparse.patch_range(argparse.applied_patches,
+                             argparse.unapplied_patches,
+                             argparse.hidden_patches)]
 options =3D [
-    opt('-b', '--branch',
+    opt('-b', '--branch', args =3D [argparse.stg_branches],
         short =3D 'Use BRANCH instead of the default one'),
     opt('-p', '--patch', action =3D 'store_true',
         short =3D 'Show the refresh diffs'),
diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index e0a5521..0b3157e 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -93,6 +93,9 @@ the following:
   %(prefix)s       - 'prefix ' string passed on the command line
   %(shortdescr)s   - the first line of the patch description"""
=20
+args =3D [argparse.patch_range(argparse.applied_patches,
+                             argparse.unapplied_patches,
+                             argparse.hidden_patches)]
 options =3D [
     opt('-a', '--all', action =3D 'store_true',
         short =3D 'E-mail all the applied patches'),
@@ -134,7 +137,7 @@ options =3D [
         short =3D 'Password for SMTP authentication'),
     opt('-T', '--smtp-tls', action =3D 'store_true',
         short =3D 'Use SMTP with TLS encryption'),
-    opt('-b', '--branch',
+    opt('-b', '--branch', args =3D [argparse.stg_branches],
         short =3D 'Use BRANCH instead of the default branch'),
     opt('-m', '--mbox', action =3D 'store_true',
         short =3D 'Generate an mbox file instead of sending')
diff --git a/stgit/commands/new.py b/stgit/commands/new.py
index 4117e4e..067882a 100644
--- a/stgit/commands/new.py
+++ b/stgit/commands/new.py
@@ -39,6 +39,7 @@ the patch, unless the '--message' flag already specif=
ied one. The
 'patchdescr.tmpl' template file (if available) is used to pre-fill the
 editor."""
=20
+args =3D []
 options =3D (argparse.author_committer_options()
            + argparse.message_options(save_template =3D True)
            + argparse.sign_options())
diff --git a/stgit/commands/patches.py b/stgit/commands/patches.py
index e877171..54fac21 100644
--- a/stgit/commands/patches.py
+++ b/stgit/commands/patches.py
@@ -21,7 +21,7 @@ from stgit.argparse import opt
 from stgit.commands.common import *
 from stgit.utils import *
 from stgit.out import *
-from stgit import stack, git
+from stgit import argparse, stack, git
=20
 help =3D 'Show the applied patches modifying a file'
 kind =3D 'stack'
@@ -32,10 +32,11 @@ it shows the patches affected by the local tree mod=
ifications. The
 '--diff' option also lists the patch log and the diff for the given
 files."""
=20
+args =3D [argparse.known_files]
 options =3D [
     opt('-d', '--diff', action =3D 'store_true',
         short =3D 'Show the diff for the given files'),
-    opt('-b', '--branch',
+    opt('-b', '--branch', args =3D [argparse.stg_branches],
         short =3D 'Use BRANCH instead of the default branch')]
=20
 directory =3D DirectoryHasRepository(log =3D False)
diff --git a/stgit/commands/pick.py b/stgit/commands/pick.py
index e1c531d..760918b 100644
--- a/stgit/commands/pick.py
+++ b/stgit/commands/pick.py
@@ -20,7 +20,7 @@ from stgit.argparse import opt
 from stgit.commands.common import *
 from stgit.utils import *
 from stgit.out import *
-from stgit import stack, git
+from stgit import argparse, stack, git
 from stgit.stack import Series
=20
 help =3D 'Import a patch from a different branch or a commit object'
@@ -34,14 +34,17 @@ used as the name of the current patch. It can be ov=
erridden with the
 option. The log and author information are those of the commit
 object."""
=20
+args =3D [argparse.patch_range(argparse.applied_patches,
+                             argparse.unapplied_patches,
+                             argparse.hidden_patches)]
 options =3D [
     opt('-n', '--name',
         short =3D 'Use NAME as the patch name'),
-    opt('-B', '--ref-branch',
+    opt('-B', '--ref-branch', args =3D [argparse.stg_branches],
         short =3D 'Pick patches from BRANCH'),
     opt('-r', '--reverse', action =3D 'store_true',
         short =3D 'Reverse the commit object before importing'),
-    opt('-p', '--parent', metavar =3D 'COMMITID',
+    opt('-p', '--parent', metavar =3D 'COMMITID', args =3D [argparse.c=
ommit],
         short =3D 'Use COMMITID as parent'),
     opt('-x', '--expose', action =3D 'store_true',
         short =3D 'Append the imported commit id to the patch log'),
diff --git a/stgit/commands/pop.py b/stgit/commands/pop.py
index 855dc09..2c78ac2 100644
--- a/stgit/commands/pop.py
+++ b/stgit/commands/pop.py
@@ -20,7 +20,7 @@ import sys, os
 from stgit.argparse import opt
 from stgit.commands.common import *
 from stgit.utils import *
-from stgit import stack, git
+from stgit import argparse, stack, git
=20
 help =3D 'Pop one or more patches from the stack'
 kind =3D 'stack'
@@ -35,6 +35,7 @@ patches passed on the command line are popped from th=
e stack. Some of
 the push operations may fail because of conflicts ("stg undo" would
 revert the last push operation)."""
=20
+args =3D [argparse.patch_range(argparse.applied_patches)]
 options =3D [
     opt('-a', '--all', action =3D 'store_true',
         short =3D 'Pop all the applied patches'),
diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index 82035c6..f6d1398 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -21,7 +21,7 @@ from stgit.commands.common import *
 from stgit.utils import *
 from stgit.out import *
 from stgit.config import GitConfigException
-from stgit import stack, git
+from stgit import argparse, stack, git
=20
 help =3D 'Pull changes from a remote repository'
 kind =3D 'stack'
@@ -37,6 +37,7 @@ resolved and the patch pushed again.
=20
 Check the 'git fetch' documentation for the <repository> format."""
=20
+args =3D [argparse.repo]
 options =3D [
     opt('-n', '--nopush', action =3D 'store_true',
         short =3D 'Do not push the patches back after pulling'),
diff --git a/stgit/commands/push.py b/stgit/commands/push.py
index a7c7578..818e02d 100644
--- a/stgit/commands/push.py
+++ b/stgit/commands/push.py
@@ -21,7 +21,7 @@ from stgit.argparse import opt
 from stgit.commands.common import *
 from stgit.utils import *
 from stgit.out import *
-from stgit import stack, git
+from stgit import argparse, stack, git
=20
 help =3D 'Push one or more patches onto the stack'
 kind =3D 'stack'
@@ -38,6 +38,7 @@ conflicting push with 'stg undo').
 The command also notifies when the patch becomes empty (fully merged
 upstream) or is modified (three-way merged) by the 'push' operation.""=
"
=20
+args =3D [argparse.patch_range(argparse.unapplied_patches)]
 options =3D [
     opt('-a', '--all', action =3D 'store_true',
         short =3D 'Push all the unapplied patches'),
diff --git a/stgit/commands/rebase.py b/stgit/commands/rebase.py
index 60168ab..a4bc6e7 100644
--- a/stgit/commands/rebase.py
+++ b/stgit/commands/rebase.py
@@ -19,7 +19,7 @@ import sys, os
 from stgit.argparse import opt
 from stgit.commands.common import *
 from stgit.utils import *
-from stgit import stack, git
+from stgit import argparse, stack, git
=20
 help =3D 'Move the stack base to another point in history'
 kind =3D 'stack'
@@ -40,6 +40,7 @@ Or if you want to skip that patch:
         $ stg undo --hard
         $ stg push next-patch..top-patch"""
=20
+args =3D [argparse.commit]
 options =3D [
     opt('-n', '--nopush', action =3D 'store_true',
         short =3D 'Do not push the patches back after rebasing'),
diff --git a/stgit/commands/redo.py b/stgit/commands/redo.py
index 8e62a1d..eb8b20f 100644
--- a/stgit/commands/redo.py
+++ b/stgit/commands/redo.py
@@ -32,6 +32,7 @@ the effects of consecutive invocations of "stg undo".
 It is an error to run "stg redo" if the last command was not an
 undo."""
=20
+args =3D []
 options =3D [
     opt('-n', '--number', type =3D 'int', metavar =3D 'N', default =3D=
 1,
         short =3D 'Undo the last N undos'),
diff --git a/stgit/commands/refresh.py b/stgit/commands/refresh.py
index 3c82906..27cccc5 100644
--- a/stgit/commands/refresh.py
+++ b/stgit/commands/refresh.py
@@ -48,6 +48,7 @@ the patch stack log; this means that one undo step wi=
ll undo the merge
 between the other patch and the temp patch, and two undo steps will
 additionally get rid of the temp patch."""
=20
+args =3D [argparse.dirty_files]
 options =3D [
     opt('-u', '--update', action =3D 'store_true',
         short =3D 'Only update the current patch files'),
@@ -55,7 +56,8 @@ options =3D [
         short =3D 'Refresh from index instead of worktree', long =3D "=
""
         Instead of setting the patch top to the current contents of
         the worktree, set it to the current contents of the index.""")=
,
-    opt('-p', '--patch',
+    opt('-p', '--patch', args =3D [argparse.other_applied_patches,
+                                 argparse.unapplied_patches],
         short =3D 'Refresh (applied) PATCH instead of the top patch'),
     opt('-e', '--edit', action =3D 'store_true',
         short =3D 'Invoke an editor for the patch description'),
diff --git a/stgit/commands/rename.py b/stgit/commands/rename.py
index 7e0fbf5..8a593ac 100644
--- a/stgit/commands/rename.py
+++ b/stgit/commands/rename.py
@@ -20,7 +20,7 @@ from stgit.argparse import opt
 from stgit.commands.common import *
 from stgit.utils import *
 from stgit.out import *
-from stgit import stack, git
+from stgit import argparse, stack, git
=20
 help =3D 'Rename a patch'
 kind =3D 'patch'
@@ -29,8 +29,10 @@ description =3D """
 Rename <oldpatch> into <newpatch> in a series. If <oldpatch> is not
 given, the top-most patch will be renamed."""
=20
+args =3D [argparse.applied_patches, argparse.unapplied_patches,
+        argparse.hidden_patches]
 options =3D [
-    opt('-b', '--branch',
+    opt('-b', '--branch', args =3D [argparse.stg_branches],
         short =3D 'use BRANCH instead of the default one')]
=20
 directory =3D DirectoryHasRepository(log =3D True)
diff --git a/stgit/commands/repair.py b/stgit/commands/repair.py
index ff9bb61..37c4bab 100644
--- a/stgit/commands/repair.py
+++ b/stgit/commands/repair.py
@@ -69,6 +69,7 @@ NOTE: If using git commands on the stack was a mistak=
e, running "stg
 repair" is _not_ what you want. In that case, what you want is option
 (1) above."""
=20
+args =3D []
 options =3D []
=20
 directory =3D DirectoryGotoToplevel(log =3D True)
diff --git a/stgit/commands/reset.py b/stgit/commands/reset.py
index 3ccbf1b..7dfd4a0 100644
--- a/stgit/commands/reset.py
+++ b/stgit/commands/reset.py
@@ -21,6 +21,7 @@ from stgit.argparse import opt
 from stgit.commands import common
 from stgit.lib import git, log, transaction
 from stgit.out import out
+from stgit import argparse
=20
 help =3D 'Reset the patch stack to an earlier state'
 kind =3D 'stack'
@@ -33,6 +34,9 @@ a commit id from a stack log; "stg log" lets you view=
 this log, and
 If one or more patch names are given, reset only those patches, and
 leave the rest alone."""
=20
+args =3D [argparse.patch_range(argparse.applied_patches,
+                             argparse.unapplied_patches,
+                             argparse.hidden_patches)]
 options =3D [
     opt('--hard', action =3D 'store_true',
         short =3D 'Discard changes in your index/worktree')]
diff --git a/stgit/commands/resolved.py b/stgit/commands/resolved.py
index ce8630d..2ce7ec3 100644
--- a/stgit/commands/resolved.py
+++ b/stgit/commands/resolved.py
@@ -20,7 +20,7 @@ import sys, os
 from stgit.argparse import opt
 from stgit.commands.common import *
 from stgit.utils import *
-from stgit import stack, git, basedir
+from stgit import argparse, stack, git, basedir
 from stgit.config import config, file_extensions
 from stgit.gitmergeonefile import interactive_merge
=20
@@ -32,10 +32,12 @@ Mark a merge conflict as resolved. The conflicts ca=
n be seen with the
 'status' command, the corresponding files being prefixed with a
 'C'."""
=20
+args =3D [argparse.conflicting_files]
 options =3D [
     opt('-a', '--all', action =3D 'store_true',
         short =3D 'Mark all conflicts as solved'),
     opt('-r', '--reset', metavar =3D '(ancestor|current|patched)',
+        args =3D [argparse.strings('ancestor', 'current', 'patched')],
         short =3D 'Reset the file(s) to the given state'),
     opt('-i', '--interactive', action =3D 'store_true',
         short =3D 'Run the interactive merging tool')]
diff --git a/stgit/commands/series.py b/stgit/commands/series.py
index e9d148a..95196d3 100644
--- a/stgit/commands/series.py
+++ b/stgit/commands/series.py
@@ -21,6 +21,7 @@ from stgit.commands import common
 from stgit.commands.common import parse_patches
 from stgit.out import out
 from stgit.config import config
+from stgit import argparse
=20
 help =3D 'Print the patch series'
 kind =3D 'stack'
@@ -31,8 +32,11 @@ range. The applied patches are prefixed with a '+', =
the unapplied ones
 with a '-' and the hidden ones with a '!'. The current patch is
 prefixed with a '>'. Empty patches are prefixed with a '0'."""
=20
+args =3D [argparse.patch_range(argparse.applied_patches,
+                             argparse.unapplied_patches,
+                             argparse.hidden_patches)]
 options =3D [
-    opt('-b', '--branch',
+    opt('-b', '--branch', args =3D [argparse.stg_branches],
         short =3D 'Use BRANCH instead of the default branch'),
     opt('-a', '--all', action =3D 'store_true',
         short =3D 'Show all patches, including the hidden ones'),
@@ -42,7 +46,7 @@ options =3D [
         short =3D 'Show the unapplied patches only'),
     opt('-H', '--hidden', action =3D 'store_true',
         short =3D 'Show the hidden patches only'),
-    opt('-m', '--missing', metavar =3D 'BRANCH',
+    opt('-m', '--missing', metavar =3D 'BRANCH',  args =3D [argparse.s=
tg_branches],
         short =3D 'Show patches in BRANCH missing in current'),
     opt('-c', '--count', action =3D 'store_true',
         short =3D 'Print the number of patches in the series'),
diff --git a/stgit/commands/show.py b/stgit/commands/show.py
index e08551b..9a1f48b 100644
--- a/stgit/commands/show.py
+++ b/stgit/commands/show.py
@@ -28,8 +28,11 @@ description =3D """
 Show the commit log and the diff corresponding to the given patches.
 The output is similar to that generated by 'git show'."""
=20
+args =3D [argparse.patch_range(argparse.applied_patches,
+                             argparse.unapplied_patches,
+                             argparse.hidden_patches)]
 options =3D [
-    opt('-b', '--branch',
+    opt('-b', '--branch', args =3D [argparse.stg_branches],
         short =3D 'Use BRANCH instead of the default branch'),
     opt('-a', '--applied', action =3D 'store_true',
         short =3D 'Show the applied patches'),
diff --git a/stgit/commands/sink.py b/stgit/commands/sink.py
index 34f81c9..d4561ed 100644
--- a/stgit/commands/sink.py
+++ b/stgit/commands/sink.py
@@ -20,7 +20,7 @@ import sys, os
 from stgit.argparse import opt
 from stgit.commands.common import *
 from stgit.utils import *
-from stgit import stack, git
+from stgit import argparse, stack, git
=20
 help =3D 'Send patches deeper down the stack'
 kind =3D 'stack'
@@ -41,12 +41,14 @@ including <target patch>), then pushing the patches=
 to sink, and then
 (unless '--nopush' is also given) pushing back into place the
 formerly-applied patches."""
=20
+args =3D [argparse.patch_range(argparse.applied_patches,
+                             argparse.unapplied_patches)]
 options =3D [
     opt('-n', '--nopush', action =3D 'store_true',
         short =3D 'Do not push the patches back after sinking', long =3D=
 """
         Do not push back on the stack the formerly-applied patches.
         Only the patches to sink are pushed."""),
-    opt('-t', '--to', metavar =3D 'TARGET',
+    opt('-t', '--to', metavar =3D 'TARGET', args =3D [argparse.applied=
_patches],
         short =3D 'Sink patches below the TARGET patch', long =3D """
         Specify a target patch to place the patches below, instead of
         sinking them to the bottom of the stack.""")]
diff --git a/stgit/commands/status.py b/stgit/commands/status.py
index c78bc1b..730b47c 100644
--- a/stgit/commands/status.py
+++ b/stgit/commands/status.py
@@ -20,7 +20,7 @@ import sys, os
 from stgit.argparse import opt
 from stgit.commands.common import *
 from stgit.utils import *
-from stgit import stack, git
+from stgit import argparse, stack, git
=20
 help =3D 'Show the tree status'
 kind =3D 'wc'
@@ -39,6 +39,7 @@ under revision control. The files are prefixed as fol=
lows:
 An 'stg refresh' command clears the status of the modified, new and
 deleted files."""
=20
+args =3D [argparse.files]
 options =3D [
     opt('-m', '--modified', action =3D 'store_true',
         short =3D 'Show modified files only'),
diff --git a/stgit/commands/sync.py b/stgit/commands/sync.py
index 966ac55..ea949d6 100644
--- a/stgit/commands/sync.py
+++ b/stgit/commands/sync.py
@@ -21,7 +21,7 @@ from stgit.argparse import opt
 from stgit.commands.common import *
 from stgit.utils import *
 from stgit.out import *
-from stgit import stack, git
+from stgit import argparse, stack, git
=20
 help =3D 'Synchronise patches with a branch or a series'
 kind =3D 'patch'
@@ -33,12 +33,14 @@ for keeping patches on several branches in sync. No=
te that the
 operation may fail for some patches because of conflicts. The patches
 in the series must apply cleanly."""
=20
+args =3D [argparse.patch_range(argparse.applied_patches,
+                             argparse.unapplied_patches)]
 options =3D [
     opt('-a', '--all', action =3D 'store_true',
         short =3D 'Synchronise all the applied patches'),
-    opt('-B', '--ref-branch',
+    opt('-B', '--ref-branch', args =3D [argparse.stg_branches],
         short =3D 'Syncronise patches with BRANCH'),
-    opt('-s', '--series',
+    opt('-s', '--series', args =3D [argparse.files],
         short =3D 'Syncronise patches with SERIES')]
=20
 directory =3D DirectoryGotoToplevel(log =3D True)
diff --git a/stgit/commands/top.py b/stgit/commands/top.py
index 523afa4..4ec37b4 100644
--- a/stgit/commands/top.py
+++ b/stgit/commands/top.py
@@ -19,6 +19,7 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston,=
 MA 02111-1307 USA
 from stgit.argparse import opt
 from stgit.commands import common
 from stgit.out import out
+from stgit import argparse
=20
 help =3D 'Print the name of the top patch'
 kind =3D 'stack'
@@ -26,8 +27,9 @@ usage =3D ['']
 description =3D """
 Print the name of the current (topmost) patch."""
=20
+args =3D []
 options =3D [
-    opt('-b', '--branch',
+    opt('-b', '--branch', args =3D [argparse.stg_branches],
         short =3D 'Use BRANCH instead of the default branch')]
=20
 directory =3D common.DirectoryHasRepositoryLib()
diff --git a/stgit/commands/uncommit.py b/stgit/commands/uncommit.py
index b9950ca..bcc8bac 100644
--- a/stgit/commands/uncommit.py
+++ b/stgit/commands/uncommit.py
@@ -21,7 +21,7 @@ from stgit.argparse import opt
 from stgit.commands import common
 from stgit.lib import transaction
 from stgit.out import *
-from stgit import utils
+from stgit import argparse, utils
=20
 help =3D 'Turn regular git commits into StGit patches'
 kind =3D 'stack'
@@ -49,10 +49,12 @@ given commit should be uncommitted.
 Only commits with exactly one parent can be uncommitted; in other
 words, you can't uncommit a merge."""
=20
+args =3D []
 options =3D [
     opt('-n', '--number', type =3D 'int',
         short =3D 'Uncommit the specified number of commits'),
-    opt('-t', '--to', short =3D 'Uncommit to the specified commit'),
+    opt('-t', '--to', args =3D [argparse.commit],
+        short =3D 'Uncommit to the specified commit'),
     opt('-x', '--exclusive', action =3D 'store_true',
         short =3D 'Exclude the commit specified by the --to option')]
=20
diff --git a/stgit/commands/undo.py b/stgit/commands/undo.py
index b7b1b73..6a04363 100644
--- a/stgit/commands/undo.py
+++ b/stgit/commands/undo.py
@@ -29,6 +29,7 @@ description =3D """
 Reset the patch stack to the previous state. Consecutive invocations
 of "stg undo" will take you ever further into the past."""
=20
+args =3D []
 options =3D [
     opt('-n', '--number', type =3D 'int', metavar =3D 'N', default =3D=
 1,
         short =3D 'Undo the last N commands'),
diff --git a/stgit/commands/unhide.py b/stgit/commands/unhide.py
index acfef29..0c0832a 100644
--- a/stgit/commands/unhide.py
+++ b/stgit/commands/unhide.py
@@ -20,7 +20,7 @@ from stgit.argparse import opt
 from stgit.commands.common import *
 from stgit.utils import *
 from stgit.out import *
-from stgit import stack, git
+from stgit import argparse, stack, git
=20
 help =3D 'Unhide a hidden patch'
 kind =3D 'stack'
@@ -29,8 +29,9 @@ description =3D """
 Unhide a hidden range of patches so that they are shown in the plain
 'stg series' command output."""
=20
+args =3D [argparse.patch_range(argparse.hidden_patches)]
 options =3D [
-    opt('-b', '--branch',
+    opt('-b', '--branch', args =3D [argparse.stg_branches],
         short =3D 'Use BRANCH instead of the default branch')]
=20
 directory =3D DirectoryHasRepository(log =3D True)
diff --git a/stgit/completion.py b/stgit/completion.py
new file mode 100644
index 0000000..e461e3b
--- /dev/null
+++ b/stgit/completion.py
@@ -0,0 +1,140 @@
+import textwrap
+import stgit.commands
+from stgit import argparse
+
+def fun(name, *body):
+    return ['%s ()' % name, '{', list(body), '}']
+
+def fun_desc(name, desc, *body):
+    return ['# %s' % desc] + fun(name, *body)
+
+def flatten(stuff, sep):
+    r =3D stuff[0]
+    for s in stuff[1:]:
+        r.append(sep)
+        r.extend(s)
+    return r
+
+def write(f, stuff, indent =3D 0):
+    for s in stuff:
+        if isinstance(s, str):
+            f.write((' '*4*indent + s).rstrip() + '\n')
+        else:
+            write(f, s, indent + 1)
+
+def patch_list_fun(type):
+    return fun('_%s_patches' % type, 'local g=3D$(_gitdir)',
+               'test "$g" && cat "$g/patches/$(_current_branch)/%s"' %=
 type)
+
+def file_list_fun(name, cmd):
+    return fun('_%s_files' % name, 'local g=3D$(_gitdir)',
+               'test "$g" && %s' % cmd)
+
+def ref_list_fun(name, prefix):
+    return fun(name, 'local g=3D$(_gitdir)',
+               ("test \"$g\" && git show-ref | grep ' %s/' | sed 's,.*=
 %s/,,'"
+                % (prefix, prefix)))
+
+def util():
+    r =3D [fun_desc('_gitdir',
+                  "The path to .git, or empty if we're not in a reposi=
tory.",
+                  'echo "$(git rev-parse --git-dir 2>/dev/null)"'),
+         fun_desc('_current_branch',
+                  "Name of the current branch, or empty if there isn't=
 one.",
+                  'local b=3D$(git symbolic-ref HEAD 2>/dev/null)',
+                  'echo ${b#refs/heads/}'),
+         fun_desc('_other_applied_patches',
+                  'List of all applied patches except the current patc=
h.',
+                  'local b=3D$(_current_branch)',
+                  'local g=3D$(_gitdir)',
+                  ('test "$g" && cat "$g/patches/$b/applied" | grep -v=
'
+                   ' "^$(tail -n 1 $g/patches/$b/applied 2> /dev/null)=
$"')),
+         fun('_patch_range', 'local patches=3D"$1"', 'local cur=3D"$2"=
',
+             'case "$cur" in', [
+                '*..*)', ['local pfx=3D"${cur%..*}.."', 'cur=3D"${cur#=
*..}"',
+                          'compgen -P "$pfx" -W "$patches" -- "$cur"',=
 ';;'],
+                '*)', ['compgen -W "$patches" -- "$cur"', ';;']],
+             'esac'),
+         fun('_stg_branches',
+             'local g=3D$(_gitdir)', 'test "$g" && (cd $g/patches/ && =
echo *)'),
+         ref_list_fun('_all_branches', 'refs/heads'),
+         ref_list_fun('_tags', 'refs/tags'),
+         ref_list_fun('_remotes', 'refs/remotes')]
+    for type in ['applied', 'unapplied', 'hidden']:
+        r.append(patch_list_fun(type))
+    for name, cmd in [('conflicting',
+                       r"git ls-files --unmerged | sed 's/.*\t//g' | s=
ort -u"),
+                      ('dirty', 'git diff-index --name-only HEAD'),
+                      ('unknown', 'git ls-files --others --exclude-sta=
ndard'),
+                      ('known', 'git ls-files')]:
+        r.append(file_list_fun(name, cmd))
+    return flatten(r, '')
+
+def command_list(commands):
+    return ['_stg_commands=3D"%s"\n' % ' '.join(sorted(commands.iterke=
ys()))]
+
+def command_fun(cmd, modname):
+    mod =3D stgit.commands.get_command(modname)
+    def cg(args, flags):
+        return argparse.compjoin(list(args) + [argparse.strings(*flags=
)]
+                                 ).command('$cur')
+    return fun(
+        '_stg_%s' % cmd,
+        'local flags=3D"%s"' % ' '.join(sorted(
+                flag for opt in mod.options
+                for flag in opt.flags if flag.startswith('--'))),
+        'local prev=3D"${COMP_WORDS[COMP_CWORD-1]}"',
+        'local cur=3D"${COMP_WORDS[COMP_CWORD]}"',
+        'case "$prev" in', [
+            '%s) COMPREPLY=3D($(%s)) ;;' % ('|'.join(opt.flags), cg(op=
t.args, []))
+            for opt in mod.options if opt.args] + [
+            '*) COMPREPLY=3D($(%s)) ;;' % cg(mod.args, ['$flags'])],
+        'esac')
+
+def main_switch(commands):
+    return fun(
+        '_stg',
+        'local i',
+        'local c=3D1',
+        'local command',
+        '',
+        'while test $c -lt $COMP_CWORD; do', [
+            'if test $c =3D=3D 1; then', [
+                'command=3D"${COMP_WORDS[c]}"'],
+            'fi',
+            'c=3D$((++c))'],
+        'done',
+        '',
+        ('# Complete name of subcommand if the user has not finished'
+         ' typing it yet.'),
+        'if test $c -eq $COMP_CWORD -a -z "$command"; then', [
+            ('COMPREPLY=3D($(compgen -W "$_stg_commands" --'
+             ' "${COMP_WORDS[COMP_CWORD]}"))'),
+            'return'],
+        'fi',
+        '',
+        '# Complete arguments to subcommands.',
+        'case "$command" in', [
+            '%s) _stg_%s ;;' % (cmd, cmd)
+            for cmd in sorted(commands.iterkeys())],
+        'esac')
+
+def install():
+    return ['complete -o default -F _stg stg']
+
+def write_completion(f):
+    commands =3D stgit.commands.get_commands(allow_cached =3D False)
+    r =3D [["""# -*- shell-script -*-
+# bash completion script for StGit (automatically generated)
+#
+# To use these routines:
+#
+#    1. Copy this file to somewhere (e.g. ~/.stgit-completion.bash).
+#
+#    2. Add the following line to your .bashrc:
+#         . ~/.stgit-completion.bash"""]]
+    r +=3D [util(), command_list(commands)]
+    for cmd, (modname, _, _) in sorted(commands.iteritems()):
+        r.append(command_fun(cmd, modname))
+    r +=3D [main_switch(commands), install()]
+    write(f, flatten(r, ''))
