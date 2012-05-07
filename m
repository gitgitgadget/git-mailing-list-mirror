From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] commit: refactor option parsing
Date: Mon, 7 May 2012 17:22:08 -0400
Message-ID: <20120507212208.GA19567@sigill.intra.peff.net>
References: <20120507212125.GA19532@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Zak Johnson <zakj@nox.cx>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 07 23:22:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRVNo-0006mT-6Z
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 23:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139Ab2EGVWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 17:22:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33242
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757683Ab2EGVWL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 17:22:11 -0400
Received: (qmail 27397 invoked by uid 107); 7 May 2012 21:22:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 May 2012 17:22:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 May 2012 17:22:08 -0400
Content-Disposition: inline
In-Reply-To: <20120507212125.GA19532@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197309>

The options are declared as a static global, but really they
need only be accessible from cmd_commit. Putting them there
will allow us to directly reference local variables in the
options list, which will facilitate further cleanups.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/commit.c | 113 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 57 insertions(+), 56 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index a876a73..5f48e8a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -131,59 +131,6 @@ static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
-static struct option builtin_commit_options[] = {
-	OPT__QUIET(&quiet, "suppress summary after successful commit"),
-	OPT__VERBOSE(&verbose, "show diff in commit message template"),
-
-	OPT_GROUP("Commit message options"),
-	OPT_FILENAME('F', "file", &logfile, "read message from file"),
-	OPT_STRING(0, "author", &force_author, "author", "override author for commit"),
-	OPT_STRING(0, "date", &force_date, "date", "override date for commit"),
-	OPT_CALLBACK('m', "message", &message, "message", "commit message", opt_parse_m),
-	OPT_STRING('c', "reedit-message", &edit_message, "commit", "reuse and edit message from specified commit"),
-	OPT_STRING('C', "reuse-message", &use_message, "commit", "reuse message from specified commit"),
-	OPT_STRING(0, "fixup", &fixup_message, "commit", "use autosquash formatted message to fixup specified commit"),
-	OPT_STRING(0, "squash", &squash_message, "commit", "use autosquash formatted message to squash specified commit"),
-	OPT_BOOLEAN(0, "reset-author", &renew_authorship, "the commit is authored by me now (used with -C/-c/--amend)"),
-	OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
-	OPT_FILENAME('t', "template", &template_file, "use specified template file"),
-	OPT_BOOL('e', "edit", &edit_flag, "force edit of commit"),
-	OPT_STRING(0, "cleanup", &cleanup_arg, "default", "how to strip spaces and #comments from message"),
-	OPT_BOOLEAN(0, "status", &include_status, "include status in commit message template"),
-	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, "key id",
-	  "GPG sign commit", PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
-	/* end commit message options */
-
-	OPT_GROUP("Commit contents options"),
-	OPT_BOOLEAN('a', "all", &all, "commit all changed files"),
-	OPT_BOOLEAN('i', "include", &also, "add specified files to index for commit"),
-	OPT_BOOLEAN(0, "interactive", &interactive, "interactively add files"),
-	OPT_BOOLEAN('p', "patch", &patch_interactive, "interactively add changes"),
-	OPT_BOOLEAN('o', "only", &only, "commit only specified files"),
-	OPT_BOOLEAN('n', "no-verify", &no_verify, "bypass pre-commit hook"),
-	OPT_BOOLEAN(0, "dry-run", &dry_run, "show what would be committed"),
-	OPT_SET_INT(0, "short", &status_format, "show status concisely",
-		    STATUS_FORMAT_SHORT),
-	OPT_BOOLEAN(0, "branch", &status_show_branch, "show branch information"),
-	OPT_SET_INT(0, "porcelain", &status_format,
-		    "machine-readable output", STATUS_FORMAT_PORCELAIN),
-	OPT_BOOLEAN('z', "null", &null_termination,
-		    "terminate entries with NUL"),
-	OPT_BOOLEAN(0, "amend", &amend, "amend previous commit"),
-	OPT_BOOLEAN(0, "no-post-rewrite", &no_post_rewrite, "bypass post-rewrite hook"),
-	{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mode", "show untracked files, optional modes: all, normal, no. (Default: all)", PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
-	/* end commit contents options */
-
-	{ OPTION_BOOLEAN, 0, "allow-empty", &allow_empty, NULL,
-	  "ok to record an empty change",
-	  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
-	{ OPTION_BOOLEAN, 0, "allow-empty-message", &allow_empty_message, NULL,
-	  "ok to record a change with an empty message",
-	  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
-
-	OPT_END()
-};
-
 static void determine_whence(struct wt_status *s)
 {
 	if (file_exists(git_path("MERGE_HEAD")))
@@ -1037,6 +984,7 @@ static const char *read_commit_message(const char *name)
 }
 
 static int parse_and_validate_options(int argc, const char *argv[],
+				      const struct option *options,
 				      const char * const usage[],
 				      const char *prefix,
 				      struct commit *current_head,
@@ -1044,8 +992,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 {
 	int f = 0;
 
-	argc = parse_options(argc, argv, prefix, builtin_commit_options, usage,
-			     0);
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
 	if (force_author && !strchr(force_author, '>'))
 		force_author = find_author_by_nickname(force_author);
@@ -1422,6 +1369,59 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
 
 int cmd_commit(int argc, const char **argv, const char *prefix)
 {
+	static struct option builtin_commit_options[] = {
+		OPT__QUIET(&quiet, "suppress summary after successful commit"),
+		OPT__VERBOSE(&verbose, "show diff in commit message template"),
+
+		OPT_GROUP("Commit message options"),
+		OPT_FILENAME('F', "file", &logfile, "read message from file"),
+		OPT_STRING(0, "author", &force_author, "author", "override author for commit"),
+		OPT_STRING(0, "date", &force_date, "date", "override date for commit"),
+		OPT_CALLBACK('m', "message", &message, "message", "commit message", opt_parse_m),
+		OPT_STRING('c', "reedit-message", &edit_message, "commit", "reuse and edit message from specified commit"),
+		OPT_STRING('C', "reuse-message", &use_message, "commit", "reuse message from specified commit"),
+		OPT_STRING(0, "fixup", &fixup_message, "commit", "use autosquash formatted message to fixup specified commit"),
+		OPT_STRING(0, "squash", &squash_message, "commit", "use autosquash formatted message to squash specified commit"),
+		OPT_BOOLEAN(0, "reset-author", &renew_authorship, "the commit is authored by me now (used with -C/-c/--amend)"),
+		OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
+		OPT_FILENAME('t', "template", &template_file, "use specified template file"),
+		OPT_BOOL('e', "edit", &edit_flag, "force edit of commit"),
+		OPT_STRING(0, "cleanup", &cleanup_arg, "default", "how to strip spaces and #comments from message"),
+		OPT_BOOLEAN(0, "status", &include_status, "include status in commit message template"),
+		{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, "key id",
+		  "GPG sign commit", PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+		/* end commit message options */
+
+		OPT_GROUP("Commit contents options"),
+		OPT_BOOLEAN('a', "all", &all, "commit all changed files"),
+		OPT_BOOLEAN('i', "include", &also, "add specified files to index for commit"),
+		OPT_BOOLEAN(0, "interactive", &interactive, "interactively add files"),
+		OPT_BOOLEAN('p', "patch", &patch_interactive, "interactively add changes"),
+		OPT_BOOLEAN('o', "only", &only, "commit only specified files"),
+		OPT_BOOLEAN('n', "no-verify", &no_verify, "bypass pre-commit hook"),
+		OPT_BOOLEAN(0, "dry-run", &dry_run, "show what would be committed"),
+		OPT_SET_INT(0, "short", &status_format, "show status concisely",
+			    STATUS_FORMAT_SHORT),
+		OPT_BOOLEAN(0, "branch", &status_show_branch, "show branch information"),
+		OPT_SET_INT(0, "porcelain", &status_format,
+			    "machine-readable output", STATUS_FORMAT_PORCELAIN),
+		OPT_BOOLEAN('z', "null", &null_termination,
+			    "terminate entries with NUL"),
+		OPT_BOOLEAN(0, "amend", &amend, "amend previous commit"),
+		OPT_BOOLEAN(0, "no-post-rewrite", &no_post_rewrite, "bypass post-rewrite hook"),
+		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mode", "show untracked files, optional modes: all, normal, no. (Default: all)", PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
+		/* end commit contents options */
+
+		{ OPTION_BOOLEAN, 0, "allow-empty", &allow_empty, NULL,
+		  "ok to record an empty change",
+		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
+		{ OPTION_BOOLEAN, 0, "allow-empty-message", &allow_empty_message, NULL,
+		  "ok to record a change with an empty message",
+		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
+
+		OPT_END()
+	};
+
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf author_ident = STRBUF_INIT;
 	const char *index_file, *reflog_msg;
@@ -1449,7 +1449,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		if (!current_head || parse_commit(current_head))
 			die(_("could not parse HEAD commit"));
 	}
-	argc = parse_and_validate_options(argc, argv, builtin_commit_usage,
+	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
+					  builtin_commit_usage,
 					  prefix, current_head, &s);
 	if (dry_run)
 		return dry_run_commit(argc, argv, prefix, current_head, &s);
-- 
1.7.10.1.12.gd79f7ab
