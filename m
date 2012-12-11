From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH 4/5] pretty: Use mailmap to display username and email
Date: Tue, 11 Dec 2012 23:21:32 +0100
Message-ID: <1355264493-8298-5-git-send-email-apelisse@gmail.com>
References: <1355264493-8298-1-git-send-email-apelisse@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Rich Midwinter <rich.midwinter@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 11 23:22:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiYDn-0001al-8W
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 23:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755029Ab2LKWWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 17:22:19 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:44833 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952Ab2LKWWP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 17:22:15 -0500
Received: by mail-we0-f174.google.com with SMTP id x10so1887158wey.19
        for <git@vger.kernel.org>; Tue, 11 Dec 2012 14:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/vcTIAiXXzN7CuJcC690oG64stNnHRFC+BoAiLkNUWI=;
        b=goZfmh/xxLwP2jdqtpPVIfpJ+YQSEW0pb7GMQX0Q90NiBSG463Gdjr8THW0MW31zYi
         DaG85QcfHbt07MgvGs0IXaJv05f4BRCv/hmzFXVXuW+S4orLfPeilQkUXEakyip+XOd7
         hf0dBn7Q7J5aedW9F9tKXqi1fx8jZStikKLHU+cKqgNuE5Tek6YcAQjT8yNzbiNPOCZ7
         sA4nQFvvLIRiRxbmNcqCDvqeePbQZVIeMOaiTtzPwLUffpsmTNB5auWlzc/hx7pD5PBP
         osfnxcWKvUcFZTj4PDeceLrxuSEjnuV6ShCzs2AsZWauqU7N2ncFqb73WHSK33Wank+u
         NqSw==
Received: by 10.180.80.201 with SMTP id t9mr19367295wix.0.1355264535277;
        Tue, 11 Dec 2012 14:22:15 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id ec3sm610033wib.10.2012.12.11.14.22.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Dec 2012 14:22:14 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.5.g7e0651a
In-Reply-To: <1355264493-8298-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211307>

Use the mailmap information to display the correct
username and email address in all log commands.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 pretty.c | 46 +++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/pretty.c b/pretty.c
index 6730add..e232aaa 100644
--- a/pretty.c
+++ b/pretty.c
@@ -387,6 +387,8 @@ void pp_user_info(const struct pretty_print_context *pp,
 		  const char *what, struct strbuf *sb,
 		  const char *line, const char *encoding)
 {
+	char person_name[1024];
+	char person_mail[1024];
 	struct ident_split ident;
 	int linelen, namelen;
 	char *line_end, *date;
@@ -405,41 +407,55 @@ void pp_user_info(const struct pretty_print_context *pp,
 	if (split_ident_line(&ident, line, linelen))
 		return;
 
-	namelen = ident.mail_end - ident.name_begin + 1;
+	memcpy(person_mail, ident.mail_begin, ident.mail_end - ident.mail_begin);
+	person_mail[ident.mail_end - ident.mail_begin] = 0;
+
+	memcpy(person_name, ident.name_begin, ident.name_end - ident.name_begin);
+	person_name[ident.name_end - ident.name_begin] = 0;
+
+	if (pp->mailmap)
+		map_user(pp->mailmap, person_mail, sizeof(person_mail),
+			 person_name, sizeof(person_name));
+
+	namelen = strlen(person_name) + strlen(person_mail);
 	time = strtoul(ident.date_begin, &date, 10);
 	tz = strtol(date, NULL, 10);
 
 	if (pp->fmt == CMIT_FMT_EMAIL) {
 		int display_name_length;
 
-		display_name_length = ident.name_end - ident.name_begin;
+		display_name_length = strlen(person_name);
 
 		strbuf_addstr(sb, "From: ");
-		if (needs_rfc2047_encoding(line, display_name_length, RFC2047_ADDRESS)) {
-			add_rfc2047(sb, line, display_name_length,
+		if (needs_rfc2047_encoding(person_name, display_name_length, RFC2047_ADDRESS)) {
+			add_rfc2047(sb, person_name, display_name_length,
 						encoding, RFC2047_ADDRESS);
 			max_length = 76; /* per rfc2047 */
-		} else if (needs_rfc822_quoting(line, display_name_length)) {
+		} else if (needs_rfc822_quoting(person_name,
+						display_name_length)) {
 			struct strbuf quoted = STRBUF_INIT;
-			add_rfc822_quoted(&quoted, line, display_name_length);
+			add_rfc822_quoted(&quoted, person_name,
+					  display_name_length);
 			strbuf_add_wrapped_bytes(sb, quoted.buf, quoted.len,
 							-6, 1, max_length);
 			strbuf_release(&quoted);
 		} else {
-			strbuf_add_wrapped_bytes(sb, line, display_name_length,
-							-6, 1, max_length);
+			strbuf_add_wrapped_bytes(sb, person_name,
+						 display_name_length,
+						 -6, 1, max_length);
 		}
-		if (namelen - display_name_length + last_line_length(sb) > max_length) {
+		if (namelen - display_name_length + last_line_length(sb) > max_length)
 			strbuf_addch(sb, '\n');
-			if (!isspace(ident.name_end[0]))
-				strbuf_addch(sb, ' ');
-		}
-		strbuf_add(sb, ident.name_end, namelen - display_name_length);
+
+		strbuf_addch(sb, ' ');
+		strbuf_addch(sb, '<');
+		strbuf_add(sb, person_mail, strlen(person_mail));
+		strbuf_addch(sb, '>');
 		strbuf_addch(sb, '\n');
 	} else {
-		strbuf_addf(sb, "%s: %.*s%.*s\n", what,
+		strbuf_addf(sb, "%s: %.*s%s <%s>\n", what,
 			      (pp->fmt == CMIT_FMT_FULLER) ? 4 : 0,
-			      "    ", namelen, line);
+			    "    ", person_name, person_mail);
 	}
 	switch (pp->fmt) {
 	case CMIT_FMT_MEDIUM:
-- 
1.8.1.rc1.5.g7e0651a
