Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C411C84AE
	for <git@vger.kernel.org>; Sat, 19 Jul 2025 07:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752908896; cv=none; b=OwG+AMugFPU2WWVa1AJtrCt88yLQM3+a4E68fD033FPAbcwXclZevbKIaRO6PbQz9aydxHCyv74Gpu7fLjCmqnQyyfRMV53XdQjexu1HHuoy51a9ZBeXkDUq1daMXELZp3zueKNLXOcmM2+72LK02qyr3xmDtSF78Sh8M3j6hCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752908896; c=relaxed/simple;
	bh=oInIKnIX6K5OLTRntn6b+b7QZ5p/NWX1Yu5dEAPDplw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S5ldijaN0o0wVCTYAATxn0IIF3WaIewbpm9uBFOykrkipk+RyTCuZCDyqPxH8vvWwjLpkHbbIaMGvMoC0mDy1+zGjT7zO6RJFXtGcI3t2oSnKlB62MW4ttT7bOn9LYX77GrzRGR17NYwP5E3R/mXU64+Zix8xuGb/QaXpy4CXUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BWyFxZQd; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BWyFxZQd"
Received: (qmail 27250 invoked by uid 109); 19 Jul 2025 07:08:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:mime-version:content-type; s=20240930; bh=oInIKnIX6K5OLTRntn6b+b7QZ5p/NWX1Yu5dEAPDplw=; b=BWyFxZQdvyDV0TJsu0bL1Lk5j9AKLZFRvux3wv97NAIjQw5j7LMt+RRhhEICMFbV7iQiuGkDXTxmsZ8XxzauqUH57dC+LlCBP6i17oQ2QxMi1VpPczATiyDu/81yP4BGqLza/mTpMjUFWcBxFLadPaf8GwZOywxyVBnnILZ/mGPrrNnheASWfp/trEs5gj1NJ9rw1fwUNR++e26TWPBFxBoUwKkrs+Mcoudz1RoIdRbVJyf5QRRlwrIGCRbGVNFX4oV0nYE/eIeej4Z4oCL7ifOYUHZvRgPTJ4E2IlQvmv9FJaiiPrx0i5rL6g8HvceQy5PMsmBqSUX3b0EhbwLRjA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 19 Jul 2025 07:08:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4704 invoked by uid 111); 19 Jul 2025 07:08:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 19 Jul 2025 03:08:18 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 19 Jul 2025 03:08:13 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH] revision: drop early output option
Message-ID: <20250719070813.GA706382@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

We added the --early-output feature long ago in cdcefbc971 (Add
"--early-output" log flag for interactive GUI use, 2007-11-03). The idea
was that GUIs could use it to progressively render a history view,
showing something quick-and-inaccurate at first and then enhancing it
later.

But we never documented it, and it appears never to have been used, even
by the projects which initially expressed interest. There was an RFC
patch for gitk to use it:

  http://public-inbox.org/git/18221.2285.259487.655684@cargo.ozlabs.ibm.com/

but it was never merged. Likewise QGit had a patch in:

  https://lore.kernel.org/git/e5bfff550711040225ne67c907r2023b1354c35f35@mail.gmail.com/

but it was never fully merged (to this day, QGit has a commented-out line to
add "--early-output" to the "log" invocation). Searching for other
mentions on the web or forges like github.com turns up nothing.

Meanwhile, the feature has been broken off and on over the years without
anybody noticing (and naturally, there are no tests, either). From 2011
to 2017 the option didn't even turn on via "--early-output"; this was
fixed in e35b6ac56f (revision.h: turn rev_info.early_output back into an
unsigned int, 2017-06-10).

It worked for a while then, but it does not interact well at all with
commit-graphs (which are turned on by default these days). The main
logic to count early commits is triggered by limit_list(), which we
traditionally invoked when showing output in topo-order (and
--early-output always enables --topo-order). But that changed in
f0d9cc4196 (revision.c: begin refactoring --topo-order logic,
2018-11-01). Now when we have generation numbers, we skip limit_list()
entirely, and the early-output code shows no commits, and just the final
header "Final output: 1 done". Which is syntactically OK, but
semantically wrong: that message should give the total number of commits
we're about to show.

