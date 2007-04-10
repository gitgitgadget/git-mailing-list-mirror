From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Allow git-update-index work on subprojects
Date: Wed, 11 Apr 2007 01:19:00 +0200
Message-ID: <20070410231900.GA4243@steel.home>
References: <Pine.LNX.4.64.0704092133550.6730@woody.linux-foundation.org> <81b0412b0704100639y331864f9ne0306aa4bf8de663@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 08:25:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbPcG-0000Ll-HR
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 01:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbXDJXTI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 19:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752642AbXDJXTI
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 19:19:08 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:64483 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbXDJXTG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 19:19:06 -0400
Received: from tigra.home (Fc95d.f.strato-dslnet.de [195.4.201.93])
	by post.webmailer.de (mrclete mo16) (RZmta 5.5)
	with ESMTP id D030a6j3AKVDLH ; Wed, 11 Apr 2007 01:19:02 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C142A277B6;
	Wed, 11 Apr 2007 01:19:01 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id D83C8BF6F; Wed, 11 Apr 2007 01:19:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <81b0412b0704100639y331864f9ne0306aa4bf8de663@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAwYbw==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44196>

Also, make "git commit -a" work with modifications of subproject HEADs.

---

This one works with update-index --remove (which is what git-commit -a
uses). It is ugly. I tried to keep the "F -> D/F" behaviour of
update-index. Still have to check if "F -> Subproject" works.

 builtin-update-index.c |   45 +++++++++++++++++++++++++--------------------
 1 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index eba756d..d075d50 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -62,7 +62,7 @@ static int mark_valid(const char *path)
 
 static int process_file(const char *path)
 {
-	int size, namelen, option, status;
+	int size, namelen = -1, option, status;
 	struct cache_entry *ce;
 	struct stat st;
 
@@ -73,7 +73,7 @@ static int process_file(const char *path)
 	 */
 	cache_tree_invalidate_path(active_cache_tree, path);
 
-	if (status < 0 || S_ISDIR(st.st_mode)) {
+	if (!status && S_ISDIR(st.st_mode)) {
 		/* When we used to have "path" and now we want to add
 		 * "path/file", we need a way to remove "path" before
 		 * being able to add "path/file".  However,
@@ -82,27 +82,32 @@ static int process_file(const char *path)
 		 * friendly, especially since we can do the opposite
 		 * case just fine without --force-remove.
 		 */
-		if (status == 0 || (errno == ENOENT || errno == ENOTDIR)) {
-			if (allow_remove) {
-				if (remove_file_from_cache(path))
-					return error("%s: cannot remove from the index",
-					             path);
-				else
-					return 0;
-			} else if (status < 0) {
+		namelen = strlen(path);
+		int pos = cache_name_pos(path, namelen);
+		if (0 <= pos && S_ISREG(ntohl(active_cache[pos]->ce_mode)) &&
+		    allow_remove) {
+			if (remove_file_from_cache(path))
+				return error("%s: cannot remove from the index", path);
+			else
+				return 0;
+		}
+	}
+
+	if (status < 0) {
+		if (errno == ENOENT || errno == ENOTDIR) {
+			if (!allow_remove)
 				return error("%s: does not exist and --remove not passed",
-				             path);
-			}
+					     path);
+			if (remove_file_from_cache(path))
+				return error("%s: cannot remove from the index",
+					     path);
+			return 0;
 		}
-		if (0 == status)
-			return error("%s: is a directory - add files inside instead",
-			             path);
-		else
-			return error("lstat(\"%s\"): %s", path,
-				     strerror(errno));
+		return error("lstat(\"%s\"): %s", path, strerror(errno));
 	}
 
-	namelen = strlen(path);
+	if (namelen < 0)
+		namelen = strlen(path);
 	size = cache_entry_size(namelen);
 	ce = xcalloc(1, size);
 	memcpy(ce->name, path, namelen);
@@ -211,7 +216,7 @@ static void update_one(const char *path, const char *prefix, int prefix_length)
 		goto free_return;
 	}
 	if (process_file(p))
-		die("Unable to process file %s", path);
+		die("Unable to process \"%s\"", path);
 	report("add '%s'", path);
  free_return:
 	if (p < path || p > path + strlen(path))
-- 
1.5.1.135.g19a57-dirty
