Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82402C433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 20:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351281AbiDOUmT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 16:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351342AbiDOUmR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 16:42:17 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4D12B1A2
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 13:39:46 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id g18so16995501ejc.10
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 13:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vmiklos-hu.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=p93smVSDeBofASqNfsE53Ozf7bY87egiaeoY3P43GqM=;
        b=74G1ds0UxBbDqfvfY32YKwdBBtmhh5LN84/Ppdb09cBxOAopt/Zfcds+cuKJqMvWYu
         PJTn63KitQEGlGCsS8IkjNzkmh7zNc7nHXbeMgFK8FwFhTDYwOOXUdjCI3JyQTZ4aQ0M
         IOZXA5Wsqp96Jbcq+mP2Tl2HDvan4xec1sAzvwSfNjP2DbFJ91WDD7bbbGMbHFuVxHHO
         I3UQT73fmELvaL3pTouI6rLYZmi607cdlYZQ0wmtT3PPYXGUujK9S3wpCezJOWkERj0A
         5shm657V6/AMJcMN8aG0H/ameAGxFdK5HZRxYtCO1wwN6CWnGjVEvz+Phy3fXRbvrQXB
         bG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=p93smVSDeBofASqNfsE53Ozf7bY87egiaeoY3P43GqM=;
        b=Lq81atm4vV1xhuxNUUZ2GwFJTtiC8tvG7YWe0EuI7teSRPWryhrEbEpRPh4i+08ftQ
         GGyW7gDaRUIz8pYmLR/FVhPR+Db3zqtolRY78n5eSaugb4A4hOC0c2Ipaj6cGtEkyZ8g
         1Ei0Jf1GljxFnYij17B3UkD1gUxDRyS7d0RYmct0TplV6pyWBmYzlg58VXot1bUMekPR
         i9m2ILIpxchYiq3xFPacpNCU+QksjZCSBCIcI9gYl8Tzh0BLQgvQPhapX5EAWzdoRKIz
         eBEIN81bcLGEzWh3HObjMenU+e771NtwNheC4dO4OepTZNNG0HbnQgz3FUPsCHA3hQCE
         YfVw==
X-Gm-Message-State: AOAM530kk3bxC+SRAA/qLsZ6xHD0YbbhVJSP7wwhqAS7ZJuOcOwLvSsB
        XvR9zUrGfXZexShsi9HLLTsuvQ==
X-Google-Smtp-Source: ABdhPJyPwMlFPUFH9Lb3Jt7GEfhwOaFukVc2jFFFK4SOp8NluV4tzEk84hMVhGu8QVLy6E1jvNG5cQ==
X-Received: by 2002:a17:906:301a:b0:6e8:a0b2:340a with SMTP id 26-20020a170906301a00b006e8a0b2340amr597600ejz.248.1650055184828;
        Fri, 15 Apr 2022 13:39:44 -0700 (PDT)
Received: from vmiklos.hu (94-21-185-252.pool.digikabel.hu. [94.21.185.252])
        by smtp.gmail.com with ESMTPSA id p9-20020a05640243c900b0041facb9ac9esm2952176edc.1.2022.04.15.13.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 13:39:44 -0700 (PDT)
Date:   Fri, 15 Apr 2022 22:39:42 +0200
From:   Miklos Vajna <vmiklos@vmiklos.hu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: [PATCH v4] git-log: add a --since=... --as-filter option
Message-ID: <YlnYDgZRzDI87b/z@vmiklos.hu>
References: <xmqqtub3moa0.fsf@gitster.g>
 <xmqqv8vkpara.fsf@gitster.g>
 <YlCiqgO6rL908Zsi@vmiklos.hu>
 <220412.86pmlmhe9a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220412.86pmlmhe9a.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is similar to --since, but it will filter out not matching commits,
rather than stopping at the first not matching commit.

This is useful if you e.g. want to list the commits from the last year,
but one odd commit has a bad commit date and that would hide lots of
earlier commits in that range.

The behavior of --since is left unchanged, since it's valid to depend on
its current behavior.

Signed-off-by: Miklos Vajna <vmiklos@vmiklos.hu>
---

Hi Ævar,

On Tue, Apr 12, 2022 at 10:47:15AM +0200, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> > +--as-filter::
> > +	When combined with `--since=<date>`, show all commits more recent than
> > +	a specific date. This visits all commits in the range, rather than stopping at
> > +	the first commit which is older than a specific date.
> 
> I wonder if we should be more future-proof here and say that we'll run
> anything as a filter, and that --since is the one option currently
> affected.
> 
> But maybe there's no reason to do so...

