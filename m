Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14877C433FE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 14:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1DC220637
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 14:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406207AbgLKO3D (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 09:29:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:58270 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406205AbgLKO2i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 09:28:38 -0500
Received: (qmail 9148 invoked by uid 109); 11 Dec 2020 14:27:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Dec 2020 14:27:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7159 invoked by uid 111); 11 Dec 2020 14:27:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Dec 2020 09:27:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Dec 2020 09:27:57 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 0/6] config: allow specifying config entries via env
Message-ID: <X9OB7ek8fVRXUBdK@coredump.intra.peff.net>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1607514692.git.ps@pks.im>
 <87y2i7vvz4.fsf@evledraar.gmail.com>
 <X9N1hcGl2rKH+CUU@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X9N1hcGl2rKH+CUU@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 11, 2020 at 02:35:01PM +0100, Patrick Steinhardt wrote:

> > E.g. IIRC this whole series is because it's a hassle to invoke
> > core.askpass in some stateful program where you'd like to just provide a
> > transitory password. I think some brief cross-linking or explanation
> > somewhere of these various ways to pass sensitive values around would be
> > relly helpful.
> 
> It had been the original intention, yes. And it still is, but in fact
> the usecase has broadened to also use it to get rid of our global git
> config in Gitaly. Which is a little bit awkward to do with
> `--config-env` or `-c`, as now a ps(1) would first show a dozen of
> configuration values only to have the real command buried somewhere at
> the back. It would have been easy to implement though with the
> GIT_CONFIG_ envvars.

I don't know what kinds of variables you want to set exactly, but
another possible option here is some mechanism to point Git to an extra
config file. This would work if you are setting a bunch of options in
some static way, but not if you're setting them to custom values for
each command invocation (because then you'd be dealing with a temp file,
which is annoying and error-prone).

I'm thinking something like a $GIT_CONFIG_ENV_FILE that is parsed after
repo config but before $GIT_CONFIG_PARAMETERS.

Or alternatively, add an includeIf directive that lets you do something
like:

  [includeIf "env:FOO"]
  path = foo.gitconfig

which triggers if $FOO is set. But again, that's only useful if you have
certain "profiles" of config you're trying to set, and not custom
values.

-Peff
