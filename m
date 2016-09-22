Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 474601F935
	for <e@80x24.org>; Thu, 22 Sep 2016 05:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755960AbcIVFYw (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 01:24:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:46494 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755280AbcIVFYu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 01:24:50 -0400
Received: (qmail 13178 invoked by uid 109); 22 Sep 2016 05:24:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Sep 2016 05:24:49 +0000
Received: (qmail 5882 invoked by uid 111); 22 Sep 2016 05:25:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Sep 2016 01:25:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Sep 2016 01:24:46 -0400
Date:   Thu, 22 Sep 2016 01:24:46 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH] clone: pass --progress decision to recursive submodules
Message-ID: <20160922052446.iwr62hpa2meal7uj@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cloning with "--recursive", we'd generally expect
submodules to show progress reports if the main clone did,
too.

In older versions of git, this mostly worked out of the
box. Since we show progress by default when stderr is a tty,
and since the child clones inherit the parent stderr, then
both processes would come to the same decision by default.
If the parent clone was asked for "--quiet", we passed down
"--quiet" to the child. However, if stderr was not a tty and
the user specified "--progress", we did not propagate this
to the child.

That's a minor bug, but things got much worse when we
switched recently to submodule--helper's update_clone
command. With that change, the stderr of the child clones
are always connected to a pipe, and we never output
progress at all.

This patch teaches git-submodule and git-submodule--helper
how to pass down an explicit "--progress" flag when cloning.
The clone command then decides to propagate that flag based
on the cloning decision made earlier (which takes into
account isatty(2) of the parent process, existing --progress
or --quiet flags, etc). Since the child processes always run
without a tty on stderr, we don't have to worry about
passing an explicit "--no-progress"; it's the default for
them.

This fixes the recent loss of progress during recursive
clones. And as a bonus, it makes:

  git clone --recursive --progress ... 2>&1 | cat

work by triggering progress explicitly in the children.

Signed-off-by: Jeff King <peff@peff.net>
---
I don't usually use submodules, but I happened to be testing something,
and my goto "this has a lot of submodules" repository happens to have
some pretty large submodules. So I had plenty of time to contemplate the
lack of progress reporting. :)

I checked with --jobs, too, and this should do the right thing; it
queues up the progress reports for submodules that aren't the
output_owner, and then dumps them all at once (so the progress meter
will appear to whiz by for those jobs until it catches up to the current
state, which is the only reasonable thing we can do, I think).

I imagine there are other code paths that want similar treatment, but I
didn't look into them. I'd assume "fetch" is one. I'm not sure if we do
parallel checkouts, but that's another potential.

 builtin/clone.c             | 16 ++++++++++++++--
 builtin/submodule--helper.c | 18 +++++++++++++++---
 git-submodule.sh            |  5 +++++
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 404c5e8..28ce938 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -670,7 +670,7 @@ static void update_head(const struct ref *our, const struct ref *remote,
 	}
 }
 
-static int checkout(void)
+static int checkout(int submodule_progress)
 {
 	unsigned char sha1[20];
 	char *head;
@@ -734,6 +734,9 @@ static int checkout(void)
 		if (max_jobs != -1)
 			argv_array_pushf(&args, "--jobs=%d", max_jobs);
 
+		if (submodule_progress)
+			argv_array_push(&args, "--progress");
+
 		err = run_command_v_opt(args.argv, RUN_GIT_CMD);
 		argv_array_clear(&args);
 	}
@@ -841,6 +844,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	const char *src_ref_prefix = "refs/heads/";
 	struct remote *remote;
 	int err = 0, complete_refs_before_fetch = 1;
+	int submodule_progress;
 
 	struct refspec *refspec;
 	const char *fetch_pattern;
@@ -1099,6 +1103,14 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	update_head(our_head_points_at, remote_head, reflog_msg.buf);
 
+	/*
+	 * We want to show progress for recursive submodule clones iff
+	 * we did so for the main clone. But only the transport knows
+	 * the final decision for this flag, so we need to rescue the value
+	 * before we free the transport.
+	 */
+	submodule_progress = transport->progress;
+
 	transport_unlock_pack(transport);
 	transport_disconnect(transport);
 
@@ -1108,7 +1120,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 
 	junk_mode = JUNK_LEAVE_REPO;
