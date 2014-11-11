From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 02/15] refs.c: return error instead of dying when locking
 fails during transaction
Date: Tue, 11 Nov 2014 05:34:49 -0500
Message-ID: <20141111103449.GA8371@peff.net>
References: <1413923820-14457-1-git-send-email-sahlberg@google.com>
 <1413923820-14457-3-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 11:35:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xo8mo-0001Si-Q1
	for gcvg-git-2@plane.gmane.org; Tue, 11 Nov 2014 11:34:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbaKKKey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2014 05:34:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:39021 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753263AbaKKKex (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2014 05:34:53 -0500
Received: (qmail 1835 invoked by uid 102); 11 Nov 2014 10:34:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Nov 2014 04:34:53 -0600
Received: (qmail 19105 invoked by uid 107); 11 Nov 2014 10:35:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Nov 2014 05:35:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Nov 2014 05:34:49 -0500
Content-Disposition: inline
In-Reply-To: <1413923820-14457-3-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 21, 2014 at 01:36:47PM -0700, Ronnie Sahlberg wrote:

> commit e193c10fc4f9274d1e751cfcdcc4507818e8d498 upstream.
> 
> Change lock_ref_sha1_basic to return an error instead of dying when
> we fail to lock a file during a transaction.
> This function is only called from transaction_commit() and it knows how
> to handle these failures.
> [...]
> -		else
> -			unable_to_lock_die(ref_file, errno);
> +		else {
> +			struct strbuf err = STRBUF_INIT;
> +			unable_to_lock_message(ref_file, errno, &err);
> +			error("%s", err.buf);
> +			strbuf_reset(&err);
> +			goto error_return;
> +		}

I coincidentally just wrote almost the identical patch, because this
isn't just a cleanup; it fixes a real bug. During pack_refs, we call
prune_ref to lock and delete the loose ref. If the lock fails, that's
OK; that just means somebody else is updating it at the same time, and
we can skip our pruning step. But due to the unable_to_lock_die call
here in lock_ref_sha1_basic, the pack-refs process may die prematurely.

I wonder if it is worth pulling this one out from the rest of the
series, as it has value (and can be applied) on its own. I did some
digging on the history of this, too. Here's the rationale I wrote:


    lock_ref_sha1_basic: do not die on locking errors
    
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

I also have some other cleanups to lock_ref_sha1_basic's error handling.
I'd be happy to take over this patch and send it along with those
cleanups as a separate series.

-Peff
