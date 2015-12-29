From: Jeff King <peff@peff.net>
Subject: [PATCH 13/14] trailer: add interface for parsing commit trailers
Date: Tue, 29 Dec 2015 02:36:58 -0500
Message-ID: <20151229073658.GM8842@sigill.intra.peff.net>
References: <20151229071847.GA8726@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 08:37:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDoqA-0005Yy-OL
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 08:37:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbbL2HhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 02:37:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:46646 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753166AbbL2HhB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 02:37:01 -0500
Received: (qmail 18486 invoked by uid 102); 29 Dec 2015 07:37:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 01:37:01 -0600
Received: (qmail 20033 invoked by uid 107); 29 Dec 2015 07:37:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 02:37:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 02:36:59 -0500
Content-Disposition: inline
In-Reply-To: <20151229071847.GA8726@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283104>

The git-trailer command and its subfunctions work in only
one way: they take a set of trailer operations, and pass
through a file while performing those operations on it.

However, other parts of the system may want to simply parse
trailers, and we should be able to reuse the code here. This
patch provides a simple interface for parsing a commit
message with trailers, iterating over them, and retrieving
individual keys.

The trailer code is a little heavy on the use of strbufs, so
this is perhaps a bit slower than it would be if we were
able to parse the message in place (and this speed matters
when you are iterating over every commit in the repository).
However, there's nothing in this interface that paints us
too far into a corner; we can always optimize the internals
later.

Signed-off-by: Jeff King <peff@peff.net>
---
 trailer.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 trailer.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/trailer.c b/trailer.c
index 18bf209..36ba476 100644
--- a/trailer.c
+++ b/trailer.c
@@ -882,3 +882,46 @@ void process_trailers(const char *file, int trim_empty, struct string_list *trai
 
 	strbuf_list_free(lines);
 }
+
+void trailer_parse_init(struct trailer_parse_context *ctx, const struct strbuf *buf)
+{
+	int nr_lines = 0;
+
+	init_trailer_config();
+
+	ctx->lines = strbuf_split(buf, '\n');
+	while (ctx->lines[nr_lines])
+		nr_lines++;
+
+	ctx->end = find_trailer_end(ctx->lines, nr_lines);
+	ctx->start = find_trailer_start(ctx->lines, ctx->end);
+
+	strbuf_init(&ctx->token, 0);
+	strbuf_init(&ctx->value, 0);
+}
+
+void trailer_parse_clear(struct trailer_parse_context *ctx)
+{
+	strbuf_list_free(ctx->lines);
+	strbuf_release(&ctx->token);
+	strbuf_release(&ctx->value);
+}
+
+const char *trailer_parse_match(struct trailer_parse_context *ctx, int line, const char *match)
+{
+	size_t len;
+
+	if (ctx->lines[line]->buf[0] == comment_line_char)
+		return NULL;
+
+	strbuf_reset(&ctx->token);
+	strbuf_reset(&ctx->value);
+	if (parse_trailer(&ctx->token, &ctx->value, ctx->lines[line]->buf))
+		return NULL;
+
+	len = token_len_without_separator(ctx->token.buf, ctx->token.len);
+	if (strncasecmp(ctx->token.buf, match, len) || match[len])
+		return NULL;
+
+	return ctx->value.buf;
+}
diff --git a/trailer.h b/trailer.h
index 8eb25d5..1f985f6 100644
--- a/trailer.h
+++ b/trailer.h
@@ -3,4 +3,35 @@
 
 void process_trailers(const char *file, int trim_empty, struct string_list *trailers);
 
+struct trailer_parse_context {
+	struct strbuf **lines;
+	int start;
+	int end;
+
+	/* These fields are private to the parser. */
+	struct strbuf token;
+	struct strbuf value;
+};
+
+/*
+ * Parse the commit message found in "buf", looking for trailers. Any data in
+ * ctx is overwritten, and should later be freed with trailer_parse_clear().
+ *
+ * The caller can iterate over all trailers using the "start" and "end" indices
+ * into "lines".
+ */
+void trailer_parse_init(struct trailer_parse_context *ctx, const struct strbuf *buf);
+
+/*
+ * If the line contains a trailer with key "trailer", returns a pointer into
+ * "line" for the value. Otherwise, returns NULL.
+ */
+const char *trailer_parse_match(struct trailer_parse_context *ctx, int line,
+				const char *trailer);
+
+/*
+ * Free resources allocated by trailer_parse_init().
+ */
+void trailer_parse_clear(struct trailer_parse_context *ctx);
+
 #endif /* TRAILER_H */
-- 
2.7.0.rc3.367.g09631da
