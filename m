From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 7/8] ref_transaction_commit(): remove the local flags variable
Date: Sun, 10 May 2015 04:45:36 +0200
Message-ID: <1431225937-10456-8-git-send-email-mhagger@alum.mit.edu>
References: <1431225937-10456-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun May 10 04:46:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrHGE-0001h0-J6
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 04:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137AbbEJCqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2015 22:46:16 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:63666 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752043AbbEJCqN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 May 2015 22:46:13 -0400
X-AuditID: 1207440f-f792a6d000001284-e1-554ec66795f5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 7E.3D.04740.766CE455; Sat,  9 May 2015 22:45:59 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3166.dip0.t-ipconnect.de [93.219.49.102])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4A2jkxf015925
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 9 May 2015 22:45:58 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431225937-10456-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqJt+zC/UYNoDHYuuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWizNvGhkd2Dz+vv/A5LFgU6nHs949jB4XLyl7LH7g5fF5k1wAWxS3
	TVJiSVlwZnqevl0Cd8a2x0sZCybxVPzY3srewLies4uRk0NCwETi45zDrBC2mMSFe+vZuhi5
	OIQELjNKdLS3MEM4x5kk7q06zQJSxSagK7Gop5mpi5GDQ0TAS6JtZjFIDbNAL6PEo8WvGEFq
	hAUCJdZ/mgQ2lUVAVaJlz3ZWkHpeAReJG2s8IJbJSZw//pMZxOYUcJW4fWYumC0EVNK4tIll
	AiPvAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Jnq5mSV6qSmlmxghIca/g7FrvcwhRgEO
	RiUe3hlb/EKFWBPLiitzDzFKcjApifLaLAQK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuE9uR4o
	x5uSWFmVWpQPk5LmYFES51Vfou4nJJCeWJKanZpakFoEk5Xh4FCS4L1wBKhRsCg1PbUiLTOn
	BCHNxMEJMpxLSqQ4NS8ltSixtCQjHhQZ8cXA2ABJ8QDtrTwKsre4IDEXKArReopRUUqclw8k
	IQCSyCjNgxsLSxyvGMWBvhTmvQWynQeYdOC6XwENZgIa/LfYB2RwSSJCSqqBsfGqUNe87+JR
	108835Mdwl9sqmWzQ/rTmbU2p1aHPs3cJPty6RSbb9WHPsw3dFfZkbmTj3d9qZBBx+VLFeGW
	TvLLSyR6X57OOaK46W/lrAB3zdtL6i97X3wnlevHKFHhJVm4p/tfdKDsDq9z4nf4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268721>

Instead, work directly with update->flags. This has the advantage that
the REF_DELETING bit, set in the first loop, can be read in the second
loop instead of having to be recomputed. Plus, it was potentially
confusing having both update->flags and flags, which sometimes had
different values.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 76609bf..58b1182 100644
--- a/refs.c
+++ b/refs.c
@@ -3802,16 +3802,15 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	/* Acquire all locks while verifying old values */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
-		int flags = update->flags;
 
 		if (is_null_sha1(update->new_sha1))
-			flags |= REF_DELETING;
+			update->flags |= REF_DELETING;
 		update->lock = lock_ref_sha1_basic(update->refname,
 						   (update->have_old ?
 						    update->old_sha1 :
 						    NULL),
 						   NULL,
-						   flags,
+						   update->flags,
 						   &update->type);
 		if (!update->lock) {
 			ret = (errno == ENOTDIR)
@@ -3827,7 +3826,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
-		if (!is_null_sha1(update->new_sha1)) {
+		if (!(update->flags & REF_DELETING)) {
 			if (!update->lock->force_write &&
 			    !hashcmp(update->lock->old_sha1, update->new_sha1)) {
 				unlock_ref(update->lock);
-- 
2.1.4
