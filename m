Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E72C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 04:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 920EA2070A
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 04:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbhA0D6I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:58:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:39998 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388287AbhAZXVU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 18:21:20 -0500
Received: (qmail 27995 invoked by uid 109); 26 Jan 2021 23:20:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Jan 2021 23:20:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5215 invoked by uid 111); 26 Jan 2021 23:20:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Jan 2021 18:20:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Jan 2021 18:20:34 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v5 1/3] ls-refs: report unborn targets of symrefs
Message-ID: <YBCjwoc5LUrk3GBA@coredump.intra.peff.net>
References: <20201208013121.677494-1-jonathantanmy@google.com>
 <cover.1611686656.git.jonathantanmy@google.com>
 <32e16dfdbd3f54c0d4b39cbd555e66aa3950fffd.1611686656.git.jonathantanmy@google.com>
 <xmqq8s8f1iqe.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8s8f1iqe.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 26, 2021 at 01:38:49PM -0800, Junio C Hamano wrote:

> > @@ -103,14 +131,31 @@ int ls_refs(struct repository *r, struct strvec *keys,
> >  			data.symrefs = 1;
> >  		else if (skip_prefix(arg, "ref-prefix ", &out))
> >  			strvec_push(&data.prefixes, out);
> > +		else if (data.allow_unborn && !strcmp("unborn", arg))
> > +			data.unborn = 1;
> 
> I think the use of &&-cascade is iffy here.  Even when we are *not*
> accepting request for unborn, we should still parse it as such.
> This does not matter in today's code, but it is a basic courtesy for
> future developers who may add more "else if" after it.
> 
> IOW
> 
> 		else if (!strcmp("unborn", arg)) {
> 			if (!data.allow_unborn)
> 				; /* we are not accepting the request */
> 			else
> 				data.unborn = 1;
> 		}
> 
> I wrote the above in longhand only for documentation purposes; in
> practice, 
> 
> 		else if (!strcmp("unborn", arg))
>                 	data.unborn = data.allow_unborn;
> 
> may suffice.

Doing it that way is friendlier, but loosens enforcement of:

  Client will then send a space separated list of capabilities it wants
  to be in effect. The client MUST NOT ask for capabilities the server
  did not say it supports.

from Documentation/technical/protocol-capabilities.txt.

It does solve Jonathan's racy cluster-deploy problem, though. See the
discussion in the v4 thread (sorry, seems not to have hit the archive
yet, but hopefully this link will work soon):

  https://lore.kernel.org/git/YBCitNb75rpnuW2L@coredump.intra.peff.net/

-Peff
