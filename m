Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D12F1202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 05:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750798AbdJBF1B (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 01:27:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:57136 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750763AbdJBF1B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 01:27:01 -0400
Received: (qmail 6545 invoked by uid 109); 2 Oct 2017 05:27:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 05:27:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25740 invoked by uid 111); 2 Oct 2017 05:27:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 01:27:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Oct 2017 01:26:59 -0400
Date:   Mon, 2 Oct 2017 01:26:59 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/11] sha1_file: do not leak `lock_file`
Message-ID: <20171002052659.hgzkhz4sgez3mkgz@sigill.intra.peff.net>
References: <cover.1506862824.git.martin.agren@gmail.com>
 <9725917d9854a54e4daeda70940c3bb0ff5d9201.1506862824.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9725917d9854a54e4daeda70940c3bb0ff5d9201.1506862824.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 01, 2017 at 04:56:02PM +0200, Martin Ågren wrote:

> There is no longer any need to allocate and leak a `struct lock_file`.
> Initialize it on the stack instead.
> 
> Instead of setting `lock = NULL` to signal that we have already rolled
> back, and that we should not do any more work, check with
> `is_lock_file_locked()`. Since we take the lock with
> `LOCK_DIE_ON_ERROR`, it evaluates to false exactly when we have called
> `rollback_lock_file()`.

This looks correct (and is a good direction, as it drops a leak).

The original code is actually a bit confusing/unsafe, as we set the
"found" flag early and rollback here:

> @@ -481,17 +481,15 @@ void add_to_alternates_file(const char *reference)
>  		strbuf_release(&line);
>  		fclose(in);
>  
> -		if (found) {
> -			rollback_lock_file(lock);
> -			lock = NULL;
> -		}
> +		if (found)
> +			rollback_lock_file(&lock);

and that leaves the "out" filehandle dangling. It's correct because of
the later "do we still have the lock" check:

> -	if (lock) {
> +	if (is_lock_file_locked(&lock)) {
>  		fprintf_or_die(out, "%s\n", reference);

but the two spots must remain in sync. If I were writing it from scratch
I might have bumped "found" to the scope of the whole function, and then
replaced this final "do we still have the lock" with:

  if (found)
	rollback_lock_file(&lock);
  else {
	fprintf_or_die(out, "%s\n", reference);
	if (commit_lock_file(&lock))
	...etc...
  }

I don't know if it's worth changing now or not.

-Peff
