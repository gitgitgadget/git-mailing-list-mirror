Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 284BE1F858
	for <e@80x24.org>; Mon,  1 Aug 2016 01:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbcHABGP (ORCPT <rfc822;e@80x24.org>);
	Sun, 31 Jul 2016 21:06:15 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45858 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997AbcHABGO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2016 21:06:14 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC4661F858;
	Mon,  1 Aug 2016 01:06:12 +0000 (UTC)
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>, "Kyle J. McKay" <mackyle@gmail.com>,
	git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: [PATCH 2/2] pager: implement core.pagerEnv in config
Date:	Mon,  1 Aug 2016 01:05:57 +0000
Message-Id: <20160801010557.22191-3-e@80x24.org>
In-Reply-To: <20160801010557.22191-1-e@80x24.org>
References: <20160801010557.22191-1-e@80x24.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This allows overriding the build-time PAGER_ENV variable
at run-time.

Inspired by part 1 of an idea from Kyle J. McKay at:
https://public-inbox.org/git/62DB6DEF-8B39-4481-BA06-245BF45233E5@gmail.com/

Signed-off-by: Eric Wong <e@80x24.org>
---
 Documentation/config.txt |  7 +++++++
 pager.c                  |  5 ++++-
 t/t7006-pager.sh         | 14 ++++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8b1aee4..6c20269 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -714,6 +714,13 @@ Likewise, when the `LV` environment variable is unset, Git sets it
 to `-c`.  You can override this setting by exporting `LV` with
 another value or setting `core.pager` to `lv +c`.
 
+core.pagerEnv::
+	Environment for running `core.pager`.
++
+Defaults to the value set at build, usually `LESS=FRX LV=-c`.
+On platforms where `more` and `less` are the same binary,
+`LESS=FRX LV=-c MORE=FRX` is appropriate.
+
 core.whitespace::
 	A comma separated list of common whitespace problems to
 	notice.  'git diff' will use `color.diff.whitespace` to
diff --git a/pager.c b/pager.c
index 2f2cadc..cc2df7c 100644
--- a/pager.c
+++ b/pager.c
@@ -68,7 +68,10 @@ const char *git_pager(int stdout_is_tty)
 
 static void setup_pager_env(struct argv_array *env)
 {
-	const char *pager_env = stringify(PAGER_ENV);
+	const char *pager_env;
+
+	if (git_config_get_value("core.pagerenv", &pager_env))
+		pager_env = stringify(PAGER_ENV);
 
 	while (*pager_env) {
 		struct strbuf buf = STRBUF_INIT;
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index e4fc5c8..0c482fc 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -456,4 +456,18 @@ test_expect_success 'command with underscores does not complain' '
 	test_cmp expect actual
 '
 
+test_expect_success TTY 'core.pagerEnv overrides build-time env' '
+	(
+		sane_unset LESS LV MORE &&
+		git config core.pagerEnv MORE=-R &&
+		PAGER="env >pager-env.out; wc" &&
+		export PAGER &&
+		test_terminal git log
+	) &&
+	git config --unset core.pagerEnv &&
+	grep ^MORE=-R pager-env.out &&
+	grep -v ^LESS= pager-env.out &&
+	grep -v ^LV= pager-env.out
+'
+
 test_done
-- 
EW

