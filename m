From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [patch 03/11] stg diff / files: don't update directory cache unless needed
Date: Fri, 16 Sep 2005 21:35:15 +0200
Message-ID: <20050916193515.18681.83716.stgit@zion.home.lan>
References: <20050916193511.18681.24189.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 21:39:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGM2D-0005id-Pw
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 21:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbVIPTiF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 15:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbVIPTiF
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 15:38:05 -0400
Received: from ppp-62-11-79-165.dialup.tiscali.it ([62.11.79.165]:23947 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1750705AbVIPTiE
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 15:38:04 -0400
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id 28D852853F;
	Fri, 16 Sep 2005 21:35:15 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20050916193511.18681.24189.stgit@zion.home.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8712>

Do git-update-cache only when diffing with the working tree, not otherwise.
Spending something like 1min for a stg files is bad - yes, my laptop
was really busy and the Linux tree was probably cache-cold, but that's just
not needed.

Also, in diffstat we currently do it both by hand and by calling git.diff.
And in files there's no need at all for that - even the comments says that
"files" has only to do with committed changes.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 stgit/git.py |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/stgit/git.py b/stgit/git.py
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -376,11 +376,11 @@ def status(files = [], modified = False,
 def diff(files = [], rev1 = 'HEAD', rev2 = None, out_fd = None):
     """Show the diff between rev1 and rev2
     """
-    os.system('git-update-cache --refresh > /dev/null')
 
     if rev2:
         diff_str = _output(['git-diff-tree', '-p', rev1, rev2] + files)
     else:
+        os.system('git-update-cache --refresh > /dev/null')
         diff_str = _output(['git-diff-cache', '-p', rev1] + files)
 
     if out_fd:
@@ -392,7 +392,6 @@ def diffstat(files = [], rev1 = 'HEAD', 
     """Return the diffstat between rev1 and rev2
     """
 
-    os.system('git-update-cache --refresh > /dev/null')
     p=popen2.Popen3('git-apply --stat')
     diff(files, rev1, rev2, p.tochild)
     p.tochild.close()
@@ -404,7 +403,6 @@ def diffstat(files = [], rev1 = 'HEAD', 
 def files(rev1, rev2):
     """Return the files modified between rev1 and rev2
     """
-    os.system('git-update-cache --refresh > /dev/null')
 
     str = ''
     for line in _output_lines('git-diff-tree -r %s %s' % (rev1, rev2)):
