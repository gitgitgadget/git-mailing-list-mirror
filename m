Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EC4C433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 20:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB1261A19
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 20:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238119AbhCXUnp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 16:43:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:48006 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238052AbhCXUnR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 16:43:17 -0400
Received: (qmail 15237 invoked by uid 109); 24 Mar 2021 20:43:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Mar 2021 20:43:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21736 invoked by uid 111); 24 Mar 2021 20:43:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Mar 2021 16:43:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 24 Mar 2021 16:43:15 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v4 05/10] userdiff: add and use for_each_userdiff_driver()
Message-ID: <YFukY9XZkO1vRYZC@coredump.intra.peff.net>
References: <20210224195129.4004-1-avarab@gmail.com>
 <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
 <patch-05.11-64ea5e8443f-20210324T014604Z-avarab@gmail.com>
 <YFuPMMMYicFK6A/S@coredump.intra.peff.net>
 <xmqqsg4kxr38.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqsg4kxr38.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 24, 2021 at 12:57:15PM -0700, Junio C Hamano wrote:

> And while "type" could also be made a part of this structure and
> have the API always iterate over all entries regardless of "type",
> i.e. the callback function could be the one responsible for finding
> the entries in the table for one particular type, it is understandable
> that potential callers can be helped by having the pre-filtering
> based on the "type" thing on the API side.

Yeah. We _could_ also have the for-each function filter by name (if
present). And then quit when it finds a matching name (because it knows
the names are supposed to be unique).

That is the opposite of:

> Or a single for_each_driver() that gives <name, length, type> tuple
> to the callback function, iterating over all drivers regardless of
> the type.

I'd be fine with that, too. I don't have a huge preference either way,
but it does feel like it would fix the weird asymmetry (though as I
said, I don't think the asymmetry is _wrong_, and it may not be worth
over-engineering this tiny corner of the interface).

Thanks for spelling out both of these directions clearly. My response to
Ævar was a little muddled as I was having trouble figuring out just what
it was that left me so puzzled by the patch. :)


By the way, one thing I wondered about all of this: could we have an
entry in both the custom and builtin lists? I think the answer is "no",
because any custom config for a builtin type would get placed inside the
existing struct in the builtin_drivers array (which is sadly a reason we
must leak any old string values when we parse diff.*.funcname, etc; we
don't know if they are string literals or heap values from previously
parsed config).

I also notice that the "builtin" for-each does not count the boolean
"diff" or "!diff" attribute structs. That is perhaps reasonable, as they
do not have interesting names nor values in the first place. I do still
wonder whether "builtin vs custom" is even a useful distinction (i.e.,
those builtins are less builtin_drivers[] than drivers[]).

-Peff
