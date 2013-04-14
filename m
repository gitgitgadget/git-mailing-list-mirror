From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 14/33] refs: extract a function peel_entry()
Date: Sun, 14 Apr 2013 14:54:29 +0200
Message-ID: <1365944088-10588-15-git-send-email-mhagger@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 14:55:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMTA-0004F1-QO
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 14:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964Ab3DNMzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 08:55:39 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:54964 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751870Ab3DNMzi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 08:55:38 -0400
X-AuditID: 1207440f-b7f0e6d000000957-3a-516aa749cce0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id DB.7A.02391.947AA615; Sun, 14 Apr 2013 08:55:37 -0400 (EDT)
Received: from michael.fritz.box (p57A24996.dip.t-dialin.net [87.162.73.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3ECtAkB007029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Apr 2013 08:55:36 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqOu5PCvQYOF5M4uuK91MFg29V5gt
	Vj6+y2xxe8V8ZosfLT3MDqwef99/YPJof/+O2eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M74+OAic8EBiYpvv94xNTAuFe5i5OSQEDCRmDO5jRHCFpO4cG89G4gtJHCZUWJOH3MX
	IxeQfZZJYuWbZ0wgCTYBXYlFPc1ANgeHiEC2xO618iBhZgEHic2fG8HmCAvYSGzbsp8dxGYR
	UJU49eoB2ExeAVeJrXsvsEDsUpA4vn0bWD0nUHz682PsEHtdJGZtns06gZF3ASPDKka5xJzS
	XN3cxMyc4tRk3eLkxLy81CJdE73czBK91JTSTYyQgOLfwdi1XuYQowAHoxIPrwNLVqAQa2JZ
	cWXuIUZJDiYlUd6FS4FCfEn5KZUZicUZ8UWlOanFhxglOJiVRHgdW4FyvCmJlVWpRfkwKWkO
	FiVxXvUl6n5CAumJJanZqakFqUUwWRkODiUJ3tcgQwWLUtNTK9Iyc0oQ0kwcnCCCC2QDD9CG
	tyCFvMUFibnFmekQRacYFaXEeT+CJARAEhmleXADYLH/ilEc6B9h3qcgVTzAtAHX/QpoMBPQ
	YJ+96SCDSxIRUlINjByzJlUmlZ0P6dCS81Mt3OKemPZBPeTBq8/La+Oq+blv5FzSO2+W5/Zd
	/pvl2c9eEveKLf/GZIVtDYz9XsflyVRkHP7g588HZp+n7vjl09PzMS+u6MZTBXvOcxeO+T7f
	ctIxUiBZdeINkcvhEv3HtzveWMOkfEhma/SLk0/Ey8/ca395xrIvRYmlOCPRUIu5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221105>

Peel the entry, and as a side effect store the peeled value in the
entry.  Use this function from two places in peel_ref(); a third
caller will be added soon.

Please note that this change can lead to ref_entries for unpacked refs
being peeled.  This has no practical benefit but is harmless.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index a0d8e32..8cc6109 100644
--- a/refs.c
+++ b/refs.c
@@ -1286,6 +1286,16 @@ enum peel_status {
 
 	/* object cannot be peeled because it is not a tag: */
 	PEEL_NON_TAG = -2,
+
+	/* ref_entry contains no peeled value because it is a symref: */
+	PEEL_IS_SYMREF = -3,
+
+	/*
+	 * ref_entry cannot be peeled because it is broken (i.e., the
+	 * symbolic reference cannot even be resolved to an object
+	 * name):
+	 */
+	PEEL_BROKEN = -4,
 };
 
 /*
@@ -1317,31 +1327,56 @@ static enum peel_status peel_object(const unsigned char *name, unsigned char *sh
 	return PEEL_PEELED;
 }
 
+/*
+ * Peel the entry (if possible) and return its new peel_status.
+ */
+static enum peel_status peel_entry(struct ref_entry *entry)
+{
+	enum peel_status status;
+
+	if (entry->flag & REF_KNOWS_PEELED)
+		return is_null_sha1(entry->u.value.peeled) ?
+			PEEL_NON_TAG : PEEL_PEELED;
+	if (entry->flag & REF_ISBROKEN)
+		return PEEL_BROKEN;
+	if (entry->flag & REF_ISSYMREF)
+		return PEEL_IS_SYMREF;
+
+	status = peel_object(entry->u.value.sha1, entry->u.value.peeled);
+	if (status == PEEL_PEELED || status == PEEL_NON_TAG)
+		entry->flag |= REF_KNOWS_PEELED;
+	return status;
+}
+
 int peel_ref(const char *refname, unsigned char *sha1)
 {
 	int flag;
 	unsigned char base[20];
 
 	if (current_ref && (current_ref->name == refname
-		|| !strcmp(current_ref->name, refname))) {
-		if (current_ref->flag & REF_KNOWS_PEELED) {
-			if (is_null_sha1(current_ref->u.value.peeled))
-			    return -1;
-			hashcpy(sha1, current_ref->u.value.peeled);
-			return 0;
-		}
-		return peel_object(current_ref->u.value.sha1, sha1);
+			    || !strcmp(current_ref->name, refname))) {
+		if (peel_entry(current_ref))
+			return -1;
+		hashcpy(sha1, current_ref->u.value.peeled);
+		return 0;
 	}
 
 	if (read_ref_full(refname, base, 1, &flag))
 		return -1;
 
-	if ((flag & REF_ISPACKED)) {
+	/*
+	 * If the reference is packed, read its ref_entry from the
+	 * cache in the hope that we already know its peeled value.
+	 * We only try this optimization on packed references because
+	 * (a) forcing the filling of the loose reference cache could
+	 * be expensive and (b) loose references anyway usually do not
+	 * have REF_KNOWS_PEELED.
+	 */
+	if (flag & REF_ISPACKED) {
 		struct ref_entry *r = get_packed_ref(refname);
-
-		if (r && (r->flag & REF_KNOWS_PEELED)) {
-			if (is_null_sha1(r->u.value.peeled))
-			    return -1;
+		if (r) {
+			if (peel_entry(r))
+				return -1;
 			hashcpy(sha1, r->u.value.peeled);
 			return 0;
 		}
-- 
1.8.2.1
