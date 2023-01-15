Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EC0C63797
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 20:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjAOUJ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 15:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjAOUJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 15:09:28 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EACEC65A
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 12:09:27 -0800 (PST)
Received: (qmail 8545 invoked by uid 109); 15 Jan 2023 20:09:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 15 Jan 2023 20:09:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23481 invoked by uid 111); 15 Jan 2023 20:09:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 15 Jan 2023 15:09:28 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 15 Jan 2023 15:09:25 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] ci: do not die on deprecated-declarations warning
Message-ID: <Y8RddcM9Vr71ljp4@coredump.intra.peff.net>
References: <xmqqv8l9n5fj.fsf@gitster.g>
 <Y8LAim4D3g6qnZdq@coredump.intra.peff.net>
 <xmqqilh9kqdy.fsf@gitster.g>
 <xmqqzgakgu0n.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzgakgu0n.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 14, 2023 at 11:02:32PM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > But anyway, let's use CURL_DISABLE_DEPRECATION first to see how it
> > goes.
> 
> The "DEVELOPER_CFLAGS += -Wno-error=deprecated-declarations" version
> was merged to 'next', only because I wanted to see the commit
> cleanly pass the tests (and it does), but I do think in the longer
> term (like, before the topic hits 'master'), it probably is better
> to do this for everybody, not just for those who use DEVELOPER=Yes.
> 
> So, further patches on top are very much welcomed.

So I took a look at just dropping the deprecated bits, and it wasn't
_too_ bad. Here's that series. The first two I hope are obviously good.
The third one is _ugly_, but at least it punts on the whole "how should
we silence this" argument, and it takes us in the direction we'd
ultimately want to go.

  [1/3]: http-push: prefer CURLOPT_UPLOAD to CURLOPT_PUT
  [2/3]: http: prefer CURLOPT_SEEKFUNCTION to CURLOPT_IOCTLFUNCTION
  [3/3]: http: support CURLOPT_PROTOCOLS_STR

 git-curl-compat.h |  8 +++++++
 http-push.c       |  6 ++---
 http.c            | 61 +++++++++++++++++++++++++++++++++--------------
 http.h            |  2 +-
 remote-curl.c     | 28 ++++++++++------------
 5 files changed, 68 insertions(+), 37 deletions(-)

