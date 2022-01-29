Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1767DC433F5
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 00:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351911AbiA2AFM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 19:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351895AbiA2AFG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 19:05:06 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BD2C06174E
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 16:05:06 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id e3-20020a170902ed8300b0014b46561c92so3879171plj.15
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 16:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PG59nimf3aFQsEvnm7FLd7MzFnAVYcxBzvqrsB/XZE0=;
        b=VgX3q4yIqIoy7XPYJVJioAbBYkpFZ5OprvMnUtDqY1mo00kcuwJltLRSWRfw3DCOO+
         /85IdO4R57z2wWq/lvwsDrUiD5MSAkZVyIl9xrnwr9w5zX4EUNEAX77xLYQNWBj1lLNG
         xXViJvv+ey/CPfD2aSxbuGjtaKVg4eyhzoUL29XxHwgMqcdQ15Yy4AJrkdaBsen2scpV
         YuItv9VXB6HdE7bQTpS6C8dbMal7YLJB1fxwrMrelob0G4oEbubjpITH7LAEexBjUbDK
         N4jodCpB92ZWu+JqsTjIM7sTUtRaG3ATcZLR4e4LIDgqveCOFFDl0oT+SVml65bQEs15
         7wDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PG59nimf3aFQsEvnm7FLd7MzFnAVYcxBzvqrsB/XZE0=;
        b=jP2g4jZ46kmes1ibNsq9GUpBoI3TagqkR+Ww2oL4lDjs7lZLZVyEluQFlZF8/lEKhh
         07Ym0quNVa6zeRJHYxEfCZsUmEbL1L4q9FpueC+3z3nT8qXc5YnN2gMfzxvQZ4JUGaMn
         QbYGw4ZeeCeoWfT5umdBZwijBRHCsDX+pjtZq+Qg7UgNZPP2sw1A73wBJMoydHrazyC5
         yd/V+IZL1/hHUIhY257DsnFWNPfpJRvSP3bNKDop/XQL0onC7qzXVsQBZlaX8PLWqgM6
         H1LjylUCJyRZR5HogJudGc/FBJ970IygbKZ+oeDQKIK/T3VIohGJtrDblX8d7n/vtvnK
         NgcQ==
X-Gm-Message-State: AOAM5310lTSM1cCoORVKOPpzxk2lgrpXwoC3aoiQ3uOvFnMvCNxr6uM7
        vZE5d795unETurUKvdR+T66p9lR2inTvQpFw7usHhkC01MJiL4PfLltmsrEF5MmmD8T2ZQG5byI
        B78NnDUX1Dgl193hm9jqzsVoVSZEs1Y79rjtKOtKhwWTJxBLHvvFdEYGsmFigGYk=
X-Google-Smtp-Source: ABdhPJweILclKEZL9XCXOGrHs0YybYlC6x8kJzhpEmL2ymb0ljmVKaH9HoTydXy6/0TnXTHSCLYN2LgLkJii2Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:7024:: with SMTP id
 f33mr22205255pjk.15.1643414705473; Fri, 28 Jan 2022 16:05:05 -0800 (PST)
Date:   Fri, 28 Jan 2022 16:04:44 -0800
In-Reply-To: <20220129000446.99261-1-chooglen@google.com>
Message-Id: <20220129000446.99261-5-chooglen@google.com>
Mime-Version: 1.0
References: <20220124204442.39353-1-chooglen@google.com> <20220129000446.99261-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH v8 4/6] builtin/branch: consolidate action-picking logic in cmd_branch()
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
index c6fffb99ab..b352cc789a 100644
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

