From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 3/5] log: --show-signature
Date: Wed, 19 Oct 2011 17:37:01 -0700
Message-ID: <1319071023-31919-4-git-send-email-gitster@pobox.com>
References: <1318983645-18897-1-git-send-email-gitster@pobox.com>
 <1319071023-31919-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 02:37:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGgda-0007co-Qi
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 02:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755717Ab1JTAhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 20:37:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32998 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755673Ab1JTAhM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 20:37:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9615B69CE
	for <git@vger.kernel.org>; Wed, 19 Oct 2011 20:37:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=gHrU
	gS4Cg3IlrlAO4wwfEn6BOnc=; b=ijIMltSvbcR3bz/QwwRlnYtwGbWItTtEn1uh
	LIlGcj58j88Vv16BE5N6Pb+5fKkbZUC437/lDeOt2K+Neb2I6/WyBpCSVBDL4q8V
	w4TAAx7zlVNFWWKSm2CZ/uGsnaFfuOudUrP/4rTe18OEkNMZ6AV6Y5aEMnxuMabG
	VPhghgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=piFWIS
	K5Lqc6VCNalmI54VKeUGyljOurvoaijTAHwVvt07hlrobmhLP7I2G79gBq+tUCG5
	oL6fB3uEv04JOqAniMJGDgceApkq5V5Plkz6NuCv90Qc8MuuI5phIxdC594txZgo
	cNHbYZugq2owfzT+bMtDo0uHJCYY0Ik+9iH6Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D24769CD
	for <git@vger.kernel.org>; Wed, 19 Oct 2011 20:37:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D62D2696A for
 <git@vger.kernel.org>; Wed, 19 Oct 2011 20:37:10 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.498.g3f2e50
In-Reply-To: <1319071023-31919-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A5CCF4B2-FAB3-11E0-A7E6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183994>

This teaches the "log" family of commands to pass the GPG signature in the
commit objects to "gpg --verify" via the verify_signed_buffer() interface
used to verify signed tag objects. E.g.

    $ git show --show-signature -s HEAD

shows GPG output in the header part of the output.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c   |   34 ++++++++++++++++++++++++++++++++++
 commit.h   |    3 +++
 log-tree.c |   39 +++++++++++++++++++++++++++++++++++++++
 revision.c |    2 ++
 revision.h |    1 +
 5 files changed, 79 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index 4bff3cd..93045a2 100644
--- a/commit.c
+++ b/commit.c
@@ -848,6 +848,40 @@ static int do_sign_commit(struct strbuf *buf, const char *keyid)
 	return 0;
 }
 
+int parse_signed_commit(const unsigned char *sha1,
+			struct strbuf *payload, struct strbuf *signature)
+{
+	unsigned long size;
+	enum object_type type;
+	char *buffer = read_sha1_file(sha1, &type, &size);
+	int in_header, saw_signature = -1;
+	char *line;
+
+	if (!buffer || type != OBJ_COMMIT)
+		goto cleanup;
+
+	line = buffer;
+	in_header = 1;
+	saw_signature = 0;
+	while (*line) {
+		char *next = strchrnul(line, '\n');
+		if (*next)
+			next++;
+		if (in_header && !prefixcmp(line, gpg_sig_header)) {
+			const char *sig = line + gpg_sig_header_len;
+			strbuf_add(signature, sig, next - sig);
+			saw_signature = 1;
+		} else {
+			strbuf_add(payload, line, next - line);
+		}
+		if (*line == '\n')
+			in_header = 0;
+		line = next;
+	}
+ cleanup:
+	free(buffer);
+	return saw_signature;
+}
 
 static const char commit_utf8_warn[] =
 "Warning: commit message does not conform to UTF-8.\n"
diff --git a/commit.h b/commit.h
index 8c2419b..1885471 100644
--- a/commit.h
+++ b/commit.h
@@ -177,4 +177,7 @@ extern int commit_tree(const char *msg, unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret,
 		       const char *author, const char *sign_commit);
 
+extern int parse_signed_commit(const unsigned char *sha1,
+			       struct strbuf *message, struct strbuf *signature);
+
 #endif /* COMMIT_H */
diff --git a/log-tree.c b/log-tree.c
index 24c295e..f7b6976 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -8,6 +8,7 @@
 #include "refs.h"
 #include "string-list.h"
 #include "color.h"
+#include "gpg-interface.h"
 
 struct decoration name_decoration = { "object names" };
 
@@ -395,6 +396,41 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
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
@@ -502,6 +538,9 @@ void show_log(struct rev_info *opt)
 		}
 	}
 
+	if (opt->show_signature)
+		show_signature(opt, commit);
+
 	if (!commit->buffer)
 		return;
 
diff --git a/revision.c b/revision.c
index c46cfaa..860a312 100644
--- a/revision.c
+++ b/revision.c
@@ -1381,6 +1381,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->show_notes = 1;
 		revs->show_notes_given = 1;
 		revs->notes_opt.use_default_notes = 1;
+	} else if (!strcmp(arg, "--show-signature")) {
+		revs->show_signature = 1;
 	} else if (!prefixcmp(arg, "--show-notes=") ||
 		   !prefixcmp(arg, "--notes=")) {
 		struct strbuf buf = STRBUF_INIT;
diff --git a/revision.h b/revision.h
index 3d64ada..198bb95 100644
--- a/revision.h
+++ b/revision.h
@@ -89,6 +89,7 @@ struct rev_info {
 			show_merge:1,
 			show_notes:1,
 			show_notes_given:1,
+			show_signature:1,
 			pretty_given:1,
 			abbrev_commit:1,
 			abbrev_commit_given:1,
-- 
1.7.7.498.g3f2e50
