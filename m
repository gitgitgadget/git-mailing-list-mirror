From: Jeff King <peff@peff.net>
Subject: [PATCH 06/14] shortlog: replace hand-parsing of author with
 pretty-printer
Date: Tue, 29 Dec 2015 02:29:53 -0500
Message-ID: <20151229072953.GF8842@sigill.intra.peff.net>
References: <20151229071847.GA8726@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 08:30:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDojI-0007Ib-M3
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 08:30:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881AbbL2H35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 02:29:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:46625 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751097AbbL2H34 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 02:29:56 -0500
Received: (qmail 18120 invoked by uid 102); 29 Dec 2015 07:29:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 01:29:56 -0600
Received: (qmail 19898 invoked by uid 107); 29 Dec 2015 07:30:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 02:30:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 02:29:53 -0500
Content-Disposition: inline
In-Reply-To: <20151229071847.GA8726@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283097>

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

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/shortlog.c | 57 +++++++++++++++++++++---------------------------------
 1 file changed, 22 insertions(+), 35 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 668cdb4..10c92fa 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -112,45 +112,32 @@ static void read_from_stdin(struct shortlog *log)
 
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
+	if (author.len <= 3) {
 		warning(_("Missing author: %s"),
 		    oid_to_hex(&commit->object.oid));
 		return;
 	}
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
-	}
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
+	strbuf_release(&author);
+	strbuf_release(&oneline);
 }
 
 static void get_from_rev(struct rev_info *rev, struct shortlog *log)
-- 
2.7.0.rc3.367.g09631da
