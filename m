Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D5AC388F9
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 00:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A92BB238E6
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 00:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbgKQAfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 19:35:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:59876 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgKQAfM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 19:35:12 -0500
Received: (qmail 12679 invoked by uid 109); 17 Nov 2020 00:35:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 17 Nov 2020 00:35:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20674 invoked by uid 111); 17 Nov 2020 00:35:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Nov 2020 19:35:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Nov 2020 19:35:11 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff-lib: plug minor memory leaks in do_diff_cache()
Message-ID: <20201117003511.GC13516@coredump.intra.peff.net>
References: <80fb4a2a-992f-7d3b-9413-5059da3a8f01@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80fb4a2a-992f-7d3b-9413-5059da3a8f01@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 14, 2020 at 07:37:03PM +0100, René Scharfe wrote:

> do_diff_cache() builds a struct rev_info to hand to diff_cache() from
> scratch by initializing it using repo_init_revisions() and then
> replacing its diffopt and prune_data members.
> 
> The diffopt member is initialized to a heap-allocated list of options,
> though.  Release it using diff_setup_done() before overwriting it.

Makes sense. This whole "rewrite the options as a heap-allocated list"
thing is pretty gross, but is probably the least-bad solution to the
problem. I wondered if there might be other unpaired diff_setup() /
diff_setup_done() calls. Curiously, there are more of the latter:

  $ git grep 'diff_setup(' | wc -l
  22

  $ git grep 'diff_setup_done(' | wc -l
  35

I think because repo_init_revisions() makes an implicit call to
diff_setup().

> The initial value of the prune_data member doesn't need to be released,
> but the copy created using copy_pathspec() does.  Clear it after use.

I suspect there are more elements of rev_info that could be allocated
(e.g., in a traversal without "--objects", I think trees and blobs are
left sitting in the pending array). It's a prime candidate for UNLEAK()
in most cases where we do a single traversal and then exit the program.
But for sub-functions like this, we perhaps should bite the bullet and
just make a rev_info_clear() function that can be used everywhere.

(I'm not opposed to your patch here in the meantime, though).

-Peff
