From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/3] pretty: remove intermediate strbufs from pp_user_info()
Date: Thu, 25 Apr 2013 21:43:56 +0200
Message-ID: <5179877C.8000300@lsrfire.ath.cx>
References: <517986A9.4060506@lsrfire.ath.cx> <51798705.7030108@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 25 21:44:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVS5O-0000iS-44
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 21:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758992Ab3DYToA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 15:44:00 -0400
Received: from india601.server4you.de ([85.25.151.105]:49055 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757788Ab3DYToA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 15:44:00 -0400
Received: from [192.168.2.105] (p4FFDACA4.dip0.t-ipconnect.de [79.253.172.164])
	by india601.server4you.de (Postfix) with ESMTPSA id 1F5DDDC;
	Thu, 25 Apr 2013 21:43:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <51798705.7030108@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222425>

Use namebuf/namelen and mailbuf/maillen directly instead of copying
their contents into strbufs first.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 pretty.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/pretty.c b/pretty.c
index 6861997..9e43154 100644
--- a/pretty.c
+++ b/pretty.c
@@ -410,8 +410,6 @@ void pp_user_info(const struct pretty_print_context *pp,
 		  const char *what, struct strbuf *sb,
 		  const char *line, const char *encoding)
 {
-	struct strbuf name;
-	struct strbuf mail;
 	struct ident_split ident;
 	char *line_end;
 	const char *mailbuf, *namebuf;
@@ -433,42 +431,33 @@ void pp_user_info(const struct pretty_print_context *pp,
 	if (pp->mailmap)
 		map_user(pp->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
 
-	strbuf_init(&mail, 0);
-	strbuf_init(&name, 0);
-
-	strbuf_add(&mail, mailbuf, maillen);
-	strbuf_add(&name, namebuf, namelen);
-
 	if (pp->fmt == CMIT_FMT_EMAIL) {
 		strbuf_addstr(sb, "From: ");
-		if (needs_rfc2047_encoding(name.buf, name.len, RFC2047_ADDRESS)) {
-			add_rfc2047(sb, name.buf, name.len,
+		if (needs_rfc2047_encoding(namebuf, namelen, RFC2047_ADDRESS)) {
+			add_rfc2047(sb, namebuf, namelen,
 				    encoding, RFC2047_ADDRESS);
 			max_length = 76; /* per rfc2047 */
-		} else if (needs_rfc822_quoting(name.buf, name.len)) {
+		} else if (needs_rfc822_quoting(namebuf, namelen)) {
 			struct strbuf quoted = STRBUF_INIT;
-			add_rfc822_quoted(&quoted, name.buf, name.len);
+			add_rfc822_quoted(&quoted, namebuf, namelen);
 			strbuf_add_wrapped_bytes(sb, quoted.buf, quoted.len,
 							-6, 1, max_length);
 			strbuf_release(&quoted);
 		} else {
-			strbuf_add_wrapped_bytes(sb, name.buf, name.len,
+			strbuf_add_wrapped_bytes(sb, namebuf, namelen,
 						 -6, 1, max_length);
 		}
 
 		if (max_length <
 		    last_line_length(sb) + strlen(" <") + maillen + strlen(">"))
 			strbuf_addch(sb, '\n');
-		strbuf_addf(sb, " <%s>\n", mail.buf);
+		strbuf_addf(sb, " <%.*s>\n", (int)maillen, mailbuf);
 	} else {
-		strbuf_addf(sb, "%s: %.*s%s <%s>\n", what,
-			      (pp->fmt == CMIT_FMT_FULLER) ? 4 : 0,
-			      "    ", name.buf, mail.buf);
+		strbuf_addf(sb, "%s: %.*s%.*s <%.*s>\n", what,
+			    (pp->fmt == CMIT_FMT_FULLER) ? 4 : 0, "    ",
+			    (int)namelen, namebuf, (int)maillen, mailbuf);
 	}
 
-	strbuf_release(&mail);
-	strbuf_release(&name);
-
 	switch (pp->fmt) {
 	case CMIT_FMT_MEDIUM:
 		strbuf_addf(sb, "Date:   %s\n",
-- 
1.8.2.1
