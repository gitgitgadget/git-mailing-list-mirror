Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4420CC77B7C
	for <git@archiver.kernel.org>; Fri,  5 May 2023 21:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjEEVj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 17:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjEEVjy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 17:39:54 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DE944B7
        for <git@vger.kernel.org>; Fri,  5 May 2023 14:39:48 -0700 (PDT)
Received: (qmail 4732 invoked by uid 109); 5 May 2023 21:39:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 May 2023 21:39:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4472 invoked by uid 111); 5 May 2023 21:39:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 May 2023 17:39:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 May 2023 17:39:46 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3] builtin/pack-objects.c: introduce
 `pack.extraCruftTips`
Message-ID: <20230505213946.GC3321533@coredump.intra.peff.net>
References: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
 <27a7f16aab35b5cac391d9831aadb0f2e2146313.1683151485.git.me@ttaylorr.com>
 <xmqqv8h9m2az.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv8h9m2az.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 03, 2023 at 04:18:44PM -0700, Junio C Hamano wrote:

> > +	When generating a cruft pack, use the shell to execute the
> > +	specified command(s), and interpret their output as additional
> > +	tips of objects to keep in the cruft pack, regardless of their
> 
> What is a "tip of an object"?  The first byte ;-)?
> 
> A "tip of history" would only imply commit objects, but presumably
> you would want to specify a tree and protect all the blobs and trees
> it recursively contains, so that is not a good name for it.

"tips of the object graph" perhaps?

> > +		if (parse_oid_hex(buf.buf, &oid, &rest) || *rest) {
> > +			ret = error(_("invalid extra cruft tip: '%s'"), buf.buf);
> > +			goto done;
> > +		}
> > +
> > +		type = oid_object_info(the_repository, &oid, NULL);
> > +		if (type < 0)
> > +			continue;
> > +
> > +		obj = lookup_object_by_type(the_repository, &oid, type);
> > +		if (!obj)
> > +			continue;
> 
> Hmph, we may want to have an interface that lets us avoid looking up
> the same oid twice in the same set of tables.  Given an object
> unseen so far, oid_object_info() should have done most of the work
> necessary for lookup_object_by_type() to get to and start parsing
> the data of the object in the good case (i.e. object exists and in a
> pack---just we haven't needed it yet), but in the above sequence
> there is not enough information passed between two calls to take
> advantage of it.

This code was my suggestion, but it may have actually been a bad
direction.

I don't think communicating between oid_object_info() and
lookup_object_by_type() is important. The latter is only doing a lookup
in the internal hash with lookup_object(), and then auto-vivifying using
the type if necessary (which we provide to it).

The bigger inefficiency is that we call oid_object_info() before seeing
if we have already instantiated an object struct via lookup_object().

Obviously we could do that first. But let's take a step back. My
original suggestion was thinking that we don't want to call
parse_object() because it's expensive, especially for a blob. But in the
long run, most of these objects (except blobs!) will end up parsed
anyway, because we are going to see which other objects they reach.

So it's OK to parse anything except blobs. And indeed, we have a better
tool for that these days:

  obj = parse_object_with_flags(r, oid, PARSE_OBJECT_SKIP_HASH_CHECK);

That does exactly what we want. If we already saw and parsed the object,
it's quick noop after a hash lookup. If we didn't, then it already has
optimizations to avoid reading object contents if possible (checking the
commit graph, checking the type for blobs).

Skipping the hash check might seem like a bad idea for a repack, but
it's what we already do for blobs found via traversing. A disk repack
uses the much cheaper pack idx crc for exactly this purpose: to avoid
expanding objects unnecessarily.

-Peff
