Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB01D2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 19:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbdHGTuG (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 15:50:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:59544 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751508AbdHGTuG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 15:50:06 -0400
Received: (qmail 27450 invoked by uid 109); 7 Aug 2017 19:50:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 Aug 2017 19:50:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9887 invoked by uid 111); 7 Aug 2017 19:50:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 Aug 2017 15:50:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Aug 2017 15:50:03 -0400
Date:   Mon, 7 Aug 2017 15:50:03 -0400
From:   Jeff King <peff@peff.net>
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     Bernhard Reiter <ockham@raz.or.at>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/4] imap_send: setup_curl: use server_conf parameter
 instead of the global variable
Message-ID: <20170807195003.clo2vmnmufmfalb6@sigill.intra.peff.net>
References: <c74c8c386f2c2d8b6cebd4addf925d0121986067.1502114584.git.nicolas@morey-chaisemartin.com>
 <4a1f931c-9813-36a5-9c37-63b8abc4fecd@morey-chaisemartin.com>
 <CAN0heSqyiisjWyDBXLJcyx=Hh3NA562DoFqP8rpFyi_zuGKLEA@mail.gmail.com>
 <71817815-4e52-4623-b226-bbb57ca08047@morey-chaisemartin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71817815-4e52-4623-b226-bbb57ca08047@morey-chaisemartin.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 07, 2017 at 07:06:07PM +0200, Nicolas Morey-Chaisemartin wrote:

> >> -       server_fill_credential(&server);
> >> -       curl_easy_setopt(curl, CURLOPT_USERNAME, server.user);
> >> -       curl_easy_setopt(curl, CURLOPT_PASSWORD, server.pass);
> >> +       server_fill_credential(srvc);
> >> +       curl_easy_setopt(curl, CURLOPT_USERNAME, srvc->user);
> >> +       curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
> > Here you change the server_fill_credential-call that you just added.
> > Maybe do this patch earlier, perhaps even as patch 1?
> >
> > I'm snipping lots of s/server/srvc/-changes... There's a less noisy
> > way of addressing the fact that srvc is unused: dropping it. I'm not
> > saying that's a good idea, but it could be considered, then explained
> > why this approach is better. There are some other functions which
> > access "server" directly, and some which take (and use!) a "srvc".
> > Maybe make the whole file consistent?
> >
> That's why I applied it after #2. I was not sure if this one made
> sense or not. And it  can be dropped with the rest of the series still
> applying.
> I don't know what is the right approach here. Someone with more
> knowledge of why there is a mix of global variable and local can maybe
> help ?

I suspect it's just code in need of a cleanup. But let's cc the original
author of 1e16b255b (git-imap-send: use libcurl for implementation,
2014-11-09) to see if he has any comments[1].

-Peff

[1] Bernhard, the whole series is at:

      https://public-inbox.org/git/38d3ae5b-4020-63cc-edfa-0a77e42798b8@morey-chaisemartin.com/

    The general idea is to make sure the original and curl imap-send
    implementations have feature parity, make the curl version the
    default, and then hopefully eventually drop the non-curl one
    entirely.
