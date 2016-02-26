From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 13/16] bisect: prepare for different algorithms based on find_all
Date: Fri, 26 Feb 2016 03:04:39 +0100
Message-ID: <1456452282-10325-14-git-send-email-s-beyer@gmx.net>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 03:06:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ7nD-0007WA-FM
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 03:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748AbcBZCGD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 21:06:03 -0500
Received: from mout.gmx.net ([212.227.15.15]:49541 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752321AbcBZCFs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 21:05:48 -0500
Received: from fermat.fritz.box ([188.108.247.176]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0M9aX9-1admD81wsx-00Cz1f; Fri, 26 Feb 2016 03:05:45
 +0100
X-Mailer: git-send-email 2.7.2.383.g3fb0654
In-Reply-To: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:qc73jLGFjSG5clwXtyKAHd7SPeelAdZMErH29//7FZjftI9EfFR
 SxCx0UqaCuwexO61yS/4B2L5ZZNNdCgMz8dkeWey2LEEZttSrzCGS7fydrkqmRvsn5lOi5A
 9UN4MbUwXT7jrXvj4cPusok98UYIIgjD6AISz69Rkicx0qs4zRw0Qzv8YbIRiiYDUlSm5A1
 uqZ3vthPTlVjsBgWNk69Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2M2VSQQh7OM=:4y80+hOjhj9sKvJ5B4tWAX
 CLLc+zslDg0gXMS3sjqSw3oqJHQE56ua43j9LhTLNkXNuk2G/K4difZ1PCG6YAgP/TrSOQTgZ
 IE4BGaLukCKlFF/tw4NS6gZZ/euDSv+tO/4ZSk6ZpXfPipna0g7x6IjvHhpPLKmoDtwOv9U1T
 ggHbLVo4iThQkNvJnHu1AqYrSqv7TBba+kZSu9/AHRWCoDdjB6tibw+infIGKJQ3LeCah+p/D
 G8WxDwdrpxqOMC+wQLbqm41d7oLfT/No7psbpa3wxMv3xLJnoWadv8eIExNYuTiPqFZUyIou5
 d3vhV98dmy7ReitM6GGO4i/mSEoe5xih1U10zCMPxKxaeR8vqojYL4gfWdBGlHqVKhFpSloV0
 XPp4+HxHy+ICmxXNgVLJQDhEZUf/VMrOHixISH/TCP2SZG2Oo5oLXhgwiBBH2JfJFiEAx7Llr
 UpBtH+RV7DDhoCtja/y73C6xwEy/FXo4hJMBKwSshmuAN9AFJ5HxwRi6oDLz8195dlK+EEAZC
 0/z/adCcpXKjoLtLNdGMzMRb3Uwv5CsIjibkAPyP/67rB1Z1g+OH4smdX5ZKY0RGc5Vj1UKtz
 O3x9cCJdB/zwHqPKcFyg6ZzBUDRGmM/IxLQ6OSS5NmY2gZaH7GrGD81am2QdSrW0HNn8KTyPn
 KO0iau28Ub8bQXSqv8Yvm9s6VEYHSl2m/hkheun6PesXPTwNL+r/1dQo+0GyuhAXe/MjlBKCh
 Ct62vFO3uOl0xQO5I/CICxAqL8Zv/PYQh3VUHNBwg73BXLzVaDApsPolyl0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287518>

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
index a9387a7..1d1f61c 100644
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
2.7.1.354.gd492730.dirty
