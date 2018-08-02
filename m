Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AF271F597
	for <e@80x24.org>; Thu,  2 Aug 2018 11:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbeHBNLB (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 09:11:01 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:26285 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbeHBNLA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 09:11:00 -0400
Received: from lindisfarne.localdomain ([92.22.30.174])
        by smtp.talktalk.net with SMTP
        id lBeMfoYRtbZX5lBeSf1fz9; Thu, 02 Aug 2018 12:20:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533208817;
        bh=CxcTtJU5dgBnoIOYQQ4Z/fRLzGj5QKCV7CIRo3mf+7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=GPU21kSR6pLoAdbJGXVwdOnd2+RjvJb1DJV4NaotHfNJrAJJvRdazf/a5QM/3YJwK
         1+Ajv59h9ZDUEiCDqfL4Dq2aESQnA0MuyDPPv0kV+LUDtAWZLoz7UHHtVcEL6gWxsL
         mXOJWsZP2Xe2G6A7V/ouDSqQM0EoevuYXegm1eY8=
X-Originating-IP: [92.22.30.174]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=2xfjePbNG5I+/HyESt+5YA==:117
 a=2xfjePbNG5I+/HyESt+5YA==:17 a=evINK-nbAAAA:8 a=A1X0JdhQAAAA:8
 a=2CNv0cFdGKX21CVlXIwA:9 a=TNeCFR7-0hSKOHFO:21 a=Mz1bClHbbt0fp4fe:21
 a=RfR_gqz1fSpA9VikTjo0:22 a=Df3jFdWbhGDLdZNm0fyq:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 2/2] sequencer: fix quoting in write_author_script
Date:   Thu,  2 Aug 2018 12:20:02 +0100
Message-Id: <20180802112002.720-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180802112002.720-1-phillip.wood@talktalk.net>
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180802112002.720-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfBMpVCbrbIf2C+Qug5XxR/F3gJvsgkZLX+5m7+AbJDRdL2fpPS8G6hw5qBNezEJRxXnbgjACnS6QQbKDpZXe3niCMt5SsrCKxBriYVlj+ewMQmnTV9P/
 OBJf7lxiEjCsY7pm40pzkg/PLlH+GP6zZwcxmOVFZ64bx86FM9RSlxVloLNZxN9FKLni1lKd5iTolOfjA19gZ0hMwt8Z8ZKwiJtV3S5jTCk2t/yqcRxWGgki
 rLH9bw1Nq4y2Zyy64xEqRNLDBMJUBCagAnz7mxpnt6V4DXAinYNO0NWRHaTdzrRQkQI+F3AUjdNxd5XCguq7m/elAxtl1icQkDtgLxPi8kM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Single quotes should be escaped as \' not \\'. The bad quoting breaks
the interactive version of 'rebase --root' (which is used when there is
no '--onto' even if the user does not specify --interactive) for authors
that contain "'" as sq_dequote() called read_author_ident() errors out
on the bad quoting.

For other interactive rebases this only affects external scripts that
read the author script and users whose git is upgraded from the shell
version of rebase -i while rebase was stopped when the author contains
"'". This is because the parsing in read_env_script() expected the
broken quoting.

This patch includes code to gracefully handle the broken quoting when
git has been upgraded while rebase was stopped. It does this by
recording a version number (currently 1) in
$GIT_DIR/rebase-merge/interactive to indicate that the author-script
was created with correct quoting. Previously this file was always
empty. The fallback path also fixes any missing "'" at the end of the
GIT_AUTHOR_DATE line.

The fallback code has been manually tested by reverting the quoting
fixes in write_author_script() with and without reverting the previous
fix for the missing "'" at the end of the GIT_AUTHOR_DATE line and
running t3404-rebase-interactive.sh.

Ideally rebase and am would share the same code for reading and
writing the author script, but this commit just fixes the immediate
bug.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    Changes since v2:
    
     - Changed the way it detects and handles broken quoting when git
       is upgraded while rebase is stopped. This means that the fix for
       quoting is no longer tied to the fix for the trailing "'" on the
       GIT_AUTHOR_DATE line. It now also fixes broken quoting in
       read_author_ident() which would error out with the last version.
     - Changed the tests for authors that contain "'". If sq_dequote() and
       parse the author script then the shell should be able to and the
       most important thing is to check that the author in the new commit
       is correct.
     - Fixed an existing memory leak
    
    Note Eric expressed concerns about using a version number, but I had
    already written this code so I thought I send it and see how people
    felt about the additionally complexity. I like the fact that it
    decouple the quoting fix from Eric's patches. In the end the extra
    code is just reading an integer from a text file. The test for adding
    the trailing quote to the author script is quite strict can be
    defeated by a badly edited author script but hopefully that is
    unlikely as it is only invoked if git got upgraded while rebase was
    stopped.

 git-rebase--interactive.sh    |  2 +-
 sequencer.c                   | 89 +++++++++++++++++++++++++++++++----
 sequencer.h                   |  1 +
 t/t3404-rebase-interactive.sh | 20 ++++++--
 4 files changed, 97 insertions(+), 15 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 06a7b79307..c1e3f947a5 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -880,7 +880,7 @@ init_basic_state () {
 	mkdir -p "$state_dir" || die "$(eval_gettext "Could not create temporary \$state_dir")"
 	rm -f "$(git rev-parse --git-path REBASE_HEAD)"
 
-	: > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"
+	echo 1 > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"
 	write_basic_state
 }
 
