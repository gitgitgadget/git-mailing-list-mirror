Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 451091F45D
	for <e@80x24.org>; Mon, 12 Aug 2019 21:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfHLVft (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 17:35:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43277 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfHLVft (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 17:35:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id r26so14184014pgl.10
        for <git@vger.kernel.org>; Mon, 12 Aug 2019 14:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=VZUYV/i5MDB2BlqlDRklOlvJSpHqmadA1DcnDDhQVM4=;
        b=NwKWhQ4K6qFQVIRtEotlzO0SPtnw1apTVHDF84FmePWnUQ5lRO/g0wVv0s7BzD4ked
         PDtj73P6iQtDoaYKpyvQq1lt/EEJJS6EOunjFsJSpXkNa2S1BoOaqAH0N+Ilb1jvQn/l
         GIixxvOGLfClEDla1PXcn+m7vrLLc16lhVgSD8r33vQO2LZSamWIqOtvGyvEiqUw7oq1
         ENvFRAPubLvGZ4IdR7BgmOHn4vLjmILyYggC2mep0z4FfPTTiTjdK9ETR+kz2rxkUP89
         /hifWR0CgUYjqo56IFfVYqG82PSVe0NhRwzCVvsGCvf7tWXEXxuScNl+uGfX7DobUgGu
         AdyA==
X-Gm-Message-State: APjAAAV9fOIMgAulTFYqwSW1SeqtU/8IzAre+d+3cpCthc77AY5PuOZx
        HLvHI2T2dtmjbfXvvREt/eElJQ==
X-Google-Smtp-Source: APXvYqxg1D65Gb53UEOd0hzVxAxlmzpzxa2dLX4q5t9x+PDrxQyTzrxgM5o+QpVjc6PHM4vBrUXJvw==
X-Received: by 2002:a65:60cd:: with SMTP id r13mr11426093pgv.315.1565645747942;
        Mon, 12 Aug 2019 14:35:47 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id p8sm4650961pfq.129.2019.08.12.14.35.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 14:35:47 -0700 (PDT)
Subject: [PATCH v2 5/5] fetch: Make --jobs control submodules and remotes
Date:   Mon, 12 Aug 2019 14:34:48 -0700
Message-Id: <20190812213448.2649-6-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190812213448.2649-1-palmer@sifive.com>
References: <20190812213448.2649-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     peff@peff.net, e@80x24.org, chriscool@tuxfamily.org,
        gitster@pobox.com, jonathantanmy@google.com, tboegi@web.de,
        bwilliams.eng@gmail.com, jeffhost@microsoft.com,
        Palmer Dabbelt <palmer@sifive.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The existing --jobs argument was defined to control the number of jobs
used for submodule fetching, but it makes more sense to have this
argument control the number of jobs to be used when fetching from
multiple remotes as well.

This patch simply changes the --jobs argument parsing code to set both
max_children_for_{submodules,fetch}, as well as noting this new behavior
in the documentation.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 Documentation/fetch-options.txt |  4 ++++
 builtin/fetch.c                 | 21 ++++++++++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 5836024f1934..0915fd4ed6d5 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -160,6 +160,10 @@ ifndef::git-pull[]
 
 -j::
 --jobs=<n>::
+	Number of parallel children to be used for all forms of fetching.
+	This is the same as passing `--submodule-fetch-jobs=<n>` and
+	`--fetch-jobs=<n>`.
+
 --submodule-fetch-jobs=<n>::
 	Number of parallel children to be used for fetching submodules.
 	Each will fetch from different submodules, such that fetching many
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 67d001f3f78b..41498e9efb3b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -114,6 +114,20 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
 	return git_default_config(k, v, cb);
 }
 
+static int parse_jobs_arg(const struct option *opt, const char *arg, int unset)
+{
+	int jobs;
+
+	jobs = atoi(arg);
+	if (jobs < 1)
+		die(_("There must be a positive number of jobs"));
+
+	max_children_for_submodules = jobs;
+	max_children_for_fetch = jobs;
+
+	return 0;
+}
+
 static int parse_refmap_arg(const struct option *opt, const char *arg, int unset)
 {
 	BUG_ON_OPT_NEG(unset);
@@ -142,12 +156,13 @@ static struct option builtin_fetch_options[] = {
 		    N_("fetch all tags and associated objects"), TAGS_SET),
 	OPT_SET_INT('n', NULL, &tags,
 		    N_("do not fetch all tags (--no-tags)"), TAGS_UNSET),
-	OPT_INTEGER('j', "jobs", &max_children_for_submodules,
+	{ OPTION_CALLBACK, 'j', "jobs", NULL, N_("jobs"),
+		    N_("number of parallel tasks to run while fetching"),
+		    PARSE_OPT_OPTARG, &parse_jobs_arg },
+	OPT_INTEGER(0, "submodule-fetch-jobs", &max_children_for_submodules,
 		    N_("number of submodules fetched in parallel")),
 	OPT_INTEGER(0, "fetch-jobs", &max_children_for_fetch,
 		    N_("number of remotes fetched in parallel")),
-	OPT_INTEGER(0, "submodule-fetch-jobs", &max_children_for_submodules,
-		    N_("number of submodules fetched in parallel")),
 	OPT_BOOL('p', "prune", &prune,
 		 N_("prune remote-tracking branches no longer on remote")),
 	OPT_BOOL('P', "prune-tags", &prune_tags,
-- 
2.21.0

