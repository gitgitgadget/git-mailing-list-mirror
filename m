From: Jeff King <peff@peff.net>
Subject: [PATCH 13/13] format-patch: refactor get_patch_filename
Date: Fri, 18 May 2012 19:24:49 -0400
Message-ID: <20120518232449.GM30031@sigill.intra.peff.net>
References: <20120518230528.GA30510@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 19 01:25:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVWXx-0005qK-JK
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 01:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031214Ab2ERXZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 19:25:14 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48807
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967291Ab2ERXYw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 19:24:52 -0400
Received: (qmail 8010 invoked by uid 107); 18 May 2012 23:25:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 May 2012 19:25:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2012 19:24:49 -0400
Content-Disposition: inline
In-Reply-To: <20120518230528.GA30510@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197994>

The get_patch_filename function expects a commit argument
and uses it to get the sanitized subject line when making a
patch filename. However, we also want to use this same
function for the cover letter, which does not have a commit
object. The current solution is to create a fake commit with
the subject "cover letter". Instead, let's make the
get_patch_filename interface more flexibile, and allow
passing a direct subject.

Signed-off-by: Jeff King <peff@peff.net>
---
This one is a bonus. It doesn't really have anything to do with ident,
except that I came across it while trying to figure out how the
committer info is being used in make_cover_letter.

 builtin/log.c | 35 +++++++----------------------------
 log-tree.c    | 19 +++++++++++--------
 log-tree.h    |  4 ++--
 3 files changed, 20 insertions(+), 38 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 656bddf..8010a40 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -663,7 +663,8 @@ static FILE *realstdout = NULL;
 static const char *output_directory = NULL;
 static int outdir_offset;
 
-static int reopen_stdout(struct commit *commit, struct rev_info *rev, int quiet)
+static int reopen_stdout(struct commit *commit, const char *subject,
+			 struct rev_info *rev, int quiet)
 {
 	struct strbuf filename = STRBUF_INIT;
 	int suffix_len = strlen(fmt_patch_suffix) + 1;
@@ -677,7 +678,7 @@ static int reopen_stdout(struct commit *commit, struct rev_info *rev, int quiet)
 			strbuf_addch(&filename, '/');
 	}
 
-	get_patch_filename(commit, rev->nr, fmt_patch_suffix, &filename);
+	get_patch_filename(commit, subject, rev->nr, fmt_patch_suffix, &filename);
 
 	if (!quiet)
 		fprintf(realstdout, "%s\n", filename.buf + outdir_offset);
@@ -778,7 +779,6 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	const char *encoding = "UTF-8";
 	struct diff_options opts;
 	int need_8bit_cte = 0;
-	struct commit *commit = NULL;
 	struct pretty_print_context pp = {0};
 
 	if (rev->commit_format != CMIT_FMT_EMAIL)
@@ -786,31 +786,10 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 
 	committer = git_committer_info(0);
 
-	if (!numbered_files) {
-		/*
-		 * We fake a commit for the cover letter so we get the filename
-		 * desired.
-		 */
-		commit = xcalloc(1, sizeof(*commit));
-		commit->buffer = xmalloc(400);
-		snprintf(commit->buffer, 400,
-			"tree 0000000000000000000000000000000000000000\n"
-			"parent %s\n"
-			"author %s\n"
-			"committer %s\n\n"
-			"cover letter\n",
-			sha1_to_hex(head->object.sha1), committer, committer);
-	}
-
-	if (!use_stdout && reopen_stdout(commit, rev, quiet))
+	if (!use_stdout &&
+	    reopen_stdout(NULL, numbered_files ? NULL : "cover-letter", rev, quiet))
 		return;
 
-	if (commit) {
-
-		free(commit->buffer);
-		free(commit);
-	}
-
 	log_write_email_headers(rev, head, &pp.subject, &pp.after_subject,
 				&need_8bit_cte);
 
@@ -1405,8 +1384,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			gen_message_id(&rev, sha1_to_hex(commit->object.sha1));
 		}
 
-		if (!use_stdout && reopen_stdout(numbered_files ? NULL : commit,
-						 &rev, quiet))
+		if (!use_stdout &&
+		    reopen_stdout(numbered_files ? NULL : commit, NULL, &rev, quiet))
 			die(_("Failed to create output files"));
 		shown = log_tree_commit(&rev, commit);
 		free(commit->buffer);
diff --git a/log-tree.c b/log-tree.c
index 376d973..c894930 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -299,19 +299,22 @@ static unsigned int digits_in_number(unsigned int number)
 	return result;
 }
 
-void get_patch_filename(struct commit *commit, int nr, const char *suffix,
-			struct strbuf *buf)
+void get_patch_filename(struct commit *commit, const char *subject, int nr,
+			const char *suffix, struct strbuf *buf)
 {
 	int suffix_len = strlen(suffix) + 1;
 	int start_len = buf->len;
 
-	strbuf_addf(buf, commit ? "%04d-" : "%d", nr);
-	if (commit) {
+	strbuf_addf(buf, commit || subject ? "%04d-" : "%d", nr);
+	if (commit || subject) {
 		int max_len = start_len + FORMAT_PATCH_NAME_MAX - suffix_len;
 		struct pretty_print_context ctx = {0};
-		ctx.date_mode = DATE_NORMAL;
 
-		format_commit_message(commit, "%f", buf, &ctx);
+		if (subject)
+			strbuf_addstr(buf, subject);
+		else if (commit)
+			format_commit_message(commit, "%f", buf, &ctx);
+
 		if (max_len < buf->len)
 			strbuf_setlen(buf, max_len);
 		strbuf_addstr(buf, suffix);
@@ -384,8 +387,8 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			 mime_boundary_leader, opt->mime_boundary);
 		extra_headers = subject_buffer;
 
-		get_patch_filename(opt->numbered_files ? NULL : commit, opt->nr,
-				    opt->patch_suffix, &filename);
+		get_patch_filename(opt->numbered_files ? NULL : commit, NULL,
+				   opt->nr, opt->patch_suffix, &filename);
 		snprintf(buffer, sizeof(buffer) - 1,
 			 "\n--%s%s\n"
 			 "Content-Type: text/x-patch;"
diff --git a/log-tree.h b/log-tree.h
index 5c4cf7c..f5ac238 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -21,7 +21,7 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 void load_ref_decorations(int flags);
 
 #define FORMAT_PATCH_NAME_MAX 64
-void get_patch_filename(struct commit *commit, int nr, const char *suffix,
-			struct strbuf *buf);
+void get_patch_filename(struct commit *commit, const char *subject, int nr,
+			const char *suffix, struct strbuf *buf);
 
 #endif
-- 
1.7.10.1.16.g53a707b
