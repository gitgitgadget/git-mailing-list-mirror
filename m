From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2 17/21] bisect: rename count_distance() to compute_weight()
Date: Sun, 10 Apr 2016 15:19:10 +0200
Message-ID: <1460294354-7031-18-git-send-email-s-beyer@gmx.net>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 15:21:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apFIf-0000Tk-Nx
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 15:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588AbcDJNU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 09:20:56 -0400
Received: from mout.gmx.net ([212.227.17.22]:52303 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753101AbcDJNUL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 09:20:11 -0400
Received: from fermat.fritz.box ([92.76.224.62]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0Lmwpk-1bRsQU3oj6-00h2vW; Sun, 10 Apr 2016 15:20:07
 +0200
X-Mailer: git-send-email 2.8.1.137.g522756c
In-Reply-To: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:tKZ58wGo61woXW5LqMqLbxzSQNJj5Q3AA1rV1nU2awpYOdY2QtB
 zt83DDCMuuFE1a3BHJdrAOEpED+y85eTsfzAnL8C0RXSyFWIH0zD4HqXYlMEmyWef12Sj51
 2Rdp1NLzbMqsgj+RHDEePnEhx1wywmbBHj1330OG6UEDhDF+9giPT1HItXIuNmcwSQv4uZ1
 iLDZqeqnqZ9OPocoNXkVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/2AeDoeLLIA=:cQyLuR6zqu/MmA/Z46+rMk
 vYfWKm7FN7GEkneOgRQeoskc8qaIZhKEW5rSyeBFkqbrN/F+JeaCCCjd6ik2wo5bN1r0a88e2
 7pQoPAplPGwI7a986Viw3P55Jh8Vk5Pa7hmvhGU0N8oSDrrjZ/E2Lv0t8bgohg6ZfVVDd4nS5
 jSTStsPl287xwYAxeEYLtMB0mu0h1xAaBu1aRjdn70GXNde2ZiPCD53pIw8DM0SussZu9AY8f
 9cCN2jGx5qhsbvmZwNkTDXJCx5x29Q/NCS6phWBju+5vhyVWoJ2MqSQvprkCDefPkBrPin5TM
 BDdPDEUntITtuFI4J8elFVf1NfZa6BDP3Ggmz/13qPz0Hk4StPyr5qP74+vx5fLmRgTdjFRRl
 njCLdlhgKUgDBrPkaNcLGfXYEySGomW85n5wiYSY5k/fwmLy8Pmo2HHt1tkU3n62MYFw0hwPt
 OpT3esm9uprbCZaw9n13okElHeKJlMhyoyA3aj61R31aL2fIMAsiaJ0c3KCpFXTIxsQeGWQ82
 BFL1ztcU4X4NU/82yFTIaeGmjau8C4I2tyxkczGgYK4yb76hXFmDG8rTbwYulUTzJo5emIkXX
 8Je65jKJPHKl9QKHpaxNTZtXWDEfISMBc40q92x95L89s6Rzh5w68aBlmcf9h1VZURRmprICD
 nCmq3esCW5OnQ5oLOb65yd+4EMxvjC6OCyfIkQfO2Uad9IGLkwwvHR/9Q8wzAEsJM0HWkiAfb
 NIAg7AkXxySVRGWP+gQmC4BtOVk96HBfydgmHopJUInYwoHb7khBYsEjX/0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291159>

Let us use the term "weight" for the number of ancestors
of each commit, and "distance" for the number
min{weight, #commits - weight}. (Bisect finds the commit
with maximum distance.)

In these terms, "count_distance()" is the wrong name of
the function. So it is renamed to "compute_weight()",
and it also directly sets the computed weight.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 bisect.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/bisect.c b/bisect.c
index 2b415ad..a254f28 100644
--- a/bisect.c
+++ b/bisect.c
@@ -70,7 +70,7 @@ static inline int distance_direction(struct commit *commit)
 	return 0;
 }
 
-static int count_distance(struct commit *elem)
+static int compute_weight(struct commit *elem)
 {
 	int nr = 0;
 	struct commit_list *todo = NULL;
@@ -93,6 +93,7 @@ static int count_distance(struct commit *elem)
 		}
 	}
 
+	node_data(elem)->weight = nr;
 	return nr;
 }
 
@@ -241,7 +242,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list)
  * be computed.
  *
  * weight = -2 means it has more than one parent and its distance is
- * unknown.  After running count_distance() first, they will get zero
+ * unknown.  After running compute_weight() first, they will get zero
  * or positive distance.
  */
 static struct commit_list *do_find_bisection(struct commit_list *list,
@@ -286,7 +287,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 	 * If you have only one parent in the resulting set
 	 * then you can reach one commit more than that parent
 	 * can reach.  So we do not have to run the expensive
-	 * count_distance() for single strand of pearls.
+	 * compute_weight() for single strand of pearls.
 	 *
 	 * However, if you have more than one parent, you cannot
 	 * just add their distance and one for yourself, since
@@ -299,7 +300,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 	for (p = list; p; p = p->next) {
 		if (!(p->item->object.flags & UNINTERESTING)
 		 && (node_data(p->item)->weight == -2)) {
-			node_data(p->item)->weight = count_distance(p->item);
+			compute_weight(p->item);
 
 			/* Does it happen to be at exactly half-way? */
 			if (!find_all && halfway(p->item))
@@ -308,7 +309,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		}
 	}
 
-	show_list("bisection 2 count_distance", counted, list);
+	show_list("bisection 2 compute_weight", counted, list);
 
 	while (counted < total) {
 		for (p = list; p; p = p->next) {
-- 
2.8.1.137.g522756c
