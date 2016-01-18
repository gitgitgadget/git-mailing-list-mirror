From: Jeff King <peff@peff.net>
Subject: [PATCH 3/6] shortlog: replace hand-parsing of author with
 pretty-printer
Date: Mon, 18 Jan 2016 15:02:48 -0500
Message-ID: <20160118200248.GC15836@sigill.intra.peff.net>
References: <20160118200136.GA9514@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 21:02:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLG0t-00034d-ES
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 21:02:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbcARUCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 15:02:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:55645 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932223AbcARUCu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 15:02:50 -0500
Received: (qmail 32049 invoked by uid 102); 18 Jan 2016 20:02:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 15:02:50 -0500
Received: (qmail 13438 invoked by uid 107); 18 Jan 2016 20:03:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 15:03:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jan 2016 15:02:48 -0500
Content-Disposition: inline
In-Reply-To: <20160118200136.GA9514@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284315>

When gathering the author and oneline subject for each
commit, we hand-parse the commit headers to find the
"author" line, and then continue past to the blank line at
the end of the header.

We can replace this tricky hand-parsing by simply asking the
pretty-printer for the relevant items. This also decouples
the author and oneline parsing, opening up some new
optimizations in further commits.

One reason to avoid the pretty-printer is that it might be
less efficient than hand-parsing. However, I measured no
slowdown at all running "git shortlog -ns HEAD" on
linux.git.

As a bonus, we also fix a memory leak in the (uncommon) case
that the author field is blank.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/shortlog.c | 62 +++++++++++++++++++++++-------------------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 6c0a72e..1261ec4 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -113,45 +113,35 @@ static void read_from_stdin(struct shortlog *log)
 
 void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 {
-	const char *author = NULL, *buffer;
-	struct strbuf buf = STRBUF_INIT;
-	struct strbuf ufbuf = STRBUF_INIT;
-
-	pp_commit_easy(CMIT_FMT_RAW, commit, &buf);
-	buffer = buf.buf;
-	while (*buffer && *buffer != '\n') {
-		const char *eol = strchr(buffer, '\n');
-
-		if (eol == NULL)
-			eol = buffer + strlen(buffer);
-		else
-			eol++;
-
-		if (starts_with(buffer, "author "))
-			author = buffer + 7;
-		buffer = eol;
-	}
-	if (!author) {
+	struct strbuf author = STRBUF_INIT;
+	struct strbuf oneline = STRBUF_INIT;
+	struct pretty_print_context ctx = {0};
+
+	ctx.fmt = CMIT_FMT_USERFORMAT;
+	ctx.abbrev = log->abbrev;
+	ctx.subject = "";
+	ctx.after_subject = "";
+	ctx.date_mode.type = DATE_NORMAL;
+	ctx.output_encoding = get_log_output_encoding();
+
+	format_commit_message(commit, "%an <%ae>", &author, &ctx);
+	/* we can detect a total failure only by seeing " <>" in the output */
+	if (author.len <= 3) {
 		warning(_("Missing author: %s"),
 		    oid_to_hex(&commit->object.oid));
-		return;
-	}
-	if (log->user_format) {
-		struct pretty_print_context ctx = {0};
-		ctx.fmt = CMIT_FMT_USERFORMAT;
-		ctx.abbrev = log->abbrev;
-		ctx.subject = "";
-		ctx.after_subject = "";
-		ctx.date_mode.type = DATE_NORMAL;
-		ctx.output_encoding = get_log_output_encoding();
-		pretty_print_commit(&ctx, commit, &ufbuf);
-		buffer = ufbuf.buf;
-	} else if (*buffer) {
-		buffer++;
+		goto out;
 	}
-	insert_one_record(log, author, !*buffer ? "<none>" : buffer);
-	strbuf_release(&ufbuf);
-	strbuf_release(&buf);
+
+	if (log->user_format)
+		pretty_print_commit(&ctx, commit, &oneline);
+	else
+		format_commit_message(commit, "%s", &oneline, &ctx);
+
+	insert_one_record(log, author.buf, oneline.len ? oneline.buf : "<none>");
+
+out:
+	strbuf_release(&author);
+	strbuf_release(&oneline);
 }
 
 static void get_from_rev(struct rev_info *rev, struct shortlog *log)
-- 
2.7.0.248.g5eafd77
