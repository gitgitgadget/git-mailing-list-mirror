From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/10] log: grep author/committer using mailmap
Date: Mon,  7 Jan 2013 16:10:20 -0800
Message-ID: <1357603821-8647-10-git-send-email-gitster@pobox.com>
References: <1357603821-8647-1-git-send-email-gitster@pobox.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 01:11:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsMmh-0006ZE-Ka
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 01:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756150Ab3AHAK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 19:10:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50403 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756153Ab3AHAKo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 19:10:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6254B7CA;
	Mon,  7 Jan 2013 19:10:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=MZWC
	iIR+7OCYgMCdwekUBBakd08=; b=Ef3MeWELZL3YOffWlYwVr3NxL4goZBTt8vCb
	AfMvdnSJptERPVw8Zfg2rlcG9LLm/dDEQ43enLD2oKBd9mGTHVbDxIQkCprvEWLV
	60nzzrlkjyvycZIABbgUZ2eMh1SENR55UEQmayEpOzC8xtD2RjbkJ9aaKP3Gs8aM
	jZbzPRs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	exjVPMXI8fJ9jBrzlMq/+0J0za7YQIpi7qGTD9+XrkeGSyarJBKxxVb5k5pgENec
	y3Fzt3Yk4ygrtpGvfrz9tVci5lcxtjobqTFMXq2MLYrSKrW4+oD9DMS3GPiIq0IU
	dKE89TlvaxZQ+8eLXJgF7JTGi2WIVdiDtbfvZWBsKl0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B85CFB7C9;
	Mon,  7 Jan 2013 19:10:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E1F1CB7C7; Mon,  7 Jan 2013
 19:10:42 -0500 (EST)
X-Mailer: git-send-email 1.8.1.304.gf036638
In-Reply-To: <1357603821-8647-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D78AAC5A-5927-11E2-9ABF-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212930>

From: Antoine Pelisse <apelisse@gmail.com>

Currently you can use mailmap to display log authors and committers
but you can't use the mailmap to find commits with mapped values.

This commit allows you to run:

    git log --use-mailmap --author mapped_name_or_email
    git log --use-mailmap --committer mapped_name_or_email

Of course it only works if the --use-mailmap option is used.

The new name and email are copied only when necessary.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
1.8.1.304.gf036638
