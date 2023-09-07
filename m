Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF618EC873E
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 17:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbjIGRD0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 13:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238892AbjIGRDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 13:03:25 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0666B1FE0
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 10:03:03 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-594e1154756so12627907b3.2
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 10:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694106103; x=1694710903; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OKLv30un2pK2mQbL9G5n/lxUxS6XWbhhFgrtZ9Gg2oE=;
        b=YPUxDhpnb5nfGMCJx3gk7zupHN023v0krv33Q5RRjJYaW/8g35fDI3POer4lqOogHO
         tkRAokwRaG2KEEZFQJrdBV1ugEO8NMsxMUdBe+iL1oe0gnHwu+6ZHPqaft9qVunJzozn
         Dwuz+Xf8OdKT8y1uAwjHP9iloIOH2JC/eZy1Nbp/BzE8gdsYQmnmo9pEMWBfnCSD0Qfp
         87nA2YUXsCXkl7mRVmKJUdqf0ipbPqCYFXj2wYVWPx90E2Be47fF/Sj9i+RFcBiwr/EU
         ShX9UlD6nX9HAcYh4gB0sk2MwjnvCjRmeAJWZQ4FGS87Lnitmhc1EEkjkyZbmlUZ4xOZ
         aC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694106103; x=1694710903;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OKLv30un2pK2mQbL9G5n/lxUxS6XWbhhFgrtZ9Gg2oE=;
        b=Ak0CWTzflxNJk2t8YRfCCwig71+Hs/nP4chw8I86lXk+vy64PQk1SWASu9AuyfXVRN
         7i6Db1gX6dKv1Lps+O/pD+YMavHD+uoiJ9bEkeiPaUYB2lPmG3geZ2Y+3O3m3l13fFWZ
         9yX0zMkIjzcwDVOGeGqYgCFb7wzYMNiRKMhgktQhaHdf31sxJ9nTsR0VOp6JolYWHmmY
         Us6tayeTX6iQk53NGMONujBfthPppFS5wavcMEYwJiBRxidMJuIXmqCcuTzFj//Op9j4
         MCXfTwah1nUWGs8bBWhBC/3Q95sLt4a2UzHkv1Gts4goHRkYxackv44lHLjTT2xTa9i4
         l2qQ==
X-Gm-Message-State: AOJu0YxW5Xjt4SgpZmxJ4kkV6xv1p32DLTCC3bZGEILSAztPgOJE3LnR
        W7febQQQ1aAn4uNFQHA/YFWZEPkQgZkWzw==
X-Google-Smtp-Source: AGHT+IHxABwxxc5NtZr4GN82Jzz/zwWYYc/C1M1LKSIQDe2luPd5odRFqIa1N/sF351l9fqI7rr4CpdBcbOCQw==
X-Received: from sokac.sfo.corp.google.com ([2620:15c:11a:202:f965:6de7:6287:6eb3])
 (user=sokcevic job=sendgmr) by 2002:a81:450c:0:b0:592:7bd8:7346 with SMTP id
 s12-20020a81450c000000b005927bd87346mr4763ywa.4.1694106103208; Thu, 07 Sep
 2023 10:01:43 -0700 (PDT)
Date:   Thu,  7 Sep 2023 10:01:19 -0700
In-Reply-To: <20230906203726.1526272-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20230906203726.1526272-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230907170119.1536694-1-sokcevic@google.com>
Subject: [PATCH v2] diff-lib: Fix check_removed when fsmonitor is on
From:   Josip Sokcevic <sokcevic@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, git@jeffhostetler.com,
        Josip Sokcevic <sokcevic@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-diff-index may return incorrect deleted entries when fsmonitor is used in a
repository with git submodules. This can be observed on Mac machines, but it
can affect all other supported platforms too.

If fsmonitor is used, `stat *st` may not be initialized. Since `lstat` calls
aren't not desired when fsmonitor is on, skip the entire gitlink check using
the same condition used to initialize `stat *st`.

Signed-off-by: Josip Sokcevic <sokcevic@google.com>
---
 diff-lib.c                   | 19 +++++++++++++++----
 t/t7527-builtin-fsmonitor.sh |  5 +++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index d8aa777a73..664613bb1b 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -39,11 +39,22 @@
 static int check_removed(const struct index_state *istate, const struct cache_entry *ce, struct stat *st)
 {
 	assert(is_fsmonitor_refreshed(istate));
-	if (!(ce->ce_flags & CE_FSMONITOR_VALID) && lstat(ce->name, st) < 0) {
-		if (!is_missing_file_error(errno))
-			return -1;
-		return 1;
+	if (ce->ce_flags & CE_FSMONITOR_VALID) {
+		/*
+		 * Both check_removed() and its callers expect lstat() to have
+		 * happened and, in particular, the st_mode field to be set.
+		 * Simulate this with the contents of ce.
+		 */
+		memset(st, 0, sizeof(*st));
+		st->st_mode = ce->ce_mode;
+	} else {
+		if (lstat(ce->name, st) < 0) {
+			if (!is_missing_file_error(errno))
+				return -1;
+			return 1;
+		}
 	}
+
 	if (has_symlink_leading_path(ce->name, ce_namelen(ce)))
 		return 1;
 	if (S_ISDIR(st->st_mode)) {
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


