From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/4] Move finding bisection into do_find_bisection.
Date: Tue, 31 Jul 2007 14:48:35 +0200
Message-ID: <20070731144835.0cbca678.chriscool@tuxfamily.org>
References: <20070731143602.a5ed0a04.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jul 31 14:42:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFr36-0004jJ-GV
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 14:42:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757154AbXGaMl7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 08:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757033AbXGaMl7
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 08:41:59 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:32952 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756677AbXGaMl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 08:41:58 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 17F901AB2B7;
	Tue, 31 Jul 2007 14:41:57 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id D0E471AB2F1;
	Tue, 31 Jul 2007 14:41:56 +0200 (CEST)
In-Reply-To: <20070731143602.a5ed0a04.chriscool@tuxfamily.org>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.10.13; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54346>

This factorises some code and make a big function smaller.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-rev-list.c |   40 +++++++++++++++++++++++++---------------
 1 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 5bcafe4..4e2524a 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -255,6 +255,9 @@ static void show_list(const char *debug, int counted, int nr,
 }
 #endif /* DEBUG_BISECT */
 
+static struct commit_list *do_find_bisection(struct commit_list *list,
+					     int nr, int *weights);
+
 /*
  * zero or positive weight is the number of interesting commits it can
  * reach, including itself.  Especially, weight = 0 means it does not
@@ -272,7 +275,7 @@ static void show_list(const char *debug, int counted, int nr,
 static struct commit_list *find_bisection(struct commit_list *list,
 					  int *reaches, int *all)
 {
-	int n, nr, on_list, counted, distance;
+	int nr, on_list;
 	struct commit_list *p, *best, *next, *last;
 	int *weights;
 
@@ -301,6 +304,25 @@ static struct commit_list *find_bisection(struct commit_list *list,
 
 	*all = nr;
 	weights = xcalloc(on_list, sizeof(int));
+
+	/* Do the real work of finding bisection commit. */
+	best = do_find_bisection(list, nr, weights);
+
+	if (best)
+		best->next = NULL;
+
+	*reaches = weight(best);
+	free(weights);
+
+	return best;
+}
+
+static struct commit_list *do_find_bisection(struct commit_list *list,
+					     int nr, int *weights)
+{
+	int n, counted, distance;
+	struct commit_list *p, *best;
+
 	counted = 0;
 
 	for (n = 0, p = list; p; p = p->next) {
@@ -357,12 +379,8 @@ static struct commit_list *find_bisection(struct commit_list *list,
 		weight_set(p, distance);
 
 		/* Does it happen to be at exactly half-way? */
-		if (halfway(p, distance, nr)) {
-			p->next = NULL;
-			*reaches = distance;
-			free(weights);
+		if (halfway(p, distance, nr))
 			return p;
-		}
 		counted++;
 	}
 
@@ -400,12 +418,8 @@ static struct commit_list *find_bisection(struct commit_list *list,
 
 			/* Does it happen to be at exactly half-way? */
 			distance = weight(p);
-			if (halfway(p, distance, nr)) {
-				p->next = NULL;
-				*reaches = distance;
-				free(weights);
+			if (halfway(p, distance, nr))
 				return p;
-			}
 		}
 	}
 
@@ -425,12 +439,8 @@ static struct commit_list *find_bisection(struct commit_list *list,
 		if (distance > counted) {
 			best = p;
 			counted = distance;
-			*reaches = weight(p);
 		}
 	}
-	if (best)
-		best->next = NULL;
-	free(weights);
 	return best;
 }
 
-- 
1.5.2.1.144.gabc40
