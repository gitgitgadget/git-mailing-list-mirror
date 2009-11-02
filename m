From: Erick Mattos <erick.mattos@gmail.com>
Subject: [PATCH] commit -c/-C/--amend: reset timestamp and authorship to committer with --mine
Date: Sun,  1 Nov 2009 22:44:20 -0200
Message-ID: <1257122660-21350-1-git-send-email-erick.mattos@gmail.com>
References: <55bacdd30911011514r1be6e09fobe2751588ed5166e@mail.gmail.com>
Cc: git@vger.kernel.org, Erick Mattos <erick.mattos@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 01:45:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4l33-0000kY-86
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 01:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571AbZKBApQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2009 19:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752406AbZKBApQ
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 19:45:16 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:40694 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371AbZKBApP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2009 19:45:15 -0500
Received: by yxe17 with SMTP id 17so4107386yxe.33
        for <git@vger.kernel.org>; Sun, 01 Nov 2009 16:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=b5DylnLmBkQe5P9WVSYHWyb4L/ycG2G6ojPyBjeWHSY=;
        b=MMlIW1eZ/D65Q6o270YRLHdww/DgrU3PfA3L3Ww9oPV6brzWwFuRtvLEFs8rKtx2+R
         CGSUwOBMrpzrRLmaX60q/H2B9koc8djAGKIiDxQ50Gcv94vh71fujV75n6RpytQkb1z/
         5OHFzTsB3LZYmfdcoZv050Ny1Onc41n+xWg3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=afVZ2k45h+1jpSqZYJWpb6mn88DRQngTox7VqzvTPJgTFdd+FpkDS+bsTHYMnkXU5i
         Fq50DYxWq6TykC9hbEOOF4evxu5d161Wr6eU34WOy0MAIhrsFIfx/wYvFfGWTvKn3B9l
         m7e/89TfRDZMjXVjM0kLcDKwQrI6YjqwWsExc=
Received: by 10.150.237.10 with SMTP id k10mr7313655ybh.112.1257122720388;
        Sun, 01 Nov 2009 16:45:20 -0800 (PST)
Received: from localhost.localdomain ([187.15.76.58])
        by mx.google.com with ESMTPS id 8sm1923408ywg.49.2009.11.01.16.45.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 01 Nov 2009 16:45:19 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.102.gdbd78.dirty
In-Reply-To: <55bacdd30911011514r1be6e09fobe2751588ed5166e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131886>

When we use one of the options above we are normally trying to do mainly
two things: one is using the source as a template and second is to
recreate a commit with corrections.

When they are used, the authorship and timestamp recorded in the newly
created commit is always taken from the original commit.  And they
should not when we are using it as a template.

The new --mine option is meant to solve this need by regenerating the
timestamp and setting as new author the committer or the one specified
on --author option.

Signed-off-by: Erick Mattos <erick.mattos@gmail.com>
---
 Documentation/git-commit.txt |    8 +++-
 builtin-commit.c             |    9 +++-
 t/t7509-commit.sh            |   98 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+), 4 deletions(-)
 create mode 100755 t/t7509-commit.sh

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 0578a40..eae5bf4 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend] [--dry-run]
-	   [(-c | -C) <commit>] [-F <file> | -m <msg>]
+	   [(-c | -C) <commit>] [-F <file> | -m <msg>] [--mine]
 	   [--allow-empty] [--no-verify] [-e] [--author=<author>]
 	   [--cleanup=<mode>] [--] [[-i | -o ]<file>...]
 
@@ -69,6 +69,12 @@ OPTIONS
 	Like '-C', but with '-c' the editor is invoked, so that
 	the user can further edit the commit message.
 
+--mine::
+	When used with -C/-c/--amend options, declare that the
+	authorship of the resulting commit now belongs of the committer.
+	This also renews the author timestamp.  Therefore this option
+	sets the use of only the message from the original commit.
+
 -F <file>::
 --file=<file>::
 	Take the commit message from the given file.  Use '-' to
diff --git a/builtin-commit.c b/builtin-commit.c
index c395cbf..17a6794 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -51,7 +51,7 @@ static const char *template_file;
 static char *edit_message, *use_message;
 static char *author_name, *author_email, *author_date;
 static int all, edit_flag, also, interactive, only, amend, signoff;
