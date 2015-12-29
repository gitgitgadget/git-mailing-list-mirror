From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] create_symref: write reflog while holding lock
Date: Tue, 29 Dec 2015 00:57:25 -0500
Message-ID: <20151229055725.GC17012@sigill.intra.peff.net>
References: <20151229055558.GA12848@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 06:57:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDnHs-0007Ut-6i
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 06:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753578AbbL2F5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 00:57:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:46507 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751027AbbL2F53 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 00:57:29 -0500
Received: (qmail 14010 invoked by uid 102); 29 Dec 2015 05:57:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 28 Dec 2015 23:57:27 -0600
Received: (qmail 18397 invoked by uid 107); 29 Dec 2015 05:57:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 00:57:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 00:57:25 -0500
Content-Disposition: inline
In-Reply-To: <20151229055558.GA12848@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283069>

We generally hold a lock on the matching ref while writing
to its reflog; this prevents two simultaneous writers from
clobbering each other's reflog lines (it does not even have
to be two symref updates; because we don't hold the lock, we
could race with somebody writing to the pointed-to ref via
HEAD, for example).

We can fix this by writing the reflog before we commit the
lockfile. This runs the risk of writing the reflog but
failing the final rename(), but at least we now err on the
same side as the rest of the ref code.

Noticed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jeff King <peff@peff.net>
---
 refs/files-backend.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3d1994d..180c837 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2850,12 +2850,13 @@ static int create_symref_locked(struct ref_lock *lock, const char *refname,
 		return error("unable to fdopen %s: %s",
 			     lock->lk->tempfile.filename.buf, strerror(errno));
 
+	update_symref_reflog(lock, refname, target, logmsg);
+
 	/* no error check; commit_ref will check ferror */
 	fprintf(lock->lk->tempfile.fp, "ref: %s\n", target);
 	if (commit_ref(lock) < 0)
 		return error("unable to write symref for %s: %s", refname,
 			     strerror(errno));
-	update_symref_reflog(lock, refname, target, logmsg);
 	return 0;
 }
 
-- 
2.7.0.rc2.368.g1cbb535
