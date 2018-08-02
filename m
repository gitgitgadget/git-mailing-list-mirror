Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 985891F597
	for <e@80x24.org>; Thu,  2 Aug 2018 18:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387740AbeHBUYE (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 16:24:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:40652 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387512AbeHBUYE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 16:24:04 -0400
Received: (qmail 21466 invoked by uid 109); 2 Aug 2018 18:31:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 02 Aug 2018 18:31:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26337 invoked by uid 111); 2 Aug 2018 18:31:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 02 Aug 2018 14:31:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Aug 2018 14:31:45 -0400
Date:   Thu, 2 Aug 2018 14:31:45 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PoC] coccinelle: make Coccinelle-related make targets more
 fine-grained
Message-ID: <20180802183145.GA23690@sigill.intra.peff.net>
References: <20180723135100.24288-1-szeder.dev@gmail.com>
 <20180802115522.16107-1-szeder.dev@gmail.com>
 <20180802180155.GD15984@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180802180155.GD15984@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 02, 2018 at 02:01:55PM -0400, Jeff King wrote:

> I suspect if we go with the one-spatch-per-source route, though, that we
> could do this just with regular make rules.

Yeah, it's pretty straightforward:

diff --git a/Makefile b/Makefile
index d616c0412..86fdcf567 100644
--- a/Makefile
+++ b/Makefile
@@ -2674,15 +2674,17 @@ COCCI_SOURCES = $(filter-out sha1collisiondetection/%,$(C_SOURCES))
 else
 COCCI_SOURCES = $(filter-out sha1dc/%,$(C_SOURCES))
 endif
+COCCI_COMBINED = contrib/coccinelle/combined.cocci
+COCCI_SEM_PATCHES = $(filter-out $(COCCI_COMBINED), $(wildcard contrib/coccinelle/*.cocci))
 
-%.cocci.patch: %.cocci $(COCCI_SOURCES)
+$(COCCI_COMBINED): $(COCCI_SEM_PATCHES)
+	cat $^ >$@+
+	mv $@+ $@
+
+$(COCCI_COMBINED).patches/%.patch: % $(COCCI_COMBINED)
 	@echo '    ' SPATCH $<; \
-	ret=0; \
-	for f in $(COCCI_SOURCES); do \
-		$(SPATCH) --sp-file $< $$f $(SPATCH_FLAGS) || \
-			{ ret=$$?; break; }; \
-	done >$@+ 2>$@.log; \
-	if test $$ret != 0; \
+	mkdir -p $(dir $@) || exit 1; \
+	if ! $(SPATCH) --sp-file $(COCCI_COMBINED) $< $(SPATCH_FLAGS) >$@+ 2>$@.log; \
 	then \
 		cat $@.log; \
 		exit 1; \
@@ -2692,7 +2694,8 @@ endif
 	then \
 		echo '    ' SPATCH result: $@; \
 	fi
-coccicheck: $(addsuffix .patch,$(wildcard contrib/coccinelle/*.cocci))
+
+coccicheck: $(patsubst %, $(COCCI_COMBINED).patches/%.patch, $(COCCI_SOURCES))
 
 .PHONY: coccicheck
 
@@ -2907,7 +2910,7 @@ profile-clean:
 	$(RM) $(addsuffix *.gcno,$(addprefix $(PROFILE_DIR)/, $(object_dirs)))
 
 cocciclean:
-	$(RM) contrib/coccinelle/*.cocci.patch*
+	$(RM) -r contrib/coccinelle/*.cocci.patches
 
 clean: profile-clean coverage-clean cocciclean
 	$(RM) *.res

I guess you could even replace "COCCI_COMBINED" with "COCCI_PATCH" in
most of the targets, and that would let people do individual:

  make COCCI_PATCH=contrib/coccinelle/foo.cocci coccicheck

The default would just be the concatenated version.

-Peff