diff --git a/sequencer.c b/sequencer.c
index 1bf8b0c431..2599f9d80e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -44,6 +44,12 @@ static GIT_PATH_FUNC(git_path_head_file, "sequencer/head")
 static GIT_PATH_FUNC(git_path_abort_safety_file, "sequencer/abort-safety")
 
 static GIT_PATH_FUNC(rebase_path, "rebase-merge")
+/*
+ * This file indicates that an interactive rebase is in progress, if it contians
+ * an integer then that is a version indicator for the contents of files in
+ * .git/rebase-merge
+ */
+static GIT_PATH_FUNC(rebase_path_interactive, "rebase-merge/interactive")
 /*
  * The file containing rebase commands, comments, and empty lines.
  * This file is created by "git rebase -i" then edited by the user. As
@@ -636,42 +642,79 @@ static int write_author_script(const char *message)
 		else if (*message != '\'')
 			strbuf_addch(&buf, *(message++));
 		else
-			strbuf_addf(&buf, "'\\\\%c'", *(message++));
+			strbuf_addf(&buf, "'\\%c'", *(message++));
 	strbuf_addstr(&buf, "'\nGIT_AUTHOR_EMAIL='");
 	while (*message && *message != '\n' && *message != '\r')
 		if (skip_prefix(message, "> ", &message))
 			break;
 		else if (*message != '\'')
 			strbuf_addch(&buf, *(message++));
 		else
-			strbuf_addf(&buf, "'\\\\%c'", *(message++));
+			strbuf_addf(&buf, "'\\%c'", *(message++));
 	strbuf_addstr(&buf, "'\nGIT_AUTHOR_DATE='@");
 	while (*message && *message != '\n' && *message != '\r')
 		if (*message != '\'')
 			strbuf_addch(&buf, *(message++));
 		else
-			strbuf_addf(&buf, "'\\\\%c'", *(message++));
+			strbuf_addf(&buf, "'\\%c'", *(message++));
 	strbuf_addch(&buf, '\'');
 	res = write_message(buf.buf, buf.len, rebase_path_author_script(), 1);
 	strbuf_release(&buf);
 	return res;
 }
 
+/*
+ * write_author_script() used to fail to terminate the GIT_AUTHOR_DATE line with
+ * a "'" and also escaped "'" incorrectly as "'\\\\''" rather than "'\\''". Fix
+ * these problems before dequoting in when git was upgraded while rebase was
+ * stopped.
+ */
+static int fix_bad_author_script(struct strbuf *script)
+{
+	const char *next;
+	size_t off = 0;
+
+	while ((next = strstr(script->buf + off, "'\\\\''"))) {
+		off = next - script->buf + 4;
+		strbuf_splice(script, next - script->buf, 5,"'\\''", 4);
+	}
+
+	if ((next = strstr(script->buf, "\nGIT_AUTHOR_DATE='")) &&
+	    (next = strchr(++next, '\n')) &&
+	    ++next - script->buf == script->len) {
+		if (script->buf[script->len - 2] != '\'')
+			strbuf_insert(script, script->len - 1, "'", 1);
+	} else {
+		return error(_("unable to parse '%s'"),
+			     rebase_path_author_script());
+	}
+
+	return 0;
+}
+
 /*
  * Read a list of environment variable assignments (such as the author-script
  * file) into an environment block. Returns -1 on error, 0 otherwise.
  */
-static int read_env_script(struct argv_array *env)
+static int read_env_script(struct replay_opts *opts, struct argv_array *env)
 {
 	struct strbuf script = STRBUF_INIT;
 	int i, count = 0;
-	char *p, *p2;
+	const char *p2;
+	char *p;
 
-	if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0)
+	if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0) {
+		strbuf_release(&script);
 		return -1;
+	}
+
+	if (!opts->version && fix_bad_author_script(&script)) {
+		strbuf_release(&script);
+		return -1;
+	}
 
 	for (p = script.buf; *p; p++)
