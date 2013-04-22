From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 14/33] refs: extract a function peel_entry()
Date: Mon, 22 Apr 2013 21:52:22 +0200
Message-ID: <1366660361-21831-15-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 21:54:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMoS-0005Bt-3w
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 21:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755132Ab3DVTxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 15:53:51 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:53461 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755116Ab3DVTxs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 15:53:48 -0400
X-AuditID: 1207440f-b7f0e6d000000957-a4-5175954b0e80
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id F9.0D.02391.B4595715; Mon, 22 Apr 2013 15:53:48 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOR008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:53:46 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsUixO6iqOsztTTQ4GwXk0XXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGf83HWJteCNREXbjNssDYzH
	hbsYOTkkBEwkTr+YxQphi0lcuLeerYuRi0NI4DKjxP1Hp1khnAtMEp1NHxhBqtgEdCUW9TQz
	gdgiAmoSE9sOsYDYzAIOEps/N4LVCAvYS8y+2MAMYrMIqErs6eoCq+EVcJWY2nGTCWKbgsTx
	7dvA6jmB4qc7ToDVCAm4SKw4OJVlAiPvAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Jnq5
	mSV6qSmlmxghwcK/g7FrvcwhRgEORiUe3gzP0kAh1sSy4srcQ4ySHExKorwcU4BCfEn5KZUZ
	icUZ8UWlOanFhxglOJiVRHhF84FyvCmJlVWpRfkwKWkOFiVxXvUl6n5CAumJJanZqakFqUUw
	WRkODiUJ3gyQoYJFqempFWmZOSUIaSYOThDBBbKBB2hDJEghb3FBYm5xZjpE0SlGRSlxXrdJ
	QAkBkERGaR7cAFhcv2IUB/pHmNcDpJ0HmBLgul8BDWYCGpyZUAIyuCQRISXVwLhj06nrIbOL
	/ctC/Y6zfLc3Llfav52l9PSRwm2+aZltb7ItvLTUz6pMCl0/xWziWT/+yWw+KiyHjjiIsP2v
	2dPJP01uyYdtEZf0DY8d/lLpXNXF6cWnLlQq/Vb39oZPbfrzijbrn5TsL8pc7PYw/RIPe5HQ
	QsnfYaEh+pxCZp8eLa0Mm+2lpMRSnJFoqMVcVJwIAB3Q0n7GAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222060>

Peel the entry, and as a side effect store the peeled value in the
entry.  Use this function from two places in peel_ref(); a third
caller will be added soon.

Please note that this change can lead to ref_entries for unpacked refs
being peeled.  This has no practical benefit but is harmless.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index 2f73189..777a4b7 100644
--- a/refs.c
+++ b/refs.c
@@ -1285,7 +1285,17 @@ enum peel_status {
 	PEEL_INVALID = -1,
 
 	/* object cannot be peeled because it is not a tag: */
-	PEEL_NON_TAG = -2
+	PEEL_NON_TAG = -2,
+
+	/* ref_entry contains no peeled value because it is a symref: */
+	PEEL_IS_SYMREF = -3,
+
+	/*
+	 * ref_entry cannot be peeled because it is broken (i.e., the
+	 * symbolic reference cannot even be resolved to an object
+	 * name):
+	 */
+	PEEL_BROKEN = -4
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
