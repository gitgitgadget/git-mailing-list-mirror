Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55BAC1F461
	for <e@80x24.org>; Thu,  5 Sep 2019 17:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387715AbfIERxG (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 13:53:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:40724 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726097AbfIERxG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 13:53:06 -0400
Received: (qmail 1001 invoked by uid 109); 5 Sep 2019 17:53:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Sep 2019 17:53:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29575 invoked by uid 111); 5 Sep 2019 17:54:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2019 13:54:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Sep 2019 13:53:05 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Stephan Beyer <s-beyer@gmx.net>, Paul Tan <pyokagan@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] Fix maybe-uninitialized warnings found by gcc 9 -flto
Message-ID: <20190905175304.GA23663@sigill.intra.peff.net>
References: <20190905082459.26816-1-s-beyer@gmx.net>
 <6c6c4e71-d9e5-1ad4-74db-12c323da42f7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c6c4e71-d9e5-1ad4-74db-12c323da42f7@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 05, 2019 at 07:08:49PM +0200, René Scharfe wrote:

> Anyway, my points are that simply initializing might not always be the
> best fix, and that more context would help reviewers of such a patch,
> but only if functions are reasonably short and it's not necessary to
> follow the rabbit into a call chain hole.

I started looking at these, too, and came to the same conclusion.  Some
of these are pointing to real bugs, and just silencing the warnings
misses the opportunity to find them.

I'll comment on the ones I did look at.

> Further context:
> 
> 	ident_line = find_commit_header(buffer, "author", &ident_len);
> 
> 	if (split_ident_line(&id, ident_line, ident_len) < 0)
> 		die(_("invalid ident line: %.*s"), (int)ident_len, ident_line);
> 
> find_commit_header() can return NULL.  split_ident_line() won't handle
> that well.  So I think what's missing here is a NULL check.  If the
> compiler is smart enough then that should silence the initialization
> warning.

Yeah, this one is a segfault waiting to happen, I think, if the author
line is missing.

> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index 76ce906946..d0c03b0e9b 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
> > @@ -1171,7 +1171,7 @@ static int add_object_entry(const struct object_id *oid, enum object_type type,
> >  {
> >  	struct packed_git *found_pack = NULL;
> >  	off_t found_offset = 0;
> > -	uint32_t index_pos;
> > +	uint32_t index_pos = 0;
> [...]
> So if the packing list is empty then it returns NULL without setting
> index_pos.  Hmm.  It does set it in all other cases, no matter if oid is
> found or not.  Is it really a good idea to make that exception?  I
> suspect always setting index_pos here would silence the compiler as well
> and fix the issue closer to its root.

Yeah, this is a weird one. That index_pos is actually a position in the
current hash table. And in the first object we see in pack-objects'
input, we definitely _do_ end up with a nonsense index_pos, which then
gets passed to packlist_alloc().

But since we also need to grow the hash table during that allocation, we
don't use index_pos at all. So setting index_pos to something known like
"0" is kind of weird, in that we don't have a hash position at all (the
table doesn't exist!). But it's probably the least bad thing. If we do
that, it should happen in packlist_find().

I have to agree this whole "passing around index_pos" thing looks
complicated. It seems like we're just saving ourselves one hash lookup
on insertion (and it's not even an expensive hash, since we're reusing
the oid).

I suspect the whole thing would also be a lot simpler using one of our
existing hash implementations.

> Didn't check the other cases.

The only other one I looked at was:

>> int cmd__read_cache(int argc, const char **argv)
>> {
>>-       int i, cnt = 1, namelen;
>>+       int i, cnt = 1, namelen = 0;

I actually saw this one the other day, because it triggered for me when
compiling with SANITIZE=address. AFAICT it's a false positive. "name" is
always NULL unless skip_prefix() returns true, in which case we always
set "namelen". And we only look at "namelen" if "name" is non-NULL.

This one doesn't even require LTO, because skip_prefix() is an inline
function. I'm not sure why the compiler gets confused here. I don't mind
initializing namelen to 0 to silence it, though (we already set name to
NULL, so this would just match).

-Peff
