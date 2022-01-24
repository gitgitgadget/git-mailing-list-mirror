Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90939C433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 22:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1588572AbiAXWdU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 17:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355477AbiAXWRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 17:17:16 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD4CC04A2CB
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 12:45:08 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z15-20020a25bb0f000000b00613388c7d99so37286062ybg.8
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 12:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VCvjaeO8S8pcqyqAs+39F769/rd44ldNSRBvHy/41q8=;
        b=i3ylm38IbKpnBn//krMlXAXFBtbZz4iYLErSwtcE9vqFxcstWp1odq0sdCTGndbgE0
         cWpCQtjjxj0scUStpZU/vGGg37G/TWGtS6pUhsgIbdX9IvcsiLwuXFRpiuQfTlM1UR7f
         Lb5PkTsOsPmjIarBugaNzEppY+T6p1y9pv5vhMkPo3/VLlB6NvmT7G+lgpoK1baDLh3W
         GO8Rl1B5oqQmmaAZ9jYYlRf1grHQf/09IICdbYsoqmvXVvsKJjK98tJNv6FHo8npfCwM
         wduQD994IHmLfEfmiNmbaaxtFoDbAWdi6zMRT8i8cCEC4GZ772D24KR5hIkqx06bbjGo
         Ea9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VCvjaeO8S8pcqyqAs+39F769/rd44ldNSRBvHy/41q8=;
        b=R85lRZV89/s8Kgq9XYQOtcVuzdnNEpICTkz3ODl5rOgAC3xCRJkD65noK8BpOd2XXI
         j7mJ445Xhoar9HIPHZjZ2jbf8IBz3vK0JGkTftUnjugsRIEG8zR0ukrmNjYUP46w6h8t
         NvfdmIiujwhqjOMhJeRo/K+WIBanK4YjhOqhA87WiawOcLXUgNXoMBiyciuMkRPYuIFw
         nDkJw1gp55NPbV/+G11QLEGncIT7vhVIre61sfJroWqXPlyzXMcFpQGOAsMKSsQxL+GS
         ulq2ttkx+c73c9VPqLbOY55uO0OltelVCVBraumbkmCyKDDxDsp3g5lzPP0NPYh2pnKw
         xJ9w==
X-Gm-Message-State: AOAM5334hFziacjKKIlbNqcV/RWCjD1kesfRWSj//f0JZwSSMU5ysJzw
        VyaeD/xde2CrY2xrN1n8MJEmft2BLGIWeXezRVwovTP1SSaVbQouXGIOIRaUXuFhlOHG7G3C7A9
        ei75tS85GnC3hjT+xOcPVxizYS4vE+2tpYLoS7Nqlj2A+n6vT8U6FHonyKL6S3rY=
X-Google-Smtp-Source: ABdhPJy0rNp1pnN8gfookJdGFvqtsFu2KAxxlGNWO1RXOZOtQhv0LO/9RVz+hUgVMqP8UqL/nEq30wFlqxvmiA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:d0c:: with SMTP id
 12mr12070391ybn.249.1643057107696; Mon, 24 Jan 2022 12:45:07 -0800 (PST)
Date:   Mon, 24 Jan 2022 12:44:40 -0800
In-Reply-To: <20220124204442.39353-1-chooglen@google.com>
Message-Id: <20220124204442.39353-5-chooglen@google.com>
Mime-Version: 1.0
References: <20211220233459.45739-1-chooglen@google.com> <20220124204442.39353-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v7 4/6] builtin/branch: consolidate action-picking logic in cmd_branch()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Consolidate the logic for deciding when to create a new branch in
cmd_branch(), and save the result for reuse. Besides making the function
more explicit, this allows us to validate options that can only be used
when creating a branch. Such an option does not exist yet, but one will
be introduced in a subsequent commit.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/branch.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index d1e3ad6ebf..c274fbdfcf 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -616,14 +616,15 @@ static int edit_branch_description(const char *branch_name)
 
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
-	int delete = 0, rename = 0, copy = 0, force = 0, list = 0;
-	int show_current = 0;
-	int reflog = 0, edit_description = 0;
-	int quiet = 0, unset_upstream = 0;
+	/* possible actions */
+	int delete = 0, rename = 0, copy = 0, list = 0,
+	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	const char *new_upstream = NULL;
+	int noncreate_actions = 0;
+	/* possible options */
+	int reflog = 0, quiet = 0, icase = 0, force = 0;
 	enum branch_track track;
 	struct ref_filter filter;
-	int icase = 0;
 	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
 	struct ref_format format = REF_FORMAT_INIT;
 
@@ -707,8 +708,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	    filter.reachable_from || filter.unreachable_from || filter.points_at.nr)
 		list = 1;
 
-	if (!!delete + !!rename + !!copy + !!new_upstream + !!show_current +
-	    list + edit_description + unset_upstream > 1)
+	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
+			    !!show_current + !!list + !!edit_description +
+			    !!unset_upstream;
+	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
 	if (filter.abbrev == -1)
@@ -848,7 +851,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&buf, "branch.%s.merge", branch->name);
 		git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
 		strbuf_release(&buf);
-	} else if (argc > 0 && argc <= 2) {
+	} else if (!noncreate_actions && argc > 0 && argc <= 2) {
 		if (filter.kind != FILTER_REFS_BRANCHES)
 			die(_("The -a, and -r, options to 'git branch' do not take a branch name.\n"
 				  "Did you mean to use: -a|-r --list <pattern>?"));
-- 
2.33.GIT

