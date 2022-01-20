Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EBFC433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 07:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239830AbiATHrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 02:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239605AbiATHrT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 02:47:19 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53420C06173F
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 23:47:19 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id w26so10228888wmi.0
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 23:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=exCgLxTnvaWUJS4hKgk6QhhqB542JeIfreKN+YLFf5Y=;
        b=KEGgBUn8e409OU83of408SDyDqDETFUKjZvVhnW1m4AkxEZsDfkKVRujSVjbBCVrkT
         XTQKFZY3MY57J69l85q43hwXuROj15BAVn01ZyYRMBgl11TUQBCytTTdUFEwzLkJ7qFm
         7PogEQ/OEcUeyNRbzoH/PYn5Izby1ymj6HOAiPjMQ+M1ij9r33HVR2ldyXjhDBCukC0G
         h7CeLNpxOG7aIWKG1smEbyMaBJ82u2V8lTmXKr/qsvT9ymJ7vRv8AhzSxIZahptn5tmh
         tKj//Ca9pzO9+TKdyPvYxK6gvzDlKIEOXZyrvbdsO1yJgh3Xh4YFJuz6WLZj5d0UbukS
         08lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=exCgLxTnvaWUJS4hKgk6QhhqB542JeIfreKN+YLFf5Y=;
        b=WM2CRKqI+NXc1bFtnd3DVBWaFtLFAM/n1HKMdti1SAwVh9V/R2v5CXIKlBFgUWsEF5
         03ml1yXsyvtVnllxPeO31yMzPVabJL8YVQuz451U5zxG+xi0tFDrtbRDKcJXDMrvhC8O
         c8bN8P+Q0KuBmIRx0o98Ro/QxJDFGIy5izhYWhLZJhDLBn7A/WawdDnw4ypXqUx5z24r
         ofGzzdnnTRji75m/tahdD2EvtiQyYHgC+7XYJFrrerjB9CTmwFaJYiXqJt+5yrxAW3om
         g4/NFGnctSPI2xYdZ3dEMEzIViXoDDTJ05RIsp/6+kXLTIS+qX+uyFb9SXgOO0GN4YGK
         EMKg==
X-Gm-Message-State: AOAM530thb5YOufc7dMN4L+JPCX2Q0XlNnXGNR9xLJH6vJJmfhfVaN/u
        gIzqhpsplEyYBkawfO1DLwdmwhOp068=
X-Google-Smtp-Source: ABdhPJwDnOQr7OKx4yzRc/opkWJHxlRQEcPp87ESGJpgomoj9E5e7ZHCc5lPpX+JAGi9QdXGQLoT7A==
X-Received: by 2002:a5d:6d8b:: with SMTP id l11mr23035114wrs.234.1642664837706;
        Wed, 19 Jan 2022 23:47:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m11sm2644722wmi.16.2022.01.19.23.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 23:47:17 -0800 (PST)
Message-Id: <396325fac50365f2651b9447d227fc9ae025acef.1642664835.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1200.git.git.1642664835.gitgitgadget@gmail.com>
References: <pull.1200.git.git.1642664835.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Jan 2022 07:47:14 +0000
Subject: [PATCH 1/2] merge-ort: fix memory leak in merge_ort_internal()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The documentation for merge_incore_recursive(), modelled after
merge_recursive(), notes that

   merge_bases will be consumed (emptied) so make a copy if you need it

However, in merge_ort_internal() (which merge_incore_recursive() calls),
it runs

   merged_merge_bases = pop_commit(&merge_bases);
   ...
   for (iter = merge_bases; iter; iter = iter->next) {
      ...
   }

In other words, it only consumes the *first* entry of merge_bases, and
the rest it iterates through.  If it iterated through all of them, the
caller could be responsible for free'ing the memory.  If it consumed all
of them, the current documentation would be correct and the callers
would need to do nothing.  The current middle ground makes it impossible
for callers to avoid memory leaks, since any attempt to use the
merge_bases it passes in would result in a use-after-free.

It turns out this part of the code was copied from merge-recursive.c,
which has had the same bug for 15.5 years.  However, since we are trying
to keep merge-recursive.c stable as we sunset it, let's just fix the
leak in in merge_ort_internal() by having it actually consume all the
elements of the merge_bases commit_list.

Testing this commit against t6404 (the first testcase specifically
about recursive merges) under valgrind shows that this patch fixes
the following leak:

    32 (16 direct, 16 indirect) bytes in 1 blocks are definitely lost \
    in loss record 49 of 126
       at 0x484086F: malloc (vg_replace_malloc.c:380)
       by 0x69FFEB: do_xmalloc (wrapper.c:41)
       by 0x6A0073: xmalloc (wrapper.c:62)
       by 0x52A72D: commit_list_insert (commit.c:556)
       by 0x47EC86: try_merge_strategy (merge.c:751)
       by 0x48143B: cmd_merge (merge.c:1679)
       by 0x40686E: run_builtin (git.c:464)
       by 0x406C51: handle_builtin (git.c:716)
       by 0x406E96: run_argv (git.c:783)
       by 0x40730A: cmd_main (git.c:914)
       by 0x4E7DFA: main (common-main.c:56)

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index c3197970219..83a89f9f4c4 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4575,7 +4575,7 @@ static void merge_ort_internal(struct merge_options *opt,
 			       struct commit *h2,
 			       struct merge_result *result)
 {
-	struct commit_list *iter;
+	struct commit *next;
 	struct commit *merged_merge_bases;
 	const char *ancestor_name;
 	struct strbuf merge_base_abbrev = STRBUF_INIT;
@@ -4604,7 +4604,8 @@ static void merge_ort_internal(struct merge_options *opt,
 		ancestor_name = merge_base_abbrev.buf;
 	}
 
-	for (iter = merge_bases; iter; iter = iter->next) {
+	for (next = pop_commit(&merge_bases); next;
+	     next = pop_commit(&merge_bases)) {
 		const char *saved_b1, *saved_b2;
 		struct commit *prev = merged_merge_bases;
 
@@ -4621,7 +4622,7 @@ static void merge_ort_internal(struct merge_options *opt,
 		saved_b2 = opt->branch2;
 		opt->branch1 = "Temporary merge branch 1";
 		opt->branch2 = "Temporary merge branch 2";
-		merge_ort_internal(opt, NULL, prev, iter->item, result);
+		merge_ort_internal(opt, NULL, prev, next, result);
 		if (result->clean < 0)
 			return;
 		opt->branch1 = saved_b1;
@@ -4632,8 +4633,7 @@ static void merge_ort_internal(struct merge_options *opt,
 							 result->tree,
 							 "merged tree");
 		commit_list_insert(prev, &merged_merge_bases->parents);
-		commit_list_insert(iter->item,
-				   &merged_merge_bases->parents->next);
+		commit_list_insert(next, &merged_merge_bases->parents->next);
 
 		clear_or_reinit_internal_opts(opt->priv, 1);
 	}
-- 
gitgitgadget

