From: Frank Terbeck <ft@bewatermyfriend.org>
Subject: [PATCH 4/6] format-patch: introduce overwritecoverletter option
Date: Sat, 18 Apr 2009 18:16:19 +0200
Message-ID: <1240071381-25165-5-git-send-email-ft@bewatermyfriend.org>
References: <1240071381-25165-1-git-send-email-ft@bewatermyfriend.org>
Cc: Frank Terbeck <ft@bewatermyfriend.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 18:24:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvDKu-0002Kp-Sc
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 18:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757007AbZDRQWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 12:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756512AbZDRQWU
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 12:22:20 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:59842 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbZDRQWT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 12:22:19 -0400
X-Greylist: delayed 322 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Apr 2009 12:22:18 EDT
Received: from [212.117.84.81] (helo=fsst.voodoo.lan)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1LvDDq-0006js-Ka; Sat, 18 Apr 2009 18:16:54 +0200
Received: from hawk by fsst.voodoo.lan with local (Exim 4.69)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1LvDDL-0006Ye-KE; Sat, 18 Apr 2009 18:16:23 +0200
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
In-Reply-To: <1240071381-25165-1-git-send-email-ft@bewatermyfriend.org>
X-Df-Sender: 430444
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116839>

This option, when set, causes a fatal error if format-patch would
overwrite an existing coverletter to avoid information loss if the
letter was already edited before.

This changes the return value of get_patch_filename() from void to int
and its prototype now contains a new integer parameter 'check'. If
'check' is false, get_patch_filename() behaves as it did before and it
will always return zero. If 'check' is true, get_patch_filename() will
use access(3) to check whether the filename it created exists, if so
get_patch_filename() returns 1; zero otherwise.

This access(3) test is only done if the overwritecoverletter option is
unset and reopen_stdout()'s new 'check' parameter is true. That is done
only by make_cover_letter().

The default for overwritecoverletter is true, which means, that the
default behaviour does not change. If overwritecoverletter was unset,
there is the new --cover-overwrite option to temporarily force
overwriting cover letters.

Signed-off-by: Frank Terbeck <ft@bewatermyfriend.org>
---
 builtin-log.c |   24 ++++++++++++++++++++----
 log-tree.c    |    9 ++++++---
 log-tree.h    |    4 ++--
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 82d8724..816b4c9 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -438,6 +438,7 @@ static int extra_cc_alloc;
 
 static int cover_letter = 0;
 static int cover_one_patch = 1;
+static int cover_overwrite = 1;
 
 static void add_header(const char *value)
 {
@@ -523,6 +524,10 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		cover_one_patch = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "format.overwritecoverletter")) {
+		cover_overwrite = git_config_bool(var, value);
+		return 0;
+	}
 
 	return git_log_config(var, value, cb);
 }
@@ -531,7 +536,7 @@ static FILE *realstdout = NULL;
 static const char *output_directory = NULL;
 static int outdir_offset;
 
-static int reopen_stdout(struct commit *commit, struct rev_info *rev)
+static int reopen_stdout(struct commit *commit, struct rev_info *rev, int check)
 {
 	struct strbuf filename = STRBUF_INIT;
 	int suffix_len = strlen(fmt_patch_suffix) + 1;
@@ -545,7 +550,16 @@ static int reopen_stdout(struct commit *commit, struct rev_info *rev)
 			strbuf_addch(&filename, '/');
 	}
 
-	get_patch_filename(commit, rev->nr, fmt_patch_suffix, &filename);
+	if (!cover_overwrite && check) {
+		int exists;
+		exists = get_patch_filename(commit, rev->nr, fmt_patch_suffix,
+					    check, &filename);
+		if (exists)
+			die("Not overwriting existing coverletter: %s",
+			    filename.buf);
+	} else
+		get_patch_filename(commit, rev->nr, fmt_patch_suffix,
+				   0, &filename);
 
 	if (!DIFF_OPT_TST(&rev->diffopt, QUIET))
 		fprintf(realstdout, "%s\n", filename.buf + outdir_offset);
@@ -656,7 +670,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 			sha1_to_hex(head->object.sha1), committer, committer);
 	}
 
-	if (!use_stdout && reopen_stdout(commit, rev))
+	if (!use_stdout && reopen_stdout(commit, rev, 1))
 		return;
 
 	if (commit) {
@@ -880,6 +894,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			cover_letter = 1;
 		else if (!strcmp(argv[i], "--cover-one-patch"))
 			cover_one_patch = 1;
+		else if (!strcmp(argv[i], "--cover-overwrite"))
+			cover_overwrite = 1;
 		else if (!strcmp(argv[i], "--no-binary"))
 			no_binary_diff = 1;
 		else if (!prefixcmp(argv[i], "--add-header="))
@@ -1086,7 +1102,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		}
 
 		if (!use_stdout && reopen_stdout(numbered_files ? NULL : commit,
-						 &rev))
+						 &rev, 0))
 			die("Failed to create output files");
 		shown = log_tree_commit(&rev, commit);
 		free(commit->buffer);
diff --git a/log-tree.c b/log-tree.c
index 5bd29e6..7163abb 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -179,8 +179,8 @@ static int has_non_ascii(const char *s)
 	return 0;
 }
 
-void get_patch_filename(struct commit *commit, int nr, const char *suffix,
-			struct strbuf *buf)
+int get_patch_filename(struct commit *commit, int nr, const char *suffix,
+			int check, struct strbuf *buf)
 {
 	int suffix_len = strlen(suffix) + 1;
 	int start_len = buf->len;
@@ -194,6 +194,9 @@ void get_patch_filename(struct commit *commit, int nr, const char *suffix,
 			strbuf_setlen(buf, max_len);
 		strbuf_addstr(buf, suffix);
 	}
+	if (check && (access(buf->buf, F_OK) == 0))
+		return 1;
+	return 0;
 }
 
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
@@ -262,7 +265,7 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 		extra_headers = subject_buffer;
 
 		get_patch_filename(opt->numbered_files ? NULL : commit, opt->nr,
-				    opt->patch_suffix, &filename);
+				    opt->patch_suffix, 0, &filename);
 		snprintf(buffer, sizeof(buffer) - 1,
 			 "\n--%s%s\n"
 			 "Content-Type: text/x-patch;"
diff --git a/log-tree.h b/log-tree.h
index 20b5caf..8e91b7a 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -20,7 +20,7 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 void load_ref_decorations(void);
 
 #define FORMAT_PATCH_NAME_MAX 64
-void get_patch_filename(struct commit *commit, int nr, const char *suffix,
-			struct strbuf *buf);
+int get_patch_filename(struct commit *commit, int nr, const char *suffix,
+		       int check, struct strbuf *buf);
 
 #endif
-- 
1.6.2.2.446.gfbdc0
