Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817D5C433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 15:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6775920720
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 15:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404467AbgFXPrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:47:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:41920 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404253AbgFXPrm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 11:47:42 -0400
Received: (qmail 21273 invoked by uid 109); 24 Jun 2020 15:47:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Jun 2020 15:47:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30406 invoked by uid 111); 24 Jun 2020 15:47:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Jun 2020 11:47:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 24 Jun 2020 11:47:40 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 09/10] fast-export: allow seeding the anonymized mapping
Message-ID: <20200624154740.GA2088459@coredump.intra.peff.net>
References: <20200623152436.GA50925@coredump.intra.peff.net>
 <20200623152505.GI1435482@coredump.intra.peff.net>
 <CAPig+cTMu3SW5UE59Eva=jh-07hOT8Dz5A5trWyEugKd_2HaKg@mail.gmail.com>
 <20200623183053.GA1444619@coredump.intra.peff.net>
 <CAPig+cTFkAOyLG1Sm_p11GgH9Ms87_7zs-7kFbEYZ-uXg1yrYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTFkAOyLG1Sm_p11GgH9Ms87_7zs-7kFbEYZ-uXg1yrYw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 23, 2020 at 04:30:23PM -0400, Eric Sunshine wrote:

> > I'm not sure what you'd write, then. You can't mention "mybranch"
> > anymore if it was anonymized. Are you suggesting to make the example:
> >
> >  git rev-list -- foo.c
> >
> > by itself?
> 
> Sorry, I meant to provide an example like this:
> 
>     For example, if you have a bug which reproduces with `git rev-list
>     sensitive -- secret.c`, you can run:
> 
>     $ git fast-export --anonymize --all \
>         --seed-anonymized=sensitive:foo \
>         --seed-anonymized=secret.c:bar.c \
>         >stream
> 
>     After importing the stream, you can then run `git rev-list foo --
>     bar.c` in the anonymized repository.

Thanks, that makes sense. I took this as-is for my reroll (modulo the
change of option name discussed elsewhere).

> Hmm, perhaps your original attempt can be extended slightly to state
> it more explicitly?
> 
>     Note that paths and refnames are split into tokens at slash
>     boundaries. The command above would anonymize `subdir/foo.c` as
>     something like `path123/secret.c`; you could then search for
>     `secret.c` in the anonymized repository to determine the final
>     pathname.
> 
>     To make referencing the final pathname simpler, you can seed
>     anonymization for each path component; so, if you also anonymize
>     `subdir` to `publicdir`, then the final pathname would be
>     `publicdir/secret.c`.

Thanks, I took this modulo some fixups to match the example above, and
to avoid the use of the word "seed" based on our other discussion.

> This makes me wonder if --seed-anonymized should do its own
> tokenization so that --seed-anonymized=subdir/foo:public/bar is
> automatically understood as anonymizing "subdir" to "public" _and_
> "foo" to "bar". But that potentially gets weird if you say:
> 
>     --seed-anonymized=a/b:q/p --seed-anonymized=a/c:y/z
> 
> in which case you've given conflicting replacements for "a". (I
> suppose it could issue a warning message in that case.)

Right, I think you get into weird corner cases. Another issue is that
not all items are tokenized (e.g., if your author name was foo/bar,
you'd want that replaced as a whole). Probably you could add both the
broken-down and full inputs. Yet another issue is that you can't add a
token with a ":" due to the syntax.

This is an infrequently-enough-used feature that I think it's worth
keeping things simple, even if they're a little less convenient to
invoke.

> Lack of a warning or error could be kind of bad if the person doesn't
> check the fast-export file before sending it out and only discovers
> later that:
> 
>     git fast-export --seed-anonymized=foo:bar
> 
> didn't perform _any_ anonymization at all.

Good point. I'd hope people would glance at the output before sending it
out, but given that it's a potential safety issue, it probably is worth
detecting this case. I'll add it to my re-roll.

-Peff
