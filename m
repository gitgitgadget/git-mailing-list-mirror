Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35E4C2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 18:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8106217F4
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 18:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgBMSwg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:52:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:42630 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727722AbgBMSwg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 13:52:36 -0500
Received: (qmail 16589 invoked by uid 109); 13 Feb 2020 18:52:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Feb 2020 18:52:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15721 invoked by uid 111); 13 Feb 2020 19:01:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Feb 2020 14:01:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 Feb 2020 13:52:35 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Parth Gala via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Parth Gala <parthpgala@gmail.com>
Subject: Re: [PATCH 2/5] object.c: lookup_unknown_object() accept 'r' as
 parameter
Message-ID: <20200213185235.GA15252@coredump.intra.peff.net>
References: <pull.545.git.1581535151.gitgitgadget@gmail.com>
 <16dd64618ab6a086727685e9eca3850fabc46437.1581535151.git.gitgitgadget@gmail.com>
 <20200212202540.GD4364@syl.local>
 <xmqqtv3vtst5.fsf@gitster-ct.c.googlers.com>
 <20200213180030.GF45518@syl.local>
 <xmqqh7zus6hm.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7zus6hm.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 13, 2020 at 10:10:45AM -0800, Junio C Hamano wrote:

> > Right, but my suggestion was that this advice doesn't apply to this
> > particular instance since I don't expect that we'd ever passing
> > something other than 'the_repository'.
> >
> > Specifically, I was worried that we'd get bitten by re-assigning 'r' in
> > the middle of the function and then end up in some odd broken state.
> 
> "git fsck" works only in a single, "the", repository, so I guess you
> are right to be worried about unnecessary complexity here.

I think the end-game for this whole repository transition would be to
get rid of the_repository, though. I.e., I'd envision the progression
something like this:

  1. Teach all of the library code to take (and operate on) "struct
     repository".

  2. Teach static local functions like this to pass in the_repository.

  3. Teach top-level commands like cmd_fsck() to pass the_repository to
     all of those static local helpers.

  4. Teach top-level commands to get a real repository pointer, either
     from the git.c wrapper (when RUN_SETUP is used) or by calling
     setup_git_repository() themselves.

  5. Grep for the_repository and drop it everywhere.

Here we're at step 2 now, but declaring "r" makes moving to step 3 just
a little easier. And I think the existence of steps 4 and 5 implies that
it would eventually be worth going through step 3.

Of course I just wrote those steps down for the first time, so maybe
nobody else shares my vision. ;)

-Peff
