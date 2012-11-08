From: Jeff King <peff@peff.net>
Subject: [PATCH] custom log formats for "diff --submodule=log"
Date: Thu, 8 Nov 2012 15:29:40 -0500
Message-ID: <20121108202940.GA7982@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Jeffrey S. Haemer" <jeffrey.haemer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 08 21:30:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWYje-0007VT-J0
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 21:29:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756810Ab2KHU3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 15:29:45 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36681 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756733Ab2KHU3o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 15:29:44 -0500
Received: (qmail 32491 invoked by uid 107); 8 Nov 2012 20:30:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Nov 2012 15:30:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2012 15:29:40 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209188>

An off-list discussion made me wonder if something like this would be
useful:

  git log -p --submodule=log:'  %m %an <%ae>: %s'

where the format could be whatever you find useful.

I do not use submodules myself, so writing the patch below was just a
fun exercise. I'm not planning on polishing it for inclusion. But I
thought I would publish it here in case anybody who is more interested
feels like picking it up. It would need documentation and tests at the
very least.

---
diff --git a/diff.c b/diff.c
index 86e5f2a..f2adaca 100644
--- a/diff.c
+++ b/diff.c
@@ -2241,7 +2241,7 @@ static void builtin_diff(const char *name_a,
 		const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
 		show_submodule_summary(o->file, one ? one->path : two->path,
 				one->sha1, two->sha1, two->dirty_submodule,
-				del, add, reset);
+				del, add, reset, o->submodule_log_format);
 		return;
 	}
 
@@ -3654,8 +3654,13 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	} else if (!strcmp(arg, "--submodule"))
 		DIFF_OPT_SET(options, SUBMODULE_LOG);
 	else if (!prefixcmp(arg, "--submodule=")) {
-		if (!strcmp(arg + 12, "log"))
+		const char *v = arg + 12;
+		if (!strcmp(v, "log"))
 			DIFF_OPT_SET(options, SUBMODULE_LOG);
+		else if (!prefixcmp(v, "log:")) {
+			DIFF_OPT_SET(options, SUBMODULE_LOG);
+			options->submodule_log_format = xstrdup(v + 4);
+		}
 	}
 
 	/* misc options */
diff --git a/diff.h b/diff.h
index a658f85..9726375 100644
--- a/diff.h
+++ b/diff.h
@@ -132,6 +132,8 @@ struct diff_options {
 	const char *stat_sep;
 	long xdl_opts;
 
+	char *submodule_log_format;
+
 	int stat_width;
 	int stat_name_width;
 	int stat_graph_width;
diff --git a/submodule.c b/submodule.c
index e3e0b45..149bd87 100644
--- a/submodule.c
+++ b/submodule.c
@@ -217,12 +217,16 @@ static int prepare_submodule_summary(struct rev_info *rev, const char *path,
 }
 
 static void print_submodule_summary(struct rev_info *rev, FILE *f,
-		const char *del, const char *add, const char *reset)
+		const char *del, const char *add, const char *reset,
+		const char *format)
 {
-	static const char format[] = "  %m %s";
+	static const char default_format[] = "  %m %s";
 	struct strbuf sb = STRBUF_INIT;
 	struct commit *commit;
 
+	if (!format)
+		format = default_format;
+
 	while ((commit = get_revision(rev))) {
 		struct pretty_print_context ctx = {0};
 		ctx.date_mode = rev->date_mode;
@@ -259,7 +263,8 @@ int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
 void show_submodule_summary(FILE *f, const char *path,
 		unsigned char one[20], unsigned char two[20],
 		unsigned dirty_submodule,
-		const char *del, const char *add, const char *reset)
+		const char *del, const char *add, const char *reset,
+		const char *format)
 {
 	struct rev_info rev;
 	struct commit *left = left, *right = right;
@@ -304,7 +309,7 @@ void show_submodule_summary(FILE *f, const char *path,
 	fwrite(sb.buf, sb.len, 1, f);
 
 	if (!message) {
-		print_submodule_summary(&rev, f, del, add, reset);
+		print_submodule_summary(&rev, f, del, add, reset, format);
 		clear_commit_marks(left, ~0);
 		clear_commit_marks(right, ~0);
 	}
diff --git a/submodule.h b/submodule.h
index f2e8271..49a7b75 100644
--- a/submodule.h
+++ b/submodule.h
@@ -21,7 +21,8 @@ int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
 void show_submodule_summary(FILE *f, const char *path,
 		unsigned char one[20], unsigned char two[20],
 		unsigned dirty_submodule,
-		const char *del, const char *add, const char *reset);
+		const char *del, const char *add, const char *reset,
+		const char *format);
 void set_config_fetch_recurse_submodules(int value);
 void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 int fetch_populated_submodules(const struct argv_array *options,
