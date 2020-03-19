Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5654EC4332D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 17:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A772072D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 17:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgCSRDw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:03:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:44102 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727431AbgCSRDv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 13:03:51 -0400
Received: (qmail 26242 invoked by uid 109); 19 Mar 2020 17:03:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Mar 2020 17:03:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29041 invoked by uid 111); 19 Mar 2020 17:13:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Mar 2020 13:13:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 19 Mar 2020 13:03:50 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        christian.couder@gmail.com, james@jramsay.com.au
Subject: Re: Re*: [RFC PATCH 0/2] upload-pack.c: limit allowed filter choices
Message-ID: <20200319170350.GA4075823@coredump.intra.peff.net>
References: <CAP8UFD0wJo4onz0_Vw4-bcX1h61=J=ZiKfM-fMXLj4B9q0aveg@mail.gmail.com>
 <cover.1584477196.git.me@ttaylorr.com>
 <20200318101825.GB1227946@coredump.intra.peff.net>
 <xmqqtv2lfrk7.fsf_-_@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtv2lfrk7.fsf_-_@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 18, 2020 at 11:26:00AM -0700, Junio C Hamano wrote:

> > One thing that's a little ugly here is the embedded dot in the
> > subsection (i.e., "filter.<filter>"). It makes it look like a four-level
> > key, but really there is no such thing in Git.  But everything else we
> > tried was even uglier.
> 
> I think this gives us the best arrangement by upfront forcing all
> the configuration handers for "<subcommand>.*.<token>" namespace,
> current and future, to use "<group-prefix>" before the unbounded set
> of user-specifiable values that affects the <subcommand> (which is
> "uploadpack").
> 
> So far, the configuration variables that needs to be grouped by
> unbounded set of user-specifiable values we supported happened to
> have only one sensible such set for each <subcommand>, so we could
> get away without such <group-prefix> and it was perfectly OK to
> have, say "guitool.<name>.cmd".

Yeah. We have often just split those out into a separate hierarchy from
<subcommand> E.g., tar.<format>.command, which is really feeding the
git-archive command. We could do that here, too, but I wasn't sure of a
good name (this really is upload-pack specific, though I guess in theory
other commands could grow a need to look at or restrict "remote object
filters").

> Syntactically, the convention to always end such <group-prefix> with
> a dot "." may look unusual, or once readers' eyes get used to them,
> may look natural.  One tiny sad thing about it is that it cannot be
> mechanically enforced, but that is minor.

The biggest downside to implying a 4-level key is that the
case-sensitivity rules may be different. I.e., you can say:

  UploadPack.filter.blob:none.Allow

but not:

  UploadPack.Filter.blob:none.Allow

Since "filter" is part of the subsection, it's case sensitive. We could
match it case-insensitively in upload_pack_config(), but it would crop
up in other laces (e.g., "git config --unset" would still care).

> > We could do "uploadpackfilter.allow" and "uploadpackfilter.<filter>.allow",
> > but that's both ugly _and_ separates these options from the rest of
> > uploadpack.*.
> 
> There is an existing instance of a configuration that affects
> <subcommand> that uses a different word after <subcommand>, which is
> credentialCache.ignoreSIGHUP, and I tend to agree that it is ugly.

I don't think that's what's going on here. It affects only the
credential-cache subcommand, but we avoid hyphens in our key names.
So it really is the subcommand; it's just that the name is a superset of
another command name. :)

> By the way, I noticed the following while I was studying the current
> practice, so before I forget...
> 
> -- >8 --
> Subject: [PATCH] separate tar.* config to its own source file
> 
> Even though there is only one configuration variable in the
> namespace, it is not quite right to have tar.umask described
> among the variables for tag.* namespace.

Yeah, this is definitely an improvement. But I was surprised that
tar.<format>.* wasn't covered here. It is documented in git-archive.
Probably worth moving or duplicating it in git-config.

-Peff
