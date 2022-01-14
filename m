Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3ACC433EF
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 16:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243100AbiANQAB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 11:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238936AbiANP7y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 10:59:54 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0942C061746
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 07:59:50 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id s1so16357605wra.6
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 07:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8tktbsfgdwLJuLd8ONiKhRO06je4eOmcmCGWb6d79ds=;
        b=RkO7zDFeX6gtwXNojD/0Dh77J6claq26zNUbJ9ALJdtapxb7wWaIvjNLvM77oXPUbF
         4obMojd0SIcs14nhGZLfyzbuR8y67i4Coqg8gnoVtV/OWxLL9N72lhFYnl5nEUJpSYK5
         trFLJ4FaUuqkf1Y9B9g/4XBp+FkBqCtxlM1JRwbLp2JpG18nVOGUKj773xo5benrDxhd
         GLvjB54w1HUMWEF15NDcia+DmVTFgKxFe+gd1GDF3esr9nE2PhWqcL4q/0qz/4Sqoyf0
         V0EQRn2u7XxkaY0PHYzSZKB2bhX7hXpjAzeBQeZqZ4EHgCsOCYKqDFUr37fCJfMoYWbe
         ohFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8tktbsfgdwLJuLd8ONiKhRO06je4eOmcmCGWb6d79ds=;
        b=xXI3cfBKYRcZZELTncWGY+UPcL1rzV53+uhsLED+LMGy+Apl2N3RU105L1WyGWSQJR
         ISstgi9csjSeCyAM/0Z5TH+LKrvBgAeJ/bkrd+Bk/skKMQYK0yW2KqjVeRVUC7dmVFw6
         gqAv62mvNYHVdtuO8w4QjeU9hZdu0ikvDvw/1AP5txT30R1wPoiFd39lIEfmXgXrSfLf
         ydxsOnaSOLuYLdE2/Q5e4JyJdYI3/UJyFdnUbtnaGGKDDkT+BlFvuETToD1TF3b+Jz9v
         qQqoaX3FOmltrAwtBJbX/iTkNV9AzIW4NB6IEOLTRLiwaoTJrFtD+G9fDNdO5qGXT1Te
         NxiQ==
X-Gm-Message-State: AOAM530CkJmuGPQHIhQbMC/43cTxcyWeD6Eex9E+Cc9chiDtXLfJzae3
        SO7R0KlVIEDkr14nfkUVXz0fnminzKg=
X-Google-Smtp-Source: ABdhPJx/BUw0ALDZ6jbchOHddMri4VstU8ASfHBr4aPT5uTXmk/L/gc3IF0Kjipbhg+BaLn/d1p45g==
X-Received: by 2002:a05:6000:188f:: with SMTP id a15mr8966199wri.153.1642175989190;
        Fri, 14 Jan 2022 07:59:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i10sm6908019wmq.45.2022.01.14.07.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:59:48 -0800 (PST)
Message-Id: <05ac964e630a2e72eebaa1818a8807cd7a7d4f7e.1642175983.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com>
References: <pull.1114.git.1642092230.gitgitgadget@gmail.com>
        <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Jan 2022 15:59:43 +0000
Subject: [PATCH v2 5/5] Accelerate clear_skip_worktree_from_present_files() by
 caching
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Trying to clear the skip-worktree bit from files that are present does
present some computational overhead, for sparse-checkouts.  (We do not
do the bit clearing in non-sparse-checkouts.)  Optimize it as follows:

