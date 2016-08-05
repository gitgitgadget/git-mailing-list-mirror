Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A16C62018E
	for <e@80x24.org>; Fri,  5 Aug 2016 08:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934897AbcHEI0e (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 04:26:34 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55220 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934069AbcHEI0b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 04:26:31 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD1432018E;
	Fri,  5 Aug 2016 08:26:30 +0000 (UTC)
Date:	Fri, 5 Aug 2016 08:26:30 +0000
From:	Eric Wong <e@80x24.org>
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>,
	Lukas =?utf-8?Q?Sandstr=C3=B6m?= <luksan@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2016, #02; Thu, 4)
Message-ID: <20160805082630.GA29383@starla>
References: <xmqqshukyxqw.fsf@gitster.mtv.corp.google.com>
 <20160804233435.GA31403@dcvr>
 <20160805074552.6ow4h3lwdy7yxqva@sigill.intra.peff.net>
 <20160805080231.GA25379@starla>
 <20160805081103.t5f4bapmia6vircg@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160805081103.t5f4bapmia6vircg@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Fri, Aug 05, 2016 at 08:02:31AM +0000, Eric Wong wrote:
> 
> > > I just introduced another doubly-linked list in [1]. It adds some MRU
> > > features on top of the list, but it could in theory be built on top of a
> > > generic doubly-linked list.
> > 
> > Yes, and you'd be avoiding the extra mallocs and be able to use
> > list_entry (aka `container_of`) so it could be faster, too.
> 
> I'm not sure which mallocs you mean. I allocate one struct per node,
> which seems like a requirement for a linked list. If you mean holding an
> extra list struct around an existing pointer (rather than shoving the
> prev/next pointers into the pointed-to- item), then yes, we could do
> that. But it feels like a bit dirty, since the point of the list is
> explicitly to provide an alternate ordering over an existing set of
> items.

This pattern to avoid that one malloc-per-node using list_entry
(container_of) is actually a common idiom in the Linux kernel
and Userspace RCU (URCU).  Fwiw, I find it less error-prone and
easier-to-follow than the "void *"-first-element thing we do
with hashmap.

> It also doesn't make a big difference for my use case. All I really care
> about is the speed of delete-from-middle-and-insert-at-front, which is
> trivially O(1) and involves no mallocs.
> 
> > I was thinking packed_git could also be a doubly-linked list
> > anyways since it would allow easier removal of unlinked pack
> > entries.  My use case would be long-running "cat-file --batch"
> > processes being able to detect unlinked packs after someone
> > else runs GC.
> 
> We never remove packed_git structs, but it is not because of the list
> data structure. We may be holding open mmaps to packs that are deleted
> and continue using them. And in some cases other code may even hold
> pointers to our packed_git structs. So you'd have to figure out some
> memory ownership questions first.

Yes, it's easier to replace a running process once in a while :)
