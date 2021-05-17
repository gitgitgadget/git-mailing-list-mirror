Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9ACFC433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 11:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 952DD61166
	for <git@archiver.kernel.org>; Mon, 17 May 2021 11:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbhEQLkq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 07:40:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:56210 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236750AbhEQLkq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 07:40:46 -0400
Received: (qmail 5108 invoked by uid 109); 17 May 2021 11:39:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 May 2021 11:39:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28441 invoked by uid 111); 17 May 2021 11:39:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 May 2021 07:39:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 May 2021 07:39:28 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 01/11] doc: allow the user to provide ASCIIDOC_EXTRA
Message-ID: <YKJV8HBYCA7hEQiX@coredump.intra.peff.net>
References: <20210514121435.504423-1-felipe.contreras@gmail.com>
 <20210514121435.504423-2-felipe.contreras@gmail.com>
 <YJ+VGKUa0Kk3BRWQ@coredump.intra.peff.net>
 <YJ+WzATLCM8SW2GH@coredump.intra.peff.net>
 <609fbafc73fcd_e173a208f4@natae.notmuch>
 <YKIwDTQI3sBXu+7W@coredump.intra.peff.net>
 <60a24b25499c0_126a0520823@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60a24b25499c0_126a0520823@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 17, 2021 at 05:53:25AM -0500, Felipe Contreras wrote:

> > It's meant for the caller of "make". Your proposed use is within
> > doc-diff, but any user running "make ASCIIDOC_EXTRA=foo" would see the
> > different behavior.
> 
> Yeah, they would, but I don't think it would be wrong behavior.

It depends what they're trying to do. If they write:

  make ASCIIDOC_EXTRA=--one-extra-option

then they probably intend to to add to the options we set. If they
write:

  make ASCIIDOC_EXTRA='-acompat-mode -atabsize=4 ...etc...'

with the intent of replicating the flags but changing or removing some
elements, then it would no longer do what they want.

I don't mean to imply one is more right than the other (I'd suspect even
that the override behavior is more likely to be what somebody wants).
I'm mostly pointing out that this is unlike the rest of our Makefiles,
which do not ever use override (and that the effect is visible to the
caller, depending on what they want to do).

> > I'd probably call it ASCIIDOC_FLAGS (like we have CFLAGS and LDFLAGS
> > that are meant for users to inform us of extra flags they'd like
> > passed).
> 
> Right, but Makefiles do override those, like:
> 
>   override CFLAGS += -fPIC
> 
> Otherwise builds may fail.

Some Makefiles do, but in this project we have not historically used
override. Instead, we provide defaults for things like CFLAGS, expect
the use to replace them if they like, and then aggregate them (along
with other internal variables) into things like ALL_CFLAGS.

> > Of course that may not solve your problem in a sense; if you want
> > doc-diff to override it, then that might conflict with a theoretical
> > ASCIIDOC_FLAGS somebody set in their config.mak (but we really are in
> > the realm of hypothetical here).
> 
> Setting ASCIIDOC_FLAGS in config.mk would not override the
> user-supplied flags any more than setting them in the Makefile (they are
> virtually the same thing as one includes the other).
> 
> It's only if the user has `override ASCIIDOC_FLAGS` in config.mk that
> such a problem would arise. And that's really hypothetical.

I mean that if your doc-diff runs:

  make USE_ASCIIDOCTOR=Yes ASCIIDOC_FLAGS=-adocdate=01/01/1970

then that will override anything the user put into config.mak. If they
had some option like:

  ASCIIDOC_FLAGS = --load-path=/some/special/directory

they need for asciidoctor to run correctly on their system, then things
would break for them. But we don't even have a user-facing
ASCIIDOC_FLAGS now, and nobody is asking for it, so it's pretty
hypothetical (I'd guess somebody in this situation would just set
ASCIIDOC="asciidoctor --load-path=...", and that already doesn't work
with doc-diff).

-Peff
