Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C293DC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 21:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E796128B
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 21:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbhGMVaN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 17:30:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:48304 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhGMVaN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 17:30:13 -0400
Received: (qmail 12257 invoked by uid 109); 13 Jul 2021 21:27:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Jul 2021 21:27:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14260 invoked by uid 111); 13 Jul 2021 21:27:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Jul 2021 17:27:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Jul 2021 17:27:21 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] load_ref_decorations(): fix decoration with tags
Message-ID: <YO4FObgRvpt1nVr0@coredump.intra.peff.net>
References: <YOzY+qNFM2GsgKMO@coredump.intra.peff.net>
 <20210713074018.232372-1-martin.agren@gmail.com>
 <YO1GNWjMol8JV8MR@coredump.intra.peff.net>
 <xmqqpmvl29ry.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpmvl29ry.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 13, 2021 at 02:17:53PM -0700, Junio C Hamano wrote:

> >> Note how this commit could have been done as an optimization before
> >> 88473c8bae: When our peeling hits a non-tag, we won't parse that tagged
> >> object only to immediately end the loop.
> >
> > Yep, thanks for mentioning this, as it's somewhat subtle.
> 
> It is too subtle that I am not sure what the paragraph wants to say.
> 
> Before 88473c8b, we had a fully parsed object in obj and entered the
> while() loop iff the outermost object is a tag, then we find the
> underlying object via obj->tagged.  We parse that underlying object
> to find if it is a tag, and break out if it is not.
> 
> By "this commit", I assume that the above mean the change in this
> fix, i.e. parse 'obj' if it has not been parsed before looking at
> its tagged field.  But I am not sure how that would have been an
> optimization before 88473c8b that gave a parsed tag object 'obj'
> upon entry to the loop.
> 
> Puzzled.

The optimization is that we are parsing tags before looking at their
structs, instead of always parsing the thing that the tag points to.

So in the old loop (pseudo-code for clarity):

  parse_object(obj);
  while (obj->type == OBJ_TAG) {
          obj = obj->tagged;
	  parse_object(obj);
  }

if we had a tag pointing to a commit, we'd parse the commit. But we
don't need to. We just need to know that it exists and is a commit.

In the new code, we parse only when we need to look at obj->tagged:

  while (obj->type == OBJ_TAG) {
          parse_object(obj);
	  obj = obj->tagged;
  }

So we must "somehow" know the type of "obj" in the first place, as well
as the type of every obj->tagged we look at. And that leads into your
question here:

> In any case, let's talk about this patch in the context to which it
> is designed to be applied, i.e. post 88473c8b3c8b.
> 
> When we come here, we have done oid_object_info() plus
> lookup_object_by_type() to obtain 'obj' and we know its type.
> Then we enter the loop.
> 
>  	while (obj->type == OBJ_TAG) {
> +		if (!obj->parsed)
> +			parse_object(the_repository, &obj->oid);
> 
> And we parse if it hasn't been parsed.  THat is why we can ...
> 
>  		obj = ((struct tag *)obj)->tagged;
>  		if (!obj)
>  			break;
> 
> ... look at its tagged member.
> 
> -		if (!obj->parsed)
> -			parse_object(the_repository, &obj->oid);
>  		add_name_decoration(DECORATION_REF_TAG, refname, obj);
> 
> And the updated 'obj' (i.e. direct referent of the tag object) is
> fed to add_name_decoration().  And then we move to the next
> iteration.
> 
> Now, do we know what type of object 'obj' is at this point?  We
> did parse the outermost tag upon entry to this loop, we replaced
> 'obj' variable with the referent by following the .tagged member,
> but we haven't parsed that object or ran oid_object_info() on it.
> 
> Puzzled.

...and the answer is that we don't need to parse it. The tag object
mentions the type of what it points to, and we use lookup_commit(), etc,
to create the object pointed to by its "tagged" field. If we can't do
that (say, because the tag is missing the type field, or we previously
saw the object as a different type, etc), then obj->tagged would be NULL
and we'd break out of the loop.

-Peff
