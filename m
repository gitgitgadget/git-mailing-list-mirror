Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422DBC4332F
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 13:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiLQNYX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 08:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiLQNYV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 08:24:21 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335DD1742A
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 05:24:20 -0800 (PST)
Received: (qmail 1962 invoked by uid 109); 17 Dec 2022 13:24:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Dec 2022 13:24:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22682 invoked by uid 111); 17 Dec 2022 13:24:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Dec 2022 08:24:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 17 Dec 2022 08:24:18 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: don't pass strvec to apply_parse_options()
Message-ID: <Y53DAoJ4eK01rEji@coredump.intra.peff.net>
References: <baf93e4a-7f05-857c-e551-09675496c03c@web.de>
 <221213.86mt7r4ru2.gmgdl@evledraar.gmail.com>
 <2d0d77a4-f6ac-1fa7-bddb-9083579d8dd7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d0d77a4-f6ac-1fa7-bddb-9083579d8dd7@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 13, 2022 at 07:31:13PM +0100, René Scharfe wrote:

> > I think less of a hack is to teach the eventual parse_options() that
> > when it munges it it should free() it. I did that for the revisions API
> > in f92dbdbc6a8 (revisions API: don't leak memory on argv elements that
> > need free()-ing, 2022-08-02).
> >
> > What do you think?
> 
> Generating string lists and then parsing them is weird.  When calls have
> to cross a process boundary then we have no choice, but in-process we
> shouldn't have to lower our request to an intermediate text format.  git
> am does it anyway because it writes its options to a file and reads them
> back when it resumes with --continue, IIUC.

The argument has been made[1] in the past that the public API for the
revision machinery is not poking bits in the rev_info struct yourself,
but passing the appropriate options to setup_revisions().

And I can see the point; if option "--foo" requires twiddling both
revs.foo and revs.bar, then we have no way to enforce that callers have
remembered to do both. But if the only code which handles this is the
parser for "--foo", then we're OK.

In a non-C language, we'd probably mark "foo" and "bar" as private and
provide a method to enable the option. We could provide a function, but
we'd have no compiler help to ensure that it was used over fiddling the
bits. Possibly calling them "foo_private" would be sufficient to make
people think twice about tweaking them, though.

[1] Apologies for the passive voice; I didn't want to muddle the
    paragraph by discussing who and when. But I know this is an argument
    Junio has made; I don't know if he still stands by it these days
    (there is quite a lot of field-twiddling of rev_info by now). I'm
    not sure to what degree I agree with it myself, but I thought it was
    worth mentioning here.

> If we have to change parse_options() at all then I'd prefer it to not
> free() anything (to keep it usable with main()'s parameters), but to
> reorder in a non-destructive way.  That would mean keeping the NULL
> sentinel where it is, and making sure all callers use only the returned
> argc to determine which arguments parse_options() didn't recognize.

My findings with -Wunused-parameter show that there are quite a lot of
places that take argv/argc but assume the NULL-termination of the argv.

If we are just re-ordering argv, though, it feels like this could still
work with a strvec. Right now a strvec with "nr" items will free items 0
through nr-1, assuming that v[nr] is its NULL invariant. But it could
free v[nr], too, in case the NULL was swapped into an earlier position.

It's a little weird already, because that swap has violated the
invariant, so trying to strvec_push() onto it would cause confusing
results. But if the general use case is to pass the strvec to
parse_options(), get reordered, and then clear() it, it should work. If
you wanted to get really fancy, push() et al could double-check the
invariant and BUG().

-Peff
