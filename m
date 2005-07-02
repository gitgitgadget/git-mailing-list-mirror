From: Jon Seymour <jon.seymour@gmail.com>
Subject: [RESUBMITTED PATCH 1/2] Add --topo-order flag to git-rev-list [rev2]
Date: Sat, 02 Jul 2005 18:39:40 +1000
Message-ID: <20050702083940.19107.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Sat Jul 02 10:32:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DodPy-0002hM-3G
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 10:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVGBIjs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 04:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVGBIjs
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 04:39:48 -0400
Received: from 203-173-52-158.dyn.iinet.net.au ([203.173.52.158]:28801 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261761AbVGBIjm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2005 04:39:42 -0400
Received: (qmail 19117 invoked by uid 500); 2 Jul 2005 08:39:40 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Added a --topo-order flag to git-rev-list.

When this flag is specified, git-rev-list sorts its output
in topological order. That is:

	a is reachable from b ==> ord(b) < ord(a)

This ordering invariant is weaker than the --merge-order invariant
but should be sufficient for tools just as gitk that only
need the minimum guarantee provided by --topo-order.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
Note: this patch assumes that my previous patch series that introduces
sort_in_topological_order() to commit.c has been applied.

A subsequent patch to gitk will make gitk use --topo-order instead
of --merge-order.

[rev2]
   * this patch rescues the --topo-order patch that I withdrew
     by recognizing that if limit_list is called, sort_commit_list
     does not do a chronological sort
   * ensures limit_list is called whenever a topological sort is
     is required
   * removed excess braces
---

 rev-list.c |   29 +++++++++++++++++++++--------
 1 files changed, 21 insertions(+), 8 deletions(-)

de8a7f7120581ae60b7e882b15b9099a6fce55dd
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -16,7 +16,7 @@ static const char rev_list_usage[] =
 		      "  --min-age=epoch\n"
 		      "  --header\n"
 		      "  --pretty\n"
-                      "  --bisect\n"
+		      "  --bisect\n"
 		      "  --merge-order [ --show-breaks ]";
 
 static int tag_objects = 0;
@@ -32,6 +32,7 @@ static int max_count = -1;
 static enum cmit_fmt commit_format = CMIT_FMT_RAW;
 static int merge_order = 0;
 static int show_breaks = 0;
+static int topo_order=0;
 static int stop_traversal = 0;
 static int bisect_by_cut_option = 0;
 
@@ -373,11 +374,15 @@ int main(int argc, char **argv)
 			blob_objects = 1;
 			continue;
 		}
-		if (!strncmp(arg, "--merge-order", 13)) {
+		if (!strcmp(arg, "--merge-order")) {
 		        merge_order = 1;
 			continue;
 		}
-		if (!strncmp(arg, "--show-breaks", 13)) {
+		if (!strcmp(arg, "--topo-order")) {
+		        topo_order = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--show-breaks")) {
 			show_breaks = 1;
 			continue;
 		}
@@ -396,14 +401,22 @@ int main(int argc, char **argv)
 	}
 
 	if (!merge_order) {		
-	        if (limited)
+	        if (limited || topo_order || bisect_by_cut_option) {
+			/*
+			 * two expected side effects of calling 
+			 * limit_list are:
+			 *    * resulting list contains all the items to process
+			 *    * show_commit_list won't do a chronological
+			 *      sort
+			*/
 			list = limit_list(list);
-		if (!bisect_by_cut_option) 
-			show_commit_list(list);
-		else {
+		}
+		if (bisect_by_cut_option || topo_order)
 			sort_in_topological_order(&list);
+		if (bisect_by_cut_option)
 			show_commit(bisect_by_cut(list));
-		}
+		else
+			show_commit_list(list);
 	} else {
 		if (sort_list_in_merge_order(list, &process_commit)) {
 			  die("merge order sort failed\n");
------------
