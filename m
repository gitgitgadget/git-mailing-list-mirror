Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F71C433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 18:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B4C82072E
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 18:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733226AbgFWSaz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:30:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:40620 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733125AbgFWSaz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 14:30:55 -0400
Received: (qmail 12910 invoked by uid 109); 23 Jun 2020 18:30:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Jun 2020 18:30:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19471 invoked by uid 111); 23 Jun 2020 18:30:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Jun 2020 14:30:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Jun 2020 14:30:53 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 09/10] fast-export: allow seeding the anonymized mapping
Message-ID: <20200623183053.GA1444619@coredump.intra.peff.net>
References: <20200623152436.GA50925@coredump.intra.peff.net>
 <20200623152505.GI1435482@coredump.intra.peff.net>
 <CAPig+cTMu3SW5UE59Eva=jh-07hOT8Dz5A5trWyEugKd_2HaKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTMu3SW5UE59Eva=jh-07hOT8Dz5A5trWyEugKd_2HaKg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 23, 2020 at 01:16:05PM -0400, Eric Sunshine wrote:

> On Tue, Jun 23, 2020 at 11:25 AM Jeff King <peff@peff.net> wrote:
> > diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
> > @@ -238,6 +243,25 @@ collapse "User 0", "User 1", etc into "User X"). This produces a much
> > +[...] For example, if you have a bug which reproduces
> > +with `git rev-list mybranch -- foo.c`, you can run:
> > +
> > +---------------------------------------------------
> > +$ git fast-export --anonymize --all \
> > +   --seed-anonymized=foo.c:secret.c \
> > +   --seed-anonymized=mybranch \
> > +   >stream
> > +---------------------------------------------------
> > +
> > +After importing the stream, you can then run `git rev-list mybranch --
> > +secret.c` in the anonymized repository.
> 
> I understand that your intention here is to demonstrate both forms of
> --seed-anonymized, but I'm slightly concerned that people may
> interpret this example as meaning that you are not allowed to
> anonymize the refname when anonymizing a pathname. It might be less
> ambiguous to avoid the "short form" in the example; people who have
> read the description of --seed-anonymized will know that the short
> form can be used without having to see it in an example.

I'm not sure what you'd write, then. You can't mention "mybranch"
anymore if it was anonymized. Are you suggesting to make the example:

  git rev-list -- foo.c

by itself?

> > +Note that paths and refnames are split into tokens at slash boundaries.
> > +The command above would anonymize `subdir/foo.c` as something like
> > +`path123/secret.c`.
> 
> Confusing. This seems to be saying that anonymizing filenames in
> subdirectories is pointless because you can't know how the leading
> directory names will be anonymized. That leaves the reader wondering
> how to deal with the situation. Does it require using
> --seed-anonymized for each path component leading up to the filename?

You can do that, but I think it would be simpler to just find "secret.c"
in the anonymized repo (either in the checkout, or just "git ls-tree
-r").

> Or can --seed-anonymized take an full pathname (leading directory
> components and filename) in one shot?

No, it can't. Suggested wording? That's what I was trying to say with
the above sentence.

> > +    /* First check if it's a token the user configured manually... */
> > +    if (anonymized_seeds.cmpfn)
> > +        ret = hashmap_get_entry(&anonymized_seeds, &key, hash, &key);
> > +    else
> > +        ret = NULL;
> > +
> > +    /* ...otherwise check if we've already seen it in this context... */
> > +    if (!ret)
> > +        ret = hashmap_get_entry(map, &key, hash, &key);
> > +
> > +    /* ...and finally generate a new mapping if necessary */
> 
> I was a bit surprised to see that --seed-anonymized values are stored
> in a separate hash map rather than simply being used to (literally)
> seed the existing anonymization hash map. I guess there's a good
> technical reason for doing it this way, such as the normal
> anonymization hash map not yet being in existence at the time the
> --seed-anonymized option is processed? (I haven't checked because I'm
> too lazy, so it may not be worth spending time answering me.)

The reason is that there isn't one anonymization hash map. There's a
separate one for each generator (so refs become "refs/heads/ref123" and
paths become "path123/path456").

> > @@ -1188,6 +1230,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
> >         OPT_BOOL(0, "anonymize", &anonymize, N_("anonymize output")),
> > +        OPT_CALLBACK_F(0, "seed-anonymized", &anonymized_seeds, N_("from:to"),
> > +               N_("convert <from> to <to> in anonymized output"),
> > +               PARSE_OPT_NONEG, parse_opt_seed_anonymized),
> 
> Would it be worthwhile to add a check somewhere after the
> parse_options() invocation and complain if --seed-anonymized was used
> without --anonymize?  (Or should --seed-anonymized perhaps imply
> --anonymize?)

I thought about implying, but I have a slight preference to err on the
side of making things less magical. I don't mind triggering a warning or
error, but it's not like anything _bad_ happens if you don't say
--anonymize. It just doesn't do anything, which seems like a perfectly
logical outcome.

-Peff
