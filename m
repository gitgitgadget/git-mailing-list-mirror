From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 8/8] submodules: allow parallel fetching, add tests and documentation
Date: Mon, 28 Sep 2015 16:14:06 -0700
Message-ID: <1443482046-25569-9-git-send-email-sbeller@google.com>
References: <1443482046-25569-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 29 01:14:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zghd5-0007Kf-F1
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 01:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913AbbI1XOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 19:14:38 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:32874 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696AbbI1XOb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 19:14:31 -0400
Received: by pacex6 with SMTP id ex6so186732661pac.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 16:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PD9fBBdnec/7n6ylO2geq8GW6Icawm3OuQN4JJ9cJ2w=;
        b=bXtTB4QE0fD1RHlU08VVGe+5UBJ/Qt+Hxn+px0MrcYtl0G9A+t9cq/un0Nx5pgrcF5
         761egVB4e0LPvgWH78Y1YhUrx1+XU3KIaWiunWc/noEnd2sojsPwn4PwM56Pu0B1Ol5F
         FZ1jeDlY5vuVIC2t9Iq/H5bidsHsIuvIiScBNpXAAEKKLBJ2RxgUIjPdKdwNZtHEzmPM
         nFR5Cyzj34j0BCO78Nm4sb9Lxc8B+Or8+u+o73IoguuSXvh2VzUxu3c6g1NNYarBGDe/
         y87XZSfsvAf+/4/9kwrav6C9ardM6wk8YOnLsSXl5v4zeMhYoikR9VZ828GHbhyZ2r3n
         chTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PD9fBBdnec/7n6ylO2geq8GW6Icawm3OuQN4JJ9cJ2w=;
        b=aVFAF83AJ/Z+CKaTu7U6XYAeGA/DHmLtC7vp6vXAMZimCUJIEGj628uJT7Je2RrJLa
         S/1D8VgEvqiLBu5Y8ahewv7u26fzf04H+T67V8orb4PHkZdS7CCWD9uESWWInCM5tQyI
         mgc+6n+u79/qPL84bFcT8gyJFUZcXElwcK9j7KYurBGB39G9mpCuE/nKD3ODS6pMuZVn
         y87MMxgvENfizTVSn1lmWNvpxNHgsrG3cNBTovXu4xC4vtzptEVVqT45hFYQ0oTeJ8Xw
         ojkYzD+l+wjOESa8HsIAHfxXVIA3PADCJuNP1sddxpB6BXOI4k+jU4pESAu9EMBWs87l
         kK1w==
X-Gm-Message-State: ALoCoQmP6qIeHSN0DQSpRDqol+VIwrN3FkLz9jjo8P2Kd8WDXW1hzNmkujAK3n1KrmBaTRqBA5uJ
X-Received: by 10.68.69.47 with SMTP id b15mr28345186pbu.139.1443482070831;
        Mon, 28 Sep 2015 16:14:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:79ce:7412:e4be:3e39])
        by smtp.gmail.com with ESMTPSA id we9sm21589811pab.3.2015.09.28.16.14.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Sep 2015 16:14:30 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.273.g6fa2560.dirty
In-Reply-To: <1443482046-25569-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278805>

This enables the work of the previous patches.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
index 8134fe7..7ab89f4 100644
--- a/submodule.c
+++ b/submodule.c
@@ -653,10 +653,9 @@ static int fetch_finish(void *data, struct child_process *cp,
 
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
2.5.0.273.g6fa2560.dirty
