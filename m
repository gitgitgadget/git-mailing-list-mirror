From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2 12/21] bisect: replace clear_distance() by unique markers
Date: Sun, 10 Apr 2016 15:19:05 +0200
Message-ID: <1460294354-7031-13-git-send-email-s-beyer@gmx.net>
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
	id 1apFI3-0000Af-VO
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 15:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299AbcDJNUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 09:20:15 -0400
Received: from mout.gmx.net ([212.227.17.21]:51071 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753349AbcDJNUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 09:20:09 -0400
Received: from fermat.fritz.box ([92.76.224.62]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0Ldspr-1bX8YZ3PxD-00j105; Sun, 10 Apr 2016 15:20:05
 +0200
X-Mailer: git-send-email 2.8.1.137.g522756c
In-Reply-To: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:tAwksyJraKj91n4mfK+3MgSbfW43ddYlit9kJrwRY8j+ypYjC03
 Q6mbI59bpk4AXPBasf2t8kX/wwX1W5qBxkBFiOfp2qNwEFHFQ3SvKhtgS+IGW6HuELaSEsr
 bAindoSZAMYKVYAYHoAYhjvLSCyNxncx0G0a2IcrdKZojpiv4edDRX9aZyJRQIu5ddaxLrY
 Sem838LkOmIPuWZ55neXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Zs/4Hxgzqcc=:5ugRgHZkhqjSJkYQ5eNCt2
 oX1YDevC6GRxUc4x3tGF0LfqKeOngYAC15Vbn1ineRXX4EiZvm39gDKzAYGLr5iFAeeYplvSz
 hpX5/AX0xniKBM6HJd1HXHa/Duc+gzazouS/mImnPvpyiaBJ/ccJbhrP7ikRqo8tm8HGYfPMy
 qSYgpwqEF0LdILQ39DvZjkMvZexcS49dHy8sJzODvpYfKENzIAp0I58Geq+kctymlhn6eC4RN
 NoMC5qolGLx+Y8WlqeTr6CNryRC+Lt4dG2DGSqLTg7Z86leZfndVgW4Zj7OOsKL2dx6P/SjhC
 8iTY5mz/AfIedd6gMw7lX3PAyzjBwU9Vvkuhgbkulmy99aof2WxHr4TF6yyUANbRoyrkE9NxH
 Lsknz0BKzo1U0bq2MB7jtH4kBn6jGqcFJK+Cr2kHSLoYyK+zHopHpXpVsLG534l55mwKGhdWv
 Jp1WrCo8lFOuJpry90gyYl6gA1C2Pdz/R9k2CE1ix+u4pacjXjOmMR2ODt/mbzkd/Dlw7gRY1
 Wg0uMfHt1MRtb/bLFR6yLHxG7O82Pn3t9LVlzFQAIvufANGyxwn+ImZKe798bCswzQK15TtO3
 90Tc2mF6LSAOa1GKSVsUGXxYmtry38DwlbZZuNC/8Mk4fUbpAQQo3uTyckDcXiWY4j8krQm9o
 yfTWAqaMxowoHOpL9LEpFY7QZeN3AzUM2+I9lStI8O9h/kttK1ldju3j42n2Xokm65YfAz0Mx
 D99zY5yug1m68ejO3F/Bx+BcYAwuI0fhP9mUX4SoWj3G5WC7ImFHeGEIn/A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291151>

clear_distance() was a O(#commits)-time function to clear the COUNTED
flag from commits counted in count_distance().
The functions count_distance() and clear_distance() were called for
each merge commit.

This commit gets rid of the clear_distance() function by making
count_distance() use unique marker ids that do not need to be
cleared afterwards. This speeds up the bisecting process on
large repositories with a huge amount of merges.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 bisect.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/bisect.c b/bisect.c
index bc1bfbd..4209c75 100644
--- a/bisect.c
+++ b/bisect.c
@@ -23,13 +23,13 @@ static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
 static const char *term_bad;
 static const char *term_good;
 
+static unsigned marker;
+
 struct node_data {
 	int weight;
+	unsigned marked;
 };
 
-/* Remember to update object flag allocation in object.h */
-#define COUNTED		(1u<<16)
-
 #define DEBUG_BISECT 0
 
 static inline struct node_data *node_data(struct commit *elem)
@@ -43,15 +43,17 @@ static int count_distance(struct commit_list *entry)
 	int nr = 0;
 	struct commit_list *todo = NULL;
 	commit_list_append(entry->item, &todo);
+	marker++;
 
 	while (todo) {
 		struct commit *commit = pop_commit(&todo);
 
-		if (!(commit->object.flags & (UNINTERESTING | COUNTED))) {
+		if (!(commit->object.flags & UNINTERESTING)
+		 && node_data(commit)->marked != marker) {
 			struct commit_list *p;
 			if (!(commit->object.flags & TREESAME))
 				nr++;
-			commit->object.flags |= COUNTED;
+			node_data(commit)->marked = marker;
 
 			for (p = commit->parents; p; p = p->next) {
 				commit_list_insert(p->item, &todo);
@@ -62,15 +64,6 @@ static int count_distance(struct commit_list *entry)
 	return nr;
 }
 
-static void clear_distance(struct commit_list *list)
-{
-	while (list) {
-		struct commit *commit = list->item;
-		commit->object.flags &= ~COUNTED;
-		list = list->next;
-	}
-}
-
 static int count_interesting_parents(struct commit *commit)
 {
 	struct commit_list *p;
@@ -123,10 +116,9 @@ static void show_list(const char *debug, int counted, int nr,
 		const char *subject_start;
 		int subject_len;
 
-		fprintf(stderr, "%c%c%c ",
+		fprintf(stderr, "%c%c ",
 			(flags & TREESAME) ? ' ' : 'T',
-			(flags & UNINTERESTING) ? 'U' : ' ',
-			(flags & COUNTED) ? 'C' : ' ');
+			(flags & UNINTERESTING) ? 'U' : ' ');
 		if (commit->util)
 			fprintf(stderr, "%3d", node_data(commit)->weight);
 		else
@@ -289,7 +281,6 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		if (!(p->item->object.flags & UNINTERESTING)
 		 && (node_data(p->item)->weight == -2)) {
 			node_data(p->item)->weight = count_distance(p);
-			clear_distance(list);
 
 			/* Does it happen to be at exactly half-way? */
 			if (!find_all && halfway(p, nr))
@@ -351,6 +342,8 @@ struct commit_list *find_bisection(struct commit_list *list,
 	struct commit_list *p, *best, *next, *last;
 	struct node_data *weights;
 
+	marker = 0;
+
 	show_list("bisection 2 entry", 0, 0, list);
 
 	/*
-- 
2.8.1.137.g522756c
