From: mhagger@alum.mit.edu
Subject: [PATCH 08/15] is_refname_available(): reimplement using do_for_each_ref_in_array()
Date: Tue, 10 Apr 2012 07:30:20 +0200
Message-ID: <1334035827-20331-9-git-send-email-mhagger@alum.mit.edu>
References: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 07:31:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHTg1-0002SQ-68
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 07:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753713Ab2DJFbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 01:31:24 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:59227 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209Ab2DJFbB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 01:31:01 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p4FC0B8CA.dip.t-dialin.net [79.192.184.202])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3A5UXe1000870;
	Tue, 10 Apr 2012 07:30:53 +0200
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195069>

From: Michael Haggerty <mhagger@alum.mit.edu>

This implementation will survive upcoming changes to the ref_array
data structure.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   47 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index d4f58b8..4b94b08 100644
--- a/refs.c
+++ b/refs.c
@@ -348,26 +348,47 @@ static int names_conflict(const char *refname1, const char *refname2)
 		|| (*refname1 == '/' && *refname2 == '\0');
 }
 
+struct name_conflict_cb {
+	const char *refname;
+	const char *oldrefname;
+	const char *conflicting_refname;
+};
+
+static int name_conflict_fn(const char *existingrefname, const unsigned char *sha1,
+			    int flags, void *cb_data)
+{
+	struct name_conflict_cb *data = (struct name_conflict_cb *)cb_data;
+	if (data->oldrefname && !strcmp(data->oldrefname, existingrefname))
+		return 0;
+	if (names_conflict(data->refname, existingrefname)) {
+		data->conflicting_refname = existingrefname;
+		return 1;
+	}
+	return 0;
+}
+
 /*
  * Return true iff a reference named refname could be created without
- * conflicting with the name of an existing reference.  If oldrefname
- * is non-NULL, ignore potential conflicts with oldrefname (e.g.,
- * because oldrefname is scheduled for deletion in the same
+ * conflicting with the name of an existing reference in array.  If
+ * oldrefname is non-NULL, ignore potential conflicts with oldrefname
+ * (e.g., because oldrefname is scheduled for deletion in the same
  * operation).
  */
 static int is_refname_available(const char *refname, const char *oldrefname,
 				struct ref_array *array)
 {
-	int i;
-	for (i = 0; i < array->nr; i++ ) {
-		struct ref_entry *entry = array->refs[i];
-		if (oldrefname && !strcmp(oldrefname, entry->name))
-			continue;
-		if (names_conflict(refname, entry->name)) {
-			error("'%s' exists; cannot create '%s'",
-			      entry->name, refname);
-			return 0;
-		}
+	struct name_conflict_cb data;
+	data.refname = refname;
+	data.oldrefname = oldrefname;
+	data.conflicting_refname = NULL;
+
+	sort_ref_array(array);
+	if (do_for_each_ref_in_array(array, 0, "", name_conflict_fn,
+				     0, DO_FOR_EACH_INCLUDE_BROKEN,
+				     &data)) {
+		error("'%s' exists; cannot create '%s'",
+		      data.conflicting_refname, refname);
+		return 0;
 	}
 	return 1;
 }
-- 
1.7.10
