Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A65C54EE9
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 18:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbiIVS6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 14:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiIVS6U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 14:58:20 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249B1E7C27
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 11:58:19 -0700 (PDT)
Received: (qmail 6923 invoked by uid 109); 22 Sep 2022 18:58:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Sep 2022 18:58:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4706 invoked by uid 111); 22 Sep 2022 18:58:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Sep 2022 14:58:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 22 Sep 2022 14:58:17 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai <johncai86@gmail.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 1/3] fsck: free tree buffers after walking unreachable
 objects
Message-ID: <YyywSdrWO61Kza0e@coredump.intra.peff.net>
References: <Yyw0PSVe3YTQGgRS@coredump.intra.peff.net>
 <Yyw031PqCyYlEqCX@coredump.intra.peff.net>
 <xmqqa66rz20q.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa66rz20q.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2022 at 11:40:05AM -0700, Junio C Hamano wrote:

> > diff --git a/builtin/fsck.c b/builtin/fsck.c
> > index f7916f06ed..34e575a170 100644
> > --- a/builtin/fsck.c
> > +++ b/builtin/fsck.c
> > @@ -228,6 +228,8 @@ static void mark_unreachable_referents(const struct object_id *oid)
> >  
> >  	options.walk = mark_used;
> >  	fsck_walk(obj, NULL, &options);
> > +	if (obj->type == OBJ_TREE)
> > +		free_tree_buffer((struct tree *)obj);
> >  }
> 
> Unlike codepaths like mark_object(), which uses the REACHABLE bit to
> avoid the walker coming into an already marked objects, we have no
> protection that says "this tree is already marked as USED, so lets
> not go into its contents" (it would be a disaster if we free tree
> buffer here and then later end up calling the function on the same
> tree), but it is OK because this is an unreachable object nobody
> points at and we will never come back?

I do think it is true that this is the final time we'd look at these
objects. But I don't think it would be a disaster if somebody did. The
free_tree_buffer() function clears the "parsed" flag on the struct. And
anybody wishing to look at the tree contents would need to call
parse_tree(), which would then re-load the contents.

In general, that's _possibly_ less efficient if we visit the same tree
twice, but it would be balanced against not holding all of the tree data
in RAM at once. And as I said, that doesn't happen for this use case
anyway.

As a side note, IMHO having tree->buffer at all is a mistake, because it
leads to exactly this kind of confusion about when the buffer should be
discarded. We'd be better off having all callers parse directly into a
local buffer, and then clean up when they're done. It effectively ends
up the same, except then it's obvious when a tree is "leaked" because
the local buffer goes out of scope, rather than hanging around in the
global struct and just wasting memory. But that's obviously a much
bigger change.

-Peff
