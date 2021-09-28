Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9D8C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 22:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA82E6139E
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 22:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243088AbhI1Wld (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 18:41:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:57202 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238632AbhI1Wlc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 18:41:32 -0400
Received: (qmail 11705 invoked by uid 109); 28 Sep 2021 22:39:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Sep 2021 22:39:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5381 invoked by uid 111); 28 Sep 2021 22:39:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Sep 2021 18:39:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Sep 2021 18:39:51 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 4/7] merge-ort: capture and print ll-merge warnings in
 our preferred fashion
Message-ID: <YVOZty9D7NRbzhE5@coredump.intra.peff.net>
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <ce95b82fc492d48fa6022df424f9a303a1c70ad4.1630376800.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ce95b82fc492d48fa6022df424f9a303a1c70ad4.1630376800.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 02:26:37AM +0000, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> 
> Instead of immediately printing ll-merge warnings to stderr, we save
> them in our output strbuf.  Besides allowing us to move these warnings
> to a special file for --remerge-diff, this has two other benefits for
> regular merges done by merge-ort:
> 
>   * The deferral of messages ensures we can print all messages about
>     any given path together (merge-recursive was known to sometimes
>     intersperse messages about other paths, particularly when renames
>     were involved).
> 
>   * The deferral of messages means we can avoid printing spurious
>     conflict messages when we just end up aborting due to local user
>     modifications in the way.  (In contrast to merge-recursive.c which
>     prematurely checks for local modifications in the way via
>     unpack_trees() and gets the check wrong both in terms of false
>     positives and false negatives relative to renames, merge-ort does
>     not perform the local modifications in the way check until the
>     checkout() step after the full merge has been computed.)

Yeah, this is a good example of why having ll_merge() print warnings in
the first place is probably wrong. If you buy my argument that
ll_merge() should be returning an enum, then this code becomes IMHO even
nicer, as you can generate your own sensible message in the caller.

-Peff
