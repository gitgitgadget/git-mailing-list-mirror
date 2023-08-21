Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5D0EE4996
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 20:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjHUUay (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 16:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjHUUay (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 16:30:54 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F31710D
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 13:30:52 -0700 (PDT)
Received: (qmail 17407 invoked by uid 109); 21 Aug 2023 20:30:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Aug 2023 20:30:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19003 invoked by uid 111); 21 Aug 2023 20:30:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Aug 2023 16:30:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Aug 2023 16:30:51 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Santiago <taylorsantiago@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] Fix the order of consuming unpackLimit config
 settings.
Message-ID: <20230821203051.GA1800481@coredump.intra.peff.net>
References: <20230817215325.2550998-1-taylorsantiago@google.com>
 <20230817215325.2550998-2-taylorsantiago@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230817215325.2550998-2-taylorsantiago@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2023 at 02:53:25PM -0700, Taylor Santiago wrote:

> The documentation for fetch.unpackLimit states that fetch.unpackLimit
> should be treated as higher priority than transfer.unpackLimit, but the
> intended order is currently inverted.

Looks like this has been broken since it was introduced in e28714c527
(Consolidate {receive,fetch}.unpackLimit, 2007-01-24).

Sometimes when documentation and code have diverged for so long, we
prefer to change the documentation instead, to avoid disrupting users.
But that would make these weirdly unlike most other "specific overrides
general" config options. And the fact that the bug has existed for so
long without anyone noticing implies to me that nobody really tries to
mix and match them much.

So I'm in favor of fixing them[1]. Doesn't receive-pack have the same
bug, though? And we'd probably want to have tests for both.

-Peff

[1] Commit e28714c527 does mention deprecating the operation-specific
    ones. In my experience (and I did use transfer.unpackLimit quite a
    bit for server-side code at GitHub) there is no real need for have
    operation-specific ones. OTOH it is work to deprecate them, and they
    are not causing a big maintenance burden. So it is probably simplest
    to keep them.
