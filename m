From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v7] Add log.abbrevCommit config variable
Date: Wed, 18 May 2011 13:56:04 -0400
Message-ID: <1305741364-28286-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <junio@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 19:56:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMkym-0006mL-AL
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 19:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933309Ab1ERR4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 13:56:12 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54763 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630Ab1ERR4K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 13:56:10 -0400
Received: by vws1 with SMTP id 1so1305088vws.19
        for <git@vger.kernel.org>; Wed, 18 May 2011 10:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=utSsle6CNknstBN/Uvv9K5qR2SH8k67SVQFJ2NhEGqk=;
        b=dL48oP+uWgEOVky9MLqy6gG4Rg/XlBi4n/EReUOY1x6GLacw83UtEe+Y0oMTvNiifK
         W8UX69qAheUU/9n3GAyQA5D1GwUqmoCU9PN2vRRyxy+gw/n+sPzLyC93bxxBWFzK0qCp
         zLHu97tpwZSUa5pxcHJuOUDf4qg570blXXeRA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=a/Sywo1a4tZh/h5wo/1WWHZ1XU7ukbww+WhEAAIOULwzizRcnJkuOIuzOugQXCQAUN
         rPQvacfUzJDqAPeKBylLtLjaKnID6R/KbRHCMr5WfrojCLrxdgiBx72gJjAp/K33PXHE
         e9/vyBrFjNBabcHdZnH3clashtoaM2D0TKxzI=
Received: by 10.52.96.138 with SMTP id ds10mr3300521vdb.11.1305741369303;
        Wed, 18 May 2011 10:56:09 -0700 (PDT)
Received: from localhost (cpe-071-077-014-091.nc.res.rr.com [71.77.14.91])
        by mx.google.com with ESMTPS id e37sm803419vbm.17.2011.05.18.10.56.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 May 2011 10:56:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.340.g53e0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173891>

Add log.abbrevCommit config variable as a convenience for users who
often use --abbrev-commit with git log and friends. Allow the option
to be overridden with --no-abbrev-commit. Per 635530a2fc and 4f62c2bc57,
the config variable is ignored when log is given "--pretty=raw".

