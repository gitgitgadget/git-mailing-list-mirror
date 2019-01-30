Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A04F1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 14:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbfA3Or6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 09:47:58 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35307 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730350AbfA3Or6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 09:47:58 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <rhi@pengutronix.de>)
        id 1gor9f-0005yJ-R2; Wed, 30 Jan 2019 15:47:55 +0100
Received: from rhi by dude.hi.pengutronix.de with local (Exim 4.92-RC4)
        (envelope-from <rhi@pengutronix.de>)
        id 1gor9d-0000vd-Bi; Wed, 30 Jan 2019 15:47:53 +0100
From:   Roland Hieber <rhi@pengutronix.de>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Stefan Beller <stefanbeller@gmail.com>,
        Roland Hieber <rhi@pengutronix.de>
Subject: [PATCH] reflog: specify default pretty format in config
Date:   Wed, 30 Jan 2019 15:47:44 +0100
Message-Id: <20190130144744.3248-1-rhi@pengutronix.de>
X-Mailer: git-send-email 2.20.1
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

The output of git-reflog is currently only customizable by calling
reflog with --pretty=... or overriding the default "oneline" pretty
format in the configuration. To save typing, teach reflog to fall back
to a default format specified in the config option "reflog.pretty"
unless a different pretty format is given on the command line. (This is
similar to the "format.pretty" option for git-log and git-show.)
When this config option is not set, fall back to the old default of
--pretty=oneline --abbrev-hash.

Signed-off-by: Roland Hieber <rhi@pengutronix.de>
---
 Documentation/git-reflog.txt |  2 ++
 builtin/log.c                | 12 +++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index ff487ff77d..9dccd4bcfd 100644
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
index a479642eb9..0fbd324016 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -667,6 +667,7 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
 	struct setup_revision_opt opt;
+	int cfg_have_pretty;
 
 	init_log_defaults();
 	git_config(git_log_config, NULL);
@@ -676,11 +677,16 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
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
+
 	cmd_log_init_finish(argc, argv, prefix, &rev, &opt);
 
 	return cmd_log_walk(&rev);
-- 
2.20.1

