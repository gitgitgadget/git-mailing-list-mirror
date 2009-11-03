From: Erick Mattos <erick.mattos@gmail.com>
Subject: [PATCH] commit -c/-C/--amend: reset timestamp and authorship to committer with --reset-author
Date: Tue,  3 Nov 2009 19:09:11 -0200
Message-ID: <1257282551-9999-1-git-send-email-erick.mattos@gmail.com>
Cc: git@vger.kernel.org, Erick Mattos <erick.mattos@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 22:10:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5Qdj-0000JX-Jo
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 22:10:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435AbZKCVJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 16:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754249AbZKCVJy
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 16:09:54 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:59892 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104AbZKCVJx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 16:09:53 -0500
Received: by ywh40 with SMTP id 40so5791033ywh.33
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 13:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=1tNqzTYyYcmzf7lbnkuKevY5snJ9vXJeMotG+rl5yHQ=;
        b=ZqbUDOTBdZNwido3fq6n0i0HZxySDcWt2CMbq74Z403Wpe6SzIDNFDdp7GXurBPt+5
         +BQSNAaIeXUv38zbxdqxodtyPCdJjT2loDEJONYXFcMrnTZRMiBv0RTFPY++zfviFSE1
         cIgXGp1kqRG3iHYrE04HCajSTpz8VTOPxmXAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=NjAUig3GWt5+7Yevnc8dybC2K/oSGUZwYgQeuQvjWB2y7a3Up6LhXPb5fGQFTgIXJA
         3o3uWXib2Rj8dKg8NYEa+5o5A/Xwt4GhcjX3CM7tTMeYZBPEF8+wGL22G5n99eTjxcx/
         alqISzK6eFdN0WBcgtUUXlHirYiXKVakso5vM=
Received: by 10.91.159.22 with SMTP id l22mr1411183ago.9.1257282598374;
        Tue, 03 Nov 2009 13:09:58 -0800 (PST)
Received: from localhost.localdomain ([187.15.44.83])
        by mx.google.com with ESMTPS id 36sm191037yxh.49.2009.11.03.13.09.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Nov 2009 13:09:57 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.144.g1babf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131996>

When we use one of the options above we are normally trying to do mainly
two things: using the source as a template or recreating a commit with
corrections.

When they are used, the authorship and timestamp recorded in the newly
created commit are always taken from the original commit.  And they
should not when we are using it as a template or when our change to the
code is so significant that we should take over the authorship (with the
blame for bugs we introduce, of course).

The new --reset-author option is meant to solve this need by
regenerating the timestamp and setting as the new author the committer
or the one specified by --author option.

Signed-off-by: Erick Mattos <erick.mattos@gmail.com>
---
 Documentation/git-commit.txt |    7 +++-
 builtin-commit.c             |    9 +++-
 t/t7509-commit.sh            |   94 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+), 4 deletions(-)
 create mode 100755 t/t7509-commit.sh

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 0578a40..f89db9a 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend] [--dry-run]
-	   [(-c | -C) <commit>] [-F <file> | -m <msg>]
+	   [(-c | -C) <commit>] [-F <file> | -m <msg>] [--reset-author]
 	   [--allow-empty] [--no-verify] [-e] [--author=<author>]
 	   [--cleanup=<mode>] [--] [[-i | -o ]<file>...]
 
@@ -69,6 +69,11 @@ OPTIONS
 	Like '-C', but with '-c' the editor is invoked, so that
 	the user can further edit the commit message.
 
+--reset-author::
+	When used with -C/-c/--amend options, declare that the
+	authorship of the resulting commit now belongs of the committer.
+	This also renews the author timestamp.
+
 -F <file>::
 --file=<file>::
 	Take the commit message from the given file.  Use '-' to
diff --git a/builtin-commit.c b/builtin-commit.c
index beddf01..6b51a1b 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -51,7 +51,7 @@ static const char *template_file;
 static char *edit_message, *use_message;
 static char *author_name, *author_email, *author_date;
 static int all, edit_flag, also, interactive, only, amend, signoff;
