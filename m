Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E826E1F461
	for <e@80x24.org>; Wed,  4 Sep 2019 03:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfIDDO2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 23:14:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:38624 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727374AbfIDDO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 23:14:28 -0400
Received: (qmail 9709 invoked by uid 109); 4 Sep 2019 03:14:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Sep 2019 03:14:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11023 invoked by uid 111); 4 Sep 2019 03:16:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Sep 2019 23:16:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Sep 2019 23:14:26 -0400
From:   Jeff King <peff@peff.net>
To:     Grigory Yakushev <gy@daedalean.ai>
Cc:     git@vger.kernel.org
Subject: Re: Failure to fetch submodule with --depth=1 parameter
Message-ID: <20190904031426.GC28836@sigill.intra.peff.net>
References: <CACfeHrrajM8_p0=N8ZPm9h7ObcvWT5EnVa-gLhtDODdG9GeyBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACfeHrrajM8_p0=N8ZPm9h7ObcvWT5EnVa-gLhtDODdG9GeyBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 03, 2019 at 05:30:02PM +0200, Grigory Yakushev wrote:

> $ git --version
> git version 2.17.1
> 
> Repro:
> $ git clone https://github.com/PX4/Firmware.git
> $ cd Firmware
> $ git submodule update --init --recursive --depth=1
> ...
> error: Server does not allow request for unadvertised object
> 22df9475ca0d157e2db066a20f64c35906bf7f25
> Fetched in submodule path 'Tools/sitl_gazebo', but it did not contain
> 22df9475ca0d157e2db066a20f64c35906bf7f25. Direct fetching of that
> commit failed.
> 
> The same line without --depth=1 flag works fine:
> $ git submodule update --init --recursive

I think what's happening is this: the super-project (PX4/Firmware)
points to a specific sha1 in the submodule (Tools/sitl_gazebo). But
there's no branch pointing at that sha1, so the client cannot ask for it
directly.

As a fallback we instead fetch HEAD from the submodule and hope that we
got the sha1 we needed. But because we pass along "--depth=1", that
fallback is not likely to work.

IMHO one obvious improvement on the client side is to have a third-level
fallback to do a full clone, and hope we get it then.

However, there may a be an easier solution. In the v2 protocol, Git does
not enforce any advertisement or reachability properties for items the
client asks for. So the client would be free to just ask for the sha1
directly, no fallback required.

Try setting:

  git config --global protocol.version 2

which seems to make it work.

-Peff
