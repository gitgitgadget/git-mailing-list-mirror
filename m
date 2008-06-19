From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGIT PATCH 3/4] Convert git_id() to the new id format
Date: Thu, 19 Jun 2008 22:42:22 +0100
Message-ID: <20080619214222.27794.74083.stgit@localhost.localdomain>
References: <20080619214023.27794.97039.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 23:43:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Ruj-0005eT-QS
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 23:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356AbYFSVm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 17:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754498AbYFSVm3
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 17:42:29 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:28361 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754356AbYFSVm1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jun 2008 17:42:27 -0400
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com with ESMTP
          id <20080619214807.FVAB16629.mtaout03-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Thu, 19 Jun 2008 22:48:07 +0100
Received: from localhost.localdomain ([86.7.22.36])
          by aamtaout02-winn.ispmail.ntl.com with ESMTP
          id <20080619214534.IREB29365.aamtaout02-winn.ispmail.ntl.com@localhost.localdomain>;
          Thu, 19 Jun 2008 22:45:34 +0100
In-Reply-To: <20080619214023.27794.97039.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3.163.g06f9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85542>

The patch rewrites git_id() to use the new id format and coverts the
commands using this function. The git_id() will be removed once all the
commands are converted to the new infrastructure where git_commit() will
be used instead.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 stgit/commands/common.py  |   97 ++++++++-------------------------------------
 stgit/commands/diff.py    |   21 ++++------
 stgit/commands/files.py   |   10 ++---
 stgit/commands/mail.py    |    8 ++--
 stgit/commands/pick.py    |   10 ++---
 stgit/commands/refresh.py |    4 +-
 stgit/commands/series.py  |    4 +-
 t/t2000-sync.sh           |    2 -
 8 files changed, 43 insertions(+), 113 deletions(-)

diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 349389f..3e1d2d0 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -35,101 +35,38 @@ class CmdException(StgException):
     pass
 
 # Utility functions
-class RevParseException(StgException):
-    """Revision spec parse error."""
-    pass
-
 def parse_rev(rev):
-    """Parse a revision specification into its
-    patchname@branchname//patch_id parts. If no branch name has a slash
-    in it, also accept / instead of //."""
-    if '/' in ''.join(git.get_heads()):
-        # We have branch names with / in them.
-        branch_chars = r'[^@]'
-        patch_id_mark = r'//'
-    else:
-        # No / in branch names.
-        branch_chars = r'[^@/]'
-        patch_id_mark = r'(/|//)'
-    patch_re = r'(?P<patch>[^@/]+)'
-    branch_re = r'@(?P<branch>%s+)' % branch_chars
-    patch_id_re = r'%s(?P<patch_id>[a-z.]*)' % patch_id_mark
-
-    # Try //patch_id.
-    m = re.match(r'^%s$' % patch_id_re, rev)
-    if m:
-        return None, None, m.group('patch_id')
-
-    # Try path[@branch]//patch_id.
-    m = re.match(r'^%s(%s)?%s$' % (patch_re, branch_re, patch_id_re), rev)
-    if m:
-        return m.group('patch'), m.group('branch'), m.group('patch_id')
-
-    # Try patch[@branch].
-    m = re.match(r'^%s(%s)?$' % (patch_re, branch_re), rev)
-    if m:
-        return m.group('patch'), m.group('branch'), None
-
-    # No, we can't parse that.
-    raise RevParseException
+    """Parse a revision specification into its branch:patch parts.
+    """
+    try:
+        branch, patch = rev.split(':', 1)
+    except ValueError:
+        branch = None
+        patch = rev
+
+    return (branch, patch)
 
 def git_id(crt_series, rev):
     """Return the GIT id
     """
+    # TODO: remove this function once all the occurrences were converted
+    # to git_commit()
     if not rev:
+        # backwards compatibility
         return None
+    repository = libstack.Repository.default()
+    return git_commit(rev, repository, crt_series.get_name()).sha1
 
