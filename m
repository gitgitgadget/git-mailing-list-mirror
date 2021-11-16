Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5FBC433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 21:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B533261BBD
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 21:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhKPVZx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 16:25:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:60530 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229605AbhKPVZx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 16:25:53 -0500
Received: (qmail 21324 invoked by uid 109); 16 Nov 2021 21:22:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Nov 2021 21:22:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2937 invoked by uid 111); 16 Nov 2021 21:22:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Nov 2021 16:22:56 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Nov 2021 16:22:54 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: New-ish warning in refs.c with GCC (at least 11.2) under -O3
Message-ID: <YZQhLh2BU5Hquhpo@coredump.intra.peff.net>
References: <211115.86a6i5s4bn.gmgdl@evledraar.gmail.com>
 <YZLhrSoTzrC7wcQo@coredump.intra.peff.net>
 <YZQUxkYI3TES3vDo@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YZQUxkYI3TES3vDo@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 03:29:58PM -0500, Taylor Blau wrote:

> On Mon, Nov 15, 2021 at 05:39:41PM -0500, Jeff King wrote:
> > So something like the patch at the end of this email works (compiles
> > with -O3 and passes the tests), but I think it is just making things
> > more confusing.
> 
> I can absolutely understand and am sympathetic to the reasons that
> your patch would be making things more brittle. In some sense, it makes
> spots like these a little easier to read:
> 
> > -			&update->new_oid, &update->old_oid,
> > +			update->flags & REF_HAVE_NEW ? &update->new_oid : NULL,
> > +			update->flags & REF_HAVE_OLD ? &update->old_oid : NULL,
> 
> But I think forcing that burden on every caller is what makes the
> overall approach worse.

Yeah, exactly.

> So it's too bad that we even have this problem in the first place, since
> GCC's warning is clearly a false positive. But I would be OK with the
> bandaid you propose here:
> 
> > I think an assertion similar to what you have above is a better bet,
> > but perhaps written more simply as:
> >
> >   if (flags & REF_HAVE_NEW) {
> > 	/* silence gcc 11's over-eager compile-time analysis */
> > 	if (!new_oid)
> > 		BUG("REF_HAVE_NEW set without passing new_oid");
> > 	oidcpy(&update->new_oid, new_oid);
> >   }

I'm still OK with that. Another one that works and may be more obvious
to somebody reading is:

diff --git a/refs.c b/refs.c
index d7cc0a23a3..da39e9fb35 100644
--- a/refs.c
+++ b/refs.c
@@ -1089,6 +1089,14 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	if (flags & ~REF_TRANSACTION_UPDATE_ALLOWED_FLAGS)
 		BUG("illegal flags 0x%x passed to ref_transaction_update()", flags);
 
+	/*
+	 * Should be a noop per the ALLOWED_FLAGS check above, but this
+	 * is necessary to work around a problem with some versions of
+	 * "gcc -O3 -Wnonnull", which otherwise thinks that you can have the
+	 * flag set with a NULL new_oid.
+	 */
+	flags &= ~REF_HAVE_OLD | REF_HAVE_NEW;
+
 	flags |= (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);
 
 	ref_transaction_add_update(transaction, refname, flags,

I do find it interesting that gcc really _is_ convinced that those flags
can be set coming in, since clearing them makes the problem go away.
That points to it being confused by the "ALLOWED_FLAGS" check above.
Which makes me wonder if there's some weird integer rule at work here.
But even if I write:

  if (flags & REF_HAVE_NEW)
	BUG(...);

it can't figure it out. Which almost implies that it is not accepting
that BUG() will never return, but it's clearly marked with the noreturn
attribute. So...I dunno.

I noticed that Debian is carrying gcc-12 in experimental as of today. It
reports the same problem, plus another one that I can't make heads or
tails of:

  dir.c: In function ‘git_url_basename’:
  dir.c:3131:13: error: ‘memchr’ specified bound [9223372036854775808, 0] exceeds maximum object size 9223372036854775807 [-Werror=stringop-overread]
   3131 |         if (memchr(start, '/', end - start) == NULL
        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reading over the code, it all looks OK. And that size is...weirdly huge.

-Peff
