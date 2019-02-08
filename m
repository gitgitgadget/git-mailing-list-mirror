Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB51A1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 18:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfBHScR (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 13:32:17 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51221 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbfBHScR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 13:32:17 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <rhi@pengutronix.de>)
        id 1gsAwi-00020V-Em; Fri, 08 Feb 2019 19:32:16 +0100
Received: from rhi by dude.hi.pengutronix.de with local (Exim 4.92-RC5)
        (envelope-from <rhi@pengutronix.de>)
        id 1gsAwf-0003JD-Sl; Fri, 08 Feb 2019 19:32:13 +0100
From:   Roland Hieber <rhi@pengutronix.de>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Stefan Beller <stefanbeller@gmail.com>,
        Roland Hieber <rhi@pengutronix.de>
Subject: [PATCH v2] reflog: specify default pretty format in config
Date:   Fri,  8 Feb 2019 19:31:45 +0100
Message-Id: <20190208183145.11041-1-rhi@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130144744.3248-1-rhi@pengutronix.de>
References: <20190130144744.3248-1-rhi@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: rhi@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The output of git-reflog(1) is currently only customisable by calling
reflog with --pretty=... or overriding the "pretty.oneline" format in
the config, which is currently the default fallback.

To enhance flexibility and save typing, teach reflog to fall back to a
default format specified in the config option "reflog.pretty" unless a
different pretty format is given on the command line. This behaviour is
similar to the "format.pretty" option for git-log(1) and git-show(1).
When "reflog.pretty" is not set, fall back to the old default of
--pretty=oneline --abbrev-hash.

Signed-off-by: Roland Hieber <rhi@pengutronix.de>
---
Changes in v1 -> v2:
 - add test
 - add documentation for git-config(1)
 - remove accidental whitespace change
---
 Documentation/config.txt        |  2 ++
 Documentation/config/reflog.txt |  5 +++++
 Documentation/git-reflog.txt    |  2 ++
 builtin/log.c                   | 11 ++++++++---
 t/t1410-reflog.sh               | 21 +++++++++++++++++++++
 5 files changed, 38 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/config/reflog.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d87846faa..193c312fe 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -394,6 +394,8 @@ include::config/rebase.txt[]
 
 include::config/receive.txt[]
 
+include::config/reflog.txt[]
+
 include::config/remote.txt[]
 
 include::config/remotes.txt[]
diff --git a/Documentation/config/reflog.txt b/Documentation/config/reflog.txt
new file mode 100644
index 000000000..637cd852a
--- /dev/null
+++ b/Documentation/config/reflog.txt
@@ -0,0 +1,5 @@
+reflog.pretty::
+	The default pretty format used by linkgit:git-reflog[1] if nothing
+	else is specified via the `--pretty=` option.  If both are unset,
+	git-reflog falls back to `--pretty=oneline --abbrev-hash`.  See the
+	section Pretty Formats in linkgit:git-log[1] for possible values.
diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index ff487ff77..9dccd4bcf 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -41,6 +41,8 @@ command-line (or `HEAD`, by default). The reflog covers all recent
 actions, and in addition the `HEAD` reflog records branch switching.
 `git reflog show` is an alias for `git log -g --abbrev-commit
 --pretty=oneline`; see linkgit:git-log[1] for more information.
+The config option `reflog.pretty` is used as the default pretty
+format if nothing else is specified.
 
 The "expire" subcommand prunes older reflog entries. Entries older
 than `expire` time, or entries older than `expire-unreachable` time
diff --git a/builtin/log.c b/builtin/log.c
index a479642eb..0592e5076 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -667,6 +667,7 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
 	struct setup_revision_opt opt;
+	int cfg_have_pretty;
 
 	init_log_defaults();
 	git_config(git_log_config, NULL);
@@ -676,10 +677,14 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	rev.verbose_header = 1;
 	memset(&opt, 0, sizeof(opt));
 	opt.def = "HEAD";
+
+	cfg_have_pretty = git_config_get_string_const("reflog.pretty", &fmt_pretty);
 	cmd_log_init_defaults(&rev);
-	rev.abbrev_commit = 1;
-	rev.commit_format = CMIT_FMT_ONELINE;
-	rev.use_terminator = 1;
+	if (cfg_have_pretty != 0) {
+		rev.abbrev_commit = 1;
+		rev.commit_format = CMIT_FMT_ONELINE;
+		rev.use_terminator = 1;
+	}
 	rev.always_show_header = 1;
 	cmd_log_init_finish(argc, argv, prefix, &rev, &opt);
 
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index ae8a448e3..74abf3d0f 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -383,4 +383,25 @@ test_expect_success 'expire with multiple worktrees' '
 	)
 '
 
+test_expect_success '--pretty format' '
+	git init pretty-formats &&
+	(
+		cd pretty-formats &&
+		cat >expect <<-\EOF &&
+		HEAD@{0} commit (initial): foobar
+		EOF
+		test_tick &&
+		test_commit foobar &&
+
+		git reflog -n1 --pretty="%gD %gs" > output &&
+		test_cmp expect output &&
+
+		git -c reflog.pretty="%gD %gs" reflog -n1 > output &&
+		test_cmp expect output &&
+
+		git -c reflog.pretty="%h" reflog -n1 --pretty="%gD %gs" > output &&
+		test_cmp expect output
+	)
+'
+
 test_done
-- 
2.19.2

