From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 2/4] pack-objects: use unsigned int for counter and offset values
Date: Tue, 18 Oct 2011 00:21:22 -0500
Message-ID: <1318915284-6361-2-git-send-email-dpmcgee@gmail.com>
References: <1318915284-6361-1-git-send-email-dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 18 07:21:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG27O-0001Ah-7k
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 07:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885Ab1JRFVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 01:21:30 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65245 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694Ab1JRFV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 01:21:29 -0400
Received: by mail-iy0-f174.google.com with SMTP id k3so290439iae.19
        for <git@vger.kernel.org>; Mon, 17 Oct 2011 22:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8hjqoCvyzjjazgNmSPKJJKumXqIlc2oIDw83uTdjyYc=;
        b=Ao/e5e5/u7CswBXjJaxQxGbYekp6qTesWMbn3fz4E0t9fcFKDX1krYw1Ac2R6KI1G1
         pUw0oT+knDr7MG+dEhnTvm3Bq5Hd9AoVhgHbqIhnOIKoo9pk2HzKuuqDfWz8lDFr2xIu
         Ks0UhRCz/FdqQbvoEDB0Rp7bQbXGZgc4mkZQY=
Received: by 10.43.132.4 with SMTP id hs4mr1422939icc.57.1318915288673;
        Mon, 17 Oct 2011 22:21:28 -0700 (PDT)
Received: from localhost (c-71-194-41-240.hsd1.il.comcast.net. [71.194.41.240])
        by mx.google.com with ESMTPS id eh34sm2500806ibb.5.2011.10.17.22.21.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Oct 2011 22:21:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1318915284-6361-1-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183855>

This is done in some of the new pack layout code introduced in commit
1b4bb16b9ec331c. This more closely matches the nr_objects global that is
unsigned that these variables are based off of and bounded by.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 builtin/pack-objects.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0ab3a3b..0de10d2 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -455,7 +455,7 @@ static int mark_tagged(const char *path, const unsigned char *sha1, int flag,
 }
 
 static inline void add_to_write_order(struct object_entry **wo,
-			       int *endp,
+			       unsigned int *endp,
 			       struct object_entry *e)
 {
 	if (e->filled)
@@ -465,7 +465,7 @@ static inline void add_to_write_order(struct object_entry **wo,
 }
 
 static void add_descendants_to_write_order(struct object_entry **wo,
-					   int *endp,
+					   unsigned int *endp,
 					   struct object_entry *e)
 {
 	struct object_entry *child;
@@ -477,7 +477,7 @@ static void add_descendants_to_write_order(struct object_entry **wo,
 }
 
 static void add_family_to_write_order(struct object_entry **wo,
-				      int *endp,
+				      unsigned int *endp,
 				      struct object_entry *e)
 {
 	struct object_entry *root;
@@ -490,7 +490,7 @@ static void add_family_to_write_order(struct object_entry **wo,
 
 static struct object_entry **compute_write_order(void)
 {
-	int i, wo_end;
+	unsigned int i, wo_end;
 
 	struct object_entry **wo = xmalloc(nr_objects * sizeof(*wo));
 
@@ -506,8 +506,8 @@ static struct object_entry **compute_write_order(void)
 	 * Make sure delta_sibling is sorted in the original
 	 * recency order.
 	 */
-	for (i = nr_objects - 1; 0 <= i; i--) {
-		struct object_entry *e = &objects[i];
+	for (i = nr_objects; i > 0;) {
+		struct object_entry *e = &objects[--i];
 		if (!e->delta)
 			continue;
 		/* Mark me as the first child */
-- 
1.7.7
