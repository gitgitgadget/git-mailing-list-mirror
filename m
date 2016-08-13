Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3DBA20193
	for <e@80x24.org>; Sat, 13 Aug 2016 09:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180AbcHMJY5 (ORCPT <rfc822;e@80x24.org>);
	Sat, 13 Aug 2016 05:24:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:54712 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751418AbcHMJY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2016 05:24:57 -0400
Received: (qmail 2906 invoked by uid 109); 13 Aug 2016 09:23:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Aug 2016 09:23:33 +0000
Received: (qmail 28224 invoked by uid 111); 13 Aug 2016 09:23:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Aug 2016 05:23:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Aug 2016 05:23:31 -0400
Date:	Sat, 13 Aug 2016 05:23:31 -0400
From:	Jeff King <peff@peff.net>
To:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: introduce set_merge_remote_desc()
Message-ID: <20160813092330.vmy2hip4papyuula@sigill.intra.peff.net>
References: <57AEE4F7.7090804@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57AEE4F7.7090804@web.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Aug 13, 2016 at 11:14:31AM +0200, René Scharfe wrote:

> Add a helper function for allocating, populating and attaching struct
> merge_remote_desc to a commit and use it consistently.  It allocates the
> necessary memory in a single block.
> 
> commit.c::get_merge_parent() forgot to check for memory allocation
> failures of strdup(3).
> 
> merge-recursive.c::make_virtual_commit() didn't duplicate the string for
> the name member, even though one of it's callers (indirectly through
> get_ref()) may pass the result of oid_to_hex(), i.e. a static buffer.

It seems like you've buried the interesting part here. This isn't just
for cleanup, but a bugfix that the oids in our virtual commits might get
overwritten by subsequent actions.

It seems like that should be the subject and beginning of the commit
message.  And then the fix is to allocate, and by the way we can do so
easily with this nice new helper. :)

> diff --git a/commit.c b/commit.c
> index 71a360d..372b200 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1576,6 +1576,15 @@ int commit_tree_extended(const char *msg, size_t msg_len,
>  	return result;
>  }
>  
> +void set_merge_remote_desc(struct commit *commit,
> +			   const char *name, struct object *obj)
> +{
> +	struct merge_remote_desc *desc;
> +	FLEXPTR_ALLOC_STR(desc, name, name);
> +	desc->obj = obj;
> +	commit->util = desc;
> +}

I don't think there is any reason to prefer FLEXPTR_ALLOC over
FLEX_ALLOC, unless your struct interface is constrained by non-flex
users (that's why it is necessary for "struct exclude", for example,
which sometimes needs to carry its own string and sometimes not).

Using FLEX_ALLOC saves a few bytes per struct, and avoids an extra
pointer indirection when accessing the data.

Since it looks like you touch all of the allocations here, I think they
would both be happy as a regular flex array.

-Peff
