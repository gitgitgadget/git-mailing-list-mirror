From: Pavel Roskin <proski@gnu.org>
Subject: AssertionError in "stg uncommit" when going too far back
Date: Wed, 05 Mar 2008 16:47:02 -0500
Message-ID: <1204753622.17845.16.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 22:48:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX1Sm-0003Dk-K0
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 22:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753159AbYCEVrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 16:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752239AbYCEVrJ
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 16:47:09 -0500
Received: from c60.cesmail.net ([216.154.195.49]:17434 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752083AbYCEVrI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 16:47:08 -0500
Received: from unknown (HELO relay.cesmail.net) ([192.168.1.81])
  by c60.cesmail.net with ESMTP; 05 Mar 2008 16:47:05 -0500
Received: from [192.168.1.21] (static-72-92-88-10.phlapa.fios.verizon.net [72.92.88.10])
	by relay.cesmail.net (Postfix) with ESMTP id 8281F619058;
	Wed,  5 Mar 2008 16:47:04 -0500 (EST)
X-Mailer: Evolution 2.12.3 (2.12.3-1.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76273>

Hello!

"stg uncommit" causes AssertionError if the number commits to uncommit it too large:

$ stg uncommit -n 10000 
Uncommitting 10000 patches ... Traceback (most recent call last):
  File "/home/proski/bin/stg", line 43, in <module>
    main()
  File "home/proski/lib/python2.5/site-packages/stgit/main.py", line 278, in main
  File "home/proski/lib/python2.5/site-packages/stgit/commands/uncommit.py", line 94, in func
  File "home/proski/lib/python2.5/site-packages/stgit/lib/git.py", line 171, in parent
AssertionError

Perhaps parent() should raise an exception that uncommit would
intercept?  Sorry, my Python is not so good to make a correct fix.
Here's a prototype patch that still doesn't terminate gracefully:

AttributeError: 'module' object has no attribute 'NoParentException'


diff --git a/stgit/commands/uncommit.py b/stgit/commands/uncommit.py
index 933ec60..87dab77 100644
--- a/stgit/commands/uncommit.py
+++ b/stgit/commands/uncommit.py
@@ -21,7 +21,7 @@ from optparse import make_option
 from stgit.commands import common
 from stgit.lib import transaction
 from stgit.out import *
-from stgit import utils
+from stgit import utils, git
 
 help = 'turn regular GIT commits into StGIT patches'
 usage = """%prog [<patchnames>] | -n NUM [<prefix>]] | -t <committish> [-x]
@@ -89,9 +89,12 @@ def func(parser, options, args):
     next_commit = stack.base
     if patch_nr:
         out.start('Uncommitting %d patches' % patch_nr)
-        for i in xrange(patch_nr):
-            commits.append(next_commit)
-            next_commit = next_commit.data.parent
+        try:
+            for i in xrange(patch_nr):
+                commits.append(next_commit)
+                next_commit = next_commit.data.parent
+        except git.NoParentException:
+            raise common.CmdException('Cannot go beyond initial commit')
     else:
         if options.exclusive:
             out.start('Uncommitting to %s (exclusive)' % to_commit)
diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 50dc4f1..d8d339c 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -16,6 +16,9 @@ class DetachedHeadException(RepositoryException):
     def __init__(self):
         RepositoryException.__init__(self, 'Not on any branch')
 
+class NoParentException(exception.StgException):
+    pass
+
 class Repr(object):
     def __repr__(self):
         return str(self)
@@ -168,7 +171,8 @@ class Commitdata(Repr):
     parents = property(lambda self: self.__parents)
     @property
     def parent(self):
-        assert len(self.__parents) == 1
+        if len(self.__parents) != 1:
+            raise NoParentException
         return self.__parents[0]
     author = property(lambda self: self.__author)
     committer = property(lambda self: self.__committer)

-- 
Regards,
Pavel Roskin
