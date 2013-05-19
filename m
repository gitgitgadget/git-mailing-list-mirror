From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 12/17] object_array_remove_duplicates(): rewrite to reduce copying
Date: Sun, 19 May 2013 22:27:07 +0200
Message-ID: <1368995232-11042-13-git-send-email-mhagger@alum.mit.edu>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 19 22:28:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeADp-0004mK-Mr
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 22:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852Ab3ESU2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 16:28:37 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:43733 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754714Ab3ESU2P (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 16:28:15 -0400
X-AuditID: 12074411-b7f286d0000008e8-e9-519935de14fd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id CC.D1.02280.ED539915; Sun, 19 May 2013 16:28:14 -0400 (EDT)
Received: from michael.fritz.box (p57A25040.dip0.t-ipconnect.de [87.162.80.64])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4JKRX5V026019
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 19 May 2013 16:28:13 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqHvPdGagwYU70hZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYHVg9/r7/wORx6eV3No9nvXsYPS5eUvb4vEkugDWK2yYpsaQsODM9
	T98ugTvj8IIvTAXvRCru7P7H3sB4XKCLkZNDQsBEYv7DVewQtpjEhXvr2boYuTiEBC4zSlze
	c5UVJCEkcJ5J4u6XWhCbTUBXYlFPMxOILSIgK/H98EZGEJtZYAKjxNL+QhBbWCBIYtLfJjYQ
	m0VAVeLH1zUsIDavgKvE9r4dbBDLFCQuz1rDDGJzAsW3tO+C2uUi8a//NusERt4FjAyrGOUS
	c0pzdXMTM3OKU5N1i5MT8/JSi3RN9XIzS/RSU0o3MUJCSnAH44yTcocYBTgYlXh4Gz5MDxRi
	TSwrrsw9xCjJwaQkyvvOZGagEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHePUJAOd6UxMqq1KJ8
	mJQ0B4uSOC/fEnU/IYH0xJLU7NTUgtQimKwMB4eSBK87yFDBotT01Iq0zJwShDQTByeI4ALZ
	wAO0YRFIIW9xQWJucWY6RNEpRkUpcd6LIAkBkERGaR7cAFj0v2IUB/pHmPcISBUPMHHAdb8C
	GswENJj12lSQwSWJCCmpBkZ9m1OKnw/cKQxWLGLb8tJhobXbkyMdc77wJmRVC83yYpb79Ndn
	3m+9s2p/JC0XCfudenPW5i8ni++S9W2TK1/K9QQucVV3eex+8XH9FKnrcx41b2KUy7I+lzh/
	anls5Aaz+bOc4o8uOjF1y44XdTsV/rHf3lIRp6wTwJgRuUlujdCuzMnGX3iUWIoz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224920>

The old version copied one entry to its destination position, then
deleted any matching entries from the tail of the array.  This
required the tail of the array to be copied multiple times.  It didn't
affect the complexity of the algorithm because the whole tail has to
be searched through anyway.  But all the copying was unnecessary.

Instead, check for the existence of an entry with the same name in the
*head* of the list before copying an entry to its final position.
This way each entry has to be copied at most one time.

Extract a helper function contains_name() to do a bit of the work.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 object.c | 32 +++++++++++++++++++++-----------
 object.h |  6 +++++-
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/object.c b/object.c
index fcd4a82..10b5349 100644
--- a/object.c
+++ b/object.c
@@ -294,22 +294,32 @@ void object_array_filter(struct object_array *array,
 	array->nr = dst;
 }
 
+/*
+ * Return true iff array already contains an entry with name.
+ */
+static int contains_name(struct object_array *array, const char *name)
+{
+	unsigned nr = array->nr, i;
+	struct object_array_entry *object = array->objects;
+
+	for (i = 0; i < nr; i++, object++)
+		if (!strcmp(object->name, name))
+			return 1;
+	return 0;
+}
+
 void object_array_remove_duplicates(struct object_array *array)
 {
-	unsigned int ref, src, dst;
+	unsigned nr = array->nr, src;
 	struct object_array_entry *objects = array->objects;
 
-	for (ref = 0; ref + 1 < array->nr; ref++) {
-		for (src = ref + 1, dst = src;
-		     src < array->nr;
-		     src++) {
-			if (!strcmp(objects[ref].name, objects[src].name))
-				continue;
-			if (src != dst)
-				objects[dst] = objects[src];
-			dst++;
+	array->nr = 0;
+	for (src = 0; src < nr; src++) {
+		if (!contains_name(array, objects[src].name)) {
+			if (src != array->nr)
+				objects[array->nr] = objects[src];
+			array->nr++;
 		}
-		array->nr = dst;
 	}
 }
 
diff --git a/object.h b/object.h
index 0d39ff4..6c1c27f 100644
--- a/object.h
+++ b/object.h
@@ -96,7 +96,11 @@ typedef int (*object_array_each_func_t)(struct object_array_entry *, void *);
 void object_array_filter(struct object_array *array,
 			 object_array_each_func_t want, void *cb_data);
 
-void object_array_remove_duplicates(struct object_array *);
+/*
+ * Remove from array all but the first entry with a given name.
+ * Warning: this function uses an O(N^2) algorithm.
+ */
+void object_array_remove_duplicates(struct object_array *array);
 
 void clear_object_flags(unsigned flags);
 
-- 
1.8.2.3
