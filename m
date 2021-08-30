Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F36C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 19:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA35A60C40
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 19:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhH3TLl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 15:11:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:34138 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232336AbhH3TLl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 15:11:41 -0400
Received: (qmail 710 invoked by uid 109); 30 Aug 2021 19:10:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Aug 2021 19:10:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9161 invoked by uid 111); 30 Aug 2021 19:10:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Aug 2021 15:10:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 30 Aug 2021 15:10:46 -0400
From:   Jeff King <peff@peff.net>
To:     Stef Bon <stefbon@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: Exec upload-pack on remote with what parameters to get
 direntries.
Message-ID: <YS0tNoAa/0VQe1OW@coredump.intra.peff.net>
References: <CANXojcyWnFY60bXG6MDS9WAYkcFQHf+Oef0VREBkvgsuX9e=Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANXojcyWnFY60bXG6MDS9WAYkcFQHf+Oef0VREBkvgsuX9e=Kg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 28, 2021 at 02:56:17PM +0200, Stef Bon wrote:

> I've got a custom ssh library which I use to make a connection to a
> git server like www.github.com, user stefbon.
> 
> Now I want to get the direntries of a remote repo, and I know I have
> to use upload-pack for that, but with what parameters?
> 
> I want to use the outcome to make a fuse fs, user can browse the
> files. Possibly the user can also view the contents.

The protocol used by upload-pack is described in
Documentation/technical/pack-protocol.txt, but in short: I don't think
it will do what you want.

There is no operation to list the tree contents, for example, nor really
even a good way to fetch a single object. The protocol is geared around
efficiently transferring slices of history, so it is looking at sets of
reachable objects (what the client is asking for, and what it claims to
have).

You might be able to cobble something together with shallow and partial
fetches. E.g., something like:

  git clone --depth 1 --filter=blob:none --single-branch -b $branch

is basically asking to send only a single commit, plus all of its trees,
but no blobs. From there you could parse the tree objects to assemble a
directory listing. Possibly with a tree:depth filter you could even do
it iteratively.

Some hosts offer a separate API that would give you a much nicer
interface. E.g., GitHub has:

  https://docs.github.com/en/rest/reference/git#trees

But of course that won't work with GitLab, etc, and you'd have to
implement against the API for each hosting provider.

-Peff
