Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98A1C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 08:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD44361059
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 08:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244656AbhIBIpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 04:45:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:37212 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233391AbhIBIpX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 04:45:23 -0400
Received: (qmail 21682 invoked by uid 109); 2 Sep 2021 08:44:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Sep 2021 08:44:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22481 invoked by uid 111); 2 Sep 2021 08:44:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Sep 2021 04:44:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 2 Sep 2021 04:44:23 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, patrick.reynolds@github.com
Subject: Re: [PATCH] remote: avoid -Wunused-but-set-variable in gcc with
 -DNDEBUG
Message-ID: <YTCO56kbtQbODDeK@coredump.intra.peff.net>
References: <20210902073631.50062-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210902073631.50062-1-carenas@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 02, 2021 at 12:36:31AM -0700, Carlo Marcelo Arenas Belón wrote:

> d0da003d5b (use a hashmap to make remotes faster, 2014-07-29) adds
> an assert to check that the key added to remote hashmap was unique,
> which should never trigger, unless this function is used incorrectly.

I'm not sure "unless this function is used incorrectly" is accurate,
assuming you mean make_remote() as "this function". The first half of
the function checks that the key is not present, and adds it only if
that is not true.

So there is no way to call make_remote() that will trigger the
assertion. It is making sure there is not a bug within make_remote(),
but IMHO the primary function is documenting the expectation.

I.e., I think this would serve a similar purpose:

  /*
   * don't bother checking return; we know there was nothing to
   * overwrite, since we would have found it above and returned
   * early.
   */
  hashmap_put_entry(&remotes_hash, ret, ent);

But assert()/BUG() is shorter to type _and_ gives a run-time guarantee
for cheap, so I think one of those is nicer.

> this breaks the build with -DNDEBUG because the assert gets compiled
> out and therefore the variable used to check is never used

Right, this is the real point of the patch. Compiling with NDEBUG will
result in a warning.

> remote it and use instead a BUG(), which just like the assert is
> not expected to trigger, but will stay put and report regardless of
> how the code is compiled.

And the solution to switch to a BUG() is good, I think. We just ignore
NDEBUG then. But then we do not have to talk about "should never
trigger" at all. The point is that we are swapping one assertion
mechanism for another, because the new one does not trigger the compiler
warning.

> @@ -162,8 +162,8 @@ static struct remote *make_remote(const char *name, int len)
>  	remotes[remotes_nr++] = ret;
>  
>  	hashmap_entry_init(&ret->ent, lookup_entry.hash);
> -	replaced = hashmap_put_entry(&remotes_hash, ret, ent);
> -	assert(replaced == NULL);  /* no previous entry overwritten */
> +	if (hashmap_put_entry(&remotes_hash, ret, ent))
> +		BUG("A remote hash collition was detected");

This BUG() text didn't really enlighten me. It's not a hash collision,
but rather a duplicate key (you could perhaps call that a collision, but
usually "hash collision" refers to an overlap caused by reducing the
data to a hash).

Something like:

  BUG("hashmap_put overwrote entry after hashmap_get returned NULL");

That's a bit obscure if a user saw it. But the point is they're not
supposed to. The primary audience here is developers who want to
understand what is being asserted.

-Peff