-static int quiet, verbose, no_verify, allow_empty, dry_run;
+static int quiet, verbose, no_verify, allow_empty, dry_run, mine;
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
+	OPT_BOOLEAN(0, "mine", &mine, "reset timestamp and authorship to committer"),
 	OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
 	OPT_FILENAME('t', "template", &template_file, "use specified template file"),
 	OPT_BOOLEAN('e', "edit", &edit_flag, "force edit of commit"),
@@ -381,7 +382,7 @@ static void determine_author_info(void)
 	email = getenv("GIT_AUTHOR_EMAIL");
 	date = getenv("GIT_AUTHOR_DATE");
 
-	if (use_message) {
+	if (use_message && !mine) {
 		const char *a, *lb, *rb, *eol;
 
 		a = strstr(use_message_buffer, "\nauthor ");
@@ -778,6 +779,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		use_message = edit_message;
 	if (amend && !use_message)
 		use_message = "HEAD";
+	if (!use_message && mine)
+		die("Option --mine is used only with -C/-c/--amend.");
 	if (use_message) {
 		unsigned char sha1[20];
 		static char utf8[] = "UTF-8";
diff --git a/t/t7509-commit.sh b/t/t7509-commit.sh
new file mode 100755
index 0000000..514de6a
--- /dev/null
+++ b/t/t7509-commit.sh
@@ -0,0 +1,98 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Erick Mattos
+#
+
+test_description='git commit
+
+Tests for --mine option on a commit.'
+
+. ./test-lib.sh
+
+TEST_FILE=foo
+
+test_expect_success '-C without --mine uses the author from the old commit' '
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
+test_expect_success '-C with --mine makes me the author' '
+	test_tick &&
+	echo "Test 2" >> "$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	git commit -C HEAD^ --mine &&
+	git cat-file -p HEAD^ | grep "^author" > commit_1 &&
+	git cat-file -p HEAD | grep "^author" > commit_2 &&
+	test "$(cat commit_1 | sed "s/.*> //")" !=\
+		"$(cat commit_2 | sed "s/.*> //")" &&
+	test "$(cat commit_2 | sed -e "s/author //" -e "s/>.*/>/")" =\
+		"$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>"
+'
+
+test_expect_success '-c without --mine uses the author from the old commit' '
+	echo "Initial" > "$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	git commit -m "Initial Commit" --author "Frigate <flying@over.world>" &&
+	test_tick &&
+	echo "Test 3" >> "$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	git commit -c HEAD <<EOF
+	"Changed" 
+	EOF &&
+	git cat-file -p HEAD^ | grep "^author" > commit_1 &&
+	git cat-file -p HEAD | grep "^author" > commit_2 &&
+	test_cmp commit_1 commit_2
+'
+
+test_expect_success '-c with --mine makes me the author' '
+	test_tick &&
+	echo "Test 4" >> "$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	git commit -c HEAD^ --mine <<EOF
+	"Changed again" 
+	EOF &&
+	git cat-file -p HEAD^ | grep "^author" > commit_1 &&
+	git cat-file -p HEAD | grep "^author" > commit_2 &&
+	test "$(cat commit_1 | sed "s/.*> //")" !=\
+		"$(cat commit_2 | sed "s/.*> //")" &&
+	test "$(cat commit_2 | sed -e "s/author //" -e "s/>.*/>/")" =\
+		"$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>"
+'
+
+test_expect_success '--amend without --mine uses the author from the old commit' '
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
+test_expect_success '--amend with --mine makes me the author' '
+	test_tick &&
+	echo "Test 6" >> "$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	git commit -m "Changed again" --amend --mine &&
+	git cat-file -p HEAD | grep "^author" > commit_1 &&
+	test "$(cat commit_1 | sed "s/.*> //")" !=\
+		"$(cat commit_2 | sed "s/.*> //")" &&
+	test "$(cat commit_2 | sed -e "s/author //" -e "s/>.*/>/")" =\
+		"$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>"
+'
+
+test_done
-- 
1.6.5.2.102.gdbd78.dirty
