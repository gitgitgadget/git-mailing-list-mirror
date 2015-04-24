From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 4/5] ref_transaction_commit(): remove the local flags variables
Date: Fri, 24 Apr 2015 13:35:48 +0200
Message-ID: <1429875349-29736-5-git-send-email-mhagger@alum.mit.edu>
References: <1429875349-29736-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 13:36:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ylbu0-0004FB-UF
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 13:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933973AbbDXLgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 07:36:09 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:61833 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933551AbbDXLgG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2015 07:36:06 -0400
X-AuditID: 1207440d-f79976d000005643-6d-553a2aa3ad7b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 80.4F.22083.3AA2A355; Fri, 24 Apr 2015 07:36:03 -0400 (EDT)
Received: from michael.fritz.box (p4FC973EF.dip0.t-ipconnect.de [79.201.115.239])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3OBZt8a008846
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 24 Apr 2015 07:36:02 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1429875349-29736-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsUixO6iqLtYyyrU4NNVHouuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ3xepFkwQ7ii+clt9gbGGfxdjJwcEgImEm3rm1khbDGJC/fWs3UxcnEICVxmlJi0exMz
	hHOSSeLi4pOMIFVsAroSi3qamboYOThEBLwk2mYWg4SZBVIkOp53g5UIC/hLPNnUywRiswio
	Spw8docFxOYVcJFo+7iHHWKZnMT54z+ZQWxOAVeJ/uUfwWqEgGrWbPrAPoGRdwEjwypGucSc
	0lzd3MTMnOLUZN3i5MS8vNQiXSO93MwSvdSU0k2MkHDi3cH4f53MIUYBDkYlHt4ZcyxDhVgT
	y4orcw8xSnIwKYnydkpZhQrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4U0UAsrxpiRWVqUW5cOk
	pDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR4GzSBGgWLUtNTK9Iyc0oQ0kwcnCDDuaRE
	ilPzUlKLEktLMuJBcRFfDIwMkBQP0N46kHbe4oLEXKAoROspRkUpcd4tIAkBkERGaR7cWFiS
	eMUoDvSlMG8aSBUPMMHAdb8CGswENHjmUguQwSWJCCmpBkbpUDbHk48yFq1yWuBi9nKH4hlZ
	j/wKZsNW7pINentPi7tmvZDctTD5UqLhoUnHPrHJ6cZcZVfY6c8o+K/T9qOhLMMLU9bfa5ax
	Ji2etoY/us5EvPDLLJ+d++aK87laBP0UfGqp4fggebm+Xklo5xklTYO4X4q9/5b7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267733>

Instead, work directly with update->flags. This has the advantage that
the REF_DELETING bit, set in the first loop, can be read in the third
loop instead of having to compute the same expression again. Plus, it
was kindof confusing having both update->flags and flags, which
sometimes had different values.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index a55d541..782e777 100644
--- a/refs.c
+++ b/refs.c
@@ -3752,16 +3752,15 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	/* Acquire all locks while verifying old values */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
-		unsigned int flags = update->flags;
 
-		if ((flags & REF_HAVE_NEW) && is_null_sha1(update->new_sha1))
-			flags |= REF_DELETING;
+		if ((update->flags & REF_HAVE_NEW) && is_null_sha1(update->new_sha1))
+			update->flags |= REF_DELETING;
 		update->lock = lock_ref_sha1_basic(
 				update->refname,
 				((update->flags & REF_HAVE_OLD) ?
 				 update->old_sha1 : NULL),
 				NULL,
-				flags,
+				update->flags,
 				&update->type);
 		if (!update->lock) {
 			ret = (errno == ENOTDIR)
@@ -3776,9 +3775,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	/* Perform updates first so live commits remain referenced */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
-		int flags = update->flags;
 
-		if ((flags & REF_HAVE_NEW) && !is_null_sha1(update->new_sha1)) {
+		if ((update->flags & REF_HAVE_NEW) && !is_null_sha1(update->new_sha1)) {
 			int overwriting_symref = ((update->type & REF_ISSYMREF) &&
 						  (update->flags & REF_NODEREF));
 
@@ -3810,15 +3808,14 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	/* Perform deletes now that updates are safely completed */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
-		int flags = update->flags;
 
-		if ((flags & REF_HAVE_NEW) && is_null_sha1(update->new_sha1)) {
+		if (update->flags & REF_DELETING) {
 			if (delete_ref_loose(update->lock, update->type, err)) {
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
 			}
 
-			if (!(flags & REF_ISPRUNING))
+			if (!(update->flags & REF_ISPRUNING))
 				string_list_append(&refs_to_delete,
 						   update->lock->ref_name);
 		}
-- 
2.1.4
