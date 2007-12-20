From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] git-commit: add --verbatim to allow unstripped commit
	messages
Date: Fri, 21 Dec 2007 00:35:39 +0100
Message-ID: <20071220233539.GC3052@steel.home>
References: <20071220211835.GA3052@steel.home> <alpine.LFD.0.9999.0712201324270.21557@woody.linux-foundation.org> <20071220233324.GB3052@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Dec 21 00:36:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5Uvy-0005ei-KL
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 00:36:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752941AbXLTXfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 18:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753083AbXLTXfq
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 18:35:46 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:54316 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958AbXLTXfq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 18:35:46 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTvznCE=
Received: from tigra.home (Fca98.f.strato-dslnet.de [195.4.202.152])
	by post.webmailer.de (fruni mo27) (RZmta 14.6)
	with ESMTP id k0366fjBKLvQGs ; Fri, 21 Dec 2007 00:35:39 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id BCFAC277AE;
	Fri, 21 Dec 2007 00:35:39 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id A093856D22; Fri, 21 Dec 2007 00:35:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071220233324.GB3052@steel.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69023>

Sometimes the message just have to be the way user wants it.
For instance, a template can contain "#" characters, or the message
must be kept as close to its original source as possible for reimport
reasons. Or maybe the user just copied a shell script including its
comments into the commit message for future reference.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Updated patch. It conflicts with yours a bit. Will update it

 Documentation/git-commit.txt |    7 ++++++-
 builtin-commit.c             |   20 ++++++++++++++------
 t/t7502-commit.sh            |   18 ++++++++++++++++++
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 4261384..862543f 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git-commit' [-a | --interactive] [-s] [-v] [-u]
 	   [(-c | -C) <commit> | -F <file> | -m <msg> | --amend]
 	   [--allow-empty] [--no-verify] [-e] [--author <author>]
-	   [--] [[-i | -o ]<file>...]
+	   [--verbatim] [--] [[-i | -o ]<file>...]
 
 DESCRIPTION
 -----------
@@ -95,6 +95,11 @@ OPTIONS
 	from making such a commit.  This option bypasses the safety, and
 	is primarily for use by foreign scm interface scripts.
 
+--verbatim::
+	Inhibits stripping of leading and trailing spaces,
+	empty lines and #commentary from the commit message.
+	Implies --allow-empty.
+
 -e|--edit::
 	The message taken from file with `-F`, command line with
 	`-m`, and from file with `-C` are usually used as the
diff --git a/builtin-commit.c b/builtin-commit.c
index 0a91013..3127247 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -47,6 +47,7 @@ static char *logfile, *force_author, *template_file;
 static char *edit_message, *use_message;
 static int all, edit_flag, also, interactive, only, amend, signoff;
 static int quiet, verbose, untracked_files, no_verify, allow_empty;
+static int verbatim_message;
 
 static int no_edit, initial_commit, in_merge;
 const char *only_include_assumed;
@@ -88,6 +89,7 @@ static struct option builtin_commit_options[] = {
 	OPT_BOOLEAN(0, "amend", &amend, "amend previous commit"),
 	OPT_BOOLEAN(0, "untracked-files", &untracked_files, "show all untracked files"),
 	OPT_BOOLEAN(0, "allow-empty", &allow_empty, "ok to record an empty change"),
+	OPT_BOOLEAN(0, "verbatim", &verbatim_message, "do not strip spaces and #comments from message"),
 
 	OPT_END()
 };
@@ -346,7 +348,8 @@ static int prepare_log_message(const char *index_file, const char *prefix)
 	if (fp == NULL)
 		die("could not open %s", git_path(commit_editmsg));
 
-	stripspace(&sb, 0);
+	if (!verbatim_message)
+		stripspace(&sb, 0);
 
 	if (signoff) {
 		struct strbuf sob;
@@ -404,10 +407,11 @@ static int prepare_log_message(const char *index_file, const char *prefix)
 			"#\n",
 			git_path("MERGE_HEAD"));
 
-	fprintf(fp,
-		"\n"
-		"# Please enter the commit message for your changes.\n"
-		"# (Comment lines starting with '#' will not be included)\n");
+	if (!verbatim_message)
+		fprintf(fp,
+			"\n"
+			"# Please enter the commit message for your changes.\n"
+			"# (Comment lines starting with '#' will not be included)\n");
 	if (only_include_assumed)
 		fprintf(fp, "# %s\n", only_include_assumed);
 
@@ -431,6 +435,9 @@ static int message_is_empty(struct strbuf *sb, int start)
 	const char *nl;
 	int eol, i;
 
+	if (verbatim_message && sb->len)
+		return 1;
+
 	/* See if the template is just a prefix of the message. */
 	strbuf_init(&tmpl, 0);
 	if (template_file && strbuf_read_file(&tmpl, template_file, 0) > 0) {
@@ -813,7 +820,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (p != NULL)
 		strbuf_setlen(&sb, p - sb.buf + 1);
 
-	stripspace(&sb, 1);
+	if (!verbatim_message)
+		stripspace(&sb, 1);
 	if (sb.len < header_len || message_is_empty(&sb, header_len)) {
 		rollback_index_files();
 		die("no commit message?  aborting commit.");
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 21ac785..d549728 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -89,4 +89,22 @@ test_expect_success 'verbose' '
 
 '
 
+test_expect_success 'verbatim commit messages' '
+
+	echo >>negative &&
+	{ echo;echo "# text";echo; } >expect &&
+	git commit --verbatim -t expect -a &&
+	git cat-file -p HEAD |sed -e "1,/^\$/d" |head -n 3 >actual &&
+	diff -u expect actual &&
+	echo >>negative &&
+	git commit --verbatim -F expect -a &&
+	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	diff -u expect actual &&
+	echo >>negative &&
+	git commit --verbatim -m "$(cat expect)" -a &&
+	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	diff -u expect actual
+
+'
+
 test_done
-- 
1.5.4.rc1.33.gbd32b
