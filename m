From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 07/16] bisect: replace clear_distance() by unique markers
Date: Fri, 26 Feb 2016 03:04:33 +0100
Message-ID: <1456452282-10325-8-git-send-email-s-beyer@gmx.net>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 03:05:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ7n2-0007NX-Ss
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 03:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbcBZCFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 21:05:51 -0500
Received: from mout.gmx.net ([212.227.15.18]:53779 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752219AbcBZCFq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 21:05:46 -0500
Received: from fermat.fritz.box ([188.108.247.176]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0MJjvw-1aY1r92N2y-001876; Fri, 26 Feb 2016 03:05:43
 +0100
X-Mailer: git-send-email 2.7.2.383.g3fb0654
In-Reply-To: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:vslzMlOLIgceHEDvzWixbDXMm2jpzETqwkl5B77hBCXPWIFdp6+
 xBs0AVRkme24avw7u86qDChG7k7tXhtgu2ttfwdMYD5Imr7pk/UOV4bK4Pcc1d9ct4FDWOH
 D+06/BaxhgY18WkFP9g1Y9O/icuZyIzYFuAd+QF+DyjpAI1TTNrjtsg4fwnGojDxmE2XzUd
 m3GfTnIk58KZkcQPKkBSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PXXir0+U8mY=:j1215DpihLj5J0jv+Q/SH3
 WKdYGcsuBr/iDtUg1tJ4yTk7HiqOwlpZdxXI89jByXOkdJOvSMYoEWrEVtv0qiJ9NSC4lCzJp
 ryNrH1cZMBGZNyZiRZUpFzv+CuCalRQsZNbytAHfn+DvrCYwr0HIIfTM/82kpfgYJqLJIYbUt
 3m27VmLZD8HPXx1DBZNo4J6Ndy5LRHu8VXU8+Qp01S6B7s89engiJ7xQsVrBHToRhFFrcfvj6
 QNS4CnW+UzMbW36VfnVsh1A+iMLQVAzPSSz3o8VuY4LmXyrTL4k68H79/tTt3lu76KpK3e2h0
 hSTwB2jQFOKIAWgOf8VUtrDtIo92uDsbBdS5cxlKyzIhZuF0OQdIDQ0jJo22rkfzLSMaWIxDK
 4SaVu6d4VNCXFebkZg70/QjScyRCPaUiqDexT2exljjZXCWFtiB1EWJaDdomiyRpra0iSxeaG
 FTlPEbcB9CCu0XLv+d8TDjQYxjWLHChcIaHFo7Ppqe7vSpySA0atz11ECuNw94S5OiOQM3hm0
 p2gtmLOeleOsj4mlkF9NB7/FF2rOXfGwV1hUAK/7s6GfAeSv54/IU86kIX/qC969xBnXIDBeY
 F0omaPq++LZfLPMMIT2Ph4GHPuFgdn0Wbdy20ShXoeLYRdConNXbCc0Pl/FChrvUII4VoMH/3
 gt872wlgr1lE5P2AONPt1fwWfIDWnn5n1kJ1SHtctikkP5XkvcR5VoXcSfw/NJAmjLvD7bemD
 t4QMn5WYvt7lT3ZS5PlidVjvXllfrdXrXQnpZDwhb8JbDKRKRcOFcYQhUlg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287519>

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

Yaaay, this is our first gain of performance!
My test: ~30 seconds

 bisect.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/bisect.c b/bisect.c
index bcb58ed..6df13b0 100644
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
2.7.1.354.gd492730.dirty
