From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 8/8] submodules: allow parallel fetching, add tests and documentation
Date: Mon, 12 Oct 2015 11:47:21 -0700
Message-ID: <1444675641-14866-9-git-send-email-sbeller@google.com>
References: <1444675641-14866-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 12 20:47:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zli8W-0006Ox-Sf
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 20:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584AbbJLSrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 14:47:39 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34775 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbbJLSrg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 14:47:36 -0400
Received: by padhy16 with SMTP id hy16so160547578pad.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 11:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zXPtNORjt8iNHOIOVquWkgPdjiTI4h+Vc2IiBF0yMAI=;
        b=MIOdwPD1MSvdBwGPrILrgfMw2x0x7yfb0OcnaYP81HXtdGnHoKi5FdK+IwoIQJTUeS
         rR6sASnfas2FnBg5wZ4e8Tt18k8UwXt5GRzVVnMLbW8suuuZ/E5dXaGUiZxy74YEqErT
         MTaoCyA4kD2S5UT8nWEjyvltKrLDsabUSgJ2KFZXoqEbEGun8wn/FfeJECC2WEDEG/hA
         uBLtfHx8scbdopJq22Ovch/WG36BHwjKummsCp6gkZmVItT+dc0aDj8uYc2XASPWr7P/
         zJmX2yxC4VvC/bZ43/N0ydY6reNW85JfA0az8Quy0PJrTXZcOX7vVskiZmUWEd+Icok4
         MYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zXPtNORjt8iNHOIOVquWkgPdjiTI4h+Vc2IiBF0yMAI=;
        b=mgQkQdoSpBCbnwGAhA8oG+MiReq26BtCco3kPX5bU2v6E3+6ybiuoMVoXS9yJ8Yqo5
         g2Nd4I4plgiCcaTb/p9L+c+ClAAr9VfE5SWAYtVKUj44VWpKz79wXrHPOIlbOU5X1jhW
         zueYgv5g6pmeG6LpdyEe3JlWmZ9iXCjI4CzS4X7f9MXgfNNq/jWow+eebk4rv02DNXk8
         7eN2vosWRzPPv9c1Y2+t3UoB9l0+esRHpJEGCf76zPol/qWiISUKa1OvgynI/Bu4bdM+
         pxMXh/GSBDU+ceAMnn9Qm21tFhhGYEKKyYKW3HAqos9EMJ6t6r3bbmYgbQjYBaYj51Lr
         8+PA==
X-Gm-Message-State: ALoCoQnH7IW7ldkvCcRjUX2zTIZ7q3Or1kARsYS9rTZWe/p03/Cdf6h4Q2Sz49w2EFBaUcLCvWL+
X-Received: by 10.68.110.165 with SMTP id ib5mr35775421pbb.58.1444675656032;
        Mon, 12 Oct 2015 11:47:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:5950:8bdc:8939:e460])
        by smtp.gmail.com with ESMTPSA id qb7sm8061492pab.47.2015.10.12.11.47.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 12 Oct 2015 11:47:35 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.268.g453a26a
In-Reply-To: <1444675641-14866-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279399>

This enables the work of the previous patches.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/fetch-options.txt |  7 +++++++
 builtin/fetch.c                 |  6 +++++-
 builtin/pull.c                  |  6 ++++++
 submodule.c                     |  3 +--
 submodule.h                     |  2 +-
 t/t5526-fetch-submodules.sh     | 19 +++++++++++++++++++
 6 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 45583d8..6b109f6 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -100,6 +100,13 @@ ifndef::git-pull[]
 	reference to a commit that isn't already in the local submodule
 	clone.
 
+-j::
+--jobs=<n>::
+	Number of parallel children to be used for fetching submodules.
+	Each will fetch from different submodules, such that fetching many
+	submodules will be faster. By default submodules will be fetched
+	one at a time.
+
 --no-recurse-submodules::
 	Disable recursive fetching of submodules (this has the same effect as
 	using the '--recurse-submodules=no' option).
diff --git a/builtin/fetch.c b/builtin/fetch.c
index ee1f1a9..f28eac6 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -37,6 +37,7 @@ static int prune = -1; /* unspecified */
 static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity;
 static int progress = -1, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int tags = TAGS_DEFAULT, unshallow, update_shallow;
+static int max_children = 1;
 static const char *depth;
 static const char *upload_pack;
 static struct strbuf default_rla = STRBUF_INIT;
