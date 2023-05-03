Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647F5C7EE21
	for <git@archiver.kernel.org>; Wed,  3 May 2023 16:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjECQet (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 12:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjECQes (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 12:34:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD483ABC
        for <git@vger.kernel.org>; Wed,  3 May 2023 09:34:47 -0700 (PDT)
Received: (qmail 10495 invoked by uid 109); 3 May 2023 16:34:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 May 2023 16:34:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28573 invoked by uid 111); 3 May 2023 16:34:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 May 2023 12:34:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 3 May 2023 12:34:46 -0400
From:   Jeff King <peff@peff.net>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        newren@gmail.com
Subject: Re: [PATCH 2/6] credential-store: move related functions to
 credential-store file
Message-ID: <20230503163446.GB1789686@coredump.intra.peff.net>
References: <20230502211454.1673000-1-calvinwan@google.com>
 <20230502211454.1673000-3-calvinwan@google.com>
 <20230503162858.GA1789686@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230503162858.GA1789686@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 03, 2023 at 12:28:58PM -0400, Jeff King wrote:

> I think the main reason we do not have other callers is that urlmatch.c
> implements its own percent-encoding code, and that's where we do most of
> our URL handling. It does make me wonder if credential-store could
> simply switch to using that, but that is probably out of scope for your
> series.

Poking at it a bit, I think the answer is "not easily". credential-store
has broken-out elements of a URL, and wants to turn them back into one.
And urlmatch.c's url_normalize() always takes a URL string as input.
Even though it finds the broken-out fields as part of its work, the
parsing and reconstruction of the URL are inter-mingled in a complex
way (i.e., it's not just "parse it, then turn the fields back into a
normalized string).

I'm sure it could be refactored, but it's probably not worth it (and
again, this tangent is somewhat orthogonal to your series, except that
it would make these is_rfc3986 functions go away entirely).

-Peff
