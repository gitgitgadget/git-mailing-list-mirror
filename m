Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F7F22018E
	for <e@80x24.org>; Fri,  5 Aug 2016 09:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965351AbcHEJOx (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 05:14:53 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57196 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934429AbcHEJOu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 05:14:50 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 626AD2018E;
	Fri,  5 Aug 2016 09:14:32 +0000 (UTC)
Date:	Fri, 5 Aug 2016 09:14:32 +0000
From:	Eric Wong <e@80x24.org>
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>,
	Lukas =?utf-8?Q?Sandstr=C3=B6m?= <luksan@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2016, #02; Thu, 4)
Message-ID: <20160805091432.GB30906@starla>
References: <xmqqshukyxqw.fsf@gitster.mtv.corp.google.com>
 <20160804233435.GA31403@dcvr>
 <20160805074552.6ow4h3lwdy7yxqva@sigill.intra.peff.net>
 <20160805080231.GA25379@starla>
 <20160805081103.t5f4bapmia6vircg@sigill.intra.peff.net>
 <20160805082630.GA29383@starla>
 <20160805083446.3bweapo4pxsjrgcs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160805083446.3bweapo4pxsjrgcs@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Fri, Aug 05, 2016 at 08:26:30AM +0000, Eric Wong wrote:
> 
> > > I'm not sure which mallocs you mean. I allocate one struct per node,
> > > which seems like a requirement for a linked list. If you mean holding an
> > > extra list struct around an existing pointer (rather than shoving the
> > > prev/next pointers into the pointed-to- item), then yes, we could do
> > > that. But it feels like a bit dirty, since the point of the list is
> > > explicitly to provide an alternate ordering over an existing set of
> > > items.
> > 
> > This pattern to avoid that one malloc-per-node using list_entry
> > (container_of) is actually a common idiom in the Linux kernel
> > and Userspace RCU (URCU).  Fwiw, I find it less error-prone and
> > easier-to-follow than the "void *"-first-element thing we do
> > with hashmap.
> 
> My big problem with it is that it gets confusing when a particular
> struct is a member of several lists. We have had bugs in git where
> a struct ended up being used in two different lists, but accidentally
> using the same "next" pointer.

It might actually be easier since you would rarely (if ever)
touch the "next"/"prev" fields in your code.  This encourages
users to give meaningful names to list_head fields.

> So you need one "list_head" for each list that your struct may be a part
> of. Sometimes that's simple, but it's awkward when the code which wants
> the list is different than the code which "owns" the struct. Besides
> leaking concerns across modules, the struct may not want to pay the
> memory price for storing pointers for all of the possible lists it could
> be a member of.

Yes, the key is this list is flexible enough to be used either way:

	/* there are millions of these structs in practice */
	struct common_struct {
		struct list_head hot_ent;
		...
	};

	/* and only a handful of these */
	struct rarely_used_wrapper {
		struct list_head cold_ent;
		struct common_struct *common;
		...
	};

> For instance, I think it would be a mistake to convert the current
> commit_list code to something like this.

Of course, often a doubly-linked list is not needed or the extra
pointer is too expensive.  Linux/URCU have hlist for this reason.

I'm no expert on git internals, either; but there can be
readability improvements, too.  For example, I find http-walker.c
is easier-to-follow after 94e99012fc7a
("http-walker: reduce O(n) ops with doubly-linked list")
