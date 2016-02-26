From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 09/16] bisect: extract get_distance() function from code duplication
Date: Fri, 26 Feb 2016 03:04:35 +0100
Message-ID: <1456452282-10325-10-git-send-email-s-beyer@gmx.net>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 03:05:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ7n2-0007NX-0r
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 03:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452AbcBZCFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 21:05:50 -0500
Received: from mout.gmx.net ([212.227.15.18]:49573 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752065AbcBZCFq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 21:05:46 -0500
Received: from fermat.fritz.box ([188.108.247.176]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0M3j17-1Zhz6P0hTF-00rItZ; Fri, 26 Feb 2016 03:05:44
 +0100
X-Mailer: git-send-email 2.7.2.383.g3fb0654
In-Reply-To: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:OIfUuyrvl4o5pCXK+Avv3OStp8flsjd9imXg9x3gLzhD7NffJ9Q
 Q27BqQvwz+CunhtqP+1v8eZfkgFbSuDeVZYwfY5BOfR542ADpUVgq718d+xIwiJ7XN7ADTC
 h2dgqhuz82wZYHEn6CO8MT+TRbkADWEnTweZnlwP2zpBKuQc5NXd0wPVDatCcasORUGN6xH
 QHVycMDzIrclyo4lBCpKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NUFHgcxOfPk=:PN7sL6BsL7i6qNkNbEispL
 /UFey4Cx6Kuw43uOAfBYdcf+6fmVHnHyr1Ch+fIhFXbiMWtzK6tX4mWP+Ij0JgFz156qnZUqm
 Zo3mVHptpTtUUl3KfzNPyF7tuQkNZiBiKWt9gZKiM4UgPNRzPpyDfoYC0GbWkZ/ay3hGZDrD2
 QuhlwsrkrBad5YxyJ85KpuypV5RW1GtY5sjhJn25DzPBYOEdHoi0Eoa2ImeZSJA0XhI4ef5RC
 7Lb4DpUiXUroXzmlO6e6a7yT9gkuaPNNDNXDh3ywT+6urIOprKufisjarcR8N9gEmM6wMtfop
 ahIEZ1bFaIbX56Yich7ro7r3hb9JQrXwDuMfs7eLKoHt5DVAM2zaMS+fnlgTQV/phxXWYpmot
 UgCU1AcETfeyOX+aRWedfEyfryJ0ugTKHtaI6Y20Ejf3dKofN5gdj92B9dik7tuukGYc9HuOC
 PO7RmvRAdXPel7FwnIPbg5QITw9b9v7NYs0M3qIVucZNo178VbHM4cgj0pumwvxHJ6lT7kBeT
 0Cto9PAdclYEQ94C7LWtU7S6yQhrq/SpVqcLo+bgqD7Mrt9srL0uxN0BT+CXY2hoZZT4Fx3sm
 nRKfYulbU2JqPGrDuTiG1SNVlZqt0PUutcdSTsDwkcJzxH+1kNwthJFmgdWv5tA8hInj+8hsL
 Qdp6Y+NjBkSssLzp35/gaE5w/COQh1s/PZsdXT34eZGhqdVubXMhuI0u3qGWvAqJi5RWOwajq
 mAvbPPcJ4Xtr8b5OZI1B29RABMa8j+AcXZqauWj+hRTx03wkmNcRYDuLOcY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287516>

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

We will also use that function more often later.

 bisect.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/bisect.c b/bisect.c
index 76f2445..afdd1c4 100644
--- a/bisect.c
+++ b/bisect.c
@@ -38,6 +38,14 @@ static inline struct node_data *node_data(struct commit *elem)
 	return (struct node_data *)elem->util;
 }
 
+static inline int get_distance(struct commit *commit, int total)
+{
+	int distance = node_data(commit)->weight;
+	if (total - distance < distance)
+		distance = total - distance;
+	return distance;
+}
+
 static int count_distance(struct commit *entry)
 {
 	int nr = 0;
@@ -148,9 +156,7 @@ static struct commit_list *best_bisection(struct commit_list *list, int nr)
 
 		if (flags & TREESAME)
 			continue;
-		distance = node_data(p->item)->weight;
-		if (nr - distance < distance)
-			distance = nr - distance;
+		distance = get_distance(p->item, nr);
 		if (distance > best_distance) {
 			best = p;
 			best_distance = distance;
@@ -188,9 +194,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
 
 		if (flags & TREESAME)
 			continue;
-		distance = node_data(p->item)->weight;
-		if (nr - distance < distance)
-			distance = nr - distance;
+		distance = get_distance(p->item, nr);
 		array[cnt].commit = p->item;
 		array[cnt].distance = distance;
 		cnt++;
-- 
2.7.1.354.gd492730.dirty
