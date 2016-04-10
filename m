From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2 14/21] bisect: extract get_distance() function from code duplication
Date: Sun, 10 Apr 2016 15:19:07 +0200
Message-ID: <1460294354-7031-15-git-send-email-s-beyer@gmx.net>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 15:21:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apFIg-0000Tk-AM
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 15:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753598AbcDJNU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 09:20:57 -0400
Received: from mout.gmx.net ([212.227.17.22]:55017 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753371AbcDJNUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 09:20:09 -0400
Received: from fermat.fritz.box ([92.76.224.62]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MLi1v-1aoy2A2WR9-000qTh; Sun, 10 Apr 2016 15:20:05
 +0200
X-Mailer: git-send-email 2.8.1.137.g522756c
In-Reply-To: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:Eic70XarcEMJYkca++TS+fEIehZWYz1Ckb9NrkXIEsdDj9jbz/J
 RjDTgH9ghJ6hz/0CHVwzLdcL9KqkK3d+kGL0W1ZRXG/ZaVQcnadLNwZ44tqaLJjXkwbs9h2
 49UQMMNrZSpuDXp47wMwineIFOvEV9bCb+l8h2OYlakpibDV0AloU77QTcf27Ofmgs7N1PJ
 cXmPfXTavWh/MFg5wcvHQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2Tmqw0WL2NI=:RIMTt0O6aISeUa/QoPyYac
 g3x3OwjXnSWwBH9wZdIr1klewWXM0Z3YbOhjWffP+szEKtcAKWySC/XS9JXVnus2/K2AStiug
 /J5gkElTjpw2FjeCl3/hfMHwcaUWvHPk0iYVd5LMIe+shuiGj3hdv3ES6nOV1mR7M2kffS25b
 e8+8vViSzMmrf3DuQ3tSWcq2f8EyCYWQ4NWvrFm3VaPQLwzLSmLjN8LRTUsdhynsFqMrwN46B
 /MucnWEc/YGCesZ8g2x9pxvTwoyunkIoFG9/EEgxGQSmLAeBbacBv+RrZq1o6jL3/1QGWvVHj
 rT0B5g6vbaidkFGeQP/ygPeroCQJ/EAAKixNxUE5ZdEhECuDzAa/9YAmtYYMjIWlkkIEZo6Bs
 fLuqMSDYOqlkUABwPQvOZIDk0Mmzg68IQzhMYQiN3TAefWRiuxBdRiy+AXz3+irhElsR+MmR4
 yvihx/iwvamvQuVyufmwaNdhwLWBJDXcJxwFSNPfdokMmwoDgV1rYm/whAEcGqygemVXxe3ia
 g++Qq2AjM1Mq2j1748guiJkT13hkbGHBqL/LvdBQM1chUsh+MWa6CBvvTjwiDlCl95l2T6SGo
 fkdSgWMsJA5t7avHe577ZAOQzWOqIUbs4SMJFdQ4aqrzq/zpgfxmk6CE8+nysn68FgpiB7/S2
 gLS7YAS5BETXK8wcEqxDWxc01GiSDO4dOWajRnpnPzJJGBm3MhmW1TFW9ulsetlUnSlG0Oc7r
 H8WTZdvoVL2IWnFwRqE/lTXOb9wqVnwAvbrQD95VWxqAA+b1fBgUmB5UQFw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291157>

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 bisect.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/bisect.c b/bisect.c
index 2c1102f..cfd406c 100644
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
 static int count_distance(struct commit *elem)
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
2.8.1.137.g522756c
