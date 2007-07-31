From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/4] Move some bisection code into best_bisection.
Date: Tue, 31 Jul 2007 14:48:37 +0200
Message-ID: <20070731144837.3bb2c9eb.chriscool@tuxfamily.org>
References: <20070731143602.a5ed0a04.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jul 31 14:42:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFr37-0004jJ-Au
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 14:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757171AbXGaMmD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 08:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757033AbXGaMmD
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 08:42:03 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:32964 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756792AbXGaMl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 08:41:58 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 912CC1AB2FA;
	Tue, 31 Jul 2007 14:41:57 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 608101AB2F4;
	Tue, 31 Jul 2007 14:41:57 +0200 (CEST)
In-Reply-To: <20070731143602.a5ed0a04.chriscool@tuxfamily.org>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.10.13; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54344>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-rev-list.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 4e2524a..e5e8011 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -258,6 +258,8 @@ static void show_list(const char *debug, int counted, int nr,
 static struct commit_list *do_find_bisection(struct commit_list *list,
 					     int nr, int *weights);
 
+static struct commit_list *best_bisection(struct commit_list *list, int nr);
+
 /*
  * zero or positive weight is the number of interesting commits it can
  * reach, including itself.  Especially, weight = 0 means it does not
@@ -321,7 +323,7 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 					     int nr, int *weights)
 {
 	int n, counted, distance;
-	struct commit_list *p, *best;
+	struct commit_list *p;
 
 	counted = 0;
 
@@ -426,9 +428,17 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 	show_list("bisection 2 counted all", counted, nr, list);
 
 	/* Then find the best one */
-	counted = -1;
+	return best_bisection(list, nr);
+}
+
+static struct commit_list *best_bisection(struct commit_list *list, int nr)
+{
+	struct commit_list *p, *best;
+	int best_distance = -1;
+
 	best = list;
 	for (p = list; p; p = p->next) {
+		int distance;
 		unsigned flags = p->item->object.flags;
 
 		if (revs.prune_fn && !(flags & TREECHANGE))
@@ -436,11 +446,12 @@ static struct commit_list *do_find_bisection(struct commit_list *list,
 		distance = weight(p);
 		if (nr - distance < distance)
 			distance = nr - distance;
-		if (distance > counted) {
+		if (distance > best_distance) {
 			best = p;
-			counted = distance;
+			best_distance = distance;
 		}
 	}
+
 	return best;
 }
 
-- 
1.5.2.1.144.gabc40