(Also, a drive-by spelling correction in git log's short help.)

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Versus v5:
- Added --pretty=raw stanza to log.decorate test
- Added additional stanzas for --no-abbrev-commit to log.abbrevCommit test
- Corrected test name to log.abbrevCommit

 Documentation/config.txt         |    5 +++
 Documentation/pretty-options.txt |    5 +++
 builtin/log.c                    |   24 +++++++++++------
 revision.c                       |    3 ++
 revision.h                       |    1 +
 t/t4202-log.sh                   |   51 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 80 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1a060ecbc8..6b93777199 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1315,6 +1315,11 @@ interactive.singlekey::
 	setting is silently ignored if portable keystroke input
 	is not available.
 
+log.abbrevCommit::
+	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
+	linkgit:git-whatchanged[1] assume `\--abbrev-commit`. You may
+	override this option with `\--no-abbrev-commit`.
+
 log.date::
 	Set the default date-time mode for the 'log' command.
 	Setting a value for log.date is similar to using 'git log''s
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index d5c977262a..2a3dc8664f 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -19,6 +19,11 @@ configuration (see linkgit:git-config[1]).
 This should make "--pretty=oneline" a whole lot more readable for
 people using 80-column terminals.
 
+--no-abbrev-commit::
+	Show the full 40-byte hexadecimal commit object name. This negates
+	`--abbrev-commit` and those options which imply it such as
+	"--oneline". It also overrides the 'log.abbrevCommit' variable.
+
 --oneline::
 	This is a shorthand for "--pretty=oneline --abbrev-commit"
 	used together.
diff --git a/builtin/log.c b/builtin/log.c
index f6219909a7..019a44ac86 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -23,6 +23,7 @@
 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
 
+static int default_abbrev_commit;
 static int default_show_root = 1;
 static int decoration_style;
 static int decoration_given;
@@ -77,6 +78,7 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 		get_commit_format(fmt_pretty, rev);
 	rev->verbose_header = 1;
 	DIFF_OPT_SET(&rev->diffopt, RECURSIVE);
+	rev->abbrev_commit = default_abbrev_commit;
 	rev->show_root_diff = default_show_root;
 	rev->subject_prefix = fmt_patch_subject_prefix;
 	DIFF_OPT_SET(&rev->diffopt, ALLOW_TEXTCONV);
@@ -92,7 +94,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	int quiet = 0, source = 0;
 
 	const struct option builtin_log_options[] = {
-		OPT_BOOLEAN(0, "quiet", &quiet, "supress diff output"),
+		OPT_BOOLEAN(0, "quiet", &quiet, "suppress diff output"),
 		OPT_BOOLEAN(0, "source", &source, "show source"),
 		{ OPTION_CALLBACK, 0, "decorate", NULL, NULL, "decorate options",
 		  PARSE_OPT_OPTARG, decorate_callback},
@@ -129,13 +131,13 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	if (source)
 		rev->show_source = 1;
 
-	/*
-	 * defeat log.decorate configuration interacting with --pretty=raw
-	 * from the command line.
-	 */
-	if (!decoration_given && rev->pretty_given
-	    && rev->commit_format == CMIT_FMT_RAW)
-		decoration_style = 0;
+	if (rev->pretty_given && rev->commit_format == CMIT_FMT_RAW) {
+		/* "log --pretty=raw" is special */
+		if (!decoration_given)
+			decoration_style = 0;
+		if (!rev->abbrev_commit_given)
+			rev->abbrev_commit = 0;
+	}
 
 	if (decoration_style) {
 		rev->show_decorations = 1;
@@ -323,6 +325,10 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		return git_config_string(&fmt_pretty, var, value);
 	if (!strcmp(var, "format.subjectprefix"))
 		return git_config_string(&fmt_patch_subject_prefix, var, value);
+	if (!strcmp(var, "log.abbrevcommit")) {
+		default_abbrev_commit = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "log.date"))
 		return git_config_string(&default_date_mode, var, value);
 	if (!strcmp(var, "log.decorate")) {
@@ -516,11 +522,11 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 
 	init_revisions(&rev, prefix);
 	init_reflog_walk(&rev.reflog_info);
-	rev.abbrev_commit = 1;
 	rev.verbose_header = 1;
 	memset(&opt, 0, sizeof(opt));
 	opt.def = "HEAD";
 	cmd_log_init_defaults(&rev);
+	rev.abbrev_commit = 1;
 	rev.commit_format = CMIT_FMT_ONELINE;
 	rev.use_terminator = 1;
 	rev.always_show_header = 1;
diff --git a/revision.c b/revision.c
index a7cf79bf2e..be74bf92f5 100644
--- a/revision.c
+++ b/revision.c
@@ -1429,6 +1429,9 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 			revs->abbrev = 40;
 	} else if (!strcmp(arg, "--abbrev-commit")) {
 		revs->abbrev_commit = 1;
+		revs->abbrev_commit_given = 1;
+	} else if (!strcmp(arg, "--no-abbrev-commit")) {
+		revs->abbrev_commit = 0;
 	} else if (!strcmp(arg, "--full-diff")) {
 		revs->diff = 1;
 		revs->full_diff = 1;
diff --git a/revision.h b/revision.h
index bca9947977..5e1f5c7e8f 100644
--- a/revision.h
+++ b/revision.h
@@ -90,6 +90,7 @@ struct rev_info {
 			show_notes_given:1,
 			pretty_given:1,
 			abbrev_commit:1,
+			abbrev_commit_given:1,
 			use_terminator:1,
 			missing_newline:1,
 			date_mode_explicit:1;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 2fcc31a6f3..fd8362dfd3 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -448,6 +448,57 @@ test_expect_success 'log.decorate configuration' '
 	git log --oneline --decorate >actual &&
 	test_cmp expect.short actual
 
+	git config --unset-all log.decorate &&
+	git log --pretty=raw >expect.raw &&
+	git config log.decorate full &&
+	git log --pretty=raw >actual &&
+	test_cmp expect.raw actual
+
+'
+
+test_expect_success 'reflog is expected format' '
+	test_might_fail git config --remove-section log &&
+	git log -g --abbrev-commit --pretty=oneline >expect &&
+	git reflog >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'whatchanged is expected format' '
+	git log --no-merges --raw >expect &&
+	git whatchanged >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log.abbrevCommit configuration' '
+	test_when_finished "git config --unset log.abbrevCommit" &&
+
+	git log --abbrev-commit >expect.log.abbrev &&
+	git log --no-abbrev-commit >expect.log.full &&
+	git log --pretty=raw >expect.log.raw &&
+	git reflog --abbrev-commit >expect.reflog.abbrev &&
+	git reflog --no-abbrev-commit >expect.reflog.full &&
+	git whatchanged --abbrev-commit >expect.whatchanged.abbrev &&
+	git whatchanged --no-abbrev-commit >expect.whatchanged.full &&
+
+	git config log.abbrevCommit true &&
+
+	git log >actual &&
+	test_cmp expect.log.abbrev actual &&
+	git log --no-abbrev-commit >actual &&
+	test_cmp expect.log.full actual &&
+
+	git log --pretty=raw >actual &&
+	test_cmp expect.log.raw actual &&
+
+	git reflog >actual &&
+	test_cmp expect.reflog.abbrev actual &&
+	git reflog --no-abbrev-commit >actual &&
+	test_cmp expect.reflog.full actual
+
+	git whatchanged >actual &&
+	test_cmp expect.whatchanged.abbrev actual
+	git whatchanged --no-abbrev-commit >actual &&
+	test_cmp expect.whatchanged.full actual
 '
 
 test_expect_success 'show added path under "--follow -M"' '
-- 
1.7.5.1.340.g53e0.dirty
