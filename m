Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06460C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 02:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C47DD61090
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 02:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhIVCM5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 22:12:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:52288 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229734AbhIVCM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 22:12:56 -0400
Received: (qmail 7412 invoked by uid 109); 22 Sep 2021 02:11:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Sep 2021 02:11:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8426 invoked by uid 111); 22 Sep 2021 02:11:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Sep 2021 22:11:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Sep 2021 22:11:26 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 0/3] Makefile: make "sparse" and "hdr-check" non-.PHONY
Message-ID: <YUqQzn5vFDpbF5dM@coredump.intra.peff.net>
References: <cover-0.3-00000000000-20210921T224944Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.3-00000000000-20210921T224944Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 12:55:12AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Now that my series to only build "TAGS" when we strictly need to has
> landed in 1b8bd2243e7 (Merge branch 'ab/make-tags-cleanup',
> 2021-09-20), let's do the same for the "sparse" and "hdr-check"
> targets.
> 
> For *.c files we'll now generate corresponding empty *.sp and *.hco
> files when "sparse" and "hdr-check" are run, respectively. If either
> of those errored on the *.c file we'd fail to refresh the
> corresponding generated file.

All three seem pretty reasonable to me.

Though could we be confused in the sparse rule by a header file that
changed? The object files depend on the auto-computed dependencies or on
LIB_H, but the sparse rule doesn't. So, with your patch:

  $ echo '/* ok */' >>git-compat-util.h
  $ make sparse
  [lots of output, everything ok]

  $ echo 'not ok' >>git-compat-util.h
  $ make sparse
  [no output; nothing is run]

  $ touch git.c
  $ make sparse
  git.c: note: in included file (through builtin.h):
  git-compat-util.h:1382:1: error: 'not' has implicit type
  git-compat-util.h:1382:5: error: Expected ; at end of declaration
  [...etc...]

I think it's hard to use the computed dependencies here, because they're
written by the compiler with explicit ".o" targets. But we could either:

  1. make them all depend on LIB_H. That's overly broad, but still
     better than the status quo; or

  2. have "foo.sp" depend on "foo.o". That requires you to build things
     before doing sparse checks, but in practice most people would
     presumably _also_ be compiling anyway, I'd think.

I.e., this works for me (the second "make sparse" in my example above
rebuilds and shows the errors):

diff --git a/Makefile b/Makefile
index e44eb4a62a..a97e52eb19 100644
--- a/Makefile
+++ b/Makefile
@@ -2903,7 +2903,7 @@ check-sha1:: t/helper/test-tool$X
 
 SP_OBJ = $(patsubst %.o,%.sp,$(C_OBJ))
 
-$(SP_OBJ): %.sp: %.c GIT-CFLAGS
+$(SP_OBJ): %.sp: %.c %.o GIT-CFLAGS
 	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
 		-Wsparse-error \
 		$(SPARSE_FLAGS) $(SP_EXTRA_FLAGS) $< && \

-Peff
