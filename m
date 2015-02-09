From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/8] write_ref_sha1(): Move write elision test to callers
Date: Mon,  9 Feb 2015 10:12:38 +0100
Message-ID: <1423473164-6011-3-git-send-email-mhagger@alum.mit.edu>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 10:20:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKkVu-0002C7-TS
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 10:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbbBIJUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 04:20:11 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:59271 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932386AbbBIJUJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Feb 2015 04:20:09 -0500
X-AuditID: 12074413-f79f26d0000030e7-de-54d87a161350
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 18.42.12519.61A78D45; Mon,  9 Feb 2015 04:12:55 -0500 (EST)
Received: from michael.fritz.box (p4FC971C1.dip0.t-ipconnect.de [79.201.113.193])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t199CnQY026231
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 9 Feb 2015 04:12:53 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsUixO6iqCtedSPEYEaORdeVbiaLht4rzBZv
	by5htLi9Yj6zRfeUt4wWvX2fWC02b25ncWD3+Pv+A5PHzll32T0WbCr1uHhJ2ePzJrkA1ihu
	m6TEkrLgzPQ8fbsE7ownXxazFNwUrujoLG5gvMjfxcjJISFgIvFl/ydmCFtM4sK99WwgtpDA
	ZUaJHX1ZXYxcQPYJJol5t9cwgSTYBHQlFvU0g9kiAmoSE9sOsYDYzAKrmSS23gVrFhbwlPg8
	9zeQzcHBIqAq0X84GyTMK+Asse3FbUaIXXIS54//BNvLKeAi8e7cHKi9zhKzJ+9jnsDIu4CR
	YRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrrlebmaJXmpK6SZGSHgJ72DcdVLuEKMAB6MSD2/F
	x+shQqyJZcWVuYcYJTmYlER5FyTeCBHiS8pPqcxILM6ILyrNSS0+xCjBwawkwvs9AyjHm5JY
	WZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLg5aoEahQsSk1PrUjLzClBSDNx
	cIIM55ISKU7NS0ktSiwtyYgHRUV8MTAuQFI8QHu/VoDsLS5IzAWKQrSeYlSUEuf9BpIQAElk
	lObBjYUljVeM4kBfCvOeA6niASYcuO5XQIOZgAYXFIANLklESEk1MG7sLPt9NeLjxHmSrmrC
	YhsLvvedSWW8cfKrnVbo/sMXnK1aChOPpJyYcpH3zfH39fHmEgqKyduuCp7+N3+hNceXhvgr
	/yfW//gzf9aO6uh2nUWadxy1Fkj8WWHqKstbX8rcoXNi1utdLtMm7V8ZcPTGg6pG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263553>

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
index d1130e2..651e37e 100644
--- a/refs.c
+++ b/refs.c
@@ -2878,7 +2878,6 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		error("unable to lock %s for update", newrefname);
 		goto rollback;
 	}
-	lock->force_write = 1;
 	hashcpy(lock->old_sha1, orig_sha1);
 	if (write_ref_sha1(lock, orig_sha1, logmsg)) {
 		error("unable to write current sha1 into %s", newrefname);
@@ -2894,7 +2893,6 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		goto rollbacklog;
 	}
 
-	lock->force_write = 1;
 	flag = log_all_ref_updates;
 	log_all_ref_updates = 0;
 	if (write_ref_sha1(lock, orig_sha1, NULL))
@@ -3080,10 +3078,6 @@ static int write_ref_sha1(struct ref_lock *lock,
 	static char term = '\n';
 	struct object *o;
 
-	if (!lock->force_write && !hashcmp(lock->old_sha1, sha1)) {
-		unlock_ref(lock);
-		return 0;
-	}
 	o = parse_object(sha1);
 	if (!o) {
 		error("Trying to write ref %s with nonexistent object %s",
@@ -3797,15 +3791,21 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
