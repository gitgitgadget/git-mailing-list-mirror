Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CBDC6FA83
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 11:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiI0LtV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 07:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbiI0Ls7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 07:48:59 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89033152217
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 04:48:58 -0700 (PDT)
Received: (qmail 30995 invoked by uid 109); 27 Sep 2022 11:48:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Sep 2022 11:48:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18215 invoked by uid 111); 27 Sep 2022 11:48:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Sep 2022 07:48:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Sep 2022 07:48:57 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] tmp-objdir: do not opendir() when handling a signal
Message-ID: <YzLjKbLI13GN52R/@coredump.intra.peff.net>
References: <pull.1348.git.git.1664236383785.gitgitgadget@gmail.com>
 <YzJBZ9QJWIv0hpXb@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YzJBZ9QJWIv0hpXb@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2022 at 08:18:47PM -0400, Taylor Blau wrote:

> It does make me a little uneasy leaving the quarantine directory around
> via this path. So I wonder if we should be optimistically opening up the
> DIR handle? Calling unlink() in a signal is perfectly fine, so I'd think
> as long as we have an open DIR handle we could call readdir_r(), but I
> don't think we've discussed it before.

You'd need to hold multiple such DIRs, since the removal is recursive.
It's easy-ish for the "pack" directory, but the sub-process index-pack
may have created 00-ff directories, too. You'd have to pre-create and
opendir() all of them.

I'm also not sure what timing guarantees we have. If I opendir() a
directory, then wait a long time while somebody else creates entries, is
a readdir() guaranteed to see those new entries?

-Peff
