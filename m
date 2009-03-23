From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv3 3/6] format-patch: pass a commit to reopen_stdout()
Date: Sun, 22 Mar 2009 19:14:03 -0700
Message-ID: <00c4e51c2ff7786be6aedb4a451b8d1ff269d7b3.1237773604.git.bebarino@gmail.com>
References: <1237696363-6819-1-git-send-email-bebarino@gmail.com>
 <cover.1237773604.git.bebarino@gmail.com>
 <baa327d88b54efae40b6d9df09a2fe482672101e.1237773604.git.bebarino@gmail.com>
 <616420f398701fafc45b5d5cebb1371534f88caa.1237773604.git.bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 03:16:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlZhw-0000lE-Dw
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 03:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262AbZCWCOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 22:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754072AbZCWCOV
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 22:14:21 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:23531 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448AbZCWCOU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 22:14:20 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1537512rvb.1
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 19:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=wWaDA873tOOGzzXUHhgBht4EkPn5xBZ6hKqXkLeVjFE=;
        b=pKkrU3R+BSoBs3E9a+3SVUWk0gv+YKNf50rkEBmpVKVOTKZHxtARG51ZMhComrkwL3
         YnkQyuwLRbCB/60oFAxgAL0e2X4YWSwYZ73QK3qqQCdMOTT+egbGIhXLIpghY6ybxm2j
         tKmbNDsy/SeyU1W0E8xlgWbJfpVjOfKMOxjo0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AJ2thDGL1QKspd0rPX++75IRanXdGiHuu6yvISY5YKEbMuCfsKvWudZscrnPcxfg56
         Stp7XsebiCs1SkuLrLoOWujxnerrM6qGgWNcX2vhKkIMJZbiVU5A8i0A3ohrmRJtxYg1
         c+liYeeWUqMLVe9wLQD6m4xieLp1VGp4BNec0=
Received: by 10.114.59.1 with SMTP id h1mr4440710waa.87.1237774458575;
        Sun, 22 Mar 2009 19:14:18 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id n6sm4855294wag.32.2009.03.22.19.14.16
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 22 Mar 2009 19:14:18 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sun, 22 Mar 2009 19:14:15 -0700
X-Mailer: git-send-email 1.6.2
In-Reply-To: <616420f398701fafc45b5d5cebb1371534f88caa.1237773604.git.bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114229>

We use the commit to generate the patch filename in reopen_stdout()
before we redirect stdout. The cover letter codepath creates a dummy
commit with the desired subject line 'cover letter'.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 builtin-log.c |   68 +++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 54ef248..392b16a 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -540,30 +540,29 @@ static FILE *realstdout = NULL;
 static const char *output_directory = NULL;
 static int outdir_offset;
 
-static int reopen_stdout(const char *oneline, struct rev_info *rev)
+static int reopen_stdout(struct commit *commit, struct rev_info *rev)
 {
-	char filename[PATH_MAX];
-	int len = 0;
+	struct strbuf filename = STRBUF_INIT;
 	int suffix_len = strlen(fmt_patch_suffix) + 1;
 
 	if (output_directory) {
-		len = snprintf(filename, sizeof(filename), "%s",
-				output_directory);
-		if (len >=
-		    sizeof(filename) - FORMAT_PATCH_NAME_MAX - suffix_len)
+		strbuf_addstr(&filename, output_directory);
+		if (filename.len >=
+		    PATH_MAX - FORMAT_PATCH_NAME_MAX - suffix_len)
 			return error("name of output directory is too long");
-		if (filename[len - 1] != '/')
-			filename[len++] = '/';
+		if (filename.buf[filename.len - 1] != '/')
+			strbuf_addch(&filename, '/');
 	}
 
-	strncpy(filename + len, oneline, PATH_MAX - len);
+	get_patch_filename(commit, rev->nr, fmt_patch_suffix, &filename);
 
 	if (!DIFF_OPT_TST(&rev->diffopt, QUIET))
-		fprintf(realstdout, "%s\n", filename + outdir_offset);
+		fprintf(realstdout, "%s\n", filename.buf + outdir_offset);
 
-	if (freopen(filename, "w", stdout) == NULL)
-		return error("Cannot open patch file %s",filename);
+	if (freopen(filename.buf, "w", stdout) == NULL)
+		return error("Cannot open patch file %s", filename.buf);
 
+	strbuf_release(&filename);
 	return 0;
 }
 
@@ -644,26 +643,43 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	const char *encoding = "utf-8";
 	struct diff_options opts;
 	int need_8bit_cte = 0;
-	char filename[PATH_MAX];
+	struct commit *commit = NULL;
 
 	if (rev->commit_format != CMIT_FMT_EMAIL)
 		die("Cover letter needs email format");
 
-	if (numbered_files)
-	    sprintf(filename, "0");
-	else
-	    sprintf(filename, "%04d-cover-letter%s", 0, fmt_patch_suffix);
+	committer = git_committer_info(0);
+	head_sha1 = sha1_to_hex(head->object.sha1);
+
+	if (!numbered_files)
+	{
+		/*
+		 * We fake a commit for the cover letter so we get the filename
+		 * desired.
+		 */
+		commit = xcalloc(1, sizeof(*commit));
+		commit->buffer = xmalloc(400);
+		snprintf(commit->buffer, 400,
+			"tree 0000000000000000000000000000000000000000\n"
+			"parent %s\n"
+			"author %s\n"
+			"committer %s\n\n"
+			"cover letter\n",
+			head_sha1, committer, committer);
+	}
 
-	if (!use_stdout && reopen_stdout(filename, rev))
+	if (!use_stdout && reopen_stdout(commit, rev))
 		return;
 
-	head_sha1 = sha1_to_hex(head->object.sha1);
+	if (commit)
+	{
+		free(commit->buffer);
+		free(commit);
+	}
 
 	log_write_email_headers(rev, head_sha1, &subject_start, &extra_headers,
 				&need_8bit_cte);
 
-	committer = git_committer_info(0);
-
 	msg = body;
 	pp_user_info(NULL, CMIT_FMT_EMAIL, &sb, committer, DATE_RFC2822,
 		     encoding);
@@ -767,7 +783,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct patch_ids ids;
 	char *add_signoff = NULL;
 	struct strbuf buf = STRBUF_INIT;
-	struct strbuf patch_filename = STRBUF_INIT;
 
 	git_config(git_format_config, NULL);
 	init_revisions(&rev, prefix);
@@ -1071,11 +1086,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			gen_message_id(&rev, sha1_to_hex(commit->object.sha1));
 		}
 
-		get_patch_filename(numbered_files ? NULL : commit, rev.nr,
-				    fmt_patch_suffix, &patch_filename);
-		if (!use_stdout && reopen_stdout(patch_filename.buf, &rev))
+		if (!use_stdout && reopen_stdout(numbered_files ? NULL : commit,
+						 &rev))
 			die("Failed to create output files");
-		strbuf_setlen(&patch_filename, 0);
 		shown = log_tree_commit(&rev, commit);
 		free(commit->buffer);
 		commit->buffer = NULL;
@@ -1099,7 +1112,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (!use_stdout)
 			fclose(stdout);
 	}
-	strbuf_release(&patch_filename);
 	free(list);
 	if (ignore_if_in_upstream)
 		free_patch_ids(&ids);
-- 
1.6.2
