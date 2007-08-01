From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [NOT-SERIOUS PATCH] Make get_relative_cwd() not accept NULL for a
 directory
Date: Wed, 1 Aug 2007 16:26:04 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708011624260.14781@racer.site>
References: <Pine.LNX.4.64.0707300016470.14781@racer.site>
 <Pine.LNX.4.64.0708010058130.14781@racer.site> <Pine.LNX.4.64.0708010129090.14781@racer.site>
 <7vy7gvdgtn.fsf@assigned-by-dhcp.cox.net> <7vwswfbywq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, matled@gmx.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 17:26:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGG5s-0004w5-2E
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 17:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763319AbXHAP0b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 11:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759604AbXHAP0b
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 11:26:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:47436 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752900AbXHAP0a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 11:26:30 -0400
Received: (qmail invoked by alias); 01 Aug 2007 15:26:27 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp009) with SMTP; 01 Aug 2007 17:26:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Cn3lenlIC+7Q03Tvv5QqKMM+LC0r3HcEes/uqyP
	8GurXEQnKF/v/0
X-X-Sender: gene099@racer.site
In-Reply-To: <7vwswfbywq.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54443>


Earlier, get_relative_cwd() interpreted "dir == NULL" as "outside of the dir",
and therefore returned NULL.  Be more strict now.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	As promised.

	Okay, I made up my mind.  Allowing "dir == NULL" is not only a matter of
	convenience.  It is the most natural way to say that "dir" is an invalid
	or non-existing directory.

	Besides, this patch adds 14.286% more lines than it removes ;-)

	But ultimately, it is your decision, Junio, and I am d'accord with 
	what you choose.

 dir.c   |    3 ---
 setup.c |   10 +++++++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/dir.c b/dir.c
index b3329f4..cfcde13 100644
--- a/dir.c
+++ b/dir.c
@@ -646,7 +646,6 @@ file_exists(const char *f)
 /*
  * get_relative_cwd() gets the prefix of the current working directory
  * relative to 'dir'.  If we are not inside 'dir', it returns NULL.
- * As a convenience, it also returns NULL if 'dir' is already NULL.
  */
 char *get_relative_cwd(char *buffer, int size, const char *dir)
 {
@@ -656,8 +655,6 @@ char *get_relative_cwd(char *buffer, int size, const char *dir)
 	 * a lazy caller can pass a NULL returned from get_git_work_tree()
 	 * and rely on this function to return NULL.
 	 */
-	if (!dir)
-		return NULL;
 	if (!getcwd(buffer, size))
 		die("can't find the current directory: %s", strerror(errno));
 
diff --git a/setup.c b/setup.c
index 3653092..2f720f8 100644
--- a/setup.c
+++ b/setup.c
@@ -183,8 +183,10 @@ int is_inside_git_dir(void)
 
 int is_inside_work_tree(void)
 {
-	if (inside_work_tree < 0)
-		inside_work_tree = is_inside_dir(get_git_work_tree());
+	if (inside_work_tree < 0) {
+		const char *work_tree = get_git_work_tree();
+		inside_work_tree = work_tree ? is_inside_dir(work_tree) : 0;
+	}
 	return inside_work_tree;
 }
 
@@ -370,10 +372,12 @@ const char *setup_git_directory(void)
 	/* If the work tree is not the default one, recompute prefix */
 	if (inside_work_tree < 0) {
 		static char buffer[PATH_MAX + 1];
+		const char *work_tree;
 		char *rel;
 		if (retval && chdir(retval))
 			die ("Could not jump back into original cwd");
-		rel = get_relative_cwd(buffer, PATH_MAX, get_git_work_tree());
+		work_tree = get_git_work_tree();
+		rel = work_tree ? get_relative_cwd(buffer, PATH_MAX, work_tree) : NULL;
 		return rel && *rel ? strcat(rel, "/") : NULL;
 	}
 
-- 
1.5.3.rc3.112.gf60b6
