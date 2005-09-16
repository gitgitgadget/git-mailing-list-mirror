From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [patch 05/11] Make "stg files" output match "quilt files" one
Date: Fri, 16 Sep 2005 21:35:17 +0200
Message-ID: <20050916193517.18681.71959.stgit@zion.home.lan>
References: <20050916193511.18681.24189.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 21:40:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGM2W-0005pe-C6
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 21:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965309AbVIPTi0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 15:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965308AbVIPTi0
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 15:38:26 -0400
Received: from ppp-62-11-79-165.dialup.tiscali.it ([62.11.79.165]:27531 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965307AbVIPTiZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 15:38:25 -0400
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id C1DE228547;
	Fri, 16 Sep 2005 21:35:17 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20050916193511.18681.24189.stgit@zion.home.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8717>

I'm used to doing vi $(quilt files), which is impossible with stgit.
Add an option (-b/--base) to request the normal behaviour, but make it
non-default as the current output is useful.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 stgit/commands/files.py |    5 +++++
 stgit/git.py            |   10 ++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/stgit/commands/files.py b/stgit/commands/files.py
--- a/stgit/commands/files.py
+++ b/stgit/commands/files.py
@@ -35,6 +35,9 @@ command. Use the 'diff' or 'status' comm
 
 options = [make_option('-s', '--stat',
                        help = 'show the diff stat',
+                       action = 'store_true'),
+           make_option('-b', '--bare',
+                       help = 'bare file names (useful for scripting)',
                        action = 'store_true')]
 
 
@@ -53,5 +56,7 @@ def func(parser, options, args):
 
     if options.stat:
         print git.diffstat(rev1 = rev1, rev2 = rev2)
+    elif options.bare:
+        print git.barefiles(rev1, rev2)
     else:
         print git.files(rev1, rev2)
diff --git a/stgit/git.py b/stgit/git.py
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -410,6 +410,16 @@ def files(rev1, rev2):
 
     return str.rstrip()
 
+def barefiles(rev1, rev2):
+    """Return the files modified between rev1 and rev2, without status info
+    """
+
+    str = ''
+    for line in _output_lines('git-diff-tree -r %s %s' % (rev1, rev2)):
+        str += '%s\n' % line.rstrip().split(' ',4)[-1].split('\t',1)[-1]
+
+    return str.rstrip()
+
 def checkout(files = [], tree_id = None, force = False):
     """Check out the given or all files
     """
