Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFD2C433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 18:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A5FD20781
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 18:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387474AbgFWSf2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:35:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:40640 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387453AbgFWSf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 14:35:26 -0400
Received: (qmail 12948 invoked by uid 109); 23 Jun 2020 18:35:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Jun 2020 18:35:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19528 invoked by uid 111); 23 Jun 2020 18:35:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Jun 2020 14:35:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Jun 2020 14:35:25 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 09/10] fast-export: allow seeding the anonymized mapping
Message-ID: <20200623183525.GB1444619@coredump.intra.peff.net>
References: <20200623152436.GA50925@coredump.intra.peff.net>
 <20200623152505.GI1435482@coredump.intra.peff.net>
 <CAPig+cQ1EGR6_8NJ+U3MQEseU1yT9k_AwdL8Mg7qZAB8Ev4y3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQ1EGR6_8NJ+U3MQEseU1yT9k_AwdL8Mg7qZAB8Ev4y3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 23, 2020 at 02:11:51PM -0400, Eric Sunshine wrote:

> On Tue, Jun 23, 2020 at 11:25 AM Jeff King <peff@peff.net> wrote:
> > Let's make it possible to seed the anonymization map. This lets users
> > either:
> > [...]
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
> > @@ -119,6 +119,11 @@ by keeping the marks the same across runs.
> > +--seed-anonymized=<from>[:<to>]::
> > +       Convert token `<from>` to `<to>` in the anonymized output. If
> > +       `<to>` is omitted, map `<from>` to itself (i.e., do not
> > +       anonymize it). See the section on `ANONYMIZING` below.
> 
> By the way (possible bikeshedding ahead), "seed anonymous" seems
> overly technical. I wonder if a name such as
> '--anonymize-to=<from>[:<to>]' might be clearer and easier for people
> to understand.

I wrestled with the name, and I agree "seed" is overly technical. And I
came up with many similar variations of "anonymize-to", but they all
seemed ambiguous (e.g., it could be "to" a file that we're storing the
data in).

Perhaps "--anonymize-map" would be less technical?

> In fact, in an earlier email, I asked whether --seed-anonymized should
> imply --anonymize. Thinking further on this, I wonder if we even need
> the second option name. It should be possible to overload the existing
> --anonymize to handle all functions. For instance:
> 
>     '--anonymize' would anonymize everything
> 
>     '--anonymize=<from>[:<to>]' would anonymize and map <from> to <to>
> 
> So, the example you give in the documentation would become:
> 
>     git fast-export --all \
>         --anonymize=foo.c:secret.c \
>         --anonymize=mybranch >stream
> 
> Or is that too cryptic?

Yeah, that was another one I considered, but it both seemed cryptic
(after all, we're saying what _not_ to anonymize), and it squats on the
"anonymize" option. So imagine we had another option later, like
"anonymize blobs and paths, but not refs", that could easily be
"--anonymize=blobs,path" or "--anonymize=!refs". I'd rather not paint
ourselves in a corner.

-Peff
