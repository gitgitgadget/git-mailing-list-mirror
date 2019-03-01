Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C31820248
	for <e@80x24.org>; Fri,  1 Mar 2019 21:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfCAVyR (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 16:54:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:35028 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725905AbfCAVyR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 16:54:17 -0500
Received: (qmail 26579 invoked by uid 109); 1 Mar 2019 21:54:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Mar 2019 21:54:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1959 invoked by uid 111); 1 Mar 2019 21:54:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 01 Mar 2019 16:54:32 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Mar 2019 16:54:15 -0500
Date:   Fri, 1 Mar 2019 16:54:15 -0500
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] Makefile: use `git ls-files` to list header files,
 if possible
Message-ID: <20190301215414.GB1518@sigill.intra.peff.net>
References: <pull.130.git.gitgitgadget@gmail.com>
 <0b5529406b9458d37f3f5cdf38baa2d6a0a70a65.1551470265.git.gitgitgadget@gmail.com>
 <20190301213619.GA1518@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190301213619.GA1518@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 01, 2019 at 04:36:19PM -0500, Jeff King wrote:

> > However, as of ebb7baf02f (Makefile: add a hdr-check target,
> > 2018-09-19), $(LIB_H) is part of a global rule and therefore must be
> > expanded. Meaning: this `find` command has to be run upon every
> > `make` invocation. In the presence of many a worktree, this can tax the
> > developers' patience quite a bit.
> 
> I'm confused about this part. We don't run hdr-check by default. Why
> would make need the value of $(LIB_H)? Yet empirically it does run find.
> 
> Worse, it seems to actually run it _three times_. Once for the $(HCO)
> target, once for the .PHONY, and once for the hdr-check target. I think
> the .PHONY one is unavoidable (it doesn't know which names we might
> otherwise be building should be marked), but the other two seem like
> bugs in make (or at least pessimisations).
> 
> It makes me wonder if we'd be better off pushing hdr-check into a
> separate script. It doesn't actually use make's dependency tree in any
> meaningful way. And then regular invocations wouldn't even have to pay
> the `ls-files` price.
> 
> If we are going to keep it in the Makefile, we should probably use a
> ":=" rule to avoid running it three times.

Looping in Ramsay as the author of hdr-check. I think we could even do
this without using a separate script, like so:

diff --git a/Makefile b/Makefile
index c5240942f2..a65c4599e9 100644
--- a/Makefile
+++ b/Makefile
@@ -1852,7 +1852,6 @@ ifndef V
 	QUIET_MSGFMT   = @echo '   ' MSGFMT $@;
 	QUIET_GCOV     = @echo '   ' GCOV $@;
 	QUIET_SP       = @echo '   ' SP $<;
-	QUIET_HDR      = @echo '   ' HDR $<;
 	QUIET_RC       = @echo '   ' RC $@;
 	QUIET_SUBDIR0  = +@subdir=
 	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
@@ -2740,11 +2739,13 @@ EXCEPT_HDRS := $(GEN_HDRS) compat% xdiff%
 CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(patsubst ./%,%,$(LIB_H)))
 HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
 
-$(HCO): %.hco: %.h FORCE
-	$(QUIET_HDR)$(CC) -include git-compat-util.h -I. -o /dev/null -c -xc $<
-
-.PHONY: hdr-check $(HCO)
-hdr-check: $(HCO)
+.PHONY: hdr-check
+hdr-check:
+	@for i in $(LIB_H); do \
+		echo "    HDR $$i"; \
+		$(CC) -include git-compat-util.h -I. -o /dev/null -c -xc $$i || \
+			exit 1; \
+	done
 
 .PHONY: style
 style:

The one thing we do lose, though, is make's parallelization. It would
probably be possible to actually shove this into a sub-make which
defined the hdr-check rules, but I don't know how complicated that would
become.

> > This has one notable consequence: we no longer include `command-list.h`
> > in `LIB_H`, as it is a generated file, not a tracked one.
> 
> We should be able to add back $(GENERATED_H) as appropriate. I see you
> did it for the non-computed-dependencies case. Couldn't we do the same
> for $(LOCALIZED_C) and $(CHK_HDRS)?

Answering my own question somewhat: $(CHK_HDRS) explicitly ignores the
generated headers, so we wouldn't want to bother re-adding it there
anyway. Possibly $(LOCALIZED_C) would care, though. The generated file
does have translatable strings in it.

-Peff
