Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 380201F404
	for <e@80x24.org>; Mon, 13 Aug 2018 22:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731662AbeHNB1G (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 21:27:06 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:55930 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbeHNB1G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 21:27:06 -0400
Received: by mail-it0-f74.google.com with SMTP id e21-v6so10971143itb.5
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 15:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zqfwjqlmA9N5x2hHGTcSbOHKOOxnj9PO2b2GoHGdaqU=;
        b=uXw73zR3x9TfsSC95EznlbFflEmj7SnDn1iJSk6w/NVrfz2fn78R02yUSu9AK5E3YU
         y7p778H+7OwuGKkfe/k7fEj4yFoku1jF2Bw/AEIzNY2OTsegqKFoyW+P1Kbia1aNCCDO
         I+DBmSvO4b+kAM5LRNLiefLfNr3SXwWeqnKnAyTwvbnRqofn7CC+M9aYjtuCw9XS+Igd
         EX1INLAxApiDQqAJbx35ZemSMAAbeVCxVCDaxHrdoIf+3zxufBsTT3oz8GBGC+VQDwmf
         AMdXTMVialBat1SLTaWLauSimSCdVHX6JEG3iw2NCTS/3hqLebF5+ITQ5kdpoX7Hls3J
         oD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zqfwjqlmA9N5x2hHGTcSbOHKOOxnj9PO2b2GoHGdaqU=;
        b=SxWKMxKISXbREcpcADVMQm+yWKN6UZBz6k6IRljA6O7MtOWgEhblU0L/PWCXYqCODc
         UAvmGqmvsHd5sWzO8TcWv9g+dGaLzBL+t/NCNl09U8q109fg6GOQm5rUArW3RrWKZZST
         Hfz5aYyG4f1/c8AfZ8sI63PiyQ0bIBuz3Lu1G2xKh3zvFizkl3GB6LO09RiN7Pt5xmcu
         2q8jJxEaG8WeRawoaOp652S6pEmDexCH/tN5doagUwTByYQ1IgpzGoxoAJMH7fYAiEWe
         KmZDOa4402wXzdV9ooBR5nLTW6OPFJqxjJQ9tegUZOlB6ycVa8FkVlDznp6mE3byJNvD
         XDXQ==
X-Gm-Message-State: AOUpUlF54q4l9DUQuPR/IHCRHa6BUehWhbwQ/aEKfKZu5GLp7Z5dtcHf
        bgobviSEiPl9TkRhJkOCUqWjPgL6oN/4
X-Google-Smtp-Source: AA+uWPwMB0I1eB9tE/Cu3Ft30orIwnhEMlAtz9YAYZ7veld9YyV/cMAjDeZTsw7/347WM0KC+ojVboYmiime
X-Received: by 2002:a24:d11:: with SMTP id 17-v6mr7516810itx.3.1534200169882;
 Mon, 13 Aug 2018 15:42:49 -0700 (PDT)
Date:   Mon, 13 Aug 2018 15:42:31 -0700
In-Reply-To: <20180813224235.154580-1-sbeller@google.com>
Message-Id: <20180813224235.154580-4-sbeller@google.com>
Mime-Version: 1.0
References: <20180803222322.261813-1-sbeller@google.com> <20180813224235.154580-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 3/7] builtin/submodule--helper: factor out submodule updating
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Separate the command line parsing from the actual execution of the command
within the repository. For now there is not a lot of execution as
most of it is still in git-submodule.sh.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 59 +++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index da700c88963..32f00ca6f87 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1474,6 +1474,8 @@ struct submodule_update_clone {
 	/* failed clones to be retried again */
 	const struct cache_entry **failed_clones;
 	int failed_clones_nr, failed_clones_alloc;
+
+	int max_jobs;
 };
 #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
 	SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, 0, \
@@ -1716,11 +1718,36 @@ static int git_update_clone_config(const char *var, const char *value,
 	return 0;
 }
 
+static int update_submodules(struct submodule_update_clone *suc)
+{
+	struct string_list_item *item;
+
+	run_processes_parallel(suc->max_jobs,
+			       update_clone_get_next_task,
+			       update_clone_start_failure,
+			       update_clone_task_finished,
+			       suc);
+
+	/*
+	 * We saved the output and put it out all at once now.
+	 * That means:
+	 * - the listener does not have to interleave their (checkout)
+	 *   work with our fetching.  The writes involved in a
+	 *   checkout involve more straightforward sequential I/O.
+	 * - the listener can avoid doing any work if fetching failed.
+	 */
+	if (suc->quickstop)
+		return 1;
+
+	for_each_string_list_item(item, &suc->projectlines)
+		fprintf(stdout, "%s", item->string);
+
+	return 0;
+}
+
 static int update_clone(int argc, const char **argv, const char *prefix)
 {
 	const char *update = NULL;
-	int max_jobs = 1;
-	struct string_list_item *item;
 	struct pathspec pathspec;
 	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
 
@@ -1742,7 +1769,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "depth", &suc.depth, "<depth>",
 			   N_("Create a shallow clone truncated to the "
 			      "specified number of revisions")),
-		OPT_INTEGER('j', "jobs", &max_jobs,
+		OPT_INTEGER('j', "jobs", &suc.max_jobs,
 			    N_("parallel jobs")),
 		OPT_BOOL(0, "recommend-shallow", &suc.recommend_shallow,
 			    N_("whether the initial clone should follow the shallow recommendation")),
@@ -1758,8 +1785,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	};
 	suc.prefix = prefix;
 
-	update_clone_config_from_gitmodules(&max_jobs);
-	git_config(git_update_clone_config, &max_jobs);
+	update_clone_config_from_gitmodules(&suc.max_jobs);
+	git_config(git_update_clone_config, &suc.max_jobs);
 
 	argc = parse_options(argc, argv, prefix, module_update_clone_options,
 			     git_submodule_helper_usage, 0);
@@ -1774,27 +1801,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	if (pathspec.nr)
 		suc.warn_if_uninitialized = 1;
 
-	run_processes_parallel(max_jobs,
-			       update_clone_get_next_task,
-			       update_clone_start_failure,
-			       update_clone_task_finished,
-			       &suc);
-
-	/*
-	 * We saved the output and put it out all at once now.
-	 * That means:
-	 * - the listener does not have to interleave their (checkout)
-	 *   work with our fetching.  The writes involved in a
-	 *   checkout involve more straightforward sequential I/O.
-	 * - the listener can avoid doing any work if fetching failed.
-	 */
-	if (suc.quickstop)
-		return 1;
-
-	for_each_string_list_item(item, &suc.projectlines)
-		fprintf(stdout, "%s", item->string);
-
-	return 0;
+	return update_submodules(&suc);
 }
 
 static int resolve_relative_path(int argc, const char **argv, const char *prefix)
-- 
2.18.0.865.gffc8e1a3cd6-goog

