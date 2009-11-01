From: Erick Mattos <erick.mattos@gmail.com>
Subject: [PATCH] commit -c/-C/--amend: acquire authorship and restamp time with --claim
Date: Sun,  1 Nov 2009 16:45:27 -0200
Message-ID: <1257101127-8196-1-git-send-email-erick.mattos@gmail.com>
References: <1257099580-7365-1-git-send-email-erick.mattos@gmail.com>
Cc: git@vger.kernel.org, Erick Mattos <erick.mattos@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 19:45:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4fR8-0001wG-1X
	for gcvg-git-2@lo.gmane.org; Sun, 01 Nov 2009 19:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216AbZKASpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2009 13:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbZKASpq
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 13:45:46 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:59055 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063AbZKASpp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2009 13:45:45 -0500
Received: by yxe17 with SMTP id 17so3947940yxe.33
        for <git@vger.kernel.org>; Sun, 01 Nov 2009 10:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=PliqsPZM6Fh4zZa2w7PcQkB6aypVasYy9l3arAWUH30=;
        b=KKuLSYfC0QY0B8i6LFbKx1tdna3GUe2Pvyb3s9Bx4Y+WcFDiVijABcsHKbgdt4FaJw
         tlMwn2fMxUO/RAeFNfzKL/yNOAXm2xMyGAuL/dGKtsOl0uTtvM5wd9axEQJu91wpGx4p
         hCeGfGS3NVqPJ3XQVNZ8WNNXnw93EgljxfVx4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Tk/Ih3yPiAHSaEU7Gpxog1z3cex/nzAbxUvJCnQyKH155NO7dWE4ECk6qTZmYp9Djn
         6vRvtBrFCdXA68KgAcIdJir5m7YUPeGSOe7VBvMYsNHLFGWWG6go8PB082Hxs7Hy+AnX
         u6jfPTrYvxj9K5DfH7eVn4wb1z0M1T03q29Ss=
Received: by 10.150.16.14 with SMTP id 14mr6794583ybp.246.1257101150337;
        Sun, 01 Nov 2009 10:45:50 -0800 (PST)
Received: from localhost.localdomain ([187.15.76.58])
        by mx.google.com with ESMTPS id 8sm1830888ywg.19.2009.11.01.10.45.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 01 Nov 2009 10:45:49 -0800 (PST)
X-Mailer: git-send-email 1.6.5.GIT
In-Reply-To: <1257099580-7365-1-git-send-email-erick.mattos@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131873>

When we use one of the options above we are normally trying to do mainly
two things: one is using the source as a template and second is to
recreate a commit with corrections.

When they are used, the authorship and timestamp recorded in the newly
created commit is always taken from the original commit.  And they
should not when we are using it as a template.

The new --claim option is meant to solve this need by regenerating the
timestamp and setting as new author the committer or the one specified
on --author option.

Signed-off-by: Erick Mattos <erick.mattos@gmail.com>
---
 Documentation/git-commit.txt |   11 ++++-
 builtin-commit.c             |    7 ++-
 t/t7509-commit.sh            |   87 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+), 6 deletions(-)
 create mode 100755 t/t7509-commit.sh

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 0578a40..01eeb3e 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend] [--dry-run]
-	   [(-c | -C) <commit>] [-F <file> | -m <msg>]
+	   [(-c | -C) <commit>] [-F <file> | -m <msg>] [--claim]
 	   [--allow-empty] [--no-verify] [-e] [--author=<author>]
 	   [--cleanup=<mode>] [--] [[-i | -o ]<file>...]
 
@@ -61,14 +61,19 @@ OPTIONS
 -C <commit>::
 --reuse-message=<commit>::
 	Take an existing commit object, and reuse the log message
-	and the authorship information (including the timestamp)
-	when creating the commit.
+	and the authorship information when creating the commit.
 
 -c <commit>::
 --reedit-message=<commit>::
 	Like '-C', but with '-c' the editor is invoked, so that
 	the user can further edit the commit message.
 
+--claim::
+	When used with -C/-c/--amend options, declare that the
+	authorship of the resulting commit now belongs of the committer.
+	This also renews the author timestamp.  Therefore this option
+	sets the use of only the message from the original commit.
+
 -F <file>::
 --file=<file>::
 	Take the commit message from the given file.  Use '-' to
diff --git a/builtin-commit.c b/builtin-commit.c
index c395cbf..919e3fe 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -51,7 +51,7 @@ static const char *template_file;
 static char *edit_message, *use_message;
 static char *author_name, *author_email, *author_date;
 static int all, edit_flag, also, interactive, only, amend, signoff;
