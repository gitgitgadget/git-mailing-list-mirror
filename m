From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/2] Add --topo-order flag to git-rev-list
Date: Sat, 02 Jul 2005 16:09:36 +1000
Message-ID: <20050702060936.13011.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Sat Jul 02 08:02:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dob4t-0001dQ-0Y
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 08:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVGBGJn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 02:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVGBGJn
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 02:09:43 -0400
Received: from 203-173-52-158.dyn.iinet.net.au ([203.173.52.158]:39554 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261802AbVGBGJj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2005 02:09:39 -0400
Received: (qmail 13021 invoked by uid 500); 2 Jul 2005 06:09:36 -0000
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
---

 rev-list.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

804e6b585e205ba119a9a43058d69c2ef914dc80
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
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
@@ -398,9 +403,12 @@ int main(int argc, char **argv)
 	if (!merge_order) {		
 	        if (limited)
 			list = limit_list(list);
-		if (!bisect_by_cut_option) 
+		if (!bisect_by_cut_option) {
+			if (topo_order) {
+				sort_in_topological_order(&list);
+			}
 			show_commit_list(list);
-		else {
+		} else {
 			sort_in_topological_order(&list);
 			show_commit(bisect_by_cut(list));
 		}
------------