So let's drop the feature. It is extra code that is untested and
undocumented, and makes working on the revision machinery more brittle.

Given the history above, it seems unlikely that anybody is using it (or
has used it), and we can drop it without the usual deprecation period.

A gentler option might be to "soft" drop it: keep accepting the option,
have it imply --topo-order as it does now, print "Final output: 1 done",
and then do our regular traversal. That would keep any hypothetical
caller working. But it doesn't seem worth the hassle to me.

Signed-off-by: Jeff King <peff@peff.net>
---
My ulterior motive is to make changes to the revision code, and I do not
want to drag this (untested!) code along. A lengthy deprecation period
would make that more annoying. I feel like the arguments above are
reasonable, or am I just being lazy and impatient?

The "soft" version would not be too hard to do, if we find that more
palatable.

 builtin/log.c | 129 --------------------------------------------------
 revision.c    |  17 -------
 revision.h    |   8 ----
 3 files changed, 154 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 24a57c20a4..fb42e094af 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -391,145 +391,16 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	cmd_log_init_finish(argc, argv, prefix, rev, opt, cfg);
 }
 
-/*
- * This gives a rough estimate for how many commits we
- * will print out in the list.
- */
-static int estimate_commit_count(struct commit_list *list)
-{
-	int n = 0;
-
-	while (list) {
-		struct commit *commit = list->item;
-		unsigned int flags = commit->object.flags;
-		list = list->next;
-		if (!(flags & (TREESAME | UNINTERESTING)))
-			n++;
-	}
-	return n;
-}
-
-static void show_early_header(struct rev_info *rev, const char *stage, int nr)
-{
-	if (rev->shown_one) {
-		rev->shown_one = 0;
-		if (rev->commit_format != CMIT_FMT_ONELINE)
-			putchar(rev->diffopt.line_termination);
-	}
-	fprintf(rev->diffopt.file, _("Final output: %d %s\n"), nr, stage);
-}
-
-static struct itimerval early_output_timer;
-
-static void log_show_early(struct rev_info *revs, struct commit_list *list)
-{
-	int i = revs->early_output;
-	int show_header = 1;
-	int no_free = revs->diffopt.no_free;
-
-	revs->diffopt.no_free = 0;
-	sort_in_topological_order(&list, revs->sort_order);
-	while (list && i) {
-		struct commit *commit = list->item;
-		switch (simplify_commit(revs, commit)) {
-		case commit_show:
-			if (show_header) {
-				int n = estimate_commit_count(list);
-				show_early_header(revs, "incomplete", n);
-				show_header = 0;
-			}
-			log_tree_commit(revs, commit);
-			i--;
-			break;
-		case commit_ignore:
-			break;
-		case commit_error:
-			revs->diffopt.no_free = no_free;
-			diff_free(&revs->diffopt);
-			return;
-		}
-		list = list->next;
-	}
-
-	/* Did we already get enough commits for the early output? */
-	if (!i) {
-		revs->diffopt.no_free = 0;
-		diff_free(&revs->diffopt);
-		return;
-	}
-
-	/*
-	 * ..if no, then repeat it twice a second until we
-	 * do.
-	 *
-	 * NOTE! We don't use "it_interval", because if the
-	 * reader isn't listening, we want our output to be
-	 * throttled by the writing, and not have the timer
-	 * trigger every second even if we're blocked on a
-	 * reader!
-	 */
-	early_output_timer.it_value.tv_sec = 0;
-	early_output_timer.it_value.tv_usec = 500000;
-	setitimer(ITIMER_REAL, &early_output_timer, NULL);
-}
-
-static void early_output(int signal UNUSED)
-{
-	show_early_output = log_show_early;
-}
-
-static void setup_early_output(void)
-{
-	struct sigaction sa;
-
-	/*
-	 * Set up the signal handler, minimally intrusively:
-	 * we only set a single volatile integer word (not
-	 * using sigatomic_t - trying to avoid unnecessary
-	 * system dependencies and headers), and using
-	 * SA_RESTART.
-	 */
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = early_output;
-	sigemptyset(&sa.sa_mask);
-	sa.sa_flags = SA_RESTART;
-	sigaction(SIGALRM, &sa, NULL);
-
-	/*
-	 * If we can get the whole output in less than a
-	 * tenth of a second, don't even bother doing the
-	 * early-output thing..
-	 *
-	 * This is a one-time-only trigger.
-	 */
-	early_output_timer.it_value.tv_sec = 0;
-	early_output_timer.it_value.tv_usec = 100000;
-	setitimer(ITIMER_REAL, &early_output_timer, NULL);
-}
-
-static void finish_early_output(struct rev_info *rev)
-{
-	int n = estimate_commit_count(rev->commits);
-	signal(SIGALRM, SIG_IGN);
-	show_early_header(rev, "done", n);
-}
-
 static int cmd_log_walk_no_free(struct rev_info *rev)
 {
 	struct commit *commit;
 	int saved_nrl = 0;
 	int saved_dcctc = 0;
 	int result;
 
-	if (rev->early_output)
-		setup_early_output();
-
 	if (prepare_revision_walk(rev))
 		die(_("revision walk setup failed"));
 
-	if (rev->early_output)
-		finish_early_output(rev);
-
 	/*
 	 * For --check and --exit-code, the exit code is based on CHECK_FAILED
 	 * and HAS_CHANGES being accumulated in rev->diffopt, so be careful to
diff --git a/revision.c b/revision.c
index 0ca6a297a6..1ba8eb8a1c 100644
--- a/revision.c
+++ b/revision.c
@@ -50,8 +50,6 @@
 #include "parse-options.h"
 #include "wildmatch.h"
 
-volatile show_early_output_fn_t show_early_output;
-
 static char *term_bad;
 static char *term_good;
 
@@ -1479,7 +1477,6 @@ static int limit_list(struct rev_info *revs)
 	while (original_list) {
 		struct commit *commit = pop_commit(&original_list);
 		struct object *obj = &commit->object;
-		show_early_output_fn_t show;
 
 		if (commit == interesting_cache)
 			interesting_cache = NULL;
@@ -1503,13 +1500,6 @@ static int limit_list(struct rev_info *revs)
 			continue;
 		date = commit->date;
 		p = &commit_list_insert(commit, p)->next;
-
-		show = show_early_output;
-		if (!show)
-			continue;
-
-		show(revs, newlist);
-		show_early_output = NULL;
 	}
 	if (revs->cherry_pick || revs->cherry_mark)
 		cherry_pick_list(newlist, revs);
@@ -2443,13 +2433,6 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--author-date-order")) {
 		revs->sort_order = REV_SORT_BY_AUTHOR_DATE;
 		revs->topo_order = 1;
-	} else if (!strcmp(arg, "--early-output")) {
-		revs->early_output = 100;
-		revs->topo_order = 1;
-	} else if (skip_prefix(arg, "--early-output=", &optarg)) {
-		if (strtoul_ui(optarg, 10, &revs->early_output) < 0)
-			die("'%s': not a non-negative integer", optarg);
-		revs->topo_order = 1;
 	} else if (!strcmp(arg, "--parents")) {
 		revs->rewrite_parents = 1;
 		revs->print_parents = 1;
diff --git a/revision.h b/revision.h
index 6d369cdad6..fe93567e89 100644
--- a/revision.h
+++ b/revision.h
@@ -160,8 +160,6 @@ struct rev_info {
 	/* topo-sort */
 	enum rev_sort_order sort_order;
 
-	unsigned int early_output;
-
 	unsigned int	ignore_missing:1,
 			ignore_missing_links:1;
 
@@ -553,10 +551,4 @@ int rewrite_parents(struct rev_info *revs,
  */
 struct commit_list *get_saved_parents(struct rev_info *revs, const struct commit *commit);
 
-/**
- * Global for the (undocumented) "--early-output" flag for "git log".
- */
-typedef void (*show_early_output_fn_t)(struct rev_info *, struct commit_list *);
-extern volatile show_early_output_fn_t show_early_output;
-
 #endif
-- 
2.50.1.589.g6e88b11be3
