Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96D2C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 16:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D06864D9D
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 16:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhBIQkd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 11:40:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:55026 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232897AbhBIQkO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 11:40:14 -0500
Received: (qmail 26946 invoked by uid 109); 9 Feb 2021 16:39:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Feb 2021 16:39:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7452 invoked by uid 111); 9 Feb 2021 16:39:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Feb 2021 11:39:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 9 Feb 2021 11:39:31 -0500
From:   Jeff King <peff@peff.net>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: how to most effectively cherry pick by selective patch hunk?
Message-ID: <YCK6w/VbfUtM68Ad@coredump.intra.peff.net>
References: <566b38df-307c-f342-b583-3a50a81b5057@crashcourse.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <566b38df-307c-f342-b583-3a50a81b5057@crashcourse.ca>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 09, 2021 at 08:58:06AM -0500, Robert P. J. Day wrote:

>   what would be great is some sort of "-p" (patch selection) option
> with cherry-pick, but i don't see that.

We have "checkout -p", but of course the problem there is that it's
picking out of the whole state of that commit. So you might see other
changes not introduced by that commit.

Conceptually, adding "cherry-pick -p" would be pretty easy. The strategy
for all of the "-p" options is to generate a diff, then feed that diff
to the patch-selection code, then apply whatever the user selects. For
"checkout -p $commit", that diff is the diff between $commit and our
current state. But for "cherry-pick -p", it would be the diff between
$commit^ and $commit.

Of course that involves a change to Git, and you were looking for
something you could do with existing versions. :) You can emulate it by
making the commit's parent equivalent to your current state. I.e.:

  git checkout --detach ;# detached HEAD for temporary commit
  git cherry-pick $commit ;# maybe deal with conflicts
  commit=$(git rev-parse --verify HEAD) ;# remember the temp commit
  git checkout - ;# back to your branch
  git checkout -p $commit

-Peff