-static int quiet, verbose, no_verify, allow_empty, dry_run;
+static int quiet, verbose, no_verify, allow_empty, dry_run, claim;
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
+	OPT_BOOLEAN(0, "claim", &claim, "acquire authorship and restamp time of resulting commit"),
 	OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
 	OPT_FILENAME('t', "template", &template_file, "use specified template file"),
 	OPT_BOOLEAN('e', "edit", &edit_flag, "force edit of commit"),
@@ -381,7 +382,7 @@ static void determine_author_info(void)
 	email = getenv("GIT_AUTHOR_EMAIL");
 	date = getenv("GIT_AUTHOR_DATE");
 
-	if (use_message) {
+	if (use_message && !claim) {
 		const char *a, *lb, *rb, *eol;
 
 		a = strstr(use_message_buffer, "\nauthor ");
diff --git a/t/t7509-commit.sh b/t/t7509-commit.sh
new file mode 100755
index 0000000..62fb00f
--- /dev/null
+++ b/t/t7509-commit.sh
@@ -0,0 +1,87 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Erick Mattos
+#
+
+test_description='git commit
+
+Tests for --claim option on a commit.'
+
+. ./test-lib.sh
+
+TEST_FILE="$PWD"/foo
+
+test_expect_success '-C option should be working' '
+	echo "Initial" > "$TEST_FILE" && 
+	git add "$TEST_FILE" && 
+	git commit -m "Initial Commit" --author Frigate\ \<flying@over.world\> && 
+	sleep 1 && 
+	echo "Test 1" >> "$TEST_FILE" && 
+	git add "$TEST_FILE" && 
+	git commit -C HEAD && 
+	git cat-file -p HEAD^ | sed -e '/^parent/d' -e '/^tree/d' -e '/^committer/d' > commit_1 && 
+	git cat-file -p HEAD | sed -e '/^parent/d' -e '/^tree/d' -e '/^committer/d' > commit_2 && 
+	cmp commit_1 commit_2
+'
+
+test_expect_success '-C option with --claim is working properly' '
+	sleep 1 &&
+	echo "Test 2" >> "$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	git commit -C HEAD^ --claim &&
+	git cat-file -p HEAD^ | grep '^author' > commit_1 &&
+	git cat-file -p HEAD | grep '^author' > commit_2 &&
+	test_must_fail cmp commit_1 commit_2
+'
+
+test_expect_success '-c option should be working' '
+	echo "Initial" > "$TEST_FILE" && 
+	git add "$TEST_FILE" && 
+	git commit -m "Initial Commit" --author Frigate\ \<flying@over.world\> && 
+	sleep 1 && 
+	echo "Test 3" >> "$TEST_FILE" && 
+	git add "$TEST_FILE" && 
+	git commit -c HEAD <<EOF
+	"Changed" 
+	EOF && 
+	git cat-file -p HEAD^ | grep '^author' > commit_1 &&
+	git cat-file -p HEAD | grep '^author' > commit_2 &&
+	cmp commit_1 commit_2
+'
+
+test_expect_success '-c option with --claim is working properly' '
+	sleep 1 &&
+	echo "Test 4" >> "$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	git commit -c HEAD^ --claim <<EOF
+	"Changed again" 
+	EOF && 
+	git cat-file -p HEAD^ | grep '^author' > commit_1 &&
+	git cat-file -p HEAD | grep '^author' > commit_2 &&
+	test_must_fail cmp commit_1 commit_2
+'
+
+test_expect_success '--amend option should be working' '
+	echo "Initial" > "$TEST_FILE" && 
+	git add "$TEST_FILE" && 
+	git commit -m "Initial Commit" --author Frigate\ \<flying@over.world\> && 
+	echo "Test 5" >> "$TEST_FILE" && 
+	git add "$TEST_FILE" && 
+	git commit -m "--amend test" && 
+	git cat-file -p HEAD | grep '^author' > commit_1 &&
+	sleep 1 && 
+	git commit -m "Changed" --amend && 
+	git cat-file -p HEAD | grep '^author' > commit_2 &&
+	cmp commit_1 commit_2
+'
+
+test_expect_success '--amend option with --claim is working properly' '
+	sleep 1 &&
+	echo "Test 6" >> "$TEST_FILE" &&
+	git add "$TEST_FILE" &&
+	git commit -m "Changed again" --amend --claim && 
+	git cat-file -p HEAD | grep '^author' > commit_1 &&
+	test_must_fail cmp commit_1 commit_2
+'
+
+test_done
-- 
1.6.5.GIT
