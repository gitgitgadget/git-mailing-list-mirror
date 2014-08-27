From: Jeff King <peff@peff.net>
Subject: [PATCH v2 5/6] determine_author_info: reuse parsing functions
Date: Wed, 27 Aug 2014 03:57:28 -0400
Message-ID: <20140827075728.GE26384@peff.net>
References: <20140827075503.GA19521@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 27 09:57:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMY6q-0002pK-9B
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 09:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754558AbaH0H5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 03:57:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:59898 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751945AbaH0H5a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 03:57:30 -0400
Received: (qmail 14694 invoked by uid 102); 27 Aug 2014 07:57:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Aug 2014 02:57:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2014 03:57:28 -0400
Content-Disposition: inline
In-Reply-To: <20140827075503.GA19521@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255987>

Rather than parsing the header manually to find the "author"
field, and then parsing its sub-parts, let's use
find_commit_header and split_ident_line. This is shorter and
easier to read, and should do a more careful parsing job.

For example, the current parser could find the end-of-email
right-bracket across a newline (for a malformed commit), and
calculate a bogus gigantic length for the date (by using
"eol - rb").

As a bonus, this also plugs a memory leak when we pull the
date field from an existing commit (we still leak the name
and email buffers, which will be fixed in a later commit).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/commit.c | 51 ++++++++++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 8da0a9f..57b046b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -546,42 +546,35 @@ static void determine_author_info(struct strbuf *author_ident)
 	date = getenv("GIT_AUTHOR_DATE");
 
 	if (author_message) {
-		const char *a, *lb, *rb, *eol;
-		size_t len;
+		struct ident_split ident;
+		unsigned long len;
+		const char *a;
 
-		a = strstr(author_message_buffer, "\nauthor ");
+		a = find_commit_header(author_message_buffer, "author", &len);
 		if (!a)
-			die(_("invalid commit: %s"), author_message);
-
-		lb = strchrnul(a + strlen("\nauthor "), '<');
-		rb = strchrnul(lb, '>');
-		eol = strchrnul(rb, '\n');
-		if (!*lb || !*rb || !*eol)
-			die(_("invalid commit: %s"), author_message);
-
-		if (lb == a + strlen("\nauthor "))
-			/* \nauthor <foo@example.com> */
-			name = xcalloc(1, 1);
-		else
-			name = xmemdupz(a + strlen("\nauthor "),
-					(lb - strlen(" ") -
-					 (a + strlen("\nauthor "))));
-		email = xmemdupz(lb + strlen("<"), rb - (lb + strlen("<")));
-		len = eol - (rb + strlen("> "));
-		date = xmalloc(len + 2);
-		*date = '@';
-		memcpy(date + 1, rb + strlen("> "), len);
-		date[len + 1] = '\0';
+			die(_("commit '%s' lacks author header"), author_message);
+		if (split_ident_line(&ident, a, len) < 0)
+			die(_("commit '%s' has malformed author line"), author_message);
+
+		name = xmemdupz(ident.name_begin, ident.name_end - ident.name_begin);
+		email = xmemdupz(ident.mail_begin, ident.mail_end - ident.mail_begin);
+		if (ident.date_begin) {
+			strbuf_reset(&date_buf);
+			strbuf_addch(&date_buf, '@');
+			strbuf_add(&date_buf, ident.date_begin, ident.date_end - ident.date_begin);
+			strbuf_addch(&date_buf, ' ');
+			strbuf_add(&date_buf, ident.tz_begin, ident.tz_end - ident.tz_begin);
+			date = date_buf.buf;
+		}
 	}
 
 	if (force_author) {
-		const char *lb = strstr(force_author, " <");
-		const char *rb = strchr(force_author, '>');
+		struct ident_split ident;
 
-		if (!lb || !rb)
+		if (split_ident_line(&ident, force_author, strlen(force_author)) < 0)
 			die(_("malformed --author parameter"));
-		name = xstrndup(force_author, lb - force_author);
-		email = xstrndup(lb + 2, rb - (lb + 2));
+		name = xmemdupz(ident.name_begin, ident.name_end - ident.name_begin);
+		email = xmemdupz(ident.mail_begin, ident.mail_end - ident.mail_begin);
 	}
 
 	if (force_date) {
-- 
2.1.0.346.ga0367b9
