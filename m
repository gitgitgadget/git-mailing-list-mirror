Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 059AB20285
	for <e@80x24.org>; Thu, 24 Aug 2017 14:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753422AbdHXOoT (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 10:44:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:48004 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753021AbdHXOoH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 10:44:07 -0400
Received: (qmail 19787 invoked by uid 109); 24 Aug 2017 14:44:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Aug 2017 14:44:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10351 invoked by uid 111); 24 Aug 2017 14:44:35 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Aug 2017 10:44:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Aug 2017 07:44:04 -0700
Date:   Thu, 24 Aug 2017 07:44:04 -0700
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] Retry acquiring reference locks for 100ms
Message-ID: <20170824144403.lxpgenqfgt7r3mrr@sigill.intra.peff.net>
References: <030b6bb22973df429ddbb64a079b9cdc1fbcb1b7.1503313472.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <030b6bb22973df429ddbb64a079b9cdc1fbcb1b7.1503313472.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 21, 2017 at 01:51:34PM +0200, Michael Haggerty wrote:

> The philosophy of reference locking has been, "if another process is
> changing a reference, then whatever I'm trying to do to it will
> probably fail anyway because my old-SHA-1 value is probably no longer
> current". But this argument falls down if the other process has locked
> the reference to do something that doesn't actually change the value
> of the reference, such as `pack-refs` or `reflog expire`. There
> actually *is* a decent chance that a planned reference update will
> still be able to go through after the other process has released the
> lock.
> 
> So when trying to lock an individual reference (e.g., when creating
> "refs/heads/master.lock"), if it is already locked, then retry the
> lock acquisition for approximately 100 ms before giving up. This
> should eliminate some unnecessary lock conflicts without wasting a lot
> of time.

It will probably comes as little surprise to others on the list that
I agree with the intent of this patch. This version is cleaned up a
little from what we're running at GitHub right now, so I'll try to
review with fresh eyes.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index d5c9c4cab6..2c04b9dfb4 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -776,6 +776,12 @@ core.commentChar::
>  If set to "auto", `git-commit` would select a character that is not
>  the beginning character of any line in existing commit messages.
>  
> +core.filesRefLockTimeout::
> +	The length of time, in milliseconds, to retry when trying to
> +	lock an individual reference. Value 0 means not to retry at
> +	all; -1 means to try indefinitely. Default is 100 (i.e.,
> +	retry for 100ms).
> +
>  core.packedRefsTimeout::
>  	The length of time, in milliseconds, to retry when trying to
>  	lock the `packed-refs` file. Value 0 means not to retry at

Do we need a separate config from packedRefsTimeout that is in the
context? I guess so, since the default values are different. And
rightfully so, I think, since writing a packed-refs file is potentially
a much larger operation (being O(n) in the number of refs rather than a
constant 40 bytes).

It probably doesn't matter all that much either way, as I wouldn't
expect people to need to tweak either of these in practice.

At some point when we have another ref backend that needs to take a
global lock, we'd probably have a third timeout. If we were starting
from scratch, I'd suggest that these might be part of refstorage.files.*
instead of core.*. And then eventually we might have
refstorage.reftable.timeout, refstorage.lmdb.timeout, etc.

But since core.packedRefsTimeout has already sailed, I'm not sure it's
worth caring about.

> diff --git a/refs.c b/refs.c
> index fe4c59aa8b..29dbb9b610 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -561,6 +561,21 @@ enum ref_type ref_type(const char *refname)
>         return REF_TYPE_NORMAL;
>  }
>  
> +long get_files_ref_lock_timeout_ms(void)
> +{
> +	static int configured = 0;
> +
> +	/* The default timeout is 100 ms: */
> +	static int timeout_ms = 100;
> +
> +	if (!configured) {
> +		git_config_get_int("core.filesreflocktimeout", &timeout_ms);
> +		configured = 1;
> +	}
> +
> +	return timeout_ms;
> +}

This reads the config value into a static local that gets cached for the
rest of the program run, and there's no way to invalidate the cache. I
think that should be OK, as we would never hit the ref code until we've
actually initialized the repository, at which point we're fairly well
committed.

(I'm a little gun-shy because I used a similar lazy-load pattern for
core.sharedrepository a while back, and those corner cases bit us. But
there it was heavily used by git-init, which wants to "switch" repos
after having loaded some values).

> @@ -573,7 +588,9 @@ static int write_pseudoref(const char *pseudoref, const unsigned char *sha1,
>  	strbuf_addf(&buf, "%s\n", sha1_to_hex(sha1));
>  
>  	filename = git_path("%s", pseudoref);
> -	fd = hold_lock_file_for_update(&lock, filename, LOCK_DIE_ON_ERROR);
> +	fd = hold_lock_file_for_update_timeout(&lock, filename,
> +					       LOCK_DIE_ON_ERROR,
> +					       get_files_ref_lock_timeout_ms());
>  	if (fd < 0) {
>  		strbuf_addf(err, "could not open '%s' for writing: %s",
>  			    filename, strerror(errno));

The rest of the patch looks obviously correct to me. The one thing I
didn't audit for was whether there were any calls that _should_ be
changed that you missed. But I'm pretty sure based on our previous
off-list discussions that you just did that audit.

Obviously new ref-locking calls would want to use the timeout variant
here, too, and we need to remember to do so. But I don't think there
should be many, as most sites should be going through create_reflock()
or lock_raw_ref(), which you touch here.

-Peff
