From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 2/7] write_ref_sha1(): Move write elision test to callers
Date: Tue,  3 Mar 2015 12:43:12 +0100
Message-ID: <1425382997-24984-3-git-send-email-mhagger@alum.mit.edu>
References: <1425382997-24984-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 12:43:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSlEu-0003ti-Fk
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 12:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756435AbbCCLnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 06:43:45 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:46139 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756317AbbCCLno (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2015 06:43:44 -0500
X-AuditID: 12074414-f797f6d000004084-c6-54f59e62e5c1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id C5.15.16516.26E95F45; Tue,  3 Mar 2015 06:43:30 -0500 (EST)
Received: from michael.fritz.box (p5DDB193E.dip0.t-ipconnect.de [93.219.25.62])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t23BhJqF016748
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Mar 2015 06:43:28 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1425382997-24984-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsUixO6iqJs072uIwcQ78hZdV7qZLBp6rzBb
	vL25hNHi9or5zBbdU94yWvxo6WG26O37xGqxeXM7i8WZN42MDpwef99/YPLYOesuu8eCTaUe
	z3r3MHpcvKTssfiBl8fnTXIB7FHcNkmJJWXBmel5+nYJ3BmPJrWwFNwUrtg3u529gfEifxcj
	J4eEgInE85XzWCFsMYkL99azgdhCApcZJS7/TYawjzFJTJsOFmcT0JVY1NPMBGKLCKhJTGw7
	xAJiMwv8YJI4tKIWxBYW8JG48GIZUD0HB4uAqsSUTT4gYV4BF4ljfzdArZKTOH/8JzOIzSng
	KrFy7VZWkHIhoJpbHyomMPIuYGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRroZebWaKXmlK6
	iREShCI7GI+clDvEKMDBqMTDO4H9a4gQa2JZcWXuIUZJDiYlUV752UAhvqT8lMqMxOKM+KLS
	nNTiQ4wSHMxKIrzMc4FyvCmJlVWpRfkwKWkOFiVx3m+L1f2EBNITS1KzU1MLUotgsjIcHEoS
	vPogjYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgmIgvBkYFSIoHaO/POSB7iwsS
	c4GiEK2nGBWlxHmfgiQEQBIZpXlwY2Gp5RWjONCXwrxzQbbzANMSXPcroMFMQINvKX4BGVyS
	iJCSamBkXlIjtFiVs3HX5zmfgo4ybb9ZbzLz2bvDsRbbuv9xL/80QW+hQj+zy9bGw/sm8TFq
	zt2teOSCyi5puW+d8oukj+sx5bX8f8I1xZojSZydselceFe0n1c264voFQ3npe4Z 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264656>

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
