Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9065820401
	for <e@80x24.org>; Sun, 18 Jun 2017 13:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752992AbdFRN40 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Jun 2017 09:56:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:42343 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752950AbdFRN40 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jun 2017 09:56:26 -0400
Received: (qmail 14246 invoked by uid 109); 18 Jun 2017 13:56:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 18 Jun 2017 13:56:25 +0000
Received: (qmail 21008 invoked by uid 111); 18 Jun 2017 13:56:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 18 Jun 2017 09:56:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Jun 2017 09:56:23 -0400
Date:   Sun, 18 Jun 2017 09:56:23 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [BUG] add_again() off-by-one error in custom format
Message-ID: <20170618135623.3b27zhzdxur6gpg3@sigill.intra.peff.net>
References: <xmqqtw3j68rc.fsf@gitster.mtv.corp.google.com>
 <99d19e5a-9f79-9c1e-3a23-7b2437b04ce9@web.de>
 <xmqqwp8f4mb2.fsf@gitster.mtv.corp.google.com>
 <dae96f72-761c-3ed1-4567-0933acc7618a@web.de>
 <20170615055654.efvsouhr3leszz3i@sigill.intra.peff.net>
 <ec36f9fa-5f3e-b511-3985-3d0301b4847f@web.de>
 <20170615132532.nivmj22dctowxssm@sigill.intra.peff.net>
 <b0bc9dab-bd93-c321-9f2e-f1621f857708@web.de>
 <20170618114923.bffmbr5dqe4oivyw@sigill.intra.peff.net>
 <96c26ba2-8548-1693-e803-3a3434ae3a62@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96c26ba2-8548-1693-e803-3a3434ae3a62@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 18, 2017 at 02:59:04PM +0200, René Scharfe wrote:

> > > @@ -1586,6 +1587,9 @@ extern struct alternate_object_database {
> > >   	struct strbuf scratch;
> > >   	size_t base_len;
> > > +	uint32_t loose_objects_subdir_bitmap[8];
> > 
> > Is it worth the complexity of having an actual bitmap and not just an
> > array of char? I guess it's not _that_ complex to access the bits, but
> > there are a lot of magic numbers involved.
> 
> That would be 224 bytes more per alternate_object_database, and we'd
> gain simpler code.  Hmm.  We could add some bitmap helper macros, but
> you're probably right that the first version should use the simplest
> form for representing small bitmaps that we currently have.

I'd be OK with keeping it if we could reduce the number of magic
numbers. E.g,. rather than 32 elsewhere use:

  (sizeof(*loose_objects_subdir_bitmap) * CHAR_BIT)

and similarly rather than 8 here use

  256 / sizeof(*loose_objects_subdir_bitmap) / CHAR_BIT

There's also already a bitmap data structure in ewah/bitmap.c. It's a
little bit overkill, though, because it mallocs and will grow the bitmap
as needed.

> > We should probably insert a comment here warning that the cache may go
> > out of date during the process run, and should only be used when that's
> > an acceptable tradeoff.
> 
> Then we need to offer a way for opting out.  Through a global variable?
> (I'd rather reduce their number, but don't see how allow programs to
> nicely toggle this cache otherwise.)

Sorry, I didn't mean disabling it for a particular run of a program. I
just meant that we know this is an OK tradeoff for short-sha1 lookups,
but has_sha1_file(), for example, would never want to use it. So we are
warning programmers from using it in more code, not giving users a way
to turn it off run-to-run.

> > > +static void read_loose_object_subdir(struct alternate_object_database *alt,
> > > +				     int subdir_nr)
> > 
> > I think it's nice to pull this out into a helper function. I do wonder
> > if it should just be reusing for_each_loose_file_in_objdir(). You'd just
> > need to expose the in_obj_subdir() variant publicly.
> > 
> > It does do slightly more than we need (for the callbacks it actually
> > builds the filename), but I doubt memcpy()ing a few bytes would be
> > measurable.
> 
> Good point.  The function also copies the common first two hex digits
> for each entry.  But all that extra work is certainly dwarfed by the
> readdir calls.

Yes. You're welcome to micro-optimize that implementation if you want. ;)

-Peff
