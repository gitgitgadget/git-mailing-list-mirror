Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20214C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 07:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF1BE221EB
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 07:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgIYHBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 03:01:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:40412 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbgIYHBw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 03:01:52 -0400
Received: (qmail 13144 invoked by uid 109); 25 Sep 2020 07:01:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Sep 2020 07:01:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15927 invoked by uid 111); 25 Sep 2020 07:01:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Sep 2020 03:01:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 25 Sep 2020 03:01:50 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/8] shortlog: change "author" variables to "ident"
Message-ID: <20200925070150.GA62741@coredump.intra.peff.net>
References: <20200925070120.GA3669667@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200925070120.GA3669667@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already match "committer", and we're about to start
matching more things. Let's use a more neutral variable to
avoid confusion.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/shortlog.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index c856c58bb5..edcf2e0d54 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -49,12 +49,12 @@ static int compare_by_list(const void *a1, const void *a2)
 }
 
 static void insert_one_record(struct shortlog *log,
-			      const char *author,
+			      const char *ident,
 			      const char *oneline)
 {
 	struct string_list_item *item;
 
-	item = string_list_insert(&log->list, author);
+	item = string_list_insert(&log->list, ident);
 
 	if (log->summary)
 		item->util = (void *)(UTIL_TO_INT(item) + 1);
@@ -97,8 +97,8 @@ static void insert_one_record(struct shortlog *log,
 	}
 }
 
-static int parse_stdin_author(struct shortlog *log,
-			       struct strbuf *out, const char *in)
+static int parse_stdin_ident(struct shortlog *log,
+			     struct strbuf *out, const char *in)
 {
 	const char *mailbuf, *namebuf;
 	size_t namelen, maillen;
@@ -122,18 +122,18 @@ static int parse_stdin_author(struct shortlog *log,
 
 static void read_from_stdin(struct shortlog *log)
 {
-	struct strbuf author = STRBUF_INIT;
-	struct strbuf mapped_author = STRBUF_INIT;
+	struct strbuf ident = STRBUF_INIT;
+	struct strbuf mapped_ident = STRBUF_INIT;
 	struct strbuf oneline = STRBUF_INIT;
 	static const char *author_match[2] = { "Author: ", "author " };
 	static const char *committer_match[2] = { "Commit: ", "committer " };
 	const char **match;
 
 	match = log->committer ? committer_match : author_match;
-	while (strbuf_getline_lf(&author, stdin) != EOF) {
+	while (strbuf_getline_lf(&ident, stdin) != EOF) {
 		const char *v;
-		if (!skip_prefix(author.buf, match[0], &v) &&
-		    !skip_prefix(author.buf, match[1], &v))
+		if (!skip_prefix(ident.buf, match[0], &v) &&
+		    !skip_prefix(ident.buf, match[1], &v))
 			continue;
 		while (strbuf_getline_lf(&oneline, stdin) != EOF &&
 		       oneline.len)
@@ -142,20 +142,20 @@ static void read_from_stdin(struct shortlog *log)
 		       !oneline.len)
 			; /* discard blanks */
 
-		strbuf_reset(&mapped_author);
-		if (parse_stdin_author(log, &mapped_author, v) < 0)
+		strbuf_reset(&mapped_ident);
+		if (parse_stdin_ident(log, &mapped_ident, v) < 0)
 			continue;
 
-		insert_one_record(log, mapped_author.buf, oneline.buf);
+		insert_one_record(log, mapped_ident.buf, oneline.buf);
 	}
-	strbuf_release(&author);
-	strbuf_release(&mapped_author);
+	strbuf_release(&ident);
+	strbuf_release(&mapped_ident);
 	strbuf_release(&oneline);
 }
 
 void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 {
-	struct strbuf author = STRBUF_INIT;
+	struct strbuf ident = STRBUF_INIT;
 	struct strbuf oneline = STRBUF_INIT;
 	struct pretty_print_context ctx = {0};
 	const char *fmt;
@@ -170,17 +170,17 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 		(log->email ? "%cN <%cE>" : "%cN") :
 		(log->email ? "%aN <%aE>" : "%aN");
 
-	format_commit_message(commit, fmt, &author, &ctx);
+	format_commit_message(commit, fmt, &ident, &ctx);
 	if (!log->summary) {
 		if (log->user_format)
 			pretty_print_commit(&ctx, commit, &oneline);
 		else
 			format_commit_message(commit, "%s", &oneline, &ctx);
 	}
 
-	insert_one_record(log, author.buf, oneline.len ? oneline.buf : "<none>");
+	insert_one_record(log, ident.buf, oneline.len ? oneline.buf : "<none>");
 
-	strbuf_release(&author);
+	strbuf_release(&ident);
 	strbuf_release(&oneline);
 }
 
-- 
2.28.0.1085.g44a0350633

