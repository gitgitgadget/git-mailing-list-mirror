From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] show changed tree objects with recursive git-diff-tree
Date: Fri, 20 May 2005 21:40:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505202131520.4397@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 03:40:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZIyD-0005kX-Hy
	for gcvg-git@gmane.org; Sat, 21 May 2005 03:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVEUBkt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 21:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVEUBkt
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 21:40:49 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45614 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261630AbVEUBkl
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2005 21:40:41 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IGT003OLGNTMC@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 20 May 2005 21:40:41 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When -p is not used, git-diff-tree currently shows changed tree objects
but only when not recursive.  This patch makes the recursive output
show tree objects as well.

This has the immediate benefit of making git-deltafy-script handle
deltafication of tree objects.

Signed-off-by: Nicolas Pitre <nico@cam.org>

diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -131,7 +131,10 @@ static int compare_tree_entry(void *tree
 
 	if (recursive && S_ISDIR(mode1)) {
 		int retval;
-		char *newbase = malloc_base(base, path1, pathlen1);
+		char *newbase;
+		if (!silent && !generate_patch)
+			diff_change(mode1, mode2, sha1, sha2, base, path1);
+		newbase = malloc_base(base, path1, pathlen1);
 		retval = diff_tree_sha1(sha1, sha2, newbase);
 		free(newbase);
 		return retval;
diff --git a/git-deltafy-script b/git-deltafy-script
--- a/git-deltafy-script
+++ b/git-deltafy-script
@@ -9,8 +9,6 @@
 # NOTE: the "best earlier version" is not implemented in mkdelta yet
 #       and therefore only the next eariler version is used at this time.
 #
-# TODO: deltafy tree objects as well.
-#
 # The -d argument allows to provide a limit on the delta chain depth.
 # If 0 is passed then everything is undeltafied.
 
