Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EE3C433E6
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 17:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE45C64F50
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 17:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhCQRdH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 13:33:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:39608 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhCQRcw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 13:32:52 -0400
Received: (qmail 26083 invoked by uid 109); 17 Mar 2021 17:32:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Mar 2021 17:32:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9736 invoked by uid 111); 17 Mar 2021 17:32:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Mar 2021 13:32:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Mar 2021 13:32:51 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] Makefile: add 'check-sort' target
Message-ID: <YFI9QzKMKLMXYoyz@coredump.intra.peff.net>
References: <cover.1615856156.git.liu.denton@gmail.com>
 <5088e93d76e44de9d079b7b2296b8c810828a2f5.1615856156.git.liu.denton@gmail.com>
 <87mtv2dk18.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mtv2dk18.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 17, 2021 at 01:47:15PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Why does this part need to be a Perl script at all? We can check this in
> the makefile itself. Make has a sort function and string comparisons,
> e.g.:
> 
> LIB_OBJS_SORTED =
> LIB_OBJS_SORTED += $(sort $(LIB_OBJS))
> ifneq ("$(LIB_OBJS)", "$(LIB_OBJS_SORTED)")
> $(error "please sort and de-duplicate LIB_OBJS!")
> endif
> 
> This will fail/pass before/after your patches. Note that make's sort
> isn't just a sort, it also de-deplicates (not that we're likely to have
> that issue).

I like that much better, if only because it runs quickly and
automatically (as opposed to much later as part of some CI process).
Reducing the length of the feedback loop makes automated checks much
less annoying.

It doesn't indicate which lines are out of order or duplicated. We could
probably add some $(shell) magic to dump both sides to diff inside the
ifneq. That's getting unwieldy to use in each site, but I wonder if
something like this solves that:

diff --git a/Makefile b/Makefile
index dfb0f1000f..3fa7893c8b 100644
--- a/Makefile
+++ b/Makefile
@@ -596,6 +596,16 @@ THIRD_PARTY_SOURCES =
 # interactive shell sessions without exporting it.
 unexport CDPATH
 
+# usage: $(call check-sort,VAR)
+# If this complains, then make sure the contents of VAR are ASCII-sorted.
+define check-sort-template
+SORTED_$1 = $$(sort $$($1))
+ifneq ($$($1),$$(SORTED_$1))
+$$(error "please sort and de-duplicate $1!")
+endif
+endef
+check-sort = $(eval $(call check-sort-template,$1))
+
 SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
@@ -1037,6 +1047,7 @@ LIB_OBJS += ws.o
 LIB_OBJS += wt-status.o
 LIB_OBJS += xdiff-interface.o
 LIB_OBJS += zlib.o
+$(call check-sort,LIB_OBJS)
 
 BUILTIN_OBJS += builtin/add.o
 BUILTIN_OBJS += builtin/am.o

And then it's just a single-liner for each block that should be checked.
We haven't used $(call) or $(eval) yet in our Makefile, but past
discussions have reached the conclusion that they should be safe
(they're both in GNU make 3.80, which is the oldest version worth caring
about).

TBH, I'm a little on the fence on whether automatically checking this is
even worth the hassle. Doing the make function above was a fun
diversion, but already I think this discussion has taken more time than
people actually spend resolving conflicts on unsorted Makefile lists.

> > [...]
> > +	./check-sort.perl '\t\{ "[^"]*",' <git.c
> 
> This last one you can IMO be done better as (or if we want to be more
> anal, we could make git die on startup if it's not true):
>     
>     diff --git a/t/t0012-help.sh b/t/t0012-help.sh
>     index 5679e29c62..5bd2ebceca 100755
>     --- a/t/t0012-help.sh
>     +++ b/t/t0012-help.sh
>     @@ -77,6 +77,11 @@ test_expect_success 'generate builtin list' '
>             git --list-cmds=builtins >builtins
>      '
>      
>     +test_expect_success 'list of builtins in git.c should be sorted' '
>     +       sort builtins >sorted &&
>     +       test_cmp sorted builtins
>     +'

Again, much nicer, because it just happens as part of the test suite
(which I hope everyone is running after making changes). If we care
about the order in the source code, then this check implies that we are
not sorting the list internally before outputting it, but that is
probably reasonable.

> > +	./check-sort.perl 'int cmd_[^(]*\(' <builtin.h
> > +	./check-sort.perl 'int cmd__[^(]*\(' <t/helper/test-tool.h
> 
> As something that can't be done in the Makefile itself or that we're
> already extracting from the tests.
> 
> Both of those IMO would be better handled down the line by making the
> relevant part of these files generated from the data in the Makefile, at
> which point we'd have no need for the external perl script.

Agreed. Automating away a tedious task is always better than
automatically checking that somebody did it right. :)

-Peff
