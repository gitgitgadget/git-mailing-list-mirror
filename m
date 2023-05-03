Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F3BC77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 16:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjECQ3G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 12:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjECQ3D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 12:29:03 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F60C7290
        for <git@vger.kernel.org>; Wed,  3 May 2023 09:29:00 -0700 (PDT)
Received: (qmail 10289 invoked by uid 109); 3 May 2023 16:28:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 May 2023 16:28:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28537 invoked by uid 111); 3 May 2023 16:28:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 May 2023 12:28:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 3 May 2023 12:28:58 -0400
From:   Jeff King <peff@peff.net>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        newren@gmail.com
Subject: Re: [PATCH 2/6] credential-store: move related functions to
 credential-store file
Message-ID: <20230503162858.GA1789686@coredump.intra.peff.net>
References: <20230502211454.1673000-1-calvinwan@google.com>
 <20230502211454.1673000-3-calvinwan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230502211454.1673000-3-calvinwan@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 02, 2023 at 09:14:50PM +0000, Calvin Wan wrote:

> is_rfc3986_unreserved() and is_rfc3986_reserved_or_unreserved() are only
> called from builtin/credential-store.c and they are only relevant to that
> file so move those functions and make them static.

This is probably OK to do, though I think "and they are only relevant to
that file" is overstating things a bit.

They are callbacks to be used with strbuf_add_urlencode(). Originally
they were static-locals next to that function, with a flag bit to
trigger which was used.

Later, c2694952e3 (strbuf: give URL-encoding API a char predicate fn,
2019-06-27) replaced the flag with a callback mechanism, which meant the
functions had to be public. But all callers except the new one added in
that series still needed them (that other caller is not encoding a URL,
so it wants different rules).

And then finally, 644de29e22 (http: drop support for curl < 7.19.4,
2021-07-30) dropped the http.c callers, leaving only the ones in
credential-store.

So yes, it's true that only credential-store.c needs them right now. But
separating them from strbuf_add_urlencode() is making that function next
to useless for any future callers, as they'd have to reimplement the
logic about which characters are reserved. I say "next to useless",
because that one "not a URL" caller doesn't need that logic.

So I dunno. It's largely academic until somebody else needs to encode
bits of a URL. But when they do, the first thing they'd need to do is
make these functions public again.

I think the main reason we do not have other callers is that urlmatch.c
implements its own percent-encoding code, and that's where we do most of
our URL handling. It does make me wonder if credential-store could
simply switch to using that, but that is probably out of scope for your
series.

-Peff
