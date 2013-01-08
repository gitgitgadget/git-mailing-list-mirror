From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/10] pretty: use mailmap to display username and email
Date: Mon,  7 Jan 2013 16:10:17 -0800
Message-ID: <1357603821-8647-7-git-send-email-gitster@pobox.com>
References: <1357603821-8647-1-git-send-email-gitster@pobox.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 01:11:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsMmh-0006ZE-4U
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 01:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756169Ab3AHAKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 19:10:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50320 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756155Ab3AHAKi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 19:10:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A23EB7B8;
	Mon,  7 Jan 2013 19:10:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=0lwN
	Fcq0xuuHreSEWEQEw3JVFeg=; b=hJAViCbSb4rI3CQRKndCfSYCFBl4nuPlsymG
	Cm8vb5Ne1KaQmgh+jRTrqXcJc6v/mXMKHl6FLOiQOKh5sbjvsHLYv3JSyRjZpj7E
	PVLnMNsabaQ5tii8VFwpK0YQ7SAn5oiaeJoBj7pFlFAUXpTEBGUIn/zb7YEDiwkl
	jhbDmeE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	ydNhA4bxTqaxhIxI2luANQubGMXlnbzlTiACnOaCZZtsjus+8AOEe/PWEShyagKg
	00rUhIENsqHyH4BoAAqJHNaQ6gCj1ZGZlesfutsXHoNPLNgnFO7VidVWUab9goa5
	4mqD2tR0RtJFjt9HxHefKsqEek8T0R68EXeAH//eiTE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C725B7B7;
	Mon,  7 Jan 2013 19:10:37 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB8F2B7B3; Mon,  7 Jan 2013
 19:10:36 -0500 (EST)
X-Mailer: git-send-email 1.8.1.304.gf036638
In-Reply-To: <1357603821-8647-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D3D53CC4-5927-11E2-8F2E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212928>

From: Antoine Pelisse <apelisse@gmail.com>

Use the mailmap information to display the rewritten
username and email address in all log commands.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pretty.c | 58 +++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/pretty.c b/pretty.c
index dffcade..622275c 100644
--- a/pretty.c
+++ b/pretty.c
@@ -387,9 +387,13 @@ void pp_user_info(const struct pretty_print_context *pp,
 		  const char *what, struct strbuf *sb,
 		  const char *line, const char *encoding)
 {
+	struct strbuf name;
+	struct strbuf mail;
 	struct ident_split ident;
-	int linelen, namelen;
+	int linelen;
 	char *line_end, *date;
+	const char *mailbuf, *namebuf;
+	size_t namelen, maillen;
 	int max_length = 78; /* per rfc2822 */
 	unsigned long time;
 	int tz;
@@ -408,42 +412,54 @@ void pp_user_info(const struct pretty_print_context *pp,
 	if (split_ident_line(&ident, line, linelen))
 		return;
 
-	namelen = ident.mail_end - ident.name_begin + 1;
+
+	mailbuf = ident.mail_begin;
+	maillen = ident.mail_end - ident.mail_begin;
+	namebuf = ident.name_begin;
+	namelen = ident.name_end - ident.name_begin;
+
+	if (pp->mailmap)
+		map_user(pp->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
+
+	strbuf_init(&mail, 0);
+	strbuf_init(&name, 0);
+
+	strbuf_add(&mail, mailbuf, maillen);
+	strbuf_add(&name, namebuf, namelen);
+
+	namelen = name.len + mail.len + 3; /* ' ' + '<' + '>' */
 	time = strtoul(ident.date_begin, &date, 10);
 	tz = strtol(date, NULL, 10);
 
 	if (pp->fmt == CMIT_FMT_EMAIL) {
-		int display_name_length;
-
-		display_name_length = ident.name_end - ident.name_begin;
-
 		strbuf_addstr(sb, "From: ");
-		if (needs_rfc2047_encoding(line, display_name_length, RFC2047_ADDRESS)) {
-			add_rfc2047(sb, line, display_name_length,
-						encoding, RFC2047_ADDRESS);
+		if (needs_rfc2047_encoding(name.buf, name.len, RFC2047_ADDRESS)) {
+			add_rfc2047(sb, name.buf, name.len,
+				    encoding, RFC2047_ADDRESS);
 			max_length = 76; /* per rfc2047 */
-		} else if (needs_rfc822_quoting(line, display_name_length)) {
+		} else if (needs_rfc822_quoting(name.buf, name.len)) {
 			struct strbuf quoted = STRBUF_INIT;
-			add_rfc822_quoted(&quoted, line, display_name_length);
+			add_rfc822_quoted(&quoted, name.buf, name.len);
 			strbuf_add_wrapped_bytes(sb, quoted.buf, quoted.len,
 							-6, 1, max_length);
 			strbuf_release(&quoted);
 		} else {
-			strbuf_add_wrapped_bytes(sb, line, display_name_length,
-							-6, 1, max_length);
+			strbuf_add_wrapped_bytes(sb, name.buf, name.len,
+						 -6, 1, max_length);
 		}
-		if (namelen - display_name_length + last_line_length(sb) > max_length) {
+		if (namelen - name.len + last_line_length(sb) > max_length)
 			strbuf_addch(sb, '\n');
-			if (!isspace(ident.name_end[0]))
-				strbuf_addch(sb, ' ');
-		}
-		strbuf_add(sb, ident.name_end, namelen - display_name_length);
-		strbuf_addch(sb, '\n');
+
+		strbuf_addf(sb, " <%s>\n", mail.buf);
 	} else {
-		strbuf_addf(sb, "%s: %.*s%.*s\n", what,
+		strbuf_addf(sb, "%s: %.*s%s <%s>\n", what,
 			      (pp->fmt == CMIT_FMT_FULLER) ? 4 : 0,
-			      "    ", namelen, line);
+			      "    ", name.buf, mail.buf);
 	}
+
+	strbuf_release(&mail);
+	strbuf_release(&name);
+
 	switch (pp->fmt) {
 	case CMIT_FMT_MEDIUM:
 		strbuf_addf(sb, "Date:   %s\n", show_date(time, tz, pp->date_mode));
-- 
1.8.1.304.gf036638
