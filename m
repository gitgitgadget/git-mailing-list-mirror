From: Michael Schubert <mschub@elegosoft.com>
Subject: [PATCH] git-commit: add option --date-now
Date: Wed, 21 Dec 2011 15:56:43 +0100
Message-ID: <4EF1F3AB.5080607@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 21 15:57:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdNc9-0007fq-Sp
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 15:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487Ab1LUO5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 09:57:50 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:52271 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751621Ab1LUO5t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 09:57:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 040E5DE971
	for <git@vger.kernel.org>; Wed, 21 Dec 2011 15:57:48 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y1c3AU9OR3ds for <git@vger.kernel.org>;
	Wed, 21 Dec 2011 15:57:47 +0100 (CET)
Received: from [10.10.10.197] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id CB3D9DE96C
	for <git@vger.kernel.org>; Wed, 21 Dec 2011 15:57:47 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111108 Thunderbird/8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187567>

Currently, Git doesn't provide an easy way to use the current date when
amending a commit or reusing an existing commmit with -C/-c. Therefore,
add --date-now.

Signed-off-by: Michael Schubert <mschub@elegosoft.com>
---
 Documentation/git-commit.txt |    7 +++++--
 builtin/commit.c             |    9 ++++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 5cc84a1..b7c6f0d 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -12,8 +12,8 @@ SYNOPSIS
 	   [--dry-run] [(-c | -C | --fixup | --squash) <commit>]
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
-	   [--date=<date>] [--cleanup=<mode>] [--status | --no-status]
-	   [-i | -o] [--] [<file>...]
+	   [--date=<date> | --date-now] [--cleanup=<mode>]
+	   [--status | --no-status] [-i | -o] [--] [<file>...]
 
 DESCRIPTION
 -----------
@@ -126,6 +126,9 @@ OPTIONS
 --date=<date>::
 	Override the author date used in the commit.
 
+--date-now
+	Override the author date used in the commit with the current local time.
+
 -m <msg>::
 --message=<msg>::
 	Use the given <msg> as the commit message.
diff --git a/builtin/commit.c b/builtin/commit.c
index be1ab2e..28fdf1a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -82,6 +82,7 @@ static const char *author_message, *author_message_buffer;
 static char *edit_message, *use_message;
 static char *fixup_message, *squash_message;
 static int all, also, interactive, patch_interactive, only, amend, signoff;
+static int date_now;
 static int edit_flag = -1; /* unspecified */
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int no_post_rewrite, allow_empty_message;
@@ -134,6 +135,7 @@ static struct option builtin_commit_options[] = {
 	OPT_FILENAME('F', "file", &logfile, "read message from file"),
 	OPT_STRING(0, "author", &force_author, "author", "override author for commit"),
 	OPT_STRING(0, "date", &force_date, "date", "override date for commit"),
+	OPT_BOOLEAN(0, "date-now", &date_now, "override date for commit with current local time"),
 	OPT_CALLBACK('m', "message", &message, "message", "commit message", opt_parse_m),
 	OPT_STRING('c', "reedit-message", &edit_message, "commit", "reuse and edit message from specified commit"),
 	OPT_STRING('C', "reuse-message", &use_message, "commit", "reuse message from specified commit"),
@@ -557,7 +559,9 @@ static void determine_author_info(struct strbuf *author_ident)
 					(lb - strlen(" ") -
 					 (a + strlen("\nauthor "))));
 		email = xmemdupz(lb + strlen("<"), rb - (lb + strlen("<")));
-		date = xmemdupz(rb + strlen("> "), eol - (rb + strlen("> ")));
+		if (!date_now)
+			date = xmemdupz(rb + strlen("> "),
+					eol - (rb + strlen("> ")));
 	}
 
 	if (force_author) {
@@ -1018,6 +1022,9 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (force_author && renew_authorship)
 		die(_("Using both --reset-author and --author does not make sense"));
 
+	if (force_date && date_now)
+		die(_("Using both --date and --date-now does not make sense"));
+
 	if (logfile || message.len || use_message || fixup_message)
 		use_editor = 0;
 	if (0 <= edit_flag)
-- 
1.7.8.521.g64725
