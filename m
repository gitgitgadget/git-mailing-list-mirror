From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH 9/9] Use the default git colouring scheme rather than
	specific scripts
Date: Tue, 28 Apr 2009 16:10:25 +0100
Message-ID: <20090428151025.27261.15964.stgit@pc1117.cambridge.arm.com>
References: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 17:13:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyp07-0002lt-2U
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 17:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762151AbZD1PLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 11:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762145AbZD1PLR
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 11:11:17 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:49026 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761966AbZD1PLP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2009 11:11:15 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id n3SF7KZm027095;
	Tue, 28 Apr 2009 16:07:20 +0100 (BST)
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Apr 2009 16:11:12 +0100
In-Reply-To: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com>
User-Agent: StGit/0.14.3.375.g65f9.dirty
X-OriginalArrivalTime: 28 Apr 2009 15:11:12.0173 (UTC) FILETIME=[91238DD0:01C9C813]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117782>

This patch adds the mechanism to check if the output is tty for the
diff and show commands and passes the --color option to git if the
color.diff config option is set auto or true. The patch also changes the
default pager to 'less -FRSX' from the diffcol.sh script.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 contrib/diffcol.sh       |   51 ----------------------------------------------
 examples/gitconfig       |    4 ++--
 setup.py                 |    3 +--
 stgit/commands/common.py |    8 +++++++
 stgit/commands/diff.py   |    2 ++
 stgit/commands/show.py   |    1 +
 stgit/config.py          |   10 +++++----
 7 files changed, 19 insertions(+), 60 deletions(-)
 delete mode 100755 contrib/diffcol.sh

diff --git a/contrib/diffcol.sh b/contrib/diffcol.sh
deleted file mode 100755
index eecc87a..0000000
--- a/contrib/diffcol.sh
+++ /dev/null
@@ -1,51 +0,0 @@
-#!/bin/bash
-
-# Code copied from Quilt (http://savannah.nongnu.org/projects/quilt)
-#
-# Copyright 2006 - the Quilt authors
-#
-#  This script is free software; you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License version 2 as
-#  published by the Free Software Foundation.
-
-setup_colors()
-{
-	local C="diffhdr=1;36:diffhdradd=1;32:diffadd=32:diffhdrmod=1;35:diffmod=35:diffhdrrem=1;31:diffrem=31:diffhunk=36:diffctx=34:diffcctx=33:default=0"
-	[ -n "$DIFF_COLORS" ] && C="$C:$DIFF_COLORS"
-
-	C=${C//=/=\'$'\e'[}
-	C=col${C//:/m\'; col}m\'
-	#coldefault=$(tput op)
-	eval $C
-}
-
-setup_colors
-
-gawk '{
-	if (/^(Index:|diff --git) /)
-		print "'$coldiffhdr'" $0 "'$coldefault'"
-	else if (/^======*$/)
-		print "'$coldiffhdr'" $0 "'$coldefault'"
-	else if (/^\+\+\+/)
-		print "'$coldiffhdradd'" $0 "'$coldefault'"
-	else if (/^\*\*\*/)
-		print "'$coldiffhdrmod'" $0 "'$coldefault'"
-	else if (/^---/)
-		print "'$coldiffhdrrem'" $0 "'$coldefault'"
-	else if (/^(\+|new( file)? mode )/)
-		print "'$coldiffadd'" $0 "'$coldefault'"
-	else if (/^(-|(deleted file|old) mode )/)
-		print "'$coldiffrem'" $0 "'$coldefault'"
-	else if (/^!/)
-		print "'$coldiffmod'" $0 "'$coldefault'"
-	else if (/^@@ \-[0-9]+(,[0-9]+)? \+[0-9]+(,[0-9]+)? @@/)
-		print gensub(/^(@@[^@]*@@)([ \t]*)(.*)/,
-			"'$coldiffhunk'" "\\1" "'$coldefault'" \
-			"\\2" \
-			"'$coldiffctx'" "\\3" "'$coldefault'", "")
-	else if (/^\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/)
-		print "'$coldiffcctx'" $0 "'$coldefault'"
-	else {
-		print
-	}
-}' $1 | less -R -S
diff --git a/examples/gitconfig b/examples/gitconfig
index f6e3a79..e235e14 100644
--- a/examples/gitconfig
+++ b/examples/gitconfig
@@ -42,8 +42,8 @@
 	#editor = /usr/bin/vi
 
 	# this value overrides the default PAGER environment variable
-	#pager = ~/share/stgit/contrib/diffcol.sh
-	#pager = filterdiff --annotate | colordiff | less -FRX
+	#pager = less -FRSX
+	#pager = filterdiff --annotate | colordiff | less -FRSX
 
 	# GIT pull and fetch commands (should take the same arguments as
 	# git fetch or git pull).  By default:
diff --git a/setup.py b/setup.py
index fb67958..73ce2e5 100755
--- a/setup.py
+++ b/setup.py
@@ -58,8 +58,7 @@ def __run_setup():
             ('share/stgit/templates', glob.glob('templates/*.tmpl')),
             ('share/stgit/examples', glob.glob('examples/*.tmpl')),
             ('share/stgit/examples', ['examples/gitconfig']),
-            ('share/stgit/contrib', ['contrib/diffcol.sh',
-                                     'contrib/stgbashprompt.sh']),
+            ('share/stgit/contrib', ['contrib/stgbashprompt.sh']),
             ('share/stgit/completion', ['stgit-completion.bash'])
             ])
 
diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 6bb3685..e46412e 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -83,6 +83,14 @@ def git_commit(name, repository, branch_name = None):
     except libgit.RepositoryException:
         raise CmdException('%s: Unknown patch or revision name' % name)
 
+def color_diff_flags():
+    """Return the git flags for coloured diff output if the configuration and
+    stdout allows."""
+    if sys.stdout.isatty() and config.get('color.diff') in ['true', 'auto']:
+        return ['--color']
+    else:
+        return []
+
 def check_local_changes():
     if git.local_changes():
         raise CmdException('local changes in the tree. Use "refresh" or'
diff --git a/stgit/commands/diff.py b/stgit/commands/diff.py
index 7d2f719..8b8ebe3 100644
--- a/stgit/commands/diff.py
+++ b/stgit/commands/diff.py
@@ -72,6 +72,8 @@ def func(parser, options, args):
         rev1 = 'HEAD'
         rev2 = None
 
+    if not options.stat:
+        options.diff_flags.extend(color_diff_flags())
     diff_str = git.diff(args, git_id(crt_series, rev1),
                         rev2 and git_id(crt_series, rev2),
                         diff_flags = options.diff_flags)
diff --git a/stgit/commands/show.py b/stgit/commands/show.py
index 895943a..b7a8aa9 100644
--- a/stgit/commands/show.py
+++ b/stgit/commands/show.py
@@ -61,6 +61,7 @@ def func(parser, options, args):
         # individual patches or commit ids
         patches = args
 
+    options.diff_flags.extend(color_diff_flags())
     commit_ids = [git_id(crt_series, patch) for patch in patches]
     commit_str = '\n'.join([git.pretty_commit(commit_id,
                                               flags = options.diff_flags)
diff --git a/stgit/config.py b/stgit/config.py
index efce097..4f16978 100644
--- a/stgit/config.py
+++ b/stgit/config.py
@@ -37,7 +37,8 @@ class GitConfig:
         'stgit.autoimerge':	'no',
         'stgit.keepoptimized':	'no',
         'stgit.extensions':	'.ancestor .current .patched',
-        'stgit.shortnr':	 '5'
+        'stgit.shortnr': '5',
+        'stgit.pager':  'less -FRSX'
         }
 
     __cache={}
@@ -109,10 +110,9 @@ config=GitConfig()
 def config_setup():
     global config
 
-    # Set the PAGER environment to the config value (if any)
-    pager = config.get('stgit.pager')
-    if pager:
-        os.environ['PAGER'] = pager
+    # Set the PAGER environment to the config value if not already set
+    if not 'PAGER' in os.environ:
+        os.environ['PAGER'] = config.get('stgit.pager')
     # FIXME: handle EDITOR the same way ?
 
 class ConfigOption:
