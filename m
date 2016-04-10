From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2 18/21] bisect: prepare for different algorithms based on find_all
Date: Sun, 10 Apr 2016 15:19:11 +0200
Message-ID: <1460294354-7031-19-git-send-email-s-beyer@gmx.net>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 15:20:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apFI3-0000Af-CD
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 15:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbcDJNUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 09:20:23 -0400
Received: from mout.gmx.net ([212.227.17.22]:50061 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753349AbcDJNUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 09:20:16 -0400
Received: from fermat.fritz.box ([92.76.224.62]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MCwbX-1axnjo1EWp-009gBN; Sun, 10 Apr 2016 15:20:07
 +0200
X-Mailer: git-send-email 2.8.1.137.g522756c
In-Reply-To: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:RDfCh1MEmut/cJW3fWEyfSS7/RQ0ony4lAN28FAkt3MkHKNFvXA
 1rWsHLP8/QEqXYIqs85XfMKs3lDh4nW04bSxs5NjNPUPe034T8sTDWX6+/baeWahtnKOMeA
 0P9SKkzsm2WWp2D7PIAFRO+nAr3/U5JYO2wmFnhThQA0imkQtcchQLK1pnvtjIpHhCH/zAW
 bgYl84GyfTQz2QIiAKRSA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YqxZ8PdKdGI=:glu5sO8xDg5YAtspPO49S6
 i6NsJb3Fya/G5RjdPycrTsBwDGg+zTlzB5hDgu+Hfzc02oc+JgLpuNeLV5jCtKtcEY6UkGsbi
 c7pUP1DULhnUWbk7uv74xWZySR8SZUDzJ6ENTPT6J11/VcNCtcVpMdDqyG3dOOSrYv6xA1htX
 z83VEMwev7jlw76tHgs0czzMpcWfOknyEyRtdPUzoe9H0PSlPSdeEnRd+9ugJiJeFnZa3rvMW
 W9XDUdHaYShGVQRTv5TTNynFKJzzu0ldFZuUuk/LYDuklYV/ISFaulTR2SGhiAGJkTdxVnc4b
 difcrWRrWkNxVSCpkl1+K0JdbCqpGQAR3UsvdHNFYGpjLbEWwU63xEa0fAWVLIJeIE6DaDuWU
 AEDTwXi17dL9usnZTlgYTH2IXSupYSVd6BYkQGPHDJQghQH+M9r22R8EjOsbpTPQ4SE56OaFT
 /wZeyVRk5XM67AZi8rSGdHuE3KqjSV4B20H6DdJKqK9Yy7Pj55OztG7qzHLwjOiVlHep2+yNP
 2LZgg8ThOo0vfDyyVsPHJNCNyIx7IbEBBnAQIZcq6PjbcGrJoQhRvlmBKrFN5x68gMuDNZAZO
 RVDMdN4EAMVg/bRRFTomLQoR4rCojZzGvBOwjFBizDb2H1Eo5dQZcDeVKNIxwhDJ1mjrPpOiQ
 fCLZsSfCnp8qjiyiLHNOc0AxS1oJ6xj5be4HP55FolDp8wo9a4ufrty3t4lOVSlOeEQm5jAfm
 XFSPqTH2RzvANvFVNOW0926p8xETdIAJsU4vEabK6pKgIdD2W9hjSZ1tB+8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291155>

This is a preparation commit with copy-and-paste involved.
The function do_find_bisection() is changed and copied to
two almost similar functions compute_all_weights() and
compute_relevant_weights().

The function compute_relevant_weights() stops when a
"halfway" commit is found.

To keep the code clean, the halfway commit is not returned
and has to be found by best_bisection() afterwards.
This results in a singular additional O(#commits)-time
overhead but this will be outweighed by the following
changes to compute_relevant_weights().

It is necessary to keep compute_all_weights() for the
"git rev-list --bisect-all" command. All other bisect-related
commands will use compute_relevant_weights().

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 bisect.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 97 insertions(+), 19 deletions(-)

diff --git a/bisect.c b/bisect.c
index a254f28..c6bad43 100644
--- a/bisect.c
+++ b/bisect.c
@@ -179,6 +179,7 @@ static struct commit_list *best_bisection(struct commit_list *list)
 		}
 	}
 
+	best->next = NULL;
 	return best;
 }
 
@@ -245,9 +246,8 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list)
  * unknown.  After running compute_weight() first, they will get zero
  * or positive distance.
  */
-static struct commit_list *do_find_bisection(struct commit_list *list,
-					     struct node_data *weights,
-					     int find_all)
+static void compute_all_weights(struct commit_list *list,
+				struct node_data *weights)
 {
 	int n, counted;
 	struct commit_list *p;
@@ -301,10 +301,88 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		if (!(p->item->object.flags & UNINTERESTING)
 		 && (node_data(p->item)->weight == -2)) {
 			compute_weight(p->item);
+			counted++;
+		}
+	}
+
+	show_list("bisection 2 compute_weight", counted, list);
+
+	while (counted < total) {
+		for (p = list; p; p = p->next) {
+			struct commit_list *q;
+			unsigned flags = p->item->object.flags;
+
+			if (0 <= node_data(p->item)->weight)
+				continue;
+			for (q = p->item->parents; q; q = q->next) {
+				if (q->item->object.flags & UNINTERESTING)
+					continue;
+				if (0 <= node_data(q->item)->weight)
+					break;
+			}
+			if (!q)
+				continue;
+
+			/*
+			 * weight for p is unknown but q is known.
+			 * add one for p itself if p is to be counted,
+			 * otherwise inherit it from q directly.
+			 */
+			node_data(p->item)->weight = node_data(q->item)->weight;
+			if (!(flags & TREESAME)) {
+				node_data(p->item)->weight++;
+				counted++;
+				show_list("bisection 2 count one",
+					  counted, list);
+			}
+		}
+	}
+	show_list("bisection 2 counted all", counted, list);
+}
+
+/* At the moment this is basically the same as compute_all_weights()
+ * but with a halfway shortcut */
+static void compute_relevant_weights(struct commit_list *list,
+				     struct node_data *weights)
+{
+	int n, counted;
+	struct commit_list *p;
+
+	counted = 0;
+
+	for (n = 0, p = list; p; p = p->next) {
+		struct commit *commit = p->item;
+		unsigned flags = commit->object.flags;
+
+		commit->util = &weights[n++];
+		switch (count_interesting_parents(commit)) {
+		case 0:
+			if (!(flags & TREESAME)) {
+				node_data(commit)->weight = 1;
+				counted++;
+				show_list("bisection 2 count one",
+					  counted, list);
+			}
+			break;
+		case 1:
+			node_data(commit)->weight = -1;
+			break;
+		default:
+			node_data(commit)->weight = -2;
+			break;
+		}
+	}
+
+	show_list("bisection 2 initialize", counted, list);
+
+	for (p = list; p; p = p->next) {
+		if (!(p->item->object.flags & UNINTERESTING)
+		 && (node_data(p->item)->weight == -2)) {
+			compute_weight(p->item);
 
 			/* Does it happen to be at exactly half-way? */
-			if (!find_all && halfway(p->item))
-				return p;
+			if (halfway(p->item))
+				return;
 			counted++;
 		}
 	}
@@ -341,17 +419,11 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 			}
 
 			/* Does it happen to be at exactly half-way? */
-			if (!find_all && halfway(p->item))
-				return p;
+			if (halfway(p->item))
+				return;
 		}
 	}
-
 	show_list("bisection 2 counted all", counted, list);
-
-	if (!find_all)
-		return best_bisection(list);
-	else
-		return best_bisection_sorted(list);
 }
 
 struct commit_list *find_bisection(struct commit_list *list,
@@ -365,6 +437,9 @@ struct commit_list *find_bisection(struct commit_list *list,
 	total = 0;
 	marker = 0;
 
+	if (!list)
+		return NULL;
+
 	show_list("bisection 2 entry", 0, list);
 
 	/*
@@ -391,13 +466,16 @@ struct commit_list *find_bisection(struct commit_list *list,
 	*all = total;
 	weights = (struct node_data *)xcalloc(on_list, sizeof(*weights));
 
-	/* Do the real work of finding bisection commit. */
-	best = do_find_bisection(list, weights, find_all);
-	if (best) {
-		if (!find_all)
-			best->next = NULL;
-		*reaches = node_data(best->item)->weight;
+	if (find_all) {
+		compute_all_weights(list, weights);
+		best = best_bisection_sorted(list);
+	} else {
+		compute_relevant_weights(list, weights);
+		best = best_bisection(list);
 	}
+	assert(best);
+	*reaches = node_data(best->item)->weight;
+
 	free(weights);
 
 	return best;
-- 
2.8.1.137.g522756c
