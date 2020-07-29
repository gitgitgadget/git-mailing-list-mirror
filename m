Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B59C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 16:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE7B52075D
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 16:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgG2QdH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 12:33:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:41196 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgG2QdG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 12:33:06 -0400
Received: (qmail 7506 invoked by uid 109); 29 Jul 2020 16:33:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Jul 2020 16:33:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5878 invoked by uid 111); 29 Jul 2020 16:33:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jul 2020 12:33:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jul 2020 12:33:05 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 0/11] renaming argv_array
Message-ID: <20200729163305.GB2320983@coredump.intra.peff.net>
References: <20200728202124.GA1021264@coredump.intra.peff.net>
 <CAP8UFD26J6W50SeQqJiG0y04kcdNzr6RRT7ZeJmrQ2V-QTS3Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD26J6W50SeQqJiG0y04kcdNzr6RRT7ZeJmrQ2V-QTS3Lg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 29, 2020 at 08:15:54AM +0200, Christian Couder wrote:

> On Tue, Jul 28, 2020 at 10:23 PM Jeff King <peff@peff.net> wrote:
> >
> > The argv_array data type has turned out to be useful in our code base,
> > but the name isn't very good. From patch 2 of this series:
> >
> >   The name "argv-array" isn't very good, because it describes what the
> >   data type can be used for (program argument arrays), not what it
> >   actually is (a dynamically-growing string array that maintains a
> >   NULL-terminator invariant).
> 
> I cannot help but notice that you still use "array" when describing
> what it is. You actually use "string array" to describe what it is,
> and at the same time say that the name should describe what it is. So
> I would expect after the above sentence that you would rename it to
> "string_array" or "str_array".

I think one thing that leads me to "vec" is the "v" from "argv", which
implies the NULL-terminator (though of course that's _not_ implied by
"vector" in other languages). None of the other "array" types have that
feature, and it's an important one here.

> > "strarray" would work, too, but it's
> > longer and a bit more awkward to say (and don't we all say these things
> > in our mind as we type them?).
> 
> It's longer than "strarray" by 2 characters only.

Yeah, I agree the length between the two is not super important. Mostly
I find it harder to read and say. That's obviously subjective, but I do
think counts for something.

We use an underscore for "oid_array" (which I think makes sense because
it's awkward to concatenate directly a word that starts with a vowel and
has multiple syllables). That makes it inconsistent with oidmap and
oidset. Likewise, I was hoping for consistency with strbuf here.

> Also we still use "array" in "oid_array" which is very similar to
> this. And the implementation is based on the ALLOC_GROW macro which
> uses the REALLOC_ARRAY macro.
> 
> We also use ALLOC_ARRAY, FLEX_ARRAY, CALLOC_ARRAY, COPY_ARRAY and
> MOVE_ARRAY macros.

Those macro names are pretty bulky, but I think it matters a lot less
because they're used a lot less. The type name here is prepended to all
of the "method" functions like strvec_pushf(), etc.

> So if you don't like the "array" part of the name, are you going to
> also change "oid_array" into "oidvec" and for example "REALLOC_ARRAY"
> into "REALLOC_VEC" or "REALLOC_VECTOR"?

I hadn't planned on it, just because I think the cost of changing versus
the benefit is not that high. If I were designing from scratch, I'd
definitely consider oidvec (but probably not REALLOC_VEC for the reasons
above).

I think the cost of changing away from argv_array _is_ worth it, and
once we're doing that, we can choose between the alternatives without
paying an extra cost.

> If you want to change only "argv_array" (and not also "oid_array",
> "REALLOC_ARRAY" and perhaps other *_ARRAY macros) into something else,
> then I think it would be better to be consistent with them.

I definitely sympathize with the consistency argument, and I don't think
'str_array" is the end of the world. But I think there are many
dimensions of inconsistency already, so without renaming every data
structure, we're going to be inconsistent with something. Mostly I just
subjectively find strvec easier to read, say, and type, and I don't
think the inconsistencies are so glaring that it's a problem.

-Peff
