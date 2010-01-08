From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH 2/3] Add support for command aliases
Date: Fri, 08 Jan 2010 12:36:04 +0000
Message-ID: <20100108123604.24161.25653.stgit@pc1117.cambridge.arm.com>
References: <20100108123403.24161.3495.stgit@pc1117.cambridge.arm.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 13:36:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTE4f-00082t-4X
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 13:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133Ab0AHMgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 07:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752615Ab0AHMgJ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 07:36:09 -0500
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:40771 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751489Ab0AHMgI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2010 07:36:08 -0500
Received: from cam-owa1.Emea.Arm.com (cam-owa1.emea.arm.com [10.1.255.62])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id o08Ca5eI002305;
	Fri, 8 Jan 2010 12:36:05 GMT
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa1.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Fri, 8 Jan 2010 12:36:05 +0000
In-Reply-To: <20100108123403.24161.3495.stgit@pc1117.cambridge.arm.com>
User-Agent: StGit/0.15-36-g53e3
X-OriginalArrivalTime: 08 Jan 2010 12:36:05.0130 (UTC) FILETIME=[250BBEA0:01CA905F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136429>

This patch introduces support StGit command aliases with a few defaults:

stg add		-> git add
stg rm		-> git rm
stg mv		-> git mv
stg resolved	-> git add

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/commands/__init__.py |    3 ++-
 stgit/config.py            |   11 ++++++++++-
 stgit/main.py              |   35 ++++++++++++++++++++++++++++++++++-
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/stgit/commands/__init__.py b/stgit/commands/__init__.py
index f6cf3c3..f9de42b 100644
--- a/stgit/commands/__init__.py
+++ b/stgit/commands/__init__.py
@@ -28,7 +28,8 @@ def get_command(mod):
 _kinds = [('repo', 'Repository commands'),
           ('stack', 'Stack (branch) commands'),
           ('patch', 'Patch commands'),
-          ('wc', 'Index/worktree commands')]
+          ('wc', 'Index/worktree commands'),
+          ('alias', 'Alias commands')]
 _kind_order = [kind for kind, desc in _kinds]
 _kinds = dict(_kinds)
 
diff --git a/stgit/config.py b/stgit/config.py
index 811138d..dd194d3 100644
--- a/stgit/config.py
+++ b/stgit/config.py
@@ -36,7 +36,11 @@ class GitConfig:
         'stgit.autoimerge':     ['no'],
         'stgit.keepoptimized':  ['no'],
         'stgit.shortnr':        ['5'],
-        'stgit.pager':          ['less']
+        'stgit.pager':          ['less'],
+        'stgit.alias.add':      ['git add'],
+        'stgit.alias.rm':       ['git rm'],
+        'stgit.alias.mv':       ['git mv'],
+        'stgit.alias.resolved': ['git add']
         }
 
     __cache = None
@@ -76,6 +80,11 @@ class GitConfig:
         else:
             raise GitConfigException, 'Value for "%s" is not an integer: "%s"' % (name, value)
 
+    def getstartswith(self, name):
+        self.load()
+        return ((n, v[-1]) for (n, v) in self.__cache.iteritems()
+                if n.startswith(name))
+
     def rename_section(self, from_name, to_name):
         """Rename a section in the config file. Silently do nothing if
         the section doesn't exist."""
diff --git a/stgit/main.py b/stgit/main.py
index e324179..d5be70b 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -23,6 +23,30 @@ import sys, os, traceback
 import stgit.commands
 from stgit.out import *
 from stgit import argparse, run, utils
+from stgit.config import config
+
+class CommandAlias(object):
+    def __init__(self, name, command):
+        self.__command = command
+        self.__name__ = name
+        self.usage = ['<arguments>']
+        self.help = 'Alias for "%s <arguments>".' % self.__command
+        self.options = []
+
+    def func(self, args):
+        cmd = self.__command.split() + args
+        p = run.Run(*cmd)
+        p.discard_exitcode().run()
+        return p.exitcode
+
+def is_cmd_alias(cmd):
+    return isinstance(cmd, CommandAlias)
+
+def append_alias_commands(cmd_list):
+    for (name, command) in config.getstartswith('stgit.alias.'):
+        name = utils.strip_prefix('stgit.alias.', name)
+        cmd_list[name] = (CommandAlias(name, command),
+                          'Alias commands', command)
 
 #
 # The commands map
@@ -49,9 +73,13 @@ class Commands(dict):
         
     def __getitem__(self, key):
         cmd_mod = self.get(key) or self.get(self.canonical_cmd(key))
-        return stgit.commands.get_command(cmd_mod)
+        if is_cmd_alias(cmd_mod):
+            return cmd_mod
+        else:
+            return stgit.commands.get_command(cmd_mod)
 
 cmd_list = stgit.commands.get_commands()
+append_alias_commands(cmd_list)
 commands = Commands((cmd, mod) for cmd, (mod, kind, help)
                     in cmd_list.iteritems())
 
@@ -100,6 +128,8 @@ def _main():
             sys.argv[0] += ' %s' % cmd
             command = commands[cmd]
             parser = argparse.make_option_parser(command)
+            if is_cmd_alias(command):
+                parser.remove_option('-h')
             from pydoc import pager
             pager(parser.format_help())
         else:
@@ -121,6 +151,9 @@ def _main():
     del(sys.argv[1])
 
     command = commands[cmd]
+    if is_cmd_alias(command):
+        sys.exit(command.func(sys.argv[1:]))
+
     parser = argparse.make_option_parser(command)
     options, args = parser.parse_args()
     directory = command.directory
