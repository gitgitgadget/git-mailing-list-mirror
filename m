Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FE7C433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 08:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97F4761209
	for <git@archiver.kernel.org>; Mon, 17 May 2021 08:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhEQIEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 04:04:37 -0400
Received: from coleridge.oriole.systems ([89.238.76.34]:49802 "EHLO
        coleridge.oriole.systems" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhEQIEh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 04:04:37 -0400
From:   =?UTF-8?q?Wolfgang=20M=C3=BCller?= <wolf@oriole.systems>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Wolfgang=20M=C3=BCller?= <wolf@oriole.systems>
Subject: [PATCH v2 1/2] rev-parse: fix segfault with missing --path-format argument
Date:   Mon, 17 May 2021 10:02:42 +0200
Message-Id: <20210517080243.10191-2-wolf@oriole.systems>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517080243.10191-1-wolf@oriole.systems>
References: <20210516120449.661636-1-wolf@oriole.systems>
 <20210517080243.10191-1-wolf@oriole.systems>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calling "git rev-parse --path-format" without an argument segfaults
instead of giving an error message. Commit fac60b8925 (rev-parse: add
option for absolute or relative path formatting, 2020-12-13) added the
argument parsing code but forgot to handle NULL.

Returning an error makes sense here because there is no default value we
could use. Add a test case to verify.

Signed-off-by: Wolfgang Müller <wolf@oriole.systems>
---
 builtin/rev-parse.c  | 2 ++
 t/t1500-rev-parse.sh | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 85bad9052e..7af8dab8bc 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -759,6 +759,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (opt_with_value(arg, "--path-format", &arg)) {
+				if (!arg)
+					die("--path-format requires an argument");
 				if (!strcmp(arg, "absolute")) {
 					format = FORMAT_CANONICAL;
 				} else if (!strcmp(arg, "relative")) {
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index deae916707..1c2df08333 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -146,6 +146,10 @@ test_expect_success '--path-format can change in the middle of the command line'
 	test_cmp expect actual
 '
 
+test_expect_success '--path-format does not segfault without an argument' '
+	test_must_fail git rev-parse --path-format
+'
+
 test_expect_success 'git-common-dir from worktree root' '
 	echo .git >expect &&
 	git rev-parse --git-common-dir >actual &&
-- 
2.31.1