-static int quiet, verbose, no_verify, allow_empty, dry_run;
+static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static char *untracked_files_arg;
 /*
  * The default commit message cleanup mode will remove the lines
@@ -91,8 +91,9 @@ static struct option builtin_commit_options[] = {
 	OPT_FILENAME('F', "file", &logfile, "read log from file"),
 	OPT_STRING(0, "author", &force_author, "AUTHOR", "override author for commit"),
 	OPT_CALLBACK('m', "message", &message, "MESSAGE", "specify commit message", opt_parse_m),
-	OPT_STRING('c', "reedit-message", &edit_message, "COMMIT", "reuse and edit message from specified commit "),
+	OPT_STRING('c', "reedit-message", &edit_message, "COMMIT", "reuse and edit message from specified commit"),
 	OPT_STRING('C', "reuse-message", &use_message, "COMMIT", "reuse message from specified commit"),
+	OPT_BOOLEAN(0, "reset-author", &renew_authorship, "reset timestamp and authorship to committer"),
 	OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
 	OPT_FILENAME('t', "template", &template_file, "use specified template file"),
 	OPT_BOOLEAN('e', "edit", &edit_flag, "force edit of commit"),
@@ -381,7 +382,7 @@ static void determine_author_info(void)
 	email = getenv("GIT_AUTHOR_EMAIL");
 	date = getenv("GIT_AUTHOR_DATE");
 
-	if (use_message) {
+	if (use_message && !renew_authorship) {
 		const char *a, *lb, *rb, *eol;
 
 		a = strstr(use_message_buffer, "\nauthor ");
@@ -780,6 +781,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		use_message = edit_message;
 	if (amend && !use_message)
 		use_message = "HEAD";
+	if (!use_message && renew_authorship)
+		die("Option --reset-author is used only with -C/-c/--amend.");
 	if (use_message) {
 		unsigned char sha1[20];
 		static char utf8[] = "UTF-8";
diff --git a/t/t7509-commit.sh b/t/t7509-commit.sh
new file mode 100755
index 0000000..7290242
--- /dev/null
+++ b/t/t7509-commit.sh
@@ -0,0 +1,94 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Erick Mattos
+#
+
+test_description='git commit
+
+Tests for --reset-author option on a commit.'
+
+. ./test-lib.sh
+
+TEST_FILE=foo
+
+test_expect_success '-C without --reset-author uses the author from the old commit' '
+	echo "initial" > "$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	git commit -m "Initial Commit" --author "Frigate <flying@over.world>" &&
+	test_tick &&
+	echo "Test 1" >> "$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	git commit -C HEAD &&
+	git cat-file -p HEAD^ | sed -e "/^parent/d" -e "/^tree/d" \
+		-e "/^committer/d" > commit_1 &&
+	git cat-file -p HEAD | sed -e "/^parent/d" -e "/^tree/d" \
+		-e "/^committer/d" > commit_2 &&
+	test_cmp commit_1 commit_2
+'
+
+test_expect_success '-C with --reset-author makes me the author' '
+	test_tick &&
+	echo "Test 2" >> "$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	git commit -C HEAD^ --reset-author &&
+	git cat-file -p HEAD^ | grep "^author" > commit_1 &&
+	git cat-file -p HEAD | grep "^author" > commit_2 &&
+	test "$(cat commit_1 | sed "s/.*> //")" !=\
+		"$(cat commit_2 | sed "s/.*> //")" &&
+	test "$(cat commit_2 | sed -e "s/author //" -e "s/>.*/>/")" =\
+		"$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>"
+'
+
+test_expect_success '-c without --reset-author uses the author from the old commit' '
+	echo "Initial" > "$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	git commit -m "Initial Commit" --author "Frigate <flying@over.world>" &&
+	test_tick &&
+	echo "Test 3" >> "$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	EDITOR=: VISUAL=: git commit -c HEAD
+	git cat-file -p HEAD^ | grep "^author" > commit_1 &&
+	git cat-file -p HEAD | grep "^author" > commit_2 &&
+	test_cmp commit_1 commit_2
+'
+
+test_expect_success '-c with --reset-author makes me the author' '
+	test_tick &&
+	echo "Test 4" >> "$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	EDITOR=: VISUAL=: git commit -c HEAD^ --reset-author
+	git cat-file -p HEAD^ | grep "^author" > commit_1 &&
+	git cat-file -p HEAD | grep "^author" > commit_2 &&
+	test "$(cat commit_1 | sed "s/.*> //")" !=\
+		"$(cat commit_2 | sed "s/.*> //")" &&
+	test "$(cat commit_2 | sed -e "s/author //" -e "s/>.*/>/")" =\
+		"$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>"
+'
+
+test_expect_success '--amend without --reset-author uses the author from the old commit' '
+	echo "Initial" > "$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	git commit -m "Initial Commit" --author "Frigate <flying@over.world>" &&
+	echo "Test 5" >> "$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	git commit -m "--amend test" &&
+	git cat-file -p HEAD | grep "^author" > commit_1 &&
+	test_tick &&
+	git commit -m "Changed" --amend &&
+	git cat-file -p HEAD | grep "^author" > commit_2 &&
+	test_cmp commit_1 commit_2
+'
+
+test_expect_success '--amend with --reset-author makes me the author' '
+	test_tick &&
+	echo "Test 6" >> "$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	git commit -m "Changed again" --amend --reset-author &&
+	git cat-file -p HEAD | grep "^author" > commit_1 &&
+	test "$(cat commit_1 | sed "s/.*> //")" !=\
+		"$(cat commit_2 | sed "s/.*> //")" &&
+	test "$(cat commit_2 | sed -e "s/author //" -e "s/>.*/>/")" =\
+		"$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>"
+'
+
+test_done
-- 
1.6.5.2.144.g1babf
