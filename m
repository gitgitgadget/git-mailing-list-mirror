Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3375720401
	for <e@80x24.org>; Sat, 24 Jun 2017 12:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751276AbdFXMsR (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 08:48:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:51838 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750817AbdFXMsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 08:48:16 -0400
Received: (qmail 2698 invoked by uid 109); 24 Jun 2017 12:48:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 24 Jun 2017 12:48:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23668 invoked by uid 111); 24 Jun 2017 12:48:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 24 Jun 2017 08:48:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Jun 2017 08:48:14 -0400
Date:   Sat, 24 Jun 2017 08:48:14 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 7/8] sha1_file: do not access pack if unneeded
Message-ID: <20170624124813.wajhxkrqhw4xoee4@sigill.intra.peff.net>
References: <cover.1497920092.git.jonathantanmy@google.com>
 <cover.1497035376.git.jonathantanmy@google.com>
 <cover.1497920092.git.jonathantanmy@google.com>
 <fb656dfeb96e3c69f612fed924d0d9dec592c772.1497920092.git.jonathantanmy@google.com>
 <xmqq8tklqkbe.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8tklqkbe.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2017 at 11:15:01AM -0700, Junio C Hamano wrote:

> > +	if (!oi->typep && !oi->sizep && !oi->disk_sizep &&
> > +	    !oi->delta_base_sha1 && !oi->typename && !oi->contentp &&
> > +	    !oi->populate_u) {
> > +		oi->whence = OI_PACKED;
> > +		return 0;
> > +	}
> > +
> 
> ... this "if" statement feels like a maintenance nightmare.  The
> intent of the guard, I think, is "when the call wants absolutely
> nothing but whence", but the implementation of the guard will not
> stay true to the intent whenever somebody adds a new field to oi.
> 
> I wonder if it makes more sense to have a new field "whence_only",
> which is set only by such a specialized caller, which this guard
> checks (and no other fields).

The other nice thing about whence_only is that it flips the logic. So
any existing callers which depend on filling the union automatically
will not be affected (though I would be surprised if there are any such
callers; most of that information isn't actually that interesting).

-Peff
