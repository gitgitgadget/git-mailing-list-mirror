From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] BROKEN -- format-patch: learn to fill comment section of email from notes
Date: Tue, 23 Feb 2010 18:34:56 +0100
Message-ID: <fe0d69eba1b0265c0ca913831ba26e643062f8eb.1266946248.git.trast@student.ethz.ch>
References: <6cf9010742df96e0c68ef8adc1ab392c08525bc2.1266946262.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 23 18:35:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjyfC-0005qF-5c
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 18:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806Ab0BWRfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 12:35:05 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:15136 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751665Ab0BWRfE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 12:35:04 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 23 Feb
 2010 18:35:00 +0100
Received: from localhost.localdomain (129.132.210.179) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 23 Feb
 2010 18:34:58 +0100
X-Mailer: git-send-email 1.7.0.218.g73a398
In-Reply-To: <6cf9010742df96e0c68ef8adc1ab392c08525bc2.1266946262.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140819>

Teach git-format-patch a new option --comment-notes (with config
format.commentNotes) which takes a notes ref argument.  These notes
are then added to the patch email between the --- separator and the
diffstat/diff.

This is somewhat tricky because the pretty-printing code has no
control whatsoever over the --- and the diffstat.  To fix that, move
the associated code down into show_log(), which can set options in the
pretty_print_context.  Extend the latter with fields for an arbitrary
string, to be inserted after commit message and after notes.  Use
those to place the --- appropriately.

To ensure correctness of the resulting email, extend the existing rule
(separator if not 'oneline' format and --patch-with-stat) to also
include a separator if there are notes and a patch will be included.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---


 Documentation/config.txt           |    6 ++
 Documentation/git-format-patch.txt |   10 ++++
 builtin-log.c                      |   12 +++++
 commit.h                           |    2 +
 log-tree.c                         |   38 ++++++++++-----
 pretty.c                           |   19 ++++++-
 t/t4014-format-patch.sh            |   91 ++++++++++++++++++++++++++++++++++++
 7 files changed, 162 insertions(+), 16 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index dffe1f6..a9e27db 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -886,6 +886,12 @@ format.signoff::
     the rights to submit this work under the same open source license.
     Please see the 'SubmittingPatches' document for further discussion.
 
+format.commentNotes::
+	The default notes reference that is used for the comment
+	section with --pretty=email and for 'git-format-patch'.  (The
+	comment section is the area between the `\---` separator and
+	the patch, which also holds the diffstat.)
+
 gc.aggressiveWindow::
 	The window size parameter used in the delta compression
 	algorithm used by 'git gc --aggressive'.  This defaults
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 9674f9d..afe7e41 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -198,6 +198,16 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
 	range are always formatted as creation patches, independently
 	of this flag.
 
+--comment-notes=<ref>::
+	Use the notes from <ref> to fill the comment section of the
+	email, i.e., the part between the `\---` separator and the
+	patch.  See linkgit:git-notes[1].
++
+Warning: the code currently does not guard against a line in the notes
+that starts with `diff`, which will be treated as the start of the
+patch by 'git-am'.
+
+
 CONFIGURATION
 -------------
 You can specify extra mail header lines to be added to each message,
diff --git a/builtin-log.c b/builtin-log.c
index e7ea088..f85837d 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -19,6 +19,7 @@
 #include "remote.h"
 #include "string-list.h"
 #include "parse-options.h"
+#include "notes.h"
 
 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
@@ -495,6 +496,7 @@ static void add_header(const char *value)
 #define THREAD_DEEP 2
 static int thread = 0;
 static int do_signoff = 0;
+static const char *comment_notes = NULL;
 
 static int git_format_config(const char *var, const char *value, void *cb)
 {
@@ -548,6 +550,9 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		do_signoff = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "format.commentnotes")) {
+		return git_config_string(&comment_notes, var, value);
+	}
 
 	return git_log_config(var, value, cb);
 }
