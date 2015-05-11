From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 13/18] lock_ref_sha1_basic(): report errors via a "struct strbuf *err"
Date: Mon, 11 May 2015 17:25:15 +0200
Message-ID: <1431357920-25090-14-git-send-email-mhagger@alum.mit.edu>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 17:26:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrpal-0002aa-57
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 17:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754346AbbEKPZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 11:25:56 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:56686 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751963AbbEKPZy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 11:25:54 -0400
X-AuditID: 1207440d-f79976d000005643-9d-5550ca005c93
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 75.A3.22083.00AC0555; Mon, 11 May 2015 11:25:52 -0400 (EDT)
Received: from michael.fritz.box (p5DDB195E.dip0.t-ipconnect.de [93.219.25.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4BFPNnP002156
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 11 May 2015 11:25:51 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqMtwKiDU4P5RFYuuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWizNvGhkd2Dz+vv/A5LFgU6nHs949jB4XLyl7LH7g5fF5k1wAWxS3
	TVJiSVlwZnqevl0Cd8aMjx1sBX06FbPPTmVvYLyj1MXIySEhYCJxf95CRghbTOLCvfVsXYxc
	HEIClxklpv87AeUcZ5LY9XsBK0gVm4CuxKKeZiYQW0RATWJi2yEWkCJmgV2MEveWTmUBSQgL
	REqcXnIEqIGDg0VAVeLKHg6QMK+Aq8Sjj+vYILbJSZw//pMZxOYEii+9ehmsVUjARaLp8T2W
	CYy8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGunlZpbopaaUbmKEBBnvDsb/62QOMQpw
	MCrx8HZc8g8VYk0sK67MPcQoycGkJMr7a29AqBBfUn5KZUZicUZ8UWlOavEhRgkOZiURXuU1
	QDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgRvykmgRsGi1PTUirTM
	nBKENBMHJ8hwLimR4tS8lNSixNKSjHhQbMQXA6MDJMUDtPfrCZC9xQWJuUBRiNZTjIpS4rwp
	IAkBkERGaR7cWFjqeMUoDvSlMK8lSBUPMO3Adb8CGswENNgxDmxwSSJCSqqBUTypYZPYmuwN
	mxTF1757abVN5cu92J+mzyRnLmuyjb+id9mspPDR98yl97rFanJtV7yLOpj7rC2N6ZXPVP3k
	wKtz4u7FfFnsomZrxZTw3tn7pIKdX7Zw9VT9zyeVt+hZrX5mfDN+94ryNaqerlOi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268786>

For now, change the callers to spew the error to stderr like before.
But soon we will change them to incorporate the reason for the failure
into their own error messages.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 43e7bdd..ff9b9cf 100644
--- a/refs.c
+++ b/refs.c
@@ -2333,7 +2333,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
 					    const struct string_list *extras,
 					    const struct string_list *skip,
-					    unsigned int flags, int *type_p)
+					    unsigned int flags, int *type_p,
+					    struct strbuf *err)
 {
 	char *ref_file;
 	const char *orig_refname = refname;
@@ -2343,7 +2344,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
 	int resolve_flags = 0;
 	int attempts_remaining = 3;
-	struct strbuf err = STRBUF_INIT;
+
+	assert(err);
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
@@ -2367,7 +2369,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		ref_file = git_path("%s", orig_refname);
 		if (remove_empty_directories(ref_file)) {
 			last_errno = errno;
-			error("there are still refs under '%s'", orig_refname);
+			strbuf_addf(err, "there are still refs under '%s'",
+				    orig_refname);
 			goto error_return;
 		}
 		refname = resolve_ref_unsafe(orig_refname, resolve_flags,
@@ -2377,8 +2380,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	    *type_p = type;
 	if (!refname) {
 		last_errno = errno;
-		error("unable to resolve reference %s: %s",
-			orig_refname, strerror(errno));
+		strbuf_addf(err, "unable to resolve reference %s: %s",
+			    orig_refname, strerror(errno));
 		goto error_return;
 	}
 	/*
@@ -2389,8 +2392,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 */
 	if (is_null_sha1(lock->old_sha1) &&
 	    verify_refname_available(refname, extras, skip,
-				     get_packed_refs(&ref_cache), &err)) {
-		error("%s", err.buf);
+				     get_packed_refs(&ref_cache), err)) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -2416,7 +2418,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		/* fall through */
 	default:
 		last_errno = errno;
-		error("unable to create directory for %s", ref_file);
+		strbuf_addf(err, "unable to create directory for %s", ref_file);
 		goto error_return;
 	}
 
@@ -2431,8 +2433,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			 */
 			goto retry;
 		else {
-			unable_to_lock_message(ref_file, errno, &err);
-			error("%s", err.buf);
+			unable_to_lock_message(ref_file, errno, err);
 			goto error_return;
 		}
 	}
@@ -2440,7 +2441,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 
  error_return:
 	unlock_ref(lock);
-	strbuf_release(&err);
 	errno = last_errno;
 	return NULL;
 }
@@ -2854,6 +2854,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	struct stat loginfo;
 	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
 	const char *symref = NULL;
+	struct strbuf err = STRBUF_INIT;
 
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
@@ -2896,8 +2897,10 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, NULL, 0, NULL, &err);
 	if (!lock) {
+		error("%s", err.buf);
+		strbuf_release(&err);
 		error("unable to lock %s for update", newrefname);
 		goto rollback;
 	}
@@ -2910,8 +2913,10 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	return 0;
 
  rollback:
-	lock = lock_ref_sha1_basic(oldrefname, NULL, NULL, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(oldrefname, NULL, NULL, NULL, 0, NULL, &err);
 	if (!lock) {
+		error("%s", err.buf);
+		strbuf_release(&err);
 		error("unable to lock %s for rollback", oldrefname);
 		goto rollbacklog;
 	}
@@ -3824,11 +3829,14 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 				 update->old_sha1 : NULL),
 				&affected_refnames, NULL,
 				flags,
-				&update->type);
+				&update->type,
+				err);
 		if (!update->lock) {
 			ret = (errno == ENOTDIR)
 				? TRANSACTION_NAME_CONFLICT
 				: TRANSACTION_GENERIC_ERROR;
+			error("%s", err->buf);
+			strbuf_reset(err);
 			strbuf_addf(err, "Cannot lock the ref '%s'.",
 				    update->refname);
 			goto cleanup;
@@ -4088,6 +4096,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 	char *log_file;
 	int status = 0;
 	int type;
+	struct strbuf err = STRBUF_INIT;
 
 	memset(&cb, 0, sizeof(cb));
 	cb.flags = flags;
@@ -4099,9 +4108,12 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 	 * reference itself, plus we might need to update the
 	 * reference if --updateref was specified:
 	 */
-	lock = lock_ref_sha1_basic(refname, sha1, NULL, NULL, 0, &type);
-	if (!lock)
+	lock = lock_ref_sha1_basic(refname, sha1, NULL, NULL, 0, &type, &err);
+	if (!lock) {
+		error("%s", err.buf);
+		strbuf_release(&err);
 		return error("cannot lock ref '%s'", refname);
+	}
 	if (!reflog_exists(refname)) {
 		unlock_ref(lock);
 		return 0;
-- 
2.1.4
