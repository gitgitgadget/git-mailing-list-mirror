From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH v2] log: grep author/committer using mailmap
Date: Thu, 27 Dec 2012 16:31:58 +0100
Message-ID: <1356622318-19523-1-git-send-email-apelisse@gmail.com>
References: <7vy5gkmr53.fsf@alter.siamese.dyndns.org>
Cc: git <git@vger.kernel.org>, Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 27 16:32:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToFRZ-0003TA-Fo
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 16:32:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750Ab2L0PcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2012 10:32:06 -0500
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34153 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686Ab2L0PcF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2012 10:32:05 -0500
Received: by mail-wi0-f177.google.com with SMTP id hm2so5425185wib.16
        for <git@vger.kernel.org>; Thu, 27 Dec 2012 07:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=fdsd4k+QQwjNTegdstzPET4gZEWDzAlAXr9nOUubSc8=;
        b=pjL2ZZXIczfyXQUrf0Dk2vuabAXBQ3J5OunzZez0DVfl4X8WyeYgsJfDVm4YK4xZRg
         3rS2aw2OU1jNP5azjHzdpx3y5UOeL2Ewl9vCTOoyTjzGH8HYyGBiVf0jY98ZHRTKTcx4
         efJe9xCudbKl9kWT69+PNy41pHV4hgre8W5rA/Zv81TSZJt0u3zxk5oHI+WxMcUYMedg
         i+j7qsMgHSAWSYClde9wlPVXd/hP1VO+WCSeo4kieo8m7G060iTpTaHcuzLzpFs253TJ
         BPAk9VT7ZbqicDlBuU/l1VIuQE+RLFitmy5+wxrsL9MgKwLRCyezF1fuxbTSpQR1z7q8
         Y/Og==
X-Received: by 10.180.24.133 with SMTP id u5mr40241055wif.17.1356622323385;
        Thu, 27 Dec 2012 07:32:03 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id ex6sm49741157wid.3.2012.12.27.07.32.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 27 Dec 2012 07:32:02 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <7vy5gkmr53.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212201>

Currently you can use mailmap to display log authors and committers
but you can't use the mailmap to find commits with mapped values.

This commit allows you to run:

    git log --use-mailmap --author mapped_name_or_email
    git log --use-mailmap --committer mapped_name_or_email

Of course it only works if the --use-mailmap option is used.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 revision.c         |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t4203-mailmap.sh |   18 ++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/revision.c b/revision.c
index 95d21e6..fa16b9d 100644
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
+	size_t len;
+	struct strbuf name = STRBUF_INIT;
+	struct strbuf mail = STRBUF_INIT;
+	struct ident_split ident;
+
+	person = strstr(buf->buf, what);
+	if (!person)
+		goto left_intact;
+
+	person += strlen(what);
+	endp = strchr(person, '\n');
+	if (!endp)
+		goto left_intact;
+
+	len = endp - person;
+
+	if (split_ident_line(&ident, person, len))
+		goto left_intact;
+
+	strbuf_add(&name, ident.name_begin, ident.name_end - ident.name_begin);
+	strbuf_add(&mail, ident.mail_begin, ident.mail_end - ident.mail_begin);
+
+	if (map_user(mailmap, &mail, &name)) {
+		strbuf_addf(&name, " <%s>", mail.buf);
+
+		strbuf_splice(buf, ident.name_begin - buf->buf,
+			      ident.mail_end - ident.name_begin + 1,
+			      name.buf, name.len);
+
+		strbuf_release(&name);
+		strbuf_release(&mail);
+
+		return 1;
+	}
+
+left_intact:
+	strbuf_release(&name);
+	strbuf_release(&mail);
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
1.7.9.5
