From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] lock_ref_sha1_basic: simplify errno handling
Date: Tue, 18 Nov 2014 20:37:30 -0500
Message-ID: <20141119013730.GB2135@peff.net>
References: <20141119013532.GA861@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: sahlberg@google.com, jrnieder@gmail.com, gitster@pobox.com,
	git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 02:37:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XquD9-0001SP-SV
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 02:37:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbaKSBhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 20:37:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:42060 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754398AbaKSBhb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 20:37:31 -0500
Received: (qmail 9684 invoked by uid 102); 19 Nov 2014 01:37:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 19:37:31 -0600
Received: (qmail 25425 invoked by uid 107); 19 Nov 2014 01:37:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 20:37:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Nov 2014 20:37:30 -0500
Content-Disposition: inline
In-Reply-To: <20141119013532.GA861@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that error() does not clobber errno, we do not have to
take pains to save it ourselves.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 5ff457e..169a46d 100644
--- a/refs.c
+++ b/refs.c
@@ -2232,7 +2232,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	char *ref_file;
 	const char *orig_refname = refname;
 	struct ref_lock *lock;
-	int last_errno = 0;
 	int type, lflags;
 	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
 	int resolve_flags = 0;
@@ -2260,7 +2259,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		 */
 		ref_file = git_path("%s", orig_refname);
 		if (remove_empty_directories(ref_file)) {
-			last_errno = errno;
 			error("there are still refs under '%s'", orig_refname);
 			goto error_return;
 		}
@@ -2270,7 +2268,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	if (type_p)
 	    *type_p = type;
 	if (!refname) {
-		last_errno = errno;
 		error("unable to resolve reference %s: %s",
 			orig_refname, strerror(errno));
 		goto error_return;
@@ -2283,7 +2280,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 */
 	if (missing &&
 	     !is_refname_available(refname, skip, get_packed_refs(&ref_cache))) {
-		last_errno = ENOTDIR;
+		errno = ENOTDIR;
 		goto error_return;
 	}
 
@@ -2311,7 +2308,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			goto retry;
 		/* fall through */
 	default:
-		last_errno = errno;
 		error("unable to create directory for %s", ref_file);
 		goto error_return;
 	}
@@ -2332,7 +2328,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 
  error_return:
 	unlock_ref(lock);
-	errno = last_errno;
 	return NULL;
 }
 
-- 
2.1.2.596.g7379948
