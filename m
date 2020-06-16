Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E2EC433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 08:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEFC8206F1
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 08:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgFPICF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:02:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:60992 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbgFPICB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 04:02:01 -0400
Received: (qmail 19689 invoked by uid 109); 16 Jun 2020 08:02:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Jun 2020 08:02:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10508 invoked by uid 111); 16 Jun 2020 08:02:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Jun 2020 04:02:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Jun 2020 04:02:00 -0400
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org
Subject: Re: [Possible Bug] Use of write on size-limited platforms
Message-ID: <20200616080200.GA650578@coredump.intra.peff.net>
References: <015c01d63ddd$97d65080$c782f180$@nexbridge.com>
 <20200615215937.GA636737@coredump.intra.peff.net>
 <002801d64365$b6fdc2d0$24f94870$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <002801d64365$b6fdc2d0$24f94870$@nexbridge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 15, 2020 at 06:38:34PM -0400, Randall S. Becker wrote:

> > So I think this really ought to be using write_in_full(). There's only one caller,
> > and I think it would be improved by the switch. Do you want to write a
> > patch?
> > 
> > You could make an argument that the fwrite() version ought to also loop,
> > since it's possible to get a partial write there, too. But we don't do that in
> > general. I suspect in practice most stdio implementations will keep writing
> > until they see an error, and most callers don't bother checking stdio errors at
> > all, or use ferror().
> 
> I'll give the patch a go. It is very simple. Would you suggest
> removing the strbuf_write_fd() as part of this patch since it only
> impacts bugreport.c?

I could go either way on that. IMHO it isn't offering much over a bare
write_in_full() call. The "don't call write() if there are 0 bytes"
logic is part of write_in_full() already.

-Peff
