From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 3/4] pack-objects: don't traverse objects unnecessarily
Date: Tue, 18 Oct 2011 00:21:23 -0500
Message-ID: <1318915284-6361-3-git-send-email-dpmcgee@gmail.com>
References: <1318915284-6361-1-git-send-email-dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 18 07:21:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG27O-0001Ah-Os
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 07:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554Ab1JRFVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 01:21:32 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65245 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694Ab1JRFVb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 01:21:31 -0400
Received: by mail-iy0-f174.google.com with SMTP id k3so290439iae.19
        for <git@vger.kernel.org>; Mon, 17 Oct 2011 22:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ny5ILsUrQmB/SozXl7GNMyz7MidSL/bcWXWKiHs6X5U=;
        b=OJA9TgdlzFFxB4zCn6DAl0NxAmqLTcEPSOp/sy3AzEJ4uvvUCKsCMYXKjXC0q8rYZL
         xEkQ7Jsn/wLqo4nZwS4u327sY3br4S5l2iQRTBAlCDZrWNis2pvRzri2J+VjN44R7Iey
         QSDFk/8yaXncyrH3claYQLSkHkImaOtyZScwk=
Received: by 10.42.147.65 with SMTP id m1mr1576260icv.27.1318915291241;
        Mon, 17 Oct 2011 22:21:31 -0700 (PDT)
Received: from localhost (c-71-194-41-240.hsd1.il.comcast.net. [71.194.41.240])
        by mx.google.com with ESMTPS id z10sm2461903ibv.9.2011.10.17.22.21.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Oct 2011 22:21:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1318915284-6361-1-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183857>

This brings back some of the performance lost in optimizing recency
order inside pack objects. We were doing extreme amounts of object
re-traversal: for the 2.14 million objects in the Linux kernel
repository, we were calling add_to_write_order() over 1.03 billion times
(a 0.2% hit rate, making 99.8% of of these calls extraneous).

Two optimizations take place here- we can start our objects array
iteration from a known point where we left off before we started trying
to find our tags, and we don't need to do the deep dives required by
add_family_to_write_order() if the object has already been marked as
filled.

These two optimizations bring some pretty spectacular results via `perf
stat`:

task-clock:   83373 ms        --> 43800 ms         (50% faster)
cycles:       221,633,461,676 --> 116,307,209,986  (47% fewer)
instructions: 149,299,179,939 --> 122,998,800,184  (18% fewer)

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 builtin/pack-objects.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0de10d2..d9fb202 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -490,7 +490,7 @@ static void add_family_to_write_order(struct object_entry **wo,
 
 static struct object_entry **compute_write_order(void)
 {
-	unsigned int i, wo_end;
+	unsigned int i, wo_end, last_untagged;
 
 	struct object_entry **wo = xmalloc(nr_objects * sizeof(*wo));
 
@@ -521,7 +521,7 @@ static struct object_entry **compute_write_order(void)
 	for_each_tag_ref(mark_tagged, NULL);
 
 	/*
-	 * Give the commits in the original recency order until
+	 * Give the objects in the original recency order until
 	 * we see a tagged tip.
 	 */
 	for (i = wo_end = 0; i < nr_objects; i++) {
@@ -529,6 +529,7 @@ static struct object_entry **compute_write_order(void)
 			break;
 		add_to_write_order(wo, &wo_end, &objects[i]);
 	}
+	last_untagged = i;
 
 	/*
 	 * Then fill all the tagged tips.
@@ -541,7 +542,7 @@ static struct object_entry **compute_write_order(void)
 	/*
 	 * And then all remaining commits and tags.
 	 */
-	for (i = 0; i < nr_objects; i++) {
+	for (i = last_untagged; i < nr_objects; i++) {
 		if (objects[i].type != OBJ_COMMIT &&
 		    objects[i].type != OBJ_TAG)
 			continue;
@@ -551,7 +552,7 @@ static struct object_entry **compute_write_order(void)
 	/*
 	 * And then all the trees.
 	 */
-	for (i = 0; i < nr_objects; i++) {
+	for (i = last_untagged; i < nr_objects; i++) {
 		if (objects[i].type != OBJ_TREE)
 			continue;
 		add_to_write_order(wo, &wo_end, &objects[i]);
@@ -560,8 +561,13 @@ static struct object_entry **compute_write_order(void)
 	/*
 	 * Finally all the rest in really tight order
 	 */
-	for (i = 0; i < nr_objects; i++)
-		add_family_to_write_order(wo, &wo_end, &objects[i]);
+	for (i = last_untagged; i < nr_objects; i++) {
+		if (!objects[i].filled)
+			add_family_to_write_order(wo, &wo_end, &objects[i]);
+	}
+
+	if(wo_end != nr_objects)
+		die("ordered %u objects, expected %u", wo_end, nr_objects);
 
 	return wo;
 }
-- 
1.7.7
