From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] lock_ref_sha1_basic: do not die on locking errors
Date: Tue, 18 Nov 2014 20:41:12 -0500
Message-ID: <20141119014112.GA2305@peff.net>
References: <20141119013532.GA861@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: sahlberg@google.com, jrnieder@gmail.com, gitster@pobox.com,
	git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 02:41:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XquGk-0002Vf-Ck
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 02:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932680AbaKSBlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 20:41:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:42071 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932547AbaKSBlO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 20:41:14 -0500
Received: (qmail 10011 invoked by uid 102); 19 Nov 2014 01:41:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 19:41:14 -0600
Received: (qmail 25502 invoked by uid 107); 19 Nov 2014 01:41:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Nov 2014 20:41:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Nov 2014 20:41:12 -0500
Content-Disposition: inline
In-Reply-To: <20141119013532.GA861@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

lock_ref_sha1_basic is inconsistent about when it calls
die() and when it returns NULL to signal an error. This is
annoying to any callers that want to recover from a locking
error.

This seems to be mostly historical accident. It was added in
4bd18c4 (Improve abstraction of ref lock/write.,
2006-05-17), which returned an error in all cases except
calling safe_create_leading_directories, in which case it
died.  Later, 40aaae8 (Better error message when we are
unable to lock the index file, 2006-08-12) asked
hold_lock_file_for_update to die for us, leaving the
resolve_ref code-path the only one which returned NULL.

We tried to correct that in 5cc3cef (lock_ref_sha1(): do not
sometimes error() and sometimes die()., 2006-09-30),
by converting all of the die() calls into returns. But we
missed the "die" flag passed to the lock code, leaving us
inconsistent. This state persisted until e5c223e
(lock_ref_sha1_basic(): if locking fails with ENOENT, retry,
2014-01-18). Because of its retry scheme, it does not ask
the lock code to die, but instead manually dies with
unable_to_lock_die().

We can make this consistent with the other return paths by
converting this to use unable_to_lock_message(), and
returning NULL. This is safe to do because all callers
already needed to check the return value of the function,
since it could fail (and return NULL) for other reasons.

[jk: Added excessive history explanation and rebased on
 nearby cleanups.]

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jeff King <peff@peff.net>
---
It's a little sad to have to do the errno dance here after our earlier
cleanups. But while error() is safe, unable_to_lock_message is anything
but (the original patch from Ronnie did not need this, because it leaves
the goto and last_errno in place). So I dunno. Maybe my cleanups were
all for naught, and this end result is worse.

 refs.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index fafae7e..1f7e136 100644
--- a/refs.c
+++ b/refs.c
@@ -2321,8 +2321,15 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			 * again:
 			 */
 			goto retry;
-		else
-			unable_to_lock_die(ref_file, errno);
+		else {
+			int saved_errno = errno;
+			struct strbuf buf = STRBUF_INIT;
+			unable_to_lock_message(ref_file, errno, &buf);
+			error("%s", buf.buf);
+			strbuf_release(&buf);
+			errno = saved_errno;
+			return NULL;
+		}
 	}
 	return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
 }
-- 
2.1.2.596.g7379948
