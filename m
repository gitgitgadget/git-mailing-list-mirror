Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA61C433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 17:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F4F860EE5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 17:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbhIVRG0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 13:06:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:52656 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236764AbhIVRG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 13:06:26 -0400
Received: (qmail 10095 invoked by uid 109); 22 Sep 2021 17:04:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Sep 2021 17:04:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15538 invoked by uid 111); 22 Sep 2021 17:04:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Sep 2021 13:04:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Sep 2021 13:04:54 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: make COMPUTE_HEADER_DEPENDENCIES=auto work
 with DEVOPTS=pedantic
Message-ID: <YUtiNuUiBU4Xg4gw@coredump.intra.peff.net>
References: <patch-1.1-6b2e9af5e67-20210922T103749Z-avarab@gmail.com>
 <xmqqmto48ufz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqmto48ufz.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 09:08:00AM -0700, Junio C Hamano wrote:

> While I agree with your analysis of the problem, I cannot shake this
> nagging feeling that the proposed solution is barking up a wrong
> tree.  After all, -pedantic and any other option that lets the
> compiler notice that it is being asked to compile an empty source
> can come directly from the end user (e.g. CC="gcc -pedantic" or as
> part of CFLAGS)---realization of which makes me wonder if it is
> essential to compile /dev/null for this check, or any reasonably
> syntactically correct program would do.
> 
> I wonder if the attached (with clean-up to remove the tracing cruft)
> would show us a better direction.  It feeds a single line
> 
> 	int dummy_for_dep_check;
> 
> C "program" from the standard input of the compiler to tackle the
> "you are not supposed to be compiling an empty compilation unit"
> problem in a more direct way.

That feels a bit like we're playing a game of chicken with the compiler
in terms of what it may complain about. For example, sparse will
complain:

  foo.c:1:5: warning: symbol 'dummy_for_dep_check' was not declared. Should it be static?

Might compilers ever learn to warn of the same thing?

I kind of like the simplicity of Ævar's approach. We want to know if the
compiler can be invoked with options XYZ, so we do so. That should be
largely independent of our cflags, and there's prior art in how we
invoke it in the detect-compiler script.

So I'd argue we should go even simpler, like:

diff --git a/Makefile b/Makefile
index 3628d14f16..4597a126d0 100644
--- a/Makefile
+++ b/Makefile
@@ -1277,7 +1277,7 @@ COMPUTE_HEADER_DEPENDENCIES = auto
 endif
 
 ifeq ($(COMPUTE_HEADER_DEPENDENCIES),auto)
-dep_check = $(shell $(CC) $(ALL_CFLAGS) \
+dep_check = $(shell $(CC) \
 	-c -MF /dev/null -MQ /dev/null -MMD -MP \
 	-x c /dev/null -o /dev/null 2>&1; \
 	echo $$?)

I'm also tempted by a hunk like this. Then we can set the REQUIRE flag
in a CI job (or locally for git devs who know they have gcc) and notice
an unexpected breakage in the auto test.

@@ -1295,6 +1295,9 @@ ifneq ($(COMPUTE_HEADER_DEPENDENCIES),no)
 $(error please set COMPUTE_HEADER_DEPENDENCIES to yes, no, or auto \
 (not "$(COMPUTE_HEADER_DEPENDENCIES)"))
 endif
+ifdef REQUIRE_COMPUTE_HEADER_DEPENDENCIES
+$(error computed header dependencies required, but auto-check did not find them)
+endif
 endif
 
 ifndef GENERATE_COMPILATION_DATABASE

-Peff
