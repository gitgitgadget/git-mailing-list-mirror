Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A38C43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 15:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0AF206F6
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 15:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgC1PNB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 11:13:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:54510 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725807AbgC1PNB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 11:13:01 -0400
Received: (qmail 24370 invoked by uid 109); 28 Mar 2020 15:13:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 28 Mar 2020 15:13:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2349 invoked by uid 111); 28 Mar 2020 15:23:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 28 Mar 2020 11:23:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 28 Mar 2020 11:13:00 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [RFC PATCH] http-backend: write error packet if backend command
 fails
Message-ID: <20200328151300.GA1215566@coredump.intra.peff.net>
References: <b5f8b81498e1d152014acab92fa1b6e9701b3a0e.1585363771.git.liu.denton@gmail.com>
 <20200328145741.GA1209174@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200328145741.GA1209174@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 28, 2020 at 10:57:42AM -0400, Jeff King wrote:

> But since it works for v1 (which also dies!), and since you were able to
> reproduce the problem locally, I suspect it may be an issue in
> upload-pack itself.

Actually, I think the problem is on the client side.

If I run your test without the http-backend change, then nothing is left
running on the server side, but on the client we have two processes:
git-clone and the git-remote-https helper. And they're deadlocked trying
to read from each other.

I think the issue is that git-remote-https in v2 mode calls into
stateless_connect(), and just pumps http request/response pairs from
git-clone to the server. But if a request generates an empty response,
then clone has no idea that anything was received at all. It continues
waiting, but remote-https has looped to expect another request from it.

Your patch fixes _this case_ because it causes the server to send a
non-empty response. But the client can't rely on that. Besides that not
being a documented server behavior, in the worst case the connection
could be severed mid-stream. So I think remote-https needs to complain
about an empty response. This isn't a problem in v1 because it would
actually try to look at that empty response; in v2 it's just proxying
bytes around.

-Peff
