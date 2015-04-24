From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/5] write_ref_sha1(): inline function at callers
Date: Fri, 24 Apr 2015 13:35:47 +0200
Message-ID: <1429875349-29736-4-git-send-email-mhagger@alum.mit.edu>
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
	id 1Ylbu1-0004FB-HG
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 13:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966151AbbDXLgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 07:36:10 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:51372 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932685AbbDXLgE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2015 07:36:04 -0400
X-AuditID: 1207440f-f792a6d000001284-2b-553a2aa1c64c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 34.97.04740.1AA2A355; Fri, 24 Apr 2015 07:36:02 -0400 (EDT)
Received: from michael.fritz.box (p4FC973EF.dip0.t-ipconnect.de [79.201.115.239])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3OBZt8Z008846
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 24 Apr 2015 07:36:01 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1429875349-29736-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsUixO6iqLtIyyrU4HaQRdeVbiaLht4rzBa3
	V8xntvjR0sNssXlzO4sDq8ff9x+YPBZsKvV41ruH0ePiJWWPz5vkAlijuG2SEkvKgjPT8/Tt
	ErgzuvosCs6LV8z53sfUwHhSqIuRk0NCwESiY143M4QtJnHh3nq2LkYuDiGBy4wSXS93sUM4
	J5kkGs+sYwepYhPQlVjU08zUxcjBISLgJdE2sxgkzCyQItHxvJsRxBYWcJQ42/UWbCiLgKrE
	jl1vwFp5BVwkJkzexwaxTE7i/PGfYDWcAq4S/cs/soDYQkA1azZ9YJ/AyLuAkWEVo1xiTmmu
	bm5iZk5xarJucXJiXl5qka6JXm5miV5qSukmRkgw8e9g7Fovc4hRgINRiYd3xhzLUCHWxLLi
	ytxDjJIcTEqivJ1SVqFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHgThYByvCmJlVWpRfkwKWkO
	FiVxXvUl6n5CAumJJanZqakFqUUwWRkODiUJXm5NoEbBotT01Iq0zJwShDQTByfIcC4pkeLU
	vJTUosTSkox4UFzEFwMjAyTFA7SXAaSdt7ggMRcoCtF6ilFRSpz3twZQQgAkkVGaBzcWliJe
	MYoDfSnMmwbSzgNML3Ddr4AGMwENnrnUAmRwSSJCSqqBUbiTkSN52vx8wfZ7R5zCpF8b1B35
	X+vG/y74251Y20+ye1+xaIjY7no4d+r2eSVv5J7vWxPJvndxau7uWaqsjplTuT04gjMOeP0S
	TpqbXuk059DK/guzXxYLb52YuWqBRvtcT6HkCn3WCbnihyx3KnuJ+jJdXH444OiS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267730>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/refs.c b/refs.c
index 9b68aec..a55d541 100644
--- a/refs.c
+++ b/refs.c
@@ -2770,8 +2770,10 @@ static int rename_ref_available(const char *oldname, const char *newname)
 	return ret;
 }
 
-static int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1,
-			  const char *logmsg);
+static int write_ref_to_lockfile(struct ref_lock *lock,
+				 const unsigned char *sha1);
+static int commit_ref_update(struct ref_lock *lock,
+			     const unsigned char *sha1, const char *logmsg);
 
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
@@ -2829,7 +2831,8 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		goto rollback;
 	}
 	hashcpy(lock->old_sha1, orig_sha1);
-	if (write_ref_sha1(lock, orig_sha1, logmsg)) {
+	if (write_ref_to_lockfile(lock, orig_sha1) ||
+	    commit_ref_update(lock, orig_sha1, logmsg)) {
 		error("unable to write current sha1 into %s", newrefname);
 		goto rollback;
 	}
@@ -2845,7 +2848,8 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 
 	flag = log_all_ref_updates;
 	log_all_ref_updates = 0;
-	if (write_ref_sha1(lock, orig_sha1, NULL))
+	if (write_ref_to_lockfile(lock, orig_sha1) ||
+	    commit_ref_update(lock, orig_sha1, NULL))
 		error("unable to write current sha1 into %s", oldrefname);
 	log_all_ref_updates = flag;
 
@@ -3093,21 +3097,6 @@ static int commit_ref_update(struct ref_lock *lock,
 	return 0;
 }
 
-/*
- * Write sha1 as the new value of the reference specified by the
- * (open) lock. On error, roll back the lockfile and set errno
- * appropriately.
- */
-static int write_ref_sha1(struct ref_lock *lock,
-	const unsigned char *sha1, const char *logmsg)
-{
-	if (write_ref_to_lockfile(lock, sha1) ||
-	    commit_ref_update(lock, sha1, logmsg))
-		return -1;
-
-	return 0;
-}
-
 int create_symref(const char *ref_target, const char *refs_heads_master,
 		  const char *logmsg)
 {
@@ -3801,15 +3790,18 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 				 */
 				unlock_ref(update->lock);
 				update->lock = NULL;
-			} else if (write_ref_sha1(update->lock, update->new_sha1,
-						  update->msg)) {
-				update->lock = NULL; /* freed by write_ref_sha1 */
+			} else if (write_ref_to_lockfile(update->lock,
+							 update->new_sha1) ||
+				   commit_ref_update(update->lock,
+						     update->new_sha1,
+						     update->msg)) {
+				update->lock = NULL; /* freed by the above calls */
 				strbuf_addf(err, "Cannot update the ref '%s'.",
 					    update->refname);
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
 			} else {
-				/* freed by write_ref_sha1(): */
+				/* freed by the above calls: */
 				update->lock = NULL;
 			}
 		}
-- 
2.1.4
