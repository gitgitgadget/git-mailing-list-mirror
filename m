Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C25FC28CBC
	for <git@archiver.kernel.org>; Sun,  3 May 2020 10:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3177E206A5
	for <git@archiver.kernel.org>; Sun,  3 May 2020 10:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgECKG2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 May 2020 06:06:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:35088 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727971AbgECKG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 May 2020 06:06:28 -0400
Received: (qmail 22471 invoked by uid 109); 3 May 2020 10:06:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 03 May 2020 10:06:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5006 invoked by uid 111); 3 May 2020 10:06:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 03 May 2020 06:06:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 3 May 2020 06:06:27 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        jrnieder@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v10] credential-store: ignore bogus lines from store file
Message-ID: <20200503100627.GA171296@coredump.intra.peff.net>
References: <20200430160642.90096-1-carenas@gmail.com>
 <20200502181643.38203-1-carenas@gmail.com>
 <xmqqo8r6jc8i.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo8r6jc8i.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 02, 2020 at 01:47:09PM -0700, Junio C Hamano wrote:

> > As a special case, flag files with CRLF endings as invalid early
> > to prevent current problems in credential_from_url_gently() with
> > handling of '\r' in the host.
> 
> I do not think it hurts to silently ignore a line that ends with CR,
> but only because I do not think credential_from_url_gently() would
> not match such a line when asked to match something without
> complaining.

I wondered if we might hit a case where the CR ends up in the path,
like:

  $ printf 'https://user:pass@example.com/\r\n' >creds
  $ echo url=https://example.com/ |
    git credential-store --file=creds get
  username=user
  password=pass

because the path is parsed as missing in the incoming pattern (and thus
we match any path, even "\r").

But credential-store would never write such a path in the first place.
Even with the trailing slash on an incoming URL, it will write:

  https://example.com

without a slash at all (and thus any inserted CR would be part of the
hostname). So somebody would have to have inserted it themselves, or
have turned useHTTPPath on (in which case we _would_ complain on the
matching side, too, because we'd try matching the path with a CR in it).

I think it's reasonable to assume that any CR would have been a problem
even in older versions.

-Peff
