From: Jeff King <peff@peff.net>
Subject: [PATCH 5/6] shortlog: optimize out useless "<none>" normalization
Date: Fri, 15 Jan 2016 12:10:07 -0500
Message-ID: <20160115171006.GE21102@sigill.intra.peff.net>
References: <20160115170627.GA20983@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 18:10:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK7tA-00005P-V3
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 18:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720AbcAORKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 12:10:10 -0500
Received: from cloud.peff.net ([50.56.180.127]:54478 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752359AbcAORKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 12:10:09 -0500
Received: (qmail 2213 invoked by uid 102); 15 Jan 2016 17:10:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 12:10:09 -0500
Received: (qmail 21428 invoked by uid 107); 15 Jan 2016 17:10:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 12:10:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jan 2016 12:10:07 -0500
Content-Disposition: inline
In-Reply-To: <20160115170627.GA20983@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284185>

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
index 3e1e0d6..c2bf9b2 100644
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
 
 /*
-- 
2.7.0.244.g0701a9d
