Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01591C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 07:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D13E860200
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 07:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238673AbhHaHIX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 03:08:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:34716 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238155AbhHaHIW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 03:08:22 -0400
Received: (qmail 4431 invoked by uid 109); 31 Aug 2021 07:07:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 31 Aug 2021 07:07:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20307 invoked by uid 111); 31 Aug 2021 07:07:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Aug 2021 03:07:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 31 Aug 2021 03:07:26 -0400
From:   Jeff King <peff@peff.net>
To:     Stef Bon <stefbon@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: Exec upload-pack on remote with what parameters to get
 direntries.
Message-ID: <YS3VLh8SFvpDZy84@coredump.intra.peff.net>
References: <CANXojcyWnFY60bXG6MDS9WAYkcFQHf+Oef0VREBkvgsuX9e=Kg@mail.gmail.com>
 <YS0tNoAa/0VQe1OW@coredump.intra.peff.net>
 <CANXojczR1hMrzz7t0P6AkqL3kjdk+NzBKyCQnm-9cWFbULifow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANXojczR1hMrzz7t0P6AkqL3kjdk+NzBKyCQnm-9cWFbULifow@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 08:38:39AM +0200, Stef Bon wrote:

> So in my program I do not have to do something like:
> 
> ssh -x git@server "git-upload-pack 'simplegit-progit.git'"
> 
> It is only the sending of an exec message with the right command.
> Via the SSH_MSG_CHANNEL_DATA message the server will return the
> output. In my program I have to write a parser to get the
> tree/direntries.
> 
> Now you suggest the git clone --depth 1 --filter=blob:none
> --single-branch -b $branch
> command. How does that look when writing it in lowlevel git messages
> as described in
> 
> https://git-scm.com/book/en/v2/Git-Internals-Transfer-Protocols
> 
> ?
> I'm programming at this low level, so I have to write the messages to
> send to the server myself.

You'll have to read the documentation I pointed to earlier:

  https://github.com/git/git/blob/master/Documentation/technical/pack-protocol.txt

In short: the server tells you which refs it has and what they point to,
then the client says which objects it wants and which objects it has,
and then the server sends a packfile. The flow of the protocol and the
format of the messages is laid out there.

You might also set GIT_TRACE_PACKET=1 in your environment and try
running some Git commands. They will show you what's being said on the
wire, up until the packfile is sent (decoding the packfile itself is a
whole other story).

> And you mention the api github has for a git tree object. But git2 has
> already the git_tree object?

If you mean libgit2, then yes, it has a git_tree struct. Just like we
have internally within regular Git. But those are for accessing _local_
objects, that have already been fetched.

You could build a fuse filesystem around a local Git repository pretty
easily, either by using libgit2 or around tools like "git ls-tree" and
"git cat-file". But if your purpose is to access a remote one without
downloading all of the objects first, then no, Git does not expose any
of the endpoints you'd need remotely (but provider-specific APIs like
GitHub's do).

-Peff
