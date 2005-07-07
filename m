From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH] Ensure list insertion method does not depend on position of --merge-order argument
Date: Thu, 07 Jul 2005 10:59:13 +1000
Message-ID: <20050707005913.16295.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Thu Jul 07 03:03:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqKna-0005gp-Aq
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 03:03:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbVGGBDL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 21:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVGGBAh
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 21:00:37 -0400
Received: from 203-217-64-103.dyn.iinet.net.au ([203.217.64.103]:16257 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262420AbVGGA7P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 20:59:15 -0400
Received: (qmail 16305 invoked by uid 500); 7 Jul 2005 00:59:13 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This change ensures that git-rev-list --merge-order produces the same result
irrespective of what position the --merge-order argument appears in the argument
list.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
Linus: if you'd prefer to fix this a different way, that's fine by me!
---

 rev-list.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

8723420366d839123ca4186c60469fd38fd4b798
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -411,10 +411,8 @@ static struct commit *get_commit_referen
 int main(int argc, char **argv)
 {
 	struct commit_list *list = NULL;
-	struct commit_list *(*insert)(struct commit *, struct commit_list **);
 	int i, limited = 0;
 
-	insert = insert_by_date;
 	for (i = 1 ; i < argc; i++) {
 		int flags;
 		char *arg = argv[i];
@@ -464,7 +462,6 @@ int main(int argc, char **argv)
 		}
 		if (!strcmp(arg, "--merge-order")) {
 		        merge_order = 1;
-		        insert = commit_list_insert;
 			continue;
 		}
 		if (!strcmp(arg, "--show-breaks")) {
@@ -491,10 +488,11 @@ int main(int argc, char **argv)
 		if (commit->object.flags & DUPCHECK)
 			continue;
 		commit->object.flags |= DUPCHECK;
-		insert(commit, &list);
+		commit_list_insert(commit, &list);
 	}
 
 	if (!merge_order) {		
+		sort_by_date(&list);
 	        if (limited)
 			list = limit_list(list);
 		if (topo_order)
------------
