From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit RFC] Make "stg branch -l" faster by getting all git config
	information in one call
Date: Thu, 13 Dec 2007 14:38:36 +0100
Message-ID: <20071213133653.13925.89254.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Thu Dec 13 14:38:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2oGy-0005tD-HT
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 14:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbXLMNiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 08:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753496AbXLMNiV
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 08:38:21 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:43652 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581AbXLMNiU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 08:38:20 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 12B10200A20C;
	Thu, 13 Dec 2007 14:38:19 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 06919-01-11; Thu, 13 Dec 2007 14:38:18 +0100 (CET)
Received: from krank (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 8AA2D200A209;
	Thu, 13 Dec 2007 14:38:18 +0100 (CET)
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by krank (Postfix) with ESMTP id 636837B406D;
	Thu, 13 Dec 2007 14:38:36 +0100 (CET)
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68150>

This isn't a real patch yet, but it is good enough for my usage.

I have a fair amount of branches, and I noticed that "stg branch -l"
takes ridiculously long to finish. The problem is that it creates
stack objects for all branches, and indiviudally extract information
about them one after one.  With 20 branches, it took almost 2 seconds
to run.  Compare that with the 0.01 seconds it takes to run "git
branch".

I made a patch that uses "git config --get-regexp" to get the
description and stgit.stackformatversion options for all branches at
once, and ignore the "protected" flag that I don't use. With this
change, I'm almost down to half a second, which almost makes it
usable.

There are still a bunch of redundant invokations of git, but python
startup times are hard to get around.

Maybe someone can help me find a quicker replacement for the
get_protected call?

---

 stgit/commands/branch.py |   39 ++++++++++++++++++++++++++++++---------
 1 files changed, 30 insertions(+), 9 deletions(-)


diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index 50684bb..f4b0c33 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -72,21 +72,21 @@ options = [make_option('-c', '--create',
 def __is_current_branch(branch_name):
     return crt_series.get_name() == branch_name
 
-def __print_branch(branch_name, length):
+def __print_branch(branch_name, description, version, length):
     initialized = ' '
     current = ' '
     protected = ' '
 
-    branch = stack.Series(branch_name)
+    #branch = stack.Series(branch_name)
 
-    if branch.is_initialised():
+    if version != None:
         initialized = 's'
     if __is_current_branch(branch_name):
         current = '>'
-    if branch.get_protected():
-        protected = 'p'
+    #if branch.get_protected():
+    #    protected = 'p'
     out.stdout(current + ' ' + initialized + protected + '\t'
-               + branch_name.ljust(length) + '  | ' + branch.get_description())
+               + branch_name.ljust(length) + '  | ' + (description or ''))
 
 def __delete_branch(doomed_name, force = False):
     doomed = stack.Series(doomed_name)
@@ -100,6 +100,23 @@ def __delete_branch(doomed_name, force = False):
     doomed.delete(force)
     out.done()
 
+class FormatException(StgException):
+    pass
+
+def __get_all_branch_config(key):
+    key = re.escape(key)
+    lines = git.GRun('config', '--get-regexp',
+                     r'branch\..*\.'+key).returns([0,1]).output_lines()
+    val_re = re.compile(r'branch\.(.*)\.%s (.*)' % key)
+    result = {}
+    for line in lines:
+        m = val_re.match(line)
+        if not m:
+            raise FormatException("unknown output from git config")
+        branch, data = m.groups()
+        result[branch] = data
+    return result
+
 def func(parser, options, args):
 
     if options.create:
@@ -198,11 +215,15 @@ def func(parser, options, args):
         branches = git.get_heads()
         branches.sort()
 
+        descriptions = __get_all_branch_config('description')
+        versions = __get_all_branch_config('stgit.stackformatversion')
+
         if branches:
             out.info('Available branches:')
-            max_len = max([len(i) for i in branches])
-            for i in branches:
-                __print_branch(i, max_len)
+            max_len = max(len(i) for i in branches)
+            for branch in branches:
+                __print_branch(branch, descriptions.get(branch),
+                               versions.get(branch), max_len)
         else:
             out.info('No branches')
         return
