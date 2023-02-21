Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71502C636D7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 06:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjBUGBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 01:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjBUGBk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 01:01:40 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502762332A
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 22:01:38 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id ky4so5029511plb.3
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 22:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xy1IT01CTo/dcs+5t4ZdTy1e5bpLDuJ8H3Byjpbrpv0=;
        b=hoNZRY89jcTfdbBGZfHmxSMXhljToMgvYrLaUKcPpy9c9D5js6C7N+jHQ2uoohdexI
         aOqGSWkH+lF0+adD8rRtkcpAvZyOTeyHDihedOaNQz565nrXmJE9+sWpWO1DcJWZH/yc
         cYRcwiuzWcuG3hCqnCtKS9T/0GtqZmI2hj8kmKskLmW2wx8pux01WhARJu//5N7b88fH
         rtEkuIT17UsEVJswTqV248hRU+Y5fIo9Jc6IOPILY1THqJTsPKiJFerfmh5n5JCn/SNI
         SGy7aROVDR+J6dJl9fArlvTe4iG/V+O7VcYwpYBtBBrF8HefTbn7oP6yXxR1eAbmxkgC
         jz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xy1IT01CTo/dcs+5t4ZdTy1e5bpLDuJ8H3Byjpbrpv0=;
        b=lMsKJ7hAnK18tvqhyOZWRyEQpJJLuWXGK2c+VOYcpMe6aApbkmhlvnq202IurSi9yv
         E2GHV0NakDoloO0biNBix4M0YKEA75SVhXqkk1siPEiKEan7u8YAWJUlUbcP3WTAY5vU
         WI26osVkn+dKW8vy9ubyAYBrOC4BvIDOYwZjQgbVOWF0jyuakCbmFDo2+WRq5G/KRljG
         bD/lJyOs/+t4FxHvaYZ3nA59JW6j6TPKEu2YOaza+kBLv5imkHNhnPLrCiN8/mQTNQYL
         fF5ub4wfNcl74DdUqqGswC963dzzc4hRQtiE3Yscf+DTauAoD8fRIRB+YTQpL1HhmIcI
         tDsg==
X-Gm-Message-State: AO0yUKUkBugBangfQ01Xiq1Mrlh02Via6WufszxLrRkeifFLyr1W9OjI
        xnuDtd1kSVfihvIlnn7YrGbXBG3FECo=
X-Google-Smtp-Source: AK7set92KcmoeN5y+m88Q9QhVliwegpRHsxdML2cdjifH898rFibT9fktKUDoCUaY9QCz2xvov7EwA==
X-Received: by 2002:a17:90b:3847:b0:233:e9db:bd7d with SMTP id nl7-20020a17090b384700b00233e9dbbd7dmr4220554pjb.23.1676959297384;
        Mon, 20 Feb 2023 22:01:37 -0800 (PST)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id mv14-20020a17090b198e00b002308e6e645bsm993905pjb.49.2023.02.20.22.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 22:01:37 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2 3/4] rebase: stop accepting --rebase-merges=""
Date:   Mon, 20 Feb 2023 22:58:04 -0700
Message-Id: <20230221055805.210951-3-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230221055805.210951-1-alexhenrie24@gmail.com>
References: <20230221055805.210951-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The unusual syntax --rebase-merges="" (that is, --rebase-merges with an
empty string argument) has been an undocumented synonym of
--rebase-merges=no-rebase-cousins. Stop accepting that syntax to avoid
confusion when a rebase.merges config option is introduced, where
rebase.merges="" will be equivalent to not passing --rebase-merges.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/rebase.c         | 42 +++++++++++++++++++++++++++-------------
 t/t3430-rebase-merges.sh |  6 ++++++
 2 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 6635f10d52..0a8366f30f 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -771,6 +771,20 @@ static int run_specific_rebase(struct rebase_options *opts)
 	return status ? -1 : 0;
 }
 
+static void parse_merges_value(struct rebase_options *options, const char *value)
+{
+	if (value) {
+		if (!strcmp("no-rebase-cousins", value))
+			options->rebase_cousins = 0;
+		else if (!strcmp("rebase-cousins", value))
+			options->rebase_cousins = 1;
+		else
+			die(_("Unknown mode: %s"), value);
+	}
+
+	options->rebase_merges = 1;
+}
+
 static int rebase_config(const char *var, const char *value, void *data)
 {
 	struct rebase_options *opts = data;
@@ -980,6 +994,18 @@ static int parse_opt_empty(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int parse_opt_merges(const struct option *opt, const char *arg, int unset)
+{
+	struct rebase_options *options = opt->value;
+
+	if (unset)
+		options->rebase_merges = 0;
+	else
+		parse_merges_value(options, arg);
+
+	return 0;
+}
+
 static void NORETURN error_on_missing_default_upstream(void)
 {
 	struct branch *current_branch = branch_get(NULL);
@@ -1035,7 +1061,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct object_id branch_base;
 	int ignore_whitespace = 0;
 	const char *gpg_sign = NULL;
-	const char *rebase_merges = NULL;
 	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
 	struct object_id squash_onto;
 	char *squash_onto_name = NULL;
@@ -1137,10 +1162,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			   &options.allow_empty_message,
 			   N_("allow rebasing commits with empty messages"),
 			   PARSE_OPT_HIDDEN),
-		{OPTION_STRING, 'r', "rebase-merges", &rebase_merges,
-			N_("mode"),
+		OPT_CALLBACK_F('r', "rebase-merges", &options, N_("mode"),
 			N_("try to rebase merges instead of skipping them"),
-			PARSE_OPT_OPTARG, NULL, (intptr_t)""},
+			PARSE_OPT_OPTARG, parse_opt_merges),
 		OPT_BOOL(0, "fork-point", &options.fork_point,
 			 N_("use 'merge-base --fork-point' to refine upstream")),
 		OPT_STRING('s', "strategy", &options.strategy,
@@ -1436,16 +1460,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.exec.nr)
 		imply_merge(&options, "--exec");
 
-	if (rebase_merges) {
-		if (!*rebase_merges)
-			; /* default mode; do nothing */
-		else if (!strcmp("rebase-cousins", rebase_merges))
-			options.rebase_cousins = 1;
-		else if (strcmp("no-rebase-cousins", rebase_merges))
-			die(_("Unknown mode: %s"), rebase_merges);
-		options.rebase_merges = 1;
+	if (options.rebase_merges)
 		imply_merge(&options, "--rebase-merges");
-	}
 
 	if (options.type == REBASE_APPLY) {
 		if (ignore_whitespace)
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index e0d910c229..b8ba323dbc 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -293,6 +293,12 @@ test_expect_success 'do not rebase cousins unless asked for' '
 	EOF
 '
 
+test_expect_success '--rebase-merges="" is invalid syntax' '
+	echo "fatal: Unknown mode: " >expect &&
+	! git rebase --rebase-merges="" HEAD^ 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'refs/rewritten/* is worktree-local' '
 	git worktree add wt &&
 	cat >wt/script-from-scratch <<-\EOF &&
-- 
2.39.2

