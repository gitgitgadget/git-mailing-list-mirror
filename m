From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 4/7] "stg series" option to show patch summary descriptions
Date: Tue, 29 Nov 2005 17:09:45 -0500
Message-ID: <20051129220945.9885.51164.stgit@dexter.citi.umich.edu>
References: <20051129220552.9885.41086.stgit@dexter.citi.umich.edu>
Reply-To: Chuck Lever <cel@citi.umich.edu>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 23:13:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhDfi-0006zv-Jt
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 23:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbVK2WJr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 17:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbVK2WJr
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 17:09:47 -0500
Received: from citi.umich.edu ([141.211.133.111]:9831 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932442AbVK2WJp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2005 17:09:45 -0500
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 746881BBDE;
	Tue, 29 Nov 2005 17:09:45 -0500 (EST)
To: catalin.marinas@gmail.com
In-Reply-To: <20051129220552.9885.41086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12965>

Optionally show each patch's short description when listing a series.

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 stgit/commands/series.py |   48 +++++++++++++++++++++++++++++++---------------
 1 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/stgit/commands/series.py b/stgit/commands/series.py
index 032b89e..a843307 100644
--- a/stgit/commands/series.py
+++ b/stgit/commands/series.py
@@ -33,12 +33,31 @@ prefixed with a '>'. Empty patches are p
 
 options = [make_option('-b', '--branch',
                        help = 'use BRANCH instead of the default one'),
+           make_option('-d', '--description',
+                       help = 'show a show description for each patch',
+                       action = 'store_true'),
            make_option('-e', '--empty',
                        help = 'check whether patches are empty '
                        '(much slower)',
                        action = 'store_true') ]
 
 
+def __get_description(patch):
+    """Extract and return a patch's short description
+    """
+    p = crt_series.get_patch(patch)
+    descr = p.get_description().strip()
+    descr_lines = descr.split('\n')
+    return descr_lines[0].rstrip()
+
+def __print_patch(patch, prefix, empty_prefix, length, options):
+    if options.empty and crt_series.empty_patch(patch):
+        prefix = empty_prefix
+    if options.description:
+        print prefix + patch.ljust(length) + '  | ' + __get_description(patch)
+    else:
+        print prefix + patch
+
 def func(parser, options, args):
     """Show the patch series
     """
@@ -46,21 +65,18 @@ def func(parser, options, args):
         parser.error('incorrect number of arguments')
 
     applied = crt_series.get_applied()
+    unapplied = crt_series.get_unapplied()
+    patches = applied + unapplied
+
+    max_len = 0
+    if len(patches) > 0:
+        max_len = max([len(i) for i in patches])
+
     if len(applied) > 0:
         for p in applied [0:-1]:
-            if options.empty and crt_series.empty_patch(p):
-                print '0', p
-            else:
-                print '+', p
-        p = applied[-1]
-
-        if options.empty and crt_series.empty_patch(p):
-            print '0>%s' % p
-        else:
-            print '> %s' % p
-
-    for p in crt_series.get_unapplied():
-        if options.empty and crt_series.empty_patch(p):
-            print '0', p
-        else:
-            print '-', p
+            __print_patch(p, '+ ', '0 ', max_len, options)
+
+        __print_patch(applied[-1], '> ', '0>', max_len, options)
+
+    for p in unapplied:
+        __print_patch(p, '- ', '0 ', max_len, options)
