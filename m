Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A38C4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 17:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36D7723DC2
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 17:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390338AbgLKQD7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 11:03:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:58464 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390355AbgLKQDn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 11:03:43 -0500
Received: (qmail 9662 invoked by uid 109); 11 Dec 2020 16:02:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Dec 2020 16:02:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8136 invoked by uid 111); 11 Dec 2020 16:02:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Dec 2020 11:02:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Dec 2020 11:02:58 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 0/6] config: allow specifying config entries via env
Message-ID: <X9OYMnb8g8Hisvv0@coredump.intra.peff.net>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1607514692.git.ps@pks.im>
 <87y2i7vvz4.fsf@evledraar.gmail.com>
 <X9N1hcGl2rKH+CUU@ncase>
 <X9OB7ek8fVRXUBdK@coredump.intra.peff.net>
 <X9OGiuUUcVw83obp@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X9OGiuUUcVw83obp@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 11, 2020 at 03:47:38PM +0100, Patrick Steinhardt wrote:

> The issue we have is that the config file isn't necessarily under our
> control. It is in most cases, like e.g. when Gitaly gets deployed via
> Omnibus. But we also allow for source-based installations, where the
> user configures most things manually. And in that case, we have to ask
> the user to "Please set config variables A, B and C". Naturally, this is
> easy to forget, will drift apart in future releases and so on.

For GitHub, we ship a VM appliance, so we just put what we want into
/etc/gitconfig. I think in the worst case you could simplify everything
down to "put [include]path=/usr/share/gitlab/gitconfig into your system
config.  Though I'm a little surprised that you wouldn't just ship your
own version of Git that is used on the backend (so you know you have the
right version, plus any custom patches you'd want), and then point its
system config to /usr/share/gitlab/ or whatever.

But I'm probably just showing my ignorance of your setup / install
procedures, and there are a dozen reasons why that wouldn't work. ;)

> To fix this, the plan is to move all required configuration items into
> Gitaly itself, which GIT_CONFIG_COUNT would've allowd to do quite
> nicely. Something like Ævar's proposal to allow reading the config from
> a file descriptor would also work, and just putting the whole
> configuration into an environment variable (similar to your
> GIT_CONFIG_ENV_FILE, but containing contents instead of a path). And
> finally, using `-c` would also work, with the downside of making it
> harder to see what's going on with all the git processes.

We do have a couple scripts (like our git-repack wrapper) that make
heavy use of "git -c" to tweak things that don't have a command-line
option, or for which using it is awkward. It does clutter up "ps" a bit,
but it's sometimes nice to see the extra values, too (just as you'd see
command-line options).

-Peff
