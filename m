From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] pretty.c: give format_person_part the whole placeholder
Date: Sat, 5 Mar 2011 14:51:56 -0500
Message-ID: <20110305195156.GA32095@sigill.intra.peff.net>
References: <20110305195020.GA3089@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dietmar Winkler <dietmarw@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 05 20:52:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvxWF-0005Dk-U5
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 20:52:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930Ab1CETv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2011 14:51:59 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:60285 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753519Ab1CETv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2011 14:51:58 -0500
Received: (qmail 14190 invoked by uid 111); 5 Mar 2011 19:51:58 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 05 Mar 2011 19:51:58 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Mar 2011 14:51:56 -0500
Content-Disposition: inline
In-Reply-To: <20110305195020.GA3089@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168508>

Until now it only got to see the next character. Giving it
the whole string will make it possible to add longer
placeholders in a future patch.

Signed-off-by: Jeff King <peff@peff.net>
---
I split this out because the patch ends up so noisy.

 pretty.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/pretty.c b/pretty.c
index 8549934..00bcf83 100644
--- a/pretty.c
+++ b/pretty.c
@@ -440,7 +440,7 @@ static int mailmap_name(char *email, int email_len, char *name, int name_len)
 	return mail_map->nr && map_user(mail_map, email, email_len, name, name_len);
 }
 
-static size_t format_person_part(struct strbuf *sb, char part,
+static size_t format_person_part(struct strbuf *sb, const char *part,
 				 const char *msg, int len, enum date_mode dmode)
 {
 	/* currently all placeholders have same length */
@@ -477,7 +477,7 @@ static size_t format_person_part(struct strbuf *sb, char part,
 		goto skip;
 	end = mail_end-msg;
 
-	if (part == 'N' || part == 'E') { /* mailmap lookup */
+	if (*part == 'N' || *part == 'E') { /* mailmap lookup */
 		strlcpy(person_name, name_start, name_end-name_start+1);
 		strlcpy(person_mail, mail_start, mail_end-mail_start+1);
 		mailmap_name(person_mail, sizeof(person_mail), person_name, sizeof(person_name));
@@ -486,11 +486,11 @@ static size_t format_person_part(struct strbuf *sb, char part,
 		mail_start = person_mail;
 		mail_end = mail_start +  strlen(person_mail);
 	}
-	if (part == 'n' || part == 'N') {	/* name */
+	if (*part == 'n' || *part == 'N') {	/* name */
 		strbuf_add(sb, name_start, name_end-name_start);
 		return placeholder_len;
 	}
-	if (part == 'e' || part == 'E') {	/* email */
+	if (*part == 'e' || *part == 'E') {	/* email */
 		strbuf_add(sb, mail_start, mail_end-mail_start);
 		return placeholder_len;
 	}
@@ -504,7 +504,7 @@ static size_t format_person_part(struct strbuf *sb, char part,
 	if (msg + start == ep)
 		goto skip;
 
-	if (part == 't') {	/* date, UNIX timestamp */
+	if (*part == 't') {	/* date, UNIX timestamp */
 		strbuf_add(sb, msg + start, ep - (msg + start));
 		return placeholder_len;
 	}
@@ -518,7 +518,7 @@ static size_t format_person_part(struct strbuf *sb, char part,
 			tz = -tz;
 	}
 
-	switch (part) {
+	switch (*part) {
 	case 'd':	/* date */
 		strbuf_addstr(sb, show_date(date, tz, dmode));
 		return placeholder_len;
@@ -538,8 +538,8 @@ skip:
 	 * bogus commit, 'sb' cannot be updated, but we still need to
 	 * compute a valid return value.
 	 */
-	if (part == 'n' || part == 'e' || part == 't' || part == 'd'
-	    || part == 'D' || part == 'r' || part == 'i')
+	if (*part == 'n' || *part == 'e' || *part == 't' || *part == 'd'
+	    || *part == 'D' || *part == 'r' || *part == 'i')
 		return placeholder_len;
 
 	return 0; /* unknown placeholder */
@@ -899,11 +899,11 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 
 	switch (placeholder[0]) {
 	case 'a':	/* author ... */
-		return format_person_part(sb, placeholder[1],
+		return format_person_part(sb, placeholder + 1,
 				   msg + c->author.off, c->author.len,
 				   c->pretty_ctx->date_mode);
 	case 'c':	/* committer ... */
-		return format_person_part(sb, placeholder[1],
+		return format_person_part(sb, placeholder + 1,
 				   msg + c->committer.off, c->committer.len,
 				   c->pretty_ctx->date_mode);
 	case 'e':	/* encoding */
-- 
1.7.4.rc1.24.g38985d
