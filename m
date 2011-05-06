From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] Teach checkout the -n|--dry-run option
Date: Sat, 07 May 2011 00:12:18 +0200
Message-ID: <4DC47242.6060205@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 07 00:12:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QITG6-0001Z8-Fm
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 00:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897Ab1EFWMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 18:12:21 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:41945 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417Ab1EFWMU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 18:12:20 -0400
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 75C4418E1F682;
	Sat,  7 May 2011 00:12:18 +0200 (CEST)
Received: from [93.246.59.164] (helo=[192.168.178.43])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QITFy-0003yp-00; Sat, 07 May 2011 00:12:18 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18ifQCM2dyIq7IOEiPSE+1LGZ1P+mDP4uI0zdUJ
	MAQNSxCl3wsuCyNV/jET+b/71pnePpyGH5cea7jAQqXJmWbO+X
	euC5qJT8cr8xiMhMSmfQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173019>

This option can be used to determine if checking out a branch or commit
would touch files which are modified in the work tree. It doesn't change
the work tree contents or the index, so it can only tell if the checkout
would succeed using trivial merges.

It can neither be used when checking out only certain paths nor together
with the '-m' option.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

This is a repost of a RFC patch from Sep 04, 2010 I did not receive any
responses upon:

I need this new option for the recursive submodule checkout. Denying a
checkout inside a submodule just because it has modifications is a too
limiting condition (and it is way too expensive to check the whole tree,
just looking at those paths going to be changed by the checkout should
be much faster, especially for large submodules).

IMO the same behavior that applies for a checkout in the superproject
should apply for the checkout inside the submodule: no local changes
may be overwritten by the checkout (and the HEAD must match the commit
recorded in the superproject, but that is handled elsewhere).

To be able to test that, I added the -n|--dry-run option to checkout.
I think I found all relevant places, but a few more eyeballs are highly
appreciated as I am not very familiar with this part of the code.

A thing I'm not so sure about is the output of show_local_changes(),
with -n it doesn't show the changes as they would have been *after* the
- not executed - checkout but *without* having done it.
Is that a problem here?

 Documentation/git-checkout.txt |   15 ++++++++++++---
 builtin/checkout.c             |   20 +++++++++++++++-----
 t/t2018-checkout-branch.sh     |   23 +++++++++++++++++++++++
 3 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 1063f69..ae58762 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -8,9 +8,9 @@ git-checkout - Checkout a branch or paths to the working tree
 SYNOPSIS
 --------
 [verse]
-'git checkout' [-q] [-f] [-m] [<branch>]
-'git checkout' [-q] [-f] [-m] [--detach] [<commit>]
-'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
+'git checkout' [-q] [-f] [-m|-n] [<branch>]
+'git checkout' [-q] [-f] [-m|-n] [--detach] [<commit>]
+'git checkout' [-q] [-f] [-m|-n] [[-b|-B|--orphan] <new_branch>] [<start_point>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
 'git checkout' --patch [<tree-ish>] [--] [<paths>...]

@@ -79,6 +79,13 @@ OPTIONS
 When checking out paths from the index, do not fail upon unmerged
 entries; instead, unmerged entries are ignored.

+-n::
+--dry-run::
+	Don't really checkout the file(s), just check if it would succeed
+	using only trivial merges. Using this option will not touch the work
+	tree or the index. The command will fail when the checkout would change
+	locally modified files. This option can not be used together with `-m`.
+
 --ours::
 --theirs::
 	When checking out paths from the index, check out stage #2
@@ -167,6 +174,8 @@ should result in deletion of the path).
 +
 When checking out paths from the index, this option lets you recreate
 the conflicted merge in the specified paths.
