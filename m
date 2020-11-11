Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD858C388F7
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 02:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 624272065E
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 02:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbgKKCWk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 21:22:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:53864 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731899AbgKKCWk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 21:22:40 -0500
Received: (qmail 10267 invoked by uid 109); 11 Nov 2020 02:22:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Nov 2020 02:22:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11707 invoked by uid 111); 11 Nov 2020 02:22:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Nov 2020 21:22:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Nov 2020 21:22:38 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Demi M. Obenour" <athena@invisiblethingslab.com>,
        Git <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] rev-parse: handle --end-of-options
Message-ID: <20201111022238.GA806755@coredump.intra.peff.net>
References: <20201110213544.GA3263091@coredump.intra.peff.net>
 <20201110214019.GC788740@coredump.intra.peff.net>
 <xmqqr1p06ec9.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1p06ec9.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 10, 2020 at 02:23:34PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This patch lets callers write:
> >
> >   git rev-parse --end-of-options "$rev" -- "$path"
> >
> > and:
> >
> >   git rev-parse --verify --end-of-options "$rev"
> >
> > which will both treat "$rev" always as a revision parameter.
> 
> Nice.  The only iffy case I can think of is that we can never have
> "--" to specify a rev, because with "git cmd -- -- path" we don't
> know which double-dash among the two is the disambiguator that makes
> the other double-dash to be either rev or path, but that is not a
> new problem with this change.

Yeah. It is sufficient to me that "rev-parse" (or any command) does not
do a bad thing when somebody malicious asks about "--", even if the repo
contents themselves are sane and do not have "--". If somebody has a
not-sane repo with refs/heads/-- and the worst case is that they have
trouble accessing it without a fully-qualified name, then I find it hard
to sympathize. ;)

> > +test_expect_success 'verify respects --end-of-options' '
> > +	git update-ref refs/heads/-tricky HEAD &&
> > +	git rev-parse --verify HEAD >expect &&
> > +	git rev-parse --verify --end-of-options -tricky >actual &&
> > +	test_cmp expect actual
> > +'
> 
> ;-)  Or refs/heads/--tricky?

Yeah, arguably that is a better name. It could even be a real option
name, though once the bug is fixed none of it matters. :)

-Peff
