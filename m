Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC2A4211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 20:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeLEURa (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 15:17:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:60118 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727402AbeLEURa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 15:17:30 -0500
Received: (qmail 7105 invoked by uid 109); 5 Dec 2018 20:17:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Dec 2018 20:17:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2108 invoked by uid 111); 5 Dec 2018 20:16:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 05 Dec 2018 15:16:58 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Dec 2018 15:17:28 -0500
Date:   Wed, 5 Dec 2018 15:17:28 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Geert Jansen <gerardu@amazon.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Takuto Ikuta <tikuta@chromium.org>
Subject: Re: [PATCH 8/9] sha1-file: use loose object cache for quick
 existence check
Message-ID: <20181205201728.GA19936@sigill.intra.peff.net>
References: <87bm6u2akf.fsf@evledraar.gmail.com>
 <878t1x2t3e.fsf@evledraar.gmail.com>
 <221cb2e4-a024-e301-2b3f-e37dcd93795e@web.de>
 <20181203220424.GA11883@sigill.intra.peff.net>
 <fe388ba5-765e-ff83-e610-d40964a76a0c@web.de>
 <20181205044645.GA12284@sigill.intra.peff.net>
 <54e7a97d-501c-1aa7-55cd-83f070d05a8c@web.de>
 <20181205065136.GA27263@sigill.intra.peff.net>
 <20181205081544.GA9271@sigill.intra.peff.net>
 <48ab861b-46c8-2bd5-0508-fa106efd8e56@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48ab861b-46c8-2bd5-0508-fa106efd8e56@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 05, 2018 at 07:41:44PM +0100, René Scharfe wrote:

> > If we start to convert those, there's a
> > little bit of a rabbit hole, but it's actually not too bad.
> 
> You don't need to crawl in just for quick_has_loose(), but eventually
> everything has to be converted.  It seems a bit much for one patch, but
> perhaps that's just my ever-decreasing attention span speaking.

Yeah, my normal process here is to dig to the bottom of the rabbit hole,
and then break it into actual patches. I just shared the middle state
here. ;)

I suspect the http bits could be split off into their own thing. The
bits in sha1-file.c I'd plan to mostly do all together, as they are
a family of related functions.

Mostly I wasn't sure how to wrap this up with the other changes. It's
obviously pretty invasive, and I don't want it to get in the way of
actual functional changes we've been discussing.

> > @@ -879,15 +879,15 @@ int git_open_cloexec(const char *name, int flags)
> >   * Note that it may point to static storage and is only valid until another
> >   * call to stat_sha1_file().
> >   */
> > -static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
> > -			  struct stat *st, const char **path)
> > +static int stat_loose_object(struct repository *r, const struct object_id *oid,
> > +			     struct stat *st, const char **path)
> 
> Hmm, read_sha1_file() was renamed to read_object_file() earlier this
> year, and I'd have expected this to become stat_object_file().  Names..

read_object_file() is about reading an object from _any_ source. These
are specifically about loose objects, and I think that distinction is
important (both here and for map_loose_object, etc).

I'd actually argue that read_object_file() should just be read_object(),
but that already exists. Sigh. (I think it's fixable, but obviously
orthogonal to this topic).

> Anyway, the comment above and one a few lines below should be updated
> as well.

Thanks, fixed.

> >  static int open_sha1_file(struct repository *r,
> > -			  const unsigned char *sha1, const char **path)
> > +			  const struct object_id *oid, const char **path)
> 
> That function should lose the "sha1" in its name as well.

Yep, fixed.

> > -static void *unpack_sha1_rest(git_zstream *stream, void *buffer, unsigned long size, const unsigned char *sha1)
> > +static void *unpack_loose_rest(git_zstream *stream,
> > +			       void *buffer, unsigned long size,
> > +			       const struct object_id *oid)
> 
> Hmm, both old and new name here look weird to me at this point.

It makes more sense in the pairing of unpack_sha1_header() and
unpack_sha1_rest(). Maybe "body" would be better than "rest".

At any rate, it probably makes sense to rename them together (but I
didn't touch the "header" one here). Maybe the name changes should come
as a separate patch. I was mostly changing them here because I was
changing the signatures anyway, and had to touch all of the callers.

-Peff
