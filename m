Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A52471F667
	for <e@80x24.org>; Tue, 15 Aug 2017 10:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753498AbdHOKX6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 06:23:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:39304 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753389AbdHOKX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 06:23:58 -0400
Received: (qmail 31538 invoked by uid 109); 15 Aug 2017 10:23:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Aug 2017 10:23:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9847 invoked by uid 111); 15 Aug 2017 10:24:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Aug 2017 06:24:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Aug 2017 06:23:56 -0400
Date:   Tue, 15 Aug 2017 06:23:56 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 6/8] pretty: move trailer formatting to trailer.c
Message-ID: <20170815102355.zf4lvkntbwxacgca@sigill.intra.peff.net>
References: <20170815102254.knccmhgralfijwli@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170815102254.knccmhgralfijwli@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The next commit will add many features to the %(trailer)
placeholder in pretty.c. We'll need to access some internal
functions of trailer.c for that, so our options are either:

  1. expose those functions publicly

or

  2. make an entry point into trailer.c to do the formatting

Doing (2) ends up exposing less surface area, though do note
that caveats in the docstring of the new function.

Signed-off-by: Jeff King <peff@peff.net>
---
 pretty.c  | 13 ++-----------
 trailer.c | 18 ++++++++++++++++++
 trailer.h | 14 ++++++++++++++
 3 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/pretty.c b/pretty.c
index 39cad5112b..99b309bb15 100644
--- a/pretty.c
+++ b/pretty.c
@@ -871,16 +871,6 @@ const char *format_subject(struct strbuf *sb, const char *msg,
 	return msg;
 }
 
-static void format_trailers(struct strbuf *sb, const char *msg)
-{
-	struct trailer_info info;
-
-	trailer_info_get(&info, msg);
-	strbuf_add(sb, info.trailer_start,
-		   info.trailer_end - info.trailer_start);
-	trailer_info_release(&info);
-}
-
 static void parse_commit_message(struct format_commit_context *c)
 {
 	const char *msg = c->message + c->message_off;
@@ -1293,7 +1283,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	}
 
 	if (starts_with(placeholder, "(trailers)")) {
-		format_trailers(sb, msg + c->subject_off);
+		struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
+		format_trailers_from_commit(sb, msg + c->subject_off, &opts);
 		return strlen("(trailers)");
 	}
 
diff --git a/trailer.c b/trailer.c
index ed4fedc087..2d2b997ccc 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1091,3 +1091,21 @@ void trailer_info_release(struct trailer_info *info)
 		free(info->trailers[i]);
 	free(info->trailers);
 }
+
+static void format_trailer_info(struct strbuf *out,
+				const struct trailer_info *info,
+				const struct process_trailer_options *opts)
+{
+	strbuf_add(out, info->trailer_start,
+		   info->trailer_end - info->trailer_start);
+}
+
+void format_trailers_from_commit(struct strbuf *out, const char *msg,
+				 const struct process_trailer_options *opts)
+{
+	struct trailer_info info;
+
+	trailer_info_get(&info, msg);
+	format_trailer_info(out, &info, opts);
+	trailer_info_release(&info);
+}
diff --git a/trailer.h b/trailer.h
index 194f85a102..a172811022 100644
--- a/trailer.h
+++ b/trailer.h
@@ -40,4 +40,18 @@ void trailer_info_get(struct trailer_info *info, const char *str);
 
 void trailer_info_release(struct trailer_info *info);
 
+/*
+ * Format the trailers from the commit msg "msg" into the strbuf "out".
+ * Note two caveats about "opts":
+ *
+ *   - this is primarily a helper for pretty.c, and not
+ *     all of the flags are supported.
+ *
+ *   - this differs from process_trailers slightly in that we always format
+ *     only the trailer block itself, even if the "only_trailers" option is not
+ *     set.
+ */
+void format_trailers_from_commit(struct strbuf *out, const char *msg,
+				 const struct process_trailer_options *opts);
+
 #endif /* TRAILER_H */
-- 
2.14.1.352.ge5efb0d3f3

