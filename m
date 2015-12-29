From: Jeff King <peff@peff.net>
Subject: [PATCH 10/14] shortlog: change "author" variables to "ident"
Date: Tue, 29 Dec 2015 02:32:41 -0500
Message-ID: <20151229073241.GJ8842@sigill.intra.peff.net>
References: <20151229071847.GA8726@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 08:32:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDolz-0001PF-OV
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 08:32:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217AbbL2Hcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 02:32:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:46637 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753166AbbL2Hcn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 02:32:43 -0500
Received: (qmail 18259 invoked by uid 102); 29 Dec 2015 07:32:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 01:32:44 -0600
Received: (qmail 19966 invoked by uid 107); 29 Dec 2015 07:32:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 02:32:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 02:32:41 -0500
Content-Disposition: inline
In-Reply-To: <20151229071847.GA8726@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283101>

This is in preparation for shortlog counting more things
than just authors. Breaking it out into a separate patch
keeps the noise down when the real changes come.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/shortlog.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 7ec6b76..d7eb0cb 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -47,7 +47,7 @@ static int compare_by_list(const void *a1, const void *a2)
 }
 
 static void insert_one_record(struct shortlog *log,
-			      const char *author,
+			      const char *ident_string,
 			      const char *oneline)
 {
 	struct string_list_item *item;
@@ -56,7 +56,7 @@ static void insert_one_record(struct shortlog *log,
 	struct strbuf namemailbuf = STRBUF_INIT;
 	struct ident_split ident;
 
-	if (split_ident_line(&ident, author, strlen(author)))
+	if (split_ident_line(&ident, ident_string, strlen(ident_string)))
 		return;
 
 	namebuf = ident.name_begin;
@@ -115,12 +115,12 @@ static void insert_one_record(struct shortlog *log,
 
 static void read_from_stdin(struct shortlog *log)
 {
-	struct strbuf author = STRBUF_INIT;
+	struct strbuf ident = STRBUF_INIT;
 	struct strbuf oneline = STRBUF_INIT;
 
-	while (strbuf_getline(&author, stdin, '\n') != EOF) {
+	while (strbuf_getline(&ident, stdin, '\n') != EOF) {
 		const char *v;
-		if (!skip_prefix_icase(author.buf, "Author: ", &v))
+		if (!skip_prefix_icase(ident.buf, "Author: ", &v))
 			continue;
 		while (strbuf_getline(&oneline, stdin, '\n') != EOF &&
 		       oneline.len)
@@ -130,13 +130,13 @@ static void read_from_stdin(struct shortlog *log)
 			; /* discard blanks */
 		insert_one_record(log, v, oneline.buf);
 	}
-	strbuf_release(&author);
+	strbuf_release(&ident);
 	strbuf_release(&oneline);
 }
 
 void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 {
-	struct strbuf author = STRBUF_INIT;
+	struct strbuf ident = STRBUF_INIT;
 	struct strbuf oneline = STRBUF_INIT;
 	struct pretty_print_context ctx = {0};
 
@@ -147,8 +147,8 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	ctx.date_mode.type = DATE_NORMAL;
 	ctx.output_encoding = get_log_output_encoding();
 
-	format_commit_message(commit, "%an <%ae>", &author, &ctx);
-	if (author.len <= 3) {
+	format_commit_message(commit, "%an <%ae>", &ident, &ctx);
+	if (ident.len <= 3) {
 		warning(_("Missing author: %s"),
 		    oid_to_hex(&commit->object.oid));
 		return;
@@ -161,8 +161,8 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 			format_commit_message(commit, "%s", &oneline, &ctx);
 	}
 
-	insert_one_record(log, author.buf, oneline.len ? oneline.buf : "<none>");
-	strbuf_release(&author);
+	insert_one_record(log, ident.buf, oneline.len ? oneline.buf : "<none>");
+	strbuf_release(&ident);
 	strbuf_release(&oneline);
 }
 
-- 
2.7.0.rc3.367.g09631da