-	err = checkout();
+	err = checkout(submodule_progress);
 
 	strbuf_release(&reflog_msg);
 	strbuf_release(&branch_top);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 7b8ddfe..d2f9d7d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -443,7 +443,8 @@ static int module_name(int argc, const char **argv, const char *prefix)
 }
 
 static int clone_submodule(const char *path, const char *gitdir, const char *url,
-			   const char *depth, struct string_list *reference, int quiet)
+			   const char *depth, struct string_list *reference,
+			   int quiet, int progress)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 
@@ -451,6 +452,8 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
 	argv_array_push(&cp.args, "--no-checkout");
 	if (quiet)
 		argv_array_push(&cp.args, "--quiet");
+	if (progress)
+		argv_array_push(&cp.args, "--progress");
 	if (depth && *depth)
 		argv_array_pushl(&cp.args, "--depth", depth, NULL);
 	if (reference->nr) {
@@ -575,6 +578,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 {
 	const char *name = NULL, *url = NULL, *depth = NULL;
 	int quiet = 0;
+	int progress = 0;
 	FILE *submodule_dot_git;
 	char *p, *path = NULL, *sm_gitdir;
 	struct strbuf rel_path = STRBUF_INIT;
@@ -601,6 +605,8 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 			   N_("string"),
 			   N_("depth for shallow clones")),
 		OPT__QUIET(&quiet, "Suppress output for cloning a submodule"),
+		OPT_BOOL(0, "progress", &progress,
+			   N_("force cloning progress")),
 		OPT_END()
 	};
 
@@ -634,7 +640,8 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 
 		prepare_possible_alternates(name, &reference);
 
-		if (clone_submodule(path, sm_gitdir, url, depth, &reference, quiet))
+		if (clone_submodule(path, sm_gitdir, url, depth, &reference,
+				    quiet, progress))
 			die(_("clone of '%s' into submodule path '%s' failed"),
 			    url, path);
 	} else {
@@ -684,6 +691,7 @@ struct submodule_update_clone {
 	struct submodule_update_strategy update;
 
 	/* configuration parameters which are passed on to the children */
+	int progress;
 	int quiet;
 	int recommend_shallow;
 	struct string_list references;
@@ -702,7 +710,7 @@ struct submodule_update_clone {
 	int failed_clones_nr, failed_clones_alloc;
 };
 #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
-	SUBMODULE_UPDATE_STRATEGY_INIT, 0, -1, STRING_LIST_INIT_DUP, \
+	SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, \
 	NULL, NULL, NULL, \
 	STRING_LIST_INIT_DUP, 0, NULL, 0, 0}
 
@@ -804,6 +812,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	child->err = -1;
 	argv_array_push(&child->args, "submodule--helper");
 	argv_array_push(&child->args, "clone");
+	if (suc->progress)
+		argv_array_push(&child->args, "--progress");
 	if (suc->quiet)
 		argv_array_push(&child->args, "--quiet");
 	if (suc->prefix)
@@ -950,6 +960,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "recommend-shallow", &suc.recommend_shallow,
 			    N_("whether the initial clone should follow the shallow recommendation")),
 		OPT__QUIET(&suc.quiet, N_("don't print cloning progress")),
+		OPT_BOOL(0, "progress", &suc.progress,
+			    N_("force cloning progress")),
 		OPT_END()
 	};
 
diff --git a/git-submodule.sh b/git-submodule.sh
index a1cc71b..a024a13 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -44,6 +44,7 @@ update=
 prefix=
 custom_name=
 depth=
+progress=
 
 die_if_unmatched ()
 {
@@ -498,6 +499,9 @@ cmd_update()
 		-q|--quiet)
 			GIT_QUIET=1
 			;;
+		--progress)
+			progress="--progress"
+			;;
 		-i|--init)
 			init=1
 			;;
@@ -573,6 +577,7 @@ cmd_update()
 
 	{
 	git submodule--helper update-clone ${GIT_QUIET:+--quiet} \
+		${progress:+"$progress"} \
 		${wt_prefix:+--prefix "$wt_prefix"} \
 		${prefix:+--recursive-prefix "$prefix"} \
 		${update:+--update "$update"} \
-- 
2.10.0.482.gae5a597
