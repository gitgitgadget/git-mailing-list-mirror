Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8CDC64EC4
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 09:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjCJJpP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 04:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjCJJpA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 04:45:00 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0672D144AF
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 01:44:28 -0800 (PST)
Received: (qmail 19390 invoked by uid 109); 10 Mar 2023 09:44:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Mar 2023 09:44:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10575 invoked by uid 111); 10 Mar 2023 09:44:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Mar 2023 04:44:28 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Mar 2023 04:44:27 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/5] diff: add --default-prefix option
Message-ID: <ZAr7+zW+pkOXoIfL@coredump.intra.peff.net>
References: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
 <ZAl4MkWVV8fr+3fO@coredump.intra.peff.net>
 <xmqq5yb9q42e.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5yb9q42e.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 09, 2023 at 08:31:37AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This isn't strictly necessary for the series, but it seemed like a gap.
> > You can always do:
> >
> >   git -c diff.noprefix=false -c diff.mnemonicprefix=false ...
> >
> > but that's rather a mouthful.
> 
> or "git diff --src-prefix=a/ --dst-prefix=b/"

Doh. How did I write this whole patch series without remembering the
existence of those options?

While it is not _quite_ the same thing to say "use prefixes a/ and b/"
versus "countermand any config and use the default", it is close enough
that I am tempted to say this patch should be scrapped. I mostly just
wanted to have a way to counter format.noprefix, if we are going to
endorse it as a concept (whether by adding it, or saying "no, respecting
diff.noprefix is not a bug").

(If we do scrap it, I'd probably fold the extra tests into the previous
commit, but using --src-prefix, etc).

> > +static int diff_opt_default_prefix(const struct option *opt,
> > +				   const char *optarg, int unset)
> > +{
> > +	struct diff_options *options = opt->value;
> > +
> > +	BUG_ON_OPT_NEG(unset);
> > +	BUG_ON_OPT_ARG(optarg);
> 
> OK.  It is a bit unsatisfactory that we already said this does not
> take negative form or any argument in the option[] array, and still
> have to do this, but that is completely outside the topic of this
> series.

We don't strictly have to do it. It's a cross-check that the correct
flags were set in the options struct, and serves as documentation both
for the human and the compiler (via -Wunused-parameter) that yes, it
really is correct to take "unset" and not look at it. We could just as
easily mark unset with "UNUSED", but I consider the extra run-time check
a bonus.

I do admit that in a one-off callback like this, it is not accomplishing
much. It's much more useful for generic ones like parse_opt_commit(),
that may be triggered from many places. I do wish there was a better way
to make sure they matched at compile-time, but I can't think of one.

-Peff
