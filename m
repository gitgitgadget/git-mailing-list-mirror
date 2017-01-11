Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 276EF205C9
	for <e@80x24.org>; Wed, 11 Jan 2017 14:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967483AbdAKOmE (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 09:42:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:38006 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758970AbdAKOmC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 09:42:02 -0500
Received: (qmail 2996 invoked by uid 109); 11 Jan 2017 14:42:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Jan 2017 14:42:01 +0000
Received: (qmail 22427 invoked by uid 111); 11 Jan 2017 14:42:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Jan 2017 09:42:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jan 2017 09:41:59 -0500
Date:   Wed, 11 Jan 2017 09:41:59 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Richard Hansen <hansenr@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] diff: document behavior of relative diff.orderFile
Message-ID: <20170111144158.ef6kle3vw3ejgmut@sigill.intra.peff.net>
References: <20170110004031.57985-1-hansenr@google.com>
 <20170110004031.57985-2-hansenr@google.com>
 <20170110065816.pu325sxajbyuqpj6@sigill.intra.peff.net>
 <e100d30a-5ee8-8485-5012-f9b1c6961ffa@google.com>
 <xmqq4m16sm5v.fsf@gitster.mtv.corp.google.com>
 <xmqqziiyr7e9.fsf@gitster.mtv.corp.google.com>
 <9daa70e4-82b0-a82a-67b9-e893546638a7@google.com>
 <xmqqtw96pno0.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtw96pno0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 10, 2017 at 02:15:11PM -0800, Junio C Hamano wrote:

> Richard Hansen <hansenr@google.com> writes:
> 
> >> A related tangent.
> >>
> >> I wonder if anything that uses git_config_pathname() should be
> >> relative to GIT_DIR when it is not absolute.
> >
> > I think so.  (For bare repositories anyway; non-bare should be
> > relative to GIT_WORK_TREE.)  Perhaps git_config_pathname() itself
> > should convert relative paths to absolute so that every pathname
> > setting automatically works without changing any calling code.
> 
> Yes, that was what I was alluding to.  We might have to wait until
> major version boundary to do so, but I think that it is the sensible
> way forward in the longer term to convert relative to absolute in
> git_config_pathname().

Yeah, I'd agree.

I'm undecided on whether it would need to happen at a major version
bump. The existing semantics are fairly insane, and would cause a lot of
confusing breakages. We can imagine use of relative paths in a bare
repository falls into one of a few categories:

  1. The user generally runs by "cd /path/to/bare.git && git ...". This
     would be unaffected, as relative and $GIT_DIR are the same.

  2. The user runs via "cd /path/to/bare.git/some-subdir". This would be
     broken, but I have trouble imagining that they really wanted to
     read something like "objects/orderfile".

  3. The user runs via "GIT_DIR=/path/to/bare.git" from various
     directories. This case is probably horribly broken, as things like
     diff.orderFile will complain if they ever run from a directory that
     doesn't have the order file.

  4. They run GIT_DIR=/path/to/bare.git from a consistent origin
     directory. This _does_ work, and we'd be breaking it. Though I kind
     of question why the config in $GIT_DIR is meant to apply to a file
     in a totally unrelated directory.

     I suppose somebody could be relying on the behavior where setting
     GIT_DIR uses the current directory as the working tree (i.e., if
     core.bare is "true" in bare.git). But then, we'd consider their
     working directory as the working tree and read from that anyway. So
     the behavior would stay the same.

So I dunno. I do hate to break even corner cases, but I'm having trouble
imagining the scenario where somebody is actually using the current
behavior in a useful way.

-Peff
