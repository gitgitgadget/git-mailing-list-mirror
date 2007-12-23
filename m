From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] builtin-commit: avoid double-negation in the code.
Date: Sat, 22 Dec 2007 19:55:35 -0800
Message-ID: <1198382136-15724-3-git-send-email-gitster@pobox.com>
References: <1198382136-15724-1-git-send-email-gitster@pobox.com>
 <1198382136-15724-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 23 04:56:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6Hwy-0008FK-Py
	for gcvg-git-2@gmane.org; Sun, 23 Dec 2007 04:56:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754711AbXLWDz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 22:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754660AbXLWDzz
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 22:55:55 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45734 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754702AbXLWDzy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 22:55:54 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 592312592;
	Sat, 22 Dec 2007 22:55:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BEF452591;
	Sat, 22 Dec 2007 22:55:52 -0500 (EST)
X-Mailer: git-send-email 1.5.4.rc1.19.g9151fa
In-Reply-To: <1198382136-15724-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69167>

The flag no_edit meant "we have got final message from the user
and will not editing it any further", but there were quite a few
places that needed to check !no_edit.  Rename the variable to
use_editor and reverse the logic everywhere.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-commit.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index d8f0dfd..200eb9d 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -48,7 +48,7 @@ static char *edit_message, *use_message;
 static int all, edit_flag, also, interactive, only, amend, signoff;
 static int quiet, verbose, untracked_files, no_verify, allow_empty;
 
-static int no_edit, initial_commit, in_merge;
+static int use_editor = 1, initial_commit, in_merge;
 const char *only_include_assumed;
 struct strbuf message;
 
@@ -372,7 +372,7 @@ static int prepare_log_message(const char *index_file, const char *prefix)
 
 	strbuf_release(&sb);
 
-	if (no_edit) {
+	if (!use_editor) {
 		struct rev_info rev;
 		unsigned char sha1[20];
 		const char *parent = "HEAD";
@@ -398,7 +398,7 @@ static int prepare_log_message(const char *index_file, const char *prefix)
 		return !!DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES);
 	}
 
-	if (in_merge && !no_edit)
+	if (in_merge)
 		fprintf(fp,
 			"#\n"
 			"# It looks like you may be committing a MERGE.\n"
@@ -513,9 +513,9 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	argc = parse_options(argc, argv, builtin_commit_options, usage, 0);
 
 	if (logfile || message.len || use_message)
-		no_edit = 1;
+		use_editor = 0;
 	if (edit_flag)
-		no_edit = 0;
+		use_editor = 1;
 
 	if (get_sha1("HEAD", head_sha1))
 		initial_commit = 1;
@@ -796,7 +796,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	/* Get the commit message and validate it */
 	header_len = sb.len;
-	if (!no_edit) {
+	if (use_editor) {
 		char index[PATH_MAX];
 		const char *env[2] = { index, NULL };
 		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
-- 
1.5.4.rc1.19.g9151fa
