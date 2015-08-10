From: Jeff King <peff@peff.net>
Subject: [PATCH 13/17] refs.c: avoid git_path assignment in
 lock_ref_sha1_basic
Date: Mon, 10 Aug 2015 05:37:12 -0400
Message-ID: <20150810093711.GM30981@sigill.intra.peff.net>
References: <20150810092731.GA9027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 11:37:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjWE-00057U-3x
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535AbbHJJhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:37:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:42853 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754457AbbHJJhR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 05:37:17 -0400
Received: (qmail 31052 invoked by uid 102); 10 Aug 2015 09:37:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 04:37:17 -0500
Received: (qmail 3237 invoked by uid 107); 10 Aug 2015 09:37:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 05:37:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2015 05:37:12 -0400
Content-Disposition: inline
In-Reply-To: <20150810092731.GA9027@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275579>

Assigning the result of git_path is a bad pattern, because
it's not immediately obvious how long you expect the content
to stay valid (and it may be overwritten by subsequent
calls). Let's use a function-local strbuf here instead,
which we know is safe (we just have to remember to free it
in all code paths).

As a bonus, we get rid of a confusing variable-reuse
("ref_file" is used for two distinct purposes).

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index 61a318f..8566677 100644
--- a/refs.c
+++ b/refs.c
@@ -2408,7 +2408,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    unsigned int flags, int *type_p,
 					    struct strbuf *err)
 {
-	const char *ref_file;
+	struct strbuf ref_file = STRBUF_INIT;
+	struct strbuf orig_ref_file = STRBUF_INIT;
 	const char *orig_refname = refname;
 	struct ref_lock *lock;
 	int last_errno = 0;
@@ -2432,20 +2433,19 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	refname = resolve_ref_unsafe(refname, resolve_flags,
 				     lock->old_oid.hash, &type);
 	if (!refname && errno == EISDIR) {
-		/* we are trying to lock foo but we used to
+		/*
+		 * we are trying to lock foo but we used to
 		 * have foo/bar which now does not exist;
 		 * it is normal for the empty directory 'foo'
 		 * to remain.
 		 */
-		ref_file = git_path("%s", orig_refname);
-		if (remove_empty_directories(ref_file)) {
+		strbuf_git_path(&orig_ref_file, "%s", orig_refname);
+		if (remove_empty_directories(orig_ref_file.buf)) {
 			last_errno = errno;
-
 			if (!verify_refname_available(orig_refname, extras, skip,
 						      get_loose_refs(&ref_cache), err))
 				strbuf_addf(err, "there are still refs under '%s'",
 					    orig_refname);
-
 			goto error_return;
 		}
 		refname = resolve_ref_unsafe(orig_refname, resolve_flags,
@@ -2485,10 +2485,10 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	}
 	lock->ref_name = xstrdup(refname);
 	lock->orig_ref_name = xstrdup(orig_refname);
-	ref_file = git_path("%s", refname);
+	strbuf_git_path(&ref_file, "%s", refname);
 
  retry:
-	switch (safe_create_leading_directories_const(ref_file)) {
+	switch (safe_create_leading_directories_const(ref_file.buf)) {
 	case SCLD_OK:
 		break; /* success */
 	case SCLD_VANISHED:
@@ -2497,11 +2497,12 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		/* fall through */
 	default:
 		last_errno = errno;
-		strbuf_addf(err, "unable to create directory for %s", ref_file);
+		strbuf_addf(err, "unable to create directory for %s",
+			    ref_file.buf);
 		goto error_return;
 	}
 
-	if (hold_lock_file_for_update(lock->lk, ref_file, lflags) < 0) {
+	if (hold_lock_file_for_update(lock->lk, ref_file.buf, lflags) < 0) {
 		last_errno = errno;
 		if (errno == ENOENT && --attempts_remaining > 0)
 			/*
@@ -2511,7 +2512,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			 */
 			goto retry;
 		else {
-			unable_to_lock_message(ref_file, errno, err);
+			unable_to_lock_message(ref_file.buf, errno, err);
 			goto error_return;
 		}
 	}
@@ -2519,12 +2520,17 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		last_errno = errno;
 		goto error_return;
 	}
-	return lock;
+	goto out;
 
  error_return:
 	unlock_ref(lock);
+	lock = NULL;
+
+ out:
+	strbuf_release(&ref_file);
+	strbuf_release(&orig_ref_file);
 	errno = last_errno;
-	return NULL;
+	return lock;
 }
 
 /*
-- 
2.5.0.414.g670f2a4
