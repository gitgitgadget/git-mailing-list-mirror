From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 13/18] lock_ref_sha1_basic(): report errors via a "struct strbuf *err"
Date: Fri,  1 May 2015 14:25:53 +0200
Message-ID: <1430483158-14349-14-git-send-email-mhagger@alum.mit.edu>
References: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 14:27:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoA25-0001MH-3u
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 14:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820AbbEAM0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 08:26:51 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:57978 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753758AbbEAM01 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2015 08:26:27 -0400
X-AuditID: 1207440c-f79376d00000680a-0a-554370f2b5b5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 52.8F.26634.2F073455; Fri,  1 May 2015 08:26:26 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D7E.dip0.t-ipconnect.de [79.201.125.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t41CQ3Zq004310
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 1 May 2015 08:26:25 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsUixO6iqPupwDnUYMsLWYuuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ3zvnsda8Fu74vPRdrYGxgtKXYycHBICJhLbb+xjhLDFJC7cW8/WxcjFISRwmVHixoH1
	TCAJIYETTBJbnrmB2GwCuhKLeprB4iICahIT2w6xgDQwC3QwSlxYvo0dJCEsECbx4UYXcxcj
	BweLgKrEprcGIGFeAVeJnrlvoZbJSZw//hOshBMo/mVqIsQqF4n737+yTWDkXcDIsIpRLjGn
	NFc3NzEzpzg1Wbc4OTEvL7VI11AvN7NELzWldBMjJJx4djB+WydziFGAg1GJh5fjpFOoEGti
	WXFl7iFGSQ4mJVFe2wTnUCG+pPyUyozE4oz4otKc1OJDjBIczEoivPfUgXK8KYmVValF+TAp
	aQ4WJXFe1SXqfkIC6YklqdmpqQWpRTBZGQ4OJQneX/lAjYJFqempFWmZOSUIaSYOTpDhXFIi
	xal5KalFiaUlGfGguIgvBkYGSIoHaO9DkHbe4oLEXKAoROspRkUpcd4wkIQASCKjNA9uLCxJ
	vGIUB/pSmJcVmDKEeIAJBq77FdBgJqDB5285gAwuSURISTUwljRaWPZve3AgbXETr81eLVkt
	2Y3cc6YX+MpPWV0d5Ze9SW6m/x0ht7qKueFM04/NT1rnP2NuQ+yjbaduyfJ9iWA+O3XPnwud
	FtYbcla+Ycx87848Z/vJtL1Bt8UuTAq3OjE/XSP8ZdONle9WvJstJlUleu3wcbMX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268129>

For now, change the callers spew the error to stderr like before. But
eventually, they should incorporate the reason for the failure into
their own error messages.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 730e248..1b466bc 100644
--- a/refs.c
+++ b/refs.c
@@ -2315,7 +2315,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
 					    const struct string_list *extras,
 					    const struct string_list *skip,
-					    unsigned int flags, int *type_p)
+					    unsigned int flags, int *type_p,
+					    struct strbuf *err)
 {
 	char *ref_file;
 	const char *orig_refname = refname;
@@ -2325,7 +2326,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
 	int resolve_flags = 0;
 	int attempts_remaining = 3;
-	struct strbuf err = STRBUF_INIT;
+
+	assert(err);
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
 
@@ -2348,7 +2350,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		ref_file = git_path("%s", orig_refname);
 		if (remove_empty_directories(ref_file)) {
 			last_errno = errno;
-			error("there are still refs under '%s'", orig_refname);
+			strbuf_addf(err, "there are still refs under '%s'",
+				    orig_refname);
 			goto error_return;
 		}
 		refname = resolve_ref_unsafe(orig_refname, resolve_flags,
@@ -2358,8 +2361,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
@@ -2370,8 +2373,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 */
 	if (is_null_sha1(lock->old_sha1) &&
 	    verify_refname_available(refname, extras, skip,
-				     get_packed_refs(&ref_cache), &err)) {
-		error("%s", err.buf);
+				     get_packed_refs(&ref_cache), err)) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -2397,7 +2399,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		/* fall through */
 	default:
 		last_errno = errno;
-		error("unable to create directory for %s", ref_file);
+		strbuf_addf(err, "unable to create directory for %s", ref_file);
 		goto error_return;
 	}
 
@@ -2411,8 +2413,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			 */
 			goto retry;
 		else {
-			unable_to_lock_message(ref_file, errno, &err);
-			error("%s", err.buf);
+			unable_to_lock_message(ref_file, errno, err);
 			goto error_return;
 		}
 	}
@@ -2420,7 +2421,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 
  error_return:
 	unlock_ref(lock);
-	strbuf_release(&err);
 	errno = last_errno;
 	return NULL;
 }
@@ -2836,6 +2836,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	struct stat loginfo;
 	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
 	const char *symref = NULL;
+	struct strbuf err = STRBUF_INIT;
 
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
@@ -2878,8 +2879,10 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, NULL, 0, NULL);
+	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, NULL, 0, NULL, &err);
 	if (!lock) {
+		error("%s", err.buf);
+		strbuf_release(&err);
 		error("unable to lock %s for update", newrefname);
 		goto rollback;
 	}
@@ -2893,8 +2896,10 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
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
@@ -3816,11 +3821,14 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 				 update->old_sha1 : NULL),
 				&affected_refnames, NULL,
 				update->flags,
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
@@ -4100,6 +4108,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 	char *log_file;
 	int status = 0;
 	int type;
+	struct strbuf err = STRBUF_INIT;
 
 	memset(&cb, 0, sizeof(cb));
 	cb.flags = flags;
@@ -4111,9 +4120,12 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
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