-    # try a GIT revision first
-    try:
-        return git.rev_parse(rev + '^{commit}')
-    except git.GitException:
-        pass
-
-    # try an StGIT patch name
-    try:
-        patch, branch, patch_id = parse_rev(rev)
-        if branch == None:
-            series = crt_series
-        else:
-            series = stack.Series(branch)
-        if patch == None:
-            patch = series.get_current()
-            if not patch:
-                raise CmdException, 'No patches applied'
-        if patch in series.get_applied() or patch in series.get_unapplied() or \
-               patch in series.get_hidden():
-            if patch_id in ['top', '', None]:
-                return series.get_patch(patch).get_top()
-            elif patch_id == 'bottom':
-                return series.get_patch(patch).get_bottom()
-            elif patch_id == 'top.old':
-                return series.get_patch(patch).get_old_top()
-            elif patch_id == 'bottom.old':
-                return series.get_patch(patch).get_old_bottom()
-            elif patch_id == 'log':
-                return series.get_patch(patch).get_log()
-        if patch == 'base' and patch_id == None:
-            return series.get_base()
-    except RevParseException:
-        pass
-    except stack.StackException:
-        pass
-
-    raise CmdException, 'Unknown patch or revision: %s' % rev
-
-def git_commit(name, repository, branch = None):
+def git_commit(name, repository, branch_name = None):
     """Return the a Commit object if 'name' is a patch name or Git commit.
     The patch names allowed are in the form '<branch>:<patch>' and can be
     followed by standard symbols used by git-rev-parse. If <patch> is '{base}',
     it represents the bottom of the stack.
     """
     # Try a [branch:]patch name first
-    try:
-        branch, patch = name.split(':', 1)
-    except ValueError:
-        patch = name
+    branch, patch = parse_rev(name)
     if not branch:
-        branch = repository.current_branch_name
+        branch = branch_name or repository.current_branch_name
 
     # The stack base
     if patch == '{base}':
