From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] lock_ref_sha1_basic: simplify error code path
Date: Tue, 18 Nov 2014 20:37:40 -0500
Message-ID: <20141119013739.GC2135@peff.net>
References: <20141119013532.GA861@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: sahlberg@google.com, jrnieder@gmail.com, gitster@pobox.com,
	git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 02:37:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XquDK-0001V5-1v
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 02:37:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbaKSBhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 20:37:42 -0500
Received: from cloud.peff.net ([50.56.180.127]:42066 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932229AbaKSBhm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 20:37:42 -0500
Received: (qmail 9735 invoked by uid 102); 19 Nov 2014 01:37:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 19:37:41 -0600
Received: (qmail 25445 invoked by uid 107); 19 Nov 2014 01:37:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 20:37:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Nov 2014 20:37:40 -0500
Content-Disposition: inline
In-Reply-To: <20141119013532.GA861@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For most errors, we jump to a goto label that unlocks the
ref and returns NULL. However, in none of these error paths
would we ever have actually locked the ref. By the time we
actually take the lock, we follow a different path that does
not ever hit this goto (we rely on verify_lock to unlock if
it finds an error).

We can just drop the goto completely and return NULL as
appropriate.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 169a46d..fafae7e 100644
--- a/refs.c
+++ b/refs.c
@@ -2260,7 +2260,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		ref_file = git_path("%s", orig_refname);
 		if (remove_empty_directories(ref_file)) {
 			error("there are still refs under '%s'", orig_refname);
-			goto error_return;
+			return NULL;
 		}
 		refname = resolve_ref_unsafe(orig_refname, resolve_flags,
 					     lock->old_sha1, &type);
@@ -2270,7 +2270,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	if (!refname) {
 		error("unable to resolve reference %s: %s",
 			orig_refname, strerror(errno));
-		goto error_return;
+		return NULL;
 	}
 	missing = is_null_sha1(lock->old_sha1);
 	/* When the ref did not exist and we are creating it,
@@ -2281,7 +2281,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	if (missing &&
 	     !is_refname_available(refname, skip, get_packed_refs(&ref_cache))) {
 		errno = ENOTDIR;
-		goto error_return;
+		return NULL;
 	}
 
 	lock->lk = xcalloc(1, sizeof(struct lock_file));
@@ -2309,7 +2309,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		/* fall through */
 	default:
 		error("unable to create directory for %s", ref_file);
-		goto error_return;
+		return NULL;
 	}
 
 	lock->lock_fd = hold_lock_file_for_update(lock->lk, ref_file, lflags);
@@ -2325,10 +2325,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			unable_to_lock_die(ref_file, errno);
 	}
 	return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
-
- error_return:
-	unlock_ref(lock);
-	return NULL;
 }
 
 struct ref_lock *lock_any_ref_for_update(const char *refname,
-- 
2.1.2.596.g7379948
