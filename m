From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH 06/10] pretty: use mailmap to display username and email
Date: Sat,  5 Jan 2013 22:26:42 +0100
Message-ID: <1357421206-5014-7-git-send-email-apelisse@gmail.com>
References: <1357421206-5014-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 22:28:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrbHY-0000ix-Ur
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 22:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755925Ab3AEV1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 16:27:25 -0500
Received: from mail-we0-f171.google.com ([74.125.82.171]:62843 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755912Ab3AEV1U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 16:27:20 -0500
Received: by mail-we0-f171.google.com with SMTP id u3so8901540wey.30
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 13:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=9zBRw+cWfAx36P0NI5EXPnrnUw+LDtSaHS1XRuyDNxk=;
        b=TgjDGdDRrbykI0xygbRUBCBRF8kJMvrW+Yiy7x2gz+r4oPdpsMXmbRuKnP+CVhRw10
         jRdTJIFigr2dp1n0STF/M2ENrYrIX308weC6KRXRRB9tNvja36l+v0ff5AvlQysiDzo4
         YoHnLZTHsbRXyZXnAxsONKxdTma5CAyDioftYookG4xrzaC0XvZVdo6acK+s9KhFppcI
         DfngmjJNi9OtCq7Cw90OZuAT6+HBFtGMT3eO1r8RwXzO0if6B8Qi+jzKQhoE865pYbuS
         yoZQgnC37lCYB6covwv5GWhqyU0PFtSnJ66pqWuQiszrEwzwyZUk41EHNNWvedtw6kgd
         zv1w==
X-Received: by 10.194.76.7 with SMTP id g7mr10691509wjw.50.1357421239118;
        Sat, 05 Jan 2013 13:27:19 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id t17sm5623711wiv.6.2013.01.05.13.27.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 13:27:18 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.15.g5ddde70
In-Reply-To: <1357421206-5014-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212722>

Use the mailmap information to display the correct
username and email address in all log commands.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
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
1.7.12.4.3.g2036a08.dirty
