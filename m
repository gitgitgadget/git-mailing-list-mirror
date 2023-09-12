Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC98CA0EC3
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 07:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjILHwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 03:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjILHvw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 03:51:52 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6866F10C4
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 00:51:48 -0700 (PDT)
Received: (qmail 14098 invoked by uid 109); 12 Sep 2023 07:51:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Sep 2023 07:51:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16615 invoked by uid 111); 12 Sep 2023 07:51:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Sep 2023 03:51:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Sep 2023 03:51:45 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] grep: use OPT_INTEGER_F for --max-depth
Message-ID: <20230912075145.GA1630538@coredump.intra.peff.net>
References: <4d2eb736-4f34-18f8-2eb7-20e7f7b8c2f8@web.de>
 <20230905072122.GG199565@coredump.intra.peff.net>
 <724641d2-1cba-3768-6008-01e8a1cdca4e@web.de>
 <20230907204027.GA941945@coredump.intra.peff.net>
 <cec47733-5b15-6ca7-adaf-7f3216ad178b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cec47733-5b15-6ca7-adaf-7f3216ad178b@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 09, 2023 at 12:28:20AM +0200, René Scharfe wrote:

> >> OPTARG would need a new macro to allow specifying the default value.  Or
> >> is there a variadic macro trick that we could use?
> >
> > Hmm, I had just assumed OPTARG was a lost cause (or we would need an
> > "OPTARG" variant of each macro; yuck).
> 
> Only for OPT_INTEGER and OPT_STRING AFAICS.

True, my use of BOOL was obviously dumb, as it wouldn't have arguments.
But in theory anything that takes an argument could have an OPTARG
variant. So that would include special stuff like OPT_EXPIRY_DATE,
OPT_FILENAME, and so on. Though I would not be surprised if we currently
only use it for string/integer.

> It's true that a macro that accepts a variable number of arguments would
> accept accidental extra arguments of the right type, but I don't see how
> it would ignore excessive ones.

The macro itself wouldn't notice, but I guess the generated code would
probably complain about getting "(foo,bar)" as the initializer, if you
really sent to many.

But I was more worried about an error where you accidentally give an
extra argument. Right now that's an error, but would it be quietly
shifted into the OPTARG slot?

> > You'd want some semantic check between what's in flags (i.e., is the
> > OPTARG flag set), but I think that's beyond what the compiler itself can
> > do (you could probably write a coccinelle rule for it, though).
> 
> Actually I'd want the macro to set that flag for me.

For a dedicated OPT_STRING_OPTARG(), I'd agree. For OPT_STRING() that
uses varargs, I'm more on the fence (because of the cross-checking
above; now we are getting into "accidentally adding a parameter is
quietly accepted" territory).

I dunno. Maybe saving some keystrokes is worth it, but having to say
both OPTARG _and_ provide the extra argument makes things less subtle.

> I was thinking more about something like the solutions discussed at
> https://stackoverflow.com/questions/47674663/variable-arguments-inside-a-macro.
> It allows selecting variants based on argument count.
> [...]
> So OPT_INTEGER(s, l, v, h) would be the same as before.  Add an argument
> and it becomes current OPT_INTEGER_F, add another one and it acts as
> your _OPTARG_F variant.

Ah, yeah, I've seen something like this before. I do think it would
work as you're suggesting. I'm just not sure if being verbose and
explicit is better than trying to be clever here.

-Peff
