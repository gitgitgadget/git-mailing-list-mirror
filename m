From: Jeff King <peff@peff.net>
Subject: [PATCH 08/14] shortlog: optimize out useless "<none>" normalization
Date: Tue, 29 Dec 2015 02:31:08 -0500
Message-ID: <20151229073108.GH8842@sigill.intra.peff.net>
References: <20151229071847.GA8726@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 08:31:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDokU-0008Pm-FS
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 08:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150AbbL2HbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 02:31:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:46631 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752299AbbL2HbK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 02:31:10 -0500
Received: (qmail 18213 invoked by uid 102); 29 Dec 2015 07:31:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 01:31:10 -0600
Received: (qmail 19931 invoked by uid 107); 29 Dec 2015 07:31:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 02:31:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 02:31:08 -0500
Content-Disposition: inline
In-Reply-To: <20151229071847.GA8726@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283099>

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
index af24d84..400e03b 100644
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
2.7.0.rc3.367.g09631da
