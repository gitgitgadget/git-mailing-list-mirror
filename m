From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/7] get_patch_filename(): simplify function signature
Date: Sat, 22 Dec 2012 00:33:29 -0800
Message-ID: <1356165212-5611-5-git-send-email-gitster@pobox.com>
References: <1356165212-5611-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 22 09:34:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmKX0-0007tg-P8
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 09:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238Ab2LVIdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 03:33:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64892 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751202Ab2LVIdm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 03:33:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F5D2828A
	for <git@vger.kernel.org>; Sat, 22 Dec 2012 03:33:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=zgaA
	q0UfBkshYEm1sQSk6Szh4t8=; b=UZCYXwS+e+5t4LTiPmN89bi85vd+EK2uNeG3
	9l+BeBnsYw88gRcak6+U2ONG3GY6j7dYSFkEXNIR3zWS8eZeU5GuQTwo6aQOo/Qs
	BFgCiIOA02AT9tZM16HeHMcIcvrefPwTScHwbvoPpS0e1eeCIU/Py4Oqwnftku3P
	mn9ZRLg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=SgmI+V
	hSQ5aO6G26gQVmPjU3bvLG60VM93VE7D/QOefIDeX+smYo4kUuEbLaEjGCPKaeyb
	50RJgZAIOYMvrCFKAoOdE+Q485Eb+M6oVNkenCVtx8bvkwXn3858d5Adt43dZq6C
	4+sj2TkHNcTwEyDkUjr8qblDUMGTLrcOQuIDM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DF7E8289
	for <git@vger.kernel.org>; Sat, 22 Dec 2012 03:33:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 943508287 for
 <git@vger.kernel.org>; Sat, 22 Dec 2012 03:33:41 -0500 (EST)
X-Mailer: git-send-email 1.8.1.rc2.227.g7335c9f
In-Reply-To: <1356165212-5611-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4A6A2C3C-4C12-11E2-A9FD-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212038>

Most functions that emit to a strbuf take the strbuf as their first
parameter; make this function follow suit.

The serial number of the patch being emitted (nr) and suffix used
for patch filename (suffix) are both recorded in rev_info; drop
these separate parameters and pass the rev_info directly.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c |  2 +-
 log-tree.c    | 12 ++++++++----
 log-tree.h    |  5 +++--
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 7cf157e..d9946ec 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -684,7 +684,7 @@ static int reopen_stdout(struct commit *commit, const char *subject,
 			strbuf_addch(&filename, '/');
 	}
 
-	get_patch_filename(commit, subject, rev->nr, rev->patch_suffix, &filename);
+	get_patch_filename(&filename, commit, subject, rev);
 
 	if (!quiet)
 		fprintf(realstdout, "%s\n", filename.buf + outdir_offset);
diff --git a/log-tree.c b/log-tree.c
index c894930..ceed6b6 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -299,9 +299,12 @@ static unsigned int digits_in_number(unsigned int number)
 	return result;
 }
 
-void get_patch_filename(struct commit *commit, const char *subject, int nr,
-			const char *suffix, struct strbuf *buf)
+void get_patch_filename(struct strbuf *buf,
+			struct commit *commit, const char *subject,
+			struct rev_info *info)
 {
+	const char *suffix = info->patch_suffix;
+	int nr = info->nr;
 	int suffix_len = strlen(suffix) + 1;
 	int start_len = buf->len;
 
@@ -387,8 +390,9 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			 mime_boundary_leader, opt->mime_boundary);
 		extra_headers = subject_buffer;
 
-		get_patch_filename(opt->numbered_files ? NULL : commit, NULL,
-				   opt->nr, opt->patch_suffix, &filename);
+		get_patch_filename(&filename,
+				   opt->numbered_files ? NULL : commit, NULL,
+				   opt);
 		snprintf(buffer, sizeof(buffer) - 1,
 			 "\n--%s%s\n"
 			 "Content-Type: text/x-patch;"
diff --git a/log-tree.h b/log-tree.h
index f5ac238..c6a944a 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -21,7 +21,8 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 void load_ref_decorations(int flags);
 
 #define FORMAT_PATCH_NAME_MAX 64
-void get_patch_filename(struct commit *commit, const char *subject, int nr,
-			const char *suffix, struct strbuf *buf);
+void get_patch_filename(struct strbuf *buf,
+			struct commit *commit, const char *subject,
+			struct rev_info *);
 
 #endif
-- 
1.8.0.6.gd28b5d4.dirty
