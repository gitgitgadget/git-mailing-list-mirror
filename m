From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2 10/21] bisect: get rid of recursion in count_distance()
Date: Sun, 10 Apr 2016 15:19:03 +0200
Message-ID: <1460294354-7031-11-git-send-email-s-beyer@gmx.net>
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
	id 1apFI2-0000Af-6v
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 15:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441AbcDJNUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 09:20:16 -0400
Received: from mout.gmx.net ([212.227.17.21]:50412 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753312AbcDJNUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 09:20:09 -0400
Received: from fermat.fritz.box ([92.76.224.62]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0LtlG5-1bqK8M3qg1-011ENL; Sun, 10 Apr 2016 15:20:04
 +0200
X-Mailer: git-send-email 2.8.1.137.g522756c
In-Reply-To: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:shxXk5pNL65IqWPuLXJ6eyIN/vKEnybHfDuetR/5/wM/4OO4LXt
 da1oB3+FGZ/KCRGu7xlI5D5KFEoBWQUkudHGkhp9NqMcsnyCzih4LaFqoWGWJ1H0bEZJk60
 0syImTnsOISZ0SPU+PcIzHfXQ/k6a+PT/IR4Mh3W7zoozOI9dneTUJkmLw4WarcyI6DimAq
 1gjVRTI5QEXYWcy4Gya+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ELUek6bTqJ0=:3j6Ebe7OEKCbxK7uFpnu74
 bpSVn/N4lI82/A7QNqhPv5WHAwIKHbYLB4NgfQmK1EzVQ1KCrvLh/4dQrSL4wjjoPX+8xxzb+
 r/rK4VOCs6cnPHXJ9bYLZfu/fLndkOk2TM3z9owxsfW01e56DKtr+n+lHHEehHeJ0uPwGh93t
 im/ohRXjsrb37/8xLRxph2JhwU8OpBQyhrwj0CFEMI6lchfoYLOZOph5KmxBcvrYfpwPWG3Zy
 BfZ+cahQq7eiQqHVlvfDPNpGcjzudlsvOcbVG0ngOdUYSbZ/thHzP/FZokJSRMNleguIMm2Cj
 m4JEBvizOJZsQ/VFE+fqBh46fBvb0S2qJrE/NyfJL8znR9cZEXH2nZaEwU334QT44s+FevAcN
 DQdYrTz/4yHFu74ZKAq3/Hw5JiuB5leyDReOVzxLBO1M7b7LXBzfLp0Jsoy/Rd+K30opHi+Oj
 VroCbha2BJysPE56v9CJMcjG5u8cfuoz8dWBruMNscCXzxrdruSAsR09h/NJatE4g1PGVu93l
 E6uk8+D3rT1JoBid9FNxFN8o5bhFxj2+PAuepax/K4ElX/KUeXJcxTqns7kl7UOmixnDvkfXD
 ZPv7r2zpV3AQxKk89dLHC71zr+zVuuyBbxUPSZdqXufC3ofYJgKny3fpgVFJ6s/gUr2hyiQXD
 CNLTzZHkmlV51Dyv3YtzCLJZROaNux4xisGWGPaP2pwcqHCh9Sy/VJJeuSwN5m6Dy1i55Sul1
 ojJaeRGltzr7j5GJck97/mjddJ7YHZbQif3JYhGhRyDL86hRYn8L3VPbVOE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291150>

Large repositories with a huge amount of merge commits in the
bisection process could lead to stack overflows in git bisect.
In order to prevent this, this commit uses an *iterative* version
for counting the number of ancestors of a commit.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 bisect.c | 55 ++++++++++++++++++++++---------------------------------
 1 file changed, 22 insertions(+), 33 deletions(-)

diff --git a/bisect.c b/bisect.c
index 1a13f35..16bbfa6 100644
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
2.8.1.137.g522756c
