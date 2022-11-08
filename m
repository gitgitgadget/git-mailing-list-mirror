Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5904C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 14:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbiKHOda (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 09:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbiKHOdP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 09:33:15 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85945C75E
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 06:33:00 -0800 (PST)
Received: (qmail 7396 invoked by uid 109); 8 Nov 2022 14:32:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Nov 2022 14:32:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4733 invoked by uid 111); 8 Nov 2022 14:32:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Nov 2022 09:32:59 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Nov 2022 09:32:59 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 2/3] revision: add new parameter to specify all
 visible refs
Message-ID: <Y2pomzGndfhggXWz@coredump.intra.peff.net>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667485737.git.ps@pks.im>
 <3ccd8fc0e35407e5c9ff896165f122b10598e0e2.1667485737.git.ps@pks.im>
 <Y2ZbDXYb1jGqSfTj@coredump.intra.peff.net>
 <Y2i/uJPm5KxqAdkE@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2i/uJPm5KxqAdkE@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2022 at 09:20:08AM +0100, Patrick Steinhardt wrote:

> >   1. The mutual-exclusion selection between "transfer", "uploadpack",
> >      and "receive" is not how those options work in their respective
> > [...]
> 
> Yup, I'm aware of this. And as you say, the current implementation
> already handles this alright for both `receive` and `uploadpack` as we
> rely on `parse_hide_refs_config()`, which knows to look at both
> `transfer.hideRefs` and `$section.hideRefs`. But I don't see a reason
> why we shouldn't allow users to ask "What is the set of hidden refs that
> are shared by `uploadpack` and `receive`?", which is exactly what
> `--visible-refs=transfer` does.

OK. I don't have a real problem with having that mode, as long as it is
documented accurately. I do think, though, that it's not that likely to
be useful on its own (even less so than the hypotheticals I gave! ;) ),
and it would be easy to add later in a backwards-compatible way. So my
instinct would be to leave it out for now, but I don't think it's
hurting too much as-is (again, with a correct explanation in the
documentation).

> The implementation is not really explicit about this as we cheat a
> little bit here by passing "transfer" as a section to the parsing
> function. So what it does right now is to basically check for the same
> section twice, once via the hard-coded "transfer.hideRefs" and once for
> the "$section.hideRefs" with `section == "transfer"`. But I didn't see
> much of a point in making this more explicit.

Yeah, I agree the implementation works OK here. It does a duplicate
string-comparison for the section, but the important thing is that it
doesn't add each entry to the list twice.

> >      Now I don't have a particular use case for either of those things.
> >      But they're plausible things to want in the long run, and they fit
> >      in nicely with the existing ref-selection scheme of rev-list. They
> >      do make your call from check_connected() slightly longer, but it is
> >      pretty negligible. It's "--exclude-hidden=receive --all" instead of
> >      "--visible-refs=hidden".
> 
> Fair enough. I guess that the usecase where you e.g. only hide a subset
> of branches via `hideRefs` is going to be rare, so in most cases you
> don't gain much by modelling this so that you can `--exclude-hidden
> --branches`. But as you rightfully point out, modelling it that way fits
> neatly with the existing `--exclude` switch and is overall more
> flexible. So there's not much of a reason to not do so.

Thanks. I agree these aren't incredibly likely cases to come up in
practice. But unlike the "transfer" thing, it would be very hard to
switch techniques later without adding an awkward almost-the-same
option.

-Peff
