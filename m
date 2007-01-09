From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] sha1_name(): accept ':directory/' to get at the cache_tree
Date: Tue, 9 Jan 2007 15:03:08 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701091502030.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Jan 09 15:03:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4HZR-0003Ug-A3
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 15:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbXAIODL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 09:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbXAIODL
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 09:03:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:38771 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932098AbXAIODJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 09:03:09 -0500
Received: (qmail invoked by alias); 09 Jan 2007 14:03:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 09 Jan 2007 15:03:08 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36360>


If the cache tree is not up-to-date, it will be updated first. So, now

        $ git show :Documentation/

will in effect show what files/directories are in the index' version
of the directory Documentation. The commands

        $ git show :/
        $ git show :

are equivalent and show the index' idea of the root directory.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	'tis a resend of an earlier patch, but without support for the
	bogus ":." as equivalent to ":/".

	I find this feature highly convenient when I just want to see
	what files the index contains.

 sha1_name.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 6d7cd78..6baa7a4 100644
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
@@ -561,6 +562,23 @@ int get_sha1(const char *name, unsigned char *sha1)
 			}
 			pos++;
 		}
+		if (namelen > 0 && cp[namelen - 1] == '/')
+			namelen--;
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
