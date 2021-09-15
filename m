Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3163BC433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 166626103C
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhIOQ0q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 12:26:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:48054 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhIOQ0p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 12:26:45 -0400
Received: (qmail 32335 invoked by uid 109); 15 Sep 2021 16:25:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Sep 2021 16:25:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25043 invoked by uid 111); 15 Sep 2021 16:25:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Sep 2021 12:25:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Sep 2021 12:25:24 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 11/11] ls-refs: reject unknown arguments
Message-ID: <YUIedCI/KR3zrTA8@coredump.intra.peff.net>
References: <YUE1alo58cGyTw6/@coredump.intra.peff.net>
 <YUE2J74PP8TGthOZ@coredump.intra.peff.net>
 <875yv2ofkq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875yv2ofkq.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 15, 2021 at 02:09:16AM +0200, Ævar Arnfjörð Bjarmason wrote:

> So the below patch isn't anywhere near applying, but you can see the
> test coverage (those tests are new) & what changes if we instrument a
> client to actually send this bad data.
> 
> That packet_client_error() function is new, part of what I'm doing there
> is converting all of this error emitting from die() to properly sending
> ERR packets.

Right, I noticed that none of this is likely to make it to a client
(unless they are using file:// or an ssh channel which passes back
stderr).

I agree that we should probably be passing these back via ERR packets,
but note that the client is racy here. If the server reports an error
and dies while the client is still writing, they'll see SIGPIPE and exit
without showing the user the ERR packet. The solution may be something
along these lines:

  https://public-inbox.org/git/20200422163357.27056-1-chriscool@tuxfamily.org/

Alternatively, the server can pump the client data to /dev/null until we
hit a flush, and _then_ write the ERR. But that doesn't work for some
protocol-level errors (like "oops, I'm having trouble reading your
pkt-lines).

> I think a bug in your versio is that you're using _() here, if your
> server program happens to be started in Chinese you probably still want
> to emit errors to clients in LANG=C.

I'm not sure it's a bug. If you set LANG=zh on your server, that might
be harmful (if you serve a multi-lingual international audience), or it
might be helpful (if it's a company server where everybody speaks the
language). Likewise, for a file:// or ssh:// operation, your local LANG
would kick in.

I don't really have a strong opinion either way on whether it's helpful
or hindering overall. But I did follow the convention of nearby code in
this series, so I think we don't need to worry about it now (it also
seemed inconsistent to me; serve.c does not mark for translation, but
ls-refs.c does).

> Of course that actually working is subject to various races that I may
> or may not be able to untangle...

Oh good, so you know about them. :)

-Peff