@@ -955,6 +960,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 0, "thread", &thread, "style",
 			    "enable message threading, styles: shallow, deep",
 			    PARSE_OPT_OPTARG, thread_callback },
+		OPT_STRING(0, "comment-notes", &comment_notes,
+			   "ref", "use notes from <ref> for comment section"),
 		OPT_END()
 	};
 
@@ -1039,6 +1046,11 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (keep_subject && subject_prefix)
 		die ("--subject-prefix and -k are mutually exclusive.");
 
+	if (comment_notes) {
+		init_notes(NULL, comment_notes, combine_notes_ignore, 0);
+		rev.show_notes = 1;
+	}
+
 	argc = setup_revisions(argc, argv, &rev, "HEAD");
 	if (argc > 1)
 		die ("unrecognized argument: %s", argv[1]);
diff --git a/commit.h b/commit.h
index 3cf5166..44bcf5a 100644
--- a/commit.h
+++ b/commit.h
@@ -68,6 +68,8 @@ struct pretty_print_context
 	int abbrev;
 	const char *subject;
 	const char *after_subject;
+	const char *after_message;
+	const char *after_notes;
 	enum date_mode date_mode;
 	int need_8bit_cte;
 	int show_notes;
diff --git a/log-tree.c b/log-tree.c
index d3ae969..93e0f48 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -7,6 +7,7 @@
 #include "reflog-walk.h"
 #include "refs.h"
 #include "string-list.h"
+#include "notes.h"
 
 struct decoration name_decoration = { "object names" };
 
@@ -413,6 +414,30 @@ void show_log(struct rev_info *opt)
 	ctx.abbrev = opt->diffopt.abbrev;
 	ctx.after_subject = extra_headers;
 	ctx.reflog_info = opt->reflog_info;
+
+	ctx.after_message = NULL;
+	/*
+	 * In formats other than 'oneline', add an extra newline.  In
+	 * addition, add the triple-dash separator between message and
+	 * diff if there is a diffstat coming or we are showing notes
+	 * in 'email' format.  Otherwise, 'git am' would include the
+	 * diffstat or notes in the commit message when applying the
+	 * commit.
+	 */
+	if ((opt->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT) &&
+	    opt->verbose_header &&
+	    opt->commit_format != CMIT_FMT_ONELINE) {
+		int pch = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_PATCH;
+		int patch_with_stat = (pch & opt->diffopt.output_format) == pch;
+		if (opt->commit_format == CMIT_FMT_EMAIL
+		    && (opt->show_notes || patch_with_stat))
+			ctx.after_message = "---\n";
+		else if (opt->commit_format != CMIT_FMT_EMAIL && patch_with_stat)
+			ctx.after_notes = "---\n";
+		else
+			ctx.after_notes = "\n";
+	}
+
 	pretty_print_commit(opt->commit_format, commit, &msgbuf, &ctx);
 
 	if (opt->add_signoff)
@@ -457,20 +482,7 @@ int log_tree_diff_flush(struct rev_info *opt)
 	}
 
 	if (opt->loginfo && !opt->no_commit_id) {
-		/* When showing a verbose header (i.e. log message),
-		 * and not in --pretty=oneline format, we would want
-		 * an extra newline between the end of log and the
-		 * output for readability.
-		 */
 		show_log(opt);
-		if ((opt->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT) &&
-		    opt->verbose_header &&
-		    opt->commit_format != CMIT_FMT_ONELINE) {
-			int pch = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_PATCH;
-			if ((pch & opt->diffopt.output_format) == pch)
-				printf("---");
-			putchar('\n');
-		}
 	}
 	diff_flush(&opt->diffopt);
 	return 1;
diff --git a/pretty.c b/pretty.c
index 6ba3da8..4fc855e 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1095,9 +1095,22 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 	if (fmt == CMIT_FMT_EMAIL && sb->len <= beginning_of_body)
 		strbuf_addch(sb, '\n');
 
