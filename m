From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] builtin-commit: add --date option
Date: Tue,  1 Dec 2009 01:27:32 +0100
Message-ID: <1259627252-21615-1-git-send-email-vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 01:31:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFGee-0007lR-AC
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 01:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913AbZLAAbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 19:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752827AbZLAAbc
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 19:31:32 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:33473 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466AbZLAAbb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 19:31:31 -0500
X-Greylist: delayed 350 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Nov 2009 19:31:31 EST
Received: from vmobile.example.net (catv-89-134-195-11.catv.broadband.hu [89.134.195.11])
	by yugo.frugalware.org (Postfix) with ESMTPA id 338FC1A49F
	for <git@vger.kernel.org>; Tue,  1 Dec 2009 01:25:47 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 68D72181FDB; Tue,  1 Dec 2009 01:27:33 +0100 (CET)
X-Mailer: git-send-email 1.6.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134159>

This is useful in case git commit --amend is used but the user wants to
set the date of the new commit to a specified one, since GIT_AUTHOR_DATE
is ignored in such a situation.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

 Documentation/git-commit.txt |    6 +++++-
 builtin-commit.c             |    6 +++++-
 t/t7501-commit.sh            |   15 +++++++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 3ea80c8..3b9a7c3 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend] [--dry-run]
 	   [(-c | -C) <commit>] [-F <file> | -m <msg>]
 	   [--allow-empty] [--no-verify] [-e] [--author=<author>]
-	   [--cleanup=<mode>] [--] [[-i | -o ]<file>...]
+	   [--date=<date>] [--cleanup=<mode>] [--] [[-i | -o ]<file>...]
 
 DESCRIPTION
 -----------
@@ -80,6 +80,10 @@ OPTIONS
 	an existing commit that matches the given string and its author
 	name is used.
 
+--date=<date>::
+	Override the date used in the commit.  The format is the Git
+	native one and is `<time> SP <offutc>`.
+
 -m <msg>::
 --message=<msg>::
 	Use the given <msg> as the commit message.
diff --git a/builtin-commit.c b/builtin-commit.c
index 09d2840..594328e 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -52,7 +52,7 @@ static char *edit_message, *use_message;
 static char *author_name, *author_email, *author_date;
 static int all, edit_flag, also, interactive, only, amend, signoff;
 static int quiet, verbose, no_verify, allow_empty, dry_run;
-static char *untracked_files_arg;
+static char *untracked_files_arg, *force_date;
 /*
  * The default commit message cleanup mode will remove the lines
  * beginning with # (shell comments) and leading and trailing
@@ -90,6 +90,7 @@ static struct option builtin_commit_options[] = {
 
 	OPT_FILENAME('F', "file", &logfile, "read log from file"),
 	OPT_STRING(0, "author", &force_author, "AUTHOR", "override author for commit"),
+	OPT_STRING(0, "date", &force_date, "DATE", "override date for commit"),
 	OPT_CALLBACK('m', "message", &message, "MESSAGE", "specify commit message", opt_parse_m),
 	OPT_STRING('c', "reedit-message", &edit_message, "COMMIT", "reuse and edit message from specified commit "),
 	OPT_STRING('C', "reuse-message", &use_message, "COMMIT", "reuse message from specified commit"),
@@ -409,6 +410,9 @@ static void determine_author_info(void)
 		email = xstrndup(lb + 2, rb - (lb + 2));
 	}
 
+	if (force_date)
+		date = force_date;
+
 	author_name = name;
 	author_email = email;
 	author_date = date;
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index a603f6d..a529701 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -211,6 +211,21 @@ test_expect_success 'amend commit to fix author' '
 
 '
 
+test_expect_success 'amend commit to fix date' '
+
+	test_tick &&
+	newtick=$GIT_AUTHOR_DATE &&
+	git reset --hard &&
+	git cat-file -p HEAD |
+	sed -e "s/author.*/author $author $newtick/" \
+		-e "s/^\(committer.*> \).*$/\1$GIT_COMMITTER_DATE/" > \
+		expected &&
+	git commit --amend --date="$newtick" &&
+	git cat-file -p HEAD > current &&
+	test_cmp expected current
+
+'
+
 test_expect_success 'sign off (1)' '
 
 	echo 1 >positive &&
-- 
1.6.5.2
