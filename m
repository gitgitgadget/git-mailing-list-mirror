From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 09/10] revert: Implement parsing --continue, --abort and --skip
Date: Wed, 25 May 2011 14:17:04 +0000
Message-ID: <1306333025-29893-10-git-send-email-artagnon@gmail.com>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 16:17:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPEuF-0003uG-4v
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 16:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932712Ab1EYOR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 10:17:29 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:51743 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932548Ab1EYORW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 10:17:22 -0400
Received: by qyg14 with SMTP id 14so4504513qyg.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 07:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=d48SXfb0foLIjY09aOOB2FKCAbd6Uk07M3UajFlpJG4=;
        b=Y3vSBLyXbCeEqnqU4jfjzEvmsE6tgvnLa5pwEU3m9qUjbncoU2sOlU29fgGpcsU51j
         f/coHBJ3V41cLpXKFVpOnfYydyBxt8TZGIFmlkkzKqlnZkxRYA1itnBvy+g6s8joaCyQ
         lhnIikqQJKmkX0lIVyhN9dUZraHFboJ6qGJZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sl+BpDs2LIvcfb2dcV9c5UyZOj7EsZcmcqTEtODIjfBe+9CNqFXJItET3S27TwbZL5
         ZgdiszGPw1sD2tIo8Frx++P0GpC4HjvLpLipwhUC5Z2fVI4PUudl1PKDsVsBZzfr8Ho/
         QYk+a94AiySOMyOiob4oljjTGiTOba8qKdZcU=
Received: by 10.224.200.69 with SMTP id ev5mr3966208qab.259.1306333042068;
        Wed, 25 May 2011 07:17:22 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id t17sm5285636qcs.35.2011.05.25.07.17.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 May 2011 07:17:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174400>

Introduce three new command-line options: --continue, --abort, and
--skip resembling the correspoding options in "rebase -i".  For now,
just parse the options into the replay_opts structure, making sure
that two of them are not specified together.  They will actually be
implemented later in the series.

Mentored-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |   71 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 70 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 4741252..4607676 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -47,6 +47,11 @@ static const char *me;
 struct replay_opts {
 	enum { REVERT, CHERRY_PICK } action;
 
+	/* --abort, --skip, and --continue */
+	int abort_oper;
+	int skip_oper;
+	int continue_oper;
+
 	/* Boolean options */
 	int edit;
 	int record_origin;
@@ -103,11 +108,36 @@ static void verify_opt_compatible(const char *me, const char *base_opt, ...)
 	va_end(ap);
 }
 
+static void verify_opt_mutually_compatible(const char *me, ...)
+{
+	const char *opt1, *opt2;
+	va_list ap;
+	int set;
+
+	va_start(ap, me);
+	while ((opt1 = va_arg(ap, const char *))) {
+		set = va_arg(ap, int);
+		if (set)
+			break;
+	}
+	if (!opt1) return;
+	while ((opt2 = va_arg(ap, const char *))) {
+		set = va_arg(ap, int);
+		if (set)
+			die(_("%s: %s cannot be used with %s"),
+				me, opt1, opt2);
+	}
+	va_end(ap);
+}
+
 static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 {
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
 	int noop;
 	struct option options[] = {
+		OPT_BOOLEAN(0, "abort", &opts->abort_oper, "abort the current operation"),
+		OPT_BOOLEAN(0, "skip", &opts->skip_oper, "skip the current commit"),
+		OPT_BOOLEAN(0, "continue", &opts->continue_oper, "continue the current operation"),
 		OPT_BOOLEAN('n', "no-commit", &opts->no_commit, "don't automatically commit"),
 		OPT_BOOLEAN('e', "edit", &opts->edit, "edit the commit message"),
 		{ OPTION_BOOLEAN, 'r', NULL, &noop, NULL, "no-op (backward compatibility)",
@@ -136,7 +166,37 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	opts->commit_argc = parse_options(argc, argv, NULL, options, usage_str,
 					PARSE_OPT_KEEP_ARGV0 |
 					PARSE_OPT_KEEP_UNKNOWN);
-	if (opts->commit_argc < 2)
+
+	/* Check for mutually incompatible command line arguments */
+	verify_opt_mutually_compatible(me,
+				"--abort", opts->abort_oper,
+				"--skip", opts->skip_oper,
+				"--continue", opts->continue_oper,
+				NULL);
+
+	/* Check for incompatible command line arguments */
+	if (opts->abort_oper || opts->skip_oper || opts->continue_oper) {
+		char *this_oper;
+		if (opts->abort_oper)
+			this_oper = "--abort";
+		else if (opts->skip_oper)
+			this_oper = "--skip";
+		else
+			this_oper = "--continue";
+
+		verify_opt_compatible(me, this_oper,
+				"--no-commit", opts->no_commit,
+				"--edit", opts->edit,
+				"--signoff", opts->signoff,
+				"--mainline", opts->mainline,
+				"--strategy", opts->strategy ? 1 : 0,
+				"--strategy-option", opts->xopts ? 1 : 0,
+				"-x", opts->record_origin,
+				"--ff", opts->allow_ff,
+				NULL);
+	}
+
+	else if (opts->commit_argc < 2)
 		usage_with_options(usage_str, options);
 
 	if (opts->allow_ff)
@@ -146,6 +206,15 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 				"-x", opts->record_origin,
 				"--edit", opts->edit,
 				NULL);
+
+	/* Remove these when the options are actually implemented */
+	if (opts->abort_oper)
+		die("--abort is not implemented yet");
+	if (opts->skip_oper)
+		die("--skip is not implemented yet");
+	if (opts->continue_oper)
+		die("--continue is not implemented yet");
+
 	opts->commit_argv = argv;
 }
 
-- 
1.7.5.GIT
