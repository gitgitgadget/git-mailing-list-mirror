Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDA8C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 13:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245531AbhLVN4e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 08:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245526AbhLVN4e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 08:56:34 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C80C06173F
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 05:56:33 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q16so5099489wrg.7
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 05:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=TztSMEWbMPU/99E6+8rI6qWEdRnxF936gB3fFF671zI=;
        b=dPVWpTXXIfot8emQG2T6Iok+ULeVvetBnB2mpRF1W0Rxph6v6JFPOANkwaZpGf7Jv5
         yuVpGI9id8FqpxsZBjky/1tAKVXfDA1Drn44tt0GQogm7XTjx2uyK7HWqQQzhlVKguhs
         IMUWaVzLFm07Bdw3/czr7cHxSoKXb7RC3SI60ZI/+QYQRPZ/7jYvM13eErBvpR2j6W+l
         nnDCgEEaHGV8zzCz2bIR72i9qJHpOxtv9HKzLxUuppcNQTKZYB0C4zHjAHn3w2aRg89Y
         8WsPYJak4Vy5XdqNveO22EmTnBdLW4syOFUBHas4+RZcf2Ksfk9r+M/cK6iiuIBPQh2e
         UGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TztSMEWbMPU/99E6+8rI6qWEdRnxF936gB3fFF671zI=;
        b=tePR9nEn1WHX9eTLmV8cwdFsGXi4n5kALSy3k8gFBu0isUUN7qax0HKUR/FlqG2Ipj
         TbmIyLuPtGiC72ojbm3ZPrnK/XhV/3oHLEL6CCphFx+FXdAYtaniBYgsXtWPj56kZNUW
         H2CZA36CcBxli1/WECUJrx8O9Z8XsywpAGlIa8BnsI/1HWD2zciVBDHHsWtJb1c8Z6Kf
         nD1YQBaUn89PnCLETL8zmc2GpmW/Zn8Iy96rMhFUNR4qgVjC+hr6DcafAbkLX+dfo0DP
         cSp8Va1yuD3w7xW/tKgxLbyNagOI4df6q2ZuyFHxD2ECPQOqGP7DzTJTbaYiZ08uX8Dp
         1F5A==
X-Gm-Message-State: AOAM532h3iI5sjwlDhBa9iPLMIDTxxDp6q2FxxpaxpC70KpjIWLFBiHR
        pi6yvB2z0KcMeVklg6OSIitNhA+4A00=
X-Google-Smtp-Source: ABdhPJxCahLcFLZo16wfRPek+TRqmNtNp12pj5BJeX9tZsxS1OBkExXJu4YPkPee5cQgijRSnqf2pg==
X-Received: by 2002:a5d:59a9:: with SMTP id p9mr2341348wrr.251.1640181392218;
        Wed, 22 Dec 2021 05:56:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3sm1743480wmr.15.2021.12.22.05.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 05:56:31 -0800 (PST)
Message-Id: <pull.1105.git.1640181390841.gitgitgadget@gmail.com>
From:   "Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 13:56:30 +0000
Subject: [PATCH] update-index: refresh should rewrite index in case of racy
 timestamps
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Marc Strapetz <marc.strapetz@syntevo.com>

update-index --refresh and --really-refresh should force writing of the
index file if racy timestamps have been encountered, as status already
does [1].

Note that calling update-index still does not guarantee that there will
be no more racy timestamps afterwards (the same holds true for status):

- calling update-index immediately after touching and adding a file may
  still leave racy timestamps if all three operations occur within the
  racy-tolerance (usually 1 second unless USE_NSEC has been defined)

- calling update-index for timestamps which are set into the future
  will leave them racy

To guarantee that such racy timestamps will be resolved would require to
wait until the system clock has passed beyond these timestamps and only
then write the index file. Especially for future timestamps, this does
not seem feasible because of possibly long delays/hangs.

Both --refresh and --really-refresh may in theory be used in
combination with --unresolve and --again which may reset the
"active_cache_changed" flag. There is no difference of whether we
write the index due to racy timestamps or due to other
reasons, like if --really-refresh has detected CE_ENTRY_CHANGED in
refresh_cache(). Hence, we will set the "active_cache_changed" flag
immediately after calling refresh_cache().

[1] https://lore.kernel.org/git/d3dd805c-7c1d-30a9-6574-a7bfcb7fc013@syntevo.com/

