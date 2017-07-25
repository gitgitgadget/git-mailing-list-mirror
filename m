Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 548051F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 21:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751538AbdGYVkp (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 17:40:45 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:37325 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751759AbdGYVjp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 17:39:45 -0400
Received: by mail-pg0-f41.google.com with SMTP id y129so75227394pgy.4
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 14:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LgG4jFCI3CPx+0ajvSWvk8LvyC8bwi+Jp9NJuOjUHsE=;
        b=OMWCI/2aB2CSPNznqVwy8z+LGmnippShrbGgxuNBCuAQUIk4eD962XqZRVyABBlGPU
         N24Go1sClrlEd/4UGQ9BbLn3PSb1MNO4wZzg3/xw8PMsBU8nGkbL4ovXReFdK/mFzjcz
         QpBgPVdIT5bZW74G65bKQgA6UXd8xd3oQRpVaHfNymDhHyjhVn9xndcMDKOeY7ExEgzg
         LCccsgy0NTvs/ziRlvT54vHDo4W5cgkcC/8Gs7064OMB2kpFgDjQKuZUIhijR5ZLZk1C
         /7b/BqSZ2KzyFWox3cMFI6T8q6zWuYKWS7TWbBlqyi/ifm55BRN7jNEBu34yI0bO4oBq
         N/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LgG4jFCI3CPx+0ajvSWvk8LvyC8bwi+Jp9NJuOjUHsE=;
        b=GkTpdddpQ1ip2YycoFE9cholm05w5sPqqqH3Kek1pi2r6BCul4DsOxE4BI8yQV7fQe
         Xf0bO6MP0Bpazh1Tux07wgHsNdoVcD+pHiVnobnUb0jc7gK6aH9V4pCVIYN9gsrkvJXT
         4TqVsX4gf45x5FYT3koye3aVu6vINxDPd2ejJJZyALDOifC+F0mCo0XEgFj0TDEt5ogo
         6uJFHzwh/CEjilGiHLa3sIMazChSsQ5pmOHYuqqYjBYJfZfWd9uAUJ0yyXLbwXuXiV5x
         lvPYLupCVlSmDU2AwqD/kLR+63xdzGGRw664YwW+qy/OROP87OKHjH0dIDzEPEWd2TTQ
         NAoA==
X-Gm-Message-State: AIVw1131Mxn1qeOZc8kM0Gs92D68xFScA8rpvsIqwZ2zOFAmWNZz5i8R
        6RvmYFQHviJCz3HfPz5/Lw==
X-Received: by 10.99.37.131 with SMTP id l125mr20712453pgl.251.1501018784842;
        Tue, 25 Jul 2017 14:39:44 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m186sm27068839pfc.54.2017.07.25.14.39.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 14:39:43 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 03/15] add, reset: ensure submodules can be added or reset
Date:   Tue, 25 Jul 2017 14:39:16 -0700
Message-Id: <20170725213928.125998-4-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432dff-goog
In-Reply-To: <20170725213928.125998-1-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
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
2.14.0.rc0.400.g1c36432dff-goog

