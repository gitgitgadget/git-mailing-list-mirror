From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 12/33] peel_object(): give more specific information in return value
Date: Mon, 22 Apr 2013 21:52:20 +0200
Message-ID: <1366660361-21831-13-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 21:53:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMoB-0004ng-Fk
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 21:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755138Ab3DVTxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 15:53:47 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:53461 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755120Ab3DVTxq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 15:53:46 -0400
X-AuditID: 1207440f-b7f0e6d000000957-9e-51759549f05a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 59.0D.02391.94595715; Mon, 22 Apr 2013 15:53:45 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOP008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:53:43 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsUixO6iqOs5tTTQ4M0ldouuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M5onBJfcEmg4k/bftYGxu88
	XYycHBICJhLXjlxkgbDFJC7cW8/WxcjFISRwmVFi1abV7BDOBSagqo+sIFVsAroSi3qamUBs
	EQE1iYlth8C6mQUcJDZ/bmQEsYUFwiW+d54Cs1kEVCXWLZ8IVM/BwSvgKnG5PxdimYLE8e3b
	wEo4gcKnO06AjREScJFYcXAqywRG3gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdE30cjNL
	9FJTSjcxQgKFfwdj13qZQ4wCHIxKPLwZnqWBQqyJZcWVuYcYJTmYlER5OaYAhfiS8lMqMxKL
	M+KLSnNSiw8xSnAwK4nwiuYD5XhTEiurUovyYVLSHCxK4rzqS9T9hATSE0tSs1NTC1KLYLIy
	HBxKErwZIEMFi1LTUyvSMnNKENJMHJwgggtkAw/QhkiQQt7igsTc4sx0iKJTjIpS4rxuk4AS
	AiCJjNI8uAGwmH7FKA70jzCvB0g7DzAdwHW/AhrMBDQ4M6EEZHBJIkJKqoGxvsbW91DZ2a69
	DLdef3CUmZw461brR/UZrn53b2zZP1VFY4WLRRML/w6LtW+mHH4TEbQuZl2zsLkr++eYmV8W
	cF6e2/Cw8ZTJopnzJ0z+vGVW2Oz2yozKXROSC4rfxQg6ibyJP/DOxO3ymrCPXstZT2/o3hK6
	IzLzs5yeyy0Jn8BDE6TydATeKLEUZyQaajEXFScCAHjWZrjEAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222057>

Instead of just returning a success/failure bit, return an enumeration
value that explains the reason for any failure.  This will come in
handy shortly.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index b0ef129..d26e847 100644
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
+	PEEL_NON_TAG = -2
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
