Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E483FC433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 17:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiGARyA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 13:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiGARx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 13:53:59 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBB03B002
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 10:53:57 -0700 (PDT)
Received: (qmail 9515 invoked by uid 109); 1 Jul 2022 17:53:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 Jul 2022 17:53:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27454 invoked by uid 111); 1 Jul 2022 17:53:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Jul 2022 13:53:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 Jul 2022 13:53:55 -0400
From:   Jeff King <peff@peff.net>
To:     Roland Illig <roland.illig@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: undefined behavior in builtin/am.c
Message-ID: <Yr80s8VP8ECCXKd+@coredump.intra.peff.net>
References: <130c3636-b978-1600-df53-6a38c3414a88@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <130c3636-b978-1600-df53-6a38c3414a88@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 01, 2022 at 07:03:18PM +0200, Roland Illig wrote:

> The macro 'isspace' must only be called with an integer representable as
> an 'unsigned char', or with the value of the macro EOF.
> 
> On platforms where plain 'char' is a signed integer type, any character
> whose value is negative invokes undefined behavior (except for the one
> character that by coincidence has the same value as the macro EOF).
> 
> To fix this, write '!isspace((unsigned char)*str)' instead.
> 
> I have no idea how to trigger this part of the code but for someone who
> knows this part of Git, it should be easy. Depending on the platform,
> this kind of error may be silently ignored or crash the program, as
> always with undefined behavior.

We don't use the system isspace(), but instead our own macro wrappers in
git-compat-util.h. They do the cast to unsigned char themselves.

I won't be surprised if re-defining a system name as a macro is also
technically undefined behavior, but I don't think we've found a system
that has a problem with it in the past 17 years. :)

-Peff
