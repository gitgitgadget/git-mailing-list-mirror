From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 15/17] log: --show-signature
Date: Tue,  8 Nov 2011 17:02:01 -0800
Message-ID: <1320800523-5407-16-git-send-email-gitster@pobox.com>
References: <1320800523-5407-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 02:02:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNwZ3-0003z8-JV
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 02:02:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755372Ab1KIBCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 20:02:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36669 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754369Ab1KIBCj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 20:02:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 448115BA8
	for <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=3k0b
	XgPaZU9YuLQ60ZhHOA6mODw=; b=nx2zPzsOlmWyHLK0wQvHxvszaaLHvb2ojl0S
	NOcuqZL+SoKQuh91t0BxjcP0GROMDUz7ISQMKo9akFR1CxtbPm333Y9u65xhXYRS
	CYTTR6jJR0JEnFR8Imb1U7vo9Z1ZtZ0CMxh0Ghz1TusWicob0sdPOG4G03Cwkkge
	KPfleUk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=CRvhan
	xd33OX1FnIrtOKcTnL6ZJVeHfVFbnSqbmmEpFLJNVHirCPo9CvRAQOLq/eCkZ9cu
	lp9QxFxD4un+FQED9x9jHK0s+HeA5KvaQ71xy6gdwjTTzr9SkwNHzOSavQ2Adp8p
	dn2kiWWmFo9UaJjxhu7EhKKHgCB4dOTakdNSQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CC9A5BA7
	for <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 69E535BA6 for
 <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:38 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc1.82.gde0f9
In-Reply-To: <1320800523-5407-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 848E6496-0A6E-11E1-9413-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185134>

This teaches the "log" family of commands to pass the GPG signature in the
commit objects to "gpg --verify" via the verify_signed_buffer() interface
used to verify signed tag objects. E.g.

    $ git show --show-signature -s HEAD

shows GPG output in the header part of the output.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c   |   44 ++++++++++++++++++++++++++++++++++++++++++++
 commit.h   |    2 ++
 log-tree.c |   39 +++++++++++++++++++++++++++++++++++++++
 revision.c |    2 ++
 revision.h |    1 +
 5 files changed, 88 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index a5c53b3..7fb1830 100644
--- a/commit.c
+++ b/commit.c
@@ -877,6 +877,50 @@ static int do_sign_commit(struct strbuf *buf, const char *keyid)
 	return 0;
 }
 
+int parse_signed_commit(const unsigned char *sha1,
+			struct strbuf *payload, struct strbuf *signature)
+{
+	unsigned long size;
+	enum object_type type;
+	char *buffer = read_sha1_file(sha1, &type, &size);
+	int in_signature, saw_signature = -1;
+	char *line, *tail;
+
+	if (!buffer || type != OBJ_COMMIT)
+		goto cleanup;
+
+	line = buffer;
+	tail = buffer + size;
+	in_signature = 0;
+	saw_signature = 0;
+	while (line < tail) {
+		const char *sig = NULL;
+		char *next = memchr(line, '\n', tail - line);
+
+		next = next ? next + 1 : tail;
+		if (in_signature && line[0] == ' ')
+			sig = line + 1;
+		else if (!prefixcmp(line, gpg_sig_header) &&
+			 line[gpg_sig_header_len] == ' ')
+			sig = line + gpg_sig_header_len + 1;
+		if (sig) {
+			strbuf_add(signature, sig, next - sig);
+			saw_signature = 1;
+			in_signature = 1;
+		} else {
+			if (*line == '\n')
+				/* dump the whole remainder of the buffer */
+				next = tail;
+			strbuf_add(payload, line, next - line);
+			in_signature = 0;
+		}
+		line = next;
+	}
+ cleanup:
+	free(buffer);
+	return saw_signature;
+}
+
 static void handle_signed_tag(struct commit *parent, struct commit_extra_header ***tail)
 {
 	struct merge_remote_desc *desc;
diff --git a/commit.h b/commit.h
index d2c3e65..6107648 100644
--- a/commit.h
+++ b/commit.h
@@ -218,4 +218,6 @@ struct merge_remote_desc {
  */
 struct commit *get_merge_parent(const char *name);
 
+extern int parse_signed_commit(const unsigned char *sha1,
+			       struct strbuf *message, struct strbuf *signature);
 #endif /* COMMIT_H */
diff --git a/log-tree.c b/log-tree.c
index e7694a3..142ba51 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -8,6 +8,7 @@
 #include "refs.h"
 #include "string-list.h"
 #include "color.h"
+#include "gpg-interface.h"
 
 struct decoration name_decoration = { "object names" };
 
@@ -403,6 +404,41 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 	*extra_headers_p = extra_headers;
 }
 
+static void show_signature(struct rev_info *opt, struct commit *commit)
+{
+	struct strbuf payload = STRBUF_INIT;
+	struct strbuf signature = STRBUF_INIT;
+	struct strbuf gpg_output = STRBUF_INIT;
+	int status;
+	const char *color, *reset, *bol, *eol;
+
+	if (parse_signed_commit(commit->object.sha1, &payload, &signature) <= 0)
+		goto out;
+
+	status = verify_signed_buffer(payload.buf, payload.len,
+				      signature.buf, signature.len,
+				      &gpg_output);
+	if (status && !gpg_output.len)
+		strbuf_addstr(&gpg_output, "No signature\n");
+
+	color = diff_get_color_opt(&opt->diffopt,
+				   status ? DIFF_WHITESPACE : DIFF_FRAGINFO);
+	reset = diff_get_color_opt(&opt->diffopt, DIFF_RESET);
+
+	bol = gpg_output.buf;
+	while (*bol) {
+		eol = strchrnul(bol, '\n');
+		printf("%s%.*s%s%s", color, (int)(eol - bol), bol, reset,
+		       *eol ? "\n" : "");
+		bol = (*eol) ? (eol + 1) : eol;
+	}
+
+ out:
+	strbuf_release(&gpg_output);
+	strbuf_release(&payload);
+	strbuf_release(&signature);
+}
+
 void show_log(struct rev_info *opt)
 {
 	struct strbuf msgbuf = STRBUF_INIT;
@@ -514,6 +550,9 @@ void show_log(struct rev_info *opt)
 		}
 	}
 
+	if (opt->show_signature)
+		show_signature(opt, commit);
+
 	if (!commit->buffer)
 		return;
 
diff --git a/revision.c b/revision.c
index 8764dde..064e351 100644
--- a/revision.c
+++ b/revision.c
@@ -1469,6 +1469,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->show_notes = 1;
 		revs->show_notes_given = 1;
 		revs->notes_opt.use_default_notes = 1;
+	} else if (!strcmp(arg, "--show-signature")) {
+		revs->show_signature = 1;
 	} else if (!prefixcmp(arg, "--show-notes=") ||
 		   !prefixcmp(arg, "--notes=")) {
 		struct strbuf buf = STRBUF_INIT;
diff --git a/revision.h b/revision.h
index 6aa53d1..b8e9223 100644
--- a/revision.h
+++ b/revision.h
@@ -110,6 +110,7 @@ struct rev_info {
 			show_merge:1,
 			show_notes:1,
 			show_notes_given:1,
+			show_signature:1,
 			pretty_given:1,
 			abbrev_commit:1,
 			abbrev_commit_given:1,
-- 
1.7.8.rc1.82.g90e080
