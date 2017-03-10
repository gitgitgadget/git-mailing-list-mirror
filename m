Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50174202F8
	for <e@80x24.org>; Fri, 10 Mar 2017 08:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932192AbdCJIbW (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 03:31:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:41864 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755228AbdCJIbV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 03:31:21 -0500
Received: (qmail 14276 invoked by uid 109); 10 Mar 2017 08:31:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Mar 2017 08:31:19 +0000
Received: (qmail 3117 invoked by uid 111); 10 Mar 2017 08:31:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Mar 2017 03:31:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Mar 2017 03:31:18 -0500
Date:   Fri, 10 Mar 2017 03:31:18 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: [PATCH] Makefile: detect errors in running spatch
Message-ID: <20170310083117.cbflqx7zbe4s7cqv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "make coccicheck" target runs spatch against each source
file. But it does so in a for loop, so "make" never sees the
exit code of spatch. Worse, it redirects stderr to a log
file, so the user has no indication of any failure. And then
to top it all off, because we touched the patch file's
mtime, make will refuse to repeat the command because it
think the target is up-to-date.

So for example:

  $ make coccicheck SPATCH=does-not-exist
      SPATCH contrib/coccinelle/free.cocci
      SPATCH contrib/coccinelle/qsort.cocci
      SPATCH contrib/coccinelle/xstrdup_or_null.cocci
      SPATCH contrib/coccinelle/swap.cocci
      SPATCH contrib/coccinelle/strbuf.cocci
      SPATCH contrib/coccinelle/object_id.cocci
      SPATCH contrib/coccinelle/array.cocci
  $ make coccicheck SPATCH=does-not-exist
  make: Nothing to be done for 'coccicheck'.

With this patch, you get:

  $ make coccicheck SPATCH=does-not-exist
       SPATCH contrib/coccinelle/free.cocci
  /bin/sh: 4: does-not-exist: not found
  Makefile:2338: recipe for target 'contrib/coccinelle/free.cocci.patch' failed
  make: *** [contrib/coccinelle/free.cocci.patch] Error 1

It also dumps the log on failure, so any errors from spatch
itself (like syntax errors in our .cocci files) will be seen
by the user.

Signed-off-by: Jeff King <peff@peff.net>
---
This shell code is getting a bit unwieldy to stick inside the Makefile,
with all the line continuation and $-escaping.  It might be worth moving
it into a helper script.

It also doesn't help that shells are awkward at passing status out of a
for-loop. I think the most "make-ish" way of doing this would actually
be to lose the for loop and have a per-cocci-per-source target.

I don't know if that would make the patches harder to apply. The results
aren't full patches, so I assume you usually do some kind of munging on
them? I resorted to:

  make coccicheck SPATCH='spatch --in-place'

 Makefile | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 9ec6065cc..d97633892 100644
--- a/Makefile
+++ b/Makefile
@@ -2336,9 +2336,17 @@ check: common-cmds.h
 C_SOURCES = $(patsubst %.o,%.c,$(C_OBJ))
 %.cocci.patch: %.cocci $(C_SOURCES)
 	@echo '    ' SPATCH $<; \
+	ret=0; \
 	for f in $(C_SOURCES); do \
-		$(SPATCH) --sp-file $< $$f $(SPATCH_FLAGS); \
-	done >$@ 2>$@.log; \
+		$(SPATCH) --sp-file $< $$f $(SPATCH_FLAGS) || \
+			{ ret=$$?; break; }; \
+	done >$@+ 2>$@.log; \
+	if test $$ret != 0; \
+	then \
+		cat $@.log; \
+		exit 1; \
+	fi; \
+	mv $@+ $@; \
 	if test -s $@; \
 	then \
 		echo '    ' SPATCH result: $@; \
-- 
2.12.0.450.gd7e60cc16
