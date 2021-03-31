Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0607CC433C1
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 06:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7373619BC
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 06:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbhCaG7P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 02:59:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:38340 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233881AbhCaG6y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 02:58:54 -0400
Received: (qmail 27059 invoked by uid 109); 31 Mar 2021 06:58:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 31 Mar 2021 06:58:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1775 invoked by uid 111); 31 Mar 2021 06:58:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Mar 2021 02:58:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Mar 2021 02:58:46 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 4/5] Makefile: add the ".DELETE_ON_ERROR" flag
Message-ID: <YGQdpkHAcFR/zNOx@coredump.intra.peff.net>
References: <20210307132001.7485-1-avarab@gmail.com>
 <cover-0.6-00000000000-20210329T161723Z-avarab@gmail.com>
 <patch-4.6-2ff6359c273-20210329T161723Z-avarab@gmail.com>
 <xmqqblb1kd47.fsf@gitster.g>
 <87a6qlmt9f.fsf@evledraar.gmail.com>
 <YGM/i+k4r0q8FKg2@coredump.intra.peff.net>
 <xmqqft0cebft.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqft0cebft.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 30, 2021 at 11:36:06AM -0700, Junio C Hamano wrote:

> > Yes, I think it's fine to treat it as "nice if we have it, but OK
> > otherwise". But also, .DELETE_ON_ERROR first shows up in the GNU make
> > git repository in version 3.71.5 from 1994. So I think we can probably
> > just assume it's everywhere.
> 
> OK.  That raises my hopes up that we may be able to simplify things
> like this
> 
>     config-list.h:
>             $(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh \
>                     >$@+ && mv $@+ $@
> 
> into
> 
>     config-list.h:
>             $(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh >$@

Yes, I think .DELETE_ON_ERROR would accomplish roughly the same thing.
Though note that it's essentially a "rollback" strategy. We create the
broken file, realize there was an error, and the roll it back (as
opposed to the "mv" strategy, which confirms everything is good before
committing it into place). This is worse than a "commit" strategy in a
few ways:

  - somebody else may racily see the broken state. I'm not too concerned
    with this, and from the rest of the thread I don't think you are
    either.

  - we may be left in the broken state if the rollback fails. Plausible
    reasons are: somebody kills "make" (I'd hope on the obvious ^C that
    it catches the signal and deletes before exiting), bug in make,
    transient OS error, power failure, etc.

I don't know how paranoid we want to be about this, especially the
latter. My general inclination is to prefer "commit" systems as more
robust, but it is just a Makefile.

-Peff
