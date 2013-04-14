From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 12/33] peel_object(): give more specific information in return value
Date: Sun, 14 Apr 2013 14:54:27 +0200
Message-ID: <1365944088-10588-13-git-send-email-mhagger@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 14:55:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMT5-00046X-Bn
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 14:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939Ab3DNMzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 08:55:37 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:53347 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751870Ab3DNMzf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 08:55:35 -0400
X-AuditID: 12074413-b7f226d000000902-db-516aa74622a4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 5E.D6.02306.647AA615; Sun, 14 Apr 2013 08:55:34 -0400 (EDT)
Received: from michael.fritz.box (p57A24996.dip.t-dialin.net [87.162.73.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3ECtAk9007029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Apr 2013 08:55:33 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsUixO6iqOu2PCvQ4OxeA4uuK91MFg29V5gt
	Vj6+y2xxe8V8ZosfLT3MDqwef99/YPJof/+O2eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M5o7f3HWnBZoOLy2+NMDYw/eLoYOTgkBEwkPnQJdDFyApliEhfurWcDsYUELjNKnGg3
	62LkArLPMkmsO3udFSTBJqArsainmQmkV0QgW2L3WnmQMLOAg8Tmz42MIGFhgRCJkw9NQcIs
	AqoSby9fBAvzCrhK7D3gCbFJQeL49m2MIDYnUHj682PsEFtdJGZtns06gZF3ASPDKka5xJzS
	XN3cxMyc4tRk3eLkxLy81CJdc73czBK91JTSTYyQUBLewbjrpNwhRgEORiUe3heMWYFCrIll
	xZW5hxglOZiURHkVlwGF+JLyUyozEosz4otKc1KLDzFKcDArifA6tgLleFMSK6tSi/JhUtIc
	LErivGpL1P2EBNITS1KzU1MLUotgsjIcHEoSvK+XAjUKFqWmp1akZeaUIKSZODhBBBfIBh6g
	DW9BCnmLCxJzizPTIYpOMSpKifN+BEkIgCQySvPgBsCi/hWjONA/wrxPQap4gAkDrvsV0GAm
	oME+e9NBBpckIqSkGhjr/xjVxkgvdi+/8DeSYZtlPafBr9ldV4QLFaMer87rXdK18seWpomS
	c3NV5K7EifW2zA9Z3KhdwlgiurOZ4f7k5Rds0hhTpMriF6ksWMd+69yxr1Ef0rcxC2lVa5ic
	tV1wev/F8MuzPn84sNj68Nf5T1fX6mnsllwz31fGQ3vF1P2LXF+myQUrsRRnJBpq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221103>

Instead of just returning a success/failure bit, return an enumeration
value that explains the reason for any failure.  This will come in
handy shortly.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index a1fe6b0..84c2497 100644
--- a/refs.c
+++ b/refs.c
@@ -1272,32 +1272,48 @@ static int filter_refs(const char *refname, const unsigned char *sha1, int flags
 	return filter->fn(refname, sha1, flags, filter->cb_data);
 }
 
+enum peel_status {
+	/* object was peeled successfully: */
+	PEEL_PEELED = 0,
+
+	/*
+	 * object cannot be peeled because the named object (or an
+	 * object referred to by a tag in the peel chain), does not
+	 * exist.
+	 */
+	PEEL_INVALID = -1,
+
+	/* object cannot be peeled because it is not a tag: */
+	PEEL_NON_TAG = -2,
+};
+
 /*
  * Peel the named object; i.e., if the object is a tag, resolve the
- * tag recursively until a non-tag is found.  Store the result to sha1
- * and return 0 iff successful.  If the object is not a tag or is not
- * valid, return -1 and leave sha1 unchanged.
+ * tag recursively until a non-tag is found.  If successful, store the
+ * result to sha1 and return PEEL_PEELED.  If the object is not a tag
+ * or is not valid, return PEEL_NON_TAG or PEEL_INVALID, respectively,
+ * and leave sha1 unchanged.
  */
-static int peel_object(const unsigned char *name, unsigned char *sha1)
+static enum peel_status peel_object(const unsigned char *name, unsigned char *sha1)
 {
 	struct object *o = lookup_unknown_object(name);
 
 	if (o->type == OBJ_NONE) {
 		int type = sha1_object_info(name, NULL);
 		if (type < 0)
-			return -1;
+			return PEEL_INVALID;
 		o->type = type;
 	}
 
 	if (o->type != OBJ_TAG)
-		return -1;
+		return PEEL_NON_TAG;
 
 	o = deref_tag_noverify(o);
 	if (!o)
-		return -1;
+		return PEEL_INVALID;
 
 	hashcpy(sha1, o->sha1);
-	return 0;
+	return PEEL_PEELED;
 }
 
 int peel_ref(const char *refname, unsigned char *sha1)
-- 
1.8.2.1
