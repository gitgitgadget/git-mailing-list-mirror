From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 07/19] pull: pass git-merge's options to git-merge
Date: Wed,  3 Jun 2015 14:48:51 +0800
Message-ID: <1433314143-4478-8-git-send-email-pyokagan@gmail.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 08:50:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z02VE-0004d5-EK
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 08:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322AbbFCGuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 02:50:11 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33113 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbbFCGuG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 02:50:06 -0400
Received: by pdbqa5 with SMTP id qa5so802701pdb.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 23:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mmte1ohohXga3yj5uxlOPaIssCtxQKcivFrh9RAidKM=;
        b=ntgIQNWhMFFEEg6eg8hjDleG3sFUQ2rzFik/MKH168Yo0mgq7kRILmbwDEno6XVqeB
         YvSBCiac/i+H5QGPEZHhLVL5HtIEcQXodnTQFoCqsSKXfpa2OPSBDQRE0wHR6rJrjHvX
         Rw7Usb9qh9UHiN3ZadIeoGhgRSs+s4N9VsBQQce/8+iK6T7XRmOp8yosLLXzNyj4Vb+r
         fhWbzjcOUQcbnzKdrlS9OhR4cLtYVWbAvPI+qWJNdHn/hn4O7+ELyfr1ChJRdTG13yJ4
         VdS2+n0DfBsQSmdDq09OMWl4WZs/S6cGyjaSoxGSyARSyNSucCQ06gwEr6ANJqjWAeDe
         CXYw==
X-Received: by 10.70.37.69 with SMTP id w5mr56632256pdj.123.1433314205755;
        Tue, 02 Jun 2015 23:50:05 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qt4sm19474130pbc.86.2015.06.02.23.50.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 23:50:04 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270643>

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

Notes:
    v2
    
    * Use opt_parse_pass_strbuf(), opt_parse_pass_argv_array() and
      argv_array_pushv()

 builtin/pull.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index c9c2cc0..5f08634 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -20,6 +20,18 @@ static const char * const pull_usage[] = {
 static int opt_verbosity;
 static struct strbuf opt_progress = STRBUF_INIT;
 
+/* Options passed to git-merge */
+static struct strbuf opt_diffstat = STRBUF_INIT;
+static struct strbuf opt_log = STRBUF_INIT;
+static struct strbuf opt_squash = STRBUF_INIT;
+static struct strbuf opt_commit = STRBUF_INIT;
+static struct strbuf opt_edit = STRBUF_INIT;
+static struct strbuf opt_ff = STRBUF_INIT;
+static struct strbuf opt_verify_signatures = STRBUF_INIT;
+static struct argv_array opt_strategies = ARGV_ARRAY_INIT;
+static struct argv_array opt_strategy_opts = ARGV_ARRAY_INIT;
+static struct strbuf opt_gpg_sign = STRBUF_INIT;
+
 static struct option pull_options[] = {
 	/* Shared options */
 	OPT__VERBOSITY(&opt_verbosity),
@@ -27,6 +39,49 @@ static struct option pull_options[] = {
 	  N_("force progress reporting"),
 	  PARSE_OPT_NOARG, parse_opt_pass_strbuf},
 
+	/* Options passed to git-merge */
+	OPT_GROUP(N_("Options related to merging")),
+	{ OPTION_CALLBACK, 'n', NULL, &opt_diffstat, NULL,
+	  N_("do not show a diffstat at the end of the merge"),
+	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_pass_strbuf },
+	{ OPTION_CALLBACK, 0, "stat", &opt_diffstat, NULL,
+	  N_("show a diffstat at the end of the merge"),
+	  PARSE_OPT_NOARG, parse_opt_pass_strbuf },
+	{ OPTION_CALLBACK, 0, "summary", &opt_diffstat, NULL,
+	  N_("(synonym to --stat)"),
+	  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, parse_opt_pass_strbuf },
+	{ OPTION_CALLBACK, 0, "log", &opt_log, N_("n"),
+	  N_("add (at most <n>) entries from shortlog to merge commit message"),
+	  PARSE_OPT_OPTARG, parse_opt_pass_strbuf },
+	{ OPTION_CALLBACK, 0, "squash", &opt_squash, NULL,
+	  N_("create a single commit instead of doing a merge"),
+	  PARSE_OPT_NOARG, parse_opt_pass_strbuf },
+	{ OPTION_CALLBACK, 0, "commit", &opt_commit, NULL,
+	  N_("perform a commit if the merge succeeds (default)"),
+	  PARSE_OPT_NOARG, parse_opt_pass_strbuf },
+	{ OPTION_CALLBACK, 0, "edit", &opt_edit, NULL,
+	  N_("edit message before committing"),
+	  PARSE_OPT_NOARG, parse_opt_pass_strbuf },
+	{ OPTION_CALLBACK, 0, "ff", &opt_ff, NULL,
+	  N_("allow fast-forward"),
+	  PARSE_OPT_NOARG, parse_opt_pass_strbuf },
+	{ OPTION_CALLBACK, 0, "ff-only", &opt_ff, NULL,
+	  N_("abort if fast-forward is not possible"),
+	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_pass_strbuf },
+	{ OPTION_CALLBACK, 0, "verify-signatures", &opt_verify_signatures, NULL,
+	  N_("verify that the named commit has a valid GPG signature"),
+	  PARSE_OPT_NOARG, parse_opt_pass_strbuf },
+	{ OPTION_CALLBACK, 's', "strategy", &opt_strategies, N_("strategy"),
+	  N_("merge strategy to use"),
+	  0, parse_opt_pass_argv_array },
+	{ OPTION_CALLBACK, 'X', "strategy-option", &opt_strategy_opts,
+	  N_("option=value"),
+	  N_("option for selected merge strategy"),
+	  0, parse_opt_pass_argv_array },
+	{ OPTION_CALLBACK, 'S', "gpg-sign", &opt_gpg_sign, N_("key-id"),
+	  N_("GPG sign commit"),
+	  PARSE_OPT_OPTARG, parse_opt_pass_strbuf },
+
 	OPT_END()
 };
 
@@ -100,6 +155,26 @@ static int run_merge(void)
 	if (opt_progress.len)
 		argv_array_push(&args, opt_progress.buf);
 
+	/* Options passed to git-merge */
+	if (opt_diffstat.len)
+		argv_array_push(&args, opt_diffstat.buf);
+	if (opt_log.len)
+		argv_array_push(&args, opt_log.buf);
+	if (opt_squash.len)
+		argv_array_push(&args, opt_squash.buf);
+	if (opt_commit.len)
+		argv_array_push(&args, opt_commit.buf);
+	if (opt_edit.len)
+		argv_array_push(&args, opt_edit.buf);
+	if (opt_ff.len)
+		argv_array_push(&args, opt_ff.buf);
+	if (opt_verify_signatures.len)
+		argv_array_push(&args, opt_verify_signatures.buf);
+	argv_array_pushv(&args, opt_strategies.argv);
+	argv_array_pushv(&args, opt_strategy_opts.argv);
+	if (opt_gpg_sign.len)
+		argv_array_push(&args, opt_gpg_sign.buf);
+
 	argv_array_push(&args, "FETCH_HEAD");
 	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
 	argv_array_clear(&args);
-- 
2.1.4
