From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH v2 5/7] pretty: Use mailmap to display username and email
Date: Sat, 15 Dec 2012 19:05:52 +0100
Message-ID: <1355594754-27589-6-git-send-email-apelisse@gmail.com>
References: <1355594754-27589-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 15 19:06:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tjw8G-0001Hn-0N
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 19:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424Ab2LOSGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 13:06:13 -0500
Received: from mail-wg0-f46.google.com ([74.125.82.46]:65023 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036Ab2LOSGI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 13:06:08 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so1888858wgb.1
        for <git@vger.kernel.org>; Sat, 15 Dec 2012 10:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=ZWtUheLd5rMeSblQp6VE9oCHzMJ7/6LmISXUO9OlbjM=;
        b=dcKzWTYKx0vRPiG5jWq3d5HgobH3RBZkWdJ8Y34F4zTILrFWTai6IAmmNCKTYiO9/7
         mpiXrr423JoyZXTIJssiAve7ral+m0e+feA9REOpNI5gVGk/+a0C7TsS3naDXS51ZdL7
         8YNmbgWAMnmMt28DLIMWUXvCRurwNAVDVH2AUiBg7CovWrQvbalzIjfuiLMDQ6Pkp+4b
         h57vDmsc7kno0Eub63BrgzW4veTmkhF6Sm3y9Y8hQwOAc99hHCGJa/1HEGf2kZrsScKw
         OcFG7nCNKh8r8gsD8qjMg8qmSjOd+/Hs5nkMjpsRbpxSIwGw9BcBTf41YKlIRO0Zi845
         CZgA==
X-Received: by 10.180.24.70 with SMTP id s6mr8295402wif.22.1355594767154;
        Sat, 15 Dec 2012 10:06:07 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id bd7sm3570983wib.8.2012.12.15.10.06.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 15 Dec 2012 10:06:06 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1355594754-27589-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211548>

Use the mailmap information to display the correct
username and email address in all log commands.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 pretty.c |   48 ++++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/pretty.c b/pretty.c
index d05c675..fbf87b7 100644
--- a/pretty.c
+++ b/pretty.c
@@ -387,6 +387,8 @@ void pp_user_info(const struct pretty_print_context *pp,
 		  const char *what, struct strbuf *sb,
 		  const char *line, const char *encoding)
 {
+	struct strbuf name;
+	struct strbuf mail;
 	struct ident_split ident;
 	int linelen, namelen;
 	char *line_end, *date;
@@ -408,42 +410,48 @@ void pp_user_info(const struct pretty_print_context *pp,
 	if (split_ident_line(&ident, line, linelen))
 		return;
 
-	namelen = ident.mail_end - ident.name_begin + 1;
+	strbuf_init(&mail, 0);
+	strbuf_init(&name, 0);
+
+	strbuf_add(&mail, ident.mail_begin, ident.mail_end - ident.mail_begin);
+	strbuf_add(&name, ident.name_begin, ident.name_end - ident.name_begin);
+
+	if (pp->mailmap)
+		map_user(pp->mailmap, &mail, &name);
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
1.7.9.5
