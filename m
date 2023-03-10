Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625C5C6FD19
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 08:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjCJI65 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 03:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjCJI5x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 03:57:53 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CA910A2BB
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 00:51:31 -0800 (PST)
Received: (qmail 19074 invoked by uid 109); 10 Mar 2023 08:51:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Mar 2023 08:51:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10283 invoked by uid 111); 10 Mar 2023 08:51:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Mar 2023 03:51:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Mar 2023 03:51:29 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] receive-pack: fix stale packfile locks when dying
Message-ID: <ZArvkVPhF4Th424Z@coredump.intra.peff.net>
References: <e16bd81bf9e251aa6959fbe10a3fbc215a4a1c12.1678367338.git.ps@pks.im>
 <e1ee1d8026a361bc58d16bc741e2b347ada7a53e.1678431076.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e1ee1d8026a361bc58d16bc741e2b347ada7a53e.1678431076.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2023 at 07:52:10AM +0100, Patrick Steinhardt wrote:

> Fix this race by registering the lockfile as a tempfile so that it will
> automatically be removed at exit or when receiving a signal.

Unsurprisingly, this version looks good to me. :)

Looks like you adjusted for index_pack_lockfile() returning NULL, which
makes sense.

>  builtin/receive-pack.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

There's no test here, and I think we _could_ make a reliable one with
something like:

  1. Have a proc-receive hook that signals via fifo that it's running,
     then pauses indefinitely.

  2. Start a push in the background, then wait on the fifo signal.

  3. Kill receive-pack.

But it's awfully complicated for little gain. I'm fine with not worrying
about it (and I did something similar manually to make to sure it works
as we expect).

-Peff
