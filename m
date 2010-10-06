From: Rodolfo Borges <rodolfo.borges@gmail.com>
Subject: [PATCH] New commit option --fixup.
Date: Wed,  6 Oct 2010 15:58:21 -0700
Message-ID: <1286405901-13586-1-git-send-email-rodolfo.borges@gmail.com>
Cc: Rodolfo Borges <rodolfo.borges@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Oct 07 01:27:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3dOZ-0003Vi-Kz
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 01:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755902Ab0JFX1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 19:27:30 -0400
Received: from judo.dreamhost.com ([66.33.216.100]:53234 "EHLO
	judo.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277Ab0JFX13 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 19:27:29 -0400
X-Greylist: delayed 1692 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Oct 2010 19:27:29 EDT
Received: from smarty.dreamhost.com (smarty.dreamhost.com [208.113.175.8])
	by judo.dreamhost.com (Postfix) with ESMTP id 01E914508C5
	for <git@vger.kernel.org>; Wed,  6 Oct 2010 15:59:17 -0700 (PDT)
Received: from jaguars.dreamhost.com (jaguars.dreamhost.com [69.163.169.144])
	by smarty.dreamhost.com (Postfix) with ESMTP id A34356E804A;
	Wed,  6 Oct 2010 15:58:23 -0700 (PDT)
Received: by jaguars.dreamhost.com (Postfix, from userid 76469)
	id 9F2B2130C0C; Wed,  6 Oct 2010 15:58:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158355>

Equivalent of '-C HEAD --amend'.
Inspired by new 'fixup' rebase -i action.

Signed-off-by: Rodolfo Borges <rodolfo.borges@gmail.com>
---
 Documentation/git-commit.txt |    4 ++++
 builtin/commit.c             |    8 +++++++-
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 42fb1f5..faba634 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -180,6 +180,10 @@ You should understand the implications of rewriting history if you
 amend a commit that has already been published.  (See the "RECOVERING
 FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
 
+--fixup::
+	Like '--amend', but use previous commit message.
+	(Equivalent to `--amend -C HEAD`.)
+
 -i::
 --include::
 	Before making a commit out of staged contents so far,
diff --git a/builtin/commit.c b/builtin/commit.c
index 66fdd22..fd7c145 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -70,7 +70,7 @@ static const char *logfile, *force_author;
 static const char *template_file;
 static char *edit_message, *use_message;
 static char *author_name, *author_email, *author_date;
-static int all, edit_flag, also, interactive, only, amend, signoff;
+static int all, edit_flag, also, interactive, only, amend, fixup, signoff;
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int no_post_rewrite, allow_empty_message;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg;
@@ -147,6 +147,7 @@ static struct option builtin_commit_options[] = {
 	OPT_BOOLEAN('z', "null", &null_termination,
 		    "terminate entries with NUL"),
 	OPT_BOOLEAN(0, "amend", &amend, "amend previous commit"),
+	OPT_BOOLEAN(0, "fixup", &fixup, "fixup previous commit"),
 	OPT_BOOLEAN(0, "no-post-rewrite", &no_post_rewrite, "bypass post-rewrite hook"),
 	{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mode", "show untracked files, optional modes: all, normal, no (Default: all)", PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 	/* end commit contents options */
@@ -863,6 +864,11 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (force_author && renew_authorship)
 		die("Using both --reset-author and --author does not make sense");
 
+	if (fixup) {
+		amend = 1;
+		use_message = "HEAD";
+	}
+
 	if (logfile || message.len || use_message)
 		use_editor = 0;
 	if (edit_flag)
-- 
1.7.2.3
