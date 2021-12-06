Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09CDC433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 21:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356170AbhLFV7f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 16:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356167AbhLFV7d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 16:59:33 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC842C0611F7
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 13:56:03 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id x23-20020a634a17000000b003252e908ce3so7531221pga.1
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 13:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8Mv205hX3bZInwwGLo3RwOE9vMXaKZ9huvqITM/bX98=;
        b=MBitEye3kzBqwMX8kqQXlNPYSvZ8HiIsRTn9KiaBca46ki9f0gAFK9c6YZFwn2bmL3
         zOOrjW/4kzKUmAeOuy4xqEU/I0U6+8KuR0/BCmv7n4JIIS/OzOeTqta1xhi/NxHvPfBM
         LdTTBDyOCACaiN6Arnc+SA53fvWMeS1O6DXTpxX82ZlGBvT/t4uyrOgGbmw2fP8mfHv4
         02dppcDP3BeWWFFFIUjhBmWPiSxDYHoMlXUcZwrBH/kmLb8aShXioNjAeEsK1Ga0bV1A
         UaGrnQvUG/xdzi84q6VasXoFW8wrrG3cCkwGuZ9ORVn2klmhEXd0MyPkQvYw07lzIXQ8
         qtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8Mv205hX3bZInwwGLo3RwOE9vMXaKZ9huvqITM/bX98=;
        b=QMFAUo4Mjohz3LqCgHslSZI4dKUeXKhyocxyT1xZerlgrOMFZzG4xHanY7pnyoOYxz
         ZCRKLqDP0vNJQ2RHB5L8VT4qzOCttveMujuMk8BCY0D7uVnVwfBXHQFyv1qS+LYj2uDc
         gSWUBta0R/qRRIWq1QllDktDdZxg0tX/mwiWRiwFaKVXliDVeM9sCOqh/HLBa6lxIFJa
         EoB+G4e0eB3YgOLavK+F0iNk3lWCagYkHvvJe5oFD6bRUM2wRMP0PSt95GOWPT2LFfcv
         rtUnNy3kld8MsUSXYAPWRSYfO2FDsLY5srfH5IyByXC22u6x+RRkEZOfRJSdMMjUmQ9T
         fbVA==
X-Gm-Message-State: AOAM530B/3xxOuj7g1KgMvOoRGXwIql9gW9bJ7LxrkSX58gk1zBYwjKV
        lnBfEHnE+4oDMslUv7SD5c2KP5Y/JStlZVEkDR9LSk75dCBrTE2BdUPOLK+rCei7/GVb4a27MeX
        LmNtkaI7azna3n/qFxuaM7tqS3nTjno3nLXu0nXiMoFlkqW5iWmtHWO8n3hqogmQ=
X-Google-Smtp-Source: ABdhPJwaMVyFsEO6FTwqog4dRhym1WoOZYajIIbaitXn11MtZyEQBvuMLmclRNuii2g0byyJPYpouIW3oYcezA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:8348:: with SMTP id
 h69mr21502852pge.490.1638827763177; Mon, 06 Dec 2021 13:56:03 -0800 (PST)
Date:   Mon,  6 Dec 2021 13:55:27 -0800
In-Reply-To: <20211206215528.97050-1-chooglen@google.com>
Message-Id: <20211206215528.97050-3-chooglen@google.com>
Mime-Version: 1.0
References: <20211122223252.19922-1-chooglen@google.com> <20211206215528.97050-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v2 2/3] builtin/branch: clean up action-picking logic in cmd_branch()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a variable, noncreate_actions, to cmd_branch() that will tell us
whether or not cmd_branch() will default to creating a branch (instead
of performing another action). Besides making the function more
explicit, this allows us to validate options that can only be used when
creating a branch. Such an option does not exist yet, but one will be
introduced in a subsequent commit.

Incidentally, fix an incorrect usage string that combined the 'list'
usage of git branch (-l) with the 'create' usage; this string has been
incorrect since its inception, a8dfd5eac4 (Make builtin-branch.c use
parse_options., 2007-10-07).

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/branch.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 19f2845e7a..83b8016b38 100644
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
@@ -706,8 +707,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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
@@ -845,7 +848,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
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

