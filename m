From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Allow selection of different cleanup modes for commit
	messages
Date: Sat, 22 Dec 2007 00:08:51 +0100
Message-ID: <20071221230851.GA3260@steel.home>
References: <20071220211835.GA3052@steel.home> <alpine.LFD.0.9999.0712201324270.21557@woody.linux-foundation.org> <7vlk7plydv.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.9999.0712201555570.21557@woody.linux-foundation.org> <20071221173521.GA3494@steel.home> <7v8x3n4tbe.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 00:09:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5qzc-0007tX-9T
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 00:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757441AbXLUXI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 18:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755442AbXLUXI6
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 18:08:58 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:39690 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbXLUXI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 18:08:57 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTvznCE=
Received: from tigra.home (Fca98.f.strato-dslnet.de [195.4.202.152])
	by post.webmailer.de (fruni mo60) (RZmta 14.6)
	with ESMTP id x0374ejBLJGTBg ; Sat, 22 Dec 2007 00:08:52 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 28B2A277AE;
	Sat, 22 Dec 2007 00:08:52 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id B654556D22; Sat, 22 Dec 2007 00:08:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v8x3n4tbe.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69107>

Sometimes the message just have to be the way user wants it.
For instance, a template can contain "#" characters, or the message
must be kept as close to its original source as possible for reimport
reasons. Or maybe the user just copied a shell script including its
comments into the commit message for future reference.

The cleanup modes are default, verbatim, whitespace and strip. The
default mode depends on if the message is being edited and will either
strip whitespace and comments (if editor active) or just strip the
whitespace (for where the message is given explicitely).

Suggested by Linus.

Signed-off-by: Alex Riesen <raa@gmail.com>
---

Junio C Hamano, Fri, Dec 21, 2007 22:43:49 +0100:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > The patch is on top of my previos patches. Junio, if you wish, I can
> > squash and resend.
> 
> That would be a sane thing to do.

Done

 Documentation/git-commit.txt |   12 +++++++-
 builtin-commit.c             |   69 +++++++++++++++++++++++++++++++----------
 t/t7502-commit.sh            |   40 ++++++++++++++++++++++++
 3 files changed, 103 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 4261384..ac2bfd5 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git-commit' [-a | --interactive] [-s] [-v] [-u]
 	   [(-c | -C) <commit> | -F <file> | -m <msg> | --amend]
 	   [--allow-empty] [--no-verify] [-e] [--author <author>]
-	   [--] [[-i | -o ]<file>...]
+	   [--cleanup=<mode>] [--] [[-i | -o ]<file>...]
 
 DESCRIPTION
 -----------
@@ -95,6 +95,16 @@ OPTIONS
 	from making such a commit.  This option bypasses the safety, and
 	is primarily for use by foreign scm interface scripts.
 
+--cleanup=<mode>::
+	This option sets how the commit message is cleaned up.
+	The  '<mode>' can be one of 'verbatim', 'whitespace', 'strip',
+	and 'default'. The 'default' mode will strip leading and
+	trailing empty lines and #commentary from the commit message
+	only if the message is to be edited. Otherwise only whitespace
+	removed. The 'verbatim' mode wont change message at all,
+	'whitespace' removes just leading/trailing whitespace lines
+	and 'strip' removes both whitespace and commentary.
+
 -e|--edit::
 	The message taken from file with `-F`, command line with
 	`-m`, and from file with `-C` are usually used as the
diff --git a/builtin-commit.c b/builtin-commit.c
index 0a91013..6f98537 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -47,6 +47,20 @@ static char *logfile, *force_author, *template_file;
 static char *edit_message, *use_message;
 static int all, edit_flag, also, interactive, only, amend, signoff;
 static int quiet, verbose, untracked_files, no_verify, allow_empty;
+/*
+ * The default commit message cleanup mode will remove the lines
+ * beginning with # (shell comments) and leading and trailing
+ * whitespaces (empty lines or containing only whitespaces)
+ * if editor is used, and only the whitespaces if the message
+ * is specified explicitly.
+ */
+static enum {
+	CLEANUP_DEFAULT,
+	CLEANUP_NONE,
+	CLEANUP_SPACE,
+	CLEANUP_ALL,
+} cleanup_mode;
+static char *cleanup_arg;
 
 static int no_edit, initial_commit, in_merge;
 const char *only_include_assumed;
@@ -88,6 +102,7 @@ static struct option builtin_commit_options[] = {
 	OPT_BOOLEAN(0, "amend", &amend, "amend previous commit"),
 	OPT_BOOLEAN(0, "untracked-files", &untracked_files, "show all untracked files"),
 	OPT_BOOLEAN(0, "allow-empty", &allow_empty, "ok to record an empty change"),
+	OPT_STRING(0, "cleanup", &cleanup_arg, "default", "how to strip spaces and #comments from message"),
 
 	OPT_END()
 };
@@ -346,7 +361,8 @@ static int prepare_log_message(const char *index_file, const char *prefix)
 	if (fp == NULL)
 		die("could not open %s", git_path(commit_editmsg));
 
