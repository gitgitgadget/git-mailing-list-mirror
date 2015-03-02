From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 2/7] write_ref_sha1(): Move write elision test to callers
Date: Mon,  2 Mar 2015 10:29:52 +0100
Message-ID: <1425288597-20547-3-git-send-email-mhagger@alum.mit.edu>
References: <1425288597-20547-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 10:30:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSMgF-0007IB-3E
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 10:30:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814AbbCBJaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 04:30:23 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:58928 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753786AbbCBJaU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2015 04:30:20 -0500
X-AuditID: 1207440c-f79376d00000680a-ee-54f42da67650
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id B2.DD.26634.6AD24F45; Mon,  2 Mar 2015 04:30:14 -0500 (EST)
Received: from michael.fritz.box (p5DDB2321.dip0.t-ipconnect.de [93.219.35.33])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t229U5HV008921
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 2 Mar 2015 04:30:12 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1425288597-20547-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsUixO6iqLtM90uIweoHIhZdV7qZLBp6rzBb
	vL25hNHi9or5zBbdU94yWvxo6WG26O37xGqxeXM7i8WZN42MDpwef99/YPLYOesuu8eCTaUe
	z3r3MHpcvKTssfiBl8fnTXIB7FHcNkmJJWXBmel5+nYJ3BmPJrWwFNwUrtg3u529gfEifxcj
	J4eEgInE39lNrBC2mMSFe+vZuhi5OIQELjNKPDrxjxnCOcYksfrMYXaQKjYBXYlFPc1MILaI
	gJrExLZDLCA2s8APJolDK2pBbGEBH4lD/c+ZQWwWAVWJVTuXgm3gFXCR+HZ8LyPENjmJ88d/
	gtVwCrhK/PzVCDZfCKhm1vXVzBMYeRcwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXUy80s
	0UtNKd3ECAlGnh2M39bJHGIU4GBU4uFdMO9ziBBrYllxZe4hRkkOJiVR3uM6X0KE+JLyUyoz
	Eosz4otKc1KLDzFKcDArifC+lgfK8aYkVlalFuXDpKQ5WJTEeVWXqPsJCaQnlqRmp6YWpBbB
	ZGU4OJQkeINBhgoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDYiO+GBgdICkeoL13
	Qdp5iwsSc4GiEK2nGBWlxHmdQBICIImM0jy4sbAU84pRHOhLYd4KkCoeYHqC634FNJgJaPAt
	RbDBJYkIKakGRpWfr10akjy/Pz/iZj5j+RwXk94NwVN/m8eGLexeKxi+Zfmy8J/yBVu8DN0k
	dy5T7rbjOBnyVeeqmnp702lu8eRH+x+5GM86PkfvpWPysiyH06HeD+56+d61Wbdv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264580>

write_ref_sha1() previously skipped the write if the reference already
had the desired value, unless lock->force_write was set. Instead,
perform that test at the callers.

Two of the callers (in rename_ref()) unconditionally set force_write
just before calling write_ref_sha1(), so they don't need the extra
check at all. Nor do they need to set force_write anymore.

The last caller, in ref_transaction_commit(), still needs the test.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index e82d503..dd30bfa 100644
--- a/refs.c
+++ b/refs.c
@@ -2877,7 +2877,6 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		error("unable to lock %s for update", newrefname);
 		goto rollback;
 	}
-	lock->force_write = 1;
 	hashcpy(lock->old_sha1, orig_sha1);
 	if (write_ref_sha1(lock, orig_sha1, logmsg)) {
 		error("unable to write current sha1 into %s", newrefname);
@@ -2893,7 +2892,6 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		goto rollbacklog;
 	}
 
-	lock->force_write = 1;
 	flag = log_all_ref_updates;
 	log_all_ref_updates = 0;
 	if (write_ref_sha1(lock, orig_sha1, NULL))
@@ -3079,10 +3077,6 @@ static int write_ref_sha1(struct ref_lock *lock,
 	static char term = '\n';
 	struct object *o;
 
-	if (!lock->force_write && !hashcmp(lock->old_sha1, sha1)) {
-		unlock_ref(lock);
-		return 0;
-	}
 	o = parse_object(sha1);
 	if (!o) {
 		error("Trying to write ref %s with nonexistent object %s",
@@ -3796,15 +3790,21 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (!is_null_sha1(update->new_sha1)) {
-			if (write_ref_sha1(update->lock, update->new_sha1,
-					   update->msg)) {
+			if (!update->lock->force_write &&
+			    !hashcmp(update->lock->old_sha1, update->new_sha1)) {
+				unlock_ref(update->lock);
+				update->lock = NULL;
+			} else if (write_ref_sha1(update->lock, update->new_sha1,
+						  update->msg)) {
 				update->lock = NULL; /* freed by write_ref_sha1 */
 				strbuf_addf(err, "Cannot update the ref '%s'.",
 					    update->refname);
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
+			} else {
+				/* freed by write_ref_sha1(): */
+				update->lock = NULL;
 			}
-			update->lock = NULL; /* freed by write_ref_sha1 */
 		}
 	}
 
-- 
2.1.4
