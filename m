From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2 15/21] bisect: introduce distance_direction()
Date: Sun, 10 Apr 2016 15:19:08 +0200
Message-ID: <1460294354-7031-16-git-send-email-s-beyer@gmx.net>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 15:21:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apFIf-0000Tk-53
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 15:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581AbcDJNUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 09:20:55 -0400
Received: from mout.gmx.net ([212.227.17.21]:57150 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753391AbcDJNUK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 09:20:10 -0400
Received: from fermat.fritz.box ([92.76.224.62]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0M0smx-1bekLC44K7-00v9Yr; Sun, 10 Apr 2016 15:20:06
 +0200
X-Mailer: git-send-email 2.8.1.137.g522756c
In-Reply-To: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:w2T/9i2REi+aX1SbUBj+ZQ4KA297+0IrwZkL7i9KrL6Z1OIEVqC
 QYkteW39VvTipmCvC5PlA58x1BZSjip+cGM8knaJcl1eBilHmd/I+udZ85qwKNFeUhVAhac
 bz6LOW6wpneH7h1poC2Lt+05Zn2pIkWruG8i0eRRzZsg+A5dEjV6UdOx5CFUBmxCsBKono+
 RezVp25OxH/zSQ2IKa05w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rif7Tob/VwI=:EzMNU8L1GGfKf2EArnZwQe
 8MHpOFAxxb+onx5RsEhcStTG0MWEUI1RsMueQn/a5emFe1fyGvoLHvji1ZpXvLm58MbQCKWV5
 XziqcJB3PN26tBvEF8NNiazlQ25sc2NtK93qoxJ3pdNT3mv7LqLixGx9pIorsKQt3dyt+csg5
 oHMGr/R07/bAhq5FAluLWjCLytgCkwR+rk4iiaf+ae2u/EGquo2FNK8XLNcKMeStPqLiAXdTS
 1BUdrCzydy/ZVgwNis4zAAICXOQZVxMx8c3YSs6CSg5eHZ/YjQhqmiE1oU6+eA+KmVK7Nc1qX
 Loh85MqZ2suJGxZRTq3atsUl14Zsql173okJTMaLqgTzZpzU6Ia5rKq+Ei4tUw3GBSYGP+fLy
 FoAjAfqHzP2ICTHvX1VZjed4fvtT/Z9mDGxKqogWgOH1Fu3fUSfzuYTCCCfdrlE7vwq/qVbuG
 zAgCR7X9fkikdiry9zRML8WJkfizN+B0xHCWwAa2PwFJRMuKpy6Az99dtJz8GyE18IlOXuz8U
 nFkdOxTbV6R5vwbwULnSh0GUSfOH92umHiyt2etk8HHXBCuUwGc/u8DqkrgRzut8yjATYdhun
 53OU0sfpp+ezZaO9vusIeJ/UgQ/UwFkAOKf/01bC3JmPipzHLDMz3Db161uiuoMSoM3d6Kitd
 jSpupJdcB6eLSbqZZFMfUENdVW+Xmnr98T0M94VZcB1N0tbfCgucGlFQtAwzbUTw1ZXCVr22u
 lMTYVMyfZvrKnQWQ1Dupj6VRATZiiEI9no8FV1BHeUADOU6DtazXdJ+cDVs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291158>

We introduce the concept of rising and falling distances
(in addition to a halfway distance).
This will be useful in subsequent commits.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 bisect.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/bisect.c b/bisect.c
index cfd406c..f737ce7 100644
--- a/bisect.c
+++ b/bisect.c
@@ -46,6 +46,28 @@ static inline int get_distance(struct commit *commit, int total)
 	return distance;
 }
 
+/*
+ * Return -1 if the distance is falling.
+ * (A falling distance means that the distance of the
+ *  given commit is larger than the distance of its
+ *  child commits.)
+ * Return 0 if the distance is halfway.
+ * Return 1 if the distance is rising.
+ */
+static inline int distance_direction(struct commit *commit, int total)
+{
+	int doubled_diff = 2 * node_data(commit)->weight - total;
+	if (doubled_diff < -1)
+		return 1;
+	if (doubled_diff > 1)
+		return -1;
+	/*
+	 * 2 and 3 are halfway of 5.
+	 * 3 is halfway of 6 but 2 and 4 are not.
+	 */
+	return 0;
+}
+
 static int count_distance(struct commit *elem)
 {
 	int nr = 0;
@@ -92,16 +114,7 @@ static inline int halfway(struct commit *commit, int nr)
 	 */
 	if (commit->object.flags & TREESAME)
 		return 0;
-	/*
-	 * 2 and 3 are halfway of 5.
-	 * 3 is halfway of 6 but 2 and 4 are not.
-	 */
-	switch (2 * node_data(commit)->weight - nr) {
-	case -1: case 0: case 1:
-		return 1;
-	default:
-		return 0;
-	}
+	return !distance_direction(commit, nr);
 }
 
 #if !DEBUG_BISECT
-- 
2.8.1.137.g522756c
