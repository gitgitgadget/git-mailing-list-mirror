Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCCDC433ED
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 05:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEBF76120E
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 05:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbhDNFSu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 01:18:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:52000 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230375AbhDNFSt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 01:18:49 -0400
Received: (qmail 3245 invoked by uid 109); 14 Apr 2021 05:18:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Apr 2021 05:18:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4150 invoked by uid 111); 14 Apr 2021 05:18:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Apr 2021 01:18:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Apr 2021 01:18:27 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] is_promisor_object(): free tree buffer after parsing
Message-ID: <YHZ7Iy29FS9SjKjT@coredump.intra.peff.net>
References: <YHVECXHfZ1bidTJH@coredump.intra.peff.net>
 <YHVFKgn7WN76QnRz@coredump.intra.peff.net>
 <xmqqtuoakkgc.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtuoakkgc.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 01:17:55PM -0700, Junio C Hamano wrote:

> > diff --git a/packfile.c b/packfile.c
> > index 8668345d93..b79cbc8cd4 100644
> > --- a/packfile.c
> > +++ b/packfile.c
> > @@ -2247,6 +2247,7 @@ static int add_promisor_object(const struct object_id *oid,
> >  			return 0;
> >  		while (tree_entry_gently(&desc, &entry))
> >  			oidset_insert(set, &entry.oid);
> > +		free_tree_buffer(tree);
> >  	} else if (obj->type == OBJ_COMMIT) {
> >  		struct commit *commit = (struct commit *) obj;
> >  		struct commit_list *parents = commit->parents;
> 
> Hmph, does an added free() without removing one later mean we've
> been leaking?

Yes. Though perhaps not technically a leak, in that we are still holding
on to the "struct tree" entries via the obj_hash table. But nobody was
freeing them at all until the end of the program.

I actually think it may be a mistake for "struct tree" to have
buffer/len fields at all. It is a slight convenience to be able to pass
them around with the struct, but it makes the expected lifetime much
more confusing. In practice, all code wants to deal with one tree at a
time, then drop the buffer when it's done (we might hold several when
recursing through subtrees, but we'd never hold more than the distance
from the leaf to the root, and each recursive invocation of something
like process_tree() is holding exactly one tree buffer).

It may not be worth the trouble to try to clean it up at this point,
though.

-Peff