@@ -99,6 +100,8 @@ static struct option builtin_fetch_options[] = {
 		    N_("fetch all tags and associated objects"), TAGS_SET),
 	OPT_SET_INT('n', NULL, &tags,
 		    N_("do not fetch all tags (--no-tags)"), TAGS_UNSET),
+	OPT_INTEGER('j', "jobs", &max_children,
+		    N_("number of submodules fetched in parallel")),
 	OPT_BOOL('p', "prune", &prune,
 		 N_("prune remote-tracking branches no longer on remote")),
 	{ OPTION_CALLBACK, 0, "recurse-submodules", NULL, N_("on-demand"),
@@ -1217,7 +1220,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		result = fetch_populated_submodules(&options,
 						    submodule_prefix,
 						    recurse_submodules,
-						    verbosity < 0);
+						    verbosity < 0,
+						    max_children);
 		argv_array_clear(&options);
 	}
 
diff --git a/builtin/pull.c b/builtin/pull.c
index 722a83c..f0af196 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -94,6 +94,7 @@ static int opt_force;
 static char *opt_tags;
 static char *opt_prune;
 static char *opt_recurse_submodules;
+static char *max_children;
 static int opt_dry_run;
 static char *opt_keep;
 static char *opt_depth;
@@ -177,6 +178,9 @@ static struct option pull_options[] = {
 		N_("on-demand"),
 		N_("control recursive fetching of submodules"),
 		PARSE_OPT_OPTARG),
+	OPT_PASSTHRU('j', "jobs", &max_children, N_("n"),
+		N_("number of submodules pulled in parallel"),
+		PARSE_OPT_OPTARG),
 	OPT_BOOL(0, "dry-run", &opt_dry_run,
 		N_("dry run")),
 	OPT_PASSTHRU('k', "keep", &opt_keep, NULL,
@@ -524,6 +528,8 @@ static int run_fetch(const char *repo, const char **refspecs)
 		argv_array_push(&args, opt_prune);
 	if (opt_recurse_submodules)
 		argv_array_push(&args, opt_recurse_submodules);
+	if (max_children)
+		argv_array_push(&args, max_children);
 	if (opt_dry_run)
 		argv_array_push(&args, "--dry-run");
 	if (opt_keep)
diff --git a/submodule.c b/submodule.c
index 8fdd2cb..c21b265 100644
--- a/submodule.c
+++ b/submodule.c
@@ -737,10 +737,9 @@ static int fetch_finish(int retvalue, struct child_process *cp,
 
 int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
-			       int quiet)
+			       int quiet, int max_parallel_jobs)
 {
 	int i;
-	int max_parallel_jobs = 1;
 	struct submodule_parallel_fetch spf = SPF_INIT;
 
 	spf.work_tree = get_git_work_tree();
diff --git a/submodule.h b/submodule.h
index 5507c3d..cbc0003 100644
--- a/submodule.h
+++ b/submodule.h
@@ -31,7 +31,7 @@ void set_config_fetch_recurse_submodules(int value);
 void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
-			       int quiet);
+			       int quiet, int max_parallel_jobs);
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
 int submodule_uses_gitfile(const char *path);
 int ok_to_remove_submodule(const char *path);
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 17759b1..1b4ce69 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -71,6 +71,16 @@ test_expect_success "fetch --recurse-submodules recurses into submodules" '
 	test_i18ncmp expect.err actual.err
 '
 
+test_expect_success "fetch --recurse-submodules -j2 has the same output behaviour" '
+	add_upstream_commit &&
+	(
+		cd downstream &&
+		git fetch --recurse-submodules -j2 2>../actual.err
+	) &&
+	test_must_be_empty actual.out &&
+	test_i18ncmp expect.err actual.err
+'
+
 test_expect_success "fetch alone only fetches superproject" '
 	add_upstream_commit &&
 	(
@@ -140,6 +150,15 @@ test_expect_success "--quiet propagates to submodules" '
 	! test -s actual.err
 '
 
+test_expect_success "--quiet propagates to parallel submodules" '
+	(
+		cd downstream &&
+		git fetch --recurse-submodules -j 2 --quiet  >../actual.out 2>../actual.err
+	) &&
+	! test -s actual.out &&
+	! test -s actual.err
+'
+
 test_expect_success "--dry-run propagates to submodules" '
 	add_upstream_commit &&
 	(
-- 
2.5.0.268.g453a26a
