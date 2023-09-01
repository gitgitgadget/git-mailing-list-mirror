Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F833CA0FF3
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 19:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346414AbjIATQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 15:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjIATQn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 15:16:43 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BF410DF
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 12:16:40 -0700 (PDT)
Received: (qmail 30790 invoked by uid 109); 1 Sep 2023 19:16:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 Sep 2023 19:16:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22336 invoked by uid 111); 1 Sep 2023 19:16:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Sep 2023 15:16:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 Sep 2023 15:16:39 -0400
From:   Jeff King <peff@peff.net>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] ref-filter: sort numerically when ":size" is used
Message-ID: <20230901191639.GA1955435@coredump.intra.peff.net>
References: <20230901142624.12063-1-five231003@gmail.com>
 <xmqqa5u5rgis.fsf@gitster.g>
 <20230901174540.GB1947546@coredump.intra.peff.net>
 <xmqqr0nhpyf3.fsf@gitster.g>
 <20230901183206.GA1952051@coredump.intra.peff.net>
 <ZPI0e1XzZrDV2fJk@five231003>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZPI0e1XzZrDV2fJk@five231003>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 02, 2023 at 12:29:07AM +0530, Kousik Sanagavarapu wrote:

> > > > I think they are covered implicitly by the "else" block of the
> > > > conditional that checks for FIELD_STR.
> > > 
> > > Ah, OK.  That needs to be future-proofed to force future developers
> > > who want to add different FIELD_FOO type to look at the comparison
> > > logic.  If we want to do so, it should be done as a separate topic
> > > for cleaning-up the mess, not as part of this effort.
> 
> What I also find weird is the fact that we assign a "cmp_type" to the
> whole atom. Like "contents" is FIELD_STR and "objectsize" is "FIELD_ULONG"
> in "valid_atom". This seems wrong because the options of the atoms should be
> the ones deciding the "cmp_type", no?

I think the data structure is a little confusing if you haven't worked
with it before. But basically each "atom" corresponds to a single "%()"
block in the format. So if you ran:

  git for-each-ref --format="%(contents:size) %(contents:body)"

you'd have two atoms in the used_atom struct: one for the size and one
for the body.

IMHO the code would be a lot easier to work with if the atoms were
structured as a parse tree with child pointers (especially when you get
into things like "if" that have sub-expressions). I think one of the
reasons that used_atom is an array is to de-duplicate repeated mentions
(so if you formatted "%(foo) %(foo)" it would only have to store the
computed value once).

But I think that is the wrong way to optimize it. We shouldn't be
storing any strings per-atom, but rather walking the parse tree to
produce a single output buffer. And the values should be cheap to fill
in, because we should parse the object as necessary up front. This is
more or less the way the pretty.c parser does it.

But that is all quite a large tangent from what you're working on, and
would probably be a ground-up rewrite of the formatting code. You can
safely ignore my rant for the purposes of your patch. ;)

> I wanted to leave the "cmp_type" field of the atom untouched because that
> would mess up this "global" setting of "contents" to be a "FIELD_STR" (or
> even "raw" for that matter). Although that seems like a bad idea, after
> I've read Junio's and your comments.

Yeah, I agree that would be a problem if there were one global
"contents". But we are allocating a new atom struct on the fly for the
contents:size directive that we parse, and so on.

-Peff
