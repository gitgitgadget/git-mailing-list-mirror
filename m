From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 4/5 v4] log: parse detached options like git log --grep foo
Date: Fri, 30 Jul 2010 10:31:08 +0200
Message-ID: <1280478669-22973-4-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq7hkdml22.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 30 10:37:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oel5t-0002w8-RB
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 10:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755423Ab0G3IhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 04:37:24 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38564 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755197Ab0G3IhX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 04:37:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o6U8TYQf010071
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 30 Jul 2010 10:29:34 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oel01-0000Zn-CY; Fri, 30 Jul 2010 10:31:25 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oel01-0005zO-BV; Fri, 30 Jul 2010 10:31:25 +0200
X-Mailer: git-send-email 1.7.2.252.gb848
In-Reply-To: <vpq7hkdml22.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 30 Jul 2010 10:29:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6U8TYQf010071
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1281083375.95503@L9VMKIB0oSrxv7Lz7uwPJA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152230>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 revision.c     |   74 ++++++++++++++++++++++++++++++++++---------------------
 t/t4202-log.sh |    7 +++++
 2 files changed, 53 insertions(+), 28 deletions(-)

diff --git a/revision.c b/revision.c
index 7e82efd..359b1a1 100644
--- a/revision.c
+++ b/revision.c
@@ -1148,6 +1148,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 			       int *unkc, const char **unkv)
 {
 	const char *arg = argv[0];
+	const char *optarg;
+	int argcount;
 
 	/* pseudo revision arguments */
 	if (!strcmp(arg, "--all") || !strcmp(arg, "--branches") ||
@@ -1160,11 +1162,13 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		return 1;
 	}
 
-	if (!prefixcmp(arg, "--max-count=")) {
-		revs->max_count = atoi(arg + 12);
+	if ((argcount = diff_long_opt("max-count", argv, &optarg))) {
+		revs->max_count = atoi(optarg);
 		revs->no_walk = 0;
-	} else if (!prefixcmp(arg, "--skip=")) {
-		revs->skip_count = atoi(arg + 7);
+		return argcount;
+	} else if ((argcount = diff_long_opt("skip", argv, &optarg))) {
+		revs->skip_count = atoi(optarg);
+		return argcount;
 	} else if ((*arg == '-') && isdigit(arg[1])) {
 	/* accept -<digit>, like traditional "head" */
 		revs->max_count = atoi(arg + 1);
@@ -1178,18 +1182,24 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!prefixcmp(arg, "-n")) {
 		revs->max_count = atoi(arg + 2);
 		revs->no_walk = 0;
-	} else if (!prefixcmp(arg, "--max-age=")) {
-		revs->max_age = atoi(arg + 10);
-	} else if (!prefixcmp(arg, "--since=")) {
-		revs->max_age = approxidate(arg + 8);
-	} else if (!prefixcmp(arg, "--after=")) {
-		revs->max_age = approxidate(arg + 8);
-	} else if (!prefixcmp(arg, "--min-age=")) {
-		revs->min_age = atoi(arg + 10);
-	} else if (!prefixcmp(arg, "--before=")) {
-		revs->min_age = approxidate(arg + 9);
-	} else if (!prefixcmp(arg, "--until=")) {
-		revs->min_age = approxidate(arg + 8);
+	} else if ((argcount = diff_long_opt("max-age", argv, &optarg))) {
+		revs->max_age = atoi(optarg);
+		return argcount;
+	} else if ((argcount = diff_long_opt("since", argv, &optarg))) {
+		revs->max_age = approxidate(optarg);
+		return argcount;
+	} else if ((argcount = diff_long_opt("after", argv, &optarg))) {
+		revs->max_age = approxidate(optarg);
+		return argcount;
+	} else if ((argcount = diff_long_opt("min-age", argv, &optarg))) {
+		revs->min_age = atoi(optarg);
+		return argcount;
+	} else if ((argcount = diff_long_opt("before", argv, &optarg))) {
+		revs->min_age = approxidate(optarg);
+		return argcount;
+	} else if ((argcount = diff_long_opt("until", argv, &optarg))) {
+		revs->min_age = approxidate(optarg);
+		return argcount;
 	} else if (!strcmp(arg, "--first-parent")) {
 		revs->first_parent_only = 1;
 	} else if (!strcmp(arg, "--ancestry-path")) {
@@ -1295,6 +1305,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->pretty_given = 1;
 		get_commit_format(arg+8, revs);
 	} else if (!prefixcmp(arg, "--pretty=") || !prefixcmp(arg, "--format=")) {
+		/*
+		 * Detached form ("--pretty X" as opposed to "--pretty=X")
+		 * not allowed, since the argument is optional.
+		 */
 		revs->verbose_header = 1;
 		revs->pretty_given = 1;
 		get_commit_format(arg+9, revs);
@@ -1359,21 +1373,25 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--relative-date")) {
 		revs->date_mode = DATE_RELATIVE;
 		revs->date_mode_explicit = 1;
-	} else if (!strncmp(arg, "--date=", 7)) {
-		revs->date_mode = parse_date_format(arg + 7);
+	} else if ((argcount = diff_long_opt("date", argv, &optarg))) {
+		revs->date_mode = parse_date_format(optarg);
 		revs->date_mode_explicit = 1;
+		return argcount;
 	} else if (!strcmp(arg, "--log-size")) {
 		revs->show_log_size = 1;
 	}
 	/*
 	 * Grepping the commit log
 	 */
-	else if (!prefixcmp(arg, "--author=")) {
-		add_header_grep(revs, GREP_HEADER_AUTHOR, arg+9);
-	} else if (!prefixcmp(arg, "--committer=")) {
-		add_header_grep(revs, GREP_HEADER_COMMITTER, arg+12);
-	} else if (!prefixcmp(arg, "--grep=")) {
-		add_message_grep(revs, arg+7);
+	else if ((argcount = diff_long_opt("author", argv, &optarg))) {
+		add_header_grep(revs, GREP_HEADER_AUTHOR, optarg);
+		return argcount;
+	} else if ((argcount = diff_long_opt("committer", argv, &optarg))) {
+		add_header_grep(revs, GREP_HEADER_COMMITTER, optarg);
+		return argcount;
+	} else if ((argcount = diff_long_opt("grep", argv, &optarg))) {
+		add_message_grep(revs, optarg);
+		return argcount;
 	} else if (!strcmp(arg, "--extended-regexp") || !strcmp(arg, "-E")) {
 		revs->grep_filter.regflags |= REG_EXTENDED;
 	} else if (!strcmp(arg, "--regexp-ignore-case") || !strcmp(arg, "-i")) {
@@ -1382,12 +1400,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->grep_filter.fixed = 1;
 	} else if (!strcmp(arg, "--all-match")) {
 		revs->grep_filter.all_match = 1;
-	} else if (!prefixcmp(arg, "--encoding=")) {
-		arg += 11;
-		if (strcmp(arg, "none"))
-			git_log_output_encoding = xstrdup(arg);
+	} else if ((argcount = diff_long_opt("encoding", argv, &optarg))) {
+		if (strcmp(optarg, "none"))
+			git_log_output_encoding = xstrdup(optarg);
 		else
 			git_log_output_encoding = "";
+		return argcount;
 	} else if (!strcmp(arg, "--reverse")) {
 		revs->reverse ^= 1;
 	} else if (!strcmp(arg, "--children")) {
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 36870c5..dfbc173 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -201,6 +201,13 @@ test_expect_success 'log --grep' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log --grep option parsing' '
+	echo second >expect &&
+	git log -1 --pretty="tformat:%s" --grep sec >actual &&
+	test_cmp expect actual &&
+	test_must_fail git log -1 --pretty="tformat:%s" --grep
+'
+
 test_expect_success 'log -i --grep' '
 	echo Second >expect &&
 	git log -1 --pretty="tformat:%s" -i --grep=sec >actual &&
-- 
1.7.2.252.gb848