Rather than lstat()'ing every SKIP_WORKTREE path, take advantage of the
fact that entire directories will often be missing, especially for cone
mode and even more so ever since commit 55dfcf9591 ("sparse-checkout:
clear tracked sparse dirs", 2021-09-08).  If we have already determined
that the parent directory of a file (or other previous ancestor) does
not exist, then the file cannot exist either so we do not need to
lstat() it separately.

Timings for p2000 included below, reformatted to fit in normal commit
message line lengths, which compare three things:
  * Timings before this series
  * Timings of the unoptimized version of
    clear_skip_worktree_from_present_files() from a few commits ago
  * Timings after the optimization in this commit

(NOTE: t/perf/ appears to have timing resolution only down to 0.01 s,
which presents significant measurement error when timings only differ by
0.01s.  I don't trust any such timings below, and yet all the optimized
results differ by at most 0.01s.)

Test        Before Series    Unoptimized              Optimized
-----------------------------------------------------------------------------
*git status*
full-v3     0.15(0.10+0.06)  0.32(0.16+0.17) +113.3%  0.16(0.10+0.07) +6.7%
full-v4     0.15(0.11+0.05)  0.32(0.17+0.16) +113.3%  0.16(0.11+0.05) +6.7%
sparse-v3   0.04(0.03+0.04)  0.04(0.02+0.05) +0.0%    0.04(0.02+0.05) +0.0%
sparse-v4   0.04(0.03+0.04)  0.04(0.02+0.05) +0.0%    0.04(0.03+0.05) +0.0%

*git add -A*
full-v3     0.40(0.30+0.07)  0.56(0.36+0.17) +40.0%   0.39(0.30+0.07) -2.5%
full-v4     0.37(0.28+0.07)  0.54(0.37+0.16) +45.9%   0.38(0.29+0.07) +2.7%
sparse-v3   0.06(0.04+0.05)  0.08(0.05+0.05) +33.3%   0.06(0.05+0.04) +0.0%
sparse-v4   0.05(0.03+0.05)  0.05(0.04+0.04) +0.0%    0.06(0.04+0.05) +20.0%

*git add .*
full-v3     0.40(0.31+0.07)  0.57(0.37+0.17) +42.5%   0.41(0.30+0.08) +2.5%
full-v4     0.38(0.30+0.06)  0.55(0.37+0.16) +44.7%   0.38(0.30+0.06) +0.0%
sparse-v3   0.06(0.04+0.05)  0.06(0.05+0.04) +0.0%    0.06(0.03+0.05) +0.0%
sparse-v4   0.06(0.05+0.05)  0.06(0.04+0.05) +0.0%    0.06(0.04+0.06) +0.0%

*git commit -a -m A*
full-v3     0.41(0.32+0.06)  0.58(0.39+0.17) +41.5%   0.42(0.32+0.07) +2.4%
full-v4     0.39(0.30+0.07)  0.56(0.38+0.17) +43.6%   0.40(0.31+0.07) +2.6%
sparse-v3   0.04(0.03+0.04)  0.04(0.03+0.04) +0.0%    0.04(0.03+0.04) +0.0%
sparse-v4   0.04(0.03+0.05)  0.04(0.03+0.05) +0.0%    0.04(0.03+0.04) +0.0%

*git checkout -f -*
full-v3     0.56(0.46+0.07)  0.73(0.55+0.16) +30.4%   0.57(0.47+0.08) +1.8%
full-v4     0.54(0.45+0.07)  0.71(0.53+0.17) +31.5%   0.55(0.45+0.07) +1.9%
sparse-v3   0.06(0.04+0.04)  0.06(0.04+0.05) +0.0%    0.06(0.04+0.05) +0.0%
sparse-v4   0.05(0.05+0.04)  0.05(0.04+0.05) +0.0%    0.06(0.04+0.05) +20.0%

*git reset*
full-v3     0.34(0.26+0.05)  0.51(0.34+0.15) +50.0%   0.34(0.26+0.06) +0.0%
full-v4     0.32(0.24+0.06)  0.49(0.32+0.15) +53.1%   0.33(0.25+0.06) +3.1%
sparse-v3   0.04(0.03+0.04)  0.04(0.03+0.04) +0.0%    0.04(0.03+0.04) +0.0%
sparse-v4   0.03(0.03+0.04)  0.03(0.02+0.04) +0.0%    0.03(0.03+0.04) +0.0%

*git reset --hard*
full-v3     0.57(0.46+0.07)  0.90(0.61+0.25) +57.9%   0.57(0.45+0.08) +0.0%
full-v4     0.54(0.46+0.05)  0.88(0.59+0.26) +63.0%   0.55(0.45+0.07) +1.9%
sparse-v3   0.07(0.03+0.03)  0.07(0.04+0.03) +0.0%    0.07(0.03+0.03) +0.0%
sparse-v4   0.06(0.03+0.03)  0.06(0.04+0.02) +0.0%    0.06(0.03+0.03) +0.0%

*git reset -- does-not-exist*
full-v3     0.35(0.27+0.06)  0.52(0.32+0.17) +48.6%   0.35(0.27+0.06) +0.0%
full-v4     0.33(0.26+0.05)  0.50(0.33+0.15) +51.5%   0.33(0.26+0.06) +0.0%
sparse-v3   0.04(0.03+0.04)  0.04(0.03+0.04) +0.0%    0.04(0.03+0.04) +0.0%
sparse-v4   0.04(0.02+0.04)  0.03(0.02+0.04) -25.0%   0.03(0.02+0.04) -25.0%

*git diff*
full-v3     0.07(0.04+0.04)  0.24(0.11+0.14) +242.9%  0.07(0.04+0.04) +0.0%
full-v4     0.07(0.03+0.05)  0.24(0.13+0.12) +242.9%  0.08(0.04+0.05) +14.3%
sparse-v3   0.02(0.01+0.04)  0.02(0.01+0.04) +0.0%    0.02(0.01+0.05) +0.0%
sparse-v4   0.02(0.02+0.03)  0.02(0.01+0.04) +0.0%    0.02(0.01+0.04) +0.0%

*git diff --cached*
full-v3     0.05(0.03+0.02)  0.22(0.12+0.09) +340.0%  0.05(0.03+0.01) +0.0%
full-v4     0.05(0.03+0.01)  0.23(0.12+0.11) +360.0%  0.05(0.03+0.02) +0.0%
sparse-v3   0.01(0.00+0.00)  0.01(0.00+0.00) +0.0%    0.01(0.00+0.00) +0.0%
sparse-v4   0.01(0.00+0.00)  0.01(0.00+0.00) +0.0%    0.01(0.00+0.00) +0.0%

*git blame f2/f4/a*
full-v3     0.18(0.13+0.05)  0.52(0.29+0.23) +188.9%  0.19(0.15+0.04) +5.6%
full-v4     0.19(0.15+0.04)  0.52(0.28+0.23) +173.7%  0.19(0.14+0.04) +0.0%
sparse-v3   0.10(0.08+0.02)  0.10(0.09+0.01) +0.0%    0.10(0.09+0.01) +0.0%
sparse-v4   0.10(0.08+0.02)  0.10(0.08+0.02) +0.0%    0.10(0.08+0.02) +0.0%

*git blame f2/f4/f3/a*
full-v3     0.45(0.36+0.08)  0.78(0.51+0.27) +73.3%   0.45(0.37+0.08) +0.0%
full-v4     0.45(0.37+0.08)  0.78(0.51+0.26) +73.3%   0.45(0.37+0.08) +0.0%
sparse-v3   0.36(0.32+0.04)  0.36(0.31+0.05) +0.0%    0.36(0.31+0.04) +0.0%
sparse-v4   0.36(0.31+0.05)  0.36(0.31+0.05) +0.0%    0.36(0.31+0.04) +0.0%

*git checkout-index -f --all*
full-v3     0.07(0.02+0.05)  0.24(0.12+0.12) +242.9%  0.08(0.04+0.04) +14.3%
full-v4     0.07(0.03+0.04)  0.24(0.11+0.13) +242.9%  0.08(0.03+0.04) +14.3%
sparse-v3   0.04(0.01+0.03)  0.04(0.00+0.03) +0.0%    0.04(0.01+0.03) +0.0%
sparse-v4   0.04(0.01+0.02)  0.04(0.01+0.03) +0.0%    0.04(0.01+0.02) +0.0%

*git update-index --add --remove f2/f4/a*
full-v3     0.29(0.23+0.02)  0.46(0.30+0.12) +58.6%   0.30(0.24+0.02) +3.4%
full-v4     0.27(0.22+0.02)  0.45(0.29+0.12) +66.7%   0.28(0.22+0.03) +3.7%
sparse-v3   0.02(0.02+0.00)  0.02(0.01+0.00) +0.0%    0.02(0.01+0.00) +0.0%
sparse-v4   0.02(0.02+0.00)  0.02(0.02+0.00) +0.0%    0.02(0.02+0.00) +0.0%

So, with the optimization, the extra work appears to be essentially 0
for sparse-checkouts that are also using sparse-indexes (even before my
optimization), and the extra work appears to be just marginally more
than 0 for sparse-checkouts that are using full indexes.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 sparse-index.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index b82648b10ee..eed170cd8f7 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -341,18 +341,70 @@ void ensure_correct_sparsity(struct index_state *istate)
 		ensure_full_index(istate);
 }
 
