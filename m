From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 10/25] revision: use object_array_filter() in implementation of gc_boundary()
Date: Sat, 25 May 2013 11:08:09 +0200
Message-ID: <1369472904-12875-11-git-send-email-mhagger@alum.mit.edu>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johan Herland <johan@herland.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 25 11:09:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgATU-00052T-DE
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 11:09:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764Ab3EYJJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 05:09:12 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:50785 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752678Ab3EYJJJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 05:09:09 -0400
X-AuditID: 12074414-b7fb86d000000905-c0-51a07fb595ea
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id AA.D4.02309.5BF70A15; Sat, 25 May 2013 05:09:09 -0400 (EDT)
Received: from michael.fritz.box (p4FDD49F3.dip0.t-ipconnect.de [79.221.73.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4P98guk000489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 May 2013 05:09:07 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqLu1fkGgweGdfBZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLe5eXsXuwObx9/0HJo9LL7+zedx+PZ/Z41nvHkaPi5eUPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgzvh4sYex4ARvRd+smgbGR1xdjJwcEgImEjverGCBsMUkLtxbz9bF
	yMUhJHCZUWLrtCuMEM4FJolfi5+wgVSxCehKLOppZgKxRQQcJU48uM4KUsQs0Mso8fDRd7CE
	sECCxLmOXrCxLAKqEpM6T4E18wq4Sly4fZMRYp2CxOVZa5i7GDk4OIHib09wgoSFBFwknn86
	xzqBkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0LvdzMEr3UlNJNjJAwE9nBeOSk3CFG
	AQ5GJR5egfL5gUKsiWXFlbmHGCU5mJREeflrFwQK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuFl
	SAHK8aYkVlalFuXDpKQ5WJTEeb8tVvcTEkhPLEnNTk0tSC2CycpwcChJ8O6tA2oULEpNT61I
	y8wpQUgzcXCCCC6QDTxAG86CFPIWFyTmFmemQxSdYlSUEue9CZIQAElklObBDYAlhFeM4kD/
	CPPeBaniASYTuO5XQIOZgAbfzJ0PMrgkESEl1cDoJex2LZcjavMuJtnuO/tunfq9TftnIf/s
	6u8cVZMTtOuiXzwyud1sundLLZNrHfPRDcKJDKslvZM0LrO6pFzh3b3H1nvbq7c+q7dVm+z2
	ebrE6f3KCZ+v9T0xOt9WM8m/Kv/SMqcsry+Jfe9O10ty7v7YJPPwDcsz8WNbOIMX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225497>

Use object_array_filter(), which will soon be made smarter about
cleaning up discarded entries properly.  Also add a function comment.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

This version changes the test to "nr == alloc" for clarity, but
doesn't move the test to the caller as did v1 of the patch series.

 revision.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/revision.c b/revision.c
index 8ac88d6..be73cb4 100644
--- a/revision.c
+++ b/revision.c
@@ -2435,25 +2435,23 @@ static struct commit *get_revision_1(struct rev_info *revs)
 	return NULL;
 }
 
-static void gc_boundary(struct object_array *array)
+/*
+ * Return true for entries that have not yet been shown.  (This is an
+ * object_array_each_func_t.)
+ */
+static int entry_unshown(struct object_array_entry *entry, void *cb_data_unused)
 {
-	unsigned nr = array->nr;
-	unsigned alloc = array->alloc;
-	struct object_array_entry *objects = array->objects;
+	return !(entry->item->flags & SHOWN);
+}
 
-	if (alloc <= nr) {
-		unsigned i, j;
-		for (i = j = 0; i < nr; i++) {
-			if (objects[i].item->flags & SHOWN)
-				continue;
-			if (i != j)
-				objects[j] = objects[i];
-			j++;
-		}
-		for (i = j; i < nr; i++)
-			objects[i].item = NULL;
-		array->nr = j;
-	}
+/*
+ * If array is on the verge of a realloc, garbage-collect any entries
+ * that have already been shown to try to free up some space.
+ */
+static void gc_boundary(struct object_array *array)
+{
+	if (array->nr == array->alloc)
+		object_array_filter(array, entry_unshown, NULL);
 }
 
 static void create_boundary_commit_list(struct rev_info *revs)
-- 
1.8.2.3
