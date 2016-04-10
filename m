From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2 13/21] bisect: use commit instead of commit list as arguments when appropriate
Date: Sun, 10 Apr 2016 15:19:06 +0200
Message-ID: <1460294354-7031-14-git-send-email-s-beyer@gmx.net>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 15:20:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apFI4-0000Af-I7
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 15:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbcDJNUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 09:20:32 -0400
Received: from mout.gmx.net ([212.227.17.22]:62334 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753161AbcDJNUP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 09:20:15 -0400
Received: from fermat.fritz.box ([92.76.224.62]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0Lz0aC-1btKPV0vjc-014FBS; Sun, 10 Apr 2016 15:20:05
 +0200
X-Mailer: git-send-email 2.8.1.137.g522756c
In-Reply-To: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:ouzQp7ZBAct2VSJ2GyiYwdXv5vLQV48dkfgd4ZWycN7/OcXdVix
 Qf7r4DWl5f3cZhHP5yGAabygO/v5Yww8Pwdt1bfs17HzVSapXnRFXSqhDi0PaCVxG42PzDj
 1SWCz/70EvgISzw3cw4Hg7/oP802r9s8W6pR7tGNDUa29N6FVshc60Bp0OY8QpKpx3djSV4
 86lmUPoxdAW1NztzPjXjA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bk5rXgzh/98=:Nq4/tqNMKuHdtE86MSWUHx
 tdJWzi1DxkQumtCIYxUuek8mF2EWnnSGidkspTf3wrTzvo4OuRYZKJ2325hDMSI7u59oSqB2Z
 zsYk8sdnLK9v+UCEK8KS2rqpRedV9JOIjaBkqMUi2PLjzOUrnqBNP7UdLs/zTobgZs3OolYyB
 1xIjNL+1EzEAOasgtvSxYTWckPlkzjUefSMRe/Ifa+bZ+c12+zJ1ufFn59w6jNVfIYwL7v9pt
 vTaXhFZqUHfmAyZaxriOUBhznOYAQt7VaSulDhK/AqCUJMWdjiV1NK3SeCUGfhvneCGfXE0Gc
 Rr3WodIOBFfzOWSIX5dhLE4aQbbd8Fx5RG0FGvCGlGJZ2Km/AxUdil1BSfWqanu6xDuKPuPgf
 9/j+BH6jjcZHG1aQhc7Js2BlrRQXpuKM7nxxQvNj5bQdE7Q1EGXr7fGcNqN6SVkTYwkdemKqE
 XrE98BXVOeZtoFLJ6gnGlKXa8bwRCzUd0jjGRRYZzQNNLA8rJuy5+vh8G7rMbsHyXo2b7nfvV
 GTlWapgzQAypYF5mY1f2Q3PSKCPXYuECR/sckzytTKJgiEA20S0Nh1NctXtgocjvwMn0bnsJl
 MwBid7KxZlUvw3SQfTxxN9+2WVYuCsj+VJG+Mm6kW/XJipbRYBIlDlNm7kipBGz5f4NyOV5+1
 D8tWmv+9sbAOhprV8cSkuRXjTbKdXXMzhFrmJvYmw4p0j8xYcYkSW6aCi+Mp2/iwgrnK3TCFn
 2ehOqzcdsCCGr4tVU9MV/WOuA6BpXnJo4S7dhUMskTL1zzXqCzvYwOJLkJ0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291153>

It makes no sense that the argument for count_distance() and
halfway() is a commit list when only its first commit is relevant.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 bisect.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/bisect.c b/bisect.c
index 4209c75..2c1102f 100644
--- a/bisect.c
+++ b/bisect.c
@@ -38,11 +38,11 @@ static inline struct node_data *node_data(struct commit *elem)
 	return (struct node_data *)elem->util;
 }
 
-static int count_distance(struct commit_list *entry)
+static int count_distance(struct commit *elem)
 {
 	int nr = 0;
 	struct commit_list *todo = NULL;
-	commit_list_append(entry->item, &todo);
+	commit_list_append(elem, &todo);
 	marker++;
 
 	while (todo) {
@@ -77,18 +77,18 @@ static int count_interesting_parents(struct commit *commit)
 	return count;
 }
 
-static inline int halfway(struct commit_list *p, int nr)
+static inline int halfway(struct commit *commit, int nr)
 {
 	/*
 	 * Don't short-cut something we are not going to return!
 	 */
-	if (p->item->object.flags & TREESAME)
+	if (commit->object.flags & TREESAME)
 		return 0;
 	/*
 	 * 2 and 3 are halfway of 5.
 	 * 3 is halfway of 6 but 2 and 4 are not.
 	 */
-	switch (2 * node_data(p->item)->weight - nr) {
+	switch (2 * node_data(commit)->weight - nr) {
 	case -1: case 0: case 1:
 		return 1;
 	default:
@@ -280,10 +280,10 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 	for (p = list; p; p = p->next) {
 		if (!(p->item->object.flags & UNINTERESTING)
 		 && (node_data(p->item)->weight == -2)) {
-			node_data(p->item)->weight = count_distance(p);
+			node_data(p->item)->weight = count_distance(p->item);
 
 			/* Does it happen to be at exactly half-way? */
-			if (!find_all && halfway(p, nr))
+			if (!find_all && halfway(p->item, nr))
 				return p;
 			counted++;
 		}
@@ -321,7 +321,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 			}
 
 			/* Does it happen to be at exactly half-way? */
-			if (!find_all && halfway(p, nr))
+			if (!find_all && halfway(p->item, nr))
 				return p;
 		}
 	}
-- 
2.8.1.137.g522756c
