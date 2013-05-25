From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 09/25] object_array: add function object_array_filter()
Date: Sat, 25 May 2013 11:08:08 +0200
Message-ID: <1369472904-12875-10-git-send-email-mhagger@alum.mit.edu>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johan Herland <johan@herland.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 25 11:10:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgAV7-00066M-EP
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 11:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755545Ab3EYJKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 05:10:53 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:50785 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753306Ab3EYJJI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 05:09:08 -0400
X-AuditID: 12074414-b7fb86d000000905-bc-51a07fb3ad82
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 3A.D4.02309.3BF70A15; Sat, 25 May 2013 05:09:07 -0400 (EDT)
Received: from michael.fritz.box (p4FDD49F3.dip0.t-ipconnect.de [79.221.73.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4P98guj000489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 May 2013 05:09:06 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqLu5fkGgQdtuGYuuK91MFg29V5gt
	5t3dxWRxe8V8ZosfLT3MFncvr2J3YPP4+/4Dk8ell9/ZPG6/ns/s8ax3D6PHxUvKHp83yQWw
	RXHbJCWWlAVnpufp2yVwZyw5sIS14BR/xbSfl9kbGB/xdDFyckgImEg82zWHCcIWk7hwbz1b
	FyMXh5DAZUaJFY+uMoMkhAQuMElc2uAIYrMJ6Eos6mkGaxARcJQ48eA6K0gDs0Avo8TDR9/B
	EsICXhLvF3eygNgsAqoSM86tZASxeQVcJeZ+7mGE2KYgcXnWGqAFHBycQPG3JzghdrlIPP90
	jnUCI+8CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRboWermZJXqpKaWbGCFhJrKD8chJuUOM
	AhyMSjy8AuXzA4VYE8uKK3MPMUpyMCmJ8vLXLggU4kvKT6nMSCzOiC8qzUktPsQowcGsJMLL
	kAKU401JrKxKLcqHSUlzsCiJ835brO4nJJCeWJKanZpakFoEk5Xh4FCS4N1bB9QoWJSanlqR
	lplTgpBm4uAEEVwgG3iANpwFKeQtLkjMLc5Mhyg6xagoJc57EyQhAJLIKM2DGwBLCK8YxYH+
	Eea9C1LFA0wmcN2vgAYzAQ2+mTsfZHBJIkJKqoExgO01j5rZuV7FR1+SZod6TuBKOaUgnzF9
	2ZzgRQWqW7Uqf/3S+3f83Mmtm3muyjxvne2cFBfp0F2lJ3Njg1xDVefEvLA7DU5iyVfvLKiz
	tczYHM48n/3ErJQUj3WFK/NSn52pYgv2fO4+wz5KIleY58qRyu9P9xTtsLGb/89K 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225513>

Add a function that allows unwanted entries in an object_array to be
removed.  This encapsulation is a step towards giving object_array
ownership of its entries' name memory.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 object.c | 16 ++++++++++++++++
 object.h | 11 +++++++++++
 2 files changed, 27 insertions(+)

diff --git a/object.c b/object.c
index 20703f5..fcd4a82 100644
--- a/object.c
+++ b/object.c
@@ -278,6 +278,22 @@ void add_object_array_with_mode(struct object *obj, const char *name, struct obj
 	array->nr = ++nr;
 }
 
+void object_array_filter(struct object_array *array,
+			 object_array_each_func_t want, void *cb_data)
+{
+	unsigned nr = array->nr, src, dst;
+	struct object_array_entry *objects = array->objects;
+
+	for (src = dst = 0; src < nr; src++) {
+		if (want(&objects[src], cb_data)) {
+			if (src != dst)
+				objects[dst] = objects[src];
+			dst++;
+		}
+	}
+	array->nr = dst;
+}
+
 void object_array_remove_duplicates(struct object_array *array)
 {
 	unsigned int ref, src, dst;
diff --git a/object.h b/object.h
index 97d384b..0d39ff4 100644
--- a/object.h
+++ b/object.h
@@ -85,6 +85,17 @@ int object_list_contains(struct object_list *list, struct object *obj);
 /* Object array handling .. */
 void add_object_array(struct object *obj, const char *name, struct object_array *array);
 void add_object_array_with_mode(struct object *obj, const char *name, struct object_array *array, unsigned mode);
+
+typedef int (*object_array_each_func_t)(struct object_array_entry *, void *);
+
+/*
+ * Apply want to each entry in array, retaining only the entries for
+ * which the function returns true.  Preserve the order of the entries
+ * that are retained.
+ */
+void object_array_filter(struct object_array *array,
+			 object_array_each_func_t want, void *cb_data);
+
 void object_array_remove_duplicates(struct object_array *);
 
 void clear_object_flags(unsigned flags);
-- 
1.8.2.3
