Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAECCC433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 19:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87422610A6
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 19:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbhINTXc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:23:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:47360 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232638AbhINTXb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 15:23:31 -0400
Received: (qmail 25337 invoked by uid 109); 14 Sep 2021 19:22:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Sep 2021 19:22:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27239 invoked by uid 111); 14 Sep 2021 19:22:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Sep 2021 15:22:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Sep 2021 15:22:12 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 7/9] ls-refs: ignore very long ref-prefix counts
Message-ID: <YUD2ZEqKSU/pMzws@coredump.intra.peff.net>
References: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
 <YUDBokYvEBnzwsIN@coredump.intra.peff.net>
 <CAN0heSp9RdFwSo+x5buHSCAOa0Kay7Wcs1tNKTDXWmkCM8Latw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSp9RdFwSo+x5buHSCAOa0Kay7Wcs1tNKTDXWmkCM8Latw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 09:06:55PM +0200, Martin Ågren wrote:

> > But we can do better. Since supporting the ref-prefix capability is
> > optional anyway, the client has to further cull the response based on
> > their own patterns. So we can simply ignore the patterns once we cross a
> > certain threshold. Note that we have to ignore _all_ patterns, not just
> > the ones past our limit (since otherwise we'd send too little data).
> 
> This all makes sense to me. At some point, we should be able to go "I
> don't know what you're trying to do, but let me just ignore all this
> craziness and instead try to give you a useful result sooner rather than
> later".
> 
> I do wonder if we should document that the client can't trust us to
> actually do all this culling. In general, I find that it's a matter of
> hygiene for the client to do its own checks, but with this change they
> actually *need* to do them. (Unless they know our limit and that they're
> on the right side of it, but that kind of magic is even less hygienic.)

Perhaps we could say so more explicitly in the v2 protocol spec. I'll
take a look.

> > +               else if (skip_prefix(arg, "ref-prefix ", &out)) {
> > +                       if (too_many_prefixes) {
> > +                               /* ignore any further ones */
> > +                       } else if (data.prefixes.nr >= MAX_ALLOWED_PREFIXES) {
> > +                               strvec_clear(&data.prefixes);
> > +                               too_many_prefixes = 1;
> > +                       } else {
> > +                               strvec_push(&data.prefixes, out);
> > +                       }
> > +               }
> 
> Is it easier to reason about with something like this
> (whitespace-damaged) on top?

You're the second person to complain about this if-else chain. I'll take
the hint. ;)

> diff --git a/ls-refs.c b/ls-refs.c
> index 839fb0caa9..b3101ff361 100644
> --- a/ls-refs.c
> +++ b/ls-refs.c
> @@ -147,7 +147,6 @@ static int ls_refs_config(const char *var, const
> char *value, void *data)
>  int ls_refs(struct repository *r, struct packet_reader *request)
>  {
>         struct ls_refs_data data;
> -       int too_many_prefixes = 0;
> 
>         memset(&data, 0, sizeof(data));
>         strvec_init(&data.prefixes);
> @@ -164,14 +163,8 @@ int ls_refs(struct repository *r, struct
> packet_reader *request)
>                 else if (!strcmp("symrefs", arg))
>                         data.symrefs = 1;
>                 else if (skip_prefix(arg, "ref-prefix ", &out)) {
> -                       if (too_many_prefixes) {
> -                               /* ignore any further ones */
> -                       } else if (data.prefixes.nr >= MAX_ALLOWED_PREFIXES) {
> -                               strvec_clear(&data.prefixes);
> -                               too_many_prefixes = 1;
> -                       } else {
> +                       if (data.prefixes.nr <= MAX_ALLOWED_PREFIXES)
>                                 strvec_push(&data.prefixes, out);
> -                       }
>                 }

Hmm. At first I liked this, because it reduces the number of cases (and
variables!). But there's something really subtle going on here. I
thought at first it should be "<", but you are intentionally
over-allocating by one entry to indicate the overflow. I.e., you've
essentially stuffed the too_many_prefixes boolean into the count.

> @@ -180,6 +173,9 @@ int ls_refs(struct repository *r, struct
> packet_reader *request)
>         if (request->status != PACKET_READ_FLUSH)
>                 die(_("expected flush after ls-refs arguments"));
> 
> +       if (data.prefixes.nr > MAX_ALLOWED_PREFIXES)
> +               strvec_clear(&data.prefixes);
> +

This is far from the parser, but I think that's OK. I'd probably couple
it with a comment explaining why we need to clear rather than using what
we got.

> Maybe even name the macro TOO_MANY_PREFIXES (and bump it by one)
> to make the logic instead be
> 
>         if (data.prefixes.nr < TOO_MANY_PREFIXES)
>                 strvec_push(&data.prefixes, out);
>  ...
>         if (data.prefixes.nr >= TOO_MANY_PREFIXES)
>                 strvec_clear(&data.prefixes);

At first I thought this was just being cute, but it's an attempt to
compensate for the off-by-one subtlety in the early check. I'll give it
some thought. I kind of like it, but the fact that it took me a minute
or three to be sure the code is correct makes me worried it's being too
clever.

-Peff
