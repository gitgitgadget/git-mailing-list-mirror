Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E04C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 21:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D91C60F25
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 21:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239927AbhIPV6B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 17:58:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:49508 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234142AbhIPV6A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 17:58:00 -0400
Received: (qmail 8489 invoked by uid 109); 16 Sep 2021 21:56:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Sep 2021 21:56:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9477 invoked by uid 111); 16 Sep 2021 21:56:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Sep 2021 17:56:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Sep 2021 17:56:38 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v6 08/22] object-file.c: don't set "typep" when returning
 non-zero
Message-ID: <YUO9lrYloKGXILSA@coredump.intra.peff.net>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
 <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
 <patch-v6-08.22-38e4266772d-20210907T104559Z-avarab@gmail.com>
 <YUO3OjbnpqwEWeDv@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YUO3OjbnpqwEWeDv@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 16, 2021 at 05:29:30PM -0400, Taylor Blau wrote:

> On Tue, Sep 07, 2021 at 12:58:03PM +0200, Ævar Arnfjörð Bjarmason wrote:
> > When the loose_object_info() function returns an error stop faking up
> > the "oi->typep" to OBJ_BAD. Let the return value of the function
> > itself suffice. This code cleanup simplifies subsequent changes.
> 
> The obvious danger (which you mention) is that somebody is relying on
> what typep points to, and is reading it even if we returned non-zero
> from whatever called this function.
> 
> Hopefully nobody is, but this change makes me a little uncomfortable
> nonetheless, since there are so many potential callers (even though this
> function has only one caller, it doesn't take long before the number of
> indirect callers explodes).
> 
> So it would be nice if we could do without it, but you claim that it
> simplifies changes that happen later on. So let's continue to see if we
> really do need it...

I'm actually reasonable comfortable with this patch. If we return an
error from the *_object_info() functions, then I think all bets are off
on what is in the resulting object_info struct. E.g., we'd already leave
sizep uninitialized in such a case.

It feels like oi->typep may be a little bit special because we conflate
"error" and "type" in the return from oid_object_info(). But
oid_object_info_extended() does not do that, and the innards of
oid_object_info() do the right thing.

Of course we _have_ been setting typep in this way for a while, so it's
worth making sure nobody is depending on. Notably packed_object_info()
does not behave in this way; if it hits an error, typep may be left
unset. So any oid_object_info_extended() callers depending on this were
already potentially buggy. I'd be OK with a quick sweep of the hits of
"git grep typep" here.

I just did that, and all the sites look pretty reasonable (they call
oid_object_info_extended() and bail as soon as they see that it fails).

-Peff
