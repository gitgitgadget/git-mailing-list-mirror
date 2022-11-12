Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A71EC433FE
	for <git@archiver.kernel.org>; Sat, 12 Nov 2022 17:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbiKLRDB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Nov 2022 12:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbiKLRDA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2022 12:03:00 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C06617043
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 09:02:59 -0800 (PST)
Received: (qmail 5346 invoked by uid 109); 12 Nov 2022 17:02:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 12 Nov 2022 17:02:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21908 invoked by uid 111); 12 Nov 2022 17:02:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 12 Nov 2022 12:02:59 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 12 Nov 2022 12:02:58 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/3] pack-object: simplify --filter handling
Message-ID: <Y2/Rwvb2uiE40rW0@coredump.intra.peff.net>
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <59abb8d2-e8e6-7423-ead8-49382293aaa6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59abb8d2-e8e6-7423-ead8-49382293aaa6@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 12, 2022 at 11:44:50AM +0100, René Scharfe wrote:

> pack-objects uses OPT_PARSE_LIST_OBJECTS_FILTER_INIT() to initialize the
> a rev_info struct lazily before populating its filter member using the
> --filter option values.  It tracks whether the initialization is needed
> using the .have_revs member of the callback data.
> 
> There is a better way: Use a stand-alone list_objects_filter_options
> struct and build a rev_info struct with its .filter member after option
> parsing.  This allows using the simpler OPT_PARSE_LIST_OBJECTS_FILTER()
> and getting rid of the extra callback mechanism.

That seems like a reasonable fix (and I think we do it elsewhere). But I
wonder if it wouldn't be simpler to just unconditionally initialize the
rev_info in cmd_pack_objects(), and then unconditionally release it.
True, we _might_ not use it if we are receiving objects directly over
stdin, but I don't think initializing it is particularly costly.

And then we don't have to worry about whether it's valid (it always is),
or about copying between two representations of the filter (there's only
one).

-Peff
