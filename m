Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6982CA0FEC
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 20:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbjIAUvu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 16:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbjIAUvu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 16:51:50 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478F71B1
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 13:51:47 -0700 (PDT)
Received: (qmail 31018 invoked by uid 109); 1 Sep 2023 20:51:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 Sep 2023 20:51:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23692 invoked by uid 111); 1 Sep 2023 20:51:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Sep 2023 16:51:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 Sep 2023 16:51:45 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] ref-filter: sort numerically when ":size" is used
Message-ID: <20230901205145.GB1960498@coredump.intra.peff.net>
References: <20230901142624.12063-1-five231003@gmail.com>
 <xmqqa5u5rgis.fsf@gitster.g>
 <20230901174540.GB1947546@coredump.intra.peff.net>
 <xmqqr0nhpyf3.fsf@gitster.g>
 <20230901183206.GA1952051@coredump.intra.peff.net>
 <ZPI0e1XzZrDV2fJk@five231003>
 <20230901191639.GA1955435@coredump.intra.peff.net>
 <xmqq7cp9prux.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7cp9prux.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 01, 2023 at 01:21:10PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But I think that is the wrong way to optimize it. We shouldn't be
> > storing any strings per-atom, but rather walking the parse tree to
> > produce a single output buffer. And the values should be cheap to fill
> > in, because we should parse the object as necessary up front. This is
> > more or less the way the pretty.c parser does it.
> 
> I thought "as necessary" may be a bit tricky as populate_value()
> were taught to omit doing the whole get_object() thing when the
> values for used_atom[] are all computable without parsing the object
> at all, but it seems that over time the populate_value() callchain
> has degraded sufficiently to unconditionally call get_object() these
> days, so I agree that the arrangement does not have much optimization
> value, at least in the current code.

No, I think we still do that optimization. When parsing the format
string, the parser function for each atom sets fields in an object_info
struct to indicate what we're interested in. Then for each ref, we call
populate_value(). If that object_info doesn't need anything (we
byte-wise compare it to an empty dummy struct), then we return early,
before calling get_object().

And that optimization is very important to retain; it makes a format
like %(refname) an order of magnitude faster.

The optimization I was referring to is that if you have a format like:

  %(contents:body) %(contents:body)

then we'll de-duplicate that to a single used_atom struct, and they'll
share the same v->s result string. That's much harder to do if you parse
into an abstract syntax tree, since the two occupy different parts of
the tree. But my contention is that it does not matter if you stop
allocating v->s in the first place, and just walk the tree to directly
output the result (either to a strbuf or directly to stdout).

-Peff
