Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A2EC433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 09:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E815D613B6
	for <git@archiver.kernel.org>; Wed, 19 May 2021 09:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344068AbhESJgB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 05:36:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:58760 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239524AbhESJgA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 05:36:00 -0400
Received: (qmail 22496 invoked by uid 109); 19 May 2021 09:34:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 19 May 2021 09:34:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17795 invoked by uid 111); 19 May 2021 09:34:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 19 May 2021 05:34:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 19 May 2021 05:34:40 -0400
From:   Jeff King <peff@peff.net>
To:     Greg Pflaum <greg.pflaum@pnp-hcl.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] clone of large repo fails when server closes idle SSH
 session during "Resolving deltas"
Message-ID: <YKTbsByUaPEuDNtR@coredump.intra.peff.net>
References: <OF9ECB0D17.7C6A7258-ON852586DA.0014125E-852586DA.0014B7AB@pnp-hcl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <OF9ECB0D17.7C6A7258-ON852586DA.0014125E-852586DA.0014B7AB@pnp-hcl.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 18, 2021 at 11:46:17PM -0400, Greg Pflaum wrote:

> Git's handling of the SSH session during "git clone" changed between Git
> 2.17.0 and 2.31.1, causing cloning of a large repo to fail when the server
> closes the idle session during the "Resolving deltas" phase.

Interesting find.

During that phase, all communication with the server is finished. We're
not expecting it to say anything else, and I'd have actually expected us
to have hung up the connection.

But I can definitely reproduce the issue by fetching even a moderate
sized repository like git.git, and observing that ssh is still running
when we hit the "Resolving deltas" phase. And indeed, killing it at that
step shows the problem:

  $ git clone --bare git@github.com:git/git foo.git
  Cloning into bare repository 'foo.git'...
  remote: Enumerating objects: 307777, done.
  remote: Counting objects: 100% (114/114), done.
  remote: Compressing objects: 100% (48/48), done.
  remote: Total 307777 (delta 72), reused 94 (delta 66), pack-reused 307663
  Receiving objects: 100% (307777/307777), 159.14 MiB | 30.71 MiB/s, done.
  Resolving deltas: 100% (229729/229729), done.
  error: ssh died of signal 9

In another terminal I waited for it to hit "resolving" and ran:

  kill -9 $(ps ax | grep ssh | grep github | awk '{print $1}')

You can see that we did completely successfully receive the incoming
pack. It's just that we then do an over-eager check of ssh's exit code
and complain when disconnecting the transport.

I had a hunch that this was related to the v2 protocol (which became the
default between the two versions you mentioned). And indeed, running
"git clone -c protocol.version=0 clone ..." makes it go away.

So I'd guess that in the v0 protocol, we close the pipe going to ssh's
stdin (which does a half-duplex shutdown, and then when the server side
closes its pipe, ssh exits completely).

But in v2, we presumably don't. Which is not too surprising; v2's view
of ssh is much more as a transport over which it will make several
request/response pairs. So the caller would have to explicitly indicate
that this is the final request, and the transport can be terminated
after that. That doesn't seem too complex conceptually, but I worry
implementing it will run into conflicts with how the v2 code works.

Another side issue is that once the protocol conversation has finished,
I'm not sure if it's really useful for us to detect and complain about
ssh's exit code. We know the other side completed the conversation
successfully, and we have nothing left to ask it. So a fix for your
immediate pain would be to stop noticing that. I think the root issue is
still worth addressing, though; we are tying up network and local
resources with a useless to-be-closed ssh connection.

-Peff
