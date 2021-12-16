Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88393C433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 00:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbhLPAch (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 19:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbhLPAcg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 19:32:36 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73393C06175A
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 16:32:34 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id k21-20020a63f015000000b0033db7baf101so2406838pgh.19
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 16:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Jcr7b7U5owUgVF2fxw0unuqYaKDi7EB2CvpoPhyZzr0=;
        b=fbY+xtBN1Fuu5EY4nCnle0+bPlk04Z1Y7QKNSLWydml60+NaFU6GEku7hbzwhpTVox
         7hcs3fjZ9NfeSQ5U2bPOYqM56nXgtM9E8wb/oi6s6jJfcFihHfIg6asiXxd/p/011F0a
         fDcRR2672FZvV0VfsH/37yrc9jM4sDWW6IbtgBINQLnaOXaQfg8rarvPixs+MJueghq1
         RCTMmkoZjgJ7BtidPTmk08lSfM/8y+Ib9N2G5vEURgDv8J4/tmJGj9zQUeWcdcR4x8Hi
         lBsyvY3JVEyNSWdRb8sacEDWv/HOc9RLRFOKQJCICJNJoprMJd7LWfV9yacgNV3iCijr
         PyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Jcr7b7U5owUgVF2fxw0unuqYaKDi7EB2CvpoPhyZzr0=;
        b=dxuPF7g0+fYuVH0rQEv6DWpsMVVAq7ubAy4dwvff8U7tDaM6714fwGz08HqW68jd5/
         oIO3l5SZne58Rnlh8T0hho1VS5DPHHPkg3kby/1odDChEir3F8Gb98buww7KrNxs5WHc
         Iv8UnIPg5xpPnojrj5OkDozPPQlKFeFC3e32F5dlFYxDLPeGXT6NT0tDntmJaiCWrX5i
         lRaGH3wL2qSCdvQ0A1WbyX/EZLOOwyC/Ru+RW5OSj8h38hEHmbUi5tVXTAF2UM/W1/bg
         zEDGF5KNyScuPFiRpdFfACM/okNZoApLtVezEOWI+u7+K9+J8kCOqllToLILTzrELlkE
         lHHA==
X-Gm-Message-State: AOAM533PfTDkNpdgTctaXize+S908a5EZoeXHd9MLJMYiZb2Fx7UoQ77
        QYfBS/7cbeXQoDCVbELOSZVvS7Osyzo0/eSkeYNLaySPGzEJFWgKFUzVc0b/csSpsyjt5s3gxel
        kyB4rpGp5EgTIYl5in0N7M9Q1S8LQilp1XlVXPDJj3Mrgxwr9XEPyz1QrRIvDIK0=
X-Google-Smtp-Source: ABdhPJz/dfB2sVvO7O66u4lXLaYvw/jhmZBzhXq8q6E0Dcor4SPWiABe96Wun/asSFeOZw74DS0IGf0x8xl4tw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:38c9:: with SMTP id
 nn9mr2802484pjb.241.1639614753810; Wed, 15 Dec 2021 16:32:33 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:32:12 -0800
In-Reply-To: <20211216003213.99135-1-chooglen@google.com>
Message-Id: <20211216003213.99135-5-chooglen@google.com>
Mime-Version: 1.0
References: <20211209184928.71413-1-chooglen@google.com> <20211216003213.99135-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 4/5] builtin/branch: clean up action-picking logic in cmd_branch()
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

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/branch.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 9b300cf42f..3b010c1d2c 100644
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
@@ -849,7 +852,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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

