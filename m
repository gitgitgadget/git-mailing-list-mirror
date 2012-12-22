From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH 1/2] log: grep author/committer using mailmap
Date: Sat, 22 Dec 2012 17:58:31 +0100
Message-ID: <1356195512-4846-2-git-send-email-apelisse@gmail.com>
References: <1356195512-4846-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 22 18:07:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmSXX-0003FR-7k
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 18:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845Ab2LVRGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 12:06:53 -0500
Received: from mail-wg0-f43.google.com ([74.125.82.43]:41437 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836Ab2LVRGv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 12:06:51 -0500
Received: by mail-wg0-f43.google.com with SMTP id e12so2558096wge.34
        for <git@vger.kernel.org>; Sat, 22 Dec 2012 09:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=QuyBmmYgDlWdTifSF2rkcsaFAEVcQBcOkvgcp+1YXUI=;
        b=mB/+2rBuJOBIQu2YxjdoYJkbjlgAyqCbq5idehiEOEQOT4l0LHZNlX9em/9hsZwjiq
         xlG8i9zxyQenrBq5cZzhXCxh9qyFLmFkUprTG7dRM8l7wWa+SPvMgs9ThmTaWmrpbWWD
         qH3ETURuDc76qVTpOawe0W23x8WU9vQP1i3Ssk/fJzun7XC0cbOUrJ8q+mXNkb/0+VGA
         YP0NKbuBtu7EW/ITNdmUJML5301zfVw44neQ5eKERO1lB/gaKvs9UYFYb7pN0T7jXfrs
         O25qNcMW84zk3H7K1qh0/NFKBeZiZUZ3Eln+iyIs1Y8za6KcrLphOB49NFbyrTEqMp5K
         T5Xw==
X-Received: by 10.194.242.69 with SMTP id wo5mr29223057wjc.10.1356195520599;
        Sat, 22 Dec 2012 08:58:40 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id s10sm24125843wiw.4.2012.12.22.08.58.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 22 Dec 2012 08:58:39 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.39.g9092a12
In-Reply-To: <1356195512-4846-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212060>

Currently mailmap can be used to display log authors and committers
but there no way to use mailmap to find commits with mapped values.

This commit allows those commands to work:

    git log --use-mailmap --author mapped_name_or_email
    git log --use-mailmap --committer mapped_name_or_email

Of course it only works if the --use-mailmap option is used.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
I probably missed something but I didn't find the connection with
commit 2d10c55. Let me know if I went the wrong direction.

 revision.c         |   53 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t4203-mailmap.sh |   18 ++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/revision.c b/revision.c
index 95d21e6..fb9fd41 100644
--- a/revision.c
+++ b/revision.c
@@ -13,6 +13,7 @@
 #include "decorate.h"
 #include "log-tree.h"
 #include "string-list.h"
+#include "mailmap.h"

 volatile show_early_output_fn_t show_early_output;

@@ -2219,6 +2220,50 @@ static int rewrite_parents(struct rev_info *revs, struct commit *commit)
 	return 0;
 }

+static int commit_rewrite_authors(struct strbuf *buf, const char *what, struct string_list *mailmap)
+{
+	char *author, *endp;
+	size_t len;
+	struct strbuf name = STRBUF_INIT;
+	struct strbuf mail = STRBUF_INIT;
+	struct ident_split ident;
+
+	author = strstr(buf->buf, what);
+	if (!author)
+		goto error;
+
+	author += strlen(what);
+	endp = strstr(author, "\n");
+	if (!endp)
+		goto error;
+
+	len = endp - author;
+
+	if (split_ident_line(&ident, author, len)) {
+	error:
+		strbuf_release(&name);
+		strbuf_release(&mail);
+
+		return 1;
+	}
+
+	strbuf_add(&name, ident.name_begin, ident.name_end - ident.name_begin);
+	strbuf_add(&mail, ident.mail_begin, ident.mail_end - ident.mail_begin);
+
+	map_user(mailmap, &mail, &name);
+
+	strbuf_addf(&name, " <%s>", mail.buf);
+
+	strbuf_splice(buf, ident.name_begin - buf->buf,
+		      ident.mail_end - ident.name_begin + 1,
+		      name.buf, name.len);
+
+	strbuf_release(&name);
+	strbuf_release(&mail);
+
+	return 0;
+}
+
 static int commit_match(struct commit *commit, struct rev_info *opt)
 {
 	int retval;
@@ -2237,6 +2282,14 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 	if (buf.len)
 		strbuf_addstr(&buf, commit->buffer);

+	if (opt->mailmap) {
+		if (!buf.len)
+			strbuf_addstr(&buf, commit->buffer);
+
+		commit_rewrite_authors(&buf, "\nauthor ", opt->mailmap);
+		commit_rewrite_authors(&buf, "\ncommitter ", opt->mailmap);
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
1.7.9.5
