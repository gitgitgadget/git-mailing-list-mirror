Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B72C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 18:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhLISxh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 13:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhLISxg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 13:53:36 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA10EC061A32
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 10:50:02 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id n22-20020a6563d6000000b0029261ffde9bso3688218pgv.22
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 10:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=s77Sk63FkyMGDOdpbDwa6E11AC4W+xYYzmEtXBSi5rU=;
        b=DyA91FiLkiZChPUDm8iZt7zBk1VACOxij94/NdIuj95SZPcZcYlC34eFEJEMiA00QH
         c3NcfN2U79WNQ+286WNV598BBJb0eroD4SURHMjhzXSzLusCzD04WsEsJ3AvULdzKKHP
         7/XEwh43kcTKAcy3pCvOFLpDhZc6mmMPpaRHBFrSRfEOwRhR9w1MqanLy7qao5yoJF7F
         LDbyDGI8UkrSLYSNLutg0Xlt0dEJxJ2vsiCIWb1NcFvw/yRqMlEt8g0Zp3Ej07wdm+Xl
         gJ4mKfmf21z3E6ey+ZzYRO5LHiwKuXhuuH+X+gQnpSS7/2AahntoJXlEQBPPpanOTJlQ
         pC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s77Sk63FkyMGDOdpbDwa6E11AC4W+xYYzmEtXBSi5rU=;
        b=qILPx2jddy9Au3m1UZhe0n9hItDDnl4NSmx6KGe2aomnLuQ9MaOc3IuCvdPvxjZBe+
         DZu77uW+S1Hx2WRZsxFBDOsHIhwokvgZFZlwS2zUD+w1A+MmnCkzeYYqkUWPAKF+X4Do
         r4s8TkKmQbpKXSKezcX1QisPd5v9FVo7ORfhnGYdI1VdbJIk3EHoRKG6xEc4UXE7+v0r
         nlbRBkbZ06q6oJ9MR36olCJgTr0muaylJUv4/BwKBCTM/RmS8cvtTjSpxRChKgCjzAVs
         G/Muqzb9TIs04ZoHc/K5oabJFnNw7mrKEfhaPzl5s1EIuxiStahr/npsIy/Qjw4ZdgFK
         JnDw==
X-Gm-Message-State: AOAM5335nBi2gqkc+B39rPuGSKR4e1C51yjqZjkQCZ1pXz6i9jXhx2Vl
        C6or6eZmzLHiMkBiODO1QpweqH/RoS9ix7IKvG0mFFlckEP9NrMQv3gmwYtAiwNOrXdmtZL/Ste
        v/WibuhxH8Xnk8BrnIfoZhoYmcYVDoRsdx1ceJ3s37gk2HwMJU3SpjFFZUf9jnd0=
X-Google-Smtp-Source: ABdhPJyPistYGjDScFqbWCUk5JNr1SAPhFcl4dMxqq8tfRZWJD7hqXv85FIP5/HUdwMH5h9+ZYYmwEcG8v6vPQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:495b:: with SMTP id
 y27mr36191664pgk.601.1639075802322; Thu, 09 Dec 2021 10:50:02 -0800 (PST)
Date:   Thu,  9 Dec 2021 10:49:26 -0800
In-Reply-To: <20211209184928.71413-1-chooglen@google.com>
Message-Id: <20211209184928.71413-4-chooglen@google.com>
Mime-Version: 1.0
References: <20211206215528.97050-1-chooglen@google.com> <20211209184928.71413-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v3 3/5] builtin/branch: clean up action-picking logic in cmd_branch()
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

Add a variable to cmd_branch() that will tell us whether or not
cmd_branch() will default to creating a branch (instead of performing
another action). Besides making the function more explicit, this allows
us to validate options that can only be used when creating a branch.
Such an option does not exist yet, but one will be introduced in a
subsequent commit.

Incidentally, fix an incorrect usage string that combined the 'list'
usage of git branch (-l) with the 'create' usage; this string has been
incorrect since its inception, a8dfd5eac4 (Make builtin-branch.c use
parse_options., 2007-10-07).

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/branch.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index e19aab5356..14aff33a50 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -27,7 +27,7 @@
 
 static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged]"),
-	N_("git branch [<options>] [-l] [-f] <branch-name> [<start-point>]"),
+	N_("git branch [<options>] [-l] [<pattern>...]"),
 	N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
 	N_("git branch [<options>] (-m | -M) [<old-branch>] <new-branch>"),
 	N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
@@ -616,14 +616,15 @@ static int edit_branch_description(const char *branch_name)
 
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
-	int delete = 0, rename = 0, copy = 0, force = 0, list = 0;
-	int show_current = 0;
-	int reflog = 0, edit_description = 0;
-	int quiet = 0, unset_upstream = 0;
+	/* possible actions */
+	int delete = 0, rename = 0, copy = 0, force = 0, list = 0,
+	    unset_upstream = 0, show_current = 0, edit_description = 0;
+	int noncreate_actions = 0;
+	/* possible options */
+	int reflog = 0, quiet = 0, icase = 0;
 	const char *new_upstream = NULL;
 	enum branch_track track;
 	struct ref_filter filter;
-	int icase = 0;
 	static struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
 	struct ref_format format = REF_FORMAT_INIT;
@@ -708,8 +709,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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
@@ -847,7 +850,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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