Signed-off-by: Marc Strapetz <marc.strapetz@syntevo.com>
---
    update-index: refresh should rewrite index in case of racy timestamps
    
    This patch makes update-index --refresh write the index if it contains
    racy timestamps, as discussed at [1].
    
    [1]
    https://lore.kernel.org/git/d3dd805c-7c1d-30a9-6574-a7bfcb7fc013@syntevo.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1105%2Fmstrap%2Ffeature%2Fupdate-index-refresh-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1105/mstrap/feature/update-index-refresh-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1105

 builtin/update-index.c               |  6 +++
 cache.h                              |  1 +
 read-cache.c                         |  2 +-
 t/t2108-update-index-refresh-racy.sh | 58 ++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100755 t/t2108-update-index-refresh-racy.sh

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 187203e8bb5..0a069281e23 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -787,6 +787,12 @@ static int refresh(struct refresh_params *o, unsigned int flag)
 	setup_work_tree();
 	read_cache();
 	*o->has_errors |= refresh_cache(o->flags | flag);
+	if (has_racy_timestamp(&the_index)) {
+		/* For racy timestamps we should set active_cache_changed immediately:
+		 * other callbacks may follow for which some of them may reset
+		 * active_cache_changed. */
+		active_cache_changed |= SOMETHING_CHANGED;
+	}
 	return 0;
 }
 
diff --git a/cache.h b/cache.h
index cfba463aa97..dd1932e2d0e 100644
--- a/cache.h
+++ b/cache.h
@@ -891,6 +891,7 @@ void *read_blob_data_from_index(struct index_state *, const char *, unsigned lon
 #define CE_MATCH_IGNORE_FSMONITOR 0X20
 int is_racy_timestamp(const struct index_state *istate,
 		      const struct cache_entry *ce);
+int has_racy_timestamp(struct index_state *istate);
 int ie_match_stat(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
 int ie_modified(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
 
diff --git a/read-cache.c b/read-cache.c
index cbe73f14e5e..ed297635a33 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2775,7 +2775,7 @@ static int repo_verify_index(struct repository *repo)
 	return verify_index_from(repo->index, repo->index_file);
 }
 
-static int has_racy_timestamp(struct index_state *istate)
+int has_racy_timestamp(struct index_state *istate)
 {
 	int entries = istate->cache_nr;
 	int i;
diff --git a/t/t2108-update-index-refresh-racy.sh b/t/t2108-update-index-refresh-racy.sh
new file mode 100755
index 00000000000..ece1151847c
--- /dev/null
+++ b/t/t2108-update-index-refresh-racy.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+
+test_description='update-index refresh tests related to racy timestamps'
+
+. ./test-lib.sh
+
+reset_mtime() {
+	test-tool chmtime =$(test-tool chmtime --get .git/fs-tstamp) $1
+}
+
+update_assert_unchanged() {
+	local ts1=$(test-tool chmtime --get .git/index) &&
+	git update-index $1 &&
+	local ts2=$(test-tool chmtime --get .git/index) &&
+	[ $ts1 -eq $ts2 ]
+}
+
+update_assert_changed() {
+	local ts1=$(test-tool chmtime --get .git/index) &&
+	test_might_fail git update-index $1 &&
+	local ts2=$(test-tool chmtime --get .git/index) &&
+	[ $ts1 -ne $ts2 ]
+}
+
+test_expect_success 'setup' '
+	touch .git/fs-tstamp &&
+	test-tool chmtime -1 .git/fs-tstamp &&
+	echo content >file &&
+	reset_mtime file &&
+
+	git add file &&
+	git commit -m "initial import"
+'
+
+test_expect_success '--refresh has no racy timestamps to fix' '
+	reset_mtime .git/index &&
+	test-tool chmtime +1 .git/index &&
+	update_assert_unchanged --refresh
+'
+
+test_expect_success '--refresh should fix racy timestamp' '
+	reset_mtime .git/index &&
+	update_assert_changed --refresh
+'
+
+test_expect_success '--really-refresh should fix racy timestamp' '
+	reset_mtime .git/index &&
+	update_assert_changed --really-refresh
+'
+
+test_expect_success '--refresh should fix racy timestamp even if needs update' '
+	echo content2 >file &&
+	reset_mtime file &&
+	reset_mtime .git/index &&
+	update_assert_changed --refresh
+'
+
+test_done

base-commit: 597af311a2899bfd6640b9b107622c5795d5f998
-- 
gitgitgadget
