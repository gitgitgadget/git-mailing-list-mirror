Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCABD202BB
	for <e@80x24.org>; Sun, 24 Mar 2019 12:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfCXMIA (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 08:08:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:34174 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726160AbfCXMIA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 08:08:00 -0400
Received: (qmail 4454 invoked by uid 109); 24 Mar 2019 12:08:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 24 Mar 2019 12:08:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1485 invoked by uid 111); 24 Mar 2019 12:08:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 24 Mar 2019 08:08:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Mar 2019 08:07:58 -0400
Date:   Sun, 24 Mar 2019 08:07:58 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Wolfgang Denk <wd@denx.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Takahiro Akashi <takahiro.akashi@linaro.org>
Subject: [PATCH 0/3] fix dumb-http fetch with alternates
Message-ID: <20190324120757.GA18684@sigill.intra.peff.net>
References: <7e4a2f1d-2b3a-eb83-d3f1-9ac63d68991b@gmx.de>
 <20190322005107.GL9937@linaro.org>
 <017964a9-bd75-5e36-0de7-57d4467d6a7e@gmx.de>
 <20190322071231.GA26114@sigill.intra.peff.net>
 <20190322082114.BC19924013C@gemini.denx.de>
 <20190322093132.GA17498@sigill.intra.peff.net>
 <20190322165034.GA23124@dcvr>
 <20190323085341.GA9002@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190323085341.GA9002@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 23, 2019 at 04:53:41AM -0400, Jeff King wrote:

> On Fri, Mar 22, 2019 at 04:50:34PM +0000, Eric Wong wrote:
> 
> > > Weird. I had set http.maxrequests to "1" to give more readable output
> > > from GIT_CURL_VERBOSE, etc. It fails with that setting, but not with the
> > > default of 5. Which certainly seems like a bug, but one that has been
> > > there for a while (at least since v2.9.x, which I tested).
> > 
> > I couldn't reproduce an error after porting your patch to
> > master (commit 041f5ea1cf987a40 "The third batch"):
> > https://80x24.org/spew/20190322163449.25362-1-e@80x24.org/raw
> > 
> > So you might've hit an ephemeral error (bad connection,
> > HTTP server restarting, etc).
> 
> No, it was quite reproducible. Curious, I decided to bisect. The problem
> started in ad75ebe5b3 (http: maintain curl sessions, 2009-11-27), but
> was later fixed by your 2abc848d54 (http: always remove curl easy from
> curlm session on release, 2016-09-13).
> 
> So trying to build the fix directly on 17966c0a63d (which is in between
> those) will run into this unrelated bug. But forward-porting does work.

Here's the patch, forward-ported on top of the current master, with
actual commit messages, a test, and a few subtle tweaks around the
curl_errorstr handling.

  [1/3]: http: factor out curl result code normalization
  [2/3]: http: normalize curl results for dumb loose and alternates fetches
  [3/3]: http: use normalize_curl_result() instead of manual conversion

 http-walker.c              | 21 ++++++++++-----------
 http.c                     | 18 ++++++++++++------
 http.h                     |  9 +++++++++
 t/t5550-http-fetch-dumb.sh | 16 ++++++++++++++++
 4 files changed, 47 insertions(+), 17 deletions(-)
