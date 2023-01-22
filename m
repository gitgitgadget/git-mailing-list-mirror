Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F7DC25B4E
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 08:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjAVIAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 03:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjAVIAh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 03:00:37 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418FE1F903
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 00:00:36 -0800 (PST)
Received: (qmail 4984 invoked by uid 109); 22 Jan 2023 08:00:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 22 Jan 2023 08:00:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27850 invoked by uid 111); 22 Jan 2023 08:00:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 22 Jan 2023 03:00:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 22 Jan 2023 03:00:34 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: t5559 breaks with apache 2.4.55
Message-ID: <Y8ztIqYgVCPILJlO@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed that the test suite now fails after upgrading from apache
2.4.54 to 2.4.55 (the latter of which just hit debian unstable). The
problem is with the http2 tests, specifically t5559.30, where we send a
large fetch negotiation over http2. The output from curl is (including
some bits of tracing):

  == Info: Received 101, Switching to HTTP/2
  == Info: Using HTTP2, server supports multiplexing
  == Info: Copying HTTP/2 data in stream buffer to connection buffer after upgrade: len=0
  == Info: Closing connection 1
  error: RPC failed; HTTP 101 curl 16 Error in the HTTP2 framing layer

Bisecting within apache's Git repo, the culprit is their 9767274b88,
which says:

  mod_http2: version 2.0.10 of the module, synchronizing changes
  with the gitgub version. This is a partial rewrite of how connections
  and streams are handled.

which seems like a plausible source. But the diff is 8000 lines. It may
be possible to bisect within the mod_http2 source itself, but I haven't
tried it yet.

It's also not 100% clear that it's an apache bug. We could be doing
something weird with git-http-backend, or curl might be doing something
wrong. Though I tend to doubt it, given the simplicity of the CGI
interface on the server side and the fact that curl was working reliably
with older versions of apache.

So I haven't reported the bug further yet. But I thought I'd post this
here before anybody else wastes time digging in the same hole.

-Peff
