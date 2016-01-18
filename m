From: Jeff King <peff@peff.net>
Subject: [PATCH 5/6] shortlog: optimize out useless "<none>" normalization
Date: Mon, 18 Jan 2016 15:02:56 -0500
Message-ID: <20160118200255.GE15836@sigill.intra.peff.net>
References: <20160118200136.GA9514@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 21:03:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLG11-0003BQ-Cq
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 21:03:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbcARUC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 15:02:59 -0500
Received: from cloud.peff.net ([50.56.180.127]:55654 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932223AbcARUC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 15:02:58 -0500
Received: (qmail 32113 invoked by uid 102); 18 Jan 2016 20:02:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 15:02:58 -0500
Received: (qmail 13474 invoked by uid 107); 18 Jan 2016 20:03:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 15:03:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jan 2016 15:02:56 -0500
Content-Disposition: inline
In-Reply-To: <20160118200136.GA9514@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284317>

If we are in --summary mode, we will always pass <none> to
insert_one_record, which will then do some normalization
(e.g., cutting out "[PATCH]"). There's no point in doing so
if we aren't going to use the result anyway.

This drops my best-of-five for "git shortlog -ns HEAD" on
linux.git from:

  real    0m5.257s
  user    0m5.104s
  sys     0m0.156s

to:

  real    0m5.194s
  user    0m5.028s
  sys     0m0.168s

That's only 1%, but arguably the result is clearer to read,
as we're able to group our variable declarations inside the
conditional block. It also opens up further optimization
possibilities for future patches.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/shortlog.c | 63 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 973b50d..a7708c3 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -31,13 +31,9 @@ static void insert_one_record(struct shortlog *log,
 			      const char *author,
 			      const char *oneline)
 {
-	const char *dot3 = log->common_repo_prefix;
-	char *buffer, *p;
 	struct string_list_item *item;
 	const char *mailbuf, *namebuf;
 	size_t namelen, maillen;
-	const char *eol;
-	struct strbuf subject = STRBUF_INIT;
 	struct strbuf namemailbuf = STRBUF_INIT;
 	struct ident_split ident;
 
@@ -59,34 +55,43 @@ static void insert_one_record(struct shortlog *log,
 	if (item->util == NULL)
 		item->util = xcalloc(1, sizeof(struct string_list));
 
-	/* Skip any leading whitespace, including any blank lines. */
-	while (*oneline && isspace(*oneline))
-		oneline++;
-	eol = strchr(oneline, '\n');
-	if (!eol)
-		eol = oneline + strlen(oneline);
-	if (starts_with(oneline, "[PATCH")) {
-		char *eob = strchr(oneline, ']');
-		if (eob && (!eol || eob < eol))
-			oneline = eob + 1;
-	}
-	while (*oneline && isspace(*oneline) && *oneline != '\n')
-		oneline++;
-	format_subject(&subject, oneline, " ");
-	buffer = strbuf_detach(&subject, NULL);
-
-	if (dot3) {
-		int dot3len = strlen(dot3);
-		if (dot3len > 5) {
-			while ((p = strstr(buffer, dot3)) != NULL) {
-				int taillen = strlen(p) - dot3len;
-				memcpy(p, "/.../", 5);
-				memmove(p + 5, p + dot3len, taillen + 1);
+	if (log->summary)
+		string_list_append(item->util, xstrdup(""));
+	else {
+		const char *dot3 = log->common_repo_prefix;
+		char *buffer, *p;
+		struct strbuf subject = STRBUF_INIT;
+		const char *eol;
+
+		/* Skip any leading whitespace, including any blank lines. */
+		while (*oneline && isspace(*oneline))
+			oneline++;
+		eol = strchr(oneline, '\n');
+		if (!eol)
+			eol = oneline + strlen(oneline);
+		if (starts_with(oneline, "[PATCH")) {
+			char *eob = strchr(oneline, ']');
+			if (eob && (!eol || eob < eol))
+				oneline = eob + 1;
+		}
+		while (*oneline && isspace(*oneline) && *oneline != '\n')
+			oneline++;
+		format_subject(&subject, oneline, " ");
+		buffer = strbuf_detach(&subject, NULL);
+
+		if (dot3) {
+			int dot3len = strlen(dot3);
+			if (dot3len > 5) {
+				while ((p = strstr(buffer, dot3)) != NULL) {
+					int taillen = strlen(p) - dot3len;
+					memcpy(p, "/.../", 5);
+					memmove(p + 5, p + dot3len, taillen + 1);
+				}
 			}
 		}
-	}
 
-	string_list_append(item->util, buffer);
+		string_list_append(item->util, buffer);
+	}
 }
 
 static void read_from_stdin(struct shortlog *log)
-- 
2.7.0.248.g5eafd77
