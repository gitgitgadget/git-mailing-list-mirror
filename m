From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 07/19] pull: pass git-merge's options to git-merge
Date: Thu, 18 Jun 2015 18:54:00 +0800
Message-ID: <1434624852-6869-8-git-send-email-pyokagan@gmail.com>
References: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 12:55:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5XTw-000210-NK
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 12:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754439AbbFRKzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 06:55:14 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:36390 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754252AbbFRKzE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 06:55:04 -0400
Received: by pdjm12 with SMTP id m12so64126070pdj.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 03:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=llH/5OZq0GPeKTdcIJwJBNGGHSMgBxN79Xa2dElgmvc=;
        b=EFWL76aMqwxyND24v61pze2OckyAQttJGQoh0ei4H+iINL3YPe+HyublqINJEmj6Mu
         KfgIcoTXFBWjpqcCRHnEoJhCsfzKrjX2Pk6HGXu4FFgeUhmj5v8cHSANmaNEt+45UVlb
         nQHnJeoyZ05Aq4RI0V4H5AttGTuPPSF7Fa1xCOd9FJfG+KmHnoG8WPQsMmB+uSDrWYBD
         BQ571IbMlrsZq+JTkVZPQ0IH8AWT7/ebL/2gUS5T1wcHI6myPJes0oE1hgejStnDx+4B
         FFKJ9LC1YH7vpeCH9LnM6JMsGwMg2Iqde+dBwBdExxU1Cw2KryyUQUwrcxLStq3rvQey
         wLjg==
X-Received: by 10.70.90.232 with SMTP id bz8mr7580337pdb.120.1434624901899;
        Thu, 18 Jun 2015 03:55:01 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id eu5sm7735063pac.37.2015.06.18.03.54.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 03:55:00 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434624852-6869-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271950>

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
