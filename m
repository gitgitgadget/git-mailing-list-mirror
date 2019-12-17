Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB580C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 05:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966122072B
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 05:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbfLQFWZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 00:22:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:48282 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725796AbfLQFWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 00:22:25 -0500
Received: (qmail 29695 invoked by uid 109); 17 Dec 2019 05:22:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Dec 2019 05:22:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19660 invoked by uid 111); 17 Dec 2019 05:27:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 17 Dec 2019 00:27:01 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 17 Dec 2019 00:22:24 -0500
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] Makefile: drop GEN_HDRS
Message-ID: <20191217052224.GA2762303@coredump.intra.peff.net>
References: <xmqq1rt7hkp6.fsf@gitster-ct.c.googlers.com>
 <20191214003820.GA927924@coredump.intra.peff.net>
 <20191214010002.GA945704@coredump.intra.peff.net>
 <xmqqlfrcje1f.fsf@gitster-ct.c.googlers.com>
 <20191216192014.GA2678964@coredump.intra.peff.net>
 <20191217012756.GQ135450@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191217012756.GQ135450@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 16, 2019 at 05:27:56PM -0800, Emily Shaffer wrote:

> > Yeah, I don't think there's any change in behavior here, since with the
> > exception of hdr-check, every mention of $(LIB_H) also mentioned
> > $(GENERATED_H). And in the case of hdr-check, we explicitly exclude the
> > only item found in $(GENERATED_H).
> 
> To check my understanding - hdr-check just says "the headers are
> syntactically correct", right? $HCO's target '-o /dev/null' says
> "don't save the output", '-c' says "just compile, don't link", and '-xc'
> says "in C"; it expands to a target for each file ending in .h but not
> in $EXCEPT_HDRS, and hdr-check calls each one of those expanded targets,
> so I think I understand hdr-check is compiling each header...

Sort of.  It's less about "syntactically correct" (which we'd find out
easily when we try to compile it) and more about "does not have
unexpected dependencies on other files".

E.g., imagine I write a header foo.h that mentions "struct bar", which
is declared in bar.h. If the only C file that uses that does:

  #include "bar.h"
  #include "foo.h"

then the compiler is happy. But I've laid a trap for somebody later, who
does just:

  #include "foo.h"

and gets an annoying compiler error (which is trivial to fix in this
example, but can sometimes get complicated to untangle).

So we declared a rule that header files should be self-sufficient
(modulo git-compat-util.h), and hdr-check is the way to find out if that
is true.

> > but I'm not sure if that is really turning up any useful problems. I
> > suppose somebody besides help.c could include command-list.h, in which
> > case some of those MAYBE_UNUSED bits could become useful.
> 
> Firstly, I think if someone besides help.c includes command-list.h it
> blows up because there's no include guards :)

Only if another header file does it, which could easily cause double
inclusion within the same source file. It's perfectly fine for another
translation unit to include it.

(Side note: builtin/help.c is declared in the Makefile as depending on
it, but doesn't seem to actually include it).

> My gut wants to say, "I need to be sure my generated header is correct!"
> But it seems that will also be checked when I try to include that header
> from something actually important. So maybe it's not actually useful.
> But then it seems like hdr-check target isn't that useful for anybody,
> since those headers should always be included sometime down the road (or
> why have them). So that makes me think I must still be missing
> something, like maybe I parsed hdr-check wrong.

I think this is the "it compiles now but you've laid a trap..." thing
mentioned above.

As it is, command-list.h _does_ have such a trap; you need to include
gettext.h first. But since so few callers use it (and are likely to use
it) nobody has really noticed or cared.

-Peff
