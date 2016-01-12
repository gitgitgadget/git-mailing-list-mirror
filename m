From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] lock_ref_sha1_basic: always fill old_oid while holding
 lock
Date: Tue, 12 Jan 2016 16:44:39 -0500
Message-ID: <20160112214439.GB2841@sigill.intra.peff.net>
References: <20160112214318.GA2527@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 22:45:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ6kG-0007Va-2j
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 22:44:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934AbcALVon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 16:44:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:52570 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753882AbcALVom (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 16:44:42 -0500
Received: (qmail 19619 invoked by uid 102); 12 Jan 2016 21:44:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 16:44:42 -0500
Received: (qmail 18821 invoked by uid 107); 12 Jan 2016 21:44:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 16:44:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jan 2016 16:44:39 -0500
Content-Disposition: inline
In-Reply-To: <20160112214318.GA2527@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283847>

Our basic strategy for taking a ref lock is:

  1. Create $ref.lock to take the lock

  2. Read the ref again while holding the lock (during which
     time we know that nobody else can be updating it).

  3. Compare the value we read to the expected "old_sha1"

The value we read in step (2) is returned to the caller via
the lock->old_oid field, who may use it for other purposes
(such as writing a reflog).

If we have no "old_sha1" (i.e., we are unconditionally
taking the lock), then we obviously must omit step 3. But we
_also_ omit step 2. This seems like a nice optimization, but
it means that the caller sees only whatever was left in
lock->old_oid from previous calls to resolve_ref_unsafe(),
which happened outside of the lock.

We can demonstrate this race pretty easily. Imagine you have
three commits, $one, $two, and $three. One script just flips
between $one and $two, without providing an old-sha1:

  while true; do
    git update-ref -m one refs/heads/foo $one
    git update-ref -m two refs/heads/foo $two
  done

Meanwhile, another script tries to set the value to $three,
also not using an old-sha1:

  while true; do
    git update-ref -m three refs/heads/foo $three
  done

If these run simultaneously, we'll see a lot of lock
contention, but each of the writes will succeed some of the
time. The reflog may record movements between any of the
three refs, but we would expect it to provide a consistent
log: the "from" field of each log entry should be the same
as the "two" field of the previous one.

But if we check this:

  perl -alne '
    print "mismatch on line $."
            if defined $last && $F[0] ne $last;
    $last = $F[1];
  ' .git/logs/refs/heads/foo

we'll see many mismatches. Why?

Because sometimes, in the time between lock_ref_sha1_basic
filling lock->old_oid via resolve_ref_unsafe() and it taking
the lock, there may be a complete write by another process.
And the "from" field in our reflog entry will be wrong, and
will refer to an older value.

This is probably quite rare in practice. It requires writers
which do not provide an old-sha1 value, and it is a very
quick race. However, it is easy to fix: we simply perform
step (2), the read-under-lock, whether we have an old-sha1
or not. Then the value we hand back to the caller is always
atomic.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs/files-backend.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 180c837..69c3ecf 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1840,12 +1840,17 @@ static int verify_lock(struct ref_lock *lock,
 	if (read_ref_full(lock->ref_name,
 			  mustexist ? RESOLVE_REF_READING : 0,
 			  lock->old_oid.hash, NULL)) {
-		int save_errno = errno;
-		strbuf_addf(err, "can't verify ref %s", lock->ref_name);
-		errno = save_errno;
-		return -1;
+		if (old_sha1) {
+			int save_errno = errno;
+			strbuf_addf(err, "can't verify ref %s", lock->ref_name);
+			errno = save_errno;
+			return -1;
+		} else {
+			hashclr(lock->old_oid.hash);
+			return 0;
+		}
 	}
-	if (hashcmp(lock->old_oid.hash, old_sha1)) {
+	if (old_sha1 && hashcmp(lock->old_oid.hash, old_sha1)) {
 		strbuf_addf(err, "ref %s is at %s but expected %s",
 			    lock->ref_name,
 			    sha1_to_hex(lock->old_oid.hash),
@@ -1985,7 +1990,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			goto error_return;
 		}
 	}
-	if (old_sha1 && verify_lock(lock, old_sha1, mustexist, err)) {
+	if (verify_lock(lock, old_sha1, mustexist, err)) {
 		last_errno = errno;
 		goto error_return;
 	}
-- 
2.7.0.368.g04bc9ee