+static int path_found(const char *path, const char **dirname, size_t *dir_len,
+		      int *dir_found)
+{
+	struct stat st;
+	char *newdir;
+	char *tmp;
+
+	/*
+	 * If dirname corresponds to a directory that doesn't exist, and this
+	 * path starts with dirname, then path can't exist.
+	 */
+	if (!*dir_found && !memcmp(path, *dirname, *dir_len))
+		return 0;
+
+	/*
+	 * If path itself exists, return 1.
+	 */
+	if (!lstat(path, &st))
+		return 1;
+
+	/*
+	 * Otherwise, path does not exist so we'll return 0...but we'll first
+	 * determine some info about its parent directory so we can avoid
+	 * lstat calls for future cache entries.
+	 */
+	newdir = strrchr(path, '/');
+	if (!newdir)
+		return 0; /* Didn't find a parent dir; just return 0 now. */
+
+	/*
+	 * If path starts with directory (which we already lstat'ed and found),
+	 * then no need to lstat parent directory again.
+	 */
+	if (*dir_found && *dirname && memcmp(path, *dirname, *dir_len))
+		return 0;
+
+	/* Free previous dirname, and cache path's dirname */
+	*dirname = path;
+	*dir_len = newdir - path + 1;
+
+	tmp = xstrndup(path, *dir_len);
+	*dir_found = !lstat(tmp, &st);
+	free(tmp);
+
+	return 0;
+}
+
 void clear_skip_worktree_from_present_files(struct index_state *istate)
 {
+	const char *last_dirname = NULL;
+	size_t dir_len = 0;
+	int dir_found = 1;
+
 	int i;
+
 	if (!core_apply_sparse_checkout)
 		return;
 
 restart:
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
-		struct stat st;
 
-		if (ce_skip_worktree(ce) && !lstat(ce->name, &st)) {
+		if (ce_skip_worktree(ce) &&
+		    path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
 			if (S_ISSPARSEDIR(ce->ce_mode)) {
 				ensure_full_index(istate);
 				goto restart;
-- 
gitgitgadget
