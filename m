From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH 09/10] log: grep author/committer using mailmap
Date: Sat,  5 Jan 2013 22:26:45 +0100
Message-ID: <1357421206-5014-10-git-send-email-apelisse@gmail.com>
References: <1357421206-5014-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 22:28:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrbHb-0000ix-Mc
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 22:28:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755938Ab3AEV1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 16:27:40 -0500
Received: from mail-wg0-f46.google.com ([74.125.82.46]:64945 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755917Ab3AEV1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 16:27:24 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so8297169wgb.25
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 13:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=8y4QoccKim70vu2GSR8E8eT66Za+zPXZvH1Fcn6hxjg=;
        b=I0tIlY905tkrA/YZE/8azw9o75DTcz+xQ4uQ46O5GoKpIzAiEnxDiQbTX1ICN7XKoQ
         cGvrXWqrAyjellVR5jfrQGErBMT9rWPrDDNSmhL2ipGSyfCAo+ihxM7dqMmH1xK/vPxB
         GFH7ZR5QQE+yUAGeFsGY1hTCks/ii8OQSTWEoXDwcXUHz9IjNaKqt3fb5K6w0L1vyGVw
         l8KjXqakSk3y98cRW3QXwZgq17V0VUz3Kf6E+xQIRoZ+jkNovbE9SUEqLj+uqQ16DEEF
         UcLbyNAiy8r4/LlX6EJ28SUAhF1Ca+csnMd3AgeaLZk+DSrPZRgCXa38apKjPuGAGZxD
         rAZQ==
X-Received: by 10.194.21.70 with SMTP id t6mr89501040wje.42.1357421243107;
        Sat, 05 Jan 2013 13:27:23 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id t17sm5623711wiv.6.2013.01.05.13.27.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 13:27:22 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.15.g5ddde70
In-Reply-To: <1357421206-5014-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212721>

Currently you can use mailmap to display log authors and committers
but you can't use the mailmap to find commits with mapped values.

This commit allows you to run:

    git log --use-mailmap --author mapped_name_or_email
    git log --use-mailmap --committer mapped_name_or_email

Of course it only works if the --use-mailmap option is used.

The new name and email are copied only when necessary.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 revision.c         | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t4203-mailmap.sh | 18 ++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/revision.c b/revision.c
index 95d21e6..2cce85a 100644
--- a/revision.c
+++ b/revision.c
@@ -13,6 +13,7 @@
 #include "decorate.h"
 #include "log-tree.h"
 #include "string-list.h"
+#include "mailmap.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -2219,6 +2220,51 @@ static int rewrite_parents(struct rev_info *revs, struct commit *commit)
 	return 0;
 }
 
+static int commit_rewrite_person(struct strbuf *buf, const char *what, struct string_list *mailmap)
+{
+	char *person, *endp;
+	size_t len, namelen, maillen;
+	const char *name;
+	const char *mail;
+	struct ident_split ident;
+
+	person = strstr(buf->buf, what);
+	if (!person)
+		return 0;
+
+	person += strlen(what);
+	endp = strchr(person, '\n');
+	if (!endp)
+		return 0;
+
+	len = endp - person;
+
+	if (split_ident_line(&ident, person, len))
+		return 0;
+
+	mail = ident.mail_begin;
+	maillen = ident.mail_end - ident.mail_begin;
+	name = ident.name_begin;
+	namelen = ident.name_end - ident.name_begin;
+
+	if (map_user(mailmap, &mail, &maillen, &name, &namelen)) {
+		struct strbuf namemail = STRBUF_INIT;
+
+		strbuf_addf(&namemail, "%.*s <%.*s>",
+			    (int)namelen, name, (int)maillen, mail);
+
+		strbuf_splice(buf, ident.name_begin - buf->buf,
+			      ident.mail_end - ident.name_begin + 1,
+			      namemail.buf, namemail.len);
+
+		strbuf_release(&namemail);
+
+		return 1;
+	}
+
+	return 0;
+}
+
 static int commit_match(struct commit *commit, struct rev_info *opt)
 {
 	int retval;
@@ -2237,6 +2283,14 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 	if (buf.len)
 		strbuf_addstr(&buf, commit->buffer);
 
+	if (opt->mailmap) {
+		if (!buf.len)
+			strbuf_addstr(&buf, commit->buffer);
+
+		commit_rewrite_person(&buf, "\nauthor ", opt->mailmap);
+		commit_rewrite_person(&buf, "\ncommitter ", opt->mailmap);
+	}
+
 	/* Append "fake" message parts as needed */
 	if (opt->show_notes) {
 		if (!buf.len)
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index db043dc..e16187f 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -248,11 +248,29 @@ Author: Other Author <other@author.xx>
 Author: Some Dude <some@dude.xx>
 Author: A U Thor <author@example.com>
 EOF
+
 test_expect_success 'Log output with --use-mailmap' '
 	git log --use-mailmap | grep Author >actual &&
 	test_cmp expect actual
 '
 
+cat >expect <<\EOF
+Author: Santa Claus <santa.claus@northpole.xx>
+Author: Santa Claus <santa.claus@northpole.xx>
+EOF
+
+test_expect_success 'Grep author with --use-mailmap' '
+	git log --use-mailmap --author Santa | grep Author >actual &&
+	test_cmp expect actual
+'
+
+>expect
+
+test_expect_success 'Only grep replaced author with --use-mailmap' '
+	git log --use-mailmap --author "<cto@coompany.xx>" >actual &&
+	test_cmp expect actual
+'
+
 # git blame
 cat >expect <<\EOF
 ^OBJI (A U Thor     DATE 1) one
-- 
1.7.12.4.3.g2036a08.dirty
