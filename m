Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73CBA1F954
	for <e@80x24.org>; Thu, 23 Aug 2018 00:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbeHWEN3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 00:13:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:52518 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725924AbeHWEN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 00:13:28 -0400
Received: (qmail 12014 invoked by uid 109); 23 Aug 2018 00:46:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 Aug 2018 00:46:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6205 invoked by uid 111); 23 Aug 2018 00:46:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 22 Aug 2018 20:46:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Aug 2018 20:46:23 -0400
Date:   Wed, 22 Aug 2018 20:46:23 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Subject: [PATCH 3/9] trailer: pass process_trailer_opts to trailer_info_get()
Message-ID: <20180823004623.GC3126@sigill.intra.peff.net>
References: <20180823004300.GA1355@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180823004300.GA1355@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most of the trailer code has an "opts" struct which is
filled in by the caller. We don't pass it down to
trailer_info_get(), which does the initial parsing, because
there hasn't yet been a need to do so.

Let's start passing it down in preparation for adding new
options. Note that there's a single caller which doesn't
otherwise have such an options struct. Since it's just one
caller (that we'd have to modify anyway), let's not bother
with any special treatment like accepting a NULL options
struct, and just have it allocate one with the defaults.

Signed-off-by: Jeff King <peff@peff.net>
---
We end up needing to pass an option in that caller later anyway...

 sequencer.c | 3 ++-
 trailer.c   | 7 ++++---
 trailer.h   | 3 ++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index c81b276239..3e15faa94e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -227,11 +227,12 @@ static const char *get_todo_path(const struct replay_opts *opts)
 static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 	int ignore_footer)
 {
+	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
 	struct trailer_info info;
 	size_t i;
 	int found_sob = 0, found_sob_last = 0;
 
-	trailer_info_get(&info, sb->buf);
+	trailer_info_get(&info, sb->buf, &opts);
 
 	if (info.trailer_start == info.trailer_end)
 		return 0;
diff --git a/trailer.c b/trailer.c
index 40eef8880e..e769c5b72c 100644
--- a/trailer.c
+++ b/trailer.c
@@ -950,7 +950,7 @@ static size_t process_input_file(FILE *outfile,
 	struct strbuf val = STRBUF_INIT;
 	size_t i;
 
-	trailer_info_get(&info, str);
+	trailer_info_get(&info, str, opts);
 
 	/* Print lines before the trailers as is */
 	if (!opts->only_trailers)
@@ -1067,7 +1067,8 @@ void process_trailers(const char *file,
 	strbuf_release(&sb);
 }
 
-void trailer_info_get(struct trailer_info *info, const char *str)
+void trailer_info_get(struct trailer_info *info, const char *str,
+		      const struct process_trailer_options *opts)
 {
 	int patch_start, trailer_end, trailer_start;
 	struct strbuf **trailer_lines, **ptr;
@@ -1159,7 +1160,7 @@ void format_trailers_from_commit(struct strbuf *out, const char *msg,
 {
 	struct trailer_info info;
 
-	trailer_info_get(&info, msg);
+	trailer_info_get(&info, msg, opts);
 	format_trailer_info(out, &info, opts);
 	trailer_info_release(&info);
 }
diff --git a/trailer.h b/trailer.h
index 9c10026c35..b38c8f0d16 100644
--- a/trailer.h
+++ b/trailer.h
@@ -79,7 +79,8 @@ void process_trailers(const char *file,
 		      const struct process_trailer_options *opts,
 		      struct list_head *new_trailer_head);
 
-void trailer_info_get(struct trailer_info *info, const char *str);
+void trailer_info_get(struct trailer_info *info, const char *str,
+		      const struct process_trailer_options *opts);
 
 void trailer_info_release(struct trailer_info *info);
 
-- 
2.19.0.rc0.412.g7005db4e88