My understanding is that in practice --since is the only option that
terminates the revision walk on the first match, so I would argue there
is no need for this.

> In any case these docs are inaccurate because they cover --since, but if
> you check revision.c we'll set "max_age" on other options too
> (synonyms?).

Good catch, I've added --max-age and --after as well.

> All in all I wonder if this wouldn't be much more understandable if we
> advertised is as another option to do "HISTORY SIMPLIFICATION", which
> looking at e.g. get_commit_action() and "prune" is kind of what we're
> doing with the existing --since behavior.

Makes sense, we kind of simplify history by default here & then this
option could be documented as one that modifies this terminating
behavior.

> I think it's good to do this as a general mechanism, but if you now
> remove the "max_age" field from "struct rev_info" and:
> 
> 	make -k
> 
> You'll see a bunch of callers who check "max_age" outside of revision.c,
> since those will accept these revision options are they doing the right
> thing now too?

I found the following callers:

- some builtins that want to make sure that no history limiting is used,
  an additional --as-filter doesn't change behavior there

- blame: this has its own commit walking loop, so --as-filter doesn't
  change any behavior here unintentionally.

- bundle: --since is not used for revision walking here, just to check
  what tags to include/exclude, so this is already not terminating

> In any case we should have tests for those callers, i.e. blame, bundle
> etc.

t/t5607-clone-bundle.sh already tests bundle --since. I've added a new
t/t4218-blame-limit.sh to test blame --since, it seems there were no
tests for this so far.

Thanks,

Miklos

 Documentation/rev-list-options.txt |  6 +++++
 revision.c                         | 13 +++++++++--
 revision.h                         |  1 +
 t/t4217-log-limit.sh               | 36 ++++++++++++++++++++++++++++++
 t/t4218-blame-limit.sh             | 36 ++++++++++++++++++++++++++++++
 5 files changed, 90 insertions(+), 2 deletions(-)
 create mode 100755 t/t4217-log-limit.sh
 create mode 100755 t/t4218-blame-limit.sh

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index fd4f4e26c9..354bd29f10 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -350,6 +350,12 @@ The following options select the commits to be shown:
 <paths>::
 	Commits modifying the given <paths> are selected.
 
+--as-filter::
+	When combined with `--max-age=<date>`, `--since=<date>` or
+	`--after=<date>`, show all commits more recent than a specific date. This
+	visits all commits in the range, rather than stopping at the first commit
+	which is older than a specific date.
+
 --simplify-by-decoration::
 	Commits that are referred by some branch or tag are selected.
 
diff --git a/revision.c b/revision.c
index 7d435f8048..ff018c3976 100644
--- a/revision.c
+++ b/revision.c
@@ -1440,6 +1440,9 @@ static int limit_list(struct rev_info *revs)
 		if (revs->min_age != -1 && (commit->date > revs->min_age) &&
 		    !revs->line_level_traverse)
 			continue;
+		if (revs->max_age != -1 && revs->as_filter && (commit->date < revs->max_age) &&
+		    !revs->line_level_traverse)
+			continue;
 		date = commit->date;
 		p = &commit_list_insert(commit, p)->next;
 
