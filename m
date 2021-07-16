Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D9CC636CA
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 21:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5502613E3
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 21:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbhGPVTg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 17:19:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:52410 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230430AbhGPVTg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 17:19:36 -0400
Received: (qmail 22069 invoked by uid 109); 16 Jul 2021 21:16:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 Jul 2021 21:16:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14577 invoked by uid 111); 16 Jul 2021 21:16:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Jul 2021 17:16:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 16 Jul 2021 17:16:40 -0400
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
Message-ID: <YPH3OOOfK9RVebqZ@coredump.intra.peff.net>
References: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
 <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
 <patch-2.4-867e8e9a6c-20210714T172251Z-avarab@gmail.com>
 <871ea493-e108-e748-0234-f929690ad2fd@ahunt.org>
 <YPCrvOce5qRWk6Rq@coredump.intra.peff.net>
 <87wnpqy8zd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wnpqy8zd.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 09:46:33AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I can't say I _love_ any of that, but I think it would work (and
> > probably we'd adapt our helpers like git_config_pathname() to take a
> > def_string. Or I guess just have a def_string_free() which can be called
> > before writing into them).
> >
> > But maybe there's a better solution I'm missing.
> 
> Instead of: "int from_heap" in your "def_string" I think we should just
> use "struct string_list_item". I.e. you want a void* here. Why?

Yes, an equivalent way to write it is with a separate to_free buffer.
But why would we want it to be void? And why would we want to use a
string_list_item, which is otherwise unrelated?

> Well, tying this back to my clear() improvements for string-list.h I
> thought a really neat solution to this was:
> 
>     string_list_append(list, ptr)->util = on_heap_now_we_own_it;
>     string_list_append(list, mydup)->util = mydup;
> 
> I.e. by convention we store the pointer we need to free (if any) in the
> "util" field.

That works, but now "util" is not available for all the _other_ uses for
which it was intended. And if we're not using it for those other uses,
then why does it need to exist at all? If we are only using it to hold
the allocated string pointer, then shouldn't it be "char *to_free"?

> We're not in the habit of passing loose "string_list_item" around now,
> but I don't see why we wouldn't (possibly with a change to extract that
> bit out, so we could use it in other places).

It seems unnecessarily confusing to me. It sounds like you have a struct
which just _happens_ to have a "void *" in it you can re-use, so you
start using it in lots of other places that are not in fact string lists
at all. That is confusing to me on the face, but what happens when
string_list needs a feature which requires adding more fields to it?

If the point is to have a maybe-allocated string, why not make that a
type itself? And then if we want string_list to use it, it can.

> The neat thing about doing this is also that you're not left with every
> API boundary needing to deal with your new "def_string", a lot of them
> use string_list already, and hardly need to change anything, to the
> extent that we do need to change anything having a "void *util" is a lot
> more generally usable. You end up getting memory management for free as
> you gain a feature to pass arbitrary data along with your items.

I don't think most interfaces take a string_list_item now, so wouldn't
they similarly need to be changed? Though the point is that all of these
degrade to a regular C-string, so when you are just passing the value
(and not ownership), you would just dereference at that point.

-Peff
