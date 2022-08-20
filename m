Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF41C25B08
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 09:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343870AbiHTJrE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 05:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiHTJrC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 05:47:02 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02F9AA3F6
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 02:47:00 -0700 (PDT)
Received: (qmail 22005 invoked by uid 109); 20 Aug 2022 09:47:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 20 Aug 2022 09:47:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10302 invoked by uid 111); 20 Aug 2022 09:47:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 20 Aug 2022 05:47:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 20 Aug 2022 05:46:59 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/11] annotating unused function parameters
Message-ID: <YwCtkwjWdJVHHZV0@coredump.intra.peff.net>
References: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
 <220819.861qtc8gug.gmgdl@evledraar.gmail.com>
 <c22a8317-7d43-d84b-f63f-df2da31b4658@github.com>
 <220819.868rnk54ju.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220819.868rnk54ju.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2022 at 10:58:08PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Yes, I spoke too soon, sorry. We still need ((unused)). FWIW the below
> on top of master and doing:

Right. Using ((deprecated)) is really just a substitute for the variable
renaming part.

And I agree it works as advertised, though I think I prefer the
variable-renaming version.

One, it feels like we're abusing the deprecated attribute here. The
confusion in the compiler output I'm OK with, because we get a chance to
put our own message there (so I agree the output is actually better than
with my patch). But from time to time I've had to build with
-Wno-deprecated-declarations to get around _actual_ deprecated warnings
(e.g., compiling with OPENSSL_SHA1=Yes). And doing so would be cutting
out half the protection of UNUSED() in that case.

Likewise, one thing I like about the renaming is that it fails
compilation regardless of -Werror. So it will be caught in any compile,
no matter what. And I do automatically compile without DEVELOPER=1 when
on a detached HEAD, because historical commits often trigger warnings.
Go back far enough and OPENSSL_SHA1 was the default, which generates
lots of warnings these days. :)

And finally, I actually prefer the parentheses of:

  static int register_ref(const char *refname, const struct object_id *oid,
			  int UNUSED(flags), void *UNUSED(cb_data))

It visually binds the attribute more tightly to the variable name, like
how we sometimes write unused_flags manually in existing code. When
there are a lot of variables to mark in a function (and some callbacks
really do have a lot), that makes it easier to see what's going on. To
me, anyway. I recognize that it's a matter of taste.

Technically this last thing is orthogonal to using the deprecated
attribute. It could still be used with the parenthesized form, but the
error messages gcc generates are horrendous then (it repeats the warning
several times due to the macro).

So I dunno. These are all matters of opinion, and if it was just my
patches, I'd say my taste wins. But all of us are going to have to write
these annotations at some time or another when we add callbacks, etc. So
we should at the very least pick a syntax the majority prefers. :)

-Peff
