From: Erick Mattos <erick.mattos@gmail.com>
Subject: [PATCH v2] commit -c/-C/--amend: reset timestamp and authorship to committer with --reset-author
Date: Wed,  4 Nov 2009 01:20:11 -0200
Message-ID: <1257304811-26812-1-git-send-email-erick.mattos@gmail.com>
Cc: git@vger.kernel.org, Erick Mattos <erick.mattos@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 04:20:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5WQb-0001Lk-O6
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 04:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754379AbZKDDUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 22:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754282AbZKDDUp
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 22:20:45 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:47659 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159AbZKDDUo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 22:20:44 -0500
Received: by yxe17 with SMTP id 17so6035309yxe.33
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 19:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Lym+zifsa3/jXhbZ/Ovkr6glZjiquSSwUUF0RTuM1GA=;
        b=MQ7crDXGSG9RET17fuPdvq/UU1mTG4EtOXjETPSBpitJJQFTO6XFY7EOXZZb+Cz1aO
         6oB08NbbYCUbR+ok2Zvm3wm32exutanPbpd+2fFnEj+Bl8ogf6Bsm+4eL3wfGkReONNq
         7MpwIuR+lJT+Gkb3XTZcfYG56iCoF1vmf7dqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=TMzueaiywnnyGYApS+F9Pu+rrOG+jWk87Wd17mGeeOZgNFWZRbvoncq/B7JMm7aSbw
         86EXwyPNM1GnvJAHqKzYGLN/AsUhUX2K93SDI6Zu5QuOIX7vtqQxudIJ04Nki6HoFHgI
         ZchbSE8jI94lPDsx6I0UF76xIxGPvmRrY/sUA=
Received: by 10.91.18.5 with SMTP id v5mr2012971agi.91.1257304843514;
        Tue, 03 Nov 2009 19:20:43 -0800 (PST)
Received: from localhost.localdomain ([187.15.44.83])
        by mx.google.com with ESMTPS id 23sm325527yxe.18.2009.11.03.19.20.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Nov 2009 19:20:43 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.144.g27f8d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132030>

When we use -c, -C, or --amend, we are trying one of two things: using
the source as a template or modifying a commit with corrections.

When these options are used, the authorship and timestamp recorded in
the newly created commit are always taken from the original commit.
This is inconvenient when we just want to borrow the commit log message
or when our change to the code is so significant that we should take
over the authorship (with the blame for bugs we introduce, of course).

The new --reset-author option is meant to solve this need by
regenerating the timestamp and setting as the new author the committer
or the one specified by --author option.

Signed-off-by: Erick Mattos <erick.mattos@gmail.com>
---

I have remade the testing script to let it easier for people to understand and
to make it do all reasonable tests.

I have made minor message log changes and as you can see by the third paragraph
I am showing a different approach to option --author.  Please read the following
text:

--author text says: "override author for commit".

As I see, something that OVERRIDES supersedes everything else.

IMHO --author shouldn't be blocked by the new option.

Cutting --author away would make impossible for someone to force a new author
with a new timestamp in case he is templating.  As an example he can be using
the --author because he is doing a change in a computer not his own or
something alike.

So I would not wipe "author" out from the new option.

Please don't forget that I am just being a small contributor.  I am just
suggesting things.  You have the final word and if you want we can add your
small test to block it:

	if (force_author && renew_authorship)
		die("Using both --reset-author and --author does not make sense");

 Documentation/git-commit.txt |    7 ++-
 builtin-commit.c             |    9 ++-
 t/t7509-commit.sh            |  123 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 135 insertions(+), 4 deletions(-)
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
index 0000000..1c27de7
--- /dev/null
+++ b/t/t7509-commit.sh
@@ -0,0 +1,123 @@
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
+author_id () {
+	git cat-file -p "$1" | \
+	grep "^author" | \
+	sed -e "s/author //" -e "s/>.*/>/"
+}
+
+author_timestamp () {
+	git cat-file -p "$1" | \
+	grep "^author" | \
+	sed "s/.*> //"
+}
+
+message_body () {
+	git cat-file commit "$1" | \
+	sed -e '1,/^$/d'
+}
+
+initiate_test () {
+	test_tick
+	echo "initial" >> "$TEST_FILE"
+	git add "$TEST_FILE"
+	git commit -m "Initial Commit" --author "Frigate <flying@over.world>"
+	test_tick
+}
+
+make_files () {
+	author_id "$1" > "aid$2"
+	author_timestamp "$1" > "atime$2"
+	message_body "$1" > "message$2"
+}
+
+get_committer_id () {
+	echo "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" > aid1
+}
+
+test_expect_success '-C without --reset-author uses the author from the old commit' '
+	initiate_test &&
+	echo "Test 1" >> "$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	git commit -C HEAD &&
+	make_files HEAD^ 1 &&
+	make_files HEAD 2 &&
+	test_cmp aid1 aid2 &&
+	test_cmp atime1 atime2 &&
+	test_cmp message1 message2
+'
+
+test_expect_success '-C with --reset-author makes me the author' '
+	test_tick &&
+	echo "Test 2" >> "$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	git commit -C HEAD^ --reset-author &&
+	make_files HEAD^ 1 &&
+	make_files HEAD 2 &&
+	get_committer_id &&
+	test_cmp aid1 aid2 &&
+	test_must_fail cmp atime1 atime2 &&
+	test_cmp message1 message2
+'
+
+test_expect_success '-c without --reset-author uses the author from the old commit' '
+	initiate_test &&
+	echo "Test 3" >> "$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	EDITOR=: VISUAL=: git commit -c HEAD &&
+	make_files HEAD^ 1 &&
+	make_files HEAD 2 &&
+	test_cmp aid1 aid2 &&
+	test_cmp atime1 atime2 &&
+	test_cmp message1 message2
+'
+
+test_expect_success '-c with --reset-author makes me the author' '
+	test_tick &&
+	echo "Test 4" >> "$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	EDITOR=: VISUAL=: git commit -c HEAD^ --reset-author &&
+	make_files HEAD^ 1 &&
+	make_files HEAD 2 &&
+	get_committer_id &&
+	test_cmp aid1 aid2 &&
+	test_must_fail cmp atime1 atime2 &&
+	test_cmp message1 message2
+'
+
+test_expect_success '--amend without --reset-author uses the author from the old commit' '
+	initiate_test &&
+	make_files HEAD 2 &&
+	echo "Test 5" >> "$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	git commit -m "--amend test" --amend &&
+	make_files HEAD 1 &&
+	test_cmp aid1 aid2 &&
+	test_cmp atime1 atime2 &&
+	test_must_fail cmp message1 message2
+'
+
+test_expect_success '--amend with --reset-author makes me the author' '
+	test_tick &&
+	echo "Test 6" >> "$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	git commit -m "Changed" --amend --reset-author &&
+	make_files HEAD 2 &&
+	get_committer_id &&
+	test_cmp aid1 aid2 &&
+	test_must_fail cmp atime1 atime2 &&
+	test_must_fail cmp message1 message2
+'
+
+test_done
-- 
1.6.5.2.144.g27f8d.dirty
