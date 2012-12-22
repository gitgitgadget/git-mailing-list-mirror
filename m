From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/7] get_patch_filename(): split into two functions
Date: Sat, 22 Dec 2012 00:33:31 -0800
Message-ID: <1356165212-5611-7-git-send-email-gitster@pobox.com>
References: <1356165212-5611-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 22 09:34:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmKX1-0007tg-8c
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 09:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287Ab2LVIdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 03:33:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64951 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751202Ab2LVIdr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 03:33:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFD528291
	for <git@vger.kernel.org>; Sat, 22 Dec 2012 03:33:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=OPTj
	/0ZnY9q0bttfCs5A7h4JNyY=; b=I3X2Fu9rfq2egwOkwIjqQobZyyO5QjbLc7kF
	H0ur2xPYLQaciiRu/XYY8U6H+nA+CLMwmgt5EKnmXEkbC6xJJGhQ+N/XXcU48ccS
	Ad/Hc8r292F2QtIIrAA7o4oCj0jIcAIjNiqhshtpXmax12Wd7YiSHEDW60hVNrG8
	e6lVLKc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=gM8xJ1
	pP/NKnBcRiuSwRtGyUFVN6GFz9uQQQToPQZeJYbwzrGG4ltBRqspXQ6DyXVALPzQ
	mWoA117zanvFZzogbfKz9Aps25IkkfKxuYlbaIo/JyEYDhDn7S5RLrK+a7pGBvJ2
	6xgjRjShgcHT4i5Q3KzCopTiD3D5bZi3DZYsE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E7088290
	for <git@vger.kernel.org>; Sat, 22 Dec 2012 03:33:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F06E0828F for
 <git@vger.kernel.org>; Sat, 22 Dec 2012 03:33:45 -0500 (EST)
X-Mailer: git-send-email 1.8.1.rc2.227.g7335c9f
In-Reply-To: <1356165212-5611-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4D063B5C-4C12-11E2-9784-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212041>

The function switched between two operating modes depending on the
NULL-ness of its two parameters, as a hacky way to share small part
of implementation, sacrificing cleanliness of the API.

Implement "fmt_output_subject()" function that takes a subject
string and gives the name for the output file, and on top of it,
implement "fmt_output_commit()" function that takes a commit and
gives the name for the output file.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c |  4 +++-
 log-tree.c    | 41 +++++++++++++++++++++++------------------
 log-tree.h    |  5 ++---
 3 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 3c6f20a..8cfb4da 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -686,8 +686,10 @@ static int reopen_stdout(struct commit *commit, const char *subject,
 
 	if (rev->numbered_files)
 		strbuf_addf(&filename, "%d", rev->nr);
+	else if (commit)
+		fmt_output_commit(&filename, commit, rev);
 	else
-		get_patch_filename(&filename, commit, subject, rev);
+		fmt_output_subject(&filename, subject, rev);
 
 	if (!quiet)
 		fprintf(realstdout, "%s\n", filename.buf + outdir_offset);
diff --git a/log-tree.c b/log-tree.c
index d9f86ce..670beae 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -299,26 +299,32 @@ static unsigned int digits_in_number(unsigned int number)
 	return result;
 }
 
-void get_patch_filename(struct strbuf *buf,
-			struct commit *commit, const char *subject,
+void fmt_output_subject(struct strbuf *filename,
+			const char *subject,
 			struct rev_info *info)
 {
 	const char *suffix = info->patch_suffix;
 	int nr = info->nr;
-	int suffix_len = strlen(suffix) + 1;
-	int start_len = buf->len;
-	int max_len = start_len + FORMAT_PATCH_NAME_MAX - suffix_len;
-
-	strbuf_addf(buf, "%04d-", nr);
-	if (subject)
-		strbuf_addstr(buf, subject);
-	else if (commit) {
-		struct pretty_print_context ctx = {0};
-		format_commit_message(commit, "%f", buf, &ctx);
-	}
-	if (max_len < buf->len)
-		strbuf_setlen(buf, max_len);
-	strbuf_addstr(buf, suffix);
+	int start_len = filename->len;
+	int max_len = start_len + FORMAT_PATCH_NAME_MAX - (strlen(suffix) + 1);
+
+	strbuf_addf(filename, "%04d-%s", nr, subject);
+
+	if (max_len < filename->len)
+		strbuf_setlen(filename, max_len);
+	strbuf_addstr(filename, suffix);
+}
+
+void fmt_output_commit(struct strbuf *filename,
+		       struct commit *commit,
+		       struct rev_info *info)
+{
+	struct pretty_print_context ctx = {0};
+	struct strbuf subject = STRBUF_INIT;
+
+	format_commit_message(commit, "%f", &subject, &ctx);
+	fmt_output_subject(filename, subject.buf, info);
+	strbuf_release(&subject);
 }
 
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
@@ -390,8 +396,7 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 		if (opt->numbered_files)
 			strbuf_addf(&filename, "%d", opt->nr);
 		else
-			get_patch_filename(&filename, commit, NULL,
-					   opt);
+			fmt_output_commit(&filename, commit, opt);
 		snprintf(buffer, sizeof(buffer) - 1,
 			 "\n--%s%s\n"
 			 "Content-Type: text/x-patch;"
diff --git a/log-tree.h b/log-tree.h
index c6a944a..9140f48 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -21,8 +21,7 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 void load_ref_decorations(int flags);
 
 #define FORMAT_PATCH_NAME_MAX 64
-void get_patch_filename(struct strbuf *buf,
-			struct commit *commit, const char *subject,
-			struct rev_info *);
+void fmt_output_commit(struct strbuf *, struct commit *, struct rev_info *);
+void fmt_output_subject(struct strbuf *, const char *subject, struct rev_info *);
 
 #endif
-- 
1.8.0.6.gd28b5d4.dirty
