Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BD6E20401
	for <e@80x24.org>; Sat, 24 Jun 2017 12:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbdFXMOg (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 08:14:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:51748 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751281AbdFXMOf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 08:14:35 -0400
Received: (qmail 906 invoked by uid 109); 24 Jun 2017 12:14:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 24 Jun 2017 12:14:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23361 invoked by uid 111); 24 Jun 2017 12:14:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 24 Jun 2017 08:14:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Jun 2017 08:14:33 -0400
Date:   Sat, 24 Jun 2017 08:14:33 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] sha1_name: cache readdir(3) results in
 find_short_object_filename()
Message-ID: <20170624121433.bnrn56njycnksf3g@sigill.intra.peff.net>
References: <dae96f72-761c-3ed1-4567-0933acc7618a@web.de>
 <20170615055654.efvsouhr3leszz3i@sigill.intra.peff.net>
 <ec36f9fa-5f3e-b511-3985-3d0301b4847f@web.de>
 <20170615132532.nivmj22dctowxssm@sigill.intra.peff.net>
 <b728352d-7fa5-2adb-af00-5f232b85b2bf@web.de>
 <20170618115017.wyroncb3jka6lrdt@sigill.intra.peff.net>
 <xmqqd1a0vb2t.fsf@gitster.mtv.corp.google.com>
 <d06fb033-294e-f364-3dde-394624e83cd6@web.de>
 <20170622231041.2zdjypviwmndjnsb@sigill.intra.peff.net>
 <2cd8a407-f9a2-687a-3c78-6b502da2ad94@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cd8a407-f9a2-687a-3c78-6b502da2ad94@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 24, 2017 at 02:12:07PM +0200, René Scharfe wrote:

> Am 23.06.2017 um 01:10 schrieb Jeff King:
> > On Thu, Jun 22, 2017 at 08:19:48PM +0200, René Scharfe wrote:
> > 
> >> Read each loose object subdirectory at most once when looking for unique
> >> abbreviated hashes.  This speeds up commands like "git log --pretty=%h"
> >> considerably, which previously caused one readdir(3) call for each
> >> candidate, even for subdirectories that were visited before.
> > 
> > Is it worth adding a perf test that's heavy on abbreviations?
> 
> Sure.  Here's a simple one.  It currently reports for me:
> 
> Test                        origin/master     origin/next              origin/pu
> ---------------------------------------------------------------------------------------------
> 4205.1: log with %H         0.44(0.41+0.02)   0.43(0.42+0.01) -2.3%    0.43(0.43+0.00) -2.3%
> 4205.2: log with %h         1.03(0.60+0.42)   1.04(0.64+0.39) +1.0%    0.57(0.55+0.01) -44.7%
> 4205.3: log with %T         0.43(0.42+0.00)   0.43(0.42+0.01) +0.0%    0.43(0.40+0.02) +0.0%
> 4205.4: log with %t         1.05(0.64+0.38)   1.05(0.61+0.42) +0.0%    0.59(0.58+0.00) -43.8%
> 4205.5: log with %P         0.45(0.42+0.02)   0.43(0.42+0.00) -4.4%    0.43(0.42+0.01) -4.4%
> 4205.6: log with %p         1.21(0.63+0.57)   1.17(0.68+0.47) -3.3%    0.59(0.58+0.00) -51.2%
> 4205.7: log with %h-%h-%h   1.05(0.64+0.39)   2.00(0.83+1.15) +90.5%   0.69(0.66+0.02) -34.3%
> 
> origin/next has fe9e2aefd4 (pretty: recalculate duplicate short hashes),
> while origin/pu has cc817ca3ef (sha1_name: cache readdir(3) results in
> find_short_object_filename()).

Perfect. That last one says everything we need to know about which
approach to take. :)

-Peff
