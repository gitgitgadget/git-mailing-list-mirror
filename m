From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] lock_ref_sha1_basic: simplify error code path
Date: Wed, 19 Nov 2014 17:28:52 -0500
Message-ID: <20141119222852.GA12236@peff.net>
References: <20141119013532.GA861@peff.net>
 <20141119013739.GC2135@peff.net>
 <20141119020009.GR6527@google.com>
 <20141119020451.GA2734@peff.net>
 <20141119020713.GT6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>, sahlberg@google.com,
	gitster@pobox.com, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 23:29:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrDkC-0002Y5-2M
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 23:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbaKSW24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 17:28:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:42552 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932493AbaKSW2y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 17:28:54 -0500
Received: (qmail 1743 invoked by uid 102); 19 Nov 2014 22:28:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Nov 2014 16:28:54 -0600
Received: (qmail 8496 invoked by uid 107); 19 Nov 2014 22:29:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Nov 2014 17:29:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Nov 2014 17:28:52 -0500
Content-Disposition: inline
In-Reply-To: <20141119020713.GT6527@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 18, 2014 at 06:07:13PM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > Hmph. Should we just abandon my series in favor of taking Ronnie's
> > original patch, then? We can apply the "save/restore errno in error()"
> > patch independently if we like.
> 
> I liked patches 1 and 2 and the explanation from patch 4.  Perhaps
> patch 3 should be replaced with a patch renaming unlock_ref to
> free_ref_lock or something.

I took a look at this, and it ends up not being very useful.

The "return NULL" from the final patch has to become a "goto
error_return", so that it can call unlock_ref(). But that means it
cannot save and restore errno itself, because unlock_ref may clobber
errno[1].

So we still have to keep the last_errno handling in error_return.
Meaning that we need to drop patch 2 (even though the other cases don't
need errno saved/restore, since the goto does it unconditionally, we
still need to set last_errno). And therefore patch 1 is not helping
anyone (we could still apply it, but there's no immediate benefit).

I also looked at renaming unlock_ref, but it is called from other places
where they _do_ care about unlocking. So renaming is out. We could build
a free_ref_lock that unlock_ref builds on, but that brings up another
confusion: can we or can we not free the "struct lockfile" pointer it
contains (and which should free_ref_lock do)? Whether it is safe to do
so depends on whether we have actually fed it to hold_lock_file_for_update
or not (even if it fails, it takes ownership of the lock). So we
actually leak it in some cases, but the only case we could fix is when
safe_create_leading_directories the _first_ time (before we have ever
tried to lock and failed, at which point we loop). Yeesh.

So I really think we are better off leaving it as-is, and just applying
some form of Ronnie's patch (which does the right thing with errno). The
other cleanups end up making things worse, and the unlock_ref thing was
just my misunderstanding.

So here is that patch, with my explanation. Thanks for your patience in
my running around in circles. :)

-- >8 --
Subject: lock_ref_sha1_basic: do not die on locking errors

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

[jk: Added excessive history explanation]

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 5ff457e..0347328 100644
--- a/refs.c
+++ b/refs.c
@@ -2318,6 +2318,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 
 	lock->lock_fd = hold_lock_file_for_update(lock->lk, ref_file, lflags);
 	if (lock->lock_fd < 0) {
+		last_errno = errno;
 		if (errno == ENOENT && --attempts_remaining > 0)
 			/*
 			 * Maybe somebody just deleted one of the
@@ -2325,8 +2326,13 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			 * again:
 			 */
 			goto retry;
-		else
-			unable_to_lock_die(ref_file, errno);
+		else {
+			struct strbuf err = STRBUF_INIT;
+			unable_to_lock_message(ref_file, errno, &err);
+			error("%s", err.buf);
+			strbuf_reset(&err);
+			goto error_return;
+		}
 	}
 	return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
 
-- 
2.1.2.596.g7379948