-		if (skip_prefix(p, "'\\\\''", (const char **)&p2))
+		if (skip_prefix(p, "'\\''", &p2))
 			strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);
 		else if (*p == '\'')
 			strbuf_splice(&script, p-- - script.buf, 1, "", 0);
@@ -701,7 +744,7 @@ static char *get_author(const char *message)
 }
 
 /* Read author-script and return an ident line (author <email> timestamp) */
-static int read_author_ident(char **author)
+static int read_author_ident(struct replay_opts *opts, char **author)
 {
 	const char *keys[] = {
 		"GIT_AUTHOR_NAME=", "GIT_AUTHOR_EMAIL=", "GIT_AUTHOR_DATE="
@@ -717,6 +760,11 @@ static int read_author_ident(char **author)
 		return -1;
 	}
 
+	if (!opts->version && fix_bad_author_script(&buf)) {
+		strbuf_release(&buf);
+		return -1;
+	}
+
 	for (in = buf.buf; i < 3 && in - buf.buf < buf.len; i++) {
 		if (!skip_prefix(in, keys[i], (const char **)&in)) {
 			strbuf_release(&buf);
@@ -801,7 +849,7 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 		struct object_id root_commit, *cache_tree_oid;
 		int res = 0;
 
-		if (is_rebase_i(opts) && read_author_ident(&author))
+		if (is_rebase_i(opts) && read_author_ident(opts, &author))
 			return -1;
 
 		if (!defmsg)
@@ -839,7 +887,7 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 			cmd.err = -1;
 		}
 
-		if (read_env_script(&cmd.env_array)) {
+		if (read_env_script(opts, &cmd.env_array)) {
 			const char *gpg_opt = gpg_sign_opt_quoted(opts);
 
 			return error(_(staged_changes_advice),
@@ -2238,6 +2286,27 @@ static int read_populate_opts(struct replay_opts *opts)
 	if (is_rebase_i(opts)) {
 		struct strbuf buf = STRBUF_INIT;
 
+		if (read_oneliner(&buf, rebase_path_interactive(), 0)) {
+			if (buf.len) {
+				char *end;
+				long version = strtol(buf.buf, &end, 10);
+				if (version < 1 ||version > INT_MAX ||
+				    *end != '\0') {
+					strbuf_release(&buf);
+					return error(_("unable to parse '%s'"),
+						     rebase_path_interactive());
+				}
+				opts->version = (int)version;
+			} else {
+				opts->version = 0;
+			}
+			strbuf_reset(&buf);
+		} else {
+			strbuf_release(&buf);
+			return error(_("unable to read '%s'"),
+				     rebase_path_interactive());
+		}
+
 		if (read_oneliner(&buf, rebase_path_gpg_sign_opt(), 1)) {
 			if (!starts_with(buf.buf, "-S"))
 				strbuf_reset(&buf);
diff --git a/sequencer.h b/sequencer.h
index c5787c6b56..24d69e7ff7 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -34,6 +34,7 @@ struct replay_opts {
 	int keep_redundant_commits;
 	int verbose;
 
+	int version;
 	int mainline;
 
 	char *gpg_sign;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index b72167ecd5..4e2e787f26 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -75,6 +75,7 @@ test_expect_success 'rebase --keep-empty' '
 	test_line_count = 6 actual
 '
 
+SQ="'"
 test_expect_success 'rebase -i with the exec command' '
 	git checkout master &&
 	(
@@ -1361,7 +1362,6 @@ test_expect_success 'editor saves as CR/LF' '
 	)
 '
 
-SQ="'"
 test_expect_success 'rebase -i --gpg-sign=<key-id>' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	set_fake_editor &&
@@ -1382,9 +1382,21 @@ test_expect_success 'rebase -i --gpg-sign=<key-id> overrides commit.gpgSign' '
 test_expect_success 'valid author header after --root swap' '
 	rebase_setup_and_clean author-header no-conflict-branch &&
 	set_fake_editor &&
-	FAKE_LINES="2 1" git rebase -i --root &&
-	git cat-file commit HEAD^ >out &&
-	grep "^author ..*> [0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$" out
+	git commit --amend --author="Au ${SQ}thor <author@example.com>" --no-edit &&
+	git cat-file commit HEAD | grep ^author >expected &&
+	FAKE_LINES="5 1" git rebase -i --root &&
+	git cat-file commit HEAD^ | grep ^author >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'valid author header when author contains single quote' '
+	rebase_setup_and_clean author-header no-conflict-branch &&
+	set_fake_editor &&
+	git commit --amend --author="Au ${SQ}thor <author@example.com>" --no-edit &&
+	git cat-file commit HEAD | grep ^author >expected &&
+	FAKE_LINES="1 5" git rebase -i --root &&
+	git cat-file commit HEAD | grep ^author >actual &&
+	test_cmp expected actual
 '
 
 test_done
-- 
2.18.0

