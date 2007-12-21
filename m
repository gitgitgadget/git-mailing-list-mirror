From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Allow selection of different cleanup modes for commit
	messages
Date: Fri, 21 Dec 2007 18:35:21 +0100
Message-ID: <20071221173521.GA3494@steel.home>
References: <20071220211835.GA3052@steel.home> <alpine.LFD.0.9999.0712201324270.21557@woody.linux-foundation.org> <7vlk7plydv.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.9999.0712201555570.21557@woody.linux-foundation.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Dec 21 18:36:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5lmq-0007o6-TV
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 18:35:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380AbXLURf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 12:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753219AbXLURf2
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 12:35:28 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:54464 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193AbXLURf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 12:35:27 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTvznCE=
Received: from tigra.home (Fca98.f.strato-dslnet.de [195.4.202.152])
	by post.webmailer.de (mrclete mo2) (RZmta 14.6)
	with ESMTP id Z069b6jBLDQXva ; Fri, 21 Dec 2007 18:35:22 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 6F899277AE;
	Fri, 21 Dec 2007 18:35:22 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 0B1F356D22; Fri, 21 Dec 2007 18:35:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0712201555570.21557@woody.linux-foundation.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69077>

The modes being default, verbatim, whitespace and strip. The default
mode depends on if the message is being edited and will either strip
whitespace and comments (if editor active) or just strip the
whitespace (for where the message is given explicitely).

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

---
Linus Torvalds, Fri, Dec 21, 2007 01:03:26 +0100:
> But for the case of actually using the built-in editing capability, we 
> don't have that choice, so I'd argue that regardless, we should make the 
> "--verbatim" switch be a three-way choice between (a) not touching things 
> at all, (b) touching up just whitespace, or (c) doing the full enchilada.
> 
> And if we introduce such a flag, then I think we can make the *default* 
> (in the absense of an explicit flag) be something like
> 
> 	if (no_edit)
> 		default = touch_up_just_whitespace;
> 	else
> 		default = whole_enchilada
> 
> and obviously it could also be a configuration option.

which makes it four-way choice...

> That way, you could always get the existing behaviour with
> 
> 	git commit --verbatim=full-enchilada -F my_message
> 
> (yeah, bad name - I'm not seriously suggesting it be called 
> "full-enchilada", and I'm also not sure the flag should be called 
> "--verbatim" any more if it has choices, it's more likely that we should 
> call it something like "--cleanup={verbatim,whitespace,strip}" or 
> something like that.

"verbatim", "whitespace", "strip", "default".

The patch is on top of my previos patches. Junio, if you wish, I can
squash and resend.

 Documentation/git-commit.txt |   15 ++++++---
 builtin-commit.c             |   69 +++++++++++++++++++++++++++++-------------
 t/t7502-commit.sh            |   28 +++++++++++++++--
 3 files changed, 83 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 862543f..ac2bfd5 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git-commit' [-a | --interactive] [-s] [-v] [-u]
 	   [(-c | -C) <commit> | -F <file> | -m <msg> | --amend]
 	   [--allow-empty] [--no-verify] [-e] [--author <author>]
-	   [--verbatim] [--] [[-i | -o ]<file>...]
+	   [--cleanup=<mode>] [--] [[-i | -o ]<file>...]
 
 DESCRIPTION
 -----------
@@ -95,10 +95,15 @@ OPTIONS
 	from making such a commit.  This option bypasses the safety, and
 	is primarily for use by foreign scm interface scripts.
 
---verbatim::
-	Inhibits stripping of leading and trailing spaces,
-	empty lines and #commentary from the commit message.
-	Implies --allow-empty.
+--cleanup=<mode>::
+	This option sets how the commit message is cleaned up.
+	The  '<mode>' can be one of 'verbatim', 'whitespace', 'strip',
+	and 'default'. The 'default' mode will strip leading and
+	trailing empty lines and #commentary from the commit message
+	only if the message is to be edited. Otherwise only whitespace
+	removed. The 'verbatim' mode wont change message at all,
+	'whitespace' removes just leading/trailing whitespace lines
+	and 'strip' removes both whitespace and commentary.
 
 -e|--edit::
 	The message taken from file with `-F`, command line with
diff --git a/builtin-commit.c b/builtin-commit.c
index eae7661..6f98537 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -47,7 +47,20 @@ static char *logfile, *force_author, *template_file;
 static char *edit_message, *use_message;
 static int all, edit_flag, also, interactive, only, amend, signoff;
 static int quiet, verbose, untracked_files, no_verify, allow_empty;
-static int verbatim_message;
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
@@ -89,7 +102,7 @@ static struct option builtin_commit_options[] = {
 	OPT_BOOLEAN(0, "amend", &amend, "amend previous commit"),
 	OPT_BOOLEAN(0, "untracked-files", &untracked_files, "show all untracked files"),
 	OPT_BOOLEAN(0, "allow-empty", &allow_empty, "ok to record an empty change"),
-	OPT_BOOLEAN(0, "verbatim", &verbatim_message, "do not strip spaces and #comments from message"),
+	OPT_STRING(0, "cleanup", &cleanup_arg, "default", "how to strip spaces and #comments from message"),
 
 	OPT_END()
 };
@@ -348,7 +361,7 @@ static int prepare_log_message(const char *index_file, const char *prefix)
 	if (fp == NULL)
 		die("could not open %s", git_path(commit_editmsg));
 
-	if (!verbatim_message)
+	if (cleanup_mode != CLEANUP_NONE)
 		stripspace(&sb, 0);
 
 	if (signoff) {
@@ -397,21 +410,24 @@ static int prepare_log_message(const char *index_file, const char *prefix)
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
-	if (!verbatim_message)
-		fprintf(fp,
-			"\n"
-			"# Please enter the commit message for your changes.\n"
-			"# (Comment lines starting with '#' will not be included)\n");
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
 
@@ -435,7 +451,7 @@ static int message_is_empty(struct strbuf *sb, int start)
 	const char *nl;
 	int eol, i;
 
-	if (verbatim_message && sb->len)
+	if (cleanup_mode == CLEANUP_NONE && sb->len)
 		return 0;
 
 	/* See if the template is just a prefix of the message. */
@@ -594,6 +610,16 @@ static int parse_and_validate_options(int argc, const char *argv[],
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
@@ -820,8 +846,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (p != NULL)
 		strbuf_setlen(&sb, p - sb.buf + 1);
 
-	if (!verbatim_message)
-		stripspace(&sb, !no_edit);
+	if (cleanup_mode != CLEANUP_NONE)
+		stripspace(&sb, cleanup_mode == CLEANUP_DEFAULT ?
+			   !no_edit: cleanup_mode == CLEANUP_ALL);
 	if (sb.len < header_len || message_is_empty(&sb, header_len)) {
 		rollback_index_files();
 		die("no commit message?  aborting commit.");
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index d549728..6219378 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -93,15 +93,37 @@ test_expect_success 'verbatim commit messages' '
 
 	echo >>negative &&
 	{ echo;echo "# text";echo; } >expect &&
-	git commit --verbatim -t expect -a &&
+	git commit --cleanup=verbatim -t expect -a &&
 	git cat-file -p HEAD |sed -e "1,/^\$/d" |head -n 3 >actual &&
 	diff -u expect actual &&
 	echo >>negative &&
-	git commit --verbatim -F expect -a &&
+	git commit --cleanup=verbatim -F expect -a &&
 	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
 	diff -u expect actual &&
 	echo >>negative &&
-	git commit --verbatim -m "$(cat expect)" -a &&
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
 	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
 	diff -u expect actual
 
-- 
1.5.4.rc1.34.gf21f1
