From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] lock_ref_sha1_basic: handle REF_NODEREF with
 invalid refs
Date: Tue, 12 Jan 2016 15:42:29 -0500
Message-ID: <20160112204229.GA13706@sigill.intra.peff.net>
References: <20160112095638.GA4773@sigill.intra.peff.net>
 <20160112095804.GB16501@sigill.intra.peff.net>
 <20160112132628.GA31854@sigill.intra.peff.net>
 <20160112135522.GA23255@sigill.intra.peff.net>
 <xmqqlh7utwki.fsf@gitster.mtv.corp.google.com>
 <20160112202251.GA10843@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 21:42:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ5m1-0001P6-1x
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 21:42:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845AbcALUme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 15:42:34 -0500
Received: from cloud.peff.net ([50.56.180.127]:52520 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753145AbcALUmb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 15:42:31 -0500
Received: (qmail 17012 invoked by uid 102); 12 Jan 2016 20:42:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 15:42:31 -0500
Received: (qmail 18249 invoked by uid 107); 12 Jan 2016 20:42:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 15:42:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jan 2016 15:42:29 -0500
Content-Disposition: inline
In-Reply-To: <20160112202251.GA10843@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283843>

On Tue, Jan 12, 2016 at 03:22:51PM -0500, Jeff King wrote:

> I had thought that this:
> 
>   git init
>   git commit --allow-empty -m foo
>   git symbolic-ref refs/foo refs/heads/master
>   old=$(git rev-parse foo)
>   git update-ref --no-deref -d refs/foo $old
> 
> might trigger a problem (because reading refs/foo with NODEREF will give
> us a blank sha1 to compare against). But of course that is nonsense. The
> actual lock verification is not done by this initial resolve_ref. It
> happens _after_ we take the lock (as it must to avoid races), when
> verify_lock() calls read_ref_full().
> 
> But now I'm doubly confused. When we call read_ref_full(), it is _also_
> into lock->old_oid.hash. Which should be overwriting what the earlier
> resolve_ref_unsafe() wrote into it. Which would mean my whole commit is
> wrong; we can just unconditionally do a non-recursive resolution in the
> first place. But when I did so, I ended up with funny reflog values
> (which is why I wrote the patch as I did).
> 
> Let me try to dig a little further into that case and see what is going
> on.

Ah, I see. When calling git-symbolic-ref, we don't provide an old_sha1,
and therefore never call verify_lock(). And we get whatever value in
lock->old_oid we happened to read earlier in resolve_ref_unsafe(). Which
happened outside of a lock. Yikes. It seems like we could racily write
the wrong reflog entry in such a case.

So I think we'd want something like this:

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 291b18d..c6ce503 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1845,7 +1845,7 @@ static int verify_lock(struct ref_lock *lock,
 		errno = save_errno;
 		return -1;
 	}
-	if (hashcmp(lock->old_oid.hash, old_sha1)) {
+	if (old_sha1 && hashcmp(lock->old_oid.hash, old_sha1)) {
 		strbuf_addf(err, "ref %s is at %s but expected %s",
 			    lock->ref_name,
 			    sha1_to_hex(lock->old_oid.hash),
@@ -2008,7 +1983,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			goto error_return;
 		}
 	}
-	if (old_sha1 && verify_lock(lock, old_sha1, mustexist, err)) {
+	if (verify_lock(lock, old_sha1, mustexist, err)) {
 		last_errno = errno;
 		goto error_return;
 	}

to make sure that the value in lock->old_oid always comes from what we
read under the lock. And then the resolve_ref() calls in
lock_ref_sha1_basic() really don't matter. They are just about making
sure there is space to create the lockfile.

The patch above is not quite right; I'll work up a series that takes
this approach.

-Peff
