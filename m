Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2665020248
	for <e@80x24.org>; Thu, 14 Mar 2019 02:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfCNClk (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 22:41:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:50224 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726656AbfCNClk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 22:41:40 -0400
Received: (qmail 3332 invoked by uid 109); 14 Mar 2019 02:41:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Mar 2019 02:41:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18446 invoked by uid 111); 14 Mar 2019 02:40:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Mar 2019 22:40:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Mar 2019 22:40:23 -0400
Date:   Wed, 13 Mar 2019 22:40:23 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/4] get_oid(): when an object was not found, try harder
Message-ID: <20190314024023.GA3889@sigill.intra.peff.net>
References: <pull.161.git.gitgitgadget@gmail.com>
 <994446236d05d9d014e12a5102bcf9be222e3b57.1552472189.git.gitgitgadget@gmail.com>
 <xmqqa7hyckfm.fsf@gitster-ct.c.googlers.com>
 <20190314022245.GA1414@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190314022245.GA1414@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 13, 2019 at 10:22:46PM -0400, Jeff King wrote:

> Try this:
> 
> -- >8 --
> mkfifo in
> (git cat-file --batch-check <in) &
> exec 9>in
> 
> git commit --allow-empty -m one
> git commit --allow-empty -m two
> 
> git rev-parse --short HEAD^ >&9
> git repack -adk
> git rev-parse --short HEAD >&9
> -- >8 --
> 
> The second object will (usually) be reported as "missing", even though
> by calling reprepare_packed_git(), we would then find it in the
> packfile.
> 
> I say "usually" because if the two commits have the same first-byte to
> their sha1, then we'd load both into the loose cache during the first
> request, and use that during the second request.
> 
> After this patch, it works consistently (we flush both the loose cache
> and the cached set of packs, and find the packed version).

By the way, an interesting implication of this is that we're doing the
re-prepare only when we come up with no object. But we _could_ actually
come up with the wrong object when we should say "ambiguous". I.e., the
user asks for 1234abcd. We have 1234abcde in a pack, and 1234abcdf
loose. A simultaneous process repacks, and we see neither copy of
1234abcdf, reporting that 1234abcde is the right answer.

I'm not sure it's really worth addressing (just because I don't think
there's a good way to do it that isn't expensive).

-Peff
