Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA4BC43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 00:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E04F206D4
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 00:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgIQAzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 20:55:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:59464 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgIQAzL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 20:55:11 -0400
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 20:55:10 EDT
Received: (qmail 28483 invoked by uid 109); 17 Sep 2020 00:48:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 17 Sep 2020 00:48:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3595 invoked by uid 111); 17 Sep 2020 00:48:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Sep 2020 20:48:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Sep 2020 20:48:28 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Riesen <alexander.riesen@cetitec.com>, git@vger.kernel.org,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] config: option transfer.ipversion to set transport
 protocol version for network fetches
Message-ID: <20200917004828.GA2442845@coredump.intra.peff.net>
References: <20200915135428.GA28038@pflmari>
 <xmqqtuvxwkbz.fsf@gitster.c.googlers.com>
 <20200916201830.GA44969@coredump.intra.peff.net>
 <xmqqbli5uyj4.fsf@gitster.c.googlers.com>
 <xmqq4knxuyfz.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4knxuyfz.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 16, 2020 at 03:52:16PM -0700, Junio C Hamano wrote:

> >> Adding a command-line option for "all" is a good idea, but will probably
> >> mean needing to add the "unset" sentinel value I mentioned in the other
> >> email.
> >
> > Sorry, I do not quite follow.  I thought that assigning the
> > (misnamed --- see other mail) ALL to the "family" variable would be
> > sufficient?
> >
> >     enum transport_family {
> >             TRANSPORT_FAMILY_ALL = 0,
> >             TRANSPORT_FAMILY_IPV4,
> >             TRANSPORT_FAMILY_IPV6
> >     };
> 
> Ah, I see.  We want a way to tell "nobody has set it from the command
> line or the config" and "we were explicitly told to accept any"
> apart.
> 
> But wouldn't the usual "read config first and then override from the
> command line" handle that without "not yet set" value?  I thought we
> by default accept any.

It would, if each individual program does it in that order. But that
means every caller of the transport code needs to be updated to handle
the config. That might not be that bad (after all, they have to take
--ipv6 etc, options, and I guess they'd need a new "any" option).

My suggestion elsewhere was to have an "unset" value, and then resolve
it at the time-of-use, something like:

diff --git a/transport.c b/transport.c
index 43e24bf1e5..6414a847ae 100644
--- a/transport.c
+++ b/transport.c
@@ -248,6 +248,9 @@ static int connect_setup(struct transport *transport, int for_push)
 	if (data->conn)
 		return 0;
 
+	if (transport->family == TRANSPORT_FAMILY_UNSET)
+		transport->family = transport_family_config;
+
 	switch (transport->family) {
 	case TRANSPORT_FAMILY_ALL: break;
 	case TRANSPORT_FAMILY_IPV4: flags |= CONNECT_IPV4; break;

but I am happy either way as long as the code does the right thing.

-Peff
