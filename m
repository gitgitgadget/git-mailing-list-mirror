Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1483DC2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 19:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F078461108
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 19:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhFVTKo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 15:10:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:36278 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232614AbhFVTKn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 15:10:43 -0400
Received: (qmail 6572 invoked by uid 109); 22 Jun 2021 19:08:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Jun 2021 19:08:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29621 invoked by uid 111); 22 Jun 2021 19:08:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Jun 2021 15:08:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Jun 2021 15:08:26 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 5/5] load_ref_decorations(): avoid parsing non-tag objects
Message-ID: <YNI1KmkGTYDCW3jZ@coredump.intra.peff.net>
References: <YNIJw/8p0F3cPfzd@coredump.intra.peff.net>
 <YNILCDz3LpHX7OX0@coredump.intra.peff.net>
 <a93690bc-1d33-0fe0-5ca8-0e8baa9c66e6@gmail.com>
 <YNIYqFFFti73UT5+@coredump.intra.peff.net>
 <87zgvh20j3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zgvh20j3.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 22, 2021 at 08:27:53PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Whoops, thanks for catching that. I originally called it "enum
> > object_type type", but then of course the compiler informed that there
> > was already a "type" variable in the function. So I renamed it to
> > "objtype" but missed updating that line. But it still compiled. Yikes. :)
> 
> [Enter Captain Hindsight]
> 
> If you use a slightly different coding style and leverage the
> information the compiler has to work with you'd get it to error for you,
> e.g. this on your original patch would catch it:
> 
> 	diff --git a/log-tree.c b/log-tree.c
> 	index 8b700e9c142..7e3a011b533 100644
> 	--- a/log-tree.c
> 	+++ b/log-tree.c
> 	@@ -157,9 +157,12 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
> 	 	}
> 	 
> 	 	objtype = oid_object_info(the_repository, oid, NULL);
> 	-	if (type < 0)
> 	+	switch (type) {
> 	+	case OBJ_BAD:
> 	 		return 0;
> 	-	obj = lookup_object_by_type(the_repository, oid, objtype);
> 	+	default:
> 	+		obj = lookup_object_by_type(the_repository, oid, objtype);
> 	+	}
> 	 
> 	 	if (starts_with(refname, "refs/heads/"))
> 	 		type = DECORATION_REF_LOCAL;

Yeah, I agree that would find it in this case. I do find that style
slightly harder to read, though. And...

> IMO the real problem is an over-reliance on C being so happy to treat
> enums as ints (well, with them being ints). If you consistently use
> labels you get the compiler to do the checking. For me with gcc and
> clang with that on top:
> 	
> 	log-tree.c:161:2: error: case value ‘4294967295’ not in enumerated type ‘enum decoration_type’ [-Werror=switch]
> 	  case OBJ_BAD:
> 	  ^~~~
> 	log-tree.c:161:7: error: case value not in enumerated type 'enum decoration_type' [-Werror,-Wswitch]
> 	        case OBJ_BAD:
> 	             ^

...it would help in this case because OBJ_BAD happens to have a value
that is not defined for decoration_type. If it did, then the compiler
would be quite happy to consider them equivalent.

So I don't disagree with you exactly, but I'm not sure of the tradeoff
of always using switches instead of conditionals (which IMHO is less
readable) for more compiler safety that only works sometimes is worth
it.

> I think we've disagreed on that exact point before recently, i.e. you
> think we shouldn't rely on OBJ_BAD in that way, and instead check for
> any negative value:
> https://lore.kernel.org/git/YHCZh5nLNVEHCWV2@coredump.intra.peff.net/

To be clear, my complaint about checking for OBJ_BAD exactly is that it
closes the door on other negative return types. And indeed, the switch()
you showed above would become a silent bug if we introduced
OBJ_BAD_FOR_ANOTHER_READ as "-2" (without any compiler support, because
of the "default" case in the switch statement).

Now that's somewhat hypothetical, but in the near-term it also means
confirming that any of the functions which get converted from "int" to
"enum object_type" are not in fact passing back "-2" in any
circumstances.

That said...

> In practice I don't think it's too verbose, because once you start
> consistently using the pattern you'll usually not be doing conversions
> all over the place, and would just do this sort of thing via a helper
> that does the type checking, e.g. something like this (or anything else
> where you don't lose the type & labels):
> [...]
> 	-	objtype = oid_object_info(the_repository, oid, NULL);
> 	-	if (type < 0)
> 	+	if (!oid_object_info_ok(the_repository, oid, &type, NULL))
> 	 		return 0;

Yes, that would deal with that problem. It's definitely a different
style, but one that I could get used to. It's a lot more object oriented
("you are not allowed to do numeric logic on an object type; you can
only use these accessor methods to query it"). If we were going that
route, I would stop having "enum object_type" at all, and instead make
it "struct object_type { enum { ... } value }". That would prevent
anybody from accidentally just looking at it, and instead force people
into that object-oriented style.

I dunno. It is is a big departure from how we do things now. And the bug
here notwithstanding, I don't feel like enum confusion has generally
been a big source of error for us.

-Peff
