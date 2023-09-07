Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC67EC875C
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 20:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbjIGUkj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 16:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjIGUki (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 16:40:38 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3371BCA
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 13:40:33 -0700 (PDT)
Received: (qmail 29052 invoked by uid 109); 7 Sep 2023 20:40:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Sep 2023 20:40:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31180 invoked by uid 111); 7 Sep 2023 20:40:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Sep 2023 16:40:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Sep 2023 16:40:27 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] grep: use OPT_INTEGER_F for --max-depth
Message-ID: <20230907204027.GA941945@coredump.intra.peff.net>
References: <4d2eb736-4f34-18f8-2eb7-20e7f7b8c2f8@web.de>
 <20230905072122.GG199565@coredump.intra.peff.net>
 <724641d2-1cba-3768-6008-01e8a1cdca4e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <724641d2-1cba-3768-6008-01e8a1cdca4e@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 07, 2023 at 10:20:53PM +0200, René Scharfe wrote:

> Am 05.09.23 um 09:21 schrieb Jeff King:
> > On Sat, Sep 02, 2023 at 08:54:54PM +0200, René Scharfe wrote:
> >
> > In general, I wonder how many of the results from:
> >
> >   git grep '{ OPTION'
> >
> > could be converted to use the macros and end up more readable. There are
> > a number of OPTARG ones, which I guess can't use macros. Looks like
> > there are a handful of others (mostly for OPT_HIDDEN).
> 
> Indeed, and I have a semantic patch for that, but mostly because the
> macros allow injecting a type check.
> 
> OPTARG would need a new macro to allow specifying the default value.  Or
> is there a variadic macro trick that we could use?

Hmm, I had just assumed OPTARG was a lost cause (or we would need an
"OPTARG" variant of each macro; yuck).

I suspect variadic macros could be made to work, but you'd lose some
compile-time safety. If I say:

  OPT_BOOL('x', NULL, &v, NULL, "turn on x")

now, the compiler will complain about the number of arguments. In a
variadic world, it silently ignores the final one. I feel like I've made
this kind of error before (e.g., when switching to/from _F variants, or
between types).

You'd want some semantic check between what's in flags (i.e., is the
OPTARG flag set), but I think that's beyond what the compiler itself can
do (you could probably write a coccinelle rule for it, though).

I think it also squats on the variadic concept for the macro, so that no
other features can use it. I.e., if you accidentally give _two_ extra
arguments, I don't know that we can parse them out individually.

So yeah, I think you'd really want a separate macro. The combinations
start to add up (or multiply up, if you prefer ;) ). They _could_ be
generated mechanically, I think, as they can all be implemented in terms
of a master macro that knows about all features:

   #define OPT_BOOL_F(s, l, v, h, f) OPT_BOOL_ALL(s, l, v, h, f, 0)
   #define OPT_BOOL(s, l, v, h, f) OPT_BOOL_F(s, l, v, h, 0)
   #define OPT_BOOL_OPTARG_F(s, l, v, h, arg) OPT_BOOL_ALL(s, l, v, h, f | PARSE_OPT_OPTARG, arg)
   #define OPT_BOOL_OPTARG(s, l, v, h, arg) OPT_BOOL_OPTARG_F(s, l, v, h, 0, arg)

But I'm not sure if cpp is up to that, or if I'd want to see what the
resulting code looks like.

-Peff
