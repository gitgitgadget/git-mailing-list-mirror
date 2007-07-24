From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] cleanup unpack-trees.c: shrink struct tree_entry_list
Date: Tue, 24 Jul 2007 23:54:25 +0200
Message-ID: <46A67511.8080300@lsrfire.ath.cx>
References: <85d4ykjtuc.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: David Kastrup <dak@gnu.org>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jul 24 23:54:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDSKw-0003nn-Ch
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 23:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755596AbXGXVya (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 17:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755485AbXGXVya
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 17:54:30 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:57137
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755422AbXGXVy3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jul 2007 17:54:29 -0400
Received: from [10.0.1.201] (p508EC3BB.dip.t-dialin.net [80.142.195.187])
	by neapel230.server4you.de (Postfix) with ESMTP id 6C1398B008;
	Tue, 24 Jul 2007 23:54:28 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (Windows/20070716)
In-Reply-To: <85d4ykjtuc.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53653>

David Kastrup schrieb:
> The definition of tree_entry_list ist the following
> 
> struct tree_entry_list {
> 	struct tree_entry_list *next;
> 	unsigned directory : 1;
> 	unsigned executable : 1;
> 	unsigned symlink : 1;
> 	unsigned int mode;
> 	const char *name;
> 	const unsigned char *sha1;
> };
> 
> but it appears to me that the only of the bit fields that is used at
> all is "directory" : all other uses revert to "mode" which directory
> presumably could do as well.
> 
> Is there something I am overlooking?

A C compiler can give the definite answer: no.

--- 8< ---
Remove the two write-only fields executable and symlink from struct
tree_entry_list.  Also replace usage of the field directory with
S_ISDIR checks on the mode field, and then remove this now obsolete
field, too.  Noticed by David Kastrup.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
This patch slightly reduces RAM usage, but it also shrinks the code
without reducing functionality or readability, which is more
interesting.

 unpack-trees.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 7cc029e..3b32718 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -11,9 +11,6 @@
 
 struct tree_entry_list {
 	struct tree_entry_list *next;
-	unsigned directory : 1;
-	unsigned executable : 1;
-	unsigned symlink : 1;
 	unsigned int mode;
 	const char *name;
 	const unsigned char *sha1;
@@ -38,9 +35,6 @@ static struct tree_entry_list *create_tree_entry_list(struct tree *tree)
 		entry->name = one.path;
 		entry->sha1 = one.sha1;
 		entry->mode = one.mode;
-		entry->directory = S_ISDIR(one.mode) != 0;
-		entry->executable = (one.mode & S_IXUSR) != 0;
-		entry->symlink = S_ISLNK(one.mode) != 0;
 		entry->next = NULL;
 
 		*list_p = entry;
@@ -141,9 +135,9 @@ static int unpack_trees_rec(struct tree_entry_list **posns, int len,
 #endif
 			if (!first || entcmp(first, firstdir,
 					     posns[i]->name,
-					     posns[i]->directory) > 0) {
+					     S_ISDIR(posns[i]->mode)) > 0) {
 				first = posns[i]->name;
-				firstdir = posns[i]->directory;
+				firstdir = S_ISDIR(posns[i]->mode);
 			}
 		}
 		/* No name means we're done */
@@ -177,7 +171,7 @@ static int unpack_trees_rec(struct tree_entry_list **posns, int len,
 				continue;
 			}
 
-			if (posns[i]->directory) {
+			if (S_ISDIR(posns[i]->mode)) {
 				struct tree *tree = lookup_tree(posns[i]->sha1);
 				any_dirs = 1;
 				parse_tree(tree);
