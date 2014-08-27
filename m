From: Jeff King <peff@peff.net>
Subject: [PATCH v2 6/6] determine_author_info: copy getenv output
Date: Wed, 27 Aug 2014 03:57:56 -0400
Message-ID: <20140827075756.GF26384@peff.net>
References: <20140827075503.GA19521@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 27 09:58:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMY7Q-0003Bo-IC
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 09:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbaH0H56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 03:57:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:59902 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932439AbaH0H56 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 03:57:58 -0400
Received: (qmail 14760 invoked by uid 102); 27 Aug 2014 07:57:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Aug 2014 02:57:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2014 03:57:56 -0400
Content-Disposition: inline
In-Reply-To: <20140827075503.GA19521@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255988>

When figuring out the author name for a commit, we may end
up either pointing to const storage from getenv("GIT_AUTHOR_*"),
or to newly allocated storage based on an existing commit or
the --author option.

Using const pointers to getenv's return has two problems:

  1. It is not guaranteed that the return value from getenv
     remains valid across multiple calls.

  2. We do not know whether to free the values at the end,
     so we just leak them.

We can solve both by duplicating the string returned by
getenv().

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/commit.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 57b046b..7f9f071 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -535,15 +535,26 @@ static int parse_force_date(const char *in, struct strbuf *out)
 	return 0;
 }
 
+static void set_ident_var(char **buf, char *val)
+{
+	free(*buf);
+	*buf = val;
+}
+
+static char *envdup(const char *var)
+{
+	const char *val = getenv(var);
+	return val ? xstrdup(val) : NULL;
+}
+
 static void determine_author_info(struct strbuf *author_ident)
 {
 	char *name, *email, *date;
 	struct ident_split author;
-	struct strbuf date_buf = STRBUF_INIT;
 
-	name = getenv("GIT_AUTHOR_NAME");
-	email = getenv("GIT_AUTHOR_EMAIL");
-	date = getenv("GIT_AUTHOR_DATE");
+	name = envdup("GIT_AUTHOR_NAME");
+	email = envdup("GIT_AUTHOR_EMAIL");
+	date = envdup("GIT_AUTHOR_DATE");
 
 	if (author_message) {
 		struct ident_split ident;
@@ -556,15 +567,16 @@ static void determine_author_info(struct strbuf *author_ident)
 		if (split_ident_line(&ident, a, len) < 0)
 			die(_("commit '%s' has malformed author line"), author_message);
 
-		name = xmemdupz(ident.name_begin, ident.name_end - ident.name_begin);
-		email = xmemdupz(ident.mail_begin, ident.mail_end - ident.mail_begin);
+		set_ident_var(&name, xmemdupz(ident.name_begin, ident.name_end - ident.name_begin));
+		set_ident_var(&email, xmemdupz(ident.mail_begin, ident.mail_end - ident.mail_begin));
+
 		if (ident.date_begin) {
-			strbuf_reset(&date_buf);
+			struct strbuf date_buf = STRBUF_INIT;
 			strbuf_addch(&date_buf, '@');
 			strbuf_add(&date_buf, ident.date_begin, ident.date_end - ident.date_begin);
 			strbuf_addch(&date_buf, ' ');
 			strbuf_add(&date_buf, ident.tz_begin, ident.tz_end - ident.tz_begin);
-			date = date_buf.buf;
+			set_ident_var(&date, strbuf_detach(&date_buf, NULL));
 		}
 	}
 
@@ -573,15 +585,15 @@ static void determine_author_info(struct strbuf *author_ident)
 
 		if (split_ident_line(&ident, force_author, strlen(force_author)) < 0)
 			die(_("malformed --author parameter"));
-		name = xmemdupz(ident.name_begin, ident.name_end - ident.name_begin);
-		email = xmemdupz(ident.mail_begin, ident.mail_end - ident.mail_begin);
+		set_ident_var(&name, xmemdupz(ident.name_begin, ident.name_end - ident.name_begin));
+		set_ident_var(&email, xmemdupz(ident.mail_begin, ident.mail_end - ident.mail_begin));
 	}
 
 	if (force_date) {
-		strbuf_reset(&date_buf);
+		struct strbuf date_buf = STRBUF_INIT;
 		if (parse_force_date(force_date, &date_buf))
 			die(_("invalid date format: %s"), force_date);
-		date = date_buf.buf;
+		set_ident_var(&date, strbuf_detach(&date_buf, NULL));
 	}
 
 	strbuf_addstr(author_ident, fmt_ident(name, email, date, IDENT_STRICT));
@@ -592,7 +604,9 @@ static void determine_author_info(struct strbuf *author_ident)
 		export_one("GIT_AUTHOR_DATE", author.date_begin, author.tz_end, '@');
 	}
 
-	strbuf_release(&date_buf);
+	free(name);
+	free(email);
+	free(date);
 }
 
 static void split_ident_or_die(struct ident_split *id, const struct strbuf *buf)
-- 
2.1.0.346.ga0367b9