++
+This option does not work together with '-n'.

 --conflict=<style>::
 	The same as --merge option above, but changes the way the
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 38632fc..01175d1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -33,6 +33,7 @@ struct checkout_opts {
 	int force_detach;
 	int writeout_stage;
 	int writeout_error;
+	int dry_run;

 	/* not set by parse_options */
 	int branch_exists;
@@ -373,6 +374,8 @@ static int merge_working_tree(struct checkout_opts *opts,

 	resolve_undo_clear();
 	if (opts->force) {
+		if (opts->dry_run)
+			return 0;
 		ret = reset_tree(new->commit->tree, opts, 1);
 		if (ret)
 			return ret;
@@ -397,7 +400,7 @@ static int merge_working_tree(struct checkout_opts *opts,

 		/* 2-way merge to the new branch */
 		topts.initial_checkout = is_cache_unborn();
-		topts.update = 1;
+		topts.update = !opts->dry_run;
 		topts.merge = 1;
 		topts.gently = opts->merge && old->commit;
 		topts.verbose_update = !opts->quiet;
@@ -471,8 +474,8 @@ static int merge_working_tree(struct checkout_opts *opts,
 		}
 	}

-	if (write_cache(newfd, active_cache, active_nr) ||
-	    commit_locked_index(lock_file))
+	if (!opts->dry_run && (write_cache(newfd, active_cache, active_nr) ||
+			       commit_locked_index(lock_file)))
 		die(_("unable to write new index file"));

 	if (!opts->force && !opts->quiet)
@@ -732,7 +735,7 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 	}

 	ret = merge_working_tree(opts, &old, new);
-	if (ret)
+	if (ret || opts->dry_run)
 		return ret;

 	if (!opts->quiet && !old.path && old.commit && new->commit != old.commit)
@@ -941,6 +944,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN('m', "merge", &opts.merge, "perform a 3-way merge with the new branch"),
 		OPT_STRING(0, "conflict", &conflict_style, "style",
 			   "conflict style (merge or diff3)"),
+		OPT_BOOLEAN('n', "dry-run", &opts.dry_run, "show if the checkout would fail because it touches locally modified files"),
 		OPT_BOOLEAN('p', "patch", &patch_mode, "select hunks interactively"),
 		{ OPTION_BOOLEAN, 0, "guess", &dwim_new_local_branch, NULL,
 		  "second guess 'git checkout no-such-branch'",
@@ -967,7 +971,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	if (opts.new_branch_force)
 		opts.new_branch = opts.new_branch_force;

-	if (patch_mode && (opts.track > 0 || opts.new_branch
+	if (patch_mode && (opts.track > 0 || opts.new_branch || opts.dry_run
 			   || opts.new_branch_log || opts.merge || opts.force
 			   || opts.force_detach))
 		die (_("--patch is incompatible with all other options"));
@@ -1008,6 +1012,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	if (opts.force && opts.merge)
 		die(_("git checkout: -f and -m are incompatible"));

+	if (opts.merge && opts.dry_run)
+		die("git checkout: -m and -n are incompatible");
+
 	/*
 	 * Extract branch name from command line arguments, so
 	 * all that is left is pathspecs.
@@ -1060,6 +1067,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		if (1 < !!opts.writeout_stage + !!opts.force + !!opts.merge)
 			die(_("git checkout: --ours/--theirs, --force and --merge are incompatible when\nchecking out of the index."));

+		if (opts.dry_run)
+			die("git checkout: updating paths is incompatible with -n.");
+
 		return checkout_paths(source_tree, pathspec, &opts);
 	}

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index fa69016..61c82ef 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -169,4 +169,27 @@ test_expect_success 'checkout -f -B to an existing branch with mergeable changes
 	test_must_fail test_dirty_mergeable
 '

+test_expect_success 'checkout -n/--dry-run does not change work tree or index' '
+	echo precious >expect &&
+	echo precious >file1 &&
+	test_must_fail git checkout -n branch1 &&
+	test_cmp expect file1 &&
+	git checkout --dry-run -f branch1 &&
+	test_cmp expect file1 &&
+	test_must_fail git checkout -b new_branch --dry-run branch1 &&
+	test_cmp expect file1 &&
+	git checkout -b new_branch -n -f branch1 &&
+	test_cmp expect file1 &&
+	git checkout -f branch1 &&
+	git status -s -uno > actual &&
+	! test -s actual &&
+	git checkout -n HEAD^ &&
+	git status -s -uno > actual &&
+	! test -s actual
+'
+
+test_expect_success 'checkout -n/--dry-run is not allowed when checking out only certain paths' '
+	test_must_fail git checkout -n branch1 file1 &&
+	test_must_fail git checkout -n HEAD file1
+'
 test_done
-- 
1.7.5.1.174.g799a9
