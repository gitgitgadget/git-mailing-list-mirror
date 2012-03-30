From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] commit: rephrase the error when user did not touch
 templated log message
Date: Fri, 30 Mar 2012 12:45:19 -0700
Message-ID: <1333136719-12657-4-git-send-email-gitster@pobox.com>
References: <7vaa2ylzrm.fsf@alter.siamese.dyndns.org>
 <1333136719-12657-1-git-send-email-gitster@pobox.com>
Cc: Adam Monsen <haircut@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 21:45:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDhlR-0002lI-SN
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 21:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761306Ab2C3Tpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 15:45:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56012 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761001Ab2C3Tpa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 15:45:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74E67343F;
	Fri, 30 Mar 2012 15:45:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=/NXn
	2PSD+Muh2ng4rgKv5F3dG1Q=; b=LiGmiWrQHYjcGp0bb8Ng7EcbvmXfqOziOOus
	MrlrnL9HFjDY2m2Dw+p57kGJXwa/ePC8JSHs6fqiDGjlEbdDCciWNW+hyaMJE6zF
	eixx0o/fES95a7GCb4N+z8/EMApq/MtlV60AYdgEPUcbBJe7h+rdQbEHUU+0dF4I
	rs/7Yrg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	FH7EFPS4SPASlGlV6uzfETnhB5sEgl1hNfcAXyzT/XG4SEkrV6M5NlXi0Mnp7tw/
	ZSqtENqKVom48qEG8gvjFCPNUkixFDQRbb/F8KcmBxdnSxV30bFdsWYQbyCwfHjv
	YKfKHz3gz0HZnwDXmYrihMOtlSjMltpm6KsVzLt0bvw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BB86343E;
	Fri, 30 Mar 2012 15:45:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B04343438; Fri, 30 Mar 2012
 15:45:28 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.rc3.55.g06e99
In-Reply-To: <1333136719-12657-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E7094724-7AA0-11E1-ADDE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194389>

When the user exited editor without editing the commit log template given
by "git commit -t <template>", the commit was aborted (correct) with an
error message that said "due to empty commit message" (incorrect).

This was because the original template support was done by piggybacking on
the check to detect an empty log message.  Split the codepaths into two
independent checks to clarify the error.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c  |   60 ++++++++++++++++++++++++++++++++++++-----------------
 t/t7501-commit.sh |    6 ++++++
 2 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 7141766..847d363 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -899,27 +899,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	return 1;
 }
 
-/*
- * Find out if the message in the strbuf contains only whitespace and
- * Signed-off-by lines.
- */
-static int message_is_empty(struct strbuf *sb)
+static int rest_is_empty(struct strbuf *sb, int start)
 {
-	struct strbuf tmpl = STRBUF_INIT;
+	int i, eol;
 	const char *nl;
-	int eol, i, start = 0;
-
-	if (cleanup_mode == CLEANUP_NONE && sb->len)
-		return 0;
-
-	/* See if the template is just a prefix of the message. */
-	if (template_file && strbuf_read_file(&tmpl, template_file, 0) > 0) {
-		stripspace(&tmpl, cleanup_mode == CLEANUP_ALL);
-		if (start + tmpl.len <= sb->len &&
-		    memcmp(tmpl.buf, sb->buf + start, tmpl.len) == 0)
-			start += tmpl.len;
-	}
-	strbuf_release(&tmpl);
 
 	/* Check if the rest is just whitespace and Signed-of-by's. */
 	for (i = start; i < sb->len; i++) {
@@ -942,6 +925,40 @@ static int message_is_empty(struct strbuf *sb)
 	return 1;
 }
 
+/*
+ * Find out if the message in the strbuf contains only whitespace and
+ * Signed-off-by lines.
+ */
+static int message_is_empty(struct strbuf *sb)
+{
+	if (cleanup_mode == CLEANUP_NONE && sb->len)
+		return 0;
+	return rest_is_empty(sb, 0);
+}
+
+/*
+ * See if the user edited the message in the editor or left what
+ * was in the template intact
+ */
+static int template_untouched(struct strbuf *sb)
+{
+	struct strbuf tmpl = STRBUF_INIT;
+	char *start;
+
+	if (cleanup_mode == CLEANUP_NONE && sb->len)
+		return 0;
+
+	if (!template_file || strbuf_read_file(&tmpl, template_file, 0) <= 0)
+		return 0;
+
+	stripspace(&tmpl, cleanup_mode == CLEANUP_ALL);
+	start = (char *)skip_prefix(sb->buf, tmpl.buf);
+	if (!start)
+		start = sb->buf;
+	strbuf_release(&tmpl);
+	return rest_is_empty(sb, start - sb->buf);
+}
+
 static const char *find_author_by_nickname(const char *name)
 {
 	struct rev_info revs;
@@ -1490,6 +1507,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	if (cleanup_mode != CLEANUP_NONE)
 		stripspace(&sb, cleanup_mode == CLEANUP_ALL);
+	if (template_untouched(&sb) && !allow_empty_message) {
+		rollback_index_files();
+		fprintf(stderr, _("Aborting commit; you did not edit the message.\n"));
+		exit(1);
+	}
 	if (message_is_empty(&sb) && !allow_empty_message) {
 		rollback_index_files();
 		fprintf(stderr, _("Aborting commit due to empty commit message.\n"));
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index e59cc4e..b20ca0e 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -86,6 +86,12 @@ test_expect_success 'template "emptyness" check does not kick in with -F' '
 	git commit -t file -F file
 '
 
+test_expect_success 'template "emptyness" check' '
+	git checkout HEAD file && echo >>file && git add file &&
+	test_must_fail git commit -t file 2>err &&
+	test_i18ngrep "did not edit" err
+'
+
 test_expect_success 'setup: commit message from file' '
 	git checkout HEAD file && echo >>file && git add file &&
 	echo this is the commit message, coming from a file >msg &&
-- 
1.7.10.rc3.55.g06e99
