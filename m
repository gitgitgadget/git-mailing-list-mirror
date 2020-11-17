Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B43C388F9
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 02:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0C752469C
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 02:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgKQCez (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 21:34:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:60004 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgKQCez (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 21:34:55 -0500
Received: (qmail 13387 invoked by uid 109); 17 Nov 2020 02:34:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 17 Nov 2020 02:34:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21652 invoked by uid 111); 17 Nov 2020 02:34:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Nov 2020 21:34:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Nov 2020 21:34:54 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] config: allow specifying config entries via envvar
 pairs
Message-ID: <20201117023454.GA34754@coredump.intra.peff.net>
References: <cover.1605269465.git.ps@pks.im>
 <44e8dd50c6ea7cbcc5e4fc35c9b9057c0a52038c.1605269465.git.ps@pks.im>
 <87mtzlflw7.fsf@evledraar.gmail.com>
 <xmqqy2j1851k.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2j1851k.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 16, 2020 at 11:39:35AM -0800, Junio C Hamano wrote:

> >> While not document, it is currently possible to specify config entries
> >> [in GIT_CONFIG_PARAMETERS]
> [...]
>
> "While not documented" yes, for sure, but we do not document it for
> a good reason---it is a pure implementation detail between Git
> process that runs another one as its internal implementation detail.

I have actually been quite tempted to document and promise that it will
continue to work. Because it really is useful in some instances. The
thing that has held me back is that the documentation would reveal how
unforgiving the parser is. ;)

It insists that key/value pairs are shell-quoted as a whole. I think if
we made it accept a some reasonable inputs:

  - do not require quoting for values that do not need it

  - allow any amount of shell-style single-quoting (whole parameters,
    just values, etc).

  - do not bother allowing other quoting, like double-quotes with
    backslashes. However, document backslash and double-quote as
    meta-characters that must not appear outside of single-quotes, to
    allow for future expansion.

then I'd feel comfortable making it a public-facing feature. And for
most cases it would be pretty pleasant to use (and for the unpleasant
ones, I'm not sure that a little quoting is any worse than the paired
environment variables found here).

> I especially do not think we want to read from unbounded number of
> GIT_CONFIG_KEY_<N> variables like this patch does.  How would a
> script cleanse its environment to protect itself from stray such
> environment variable pair?  Count up from 1 to forever?  Run "env"
> and grep for "GIT_CONFIG_KEY_[0-9]*=" (the answer is No.  What if
> some environment variables have newline in its values?)

Yeah, scripts can currently assume that:

  unset $(git rev-parse --local-env-vars)

will drop any config from the environment. In some cases, having
rev-parse enumerate the GIT_CONFIG_KEY_* variables that are set would be
sufficient. But that implies that rev-parse is seeing the same
environment we're planning to clear. As it is now, a script is free to
use rev-parse to generate that list, hold on to it, and then use it
later.

-Peff
