Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC182C433DB
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 18:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A023664E61
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 18:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhCOS45 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 14:56:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:36678 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231250AbhCOS4o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 14:56:44 -0400
Received: (qmail 15053 invoked by uid 109); 15 Mar 2021 18:56:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 15 Mar 2021 18:56:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18374 invoked by uid 111); 15 Mar 2021 18:56:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 15 Mar 2021 14:56:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 15 Mar 2021 14:56:43 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     John Ratliff <john@technoplaza.net>, git@vger.kernel.org
Subject: Re: git credential cache and sudo
Message-ID: <YE+t6z6j2ITeqpnD@coredump.intra.peff.net>
References: <CAP8UukjW_TeswTHHfiwzc989U+wZMVcHeS1siRF0Rbg5nc3D5w@mail.gmail.com>
 <YEvPQS1+1sxd/aGw@coredump.intra.peff.net>
 <YEwoyeYM7ac+6aIx@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YEwoyeYM7ac+6aIx@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 12, 2021 at 06:51:53PM -0800, Jonathan Nieder wrote:

> > Note that it's a little funky to be accessing the cache as a different user than
> > the one who created it. This should work reliably when the cache was created by
> > your normal user, but then accessed as root, because root has permissions to
> > access the socket. But if you spawn a cache daemon as root (because the _first_
> > operation you perform is as root, which automatically starts a daemon to store
> > the cached credential), then it's likely you won't be able to access it as your
> > regular user.
> 
> I wonder if this suggests a missing feature in
> git-credential-cache(1): if the manpage advertised a way to launch the
> daemon through an explicit command, similar to 'ssh-agent', then a
> user could run that as themselves before running other commands that
> communicate with it as another user.

Perhaps. The daemon side of the credential-cache helper does not work
quite like ssh-agent, though, in that it tries to be ephemeral. So after
starting, you have 30 seconds to give it some data to cache before it
will exit. Normally this is fine since it's started by the client side
of the helper, which will then immediately supply it with data.

So after starting it, you'd need to immediately prime it with data,
either manually or by running a Git command. And then hope that command,
including time to talk to the other side on the network and for you to
type your password, does not exceed the timeout.

-Peff
