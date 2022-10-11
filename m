Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042D1C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 01:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJKB52 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 21:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJKB50 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 21:57:26 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A7B4B9BE
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 18:57:25 -0700 (PDT)
Received: (qmail 30062 invoked by uid 109); 11 Oct 2022 01:57:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Oct 2022 01:57:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16449 invoked by uid 111); 11 Oct 2022 01:57:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Oct 2022 21:57:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Oct 2022 21:57:23 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com
Subject: Re: [PATCH 7/7] shortlog: implement `--group=trailer` in terms of
 `--group=<format>`
Message-ID: <Y0TNgxYFDMvZW/VS@coredump.intra.peff.net>
References: <cover.1665448437.git.me@ttaylorr.com>
 <02adc297e7661cbc25302b9f5659d2356b8b5008.1665448437.git.me@ttaylorr.com>
 <Y0TL8unKev9TPytJ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0TL8unKev9TPytJ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 09:50:42PM -0400, Jeff King wrote:

> I spent a fair bit of time optimizing the regular author/committer paths
> (and I think if we restore the skip-the-dedup logic I mentioned earlier
> for those, they should be equivalent, as they already use
> format_commit_message()). But the internals of the trailer code are
> already so slow I doubt it makes much of a difference either way here.
> 
> The one thing that could hurt is that multiple trailers now require
> multiple format calls, which may load the commit object for each one. I
> think _probably_ not because we'd hopefully have it cached in the commit
> slab via the save_commit_buffer mechanism. Though I guess if we used the
> commit graph in the first place, we would need to load it. We'd also
> likely reencode, but that's a noop on utf8 commits, so it's probably not
> worth worrying about.

Looking at it more carefully, your new code also does an individual
trailer parse for each trailer. And that code is also really slow, and
better if we call it only once.

-Peff
