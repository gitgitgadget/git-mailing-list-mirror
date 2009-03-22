From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2 1/3] format-patch: create patch filename in one function
Date: Sat, 21 Mar 2009 21:32:41 -0700
Message-ID: <1237696363-6819-2-git-send-email-bebarino@gmail.com>
References: <1237696363-6819-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 05:34:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlFO7-00045r-0t
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 05:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbZCVEcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 00:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbZCVEcw
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 00:32:52 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:48019 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbZCVEcv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 00:32:51 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1648808ywb.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2009 21:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=/FU6VBzeOMQliX8Hx5BkTjMpnWGwj1Q1k2oEGjHpRQo=;
        b=deMLkBYDl3Pz7nsDlPqdgmMHRRAvofO5PZmeY5B5xCw6Rr7d1SFqRpTgMvb2EtfYF3
         3a19N55zphovQ051MCIG9cHLNpt4g4lJ6rhnrDpRMOFYTLX5Yg9Fq/uHgDsk9LdFrtIn
         saz24dYMGKF1Skfp1RD+iewMW8j63DtnUWWh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WoP3Gk4WsC3A8By/t5txwbSMk8tYB2ELybpi7VDCgpW79jNlx7ahwsk1OYgFLbkL5+
         eVYX21EQE0nTjW9MuHH1rf9wpsEHuEgfg/aUHjSr61cH6JgpiWBSeQuQ8iWGmproHb0R
         ztgcmYNHwekOjZV1zNl/QaLc7Q5u/NInnbt70=
Received: by 10.143.42.6 with SMTP id u6mr2235805wfj.121.1237696368929;
        Sat, 21 Mar 2009 21:32:48 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id 22sm8336072wfi.21.2009.03.21.21.32.47
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 21 Mar 2009 21:32:48 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sat, 21 Mar 2009 21:32:46 -0700
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1237696363-6819-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114113>

reopen_stdout() usually takes the oneline description of a commit,
appends the patch suffix, prepends the output directory (if any) and
then reopens stdout as the resulting file. Now the patch filename (the
oneline description and the patch suffix) is created in
get_patch_filename() and passed to reopen_stdout() which prepends the
output directory and reopens stdout as that file.

The original function to get the oneline description,
get_oneline_for_filename(), has been renamed to get_patch_filename() to
reflect its new functionality.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 builtin-log.c |   49 +++++++++++++++++++++++++------------------------
 1 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 8af55d2..cc6d663 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -519,21 +519,17 @@ static int git_format_config(const char *var, const char *value, void *cb)
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
+		len += sprintf(filename, "%04d-", nr);
 		/* strip [PATCH] or [PATCH blabla] */
 		if (!keep_subject && !prefixcmp(sol, "[PATCH")) {
 			char *eos = strchr(sol + 6, ']');
@@ -564,8 +560,11 @@ static const char *get_oneline_for_filename(struct commit *commit,
 		while (filename[len - 1] == '.'
 		       || filename[len - 1] == '-')
 			len--;
-		filename[len] = '\0';
+		strcpy(filename + len, fmt_patch_suffix);
 	}
+	else
+		sprintf(filename, "%d", nr);
+
 	return filename;
 }
 
@@ -573,7 +572,7 @@ static FILE *realstdout = NULL;
 static const char *output_directory = NULL;
 static int outdir_offset;
 
-static int reopen_stdout(const char *oneline, int nr, struct rev_info *rev)
+static int reopen_stdout(const char *oneline, struct rev_info *rev)
 {
 	char filename[PATH_MAX];
 	int len = 0;
@@ -588,15 +587,7 @@ static int reopen_stdout(const char *oneline, int nr, struct rev_info *rev)
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
+	strncpy(filename+len, oneline, PATH_MAX-len-1);
 
 	if (!DIFF_OPT_TST(&rev->diffopt, QUIET))
 		fprintf(realstdout, "%s\n", filename + outdir_offset);
@@ -688,8 +679,9 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	if (rev->commit_format != CMIT_FMT_EMAIL)
 		die("Cover letter needs email format");
 
-	if (!use_stdout && reopen_stdout(numbered_files ?
-				NULL : "cover-letter", 0, rev))
+	if (!use_stdout && reopen_stdout(get_patch_filename(numbered_files ?
+							NULL : "cover-letter",
+							0, 0), rev))
 		return;
 
 	head_sha1 = sha1_to_hex(head->object.sha1);
@@ -802,6 +794,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct patch_ids ids;
 	char *add_signoff = NULL;
 	struct strbuf buf = STRBUF_INIT;
+	char *sol = NULL;
 
 	git_config(git_format_config, NULL);
 	init_revisions(&rev, prefix);
@@ -1106,9 +1099,17 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			}
 			gen_message_id(&rev, sha1_to_hex(commit->object.sha1));
 		}
-		if (!use_stdout && reopen_stdout(numbered_files ? NULL :
-				get_oneline_for_filename(commit, keep_subject),
-				rev.nr, &rev))
+		/*
+		 * If we're outputting numbered files we don't need a subject
+		 * line. Otherwise we want the subject line of the commit
+		 * message which starts after the first double newline
+		 * occurence in the commit buffer.
+		 */
+		if (!numbered_files && (sol = strstr(commit->buffer, "\n\n")))
+			sol += 2;
+		if (!use_stdout && reopen_stdout(get_patch_filename(sol,
+								keep_subject,
+								rev.nr), &rev))
 			die("Failed to create output files");
 		shown = log_tree_commit(&rev, commit);
 		free(commit->buffer);
-- 
1.6.2
