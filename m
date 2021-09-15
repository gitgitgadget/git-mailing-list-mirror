Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FA8C433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3F9F61216
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhIOQ6q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 12:58:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:48176 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhIOQ6o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 12:58:44 -0400
Received: (qmail 32520 invoked by uid 109); 15 Sep 2021 16:57:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Sep 2021 16:57:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25477 invoked by uid 111); 15 Sep 2021 16:57:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Sep 2021 12:57:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Sep 2021 12:57:22 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 03/11] serve: add "receive" method for v2 capabilities
 table
Message-ID: <YUIl8hhzi3aE1FA/@coredump.intra.peff.net>
References: <YUE1alo58cGyTw6/@coredump.intra.peff.net>
 <YUE1fGZc1FuuyUNH@coredump.intra.peff.net>
 <xmqqpmt9yeo7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpmt9yeo7.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 15, 2021 at 09:41:28AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +	/*
> > +	 * Function called when a client requests the capability as a
> > +	 * non-command. This may be NULL if the capability does nothing.
> > +	 *
> > +	 * For a capability of the form "foo=bar", the value string points to
> > +	 * the content after the "=" (i.e., "bar"). For simple capabilities
> > +	 * (just "foo"), it is NULL.
> > +	 */
> > +	void (*receive)(struct repository *r, const char *value);
> 
> What does "as a non-command" mean?  To put it another way, when a
> client requests the capability as a command, what does the receive
> method do differently?

For each entry in this capability table, clients can say:

  command=foo

or just:

  foo

The latter is a non-command. The "receive" function is not called at all
if it is a "command". I think this is a bit more clear when read
together with the existing function just above (which you can't see in
the diff context):

        /*
         * Function called when a client requests the capability as a command.
         * Will be provided a struct packet_reader 'request' which it should
         * use to read the command specific part of the request.  Every command
         * MUST read until a flush packet is seen before sending a response.
         *
         * This field should be NULL for capabilities which are not commands.
         */
        int (*command)(struct repository *r, struct packet_reader *request);

I guess these could define "as a command", but I think it's pretty clear
in the context.

> >  static int parse_command(const char *key, struct protocol_capability **command)
> > @@ -262,7 +277,7 @@ static int process_request(void)
> >  		case PACKET_READ_NORMAL:
> >  			/* collect request; a sequence of keys and values */
> 
> The comment tentatively gets slightly stale here, but that will be
> corrected at the end, so it would be fine ;-)

Hmm. I think it is not stale here, as we are still collecting the "keys"
strvec. But it _does_ get stale by the end, when we stop doing so.

I'm preparing a re-roll for the test issues Eric noted, so I'll drop
that comment in the appropriate patch.

-Peff
