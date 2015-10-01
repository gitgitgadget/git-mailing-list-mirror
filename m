From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv6 8/8] submodules: allow parallel fetching, add tests and documentation
Date: Wed, 30 Sep 2015 18:54:16 -0700
Message-ID: <1443664456-1307-9-git-send-email-sbeller@google.com>
References: <1443664456-1307-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 01 03:55:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhT5a-0000PF-54
	for gcvg-git-2@plane.gmane.org; Thu, 01 Oct 2015 03:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755236AbbJABzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 21:55:14 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33698 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754852AbbJAByi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 21:54:38 -0400
Received: by pacex6 with SMTP id ex6so57699724pac.0
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 18:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+dQ74IGfrppkgq8uzpNLYG02Y01S4fyeP5p+0FqjGhs=;
        b=pIsyI8Uea/ni91gy4MRKxk50PRstwYUaGh3xLfcX5vPp73WmauyR1FUasBGUeaG5ZL
         1AsQPXspsM/Qz+ctORhqw64n8G/OS1C8wpO9W/T8Q7LVc1WUroIxzq+V90AGD+TyBKIm
         XX4SNuWFfBteWAabxV2B+K8bobZYJyPhItw/2E3Aha5+woC6d8XvzdLntO80w0D9yBKh
         04RQKOmdxJibnU3ROo8x3d76Eeq3mzbHSkCYbzspHjfQK63DuM+mFjv+Y9EHBA3R+scz
         GLE5GOfP5aXfW7ZpL7GQSvZxBzTa3KjjtrKoxSysln9Ir4nYa7+srksFyECU6GzPthEj
         v3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+dQ74IGfrppkgq8uzpNLYG02Y01S4fyeP5p+0FqjGhs=;
        b=Jtebp7q/w5ohk3s/wR5ZWEDscxzTWSqOhb4yEaV0qZCte+g/3CACGqriBYAsass8t/
         auNHxyD97cCdSdDiF1dXGWMcclO/Yz90Jjh9ky+roCXNAgaJfymL7Qk6V/4x1VMWqetT
         309VvU5uo55TBcIhi8b2yp0pM/hV9DghjFPRfKrt3I6nWh3PgiQKIIk/+/Qly4furAp5
         cPBoi7mg1by25SBckI0v5NJQZxOnfNVR5Sh9BE8XDvVxQLtpn1+/uet2mX1QHaZh/8Qy
         Jfzdtkd/QK7pM2ub9pb8WlZSl4jvSYmzs4wZYnOxLIXEBhOllIuRZKiOIFpcpoPFxnIp
         QrPg==
X-Gm-Message-State: ALoCoQkQZPNf/A63rV8EpiFI/u1bDYBvLvTM/wYpHQleIVtiqBVxPAkZu+32l/DcPy5oUodt6N7f
X-Received: by 10.68.211.131 with SMTP id nc3mr1237433pbc.159.1443664477999;
        Wed, 30 Sep 2015 18:54:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8d91:1679:adb7:b916])
        by smtp.gmail.com with ESMTPSA id te7sm3055349pbc.87.2015.09.30.18.54.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 30 Sep 2015 18:54:37 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.275.gf20166c.dirty
In-Reply-To: <1443664456-1307-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278876>

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
index ff5bc32..cf8bf5d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -654,10 +654,9 @@ static int fetch_finish(int retvalue, struct child_process *cp,
 
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
2.5.0.275.gf20166c.dirty
