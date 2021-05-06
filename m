Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F6EC433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F9FE61177
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbhEFQ46 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 12:56:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:46562 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236044AbhEFQ45 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 12:56:57 -0400
Received: (qmail 30353 invoked by uid 109); 6 May 2021 16:55:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 May 2021 16:55:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23382 invoked by uid 111); 6 May 2021 16:55:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 May 2021 12:55:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 6 May 2021 12:55:58 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/4] Makefile: don't re-define PERL_DEFINES
Message-ID: <YJQfnviIeK7UdCBy@coredump.intra.peff.net>
References: <cover-0.4-00000000000-20210505T121857Z-avarab@gmail.com>
 <patch-1.4-ed2005a2fbf-20210505T121857Z-avarab@gmail.com>
 <YJKm0dnwHBwQuTi+@coredump.intra.peff.net>
 <xmqq4kfg3c4v.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq4kfg3c4v.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 06, 2021 at 10:05:20AM +0900, Junio C Hamano wrote:

> As to the simply-expanded vs recursively-expanded variable, there is
> aneed to use former, which comes from what the original commit
> 07d90ead did outside the context of this patch, which is:
> 
>     PERL_DEFINES := $(subst $(space),:,$(PERL_DEFINES))
>     GIT-PERL-DEFINES: FORCE
>             @FLAGS='$(PERL_DEFINES)'; \
>                 if test x"$$FLAGS" != x"`cat $@ 2>/dev/null`" ; then \
>                     echo >&2 "    * new perl-specific parameters"; \
>                     echo "$$FLAGS" >$@; \
>                 fi
> 
> That is, up to this point PERL_DEFINES accumulate various build-time
> settings with += (i.e. space separated tokens), and at this point
> finally it is turned into a colon separated tokens, which cannot be
> written with a recursively expanded variable.
> 
> But I tend to agree that you do not have to := clear the list in
> this patch.

OK, that matches my understanding. Thanks for laying out.

In general, I would say that the later use that you quoted above would
do better to use a second variable (because then there is no question of
when PERL_DEFINES is space-separated and when it is colon-separated).
But that is not that big a deal, and certainly very orthogonal to Ævar's
patch.

I'd also question whether the colon transformation is even necessary.
The point of the file is to change when the values change. Being sloppy
with delimiters means we _could_ miss a change, but in practice I doubt
it is very likely (and it is not like colons cannot appear in values,
either, so they are not foolproof). But again, not really important for
this patch.

-Peff

P.S. I also wondered briefly if make would preserve spaces even for
empty variables (since without that, we might miss delimiters and
confuse one of the variables for another). I.e., we know that:

  FOO = $(one):$(two):$(three)

will have two colons even if some of the variables are empty. But does
it preserve them even for "$(one) $(two) $(three)", or more importantly,
when using "+=" (which _would_ be relevant to this patch)? The answer is
yes, they are all fine.

You can demonstrate it with the Makefile below, running "make one=foo
three=bar", "make two=foo", etc.

-- >8 --
empty :=
space := $(empty) $(empty)

COLONS = $(one):$(two):$(three)

SPACES_SINGLE = $(one) $(two) $(three)
SPACES_SINGLE := $(subst $(space),:,$(SPACES_SINGLE))

SPACES_PLUS =
SPACES_PLUS += $(one)
SPACES_PLUS += $(two)
SPACES_PLUS += $(three)
SPACES_PLUS := $(subst $(space),:,$(SPACES_PLUS))

all:
	@echo "COLONS=$(COLONS)"
	@echo "SPACES_SINGLE=$(SPACES_SINGLE)"
	@echo "SPACES_PLUS=$(SPACES_PLUS)"
