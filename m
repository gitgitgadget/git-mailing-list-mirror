Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB689C43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbiGMNK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbiGMNKt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:10:49 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EB4AE40
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:10:47 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id ay25so6492737wmb.1
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Hs+AZhfuVmwR939hq1q/v6gnBmzWfGPqsH5xKaQm3w=;
        b=h37BkOonlVWFnJ/yRtRlOzcujs3A6wJae0OUE7LkkZYEn9rj1ivJoIO1a4NBTTogD2
         wLUZRWx0z02RiOYlLO+vooiIaE9scS7d6Ovl4FcHHxQj/fudbVpNCTMgkO9aI6gd9VeI
         vYAEaYxuZpEusaMSrGBxu5TJPCsMF1BBJnsF80ds9EvWACEEozCgI7H34INYSzFApZcf
         0Phedu4ioRVgET9hfjVECJe5aRaYAdxbM4f9mBTxVniNRer2F97MwmZDnj6lzgVcYzL4
         5NcASr04dESenUXXvrAPtDN5GCkhlNt+o77SuM9+aCbKUS6kxw7pNcyfUq+dzOTq5ynF
         DLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Hs+AZhfuVmwR939hq1q/v6gnBmzWfGPqsH5xKaQm3w=;
        b=IKzxRTIvlPVi4HFww3EkDQjoc/HB4i53xRT0iC9JacghJgxd06vVJdpFl2LEN2uHhU
         fgsYfjF981R1jvQNi8359wz0XpjWx8NApSslnHcJbIuPo9ZRSr2pjr4/Jg0flJJCU7cL
         gDVxxqBQsHEhQDOVLZnzGAByEQb4zYpdd32wUgKPxy1arFEUlJcFKA+6m8RYzUufUQE1
         vjiVwPen7sajTpsIhrp9QRo3BpIUZ7zF5Dr6cX+dB08P77Xre2rOMgbU1B2oidmTBvhV
         87n1JnlAcpd8kBvF8zOt5rqW2l9JCgsgh6oURdgqxX/khN3j495fwt9OQ+J8XQknMwiu
         BaVw==
X-Gm-Message-State: AJIora9WrS4lxhjq+kn+8lx6fZmqW13YZyC6zpC5c1A1QARujdsAmGS3
        nzpuPaiBOEIvl7sPDD1amzo1fx3BszIF6w==
X-Google-Smtp-Source: AGRyM1uuA73fwLeelSPt2reWip+XfXYdJoosohuVumkGcj5OJcHo1g9mx7AW+4UiQZB+EmicLwX9OQ==
X-Received: by 2002:a05:600c:211:b0:3a2:e982:1c12 with SMTP id 17-20020a05600c021100b003a2e9821c12mr9735712wmi.18.1657717846260;
        Wed, 13 Jul 2022 06:10:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d15-20020a05600c34cf00b0039c4d022a44sm2183653wmq.1.2022.07.13.06.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:10:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/6] bisect.c: partially fix bisect_rev_setup() memory leak
Date:   Wed, 13 Jul 2022 15:10:34 +0200
Message-Id: <patch-5.6-83897fd108a-20220713T130511Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.932.g7b7031e73bc
In-Reply-To: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Partially fix the memory leak noted in in 8a534b61241 (bisect: use
argv_array API, 2011-09-13), which added the "XXX" comment seen in the
context. We can partially fix it by having the bisect_rev_setup()
function take a "struct strvec", rather than constructing it.

As the comment notes we need to keep the construct "rev_argv" around
while the "struct rev_info" is around, which as seen in the newly
added "strvec_clear()" calls here we do after "release_revisions()".

This "partially" fixes the memory leak because we're leaking the "--"
added to the "rev_argv" here still, which will be addressed in a
subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 bisect.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/bisect.c b/bisect.c
index 421470bfa59..6afb98be7a1 100644
--- a/bisect.c
+++ b/bisect.c
@@ -648,11 +648,11 @@ static struct commit_list *managed_skipped(struct commit_list *list,
 }
 
 static void bisect_rev_setup(struct repository *r, struct rev_info *revs,
+			     struct strvec *rev_argv,
 			     const char *prefix,
 			     const char *bad_format, const char *good_format,
 			     int read_paths)
 {
-	struct strvec rev_argv = STRVEC_INIT;
 	int i;
 
 	repo_init_revisions(r, revs, prefix);
@@ -660,16 +660,16 @@ static void bisect_rev_setup(struct repository *r, struct rev_info *revs,
 	revs->commit_format = CMIT_FMT_UNSPECIFIED;
 
 	/* rev_argv.argv[0] will be ignored by setup_revisions */
-	strvec_push(&rev_argv, "bisect_rev_setup");
-	strvec_pushf(&rev_argv, bad_format, oid_to_hex(current_bad_oid));
+	strvec_push(rev_argv, "bisect_rev_setup");
+	strvec_pushf(rev_argv, bad_format, oid_to_hex(current_bad_oid));
 	for (i = 0; i < good_revs.nr; i++)
-		strvec_pushf(&rev_argv, good_format,
+		strvec_pushf(rev_argv, good_format,
 			     oid_to_hex(good_revs.oid + i));
-	strvec_push(&rev_argv, "--");
+	strvec_push(rev_argv, "--");
 	if (read_paths)
-		read_bisect_paths(&rev_argv);
+		read_bisect_paths(rev_argv);
 
-	setup_revisions(rev_argv.nr, rev_argv.v, revs, NULL);
+	setup_revisions(rev_argv->nr, rev_argv->v, revs, NULL);
 	/* XXX leak rev_argv, as "revs" may still be pointing to it */
 }
 
@@ -873,10 +873,11 @@ static enum bisect_error check_merge_bases(int rev_nr, struct commit **rev, int
 static int check_ancestors(struct repository *r, int rev_nr,
 			   struct commit **rev, const char *prefix)
 {
+	struct strvec rev_argv = STRVEC_INIT;
 	struct rev_info revs;
 	int res;
 
-	bisect_rev_setup(r, &revs, prefix, "^%s", "%s", 0);
+	bisect_rev_setup(r, &revs, &rev_argv, prefix, "^%s", "%s", 0);
 
 	bisect_common(&revs);
 	res = (revs.commits != NULL);
@@ -885,6 +886,7 @@ static int check_ancestors(struct repository *r, int rev_nr,
 	clear_commit_marks_many(rev_nr, rev, ALL_REV_FLAGS);
 
 	release_revisions(&revs);
+	strvec_clear(&rev_argv);
 	return res;
 }
 
@@ -1010,6 +1012,7 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
  */
 enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 {
+	struct strvec rev_argv = STRVEC_INIT;
 	struct rev_info revs = REV_INFO_INIT;
 	struct commit_list *tried;
 	int reaches = 0, all = 0, nr, steps;
@@ -1037,7 +1040,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 	if (res)
 		goto cleanup;
 
-	bisect_rev_setup(r, &revs, prefix, "%s", "^%s", 1);
+	bisect_rev_setup(r, &revs, &rev_argv, prefix, "%s", "^%s", 1);
 
 	revs.first_parent_only = !!(bisect_flags & FIND_BISECTION_FIRST_PARENT_ONLY);
 	revs.limited = 1;
@@ -1112,6 +1115,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 	res = bisect_checkout(bisect_rev, no_checkout);
 cleanup:
 	release_revisions(&revs);
+	strvec_clear(&rev_argv);
 	return res;
 }
 
-- 
2.37.0.932.g7b7031e73bc

