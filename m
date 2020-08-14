Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C62C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 16:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3892120774
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 16:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgHNQZ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 12:25:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:59306 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgHNQZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 12:25:27 -0400
Received: (qmail 1160 invoked by uid 109); 14 Aug 2020 16:25:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Aug 2020 16:25:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27104 invoked by uid 111); 14 Aug 2020 16:25:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Aug 2020 12:25:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Aug 2020 12:25:25 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/6] more small leak fixes
Message-ID: <20200814162525.GA595840@coredump.intra.peff.net>
References: <20200814161328.GA153929@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200814161328.GA153929@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 14, 2020 at 12:13:28PM -0400, Jeff King wrote:

> Based on the discussion over in [1], I wondered how close we were to
> being able to run some test scripts with a leak-checker like LSan not
> complaining. The answer is...not close.
> 
> I picked t5526 more or less at random (it was the first failure when I
> did a parallel "make test") to see what it would take to get it passing.
> After much effort...I have t5526.1, the setup test, running clean. :)

For reference, here are the UNLEAK() calls I had to add to silence the
false positives. Some of these are kind of sketchy. For example,
declaring that wt_status_collect_changes_index() is allowed to leak is a
bit low-level for my tastes (in general it's probably only called once
per program, but it's getting quite far from the bottom of the stack).
But there's actually no convenient way to free the various bits of a
rev_info, so marking it with UNLEAK() is an expedient hack.

---
 builtin/clone.c             | 9 +++++++++
 builtin/init-db.c           | 1 +
 builtin/rev-list.c          | 1 +
 builtin/submodule--helper.c | 4 ++++
 parse-options.c             | 1 +
 wt-status.c                 | 3 +++
 6 files changed, 19 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index b087ee40c2..b2578c3c50 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -998,6 +998,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	repo_name = argv[0];
 
 	path = get_repo_path(repo_name, &is_bundle);
+	UNLEAK(path);
 	if (path)
 		repo = absolute_pathdup(repo_name);
 	else if (strchr(repo_name, ':')) {
@@ -1047,6 +1048,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		work_tree = dir;
 		git_dir = mkpathdup("%s/.git", dir);
 	}
+	UNLEAK(git_dir);
 
 	atexit(remove_junk);
 	sigchain_push_common(remove_junk_on_signal);
@@ -1166,6 +1168,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	transport->family = family;
 
 	path = get_repo_path(remote->url[0], &is_bundle);
+	UNLEAK(path);
 	is_local = option_local != 0 && path && !is_bundle;
 	if (is_local) {
 		if (option_depth)
@@ -1336,5 +1339,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	junk_mode = JUNK_LEAVE_ALL;
 
 	strvec_clear(&ref_prefixes);
+
+	UNLEAK(remote_head_points_at);
+	UNLEAK(refs);
+	UNLEAK(mapped_refs);
+	UNLEAK(repo);
+
 	return err;
 }
diff --git a/builtin/init-db.c b/builtin/init-db.c
index f70076d38e..04087ed7e6 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -665,6 +665,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	UNLEAK(real_git_dir);
 	UNLEAK(git_dir);
 	UNLEAK(work_tree);
+	UNLEAK(template_dir);
 
 	flags |= INIT_DB_EXIST_OK;
 	return init_db(git_dir, real_git_dir, template_dir, hash_algo,
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index f520111eda..71c92f6747 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -506,6 +506,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		revs.do_not_die_on_missing_tree = 1;
 
 	argc = setup_revisions(argc, argv, &revs, &s_r_opt);
+	UNLEAK(revs);
 
 	memset(&info, 0, sizeof(info));
 	info.revs = &revs;
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a59d8e4bda..850c8ff966 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -734,6 +734,7 @@ static int module_init(int argc, const char **argv, const char *prefix)
 		info.flags |= OPT_QUIET;
 
 	for_each_listed_submodule(&list, init_submodule_cb, &info);
+	UNLEAK(list);
 
 	return 0;
 }
@@ -1874,6 +1875,8 @@ static int update_submodules(struct submodule_update_clone *suc)
 				   update_clone_task_finished, suc, "submodule",
 				   "parallel/update");
 
+	UNLEAK(*suc);
+
 	/*
 	 * We saved the output and put it out all at once now.
 	 * That means:
@@ -2133,6 +2136,7 @@ static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
 		strbuf_release(&sb);
 	}
 
+	repo_clear(&subrepo);
 	return 0;
 }
 
diff --git a/parse-options.c b/parse-options.c
index c57618d537..b87cb3d70a 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -675,6 +675,7 @@ static struct option *preprocess_options(struct parse_opt_ctx_t *ctx,
 			newopt[i].short_name = short_name;
 			newopt[i].long_name = long_name;
 			newopt[i].help = strbuf_detach(&help, NULL);
+			UNLEAK(newopt[i].help);
 			break;
 		}
 
diff --git a/wt-status.c b/wt-status.c
index d75399085d..7f605958f2 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -616,6 +616,7 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 	rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
 	copy_pathspec(&rev.prune_data, &s->pathspec);
 	run_diff_files(&rev, 0);
+	UNLEAK(rev);
 }
 
 static void wt_status_collect_changes_index(struct wt_status *s)
@@ -627,6 +628,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	memset(&opt, 0, sizeof(opt));
 	opt.def = s->is_initial ? empty_tree_oid_hex() : s->reference;
 	setup_revisions(0, NULL, &rev, &opt);
+	UNLEAK(rev);
 
 	rev.diffopt.flags.override_submodule_config = 1;
 	rev.diffopt.ita_invisible_in_index = 1;
@@ -652,6 +654,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
 	copy_pathspec(&rev.prune_data, &s->pathspec);
 	run_diff_index(&rev, 1);
+	UNLEAK(rev);
 }
 
 static void wt_status_collect_changes_initial(struct wt_status *s)
-- 
2.28.0.596.g9c08d63829

