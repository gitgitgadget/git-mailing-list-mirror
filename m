From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv3 2/6] format-patch: construct patch filename in one function
Date: Sun, 22 Mar 2009 19:14:02 -0700
Message-ID: <616420f398701fafc45b5d5cebb1371534f88caa.1237773604.git.bebarino@gmail.com>
References: <1237696363-6819-1-git-send-email-bebarino@gmail.com>
 <cover.1237773604.git.bebarino@gmail.com>
 <baa327d88b54efae40b6d9df09a2fe482672101e.1237773604.git.bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 03:16:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlZhv-0000lE-OO
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 03:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661AbZCWCOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 22:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753448AbZCWCOS
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 22:14:18 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:27585 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122AbZCWCOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 22:14:16 -0400
Received: by rv-out-0506.google.com with SMTP id g37so848045rvb.5
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 19:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=VSbaE+d0L5NUD32v6WAkfECuu4bvLaj+gDQ2NegAEIw=;
        b=ZUqKLKX0/nGAh3rHNoCM9cRmVEZIf2K666A4sJjJfDjh7ZcDZ/lEdw8CJXG3u8NHLR
         TmSyDfL6vNVm265b/ApPcFldAPxlNuhssDEIzUEMzD0D4Bb8b/93mjTTjV6znA9PYDjp
         6M5Zpp8+GNcswAs4zmC8lTf2B5PFHNr+/SAyo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Yn/5tm/DpwJnped3PgyfhFfy/1kFdq5acvL5xG8AZTau2FBdhr6vu0GXep8LT0uO1M
         fA/8K3HwDg6pBglkDgZ/zsEal14T1zqoLy3gXwlll1Qf0bS23rPVYwv6ZXuVPmTuYK6D
         uwyiVZHmT8Ro12B4r7LsE+BPvIIMj4bjp+sA8=
Received: by 10.140.199.15 with SMTP id w15mr2023930rvf.26.1237774454880;
        Sun, 22 Mar 2009 19:14:14 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id f42sm9212215rvb.21.2009.03.22.19.14.13
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 22 Mar 2009 19:14:14 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sun, 22 Mar 2009 19:14:12 -0700
X-Mailer: git-send-email 1.6.2
In-Reply-To: <baa327d88b54efae40b6d9df09a2fe482672101e.1237773604.git.bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114230>

reopen_stdout() usually takes the oneline subject of a commit,
appends the patch suffix, prepends the output directory (if any) and
then reopens stdout as the resulting file. Now the patch filename (the
oneline subject and the patch suffix) is created in
get_patch_filename() and passed to reopen_stdout() which prepends the
output directory and reopens stdout as that file.

The original function to get the oneline description,
get_oneline_for_filename(), has been renamed to get_patch_filename() to
reflect its new functionality.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 builtin-log.c |   99 +++++++++++++++++++-------------------------------------
 1 files changed, 34 insertions(+), 65 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index c7a5772..54ef248 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -419,12 +419,6 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 /* format-patch */
 #define FORMAT_PATCH_NAME_MAX 64
 
-static int istitlechar(char c)
-{
-	return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') ||
-		(c >= '0' && c <= '9') || c == '.' || c == '_';
-}
-
 static const char *fmt_patch_suffix = ".patch";
 static int numbered = 0;
 static int auto_number = 1;
@@ -519,61 +513,34 @@ static int git_format_config(const char *var, const char *value, void *cb)
 }
 
 
