Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27E2C0044D
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 19:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2ECC20578
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 19:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730944AbgCKT1V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:27:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:36736 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730705AbgCKT1V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 15:27:21 -0400
Received: (qmail 3559 invoked by uid 109); 11 Mar 2020 19:27:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 11 Mar 2020 19:27:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22312 invoked by uid 111); 11 Mar 2020 19:36:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Mar 2020 15:36:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Mar 2020 15:27:20 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] sequencer: clear CHERRY_PICK_HEAD upon dropping a
 become-empty commit
Message-ID: <20200311192720.GB27978@coredump.intra.peff.net>
References: <pull.722.git.git.1583903621.gitgitgadget@gmail.com>
 <132f769adb0a34e74b6c237ff84bf8b624ea0d9f.1583903621.git.gitgitgadget@gmail.com>
 <94eec36b-581a-17eb-7aeb-2d24c90b8e73@gmail.com>
 <xmqqwo7qhh45.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwo7qhh45.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 11, 2020 at 11:38:18AM -0700, Junio C Hamano wrote:

> >>   	} else if (allow == 2) {
> >>   		drop_commit = 1;
> >> +		unlink(git_path_cherry_pick_head(r));
> 
> When this fails for whatever reason, do we need to do something
> special?  The same question for MERGE_MSG Phillip mentioned.

I don't think there's much we _can_ do. The other call-sites seem to
just ignore failures. I suspect turning those into unlink_or_warn()
would be a good idea (and should be safe; it treats ENOENT as a noop, so
anything it reports should be an actual error worthy of the user's
attention).

But probably it would make sense to do that consistently for all of
those calls, and that doesn't need to be part of the 2.26 fixup.

-Peff