-	stripspace(&sb, 0);
+	if (cleanup_mode != CLEANUP_NONE)
+		stripspace(&sb, 0);
 
 	if (signoff) {
 		struct strbuf sob;
@@ -394,20 +410,24 @@ static int prepare_log_message(const char *index_file, const char *prefix)
 		return !!DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES);
 	}
 
-	if (in_merge && !no_edit)
-		fprintf(fp,
-			"#\n"
-			"# It looks like you may be committing a MERGE.\n"
-			"# If this is not correct, please remove the file\n"
-			"#	%s\n"
-			"# and try again.\n"
-			"#\n",
-			git_path("MERGE_HEAD"));
-
-	fprintf(fp,
-		"\n"
-		"# Please enter the commit message for your changes.\n"
-		"# (Comment lines starting with '#' will not be included)\n");
+	if (!no_edit) {
+		if (in_merge)
+			fprintf(fp,
+				"#\n"
+				"# It looks like you may be committing a MERGE.\n"
+				"# If this is not correct, please remove the file\n"
+				"#	%s\n"
+				"# and try again.\n"
+				"#\n",
+				git_path("MERGE_HEAD"));
+		if (cleanup_mode != CLEANUP_NONE)
+			fprintf(fp,
+				"\n"
+				"# Please enter the commit message for your changes.\n");
+		if (cleanup_mode == CLEANUP_DEFAULT)
+			fprintf(fp,
+				"# (Comment lines starting with '#' will not be included)\n");
+	}
 	if (only_include_assumed)
 		fprintf(fp, "# %s\n", only_include_assumed);
 
@@ -431,10 +451,13 @@ static int message_is_empty(struct strbuf *sb, int start)
 	const char *nl;
 	int eol, i;
 
+	if (cleanup_mode == CLEANUP_NONE && sb->len)
+		return 0;
+
 	/* See if the template is just a prefix of the message. */
 	strbuf_init(&tmpl, 0);
 	if (template_file && strbuf_read_file(&tmpl, template_file, 0) > 0) {
-		stripspace(&tmpl, 1);
+		stripspace(&tmpl, !no_edit);
 		if (start + tmpl.len <= sb->len &&
 		    memcmp(tmpl.buf, sb->buf + start, tmpl.len) == 0)
 			start += tmpl.len;
@@ -587,6 +610,16 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		only_include_assumed = "Explicit paths specified without -i nor -o; assuming --only paths...";
 		also = 0;
 	}
+	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
+		cleanup_mode = CLEANUP_DEFAULT;
+	else if (!strcmp(cleanup_arg, "verbatim"))
+		cleanup_mode = CLEANUP_NONE;
+	else if (!strcmp(cleanup_arg, "whitespace"))
+		cleanup_mode = CLEANUP_SPACE;
+	else if (!strcmp(cleanup_arg, "strip"))
+		cleanup_mode = CLEANUP_ALL;
+	else
+		die("Invalid cleanup mode %s", cleanup_arg);
 
 	if (all && argc > 0)
 		die("Paths with -a does not make sense.");
@@ -813,7 +846,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (p != NULL)
 		strbuf_setlen(&sb, p - sb.buf + 1);
 
-	stripspace(&sb, 1);
+	if (cleanup_mode != CLEANUP_NONE)
+		stripspace(&sb, cleanup_mode == CLEANUP_DEFAULT ?
+			   !no_edit: cleanup_mode == CLEANUP_ALL);
 	if (sb.len < header_len || message_is_empty(&sb, header_len)) {
 		rollback_index_files();
 		die("no commit message?  aborting commit.");
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 21ac785..6219378 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -89,4 +89,44 @@ test_expect_success 'verbose' '
 
 '
 
+test_expect_success 'verbatim commit messages' '
+
+	echo >>negative &&
+	{ echo;echo "# text";echo; } >expect &&
+	git commit --cleanup=verbatim -t expect -a &&
+	git cat-file -p HEAD |sed -e "1,/^\$/d" |head -n 3 >actual &&
+	diff -u expect actual &&
+	echo >>negative &&
+	git commit --cleanup=verbatim -F expect -a &&
+	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	diff -u expect actual &&
+	echo >>negative &&
+	git commit --cleanup=verbatim -m "$(cat expect)" -a &&
+	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	diff -u expect actual
+
+'
+
+test_expect_success 'cleanup only whitespace from commit messages' '
+
+	echo >>negative &&
+	{ echo;echo "# text";echo; } >text &&
+	echo "# text" >expect &&
+	git commit --cleanup=whitespace -F text -a &&
+	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	diff -u expect actual
+
+'
+
+test_expect_success 'cleanup commit messages' '
+
+	echo >>negative &&
+	{ echo;echo "# text";echo sample;echo; } >text &&
+	echo sample >expect &&
+	git commit --cleanup=strip -F text -a &&
+	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	diff -u expect actual
+
+'
+
 test_done
-- 
1.5.4.rc1.36.g24341
