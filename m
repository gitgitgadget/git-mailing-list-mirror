From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] format-patch: learn to fill comment section of email from notes
Date: Tue, 23 Feb 2010 18:34:36 +0100
Message-ID: <6cf9010742df96e0c68ef8adc1ab392c08525bc2.1266946262.git.trast@student.ethz.ch>
References: <201002231810.18960.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 23 18:35:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njyez-0005kh-IB
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 18:35:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564Ab0BWRe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 12:34:56 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:41783 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863Ab0BWRez (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 12:34:55 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 23 Feb
 2010 18:34:55 +0100
Received: from localhost.localdomain (129.132.210.179) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 23 Feb
 2010 18:34:38 +0100
X-Mailer: git-send-email 1.7.0.218.g73a398
In-Reply-To: <201002231810.18960.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140818>

Teach git-format-patch a new option --comment-notes (with config
format.commentNotes) which takes a notes ref argument.  These notes
are then added to the patch email between the --- separator and the
diffstat/diff.

This is somewhat tricky because the pretty-printing code has no
control whatsoever over the --- and the diffstat, and there be dragons
in the newline-producing code inside show_log().  Try not to disturb
them, and patch around only outside show_log().

To ensure correctness of the resulting email, extend the existing rule
(separator if not 'oneline' format and --patch-with-stat) to also
include a separator if there are notes and a patch will be included.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

So here's the promised patch.  This is sort-of-RFC; it's not part of
the series because I don't want the latter to block on this one if
anyone suggests changes.

I'll follow up with a broken version to prove the point about the
dragons I made above, if anyone wants to try fixing it.

 Documentation/config.txt           |    6 ++
 Documentation/git-format-patch.txt |   10 ++++
 builtin-log.c                      |   12 +++++
 log-tree.c                         |   14 +++++-
 pretty.c                           |    2 +-
 t/t4014-format-patch.sh            |   91 ++++++++++++++++++++++++++++++++++++
 6 files changed, 133 insertions(+), 2 deletions(-)

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
diff --git a/log-tree.c b/log-tree.c
index d3ae969..9830be8 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -7,6 +7,7 @@
 #include "reflog-walk.h"
 #include "refs.h"
 #include "string-list.h"
+#include "notes.h"
 
 struct decoration name_decoration = { "object names" };
 
@@ -457,6 +458,7 @@ int log_tree_diff_flush(struct rev_info *opt)
 	}
 
 	if (opt->loginfo && !opt->no_commit_id) {
+		const unsigned char *sha1 = opt->loginfo->commit->object.sha1;
 		/* When showing a verbose header (i.e. log message),
 		 * and not in --pretty=oneline format, we would want
 		 * an extra newline between the end of log and the
@@ -467,10 +469,20 @@ int log_tree_diff_flush(struct rev_info *opt)
 		    opt->verbose_header &&
 		    opt->commit_format != CMIT_FMT_ONELINE) {
 			int pch = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_PATCH;
-			if ((pch & opt->diffopt.output_format) == pch)
+			if ((pch & opt->diffopt.output_format) == pch
+			    || (opt->commit_format == CMIT_FMT_EMAIL
+				&& opt->show_notes))
 				printf("---");
 			putchar('\n');
 		}
+		if (opt->commit_format == CMIT_FMT_EMAIL && opt->show_notes) {
+			struct strbuf sb = STRBUF_INIT;
+			putchar('\n');
+			format_note(NULL, sha1, &sb, NULL, 0);
+			fwrite(sb.buf, 1, sb.len, stdout);
+			strbuf_release(&sb);
+			putchar('\n');
+		}
 	}
 	diff_flush(&opt->diffopt);
 	return 1;
diff --git a/pretty.c b/pretty.c
index 6ba3da8..10d7812 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1095,7 +1095,7 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 	if (fmt == CMIT_FMT_EMAIL && sb->len <= beginning_of_body)
 		strbuf_addch(sb, '\n');
 
-	if (context->show_notes)
+	if (context->show_notes && fmt != CMIT_FMT_EMAIL)
 		format_display_notes(commit->object.sha1, sb, encoding,
 				     NOTES_SHOW_HEADER | NOTES_INDENT);
 
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
