Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DC7F1FA7B
	for <e@80x24.org>; Sun, 18 Jun 2017 11:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752768AbdFRLuU (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Jun 2017 07:50:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:42310 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752582AbdFRLuT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jun 2017 07:50:19 -0400
Received: (qmail 3937 invoked by uid 109); 18 Jun 2017 11:50:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 18 Jun 2017 11:50:19 +0000
Received: (qmail 20441 invoked by uid 111); 18 Jun 2017 11:50:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 18 Jun 2017 07:50:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Jun 2017 07:50:17 -0400
Date:   Sun, 18 Jun 2017 07:50:17 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [BUG] add_again() off-by-one error in custom format
Message-ID: <20170618115017.wyroncb3jka6lrdt@sigill.intra.peff.net>
References: <xmqqd1a8n7o8.fsf@gitster.mtv.corp.google.com>
 <d229403a-d078-87b4-f3e8-89058fa4b548@web.de>
 <xmqqtw3j68rc.fsf@gitster.mtv.corp.google.com>
 <99d19e5a-9f79-9c1e-3a23-7b2437b04ce9@web.de>
 <xmqqwp8f4mb2.fsf@gitster.mtv.corp.google.com>
 <dae96f72-761c-3ed1-4567-0933acc7618a@web.de>
 <20170615055654.efvsouhr3leszz3i@sigill.intra.peff.net>
 <ec36f9fa-5f3e-b511-3985-3d0301b4847f@web.de>
 <20170615132532.nivmj22dctowxssm@sigill.intra.peff.net>
 <b728352d-7fa5-2adb-af00-5f232b85b2bf@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b728352d-7fa5-2adb-af00-5f232b85b2bf@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 18, 2017 at 12:58:49PM +0200, René Scharfe wrote:

> Anyway, here's a patch for stat-based invalidation, on top of the other
> one.  Array removal is really slow (hope I didn't sneak a bug in there,
> but my confidence in this code isn't very high).  No locking is done;
> parallel threads removing and adding entries could make a mess, but
> that's not an issue for log.
> 
> Timings for "time git log --pretty=%h >/dev/null" in my git repository
> with 5094 loose objects on Debian:
> 
>         master       first patch  this patch
> real    0m1.065s     0m0.581s     0m0.633s
> user    0m0.648s     0m0.564s     0m0.580s
> sys     0m0.412s     0m0.016s     0m0.052s
> 
> 
> And on mingw with 227 loose objects:
> 
>         master       first patch  this patch
> real    0m1.756s     0m0.546s     0m1.659s
> user    0m0.000s     0m0.000s     0m0.000s
> sys     0m0.000s     0m0.000s     0m0.000s
> 
> So at least for Windows it would be really nice if we could avoid
> calling stat..

Thanks for doing the timings. Given those numbers and the earlier
discussion, I'd be inclined to skip the mtime check.

-Peff
