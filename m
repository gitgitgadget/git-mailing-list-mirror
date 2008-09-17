From: Jeff King <peff@peff.net>
Subject: Re: Mismatch between "git status" and "git ls-files" [was Re:
	Teach git status to do "git diff --name-status HEAD"]
Date: Wed, 17 Sep 2008 13:31:46 -0400
Message-ID: <20080917173146.GA29374@coredump.intra.peff.net>
References: <aba84270809162340n4ea3f5feqc71d01fa6e035b79@mail.gmail.com> <48D0C2DF.7010308@drmicha.warpmail.net> <m3ej3jm3ux.fsf@localhost.localdomain> <48D11F40.4000307@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin@laptop.org>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Sep 17 19:33:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg0th-0005jF-Cm
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 19:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222AbYIQRbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 13:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754192AbYIQRbu
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 13:31:50 -0400
Received: from peff.net ([208.65.91.99]:4888 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753183AbYIQRbt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 13:31:49 -0400
Received: (qmail 3041 invoked by uid 111); 17 Sep 2008 17:31:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 17 Sep 2008 13:31:48 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Sep 2008 13:31:46 -0400
Content-Disposition: inline
In-Reply-To: <48D11F40.4000307@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96130>

On Wed, Sep 17, 2008 at 05:16:16PM +0200, Michael J Gruber wrote:

> Following up on the discussion about "git status" versus
> "youknowwhichscm status" and suggestions to use "git diff --name-status"
> or "git ls-files -d -m -o -t" I made a little test case, see the
> attached script and output (git version 1.6.0.2.249.g97d7f).
> Observations:

You could also do something like the patch below. It produces output
like this:

  $ git status --terse
  # On branch next
  # Your branch is ahead of 'origin/next' by 1 commit.
  #
  # Changes to be committed:
  M	wt-status.c
  # Changed but not updated:
  M	builtin-commit.c
  M	wt-status.c
  M	wt-status.h
  # Untracked files:
  ? untracked_file
  nothing added to commit but untracked files present (use "git add" to track)

Though there are a few gotchas that make this unsuitable for applying:

  - replacing the callbacks with DIFF_FORMAT_NAME_STATUS isn't quite
    right. You lose the custom colorization, and it fails to set the "we
    have stuff to commit" flag (note in my example that the "nothing
    added to commit" isn't correct). Instead, we would need to do our
    own NAME_STATUS output from the callback (possibly it could be
    factored from diff.c into a general function).

  - The format has lines that don't start with a '#', so it is not
    suitable for a commit message template. So "git commit --terse"
    should be disallowed.

  - There might be other lines that can be stripped.

I personally don't see any real advantage of this format over the
existing status format, so I won't push this patch any further. But if
somebody wants to pick it up and get it into shape, feel free.

---
diff --git a/builtin-commit.c b/builtin-commit.c
index 917f638..e75b508 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -52,6 +52,7 @@ static char *edit_message, *use_message;
 static char *author_name, *author_email, *author_date;
 static int all, edit_flag, also, interactive, only, amend, signoff;
 static int quiet, verbose, no_verify, allow_empty;
+static int terse_status;
 static char *untracked_files_arg;
 /*
  * The default commit message cleanup mode will remove the lines
@@ -107,6 +108,8 @@ static struct option builtin_commit_options[] = {
 	{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mode", "show untracked files, optional modes: all, normal, no. (Default: all)", PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 	OPT_BOOLEAN(0, "allow-empty", &allow_empty, "ok to record an empty change"),
 	OPT_STRING(0, "cleanup", &cleanup_arg, "default", "how to strip spaces and #comments from message"),
+	OPT_BOOLEAN(0, "terse", &terse_status,
+			"use a more terse format to display status"),
 
 	OPT_END()
 };
@@ -348,6 +351,7 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 		s.amend = 1;
 		s.reference = "HEAD^1";
 	}
+	s.terse = terse_status;
 	s.verbose = verbose;
 	s.untracked = (show_untracked_files == SHOW_ALL_UNTRACKED_FILES);
 	s.index_file = index_file;
diff --git a/wt-status.c b/wt-status.c
index 7cf890f..fd3c2d5 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -87,8 +87,10 @@ static void wt_status_print_untracked_header(struct wt_status *s)
 {
 	const char *c = color(WT_STATUS_HEADER);
 	color_fprintf_ln(s->fp, c, "# Untracked files:");
-	color_fprintf_ln(s->fp, c, "#   (use \"git add <file>...\" to include in what will be committed)");
-	color_fprintf_ln(s->fp, c, "#");
+	if (!s->terse) {
+		color_fprintf_ln(s->fp, c, "#   (use \"git add <file>...\" to include in what will be committed)");
+		color_fprintf_ln(s->fp, c, "#");
+	}
 }
 
 static void wt_status_print_trailer(struct wt_status *s)
@@ -213,9 +215,16 @@ static void wt_status_print_updated(struct wt_status *s)
 	struct rev_info rev;
 	init_revisions(&rev, NULL);
 	setup_revisions(0, NULL, &rev, s->reference);
-	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
-	rev.diffopt.format_callback = wt_status_print_updated_cb;
-	rev.diffopt.format_callback_data = s;
+	if (s->terse) {
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER),
+				"# Changes to be committed:");
+		rev.diffopt.output_format = DIFF_FORMAT_NAME_STATUS;
+	}
+	else {
+		rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
+		rev.diffopt.format_callback = wt_status_print_updated_cb;
+		rev.diffopt.format_callback_data = s;
+	}
 	rev.diffopt.detect_rename = 1;
 	rev.diffopt.rename_limit = 200;
 	rev.diffopt.break_opt = 0;
@@ -227,9 +236,16 @@ static void wt_status_print_changed(struct wt_status *s)
 	struct rev_info rev;
 	init_revisions(&rev, "");
 	setup_revisions(0, NULL, &rev, NULL);
-	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
-	rev.diffopt.format_callback = wt_status_print_changed_cb;
-	rev.diffopt.format_callback_data = s;
+	if (s->terse) {
+		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER),
+				"# Changed but not updated:");
+		rev.diffopt.output_format = DIFF_FORMAT_NAME_STATUS;
+	}
+	else {
+		rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
+		rev.diffopt.format_callback = wt_status_print_changed_cb;
+		rev.diffopt.format_callback_data = s;
+	}
 	run_diff_files(&rev, 0);
 }
 
@@ -300,7 +316,10 @@ static void wt_status_print_untracked(struct wt_status *s)
 			wt_status_print_untracked_header(s);
 			shown_header = 1;
 		}
-		color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
+		if (s->terse)
+			color_fprintf(s->fp, color(WT_STATUS_UNTRACKED), "? ");
+		else
+			color_fprintf(s->fp, color(WT_STATUS_HEADER), "#\t");
 		color_fprintf_ln(s->fp, color(WT_STATUS_UNTRACKED), "%s",
 				quote_path(ent->name, ent->len,
 					&buf, s->prefix));
diff --git a/wt-status.h b/wt-status.h
index 78add09..40fd132 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -23,6 +23,7 @@ struct wt_status {
 	char *branch;
 	const char *reference;
 	int verbose;
+	int terse;
 	int amend;
 	int untracked;
 	int nowarn;
