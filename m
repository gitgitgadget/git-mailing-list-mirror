From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] sha1_name(): accept ':directory/' to get at the cache_tree
Date: Fri, 22 Dec 2006 03:19:21 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612220318320.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Dec 22 03:19:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxa0O-0004PC-EI
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 03:19:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945912AbWLVCTY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 21:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945914AbWLVCTY
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 21:19:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:40035 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1945912AbWLVCTX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 21:19:23 -0500
Received: (qmail invoked by alias); 22 Dec 2006 02:19:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 22 Dec 2006 03:19:21 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35118>


If the cache tree is not up-to-date, it will be updated first. So, now

	$ git show :Documentation/

will in effect show what files/directories are in the index' version
of the directory Documentation. The three commands

	$ git show :./
	$ git show :.
	$ git show :

are all equivalent and show the index' idea of the root directory.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sha1_name.c |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 6d7cd78..e3758cc 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -5,6 +5,7 @@
 #include "blob.h"
 #include "tree-walk.h"
 #include "refs.h"
+#include "cache-tree.h"
 
 static int find_short_object_filename(int len, const char *name, unsigned char *sha1)
 {
@@ -532,7 +533,7 @@ int get_sha1(const char *name, unsigned char *sha1)
 	 */
 	if (name[0] == ':') {
 		int stage = 0;
-		struct cache_entry *ce;
+		struct cache_entry *ce = NULL;
 		int pos;
 		if (namelen < 3 ||
 		    name[2] != ':' ||
@@ -561,6 +562,27 @@ int get_sha1(const char *name, unsigned char *sha1)
 			}
 			pos++;
 		}
+		if (namelen > 0 && cp[namelen - 1] == '/')
+			namelen--;
+		if (namelen == 1 && cp[0] == '.') {
+			namelen = 0;
+			cp = "";
+		}
+		if (namelen == 0 || (ce && ce_namelen(ce) > namelen &&
+					ce->name[namelen] == '/' &&
+					!memcmp(ce->name, cp, namelen))) {
+			struct cache_tree *tree =
+				cache_tree_find(active_cache_tree, cp);
+			if (!cache_tree_fully_valid(tree)) {
+				ret = cache_tree_update(active_cache_tree,
+						active_cache, active_nr, 0, 0);
+				if (ret < 0)
+					return ret;
+				tree = cache_tree_find(active_cache_tree, cp);
+			}
+			hashcpy(sha1, tree->sha1);
+			return 0;
+		}
 		return -1;
 	}
 	for (cp = name, bracket_depth = 0; *cp; cp++) {
-- 
1.4.4.2.ga854-dirty
