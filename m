From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/7] get_patch_filename(): drop "just-numbers" hack
Date: Sat, 22 Dec 2012 00:33:30 -0800
Message-ID: <1356165212-5611-6-git-send-email-gitster@pobox.com>
References: <1356165212-5611-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 22 09:34:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmKX9-00086k-Bw
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 09:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317Ab2LVIdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 03:33:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64929 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751060Ab2LVIdp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 03:33:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A58D828E
	for <git@vger.kernel.org>; Sat, 22 Dec 2012 03:33:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=T0Nu
	GUp64BLYZcZYnWLaNnGRl/g=; b=q2iWr/+U++qNvQcwhQ5OSv83jRK4mF+pq0Lp
	g+gKTVuueyRE9rEKVvdBf0h6Lj03vScfqaMV988JuWjA35egfsiKqxIXO2TUypv8
	XteZ1eXiLyy3lifYD68RdWlOlcsi/aR7XSJ/SpP3QpmjNgmJk6b4OcIPluEBVm1B
	6EWGEZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=xLYoEK
	5SvmkmtINhKsCru/NnfIDHJ5/VsXc9WJL3jj5H0YlCpv8LwlADMgBkyQL981/hgy
	E0Bkf+JiJd6EjKvxH/40QK5aHybHGAvzYkRP8vZGyxf068qVdwgQMjGVNC5ZE7/8
	IGuDKJplg+RmxFuvuBkqlXgjNIh34OpUq5XOI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8762F828D
	for <git@vger.kernel.org>; Sat, 22 Dec 2012 03:33:44 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D764B828C for
 <git@vger.kernel.org>; Sat, 22 Dec 2012 03:33:43 -0500 (EST)
X-Mailer: git-send-email 1.8.1.rc2.227.g7335c9f
In-Reply-To: <1356165212-5611-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4BC56B32-4C12-11E2-B2D6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212043>

The function chooses from three operating modes (format using the
subject, the commit, or just number) based on NULL-ness of two of
its parameters, which is an ugly hack for sharing only a bit of
code.

Separate out the "just numbers" part out to the callers.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c |  5 ++++-
 log-tree.c    | 29 ++++++++++++++---------------
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index d9946ec..3c6f20a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -684,7 +684,10 @@ static int reopen_stdout(struct commit *commit, const char *subject,
 			strbuf_addch(&filename, '/');
 	}
 
-	get_patch_filename(&filename, commit, subject, rev);
+	if (rev->numbered_files)
+		strbuf_addf(&filename, "%d", rev->nr);
+	else
+		get_patch_filename(&filename, commit, subject, rev);
 
 	if (!quiet)
 		fprintf(realstdout, "%s\n", filename.buf + outdir_offset);
diff --git a/log-tree.c b/log-tree.c
index ceed6b6..d9f86ce 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -307,21 +307,18 @@ void get_patch_filename(struct strbuf *buf,
 	int nr = info->nr;
 	int suffix_len = strlen(suffix) + 1;
 	int start_len = buf->len;
+	int max_len = start_len + FORMAT_PATCH_NAME_MAX - suffix_len;
 
-	strbuf_addf(buf, commit || subject ? "%04d-" : "%d", nr);
-	if (commit || subject) {
-		int max_len = start_len + FORMAT_PATCH_NAME_MAX - suffix_len;
+	strbuf_addf(buf, "%04d-", nr);
+	if (subject)
+		strbuf_addstr(buf, subject);
+	else if (commit) {
 		struct pretty_print_context ctx = {0};
-
-		if (subject)
-			strbuf_addstr(buf, subject);
-		else if (commit)
-			format_commit_message(commit, "%f", buf, &ctx);
-
-		if (max_len < buf->len)
-			strbuf_setlen(buf, max_len);
-		strbuf_addstr(buf, suffix);
+		format_commit_message(commit, "%f", buf, &ctx);
 	}
+	if (max_len < buf->len)
+		strbuf_setlen(buf, max_len);
+	strbuf_addstr(buf, suffix);
 }
 
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
@@ -390,9 +387,11 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			 mime_boundary_leader, opt->mime_boundary);
 		extra_headers = subject_buffer;
 
-		get_patch_filename(&filename,
-				   opt->numbered_files ? NULL : commit, NULL,
-				   opt);
+		if (opt->numbered_files)
+			strbuf_addf(&filename, "%d", opt->nr);
+		else
+			get_patch_filename(&filename, commit, NULL,
+					   opt);
 		snprintf(buffer, sizeof(buffer) - 1,
 			 "\n--%s%s\n"
 			 "Content-Type: text/x-patch;"
-- 
1.8.0.6.gd28b5d4.dirty
