From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 07/19] pull: pass git-merge's options to git-merge
Date: Sun, 14 Jun 2015 16:41:54 +0800
Message-ID: <1434271326-11349-8-git-send-email-pyokagan@gmail.com>
References: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 10:43:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z43W4-0006cm-CV
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 10:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbbFNIni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 04:43:38 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35636 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbbFNImr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 04:42:47 -0400
Received: by pacyx8 with SMTP id yx8so46695217pac.2
        for <git@vger.kernel.org>; Sun, 14 Jun 2015 01:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=llH/5OZq0GPeKTdcIJwJBNGGHSMgBxN79Xa2dElgmvc=;
        b=XbLsmy0XYTbefDw3nC9yg6Phxe2DiqhR8I0vSa2VlNjn+BRWdVhJ6ig/dlFYKILpH0
         b9ieh9cEQciOaO1JBhWTTrCYHVLm+iIO0zV5u4iiqKCXvU9pGO22z/1RrGggQSCZh+Z5
         8QHVnbEi8568ebTwYbtTSUFo2Bv1DM4ojoQosC0V+GgdmomLOAmXhyObuayubGS+xrJN
         or9aOmNBOxgu7D13ov617vEU6rSLQKiT/B8BH1Giex/bjWZO9KygKf5QKR/DJB4Y1QAX
         QMqLc8yy9JIZXBsY3u0o4wy5YOAFHnYgSx8DJ1ySaqmDCOJm6WqsmgG9Brgb2gJVroAg
         kPBw==
X-Received: by 10.70.125.129 with SMTP id mq1mr38385325pdb.19.1434271367184;
        Sun, 14 Jun 2015 01:42:47 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id kk6sm8622549pdb.94.2015.06.14.01.42.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Jun 2015 01:42:46 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434271326-11349-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271628>

Specify git-merge's options in the option list, and pass any specified
options to git-merge.

These options are:

* -n, --stat, --summary: since d8abe14 (merge, pull: introduce
  '--(no-)stat' option, 2008-04-06)

* --log: since efb779f (merge, pull: add '--(no-)log' command line
  option, 2008-04-06)

* --squash: since 7d0c688 (git-merge --squash, 2006-06-23)

* --commit: since 5072a32 (Teach git-pull about --[no-]ff, --no-squash
  and --commit, 2007-10-29)

* --edit: since 8580830 ("git pull" doesn't know "--edit", 2012-02-11)

* --ff, --ff-only: since 5072a32 (Teach git-pull about --[no-]ff,
  --no-squash and --commit, 2007-10-29)

* --verify-signatures: since efed002 (merge/pull: verify GPG signatures
  of commits being merged, 2013-03-31)

* -s, --strategy: since 60fb5b2 (Use git-merge in git-pull (second
  try)., 2005-09-25)

* -X, --strategy-option: since ee2c795 (Teach git-pull to pass
  -X<option> to git-merge, 2009-11-25)

* -S, --gpg-sign: since ea230d8 (pull: add the --gpg-sign option.,
  2014-02-10)

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index 5d9f2b5..0442da9 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -20,6 +20,18 @@ static const char * const pull_usage[] = {
 static int opt_verbosity;
 static char *opt_progress;
 
+/* Options passed to git-merge */
+static char *opt_diffstat;
+static char *opt_log;
+static char *opt_squash;
+static char *opt_commit;
+static char *opt_edit;
+static char *opt_ff;
+static char *opt_verify_signatures;
+static struct argv_array opt_strategies = ARGV_ARRAY_INIT;
+static struct argv_array opt_strategy_opts = ARGV_ARRAY_INIT;
+static char *opt_gpg_sign;
+
 static struct option pull_options[] = {
 	/* Shared options */
 	OPT__VERBOSITY(&opt_verbosity),
@@ -27,6 +39,49 @@ static struct option pull_options[] = {
 		N_("force progress reporting"),
 		PARSE_OPT_NOARG),
 
+	/* Options passed to git-merge */
+	OPT_GROUP(N_("Options related to merging")),
+	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
+		N_("do not show a diffstat at the end of the merge"),
+		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
+	OPT_PASSTHRU(0, "stat", &opt_diffstat, NULL,
+		N_("show a diffstat at the end of the merge"),
+		PARSE_OPT_NOARG),
+	OPT_PASSTHRU(0, "summary", &opt_diffstat, NULL,
+		N_("(synonym to --stat)"),
+		PARSE_OPT_NOARG | PARSE_OPT_HIDDEN),
+	OPT_PASSTHRU(0, "log", &opt_log, N_("n"),
+		N_("add (at most <n>) entries from shortlog to merge commit message"),
+		PARSE_OPT_OPTARG),
+	OPT_PASSTHRU(0, "squash", &opt_squash, NULL,
+		N_("create a single commit instead of doing a merge"),
+		PARSE_OPT_NOARG),
+	OPT_PASSTHRU(0, "commit", &opt_commit, NULL,
+		N_("perform a commit if the merge succeeds (default)"),
+		PARSE_OPT_NOARG),
+	OPT_PASSTHRU(0, "edit", &opt_edit, NULL,
+		N_("edit message before committing"),
+		PARSE_OPT_NOARG),
+	OPT_PASSTHRU(0, "ff", &opt_ff, NULL,
+		N_("allow fast-forward"),
+		PARSE_OPT_NOARG),
+	OPT_PASSTHRU(0, "ff-only", &opt_ff, NULL,
+		N_("abort if fast-forward is not possible"),
+		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
+	OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
+		N_("verify that the named commit has a valid GPG signature"),
+		PARSE_OPT_NOARG),
+	OPT_PASSTHRU_ARGV('s', "strategy", &opt_strategies, N_("strategy"),
+		N_("merge strategy to use"),
+		0),
+	OPT_PASSTHRU_ARGV('X', "strategy-option", &opt_strategy_opts,
+		N_("option=value"),
+		N_("option for selected merge strategy"),
+		0),
+	OPT_PASSTHRU('S', "gpg-sign", &opt_gpg_sign, N_("key-id"),
+		N_("GPG sign commit"),
+		PARSE_OPT_OPTARG),
+
 	OPT_END()
 };
 
@@ -101,6 +156,26 @@ static int run_merge(void)
 	if (opt_progress)
 		argv_array_push(&args, opt_progress);
 
+	/* Options passed to git-merge */
+	if (opt_diffstat)
+		argv_array_push(&args, opt_diffstat);
+	if (opt_log)
+		argv_array_push(&args, opt_log);
+	if (opt_squash)
+		argv_array_push(&args, opt_squash);
+	if (opt_commit)
+		argv_array_push(&args, opt_commit);
+	if (opt_edit)
+		argv_array_push(&args, opt_edit);
+	if (opt_ff)
+		argv_array_push(&args, opt_ff);
+	if (opt_verify_signatures)
+		argv_array_push(&args, opt_verify_signatures);
+	argv_array_pushv(&args, opt_strategies.argv);
+	argv_array_pushv(&args, opt_strategy_opts.argv);
+	if (opt_gpg_sign)
+		argv_array_push(&args, opt_gpg_sign);
+
 	argv_array_push(&args, "FETCH_HEAD");
 	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
 	argv_array_clear(&args);
-- 
2.1.4
