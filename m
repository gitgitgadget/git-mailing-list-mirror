Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6C9C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 23:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhLPXdj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 18:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhLPXdg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 18:33:36 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5AEC061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 15:33:35 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id z13-20020a63e10d000000b0033b165097ccso320575pgh.6
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 15:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=u4r2CsDHt+EXXwg3D61/TuANN1pcL64biPpB0rWeto8=;
        b=rFLtHuMaNfpSOKJFVJTCyfdbb76T4+oshAEVKZUzRTey+Q/k/4te4tYgz68aK4wUf6
         G4IKUBvPw+0jrxJLvzu54xO5306oQ/RbbwKlPanvj781DZUXdBVVMIlnUVGjgqpLYxqI
         jV+6gL5eCScihsJ62odxd/DEane5mBKsD5Pr24VEYvILZb5Lv45dLxTCwaXbDzNFBWc3
         Mo+G4NSVqeDiiocMaSz0ni+u90jaraDuUvkCvjNbbnq40uuiaeUPgM+hJ3gFgRTucjh8
         4A1rP4ESSxgn8AjRcAlQK/rFpc0udd8vuGKl2I93sd2ANY3uK71jF54taKvqxDOdytm/
         Qg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u4r2CsDHt+EXXwg3D61/TuANN1pcL64biPpB0rWeto8=;
        b=Cnpsr3Qj0TfjAHOdqcwdAI9opGva3OrOW1u0gihgnotfa9lTlIjAQzc6X+f0SwQC8W
         ATQuQ6jqruIJpXMSLMrwkR2llKD7Bnq+qFIEU9zW43NjNRW/FATrhlR6bZav5lmIXDnI
         n1DXTPxx9FSjftyjm5iE0nTGC9B/8zKr8AUkB8uKzyyj9eCzHpzT0/3P6T2N5T6F21Qa
         +G/40y2NWyGoxi/FYiHkZuI8W+woKwoGVUD3UZWT6N8OTv1/qu4dcPlfi+JApCCup3IH
         IR6P/uOtTeAKPcLYeGVqcn4e/QVAWFVqL0LPj6bU1J2JMoxbEqLK4BpYSmS2ycBSa/eo
         750w==
X-Gm-Message-State: AOAM53284/NIeeao5pMVL+rWMPN8KC1bcH6y23TEoKDtNt/E2Btk1MfG
        c8ww9NrDMYaQBWbMnY/yyKjGNNvTzZKQhyx+HLg1rPpStA9YQndXFASlyjQQFB9Vb9225lZjMv5
        kmC3gwaoZb2c29Ssax9bW+hAIF58Dz7CU9p92bi6eJ1avkBWY3EuBfzi93rqzRnA=
X-Google-Smtp-Source: ABdhPJybWVqZeNVtakwNknRPV6oGk6tYQkrA3vMa6DD9lilNtfXWHpsIDgeqMZ1lzBxBw1QRJjj5Hg7edSkYlw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:ba95:: with SMTP id
 t21mr491439pjr.113.1639697615044; Thu, 16 Dec 2021 15:33:35 -0800 (PST)
Date:   Thu, 16 Dec 2021 15:33:23 -0800
In-Reply-To: <20211216233324.65126-1-chooglen@google.com>
Message-Id: <20211216233324.65126-5-chooglen@google.com>
Mime-Version: 1.0
References: <20211216003213.99135-1-chooglen@google.com> <20211216233324.65126-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v5 4/5] builtin/branch: clean up action-picking logic in cmd_branch()
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
index d785ebdba0..6c0069bf00 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -621,14 +621,15 @@ static int edit_branch_description(const char *branch_name)
 
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
@@ -713,8 +714,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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
@@ -854,7 +857,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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

