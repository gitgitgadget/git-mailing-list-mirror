From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 11/25] object_array_remove_duplicates(): rewrite to reduce copying
Date: Sat, 25 May 2013 11:08:10 +0200
Message-ID: <1369472904-12875-12-git-send-email-mhagger@alum.mit.edu>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johan Herland <johan@herland.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 25 11:09:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgATe-0005B0-SR
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 11:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754327Ab3EYJJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 05:09:18 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:64453 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752762Ab3EYJJL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 05:09:11 -0400
X-AuditID: 1207440c-b7ff06d0000008f7-1d-51a07fb6f452
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 27.4F.02295.6BF70A15; Sat, 25 May 2013 05:09:11 -0400 (EDT)
Received: from michael.fritz.box (p4FDD49F3.dip0.t-ipconnect.de [79.221.73.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4P98gul000489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 May 2013 05:09:09 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqLu9fkGgwaEXjBZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLe5eXsXuwObx9/0HJo9LL7+zedx+PZ/Z41nvHkaPi5eUPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgzji84AtTwTuRiju7/7E3MB4X6GLk5JAQMJFYcP8+M4QtJnHh3nq2
	LkYuDiGBy4wS7VN+skI4F5gkNl++yQ5SxSagK7Gop5kJxBYRcJQ48eA6WBGzQC+jxMNH38ES
	wgKhEpdXtzOC2CwCqhL/nnwCa+YVcJVY2LKCCWKdgsTlWWuAVnNwcALF357gBAkLCbhIPP90
	jnUCI+8CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbqGermZJXqpKaWbGCGBxrOD8ds6mUOM
	AhyMSjy8guXzA4VYE8uKK3MPMUpyMCmJ8vLXLggU4kvKT6nMSCzOiC8qzUktPsQowcGsJMLL
	kAKU401JrKxKLcqHSUlzsCiJ86ouUfcTEkhPLEnNTk0tSC2CycpwcChJ8DIBI0pIsCg1PbUi
	LTOnBCHNxMEJIrhANvAAbeACKeQtLkjMLc5Mhyg6xagoJc57sw4oIQCSyCjNgxsASwmvGMWB
	/hHmvQtSxQNMJ3Ddr4AGMwENvpk7H2RwSSJCSqqBMa58uf28WxbPHsT0x85IXRZlaaqRdPpC
	mpJUdK5s5h2Gaf/v6R19M7Vf88r0CLbnZn58/opFCx0W+TQwbc78/7/BwiI9duKtFLcP/FxS
	xdm7k/VsEjc0vO55bP64tODJtD7m0Plrzt50zzpw067nVoNBXMZ9tfzbUi2fs3L/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225500>

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
