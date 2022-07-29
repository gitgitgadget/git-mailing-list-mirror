Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4035C04A68
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 18:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbiG2SDV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 14:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238452AbiG2SDT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 14:03:19 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CDD89AAB
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 11:03:18 -0700 (PDT)
Received: (qmail 22021 invoked by uid 109); 29 Jul 2022 18:03:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jul 2022 18:03:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27406 invoked by uid 111); 29 Jul 2022 18:03:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Jul 2022 14:03:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Jul 2022 14:03:16 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] revisions API: don't leak memory on argv elements
 that need free()-ing
Message-ID: <YuQg5M/cSLtqOgdw@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
 <patch-6.6-4a581a4a6ce-20220713T130511Z-avarab@gmail.com>
 <YtV4KmrTBkmcx6m3@coredump.intra.peff.net>
 <220718.86zgh6wiwa.gmgdl@evledraar.gmail.com>
 <YtWAMP0ROFseFs6B@coredump.intra.peff.net>
 <220729.86pmhoidsc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220729.86pmhoidsc.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 09:07:40AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > In that case, we could replace your patch 5 in favor of just calling
> > strvec_clear() at the end of bisect_rev_setup().
> 
> 5/6 is doing that, or rather at the end of check_ancestors() and
> bisect_next_all(), but those call bisect_rev_setup() and pass it the
> strvec, so in terms of memory management it amounts to the same thing.

Right, but my point is that we do not need to complicate the interface
and ownership rules for bisect_rev_setup() by passing around the extra
variable.

> > It's possible there's a
> > case I'm missing that makes this generally not-safe, but in the case of
> > bisect_rev_setup() there's a very limited set of items in our argv in
> > the first place. Doing so also passes the test suite with
> > SANITIZE=address, though again, this is just exercising the very limited
> > bisect options here.
> 
> I think what you're missing is that this code is basically doing this,
> which is a common pattern in various parts of our codebase:
> 
> 	struct strvec sv = STRVEC_INIT;
> 	strvec_push(&sv, "foo"); // sv.v[0] 
> 	strvec_push(&sv, "bar"); // sv.v[1] 
> 	sv.v[1] = NULL; // the code in revisions.c
> 	strvec_clear(&sv);
> 
> I.e. you can't fix this by simply having revision.c having its own
> strvec, because it would just .. proceed to do the same thing.

Right, none of what I was suggesting above gets rid of the flag to tell
revisions.c that it should free elements it removes from argv. We still
have to do that. My point was just that if we can assume that
setup_revisions() does not need for the passed-in argv to exist after it
exits (which _used_ to not be true, but I think is these days), then
that can simplify a few of the callers.

> Of course we could alter its argv-iterating state machine to not clobber
> that "argv" element to NULL, and have other subsequent code know that it
> should stop at a new lower "argc" etc. etc., but that's getting at the
> much more invasive API changes 6/6 notes as the path not taken.

Yeah, I don't think that's at all worth it. If anything, it could
perhaps hold on to the "removed" pointer and restore it at the end, but
I wouldn't be surprised if that gets ugly, too.

> And, in the general case for things that do this to the strvec what
> we're explicitly doing is having the caller then operate on that munged
> argv, i.e. it's important that we change *its* argv. That's not going on
> here, but e.g. various parse_options() callers rely on that.

Right, agreed.

> IIRC this fails SANITIZE=address or was otherwise broken, I didn't test
> it now, but that's not the point...
> 
> ... I'm just including it by way of explanation. I.e. for at least
> *some* callers (IIRC the below mostly works, and I can't remember where
> it's broken) it would suffice to just keep around a list of "here's
> stuff we should free later".
> 
> In case below I opted to do that with a string_list, but it could be
> another strvec or whatever.

FWIW, I don't really like this direction. It feels like a huge band-aid,
and the right solution is either having functions _not_ munge strvecs
too much, or be told that they can take ownership of removed elements
and free them (i.e., your current patch 6).

-Peff