diff --git a/stgit/commands/diff.py b/stgit/commands/diff.py
index fd6be34..4ae9b49 100644
--- a/stgit/commands/diff.py
+++ b/stgit/commands/diff.py
@@ -30,17 +30,14 @@ help = 'show the tree diff'
 usage = """%prog [options] [<files or dirs>]
 
 Show the diff (default) or diffstat between the current working copy
-or a tree-ish object and another tree-ish object. File names can also
-be given to restrict the diff output. The tree-ish object can be a
-standard git commit, tag or tree. In addition to these, the command
-also supports 'base', representing the bottom of the current stack,
-and '[patch][//[bottom | top]]' for the patch boundaries (defaulting to
-the current one):
+or a tree-ish object and another tree-ish object (defaulting to HEAD).
+File names can also be given to restrict the diff output. The
+tree-ish object can be an StGIT patch, a standard git commit, tag or
+tree. In addition to these, the command also supports '{base}',
+representing the bottom of the current stack.
 
-rev = '([patch][//[bottom | top]]) | <tree-ish> | base'
-
-If neither bottom nor top are given but a '//' is present, the command
-shows the specified patch (defaulting to the current one)."""
+rev = '([branch:]patch) | <tree-ish> | base'
+"""
 
 directory = DirectoryHasRepository()
 options = [make_option('-r', '--range',
@@ -67,8 +64,8 @@ def func(parser, options, args):
                 rev = strip_suffix('/', rev)
                 if rev.endswith('/'):
                     rev = strip_suffix('/', rev)
-                rev1 = rev + '//bottom'
-                rev2 = rev + '//top'
+                rev1 = rev + 'HEAD^'
+                rev2 = rev + 'HEAD'
             else:
                 rev1 = rev_list[0]
                 rev2 = None
diff --git a/stgit/commands/files.py b/stgit/commands/files.py
index b43b12f..d240872 100644
--- a/stgit/commands/files.py
+++ b/stgit/commands/files.py
@@ -26,7 +26,7 @@ from stgit import stack, git
 
 
 help = 'show the files modified by a patch (or the current patch)'
-usage = """%prog [options] [<patch>]
+usage = """%prog [options] [[<branch>:]<patch>]
 
 List the files modified by the given patch (defaulting to the current
 one). Passing the '--stat' option shows the diff statistics for the
@@ -38,8 +38,6 @@ directory = DirectoryHasRepository()
 options = [make_option('-s', '--stat',
                        help = 'show the diff stat',
                        action = 'store_true'),
-           make_option('-b', '--branch',
-                       help = 'use BRANCH instead of the default one'),
            make_option('--bare',
                        help = 'bare file names (useful for scripting)',
                        action = 'store_true')
@@ -50,14 +48,14 @@ def func(parser, options, args):
     """Show the files modified by a patch (or the current patch)
     """
     if len(args) == 0:
-        patch = ''
+        patch = 'HEAD'
     elif len(args) == 1:
         patch = args[0]
     else:
         parser.error('incorrect number of arguments')
 
-    rev1 = git_id(crt_series, '%s//bottom' % patch)
-    rev2 = git_id(crt_series, '%s//top' % patch)
+    rev1 = git_id(crt_series, '%s^' % patch)
+    rev2 = git_id(crt_series, '%s' % patch)
 
     if options.stat:
         out.stdout_raw(git.diffstat(git.diff(rev1 = rev1, rev2 = rev2)) + '\n')
diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index c87d67e..e04dc2f 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -383,8 +383,8 @@ def __build_cover(tmpl, patches, msg_id, options):
                  'shortlog':     stack.shortlog(crt_series.get_patch(p)
                                                 for p in patches),
                  'diffstat':     git.diffstat(git.diff(
-                     rev1 = git_id(crt_series, '%s//bottom' % patches[0]),
-                     rev2 = git_id(crt_series, '%s//top' % patches[-1])))}
+                     rev1 = git_id(crt_series, '%s^' % patches[0]),
+                     rev2 = git_id(crt_series, '%s' % patches[-1])))}
 
     try:
         msg_string = tmpl % tmpl_dict
@@ -460,8 +460,8 @@ def __build_message(tmpl, patch, patch_nr, total_nr, msg_id, ref_id, options):
     else:
         number_str = ''
 
-    diff = git.diff(rev1 = git_id(crt_series, '%s//bottom' % patch),
-                    rev2 = git_id(crt_series, '%s//top' % patch),
+    diff = git.diff(rev1 = git_id(crt_series, '%s^' % patch),
+                    rev2 = git_id(crt_series, '%s' % patch),
                     diff_flags = options.diff_flags)
     tmpl_dict = {'patch':        patch,
                  'sender':       sender,
diff --git a/stgit/commands/pick.py b/stgit/commands/pick.py
index 1f7c84b..2a670e8 100644
--- a/stgit/commands/pick.py
+++ b/stgit/commands/pick.py
@@ -87,8 +87,8 @@ def __pick_commit(commit_id, patchname, options):
 
         out.done()
     elif options.update:
-        rev1 = git_id(crt_series, '//bottom')
-        rev2 = git_id(crt_series, '//top')
+        rev1 = git_id(crt_series, 'HEAD^')
+        rev2 = git_id(crt_series, 'HEAD')
         files = git.barefiles(rev1, rev2).split('\n')
 
         out.start('Updating with commit %s' % commit_id)
@@ -115,10 +115,8 @@ def __pick_commit(commit_id, patchname, options):
         patchname = newpatch.get_name()
 
         # find a patchlog to fork from
-        (refpatchname, refbranchname, refpatchid) = parse_rev(patchname)
-        if refpatchname and not refpatchid and \
-               (not refpatchid or refpatchid == 'top'):
-            # FIXME: should also support picking //top.old
+        refbranchname, refpatchname = parse_rev(patchname)
+        if refpatchname:
             if refbranchname:
                 # assume the refseries is OK, since we already resolved
                 # commit_str to a git_id
diff --git a/stgit/commands/refresh.py b/stgit/commands/refresh.py
index 4695c62..73e4ee0 100644
--- a/stgit/commands/refresh.py
+++ b/stgit/commands/refresh.py
@@ -103,8 +103,8 @@ def func(parser, options, args):
             between = applied[:applied.index(patch):-1]
             pop_patches(crt_series, between, keep = True)
         elif options.update:
-            rev1 = git_id(crt_series, '//bottom')
-            rev2 = git_id(crt_series, '//top')
+            rev1 = git_id(crt_series, 'HEAD^')
+            rev2 = git_id(crt_series, 'HEAD')
             patch_files = git.barefiles(rev1, rev2).split('\n')
             files = [f for f in files if f in patch_files]
             if not files:
diff --git a/stgit/commands/series.py b/stgit/commands/series.py
index 04183bd..c11c74f 100644
--- a/stgit/commands/series.py
+++ b/stgit/commands/series.py
@@ -88,7 +88,7 @@ def __print_patch(stack, patch, branch_str, prefix, empty_prefix, length, option
     elif options.empty and stack.patches.get(patch).is_empty():
         prefix = empty_prefix
 
-    patch_str = patch + branch_str
+    patch_str = branch_str + patch
 
     if options.description or options.author:
         patch_str = patch_str.ljust(length)
@@ -164,7 +164,7 @@ def func(parser, options, args):
         return
 
     if options.showbranch:
-        branch_str = '@' + stack.name
+        branch_str = stack.name + ':'
     else:
         branch_str = ''
 
diff --git a/t/t2000-sync.sh b/t/t2000-sync.sh
index e489603..4a00c56 100755
--- a/t/t2000-sync.sh
+++ b/t/t2000-sync.sh
@@ -37,7 +37,7 @@ test_expect_success \
 test_expect_success \
     'Create a branch with empty patches' \
     '
-    stg branch -c foo base &&
+    stg branch -c foo {base} &&
     stg new p1 -m p1 &&
     stg new p2 -m p2 &&
     stg new p3 -m p3 &&
