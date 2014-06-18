From: Jeff King <peff@peff.net>
Subject: [PATCH 7/7] determine_author_info: stop leaking name/email
Date: Wed, 18 Jun 2014 16:36:09 -0400
Message-ID: <20140618203609.GG23896@sigill.intra.peff.net>
References: <20140618201944.GA23238@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 22:36:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxMad-0006Yr-N9
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 22:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240AbaFRUgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 16:36:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:47018 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754993AbaFRUgL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 16:36:11 -0400
Received: (qmail 1102 invoked by uid 102); 18 Jun 2014 20:36:11 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 15:36:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 16:36:09 -0400
Content-Disposition: inline
In-Reply-To: <20140618201944.GA23238@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252064>

When we get the author name and email either from an
existing commit or from the "--author" option, we create a
copy of the strings. We cannot just free() these copies,
since the same pointers may also be pointing to getenv()
storage which we do not own.

Instead, let's treat these the same way as we do the date
buffer: keep a strbuf to be released, and point the bare
pointers at the strbuf.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/commit.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 62abee0..72beb7f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -546,16 +546,20 @@ static void strbuf_add_pair(struct strbuf *buf, const struct pointer_pair *p)
 	strbuf_add(buf, p->begin, p->end - p->begin);
 }
 
-static char *xmemdupz_pair(const struct pointer_pair *p)
+static char *set_pair(struct strbuf *buf, struct pointer_pair *p)
 {
-	return xmemdupz(p->begin, p->end - p->begin);
+	strbuf_reset(buf);
+	strbuf_add_pair(buf, p);
+	return buf->buf;
 }
 
 static void determine_author_info(struct strbuf *author_ident)
 {
 	char *name, *email, *date;
 	struct ident_split author;
-	struct strbuf date_buf = STRBUF_INIT;
+	struct strbuf name_buf = STRBUF_INIT,
+		      mail_buf = STRBUF_INIT,
+		      date_buf = STRBUF_INIT;
 
 	name = getenv("GIT_AUTHOR_NAME");
 	email = getenv("GIT_AUTHOR_EMAIL");
@@ -572,8 +576,8 @@ static void determine_author_info(struct strbuf *author_ident)
 		if (split_ident_line(&ident, a, len) < 0)
 			die(_("commit '%s' has malformed author line"), author_message);
 
-		name = xmemdupz_pair(&ident.name);
-		email = xmemdupz_pair(&ident.mail);
+		name = set_pair(&name_buf, &ident.name);
+		email = set_pair(&mail_buf, &ident.mail);
 		if (ident.date.begin) {
 			strbuf_reset(&date_buf);
 			strbuf_addch(&date_buf, '@');
@@ -589,8 +593,8 @@ static void determine_author_info(struct strbuf *author_ident)
 
 		if (split_ident_line(&ident, force_author, strlen(force_author)) < 0)
 			die(_("malformed --author parameter"));
-		name = xmemdupz_pair(&ident.name);
-		email = xmemdupz_pair(&ident.mail);
+		name = set_pair(&name_buf, &ident.name);
+		email = set_pair(&mail_buf, &ident.mail);
 	}
 
 	if (force_date) {
@@ -608,6 +612,8 @@ static void determine_author_info(struct strbuf *author_ident)
 		export_one("GIT_AUTHOR_DATE", author.date.begin, author.tz.end, '@');
 	}
 
+	strbuf_release(&name_buf);
+	strbuf_release(&mail_buf);
 	strbuf_release(&date_buf);
 }
 
-- 
2.0.0.566.gfe3e6b2
