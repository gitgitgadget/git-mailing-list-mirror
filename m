From: Jeff King <peff@peff.net>
Subject: [PATCH 6/7] determine_author_info: reuse parsing functions
Date: Wed, 18 Jun 2014 16:35:39 -0400
Message-ID: <20140618203539.GF23896@sigill.intra.peff.net>
References: <20140618201944.GA23238@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 22:35:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxMa9-00060G-74
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 22:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754954AbaFRUfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 16:35:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:47016 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754767AbaFRUfl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 16:35:41 -0400
Received: (qmail 1039 invoked by uid 102); 18 Jun 2014 20:35:41 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 15:35:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 16:35:39 -0400
Content-Disposition: inline
In-Reply-To: <20140618201944.GA23238@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252063>

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
The large buffer comes from wrapping around the negative side of the
size_t space.  In theory you could wrap far enough to get a buffer that
we can actually allocate (probably only on a 32-bit system), and then
we followup by copying "len" random bytes into it. I doubt an attacker
could get that data out of the program, though, as we then run it
through fmt_ident, which should complain if it's full of garbage.

 builtin/commit.c | 61 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index bf770cf..62abee0 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -541,6 +541,16 @@ static int parse_force_date(const char *in, struct strbuf *out)
 	return 0;
 }
 
+static void strbuf_add_pair(struct strbuf *buf, const struct pointer_pair *p)
+{
+	strbuf_add(buf, p->begin, p->end - p->begin);
+}
+
+static char *xmemdupz_pair(const struct pointer_pair *p)
+{
+	return xmemdupz(p->begin, p->end - p->begin);
+}
+
 static void determine_author_info(struct strbuf *author_ident)
 {
 	char *name, *email, *date;
@@ -552,42 +562,35 @@ static void determine_author_info(struct strbuf *author_ident)
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
+		name = xmemdupz_pair(&ident.name);
+		email = xmemdupz_pair(&ident.mail);
+		if (ident.date.begin) {
+			strbuf_reset(&date_buf);
+			strbuf_addch(&date_buf, '@');
+			strbuf_add_pair(&date_buf, &ident.date);
+			strbuf_addch(&date_buf, ' ');
+			strbuf_add_pair(&date_buf, &ident.tz);
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
+		name = xmemdupz_pair(&ident.name);
+		email = xmemdupz_pair(&ident.mail);
 	}
 
 	if (force_date) {
-- 
2.0.0.566.gfe3e6b2
