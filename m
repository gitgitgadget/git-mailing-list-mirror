Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A42711F597
	for <e@80x24.org>; Mon,  4 Jun 2018 18:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750999AbeFDSzy (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 14:55:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:33724 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750879AbeFDSzx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 14:55:53 -0400
Received: (qmail 6830 invoked by uid 109); 4 Jun 2018 18:55:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Jun 2018 18:55:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17646 invoked by uid 111); 4 Jun 2018 18:56:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 04 Jun 2018 14:56:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Jun 2018 14:55:51 -0400
Date:   Mon, 4 Jun 2018 14:55:51 -0400
From:   Jeff King <peff@peff.net>
To:     Martin-Louis Bright <mlbright@gmail.com>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        sandals@crustytoothpaste.net, Johannes.Schindelin@gmx.de,
        pstodulk@redhat.com, nickh@reactrix.com,
        jeremy.wyman@microsoft.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC PATCH v1] http: add http.keepRejectedCredentials config
Message-ID: <20180604185551.GA4296@sigill.intra.peff.net>
References: <20180604122635.95342-1-lars.schneider@autodesk.com>
 <20180604144747.GA27655@sigill.intra.peff.net>
 <CAG2PGsoHajiYbS29F2nD+_0i2b4+Min5NR3tQYDb3MH=BW=0Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG2PGsoHajiYbS29F2nD+_0i2b4+Min5NR3tQYDb3MH=BW=0Aw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 04, 2018 at 12:18:59PM -0400, Martin-Louis Bright wrote:

> Why must the credentials must be deleted after receiving the 401 (or
> any) error? What's the rationale for this?

Because Git only tries a single credential per invocation. So if a
helper provides one, it doesn't prompt. If you get a 401 and then the
program aborts, invoking it again is just going to try the same
credential over and over. Dropping the credential from the helper breaks
out of that loop.

In fact, this patch probably should give the user some advice in that
regard (either in the documentation, or as a warning when we skip the
rejection). If you _do_ have a bogus credential and set the new option,
you'd need to reject it manually (you can do it with "git credential
reject", but it's probably easier to just unset the option temporarily
and re-invoke the original command).

-Peff
