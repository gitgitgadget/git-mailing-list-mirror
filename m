Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CD56207EB
	for <e@80x24.org>; Thu, 27 Apr 2017 03:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161087AbdD0DNT (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 23:13:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:40956 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937118AbdD0DNS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 23:13:18 -0400
Received: (qmail 12960 invoked by uid 109); 27 Apr 2017 03:13:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Apr 2017 03:13:14 +0000
Received: (qmail 7061 invoked by uid 111); 27 Apr 2017 03:13:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Apr 2017 23:13:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Apr 2017 23:13:11 -0400
Date:   Wed, 26 Apr 2017 23:13:11 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] read-cache: close index.lock in do_write_index
Message-ID: <20170427031311.hfbit6glkx2tw3ru@sigill.intra.peff.net>
References: <e1b4f9c377ceee296112fa07bd06492a1de1be67.1493237111.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e1b4f9c377ceee296112fa07bd06492a1de1be67.1493237111.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 26, 2017 at 10:05:23PM +0200, Johannes Schindelin wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Teach do_write_index() to close the index.lock file
> before getting the mtime and updating the istate.timestamp
> fields.
> 
> On Windows, a file's mtime is not updated until the file is
> closed.  On Linux, the mtime is set after the last flush.

I wondered at first what this would mean for atomicity. The original
code does an fstat, so we're sure to get the timestamp of what we just
wrote.

I think we should be OK after your change, though. We're stat()ing the
lockfile itself, so nobody else should be touching it (because they'd be
violating the lock to do so).

> -static int do_write_index(struct index_state *istate, int newfd,
> +static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>  			  int strip_extensions)
> [...]
> -	if (ce_flush(&c, newfd, istate->sha1) || fstat(newfd, &st))
> +	if (ce_flush(&c, newfd, istate->sha1))
> +		return -1;
> +	if (close_tempfile(tempfile))
> +		return error(_("could not close '%s'"), tempfile->filename.buf);
> +	if (lstat(tempfile->filename.buf, &st))
>  		return -1;

So now we unconditionally close in do_write_index(), but I don't see any
close_tempfile() calls going away. For the call in write_shared_index(),
that's because we either call delete_tempfile() or rename_tempfile(),
either of which would close as needed, but can handle an already-closed
file.

The other caller is do_write_locked_index(), which accepts either a
flag: either COMMIT_LOCK, CLOSE_LOCK, or neither. COMMIT_LOCK is OK; it
can handle the already-closed file. CLOSE_LOCK is obviously fine. It
just becomes a noop. But when neither flag is set, now we close the
lock. Are there any callers that will be affected?

There are three callers, but I think they all eventually trace up to
write_locked_index(). And grepping for callers of that function, it
looks like each one uses either COMMIT_LOCK or CLOSE_LOCK.

So perhaps we'd want to squash in (or perhaps do as a preparatory
patch) something like:

diff --git a/read-cache.c b/read-cache.c
index b0276fd55..db7a812af 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2193,14 +2193,16 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	int ret = do_write_index(istate, &lock->tempfile, 0);
 	if (ret)
 		return ret;
+
+	/* Callers must specify exactly one of COMMIT/CLOSE */
 	assert((flags & (COMMIT_LOCK | CLOSE_LOCK)) !=
 	       (COMMIT_LOCK | CLOSE_LOCK));
+	assert((flags & (COMMIT_LOCK | CLOSE_LOCK)) != 0);
+
 	if (flags & COMMIT_LOCK)
 		return commit_locked_index(lock);
-	else if (flags & CLOSE_LOCK)
-		return close_lock_file(lock);
 	else
-		return ret;
+		return close_lock_file(lock);
 }
 
 static int write_split_index(struct index_state *istate,

We could also get rid of CLOSE_LOCK entirely at this point. Or since
these are the only two flags, just turn the flags field into a boolean
"int commit_lock". But doing it as above is perhaps more readable
(callers say CLOSE_LOCK instead of an unannotated "0"), and the extra
assert will catch any topics in flight that add calls using "0" for
flags.

-Peff
