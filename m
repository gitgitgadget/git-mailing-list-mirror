From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/4 v2] Allow detached form (e.g. "git log --grep foo") in log options.
Date: Wed, 28 Jul 2010 11:41:01 +0200
Message-ID: <1280310062-16793-3-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqr5ioukca.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 28 11:46:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe3Dc-0008N5-21
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 11:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532Ab0G1Jq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 05:46:27 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33638 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754239Ab0G1Jq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 05:46:26 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o6S9Uu14028375
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Jul 2010 11:30:56 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oe38L-0000KV-Vr; Wed, 28 Jul 2010 11:41:06 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Oe38L-0004NX-Uq; Wed, 28 Jul 2010 11:41:05 +0200
X-Mailer: git-send-email 1.7.2.25.g9ebe3
In-Reply-To: <vpqr5ioukca.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 28 Jul 2010 11:30:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6S9Uu14028375
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1280914257.93629@nSzcvcbccWscMj0LgQNuQQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152065>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 revision.c     |   86 ++++++++++++++++++++++++++++++++++---------------------
 t/t4202-log.sh |    7 ++++
 2 files changed, 60 insertions(+), 33 deletions(-)

diff --git a/revision.c b/revision.c
index 7e82efd..92035a3 100644
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
@@ -1295,27 +1305,32 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
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
 	} else if (!strcmp(arg, "--show-notes")) {
 		revs->show_notes = 1;
 		revs->show_notes_given = 1;
-	} else if (!prefixcmp(arg, "--show-notes=")) {
+	} else if ((argcount = diff_long_opt("show-notes", argv, &optarg))) {
 		struct strbuf buf = STRBUF_INIT;
 		revs->show_notes = 1;
 		revs->show_notes_given = 1;
 		if (!revs->notes_opt.extra_notes_refs)
 			revs->notes_opt.extra_notes_refs = xcalloc(1, sizeof(struct string_list));
-		if (!prefixcmp(arg+13, "refs/"))
+		if (!prefixcmp(optarg, "refs/"))
 			/* happy */;
-		else if (!prefixcmp(arg+13, "notes/"))
+		else if (!prefixcmp(optarg, "notes/"))
 			strbuf_addstr(&buf, "refs/");
 		else
 			strbuf_addstr(&buf, "refs/notes/");
-		strbuf_addstr(&buf, arg+13);
+		strbuf_addstr(&buf, optarg);
 		string_list_append(revs->notes_opt.extra_notes_refs,
 				   strbuf_detach(&buf, NULL));
+		return argcount;
 	} else if (!strcmp(arg, "--no-notes")) {
 		revs->show_notes = 0;
 		revs->show_notes_given = 1;
@@ -1343,12 +1358,13 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->abbrev = 0;
 	} else if (!strcmp(arg, "--abbrev")) {
 		revs->abbrev = DEFAULT_ABBREV;
-	} else if (!prefixcmp(arg, "--abbrev=")) {
-		revs->abbrev = strtoul(arg + 9, NULL, 10);
+	} else if ((argcount = diff_long_opt("abbrev", argv, &optarg))) {
+		revs->abbrev = strtoul(optarg, NULL, 10);
 		if (revs->abbrev < MINIMUM_ABBREV)
 			revs->abbrev = MINIMUM_ABBREV;
 		else if (revs->abbrev > 40)
 			revs->abbrev = 40;
+		return argcount;
 	} else if (!strcmp(arg, "--abbrev-commit")) {
 		revs->abbrev_commit = 1;
 	} else if (!strcmp(arg, "--full-diff")) {
@@ -1359,21 +1375,25 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
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
@@ -1382,12 +1402,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->grep_filter.fixed = 1;
 	} else if (!strcmp(arg, "--all-match")) {
 		revs->grep_filter.all_match = 1;
-	} else if (!prefixcmp(arg, "--encoding=")) {
-		arg += 11;
+	} else if ((argcount = diff_long_opt("encoding", argv, &optarg))) {
 		if (strcmp(arg, "none"))
-			git_log_output_encoding = xstrdup(arg);
+			git_log_output_encoding = xstrdup(optarg);
 		else
 			git_log_output_encoding = "";
+		return argcount;
 	} else if (!strcmp(arg, "--reverse")) {
 		revs->reverse ^= 1;
 	} else if (!strcmp(arg, "--children")) {
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 3352935..f912589 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -208,6 +208,13 @@ test_expect_success 'log --grep' '
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
1.7.2.25.g9ebe3
