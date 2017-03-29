Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E847020966
	for <e@80x24.org>; Wed, 29 Mar 2017 07:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753529AbdC2HLA (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 03:11:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:53429 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753430AbdC2HK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 03:10:59 -0400
Received: (qmail 20630 invoked by uid 109); 29 Mar 2017 07:10:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Mar 2017 07:10:56 +0000
Received: (qmail 20917 invoked by uid 111); 29 Mar 2017 07:11:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Mar 2017 03:11:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Mar 2017 03:10:55 -0400
Date:   Wed, 29 Mar 2017 03:10:55 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Makefile: detect errors in running spatch
Message-ID: <20170329071055.bp7d2gwqdhspz4aq@sigill.intra.peff.net>
References: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
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
This is a verbatim repost of:

  http://public-inbox.org/git/20170310083117.cbflqx7zbe4s7cqv@sigill.intra.peff.net/

I think this is a strict improvement over the status quo. The
conversation in that thread turned to possible refactorings, but since
those didn't materialize, I think we should apply this in the meantime.

 Makefile | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 9f8b35ad4..9b36068ac 100644
--- a/Makefile
+++ b/Makefile
@@ -2348,9 +2348,17 @@ check: common-cmds.h
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
2.12.2.920.gc31091ce4
