Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20490C433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF6BB233E2
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391412AbhATQT0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:19:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:32970 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391335AbhATQTH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 11:19:07 -0500
Received: (qmail 26292 invoked by uid 109); 20 Jan 2021 16:18:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Jan 2021 16:18:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23289 invoked by uid 111); 20 Jan 2021 16:18:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Jan 2021 11:18:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 20 Jan 2021 11:18:11 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jacob Vosmaer <jacob@gitlab.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH v2 1/1] builtin/pack-objects.c: avoid iterating all refs
Message-ID: <YAhXw9Gvn5Pyvacq@coredump.intra.peff.net>
References: <20210120124514.49737-1-jacob@gitlab.com>
 <20210120124514.49737-2-jacob@gitlab.com>
 <YAhC8Gsp4H17e28n@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAhC8Gsp4H17e28n@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 20, 2021 at 09:49:20AM -0500, Taylor Blau wrote:

> > @@ -3740,7 +3738,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
> >  	}
> >  	cleanup_preferred_base();
> >  	if (include_tag && nr_result)
> > -		for_each_ref(add_ref_tag, NULL);
> > +		for_each_tag_ref(add_ref_tag, NULL);
> 
> OK. Seeing another caller (builtin/pack-objects.c:compute_write_order())
> that passes a callback to for_each_tag_ref() makes me feel more
> comfortable about using it here.

It actually made me wonder if that call might potentially be
problematic, too. ;)

It is not clear to me from the commit message if anybody actually looked
at how peel_ref() works, and whether there are any gotchas. I don't
think "there is another call like this" is compelling because we might
not notice any problem:

  - checking the ref_iterator's peeled value is an optimization; we'd
    expect to receive the correct answer but slower if it doesn't kick
    in

  - if the fallback code is looking up by refname, would it use the dwim
    rules and find an unqualified "v1.2.3". That would work most of the
    time, but fail if there was an ambiguous ref.

But looking at the implementation, I think the answer is "no". When
iterating over unqualified refs, the iterator stores a pointer to the
unqualified name, and so the optimization does kick in. And even if we
are not looking at a packed-refs value that can return the answer
quickly, we eventually end up in cache_ref_iterator_peel(), which
ignores the refname and directly peels the oid.

If we do not match the ref iterator, then we use read_ref_full(), which
doesn't do any dwim magic. And hence our unqualified refname would fail.
So it's a bit weird to pass such a refname into the function, but it
works because of the optimization magic. And if that ever changed, I
think the test suite would notice, since many peels would fail in that
case.

So I think both the existing and the new calls using for_each_tag_ref()
are OK here.

  As an aside, this peel_ref() interface is just awful, exactly because
  of this confusion. The nicest thing would be for the each_ref_fn
  callback to actually just get the peel information if we have it. But
  that would require changing tons of callbacks all over the code base,
  which is why we've never done it.

  But probably we would just peel by oid, and have the same "is it the
  current iterated ref" magic kick in. It doesn't matter if it's
  _actually_ the same ref or not. If two refs point to the same oid,
  then their peeled values are the same anyway.

  So that might be a nice cleanup, but definitely out of scope for this
  patch.

-Peff
