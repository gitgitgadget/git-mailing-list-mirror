Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DE8C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 07:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A83D6103A
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 07:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242839AbhIAHyu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 03:54:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:36126 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230161AbhIAHys (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 03:54:48 -0400
Received: (qmail 15783 invoked by uid 109); 1 Sep 2021 07:53:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Sep 2021 07:53:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4575 invoked by uid 111); 1 Sep 2021 07:53:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Sep 2021 03:53:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Sep 2021 03:53:51 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Andrzej Hunt <andrzej@ahunt.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/4] SANITIZE tests: fix memory leaks in t13*config*,
 add to whitelist
Message-ID: <YS8xj9XtKqEEy/Bb@coredump.intra.peff.net>
References: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
 <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
 <patch-2.4-867e8e9a6c-20210714T172251Z-avarab@gmail.com>
 <871ea493-e108-e748-0234-f929690ad2fd@ahunt.org>
 <YPCrvOce5qRWk6Rq@coredump.intra.peff.net>
 <87wnpqy8zd.fsf@evledraar.gmail.com>
 <YPH3OOOfK9RVebqZ@coredump.intra.peff.net>
 <87y28hwylq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y28hwylq.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 02:47:01PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > That works, but now "util" is not available for all the _other_ uses for
> > which it was intended. And if we're not using it for those other uses,
> > then why does it need to exist at all? If we are only using it to hold
> > the allocated string pointer, then shouldn't it be "char *to_free"?
> 
> Because having it be "char *" doesn't cover the common case of
> e.g. getting an already allocated "struct something *" which contains
> your string, setting the "string" in "struct string_list_item" to some
> string in that struct, and the "util" to the struct itself, as we now
> own it and want to free() it later in its entirety.

OK. I buy that storing a void pointer makes it more flexible. I'm not
altogether convinced this pattern is especially common, but it's not any
harder to work with than a "need_to_free" flag, so there's no reason not
to do that (and to be fair, I didn't look around for possible uses of
the pattern; it's just not one I think of as common off the top of my
head).

> That and the even more common case I mentioned upthread of wanting to
> ferry around the truncated version of some char *, but still wanting to
> account for the original for an eventual free().
> 
> But yes, if you want to account for freeing that data *and* have util
> set to something else you'll need to have e.g. your own wrapper struct
> and your own string_list_clear_func() callback.

But stuffing it into the util field of string_list really feels like a
stretch, and something that would make existing string_list use painful.
There are tons of cases where util points to some totally unrelated (in
terms of memory ownership) item. I'd venture to say most cases where
string_list_clear() is called without free_util would count here.

> > I don't think most interfaces take a string_list_item now, so wouldn't
> > they similarly need to be changed? Though the point is that all of these
> > degrade to a regular C-string, so when you are just passing the value
> > (and not ownership), you would just dereference at that point.
> 
> Sure, just like things would need to be changed to handle your proposed
> "struct def_string".
> 
> By piggy-backing on an already used struct in our codebase we can get a
> lot of that memory management pretty much for free without much
> churn.
> 
> If you squint and pretend that "struct string_list_item" isn't called
> something to do with that particular collections API (but it would make
> use of it) then we've already set up most of the scaffolding and
> management for this.

It's that squinting that bothers me. Sure, it's _kinda_ similar. And I
don't have any problem with some kind of struct that says "this is a
string, and when you are done with it, this is how you free it". And I
don't have any problem with building the "dup" version of string_list
with that struct as a primitive. But it seems to me to be orthogonal
from the "util" pointer of a string_list, which is about creating a
mapping from the string to some other thing (which may or may not
contain the string, and may or may not be owned).

TBH, I have always found the "util" field of string_list a bit ugly (and
really most of string_list). I think most cases would be better off with
a different data structure (a set or a hash table), but we didn't have
convenient versions of those for a long time. I don't mind seeing
conversions of string_list to other data structures. But that seems to
be working against using string_list's string struct in more places.

-Peff
