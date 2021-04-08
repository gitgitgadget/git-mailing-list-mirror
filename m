Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628A5C433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16B0561106
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbhDHXkz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 19:40:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:45338 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232991AbhDHXky (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 19:40:54 -0400
Received: (qmail 25971 invoked by uid 109); 8 Apr 2021 23:40:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Apr 2021 23:40:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4588 invoked by uid 111); 8 Apr 2021 23:40:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Apr 2021 19:40:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Apr 2021 19:40:41 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: add missing dependencies of 'config-list.h'
Message-ID: <YG+UeQRwdBsVeRNV@coredump.intra.peff.net>
References: <20200416211807.60811-2-emilyshaffer@google.com>
 <20210408212915.3060286-1-szeder.dev@gmail.com>
 <87pmz4ig4o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pmz4ig4o.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 09, 2021 at 12:08:23AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > -config-list.h:
> > +config-list.h: Documentation/*config.txt Documentation/config/*.txt
> >  	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh \
> >  		>$@+ && mv $@+ $@
> >  
> >  command-list.h: generate-cmdlist.sh command-list.txt
> >  
> > -command-list.h: $(wildcard Documentation/git*.txt) Documentation/*config.txt Documentation/config/*.txt
> > +command-list.h: $(wildcard Documentation/git*.txt)
> >  	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh \
> >  		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
> >  		command-list.txt >$@+ && mv $@+ $@
> 
> This change makes sense.

I agree it looks like it's moving in the right direction, but I am
slightly puzzled by the existing code. Why do we need to use $(wildcard)
for git*.txt, but not for the others?

> I have a not-yet-submitted patch series where I added some more
> config/*/*.txt that wouldn't be caught by this rule, I'd updated the
> Documentation/Makefile, but missed this part in the top-level Makefile.
> 
> So a relation question: Does anyone actually prefer this state of
> affairs of having a Makefile, Documentation/Makefile, t/Makefile
> t/perf/Makefile and template/Makefile?
> 
> It seems to me with ever-closer coupling between them that it's getting
> to be more of a hassle to manage state between them than it would be to
> just move them all into one big Makefile.

Yes, I'm generally a fan of avoiding recursive make when we can. I think
the caveats are:

  - it would be nice to continue to have stub Makefiles in
    sub-directories that trigger the main one (so "cd t && make"
    continues to work, for example).

  - we may need some cleanup of parts of the top-level Makefile which
    are triggered without dependencies (e.g., I think we unconditionally
    run some scripts to compute GIT_VERSION in the top-level; this is
    already a bit wasteful, but may get even more so as we add more
    rules from sub-directories).

Mostly my argument against it (and why I haven't purused it) would be:
it sounds like a lot of work and risk of regression, and the current
system seems pretty fine in practice.

-Peff