-static const char *get_oneline_for_filename(struct commit *commit,
-					    int keep_subject)
+static void get_patch_filename(struct commit *commit, int nr,
+			       const char *suffix, struct strbuf *buf)
 {
-	static char filename[PATH_MAX];
-	char *sol;
-	int len = 0;
-	int suffix_len = strlen(fmt_patch_suffix) + 1;
-
-	sol = strstr(commit->buffer, "\n\n");
-	if (!sol)
-		filename[0] = '\0';
-	else {
-		int j, space = 0;
-
-		sol += 2;
-		/* strip [PATCH] or [PATCH blabla] */
-		if (!keep_subject && !prefixcmp(sol, "[PATCH")) {
-			char *eos = strchr(sol + 6, ']');
-			if (eos) {
-				while (isspace(*eos))
-					eos++;
-				sol = eos;
-			}
-		}
+	int suffix_len = strlen(suffix) + 1;
+	int start_len = buf->len;
 
-		for (j = 0;
-		     j < FORMAT_PATCH_NAME_MAX - suffix_len - 5 &&
-			     len < sizeof(filename) - suffix_len &&
-			     sol[j] && sol[j] != '\n';
-		     j++) {
-			if (istitlechar(sol[j])) {
-				if (space) {
-					filename[len++] = '-';
-					space = 0;
-				}
-				filename[len++] = sol[j];
-				if (sol[j] == '.')
-					while (sol[j + 1] == '.')
-						j++;
-			} else
-				space = 1;
-		}
-		while (filename[len - 1] == '.'
-		       || filename[len - 1] == '-')
-			len--;
-		filename[len] = '\0';
+	strbuf_addf(buf, commit ? "%04d-" : "%d", nr);
+	if (commit)
+	{
+		format_commit_message(commit, "%f", buf, DATE_NORMAL);
+		/*
+		 * Replace characters at the end with the suffix if the the
+		 * filename is too long
+		 */
+		if (buf->len + suffix_len > FORMAT_PATCH_NAME_MAX + start_len)
+			strbuf_splice(buf,
+				start_len + FORMAT_PATCH_NAME_MAX - suffix_len,
+				suffix_len, suffix, suffix_len);
+		else
+			strbuf_addstr(buf, suffix);
 	}
-	return filename;
 }
 
 static FILE *realstdout = NULL;
 static const char *output_directory = NULL;
 static int outdir_offset;
 
-static int reopen_stdout(const char *oneline, int nr, struct rev_info *rev)
+static int reopen_stdout(const char *oneline, struct rev_info *rev)
 {
 	char filename[PATH_MAX];
 	int len = 0;
@@ -589,14 +556,7 @@ static int reopen_stdout(const char *oneline, int nr, struct rev_info *rev)
 			filename[len++] = '/';
 	}
 
-	if (!oneline)
-		len += sprintf(filename + len, "%d", nr);
-	else {
-		len += sprintf(filename + len, "%04d-", nr);
-		len += snprintf(filename + len, sizeof(filename) - len - 1
-				- suffix_len, "%s", oneline);
-		strcpy(filename + len, fmt_patch_suffix);
-	}
+	strncpy(filename + len, oneline, PATH_MAX - len);
 
 	if (!DIFF_OPT_TST(&rev->diffopt, QUIET))
 		fprintf(realstdout, "%s\n", filename + outdir_offset);
@@ -684,12 +644,17 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	const char *encoding = "utf-8";
 	struct diff_options opts;
 	int need_8bit_cte = 0;
+	char filename[PATH_MAX];
 
 	if (rev->commit_format != CMIT_FMT_EMAIL)
 		die("Cover letter needs email format");
 
-	if (!use_stdout && reopen_stdout(numbered_files ?
-				NULL : "cover-letter", 0, rev))
+	if (numbered_files)
+	    sprintf(filename, "0");
+	else
+	    sprintf(filename, "%04d-cover-letter%s", 0, fmt_patch_suffix);
+
+	if (!use_stdout && reopen_stdout(filename, rev))
 		return;
 
 	head_sha1 = sha1_to_hex(head->object.sha1);
@@ -802,6 +767,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct patch_ids ids;
 	char *add_signoff = NULL;
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf patch_filename = STRBUF_INIT;
 
 	git_config(git_format_config, NULL);
 	init_revisions(&rev, prefix);
@@ -1104,10 +1070,12 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			}
 			gen_message_id(&rev, sha1_to_hex(commit->object.sha1));
 		}
-		if (!use_stdout && reopen_stdout(numbered_files ? NULL :
-				get_oneline_for_filename(commit, keep_subject),
-				rev.nr, &rev))
+
+		get_patch_filename(numbered_files ? NULL : commit, rev.nr,
+				    fmt_patch_suffix, &patch_filename);
+		if (!use_stdout && reopen_stdout(patch_filename.buf, &rev))
 			die("Failed to create output files");
+		strbuf_setlen(&patch_filename, 0);
 		shown = log_tree_commit(&rev, commit);
 		free(commit->buffer);
 		commit->buffer = NULL;
@@ -1131,6 +1099,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (!use_stdout)
 			fclose(stdout);
 	}
+	strbuf_release(&patch_filename);
 	free(list);
 	if (ignore_if_in_upstream)
 		free_patch_ids(&ids);
-- 
1.6.2
