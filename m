Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 21201 invoked by uid 107); 28 Feb 2010 00:11:36 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sat, 27 Feb 2010 19:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030951Ab0B1ALN (ORCPT <rfc822;peff@peff.net>);
	Sat, 27 Feb 2010 19:11:13 -0500
Received: from ananke.wxnz.net ([58.28.4.122]:53134 "EHLO ananke.wxnz.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030928Ab0B1ALM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 19:11:12 -0500
Received: from localhost.localdomain (ip-118-90-92-73.xdsl.xnet.co.nz [118.90.92.73])
	by ananke.wxnz.net (Postfix) with ESMTP id B4B2E170643
	for <git@vger.kernel.org>; Sun, 28 Feb 2010 13:11:10 +1300 (NZDT)
From:	Steven Drake <sdrake@xnet.co.nz>
To:	git@vger.kernel.org
Subject: [PATCH 1/1] Add commit log message spell checking feature.
Date:	Sun, 28 Feb 2010 13:03:00 +1300
Message-Id: <7e21d6cd64aa088763c3ff11d6cbe78899ae7f10.1267314986.git.sdrake@xnet.co.nz>
X-Mailer: git-send-email 1.6.6
In-Reply-To: <alpine.LNX.2.00.1002281258340.15334@vqena.qenxr.bet.am>
References: <alpine.LNX.2.00.1002281258340.15334@vqena.qenxr.bet.am>
To:	git@vger.kernel.org
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org
X-Status: A

Add 'git commit --spell' to run a spell checker on commit log message.
The `commit.spell` configuration variable can be used to enable the spell
checker by default and can be turned off by '--no-spell'.

The spell checker shell command to run is specified by the
`commit.spellcommand` configuration variable and defaults to `ispell`.

Because it is assumed that the spell checker is an interactive command spell
checking is only done if stdio is a terminal.

Signed-off-by: Steven Drake <sdrake@xnet.co.nz>
---
The above commit log message was spell check using this feature.

 Documentation/config.txt     |    9 +++++++++
 Documentation/git-commit.txt |    8 ++++++++
 builtin/commit.c             |   33 ++++++++++++++++++++++++++++++++-
 3 files changed, 49 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 793c9a8..f977a45 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -737,6 +737,15 @@ color.ui::
 	terminal. When more specific variables of color.* are set, they always
 	take precedence over this setting. Defaults to false.
 
+commit.spell::
+	A boolean to enable/disable running of the spell checker on commit
+	log message. Defaults to false.
+
+commit.spellcommand::
+	Shell command to run as the spell checker. First argument given to
+	the command is the name of the file containing the commit log message.
+	Defaults to `ispell`.  See 'ispell(1)'.
+
 commit.status::
 	A boolean to enable/disable inclusion of status information in the
 	commit message template when using an editor to prepare the commit
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 64fb458..d68106f 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -120,6 +120,14 @@ OPTIONS
 	Add Signed-off-by line by the committer at the end of the commit
 	log message.
 
+--spell::
+	Run the spell checker on commit log message. This overrides the
+	`commit.spell` configuration variable.
+
+--no-spell::
+	Do not run the spell checker on commit log message. This overrides the
+	`commit.spell` configuration variable.
+
 -n::
 --no-verify::
 	This option bypasses the pre-commit and commit-msg hooks.
diff --git a/builtin/commit.c b/builtin/commit.c
index 8dd104e..272faa7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -66,7 +66,8 @@ static char *edit_message, *use_message;
 static char *author_name, *author_email, *author_date;
 static int all, edit_flag, also, interactive, only, amend, signoff;
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
-static int no_post_rewrite;
+static int no_post_rewrite, spell_check;
+static const char *spell_command = (const char*)"ispell";
 static char *untracked_files_arg, *force_date;
 /*
  * The default commit message cleanup mode will remove the lines
@@ -93,6 +94,11 @@ static enum {
 	STATUS_FORMAT_PORCELAIN,
 } status_format = STATUS_FORMAT_LONG;
 
+static inline int have_terminal(void)
+{
+	return (isatty(0) && isatty(1) && isatty(2));
+}
+
 static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 {
 	struct strbuf *buf = opt->value;
@@ -118,6 +124,7 @@ static struct option builtin_commit_options[] = {
 	OPT_STRING('C', "reuse-message", &use_message, "COMMIT", "reuse message from specified commit"),
 	OPT_BOOLEAN(0, "reset-author", &renew_authorship, "the commit is authored by me now (used with -C-c/--amend)"),
 	OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
+	OPT_BOOLEAN(0, "spell", &spell_check, "run spell checker on commit message"),
 	OPT_FILENAME('t', "template", &template_file, "use specified template file"),
 	OPT_BOOLEAN('e', "edit", &edit_flag, "force edit of commit"),
 	OPT_STRING(0, "cleanup", &cleanup_arg, "default", "how to strip spaces and #comments from message"),
@@ -525,6 +532,21 @@ static int ends_rfc2822_footer(struct strbuf *sb)
 	return 1;
 }
 
+static int spell_checker(const char *commit_editmsg)
+{
+	const char *terminal = getenv("TERM");
+	int terminal_is_dumb = !terminal || !strcmp(terminal, "dumb");
+
+	if (terminal_is_dumb || !have_terminal()) {
+		error("No Terminal, can not run spell checker");
+		return 0;
+	}
+
+	const char *args[] = { spell_command, commit_editmsg, NULL };
+
+	return run_command_v_opt(args, RUN_USING_SHELL);
+}
+
 static int prepare_to_commit(const char *index_file, const char *prefix,
 			     struct wt_status *s)
 {
@@ -726,6 +748,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		}
 	}
 
+	if (spell_check && spell_checker(git_path(commit_editmsg)))
+		return 0;
+
 	if (!no_verify &&
 	    run_hook(index_file, "commit-msg", git_path(commit_editmsg), NULL)) {
 		return 0;
@@ -1154,6 +1179,12 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 
 	if (!strcmp(k, "commit.template"))
 		return git_config_pathname(&template_file, k, v);
+	if (!strcmp(k, "commit.spell")) {
+		spell_check = git_config_bool(k, v);
+		return 0;
+	}
+	if (!strcmp(k, "commit.spellcommand"))
+		return git_config_string(&spell_command, k, v);
 	if (!strcmp(k, "commit.status")) {
 		include_status = git_config_bool(k, v);
 		return 0;
-- 
1.7.0.323.g7e21d

