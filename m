Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D03EC4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 20:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiLNUki (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 15:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiLNUkI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 15:40:08 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E1DBA8
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 12:39:36 -0800 (PST)
Received: (qmail 28168 invoked by uid 109); 14 Dec 2022 20:39:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Dec 2022 20:39:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22618 invoked by uid 111); 14 Dec 2022 20:39:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Dec 2022 15:39:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Dec 2022 15:39:34 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/5] ref-filter: truncate atom names in error messages
Message-ID: <Y5o0hs4wKWYCg1h7@coredump.intra.peff.net>
References: <Y5n3S7cnD7s/AIRL@coredump.intra.peff.net>
 <Y5n4mb/S/RORb+N7@coredump.intra.peff.net>
 <Y5oscak6T23G81Gu@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5oscak6T23G81Gu@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2022 at 03:05:05PM -0500, Taylor Blau wrote:

> On Wed, Dec 14, 2022 at 11:23:53AM -0500, Jeff King wrote:
> > It seems like the cleanest fix would be for atom->name to be _just_ the
> > name, since there's already a separate "args" field. But since that
> > field is also used for other things, we can't change it easily (e.g.,
> > it's how we find things in the used_atoms array, and clearly %(refname)
> > and %(refname:short) are not the same thing).
> >
> > Instead, we'll teach our error_bad_arg() function to stop at the first
> > ":". This is a little hacky, as we're effectively re-parsing the name,
> > but the format is simple enough to do this as a one-liner, and this
> > localizes the change to the error-reporting code.
> >
> > We'll give the same treatment to err_no_arg(). None of its callers use
> > this atom->name trick, but it's worth future-proofing it while we're
> > here.
> 
> For what it's worth, I think that this balance of a somewhat-hacky
> implementation against a more significant and trickier refactoring is
> well thought-out and the right decision, IMHO.

By the way, I did try the other change, to make atom->name just contain
the name with no args. There are a bunch of pitfalls in
parse_ref_filter_atom(), including:

  - don't use atom_len; it's off-by-one when looking at "atom" and not
    "sp" when there's a "*" dereference

  - the "args" pointer in the struct actually points into the name
    string. I don't think anybody relies on that, but I'm not 100% sure
    because...

  - once you deal with that, then it segfaults mysteriously, because
    the numeric index between used_atom and the computed values gets out
    of sync. That's where I gave up.

Which isn't to say it isn't do-able, or it wouldn't even make the
ref-filter code cleaner overall if somebody did that refactoring. But it
seemed like too much for solving this one little problem.

Here's the patch where I stopped, for posterity:

diff --git a/ref-filter.c b/ref-filter.c
index caf10ab23e..3a2a7d0271 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -716,7 +716,7 @@ static int parse_ref_filter_atom(struct ref_format *format,
 	used_atom_cnt++;
 	REALLOC_ARRAY(used_atom, used_atom_cnt);
 	used_atom[at].atom_type = i;
-	used_atom[at].name = xmemdupz(atom, ep - atom);
+	used_atom[at].name = xmemdupz(atom, (arg ? arg : ep) - atom);
 	used_atom[at].type = valid_atom[i].cmp_type;
 	used_atom[at].source = valid_atom[i].source;
 	if (used_atom[at].source == SOURCE_OBJ) {
@@ -726,8 +726,10 @@ static int parse_ref_filter_atom(struct ref_format *format,
 			oi.info.contentp = &oi.content;
 	}
 	if (arg) {
-		arg = used_atom[at].name + (arg - atom) + 1;
-		if (!*arg) {
+		arg++; /* skip ':' */
+		if (arg < ep) {
+			arg = xmemdupz(arg, ep - arg);
+		} else {
 			/*
 			 * Treat empty sub-arguments list as NULL (i.e.,
 			 * "%(atom:)" is equivalent to "%(atom)").

Its relative shortness does not represent the great confusion I had in
producing it.

-Peff
