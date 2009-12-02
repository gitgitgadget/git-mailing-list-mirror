From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 1/2] builtin-commit: add --date option
Date: Wed,  2 Dec 2009 23:16:18 +0100
Message-ID: <3d547f4e32c026efc76a7dfe1572da617714f8c9.1259791789.git.vmiklos@frugalware.org>
References: <7vpr6xcgki.fsf@alter.siamese.dyndns.org>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 23:14:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFxT1-0001e3-KD
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 23:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755655AbZLBWOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 17:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754273AbZLBWOY
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 17:14:24 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:47653 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754621AbZLBWOX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 17:14:23 -0500
Received: from vmobile.example.net (dsl5401C01C.pool.t-online.hu [84.1.192.28])
	by yugo.frugalware.org (Postfix) with ESMTPA id 72E0A1A4A1;
	Wed,  2 Dec 2009 23:14:28 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 325E3181FDB; Wed,  2 Dec 2009 23:16:20 +0100 (CET)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <7vpr6xcgki.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134408>

This is like --author: allow a user to specify a given date without
using the GIT_AUTHOR_DATE environment variable.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Wed, Dec 02, 2009 at 11:38:05AM -0800, Junio C Hamano <gitster@pobox.com> wrote:
> So I do not think --date is something we urgently need, even though it
> might be nice to have it to be consistent with --author.

Changes from the previous version:

* updated the commit message

* rebased on top of current master that has --reset-author

 Documentation/git-commit.txt |    5 ++++-
 builtin-commit.c             |    6 +++++-
 t/t7501-commit.sh            |   15 +++++++++++++++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index d227cec..cbbbeeb 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend] [--dry-run]
 	   [(-c | -C) <commit>] [-F <file> | -m <msg>] [--reset-author]
 	   [--allow-empty] [--no-verify] [-e] [--author=<author>]
-	   [--cleanup=<mode>] [--] [[-i | -o ]<file>...]
+	   [--date=<date>] [--cleanup=<mode>] [--] [[-i | -o ]<file>...]
 
 DESCRIPTION
 -----------
@@ -85,6 +85,9 @@ OPTIONS
 	an existing commit that matches the given string and its author
 	name is used.
 
+--date=<date>::
+	Override the date used in the commit.
+
 -m <msg>::
 --message=<msg>::
 	Use the given <msg> as the commit message.
diff --git a/builtin-commit.c b/builtin-commit.c
index e93a647..9a1264a 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -52,7 +52,7 @@ static char *edit_message, *use_message;
 static char *author_name, *author_email, *author_date;
 static int all, edit_flag, also, interactive, only, amend, signoff;
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
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
 	OPT_STRING('c', "reedit-message", &edit_message, "COMMIT", "reuse and edit message from specified commit"),
 	OPT_STRING('C', "reuse-message", &use_message, "COMMIT", "reuse message from specified commit"),
@@ -410,6 +411,9 @@ static void determine_author_info(void)
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