-	if (context->show_notes)
-		format_display_notes(commit->object.sha1, sb, encoding,
-				     NOTES_SHOW_HEADER | NOTES_INDENT);
+	if (context->after_message)
+		strbuf_addstr(sb, context->after_message);
+
+	if (context->show_notes) {
+		if (fmt == CMIT_FMT_EMAIL) {
+			strbuf_addch(sb, '\n');
+			format_note(NULL, commit->object.sha1, sb, encoding, 0);
+			strbuf_addch(sb, '\n');
+		} else {
+			format_display_notes(commit->object.sha1, sb, encoding,
+					     NOTES_SHOW_HEADER | NOTES_INDENT);
+		}
+	}
+
+	if (context->after_notes)
+		strbuf_addstr(sb, context->after_notes);
 
 	free(reencoded);
 }
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index f2a2aaa..653e50a 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -557,4 +557,95 @@ test_expect_success 'format-patch -- <path>' '
 	! grep "Use .--" error
 '
 
+cat >expect-no-comment <<EOF
+Subject: [PATCH] foo
+Cc: R. E. Cipient <rcipient@example.com>
+
+---
+ file |   32 --------------------------------
+ foo  |   32 ++++++++++++++++++++++++++++++++
+ 2 files changed, 32 insertions(+), 32 deletions(-)
+ delete mode 100644 file
+ create mode 100644 foo
+
+diff --git a/file b/file
+EOF
+
+cat >expect-comment <<EOF
+Subject: [PATCH] foo
+Cc: R. E. Cipient <rcipient@example.com>
+
+---
+
+a bit of testing here
+
+ file |   32 --------------------------------
+ foo  |   32 ++++++++++++++++++++++++++++++++
+ 2 files changed, 32 insertions(+), 32 deletions(-)
+ delete mode 100644 file
+ create mode 100644 foo
+
+diff --git a/file b/file
+EOF
+
+test_expect_success 'comment section untouched by default' '
+	git notes add -m"a bit of testing here" &&
+	git format-patch -1 --stdout > output &&
+	sed -e "1,/^Date/d" -e "/^diff --git/q" output > output+ &&
+	test_cmp expect-no-comment output+
+'
+
+test_expect_success '--comment-notes' '
+	git format-patch --comment-notes=refs/notes/commits -1 --stdout > output &&
+	sed -e "1,/^Date/d" -e "/^diff --git/q" output > output+ &&
+	test_cmp expect-comment output+
+'
+
+test_expect_success 'format.commentNotes' '
+	git config format.commentNotes refs/notes/commits &&
+	git format-patch -1 --stdout > output &&
+	sed -e "1,/^Date/d" -e "/^diff --git/q" output > output+ &&
+	test_cmp expect-comment output+
+'
+
+test_expect_success '--comment-notes overrides format.commentNotes' '
+	git config format.commentNotes refs/notes/empty &&
+	git format-patch --comment-notes=refs/notes/commits -1 --stdout > output &&
+	sed -e "1,/^Date/d" -e "/^diff --git/q" output > output+ &&
+	test_cmp expect-comment output+
+'
+
+cat >expect <<EOF
+Subject: [PATCH] foo
+Cc: R. E. Cipient <rcipient@example.com>
+
+
+diff --git a/file b/file
+EOF
+
+test_expect_success 'no separator with neither diffstat nor notes' '
+	git config --unset format.commentNotes &&
+	git format-patch -p -1 --stdout > output &&
+	sed -e "1,/^Date/d" -e "/^diff --git/q" output > output+ &&
+	test_cmp expect output+
+'
+
+cat >expect <<EOF
+Subject: [PATCH] foo
+Cc: R. E. Cipient <rcipient@example.com>
+
+---
+
+a bit of testing here
+
+diff --git a/file b/file
+EOF
+
+test_expect_success 'separator with notes but no diffstat' '
+	git config format.commentNotes refs/notes/commits &&
+	git format-patch -p -1 --stdout > output &&
+	sed -e "1,/^Date/d" -e "/^diff --git/q" output > output+ &&
+	test_cmp expect output+
+'
+
 test_done
-- 
1.7.0.218.g73a398
