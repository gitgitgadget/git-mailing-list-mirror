Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A5A31F954
	for <e@80x24.org>; Thu, 23 Aug 2018 00:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbeHWELo (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 00:11:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:52498 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725721AbeHWELo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 00:11:44 -0400
Received: (qmail 11925 invoked by uid 109); 23 Aug 2018 00:44:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 Aug 2018 00:44:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6166 invoked by uid 111); 23 Aug 2018 00:44:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 22 Aug 2018 20:44:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Aug 2018 20:44:38 -0400
Date:   Wed, 22 Aug 2018 20:44:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Subject: [PATCH 1/9] trailer: use size_t for string offsets
Message-ID: <20180823004438.GA3126@sigill.intra.peff.net>
References: <20180823004300.GA1355@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180823004300.GA1355@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many of the string-parsing functions inside trailer.c return
integer offsets into the string (e.g., to point to the end
of the trailer block). Several of these use an "int" to
return or store the offsets. On a system where "size_t" is
much larger than "int" (e.g., most 64-bit ones), it's easy
to feed a gigantic commit message that results in a negative
offset. This can result in us reading memory before the
string (if the int is used as an index) or far after (if
it's implicitly cast to a size_t by passing to a strbuf
function).

Let's fix this by using size_t for all string offsets. Note
that several of the functions need ssize_t, since they use
"-1" as a sentinel value. The interactions here can be
pretty subtle. E.g., end_of_title in find_trailer_start()
does not itself need to be signed, but it is compared to the
result of last_line(), which is. That promotes the latter to
unsigned, and the ">=" does not behave as you might expect.

Signed-off-by: Jeff King <peff@peff.net>
---
Noticed while I was in the area. I did pretty easily reproduce a
segfault with this.

 trailer.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/trailer.c b/trailer.c
index 4e309460d1..88b35b8e89 100644
--- a/trailer.c
+++ b/trailer.c
@@ -585,7 +585,7 @@ static const char *token_from_item(struct arg_item *item, char *tok)
 	return item->conf.name;
 }
 
-static int token_matches_item(const char *tok, struct arg_item *item, int tok_len)
+static int token_matches_item(const char *tok, struct arg_item *item, size_t tok_len)
 {
 	if (!strncasecmp(tok, item->conf.name, tok_len))
 		return 1;
@@ -603,7 +603,7 @@ static int token_matches_item(const char *tok, struct arg_item *item, int tok_le
  * distinguished from the non-well-formed-line case (in which this function
  * returns -1) because some callers of this function need such a distinction.
  */
-static int find_separator(const char *line, const char *separators)
+static ssize_t find_separator(const char *line, const char *separators)
 {
 	int whitespace_found = 0;
 	const char *c;
@@ -630,10 +630,10 @@ static int find_separator(const char *line, const char *separators)
  */
 static void parse_trailer(struct strbuf *tok, struct strbuf *val,
 			 const struct conf_info **conf, const char *trailer,
-			 int separator_pos)
+			 ssize_t separator_pos)
 {
 	struct arg_item *item;
-	int tok_len;
+	size_t tok_len;
 	struct list_head *pos;
 
 	if (separator_pos != -1) {
@@ -721,7 +721,7 @@ static void process_command_line_args(struct list_head *arg_head,
 	list_for_each(pos, new_trailer_head) {
 		struct new_trailer_item *tr =
 			list_entry(pos, struct new_trailer_item, list);
-		int separator_pos = find_separator(tr->text, cl_separators);
+		ssize_t separator_pos = find_separator(tr->text, cl_separators);
 
 		if (separator_pos == 0) {
 			struct strbuf sb = STRBUF_INIT;
@@ -763,9 +763,9 @@ static const char *next_line(const char *str)
 /*
  * Return the position of the start of the last line. If len is 0, return -1.
  */
-static int last_line(const char *buf, size_t len)
+static ssize_t last_line(const char *buf, size_t len)
 {
-	int i;
+	ssize_t i;
 	if (len == 0)
 		return -1;
 	if (len == 1)
@@ -788,7 +788,7 @@ static int last_line(const char *buf, size_t len)
  * Return the position of the start of the patch or the length of str if there
  * is no patch in the message.
  */
-static int find_patch_start(const char *str)
+static size_t find_patch_start(const char *str)
 {
 	const char *s;
 
@@ -804,10 +804,11 @@ static int find_patch_start(const char *str)
  * Return the position of the first trailer line or len if there are no
  * trailers.
  */
-static int find_trailer_start(const char *buf, size_t len)
+static size_t find_trailer_start(const char *buf, size_t len)
 {
 	const char *s;
-	int end_of_title, l, only_spaces = 1;
+	ssize_t end_of_title, l;
+	int only_spaces = 1;
 	int recognized_prefix = 0, trailer_lines = 0, non_trailer_lines = 0;
 	/*
 	 * Number of possible continuation lines encountered. This will be
@@ -838,7 +839,7 @@ static int find_trailer_start(const char *buf, size_t len)
 	     l = last_line(buf, l)) {
 		const char *bol = buf + l;
 		const char **p;
-		int separator_pos;
+		ssize_t separator_pos;
 
 		if (bol[0] == comment_line_char) {
 			non_trailer_lines += possible_continuation_lines;
@@ -899,14 +900,14 @@ static int find_trailer_start(const char *buf, size_t len)
 }
 
 /* Return the position of the end of the trailers. */
-static int find_trailer_end(const char *buf, size_t len)
+static size_t find_trailer_end(const char *buf, size_t len)
 {
 	return len - ignore_non_trailer(buf, len);
 }
 
 static int ends_with_blank_line(const char *buf, size_t len)
 {
-	int ll = last_line(buf, len);
+	ssize_t ll = last_line(buf, len);
 	if (ll < 0)
 		return 0;
 	return is_blank_line(buf + ll);
@@ -939,10 +940,10 @@ static void unfold_value(struct strbuf *val)
 	strbuf_release(&out);
 }
 
-static int process_input_file(FILE *outfile,
-			      const char *str,
-			      struct list_head *head,
-			      const struct process_trailer_options *opts)
+static size_t process_input_file(FILE *outfile,
+				 const char *str,
+				 struct list_head *head,
+				 const struct process_trailer_options *opts)
 {
 	struct trailer_info info;
 	struct strbuf tok = STRBUF_INIT;
@@ -1032,7 +1033,7 @@ void process_trailers(const char *file,
 {
 	LIST_HEAD(head);
 	struct strbuf sb = STRBUF_INIT;
-	int trailer_end;
+	size_t trailer_end;
 	FILE *outfile = stdout;
 
 	ensure_configured();
@@ -1132,7 +1133,7 @@ static void format_trailer_info(struct strbuf *out,
 
 	for (i = 0; i < info->trailer_nr; i++) {
 		char *trailer = info->trailers[i];
-		int separator_pos = find_separator(trailer, separators);
+		ssize_t separator_pos = find_separator(trailer, separators);
 
 		if (separator_pos >= 1) {
 			struct strbuf tok = STRBUF_INIT;
-- 
2.19.0.rc0.412.g7005db4e88

