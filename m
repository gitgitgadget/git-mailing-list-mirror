From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 10/16] bisect: introduce distance_direction()
Date: Fri, 26 Feb 2016 03:04:36 +0100
Message-ID: <1456452282-10325-11-git-send-email-s-beyer@gmx.net>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 03:06:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ7nC-0007WA-5h
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 03:06:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752409AbcBZCFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 21:05:49 -0500
Received: from mout.gmx.net ([212.227.15.19]:53726 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752288AbcBZCFr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 21:05:47 -0500
Received: from fermat.fritz.box ([188.108.247.176]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0M3AWN-1ZgKwZ1q8F-00sxaV; Fri, 26 Feb 2016 03:05:44
 +0100
X-Mailer: git-send-email 2.7.2.383.g3fb0654
In-Reply-To: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:fATjGl8HjQEIzTfdlkkrkSFmTa0tn0YIBeHFAVtUzwDcJz0xEBe
 V1LdKhFcaSKI8xqkdZR90VMxQxSauEhWgVHIsnnXKAAWmssX1vLldigFNPhrwylOGrsguAf
 i//nKOMxV6aTHHhv+lvi1Kt1dHxvvmUDMif/VeSH4VN6Au9bkWPU0WXlALqaP4HVCjfhI1W
 qdGjqxROGrwDVNIxswtmw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xr7+XU3Rikc=:hjA+vVtm4as5/9QK2fbM5A
 n8QTdIDWOcbeEwaJfN4AhvCc1NDrIkrVT54d4QpdKPz5KM8BVIMyBU39juoppsuIa9DEYvzxT
 5Y6gp65jbv0IHTISHebDybfM8nlQPvWkc2czmJ6lzSzNK0Fpyr0gL5voDZIthrx4joN9gfS4N
 971entQUktWLGPpeQYmHQHXigHUFnOEyLYeFgd5k2EuuT5BpMyngAAOne4BiAYSfd5/Tl1HuA
 qxEUwDrdb+s4SeSO+SV3wDT/uZGW5iuklENa3+8KtXaSuNxDX6dY88ovMQ4GqFUB827UGseCP
 b8FWRqbslJO/0xt29cHHZzXuzOpE1za9JW3DpErDAipIGxWHEO2ZSm5XOlxBbOnMw6vad4BuS
 TWBtdnpmYpcRFdjYDZzjsE3KdvHvThW3frXuK4Rnnkn/5MoLzf64Kn6QyL4YoZuAnqSnM4dyz
 Hha+tiJ1sY4O/pNd53h5gczON4ZsvCbYA8on3dcJCqdOrdAbnbY2NHsAQIanznNZJsRB9ls3C
 wQkFz7O4hPTiS7+B3pr+4Sj4E0gnor4fxdeK25d4UoFAEY/27X9GHMyR4iYELidXKfIyImJUU
 ec6oxH2IXbLlkMmEMHWAVz4XD3z+LZvJcI74jPBu23/FG0QOmt0MugKQYL7D3geaS+F29TSG0
 Lj8dMlX/s8OR4vCqfh10YF53lXztLiWN6ln8b9O7d0GgE5dXl4NLPEt1vp5W8hZUlj6FB+XOQ
 a81XjN2GY8r82t8uruSpbq5ujjL1yhxS3IIOKiFvitAy+gPfZexTOgCWSg4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287521>

We introduce the concept of rising and falling distances
(in addition to a halfway distance).
This will be useful in subsequent commits.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 bisect.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/bisect.c b/bisect.c
index afdd1c4..a09a410 100644
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
 static int count_distance(struct commit *entry)
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
2.7.1.354.gd492730.dirty
