Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC29C83F2C
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 16:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbjIEQAK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353667AbjIEHJx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 03:09:53 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673EB1B4
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 00:09:50 -0700 (PDT)
Received: (qmail 13673 invoked by uid 109); 5 Sep 2023 07:09:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 05 Sep 2023 07:09:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19721 invoked by uid 111); 5 Sep 2023 07:09:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Sep 2023 03:09:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 Sep 2023 03:09:48 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/10] parse-options: mark unused parameters in noop
 callback
Message-ID: <20230905070948.GD199565@coredump.intra.peff.net>
References: <20230831211637.GA949188@coredump.intra.peff.net>
 <20230831212220.GJ949469@coredump.intra.peff.net>
 <3bf1bd4a-9d28-32c1-7838-09acd2c85d03@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3bf1bd4a-9d28-32c1-7838-09acd2c85d03@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 02, 2023 at 01:37:08PM +0200, René Scharfe wrote:

> --- >8 ---
> Subject: [PATCH] parse-options: let NULL callback be a noop
> 
> Allow OPTION_CALLBACK options to have a NULL callback function pointer
> and do nothing in that case, yet still handle arguments as usual.  Use
> this to replace parse_opt_noop_cb().
> 
> We lose the ability to distinguish between a forgotten function pointer
> and intentional noop, but that will be caught by a compiler warning
> about an unused function in many cases and having an option do nothing
> is a benign failure mode.

Yeah, my concern would be missing an accidental NULL here. I guess that
is pretty unlikely in practice, though. I'd guess the worst case would
be somebody accidentally putting the function into the "opt->value" slot
where the compiler might then think it is used (though I don't know
off-hand if it would complain about an implicit conversion of a function
pointer into a "void *").

> We also lose the ability to add a warning to the callback, but we
> haven't done that since it was added by 6acec0380b (parseopt: add
> OPT_NOOP_NOARG, 2011-09-28), so we probably won't do it soon.  We can
> add a callback back when we want to show a warning.
> 
> By letting go of features we don't need this patch simplifies the
> parse-options API and gets rid of an exported empty function.

Your patch looks correct to me. I probably wouldn't have bothered to
write it, but now you did. :) My inclination would be to go with my
dumb-simple one for this series, and it looks like you may have
collected a few slight-more-risky-but-maybe-worthwhile parseopt cleanups
on top that could make their own series.

-Peff
