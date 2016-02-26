From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 05/16] bisect: get rid of recursion in count_distance()
Date: Fri, 26 Feb 2016 03:04:31 +0100
Message-ID: <1456452282-10325-6-git-send-email-s-beyer@gmx.net>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 03:06:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ7na-0007k9-K9
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 03:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752905AbcBZCGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 21:06:15 -0500
Received: from mout.gmx.net ([212.227.15.15]:59351 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155AbcBZCFp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 21:05:45 -0500
Received: from fermat.fritz.box ([188.108.247.176]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0LqiJO-1a3cRw3cfa-00eILe; Fri, 26 Feb 2016 03:05:43
 +0100
X-Mailer: git-send-email 2.7.2.383.g3fb0654
In-Reply-To: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:zVeZtn6Uld3oskRDScdoo61bM3eRrlGkYQvTyJ9jLI4eILxiM5a
 xwYX0pAU7D0qVBSDgbt395kxoJ80N8qw47mvuCVL9mIsErSkL0+56yVS7BcGfRKfkCSADMS
 bSOfqjL5YxXs1irwe2Wj4w6H6rlTczgTCIIOHr0oK5yMX+TqZl8LYMXO+Mek8+Q7otCQnnu
 /XKLohbPg5Wg+ZtPVFruA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AldQuh3k550=:swrPoDZbPiIYK64Vgg1or5
 p5CykKFjx6Lma9E+JsLvytv6lUfiZcqrzYnB5mkGlBSBsmB5xAccl+tpei/gRVOJ4xRvrDfPu
 xpi52BaS1b0aMasRqh46Paae85J9IXx7nKNpPO4hp8/BQWarTnIXfUZ7RaHR9EsUiE5CBcqE+
 McTfsuYfF3TraGvO6eHrjZpvOX1sV+SkCgCVHLL1WnOuG6RVhPT+guCmhTOIsGjwRzIhh2KLG
 dg4ppoUZgfauiC7pe8r4t2kXhxY8FiOPI81ZHxMMxulYFUrLQf3i+cEFYD7nUSi0+O4g+Icz5
 Mj7lGtWZtaSurrsm7Jf51VJwEXacL+Avmyl4KR82FH2qLvzLRK3ldaMPC8mbsoNX9QOHMjyag
 vQ9murgLS+xL8RF6Xf8gUum4h9z+IFG32c+tTkNApsfiaFkP+BZ5Qg3y24poJ9a/Wi28MHt4v
 vhBSBDmFbdsC23vpz9/L7YGv5irPEl+uitSuoB6VXGB/2cEyTOPnG+vb3wrQv8/aOTOs+k6t3
 rI4JROX0ril0woC3Hkvh0zyYutqvWOAUGpYcGeTPN2RpF7MVf8L/Ur1mmEQtENrsR4W4BMWH1
 KNnREX/kMOSty8V0WdbpHijKYjNBxaHJbhU9C6I5bau/9XZxUS8wUbvdZ5Cf9ViK6FOyfSDCv
 7TwfcS6A3KCYmtdoFPnEaPYm4bJN6/ofNglsB0fePkyPlacxZl4fgnQa46OTg+HLjL4YiVdpZ
 wm0W3yKKZry3VVnHOHlB7CsMnbVqUCAJ7zJZ6t0okrUbAczKFx/hnXzQzrk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287527>

Large repositories with a huge amount of merge commits in the
bisection process could lead to stack overflows in git bisect.
In order to prevent this, this commit uses an *iterative* version
for counting the number of ancestors of a commit.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

In the cover letter I promised that bisect will be faster.
It's not rocket science to know that replacing a simple recursion
by an iterative version involving a list (with alloc'ing and stuff)
makes the code slower.

For my git master branch test, this changed the running time
from ~50 to ~60 seconds. However, for a smaller stack size,
this changes the running time from <crash> to ~60 seconds.
That's a win ;-)

 bisect.c | 55 ++++++++++++++++++++++---------------------------------
 1 file changed, 22 insertions(+), 33 deletions(-)

diff --git a/bisect.c b/bisect.c
index 412e2c0..03e7660 100644
--- a/bisect.c
+++ b/bisect.c
@@ -26,33 +26,23 @@ static const char *term_good;
 /* Remember to update object flag allocation in object.h */
 #define COUNTED		(1u<<16)
 
-/*
- * This is a truly stupid algorithm, but it's only
- * used for bisection, and we just don't care enough.
- *
- * We care just barely enough to avoid recursing for
- * non-merge entries.
- */
 static int count_distance(struct commit_list *entry)
 {
 	int nr = 0;
+	struct commit_list *todo = NULL;
+	commit_list_append(entry->item, &todo);
 
-	while (entry) {
-		struct commit *commit = entry->item;
-		struct commit_list *p;
+	while (todo) {
+		struct commit *commit = pop_commit(&todo);
 
-		if (commit->object.flags & (UNINTERESTING | COUNTED))
-			break;
-		if (!(commit->object.flags & TREESAME))
-			nr++;
-		commit->object.flags |= COUNTED;
-		p = commit->parents;
-		entry = p;
-		if (p) {
-			p = p->next;
-			while (p) {
-				nr += count_distance(p);
-				p = p->next;
+		if (!(commit->object.flags & (UNINTERESTING | COUNTED))) {
+			struct commit_list *p;
+			if (!(commit->object.flags & TREESAME))
+				nr++;
+			commit->object.flags |= COUNTED;
+
+			for (p = commit->parents; p; p = p->next) {
+				commit_list_insert(p->item, &todo);
 			}
 		}
 	}
@@ -287,7 +277,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 	 * can reach.  So we do not have to run the expensive
 	 * count_distance() for single strand of pearls.
 	 *
-	 * However, if you have more than one parents, you cannot
+	 * However, if you have more than one parent, you cannot
 	 * just add their distance and one for yourself, since
 	 * they usually reach the same ancestor and you would
 	 * end up counting them twice that way.
@@ -296,17 +286,16 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 	 * way, and then fill the blanks using cheaper algorithm.
 	 */
 	for (p = list; p; p = p->next) {
-		if (p->item->object.flags & UNINTERESTING)
-			continue;
-		if (weight(p) != -2)
-			continue;
-		weight_set(p, count_distance(p));
-		clear_distance(list);
+		if (!(p->item->object.flags & UNINTERESTING)
+		 && (weight(p) == -2)) {
+			weight_set(p, count_distance(p));
+			clear_distance(list);
 
-		/* Does it happen to be at exactly half-way? */
-		if (!find_all && halfway(p, nr))
-			return p;
-		counted++;
+			/* Does it happen to be at exactly half-way? */
+			if (!find_all && halfway(p, nr))
+				return p;
+			counted++;
+		}
 	}
 
 	show_list("bisection 2 count_distance", counted, nr, list);
-- 
2.7.1.354.gd492730.dirty
