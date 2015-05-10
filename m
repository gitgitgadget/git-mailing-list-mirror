From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 6/8] ref_transaction_commit(): inline call to write_ref_sha1()
Date: Sun, 10 May 2015 04:45:35 +0200
Message-ID: <1431225937-10456-7-git-send-email-mhagger@alum.mit.edu>
References: <1431225937-10456-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun May 10 04:46:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrHFv-0001a1-Kj
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 04:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbbEJCqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2015 22:46:03 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:63099 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752043AbbEJCp7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 May 2015 22:45:59 -0400
X-AuditID: 12074412-f79e46d0000036b4-a9-554ec666fb95
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id E5.D5.14004.666CE455; Sat,  9 May 2015 22:45:58 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3166.dip0.t-ipconnect.de [93.219.49.102])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4A2jkxe015925
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 9 May 2015 22:45:57 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431225937-10456-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqJt2zC/UYOMXAYuuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWizNvGhkd2Dz+vv/A5LFgU6nHs949jB4XLyl7LH7g5fF5k1wAWxS3
	TVJiSVlwZnqevl0Cd8a5XXtZClYIVLx+0sLSwHiPp4uRk0NCwETiV+NeNghbTOLCvfVANheH
	kMBlRolTZ78wQjjHmST2vj7IAlLFJqArsainmamLkYNDRMBLom1mMUgNs0Avo8Sjxa8YQWqE
	BQIl2p79BrNZBFQlvrb8YwaxeQVcJI60b2OE2CYncf74T7A4p4CrxO0zc8FsIaCaxqVNLBMY
	eRcwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXTy80s0UtNKd3ECAkyoR2M60/KHWIU4GBU
	4uH9sM0vVIg1say4MvcQoyQHk5Ior81CoBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3pPrgXK8
	KYmVValF+TApaQ4WJXHen4vV/YQE0hNLUrNTUwtSi2CyMhwcShK8sUeBGgWLUtNTK9Iyc0oQ
	0kwcnCDDuaREilPzUlKLEktLMuJBsRFfDIwOkBQP0N6tIO28xQWJuUBRiNZTjIpS4rxeIAkB
	kERGaR7cWFjqeMUoDvSlMK8ISBUPMO3Adb8CGswENPhvsQ/I4JJEhJRUA2NNWs+Z7x4dG/mk
	WSa8KFqgd+KYhS7DE+7udWKXI3LKnOtd0s82p+qvDT99+n6G7A1HI1uH04vz/M8v/a5k9ues
	xE7urQF69rKLPU4KvFqR/ty3Yrsqu5WX5bW5PQaZBew1XXvbF8hm3Pmy40fbUfGz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268718>

And remove the function write_ref_sha1(), as it is no longer used.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 38 ++++++++++----------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/refs.c b/refs.c
index 18ce8e6..76609bf 100644
--- a/refs.c
+++ b/refs.c
@@ -3134,30 +3134,6 @@ static int commit_ref_update(struct ref_lock *lock,
 	return 0;
 }
 
-/*
- * Write sha1 as the new value of the reference specified by the
- * (open) lock. On error, roll back the lockfile and set errno
- * appropriately.
- */
-static int write_ref_sha1(struct ref_lock *lock,
-			  const unsigned char *sha1, const char *logmsg)
-{
-	if (!lock) {
-		errno = EINVAL;
-		return -1;
-	}
-	if (!lock->force_write && !hashcmp(lock->old_sha1, sha1)) {
-		unlock_ref(lock);
-		return 0;
-	}
-
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
@@ -3852,15 +3828,21 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (!is_null_sha1(update->new_sha1)) {
-			if (write_ref_sha1(update->lock, update->new_sha1,
-					   update->msg)) {
-				update->lock = NULL; /* freed by write_ref_sha1 */
+			if (!update->lock->force_write &&
+			    !hashcmp(update->lock->old_sha1, update->new_sha1)) {
+				unlock_ref(update->lock);
+				update->lock = NULL;
+			} else if (write_ref_to_lockfile(update->lock, update->new_sha1) ||
+				   commit_ref_update(update->lock, update->new_sha1, update->msg)) {
+				update->lock = NULL; /* freed by the above calls */
 				strbuf_addf(err, "Cannot update the ref '%s'.",
 					    update->refname);
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
+			} else {
+				/* freed by the above calls: */
+				update->lock = NULL;
 			}
-			update->lock = NULL; /* freed by write_ref_sha1 */
 		}
 	}
 
-- 
2.1.4
