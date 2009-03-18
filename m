From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 2/3] format-patch: create patch filename in 
	get_patch_filename()
Date: Wed, 18 Mar 2009 12:51:21 -0700
Message-ID: <780e0a6b0903181251l4bc1964exf91c4ae045214dc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 20:53:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk1pP-0007aw-78
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 20:53:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbZCRTvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 15:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752402AbZCRTvY
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 15:51:24 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:35113 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355AbZCRTvX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 15:51:23 -0400
Received: by wf-out-1314.google.com with SMTP id 29so227695wff.4
        for <git@vger.kernel.org>; Wed, 18 Mar 2009 12:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=wk9rc9DazCPc86RKJzUxXi9JaNBMe5pU+QRcdWyKcmw=;
        b=U4zXvYLt3UW3Ti6QSoz0Z4dy8Gix8wJDXH2TT3PauQkmgIqKkygC5y2msBGH9oMQ3c
         +R0XiazpspNHmnFiSKiVVu90N4mQYFgSSlkBGznCD022yC/gUkr0xVyLsR65rhJLdFBm
         j8YUVl6ObNv/IjY0Qsyj0ZsNEyZnsdGIXlvmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=E6/iiw8eUWg+/ef9Qz1qth+A0DT53+8mOfBX+UgOKk3KgBna0ggVODIPOaXy8IhTbL
         OnAYGdyAgpWPzc70XWP3ZqpLr6MewEaOWdpA53FpP0/W3Ru4QYAEsyrY0sXI3yslAsMD
         FBHkgsspjNHlAlmcsZ46ZTFpyX4SgPoQ8hmF8=
Received: by 10.142.156.19 with SMTP id d19mr683664wfe.6.1237405881791; Wed, 
	18 Mar 2009 12:51:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113655>

reopen_stdout() used to take the oneline description of a commit, append
the patch suffix, prepend the output directory (if any) and then point
stdout to that file. Now the patch filename (the oneline description and
the patch suffix) is created in get_patch_filename() and passed to
reopen_stdout()

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 builtin-log.c |   48 ++++++++++++++++++++++++------------------------
 1 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index c72e35a..f2a687f 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -519,21 +519,17 @@ static int git_format_config(const char *var,
const char *value, void *cb)
 }


-static const char *get_oneline_for_filename(struct commit *commit,
-					    int keep_subject)
+static const char *get_patch_filename(char* sol, int keep_subject, int nr)
 {
 	static char filename[PATH_MAX];
-	char *sol;
 	int len = 0;
 	int suffix_len = strlen(fmt_patch_suffix) + 1;

-	sol = strstr(commit->buffer, "\n\n");
-	if (!sol)
-		filename[0] = '\0';
-	else {
+	if (sol)
+	{
 		int j, space = 0;

-		sol += 2;
+		len += sprintf(filename + len, "%04d-", nr);
 		/* strip [PATCH] or [PATCH blabla] */
 		if (!keep_subject && !prefixcmp(sol, "[PATCH")) {
 			char *eos = strchr(sol + 6, ']');
@@ -564,8 +560,11 @@ static const char
*get_oneline_for_filename(struct commit *commit,
 		while (filename[len - 1] == '.'
 		       || filename[len - 1] == '-')
 			len--;
-		filename[len] = '\0';
 	}
+	else
+		len += sprintf(filename + len, "%d", nr);
+	strcpy(filename + len, fmt_patch_suffix);
+
 	return filename;
 }

@@ -573,7 +572,7 @@ static FILE *realstdout = NULL;
 static const char *output_directory = NULL;
 static int outdir_offset;

-static int reopen_stdout(const char *oneline, int nr)
+static int reopen_stdout(const char *oneline)
 {
 	char filename[PATH_MAX];
 	int len = 0;
@@ -588,15 +587,7 @@ static int reopen_stdout(const char *oneline, int nr)
 		if (filename[len - 1] != '/')
 			filename[len++] = '/';
 	}
-
-	if (!oneline)
-		len += sprintf(filename + len, "%d", nr);
-	else {
-		len += sprintf(filename + len, "%04d-", nr);
-		len += snprintf(filename + len, sizeof(filename) - len - 1
-				- suffix_len, "%s", oneline);
-		strcpy(filename + len, fmt_patch_suffix);
-	}
+	strncpy(filename+len, oneline, PATH_MAX-len);

 	fprintf(realstdout, "%s\n", filename + outdir_offset);
 	if (freopen(filename, "w", stdout) == NULL)
@@ -686,8 +677,9 @@ static void make_cover_letter(struct rev_info
*rev, int use_stdout,
 	if (rev->commit_format != CMIT_FMT_EMAIL)
 		die("Cover letter needs email format");

-	if (!use_stdout && reopen_stdout(numbered_files ?
-				NULL : "cover-letter", 0))
+	if (!use_stdout && reopen_stdout(get_patch_filename(numbered_files ?
+							NULL : "cover-letter",
+							0, 0)))
 		return;

 	head_sha1 = sha1_to_hex(head->object.sha1);
@@ -800,6 +792,7 @@ int cmd_format_patch(int argc, const char **argv,
const char *prefix)
 	struct patch_ids ids;
 	char *add_signoff = NULL;
 	struct strbuf buf = STRBUF_INIT;
+	char *sol = NULL;

 	git_config(git_format_config, NULL);
 	init_revisions(&rev, prefix);
@@ -1104,9 +1097,16 @@ int cmd_format_patch(int argc, const char
**argv, const char *prefix)
 			}
 			gen_message_id(&rev, sha1_to_hex(commit->object.sha1));
 		}
-		if (!use_stdout && reopen_stdout(numbered_files ? NULL :
-				get_oneline_for_filename(commit, keep_subject),
-				rev.nr))
+		/*
+		 * We want the subject line of the commit message which starts
+		 * after the first double newline occurence in the commit
+		 * buffer. If we're outputting numbered files we don't need a
+		 * subject line.
+		 */
+		sol = numbered_files ? NULL : strstr(commit->buffer, "\n\n")+2;
+		if (!use_stdout && reopen_stdout(get_patch_filename(sol,
+								keep_subject,
+								rev.nr)))
 			die("Failed to create output files");
 		shown = log_tree_commit(&rev, commit);
 		free(commit->buffer);
-- 
1.6.2
