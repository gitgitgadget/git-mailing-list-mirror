From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH 1/5] Use split_ident_line to parse author and committer
Date: Tue, 11 Dec 2012 23:21:29 +0100
Message-ID: <1355264493-8298-2-git-send-email-apelisse@gmail.com>
References: <1355264493-8298-1-git-send-email-apelisse@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Rich Midwinter <rich.midwinter@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 11 23:22:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiYDb-0001RM-KN
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 23:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754814Ab2LKWWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 17:22:08 -0500
Received: from mail-wi0-f170.google.com ([209.85.212.170]:46325 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754154Ab2LKWWH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 17:22:07 -0500
Received: by mail-wi0-f170.google.com with SMTP id hq7so2478312wib.1
        for <git@vger.kernel.org>; Tue, 11 Dec 2012 14:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=BtVXOxHKpUUdUr17zA6QzMzsyIKH3sRkkR2HiNGzUI8=;
        b=q99G8851/+gVyUteW0iMettnhi4zj/gkoOlOZL0XR2i9GaKiK5ryuN6HXGb+HQStG6
         50Xpgex/DPMhdqt0bxGj7hRLQsEfsf1TRITqHDBmg+qYKlF3BY2jIKt4tUhvCfodl3Ig
         DVGHbkrR4K+KFPduH+iar+SHOc8G1Ug6fVpedJTzWe88qKBmBc//U4JLsDyfb0pT9de1
         0xGFClJyoKgtSUjGs2/P8JhbnGTtG5aOmFlX4JfCVhpfavWTXWiGL6JY6+XmieQwZQBK
         yOrI8e8myMkwG1vLUuFuAZqoQ+ivkFx1YthvIjlDLJkNpaKu+wKEaacn6ZJ1x1fLJ1Py
         rATA==
Received: by 10.194.173.38 with SMTP id bh6mr3118463wjc.26.1355264526136;
        Tue, 11 Dec 2012 14:22:06 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id ec3sm610033wib.10.2012.12.11.14.22.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Dec 2012 14:22:05 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.5.g7e0651a
In-Reply-To: <1355264493-8298-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211306>

Currently blame.c::get_acline and pretty.c::pp_user_info()
are parsing author name, email, time and tz themselves.

Use ident.c::split_ident_line for better code reuse.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 builtin/blame.c | 59 ++++++++++++++++++++-------------------------------------
 pretty.c        | 32 +++++++++++++++++--------------
 2 files changed, 39 insertions(+), 52 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index cfae569..dd4aff9 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1343,8 +1343,9 @@ static void get_ac_line(const char *inbuf, const char *what,
 			int mail_len, char *mail,
 			unsigned long *time, const char **tz)
 {
-	int len, tzlen, maillen;
-	char *tmp, *endp, *timepos, *mailpos;
+	struct ident_split ident;
+	int len, tzlen, maillen, namelen;
+	char *tmp, *endp, *mailpos;
 
 	tmp = strstr(inbuf, what);
 	if (!tmp)
@@ -1355,7 +1356,10 @@ static void get_ac_line(const char *inbuf, const char *what,
 		len = strlen(tmp);
 	else
 		len = endp - tmp;
-	if (person_len <= len) {
+	if (person_len <= len)
+		goto error_out;
+
+	if (split_ident_line(&ident, tmp, len)) {
 	error_out:
 		/* Ugh */
 		*tz = "(unknown)";
@@ -1364,47 +1368,26 @@ static void get_ac_line(const char *inbuf, const char *what,
 		*time = 0;
 		return;
 	}
-	memcpy(person, tmp, len);
 
-	tmp = person;
-	tmp += len;
-	*tmp = 0;
-	while (person < tmp && *tmp != ' ')
-		tmp--;
-	if (tmp <= person)
-		goto error_out;
-	*tz = tmp+1;
-	tzlen = (person+len)-(tmp+1);
+	namelen = ident.name_end - ident.name_begin;
+	memcpy(person, ident.name_begin, namelen);
+	person[namelen] = 0;
 
-	*tmp = 0;
-	while (person < tmp && *tmp != ' ')
-		tmp--;
-	if (tmp <= person)
-		goto error_out;
-	*time = strtoul(tmp, NULL, 10);
-	timepos = tmp;
+	maillen = ident.mail_end - ident.mail_begin + 2;
+	memcpy(mail, ident.mail_begin - 1, maillen);
+	mail[maillen] = 0;
 
-	*tmp = 0;
-	while (person < tmp && !(*tmp == ' ' && tmp[1] == '<'))
-		tmp--;
-	if (tmp <= person)
-		return;
-	mailpos = tmp + 1;
-	*tmp = 0;
-	maillen = timepos - tmp;
-	memcpy(mail, mailpos, maillen);
+	*time = strtoul(ident.date_begin, NULL, 10);
 
-	if (!mailmap.nr)
-		return;
+	tzlen = ident.tz_end - ident.tz_begin;
 
-	/*
-	 * mailmap expansion may make the name longer.
-	 * make room by pushing stuff down.
-	 */
-	tmp = person + person_len - (tzlen + 1);
-	memmove(tmp, *tz, tzlen);
+	/* Place tz at the end of person */
+	*tz = tmp = person + person_len - (tzlen + 1);
+	memcpy(tmp, ident.tz_begin, tzlen);
 	tmp[tzlen] = 0;
-	*tz = tmp;
+
+	if (!mailmap.nr)
+		return;
 
 	/*
 	 * Now, convert both name and e-mail using mailmap
diff --git a/pretty.c b/pretty.c
index 5bdc2e7..6730add 100644
--- a/pretty.c
+++ b/pretty.c
@@ -387,29 +387,33 @@ void pp_user_info(const struct pretty_print_context *pp,
 		  const char *what, struct strbuf *sb,
 		  const char *line, const char *encoding)
 {
+	struct ident_split ident;
+	int linelen, namelen;
+	char *line_end, *date;
 	int max_length = 78; /* per rfc2822 */
-	char *date;
-	int namelen;
 	unsigned long time;
 	int tz;
 
 	if (pp->fmt == CMIT_FMT_ONELINE)
 		return;
-	date = strchr(line, '>');
-	if (!date)
+
+	line_end = strchr(line, '\n');
+	if (!line_end)
+		return;
+
+	linelen = ++line_end - line;
+	if (split_ident_line(&ident, line, linelen))
 		return;
-	namelen = ++date - line;
-	time = strtoul(date, &date, 10);
+
+	namelen = ident.mail_end - ident.name_begin + 1;
+	time = strtoul(ident.date_begin, &date, 10);
 	tz = strtol(date, NULL, 10);
 
 	if (pp->fmt == CMIT_FMT_EMAIL) {
-		char *name_tail = strchr(line, '<');
 		int display_name_length;
-		if (!name_tail)
-			return;
-		while (line < name_tail && isspace(name_tail[-1]))
-			name_tail--;
-		display_name_length = name_tail - line;
+
+		display_name_length = ident.name_end - ident.name_begin;
+
 		strbuf_addstr(sb, "From: ");
 		if (needs_rfc2047_encoding(line, display_name_length, RFC2047_ADDRESS)) {
 			add_rfc2047(sb, line, display_name_length,
@@ -427,10 +431,10 @@ void pp_user_info(const struct pretty_print_context *pp,
 		}
 		if (namelen - display_name_length + last_line_length(sb) > max_length) {
 			strbuf_addch(sb, '\n');
-			if (!isspace(name_tail[0]))
+			if (!isspace(ident.name_end[0]))
 				strbuf_addch(sb, ' ');
 		}
-		strbuf_add(sb, name_tail, namelen - display_name_length);
+		strbuf_add(sb, ident.name_end, namelen - display_name_length);
 		strbuf_addch(sb, '\n');
 	} else {
 		strbuf_addf(sb, "%s: %.*s%.*s\n", what,
-- 
1.8.1.rc1.5.g7e0651a