@@ -1838,6 +1841,7 @@ void repo_init_revisions(struct repository *r,
 	revs->dense = 1;
 	revs->prefix = prefix;
 	revs->max_age = -1;
+	revs->as_filter = 0;
 	revs->min_age = -1;
 	revs->skip_count = -1;
 	revs->max_count = -1;
@@ -2218,6 +2222,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if ((argcount = parse_long_opt("since", argv, &optarg))) {
 		revs->max_age = approxidate(optarg);
 		return argcount;
+	} else if (!strcmp(arg, "--as-filter")) {
+		revs->as_filter = 1;
 	} else if ((argcount = parse_long_opt("after", argv, &optarg))) {
 		revs->max_age = approxidate(optarg);
 		return argcount;
@@ -3365,7 +3371,7 @@ static void explore_walk_step(struct rev_info *revs)
 	if (revs->sort_order == REV_SORT_BY_AUTHOR_DATE)
 		record_author_date(&info->author_date, c);
 
-	if (revs->max_age != -1 && (c->date < revs->max_age))
+	if (revs->max_age != -1 && !revs->as_filter && (c->date < revs->max_age))
 		c->object.flags |= UNINTERESTING;
 
 	if (process_parents(revs, c, NULL, NULL) < 0)
@@ -3862,6 +3868,9 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
 	if (revs->min_age != -1 &&
 	    comparison_date(revs, commit) > revs->min_age)
 			return commit_ignore;
+	if (revs->max_age != -1 && revs->as_filter &&
+	    comparison_date(revs, commit) < revs->max_age)
+			return commit_ignore;
 	if (revs->min_parents || (revs->max_parents >= 0)) {
 		int n = commit_list_count(commit->parents);
 		if ((n < revs->min_parents) ||
@@ -4019,7 +4028,7 @@ static struct commit *get_revision_1(struct rev_info *revs)
 		 * that we'd otherwise have done in limit_list().
 		 */
 		if (!revs->limited) {
-			if (revs->max_age != -1 &&
+			if (revs->max_age != -1 && !revs->as_filter &&
 			    comparison_date(revs, commit) < revs->max_age)
 				continue;
 
diff --git a/revision.h b/revision.h
index 5bc59c7bfe..fe37ebd83d 100644
--- a/revision.h
+++ b/revision.h
@@ -263,6 +263,7 @@ struct rev_info {
 	int skip_count;
 	int max_count;
 	timestamp_t max_age;
+	int as_filter;
 	timestamp_t min_age;
 	int min_parents;
 	int max_parents;
diff --git a/t/t4217-log-limit.sh b/t/t4217-log-limit.sh
new file mode 100755
index 0000000000..2a3705c714
--- /dev/null
+++ b/t/t4217-log-limit.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+test_description='git log with filter options limiting the output'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+GIT_TEST_COMMIT_GRAPH=0
+GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
+
+test_expect_success 'setup test' '
+	git init &&
+	echo a > file &&
+	git add file &&
+	GIT_COMMITTER_DATE="2021-02-01 0:00" git commit -m init &&
+	echo a >> file &&
+	git add file &&
+	GIT_COMMITTER_DATE="2022-02-01 0:00" git commit -m first &&
+	echo a >> file &&
+	git add file &&
+	GIT_COMMITTER_DATE="2021-03-01 0:00" git commit -m second &&
+	echo a >> file &&
+	git add file &&
+	GIT_COMMITTER_DATE="2022-03-01 0:00" git commit -m third
+'
+
+test_expect_success 'git log --since=... --as-filter' '
+	git log --since="2022-01-01" --as-filter --pretty="format:%s" > actual &&
+	! test_i18ngrep init actual &&
+	test_i18ngrep first actual &&
+	! test_i18ngrep second actual &&
+	test_i18ngrep third actual
+'
+
+test_done
diff --git a/t/t4218-blame-limit.sh b/t/t4218-blame-limit.sh
new file mode 100755
index 0000000000..03f513f331
--- /dev/null
+++ b/t/t4218-blame-limit.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+test_description='git blame with filter options limiting the output'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+GIT_TEST_COMMIT_GRAPH=0
+GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
+
+test_expect_success 'setup test' '
+	git init &&
+	echo a > file &&
+	git add file &&
+	GIT_AUTHOR_DATE="2020-01-01 0:00" GIT_COMMITTER_DATE="2020-01-01 0:00" git commit -m init &&
+	echo a >> file &&
+	git add file &&
+	GIT_AUTHOR_DATE="2020-02-01 0:00" GIT_COMMITTER_DATE="2020-02-01 0:00" git commit -m first &&
+	echo a >> file &&
+	git add file &&
+	GIT_AUTHOR_DATE="2020-03-01 0:00" GIT_COMMITTER_DATE="2020-03-01 0:00" git commit -m second &&
+	echo a >> file &&
+	git add file &&
+	GIT_AUTHOR_DATE="2020-04-01 0:00" GIT_COMMITTER_DATE="2020-04-01 0:00" git commit -m third
+'
+
+test_expect_success 'git blame --since=...' '
+	git blame --since="2020-02-15" file > actual &&
+	! test_i18ngrep 2020-01-01 actual &&
+	test_i18ngrep 2020-02-01 actual &&
+	test_i18ngrep 2020-03-01 actual &&
+	test_i18ngrep 2020-04-01 actual
+'
+
+test_done
-- 
2.34.1

