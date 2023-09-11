Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DEFCA0EC5
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349514AbjIKVds (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243403AbjIKRJi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 13:09:38 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8879E121
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 10:09:33 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58cb845f2f2so50741247b3.1
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 10:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694452172; x=1695056972; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+wDNADLbqw4KgmqDaM3g8ypcVjxZf/JDZtiNRKg4YJE=;
        b=LHoqBXDEfMp64wat3yE2/eUq4i3up+CPerEPA3F9W61d+E5v8fArii3chSxurskyzm
         aTx0E4Ocr8t+wFBmSlZ5I9/zhxo4PDviFl2LNFt22j3cWRv/w2FTNGmk0hem0xy9j4A7
         p0m+QACaS/obAiOAOE5g+fzdtkSVI6xm58ZVcHJ9sjH2WMvmbjzKNUoNpmmxbXw8+9n6
         WsSVEQXZy8Y2wgikOkJDZ7FiIxLqlyrIo07vBlb3KyiLiQu1J7vEkaCdu8l1zRgfJ6Ui
         u1EetjrCL0xKyQzXTKW6gJpylX85tG/Y+QHOfdY+yfOJnxBYFEK+BPltjdxCsXiIFMYs
         UctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694452172; x=1695056972;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+wDNADLbqw4KgmqDaM3g8ypcVjxZf/JDZtiNRKg4YJE=;
        b=jTkJRW4xn9ZtVruMmij6DcisqY6qC3QPeoGVybYpYraUvB+OhkYuHVmzndEab3KVRA
         zmeeINcIKQzJLHqkr5v0Ze+ml4/5ECqeraMudCxaFUsdC98L+ZBQU9rY1Q+CfhbsoERJ
         otrXcbLY8h2is1A0+TTt0XwqO49P7/WQdMpv/E26SlM2T0hy7C0i0ochrP3O9dJLVk2j
         4IdBC8qt1jb01eHo7Rrdj2B6TINEWDJU6vOG2wpGuSttZzgUGsQDSL57eQtlNhwlfyTh
         pQTS99hs1dMBbzAHq+ke5cYtGyYBRC4aIivMmohJ0d5BLWnQnJQOgS2ea3BvT9d+O0Q+
         H9Ow==
X-Gm-Message-State: AOJu0YyY3xRsuwF5eF3KLg0v7tDmMYa6K7O4ce1RKPWK2UslRKpcIw9x
        mdlsc/btg+I/upKPWYBD5nf7h+IDflPSwg==
X-Google-Smtp-Source: AGHT+IFNVApISEhr6bIKhOhfyT+AUW2GZSkCVqNmikv6KkHuIJto4Qg+PpHX2G7fLV1xyn0Zk1e8hQjXeW9owA==
X-Received: from sokac.sfo.corp.google.com ([2620:15c:11a:202:f5b6:67c3:98ce:210])
 (user=sokcevic job=sendgmr) by 2002:a81:b50a:0:b0:58c:b5a4:8e1c with SMTP id
 t10-20020a81b50a000000b0058cb5a48e1cmr267650ywh.3.1694452172650; Mon, 11 Sep
 2023 10:09:32 -0700 (PDT)
Date:   Mon, 11 Sep 2023 10:09:02 -0700
In-Reply-To: <20230906060241.944886-2-sokcevic@google.com>
Mime-Version: 1.0
References: <20230906060241.944886-2-sokcevic@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230911170901.49050-2-sokcevic@google.com>
Subject: [PATCH v3] diff-lib: Fix check_removed when fsmonitor is on
From:   Josip Sokcevic <sokcevic@google.com>
To:     gitster@pobox.com, jonathantanmy@google.com
Cc:     git@vger.kernel.org, git@jeffhostetler.com,
        Josip Sokcevic <sokcevic@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-diff-index may return incorrect deleted entries when fsmonitor is used in a
repository with git submodules. This can be observed on Mac machines, but it
can affect all other supported platforms too.

If fsmonitor is used, `stat *st` is not initialized if cache_entry has
CE_FSMONITOR_VALID set. But, there are three call sites that rely on stat
afterwards, which can result in incorrect results.

This change partially reverts commit 4f3d6d0.

Signed-off-by: Josip Sokcevic <sokcevic@google.com>
---
 diff-lib.c                   | 12 ++++++------
 t/t7527-builtin-fsmonitor.sh |  5 +++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index d8aa777a73..5848e4f9ca 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -36,14 +36,14 @@
  * exists for ce that is a submodule -- it is a submodule that is not
  * checked out).  Return negative for an error.
  */
-static int check_removed(const struct index_state *istate, const struct cache_entry *ce, struct stat *st)
+static int check_removed(const struct cache_entry *ce, struct stat *st)
 {
-	assert(is_fsmonitor_refreshed(istate));
-	if (!(ce->ce_flags & CE_FSMONITOR_VALID) && lstat(ce->name, st) < 0) {
+	if (lstat(ce->name, st) < 0) {
 		if (!is_missing_file_error(errno))
 			return -1;
 		return 1;
 	}
+
 	if (has_symlink_leading_path(ce->name, ce_namelen(ce)))
 		return 1;
 	if (S_ISDIR(st->st_mode)) {
@@ -149,7 +149,7 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
 			memset(&(dpath->parent[0]), 0,
 			       sizeof(struct combine_diff_parent)*5);
 
-			changed = check_removed(istate, ce, &st);
+			changed = check_removed(ce, &st);
 			if (!changed)
 				wt_mode = ce_mode_from_stat(ce, st.st_mode);
 			else {
@@ -229,7 +229,7 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
 		} else {
 			struct stat st;
 
-			changed = check_removed(istate, ce, &st);
+			changed = check_removed(ce, &st);
 			if (changed) {
 				if (changed < 0) {
 					perror(ce->name);
@@ -303,7 +303,7 @@ static int get_stat_data(const struct index_state *istate,
 	if (!cached && !ce_uptodate(ce)) {
 		int changed;
 		struct stat st;
-		changed = check_removed(istate, ce, &st);
+		changed = check_removed(ce, &st);
 		if (changed < 0)
 			return -1;
 		else if (changed) {
diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 0c241d6c14..78503158fd 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -809,6 +809,11 @@ my_match_and_clean () {
 		status --porcelain=v2 >actual.without &&
 	test_cmp actual.with actual.without &&
 
+	git -C super --no-optional-locks diff-index --name-status HEAD >actual.with &&
+	git -C super --no-optional-locks -c core.fsmonitor=false \
+		diff-index --name-status HEAD >actual.without &&
+	test_cmp actual.with actual.without &&
+
 	git -C super/dir_1/dir_2/sub reset --hard &&
 	git -C super/dir_1/dir_2/sub clean -d -f
 }
-- 
2.42.0.283.g2d96d420d3-goog


