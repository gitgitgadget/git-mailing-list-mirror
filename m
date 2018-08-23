Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A4751F954
	for <e@80x24.org>; Thu, 23 Aug 2018 00:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbeHWEMt (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 00:12:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:52506 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726058AbeHWEMt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 00:12:49 -0400
Received: (qmail 11961 invoked by uid 109); 23 Aug 2018 00:45:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 Aug 2018 00:45:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6186 invoked by uid 111); 23 Aug 2018 00:45:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 22 Aug 2018 20:45:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Aug 2018 20:45:44 -0400
Date:   Wed, 22 Aug 2018 20:45:44 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Subject: [PATCH 2/9] trailer: use size_t for iterating trailer list
Message-ID: <20180823004543.GB3126@sigill.intra.peff.net>
References: <20180823004300.GA1355@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180823004300.GA1355@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We store the length of the trailers list in a size_t. So on
a 64-bit system with a 32-bit int, in the unlikely case that
we manage to actually allocate a list with 2^31 entries,
we'd loop forever trying to iterate over it (our "int" would
wrap to negative before exceeding info->trailer_nr).

This probably doesn't matter in practice. Each entry is at
least a pointer plus a non-empty string, so even without
malloc overhead or the memory to hold the original string
we're parsing from, you'd need to allocate tens of
gigabytes. But it's easy enough to do it right.

Signed-off-by: Jeff King <peff@peff.net>
---
 sequencer.c | 2 +-
 trailer.c   | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 65d371c746..c81b276239 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -228,7 +228,7 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 	int ignore_footer)
 {
 	struct trailer_info info;
-	int i;
+	size_t i;
 	int found_sob = 0, found_sob_last = 0;
 
 	trailer_info_get(&info, sb->buf);
diff --git a/trailer.c b/trailer.c
index 88b35b8e89..40eef8880e 100644
--- a/trailer.c
+++ b/trailer.c
@@ -948,7 +948,7 @@ static size_t process_input_file(FILE *outfile,
 	struct trailer_info info;
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
-	int i;
+	size_t i;
 
 	trailer_info_get(&info, str);
 
@@ -1112,7 +1112,7 @@ void trailer_info_get(struct trailer_info *info, const char *str)
 
 void trailer_info_release(struct trailer_info *info)
 {
-	int i;
+	size_t i;
 	for (i = 0; i < info->trailer_nr; i++)
 		free(info->trailers[i]);
 	free(info->trailers);
@@ -1122,7 +1122,7 @@ static void format_trailer_info(struct strbuf *out,
 				const struct trailer_info *info,
 				const struct process_trailer_options *opts)
 {
-	int i;
+	size_t i;
 
 	/* If we want the whole block untouched, we can take the fast path. */
 	if (!opts->only_trailers && !opts->unfold) {
-- 
2.19.0.rc0.412.g7005db4e88

