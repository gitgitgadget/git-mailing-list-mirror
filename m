Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF7DC636D3
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 23:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjBAX7d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 18:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjBAX7c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 18:59:32 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D7048A08
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 15:59:30 -0800 (PST)
Received: (qmail 6987 invoked by uid 109); 1 Feb 2023 23:59:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Feb 2023 23:59:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25871 invoked by uid 111); 1 Feb 2023 23:59:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Feb 2023 18:59:29 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Feb 2023 18:59:29 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH] imap-send: replace auto-probe libcurl with hard
 dependency
Message-ID: <Y9r84bezJ0scapwC@coredump.intra.peff.net>
References: <20230201113133.10195-2-worldhello.net@gmail.com>
 <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com>
 <xmqqlelhx973.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqlelhx973.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 01, 2023 at 03:22:24PM -0800, Junio C Hamano wrote:

> > Let's also hide the old --curl and --no-curl options, and die if
> > "--no-curl" is provided.
> 
> In other words, if we are building imap-send, we sure know cURL is
> there, and there is no need to tell a running imap-send not to use
> cURL to talk to the IMAP service?  I am not sure the linkage of this
> change with the rest of the patch.  Isn't that a totally orthogonal
> issue?  Your imap-send might be cURL enabled, but unless we stop to
> ship with our own IMAP routines compiled into imap-send, --no-curl
> does have a purpose.
> 
> Or did you just forget to document that we stop to ship with our own
> IMAP routines in the above?  If so, as long as it is made a bit more
> prominent in the proposed log message in a reroll, I would be happy
> with such a change rolled into the same patch.

FWIW, I had the same urge as Ævar, to drop the non-curl support
completely, and was puzzled that his patch did not have a big code
deletion. ;)

The problem is that the tunnel mode still relies on the non-curl code.
There was a series to address that a while ago:

  https://lore.kernel.org/git/ab866314-608b-eaca-b335-12cffe165526@morey-chaisemartin.com/

but it ran into the problem that curl did not support PREAUTH
connections (which is one of the main points of tunneling). It looks
like that got added to curl via their befaa7b14f, which is in curl
7.56.0 from 2017. That's not old enough for us to require for http, but
might be OK for a marginal component like the tunneling mode of
imap-send.

I think there was also some question of how you even get the tunnel
going. Curl really wants to have a single socket descriptor, not two
pipe descriptors, so there may have to be some trickery with
socketpair(). There's more discussion in the linked thread.

So I think there's a path forward here for getting rid of the legacy
code (and I'd be really happy to see it gone; it's imported code that
does not seem super well maintained by us). But until we do that,
disabling --no-curl doesn't seem like that big a win, if that code can
all still be triggered for tunnel mode.

-Peff
