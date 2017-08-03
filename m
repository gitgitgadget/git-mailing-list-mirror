Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E3121F991
	for <e@80x24.org>; Thu,  3 Aug 2017 18:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbdHCSUO (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 14:20:14 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33051 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751978AbdHCSUL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 14:20:11 -0400
Received: by mail-pf0-f181.google.com with SMTP id d67so9428945pfc.0
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 11:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fmyeYfAlOxA+Z/c5f2jitKwl1Xtxa3LPCdxZlZNJvS8=;
        b=NTIE0jXxYYLC7fk3PWxYiBZRcxlk5MPFQWnGhmX0lpqPJrE+BtY6D1yy7OdCtsTRTh
         leUjElm1lE0ZxOySMaJKgoCGyRHQI5TtLq42zI3Ih9t1OjmtPRW9XJgsCm5cLFq50hlG
         wtJ/hyHhE/c4r/cF1fMiJifVMf7i6mF5VjhE8GBt0H2gjev/0zO8dlVwcS3QOyyRkeMM
         3nBJxNs3RRirwRpP8P4cbJvUijOzJrIzVhLRDnPXgRVQZwX6PdW7vhk3iGSykcYn9BCZ
         itL9UKjK+Xl6Pcw+CHRgfz39Td986zWbsTGFSFOGviRNRqq+wCRyHPoSyZBuhB7PGysG
         ZtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fmyeYfAlOxA+Z/c5f2jitKwl1Xtxa3LPCdxZlZNJvS8=;
        b=H4gOm1MDTPQP6N+B6YV+F9eGZbe3kO7RS7ee6KgRgi5RnSZSc5CnHxBMwMLtnijqm5
         +TDdsdsEoZ6sZsR9KsOqvyKel+kXb9fU46SQ0f+ZjWOlAjYxWO7GmXxASaS9lj7WQQvM
         HvCqf5lkEi9doQApAdiFzYRF3h4eWrBFaEI5ITtFDmL9qM6pgQPer4lDYqs/U00IoINf
         7X9jxJchXewVHPuFSFmWmzNAgQTp67K2JCuTGCaZ594YpJjtXxyLHuxQquGxm69Rhy7H
         7B30vswZBd3/+MKhfm5gzWg2/AwlV+aqF6xvwwvxEDUrl9pKlMNM9AiF0kMYSTjmYcQR
         jwMg==
X-Gm-Message-State: AIVw110hHgvXaxQTTI7UtP/CNmPKFbORlh2ts9odvOVJ9Kb/xnPfJqIa
        QYqLF2ubqeK08xq902dGLA==
X-Received: by 10.84.141.3 with SMTP id 3mr3010077plu.128.1501784410493;
        Thu, 03 Aug 2017 11:20:10 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d1sm10706293pgc.57.2017.08.03.11.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 11:20:09 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Jens.Lehmann@web.de, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 03/15] add, reset: ensure submodules can be added or reset
Date:   Thu,  3 Aug 2017 11:19:48 -0700
Message-Id: <20170803182000.179328-4-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <20170803182000.179328-1-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
 <20170803182000.179328-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit aee9c7d65 (Submodules: Add the new "ignore" config option for
diff and status) introduced the ignore configuration option for
submodules so that configured submodules could be omitted from the
status and diff commands.  Because this flag is respected in the diff
machinery it has the unintended consequence of potentially prohibiting
users from adding or resetting a submodule, even when a path to the
submodule is explicitly given.

Ensure that submodules can be added or set, even if they are configured
to be ignored, by setting the `DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG` diff
flag.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/add.c   | 1 +
 builtin/reset.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/builtin/add.c b/builtin/add.c
index e888fb8c5..6f271512f 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -116,6 +116,7 @@ int add_files_to_cache(const char *prefix,
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = update_callback;
 	rev.diffopt.format_callback_data = &data;
+	rev.diffopt.flags |= DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
 	return !!data.add_errors;
diff --git a/builtin/reset.c b/builtin/reset.c
index 046403ed6..772d078b8 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -156,6 +156,7 @@ static int read_from_tree(const struct pathspec *pathspec,
 	opt.output_format = DIFF_FORMAT_CALLBACK;
 	opt.format_callback = update_index_from_diff;
 	opt.format_callback_data = &intent_to_add;
+	opt.flags |= DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;
 
 	if (do_diff_cache(tree_oid, &opt))
 		return 1;
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

