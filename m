Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CFD01F404
	for <e@80x24.org>; Tue, 20 Feb 2018 22:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751494AbeBTW53 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 17:57:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:58834 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750998AbeBTW53 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 17:57:29 -0500
Received: (qmail 15437 invoked by uid 109); 20 Feb 2018 22:57:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Feb 2018 22:57:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18278 invoked by uid 111); 20 Feb 2018 22:58:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 20 Feb 2018 17:58:15 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Feb 2018 17:57:27 -0500
Date:   Tue, 20 Feb 2018 17:57:27 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Question about get_cached_commit_buffer()
Message-ID: <20180220225726.GA17496@sigill.intra.peff.net>
References: <ecbbe515-b7a8-3dc8-7d14-32412e7b12c3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ecbbe515-b7a8-3dc8-7d14-32412e7b12c3@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 20, 2018 at 05:12:50PM -0500, Derrick Stolee wrote:

> In rev-list, the "--header" option outputs a value and expects the buffer to
> be cached. It outputs the header info only if get_cached_commit_buffer()
> returns a non-null buffer, giving incorrect output. If it called
> get_commit_buffer() instead, it would immediately call
> get_cached_commit_buffer() and on failure actually load the buffer.
> 
> This has not been a problem before, since the buffer was always loaded at
> some point for each commit (and saved because of the save_commit_buffer
> global).
> 
> I propose to make get_cached_commit_buffer() static to commit.c and convert
> all callers to get_commit_buffer(). Is there any reason to _not_ do this? It
> seems that there is no functional or performance change.

That helper was added in 152ff1cceb (provide helpers to access the
commit buffer, 2014-06-10). I think interesting part is the final
paragraph:

      Note that we also need to add a "get_cached" variant which
      returns NULL when we do not have a cached buffer. At first
      glance this seems to defeat the purpose of "get", which is
      to always provide a return value. However, some log code
      paths actually use the NULL-ness of commit->buffer as a
      boolean flag to decide whether to try printing the
      commit. At least for now, we want to continue supporting
      that use.

So I think a conversion to get_commit_buffer() would break the callers
that use the boolean nature for something useful. Unfortunately the
author did not enumerate exactly what those uses are, so we'll have to
dig. :)

My guess is that it has to do with showing some commits twice, since we
would normally have the buffer available the first time we hit the
commit, and then free it in finish_commit().

If we blame that rev-list line (and then walk back over a bunch of
uninteresting commits via parent re-blaming), it comes from 3131b71301
(Add "--show-all" revision walker flag for debugging, 2008-02-09).

So there it is. It does show commits multiple times, but suppresses the
verbose header after the first showing. If we do something like this:

  git rev-list --show-all --pretty --boundary c93150cfb0^-

you'll see some boundary commits that _don't_ have their pretty headers
shown. And with your proposed patch, we'd show them again. To keep the
same behavior we need to store that "we've already seen this" boolean
somewhere else (e.g., in an object flag; possibly SEEN, but that might
run afoul of other logic).

It looks like the call in log-tree comes from the same commit, and
serves the same purpose.

Aside from storing the boolean "did we show it" in another way, the
other option is to simply change the behavior and accept that we might
pretty-print the commit twice. This is a backwards-incompatible change,
but I'm not sure if anybody would care. According to that commit,
--show-all was added explicitly for debugging, and it has never been
documented.  I couldn't find any reference to people actually using it
on the list (a grep of the whole archive turns up 32 messages, most of
which are just it appearing in context; the only person mentioning its
actual use was Linus in 2008.

-Peff
