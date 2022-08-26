Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CB0ECAAA3
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 07:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245214AbiHZHKo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 03:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245215AbiHZHKj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 03:10:39 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5C5DF32
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 00:10:34 -0700 (PDT)
Received: (qmail 17990 invoked by uid 109); 26 Aug 2022 07:10:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Aug 2022 07:10:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4358 invoked by uid 111); 26 Aug 2022 07:10:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Aug 2022 03:10:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Aug 2022 03:10:32 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/11] annotating unused function parameters
Message-ID: <Ywhx6LLe6YcS/2xf@coredump.intra.peff.net>
References: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
 <220819.861qtc8gug.gmgdl@evledraar.gmail.com>
 <c22a8317-7d43-d84b-f63f-df2da31b4658@github.com>
 <220819.868rnk54ju.gmgdl@evledraar.gmail.com>
 <YwCtkwjWdJVHHZV0@coredump.intra.peff.net>
 <220825.86edx44lzh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220825.86edx44lzh.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 25, 2022 at 01:00:19PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > One, it feels like we're abusing the deprecated attribute here. The
> 
> Definitely, but structurally it seems like a better pick. I.e. isn't the
> only problem with it the "deprecated" and its interaction with
> -Wno-deprecated.
> 
> If the exact same feature existed as a "insert-custom-warning", which
> would work exactly "deprecated" without the default warning "prefix"
> would you think this would fit perfectly?

Yeah, I agree that would remove my complaint about overloading the
meaning. I don't think that exists, though.

> This is mildly annoying, but I don't really think it's a practical
> issue. We're talking about running this without
> -Wno-deprecated-declarations in CI, and by default.
> 
> For unused parameters it's enough that we're catching them somewhere, or
> in common compilation settings, we don't need to catch them
> *everywhere*, do we?

No, but the farther away you go from the edit-compile-run cycle, the
more painful warnings become. Catching them immediately and fully has
real value, as it means the cost of correcting them is lower. So all
things being equal, I think we should prefer universal solutions when
they're available (and for example compiler errors over say, coccinelle
or other analysis tools).

(And yes, I know all things sadly aren't equal; see below...)

> IOW is anyone writing patches where they're testing with
> -Wno-deprecated-declarations *and* adding unused parameters *and* won't
> test without -Wno-deprecated-declarations before submitting them, *and*
> nobody else will catch it?

Probably not. I don't actually build with -Wno-deprecated-declarations
routinely. But my fear is that some platform may be stuck there for a
while (because an overzealous libc marks something). But that's kind of
hypothetical, so we may have to just accept it and cross that bridge if
we come to it.

> > And finally, I actually prefer the parentheses of:
> >
> >   static int register_ref(const char *refname, const struct object_id *oid,
> > 			  int UNUSED(flags), void *UNUSED(cb_data))
> 
> ...and now to the real reason for the follow-up. You/Junio were CC'd,
> but this is breaking coccinelle, see:
> https://lore.kernel.org/git/220825.86ilmg4mil.gmgdl@evledraar.gmail.com/

Ugh. Yeah, that is really unfortunate. I much prefer the parenthesized
syntax, but if we can't find a way to unconfuse third-party parsing,
then switching is probably the least-bad solution.

-Peff
