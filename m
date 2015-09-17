From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 05/10] submodules: Allow parallel fetching, add tests and documentation
Date: Wed, 16 Sep 2015 18:39:03 -0700
Message-ID: <1442453948-9885-6-git-send-email-sbeller@google.com>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 03:39:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcOAl-0006Ku-SE
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 03:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbbIQBjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 21:39:23 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35244 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138AbbIQBjT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 21:39:19 -0400
Received: by pacfv12 with SMTP id fv12so4743686pac.2
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 18:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AA94HuRzVB6YAO8phudGM8ITvNrsayq+4SQUCisG5cI=;
        b=O5NV2BD3iUn+jbuuTnDpIJ4Txf9pAeXRP2BjkQcsOdQt0UvbKNtWTIUfiwILcR6TUp
         33zc0VIuc8U3fDv8SltMLLw8SekxrkjuyM7+QCWcqK7RK7nsgUNIQhROjt8I19ecON1G
         pHVr001hq94WfJTMWr8lwySsH0xu5TAEry3OKeJiv4VDlFoLNHHm8Wp5ZaOcyo/ZWA7l
         uVmZL3glQSU61WBxbr8M3MEboRgIVye/3FSwSwy+E6+N5VtbcMT+gM7cBUxNsdyFhQC9
         M9zgQcr6O7pfnrhtTY+q8jQ8i31AG6mkDKNAufpk916uoErf0UClrXXE8P+xE4WYZEei
         21rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AA94HuRzVB6YAO8phudGM8ITvNrsayq+4SQUCisG5cI=;
        b=QJ5oFyxlIvr609xRUdES28pd4/52qLuQzkMUNb9JLwRDpczWqoYh5cRIGhFPptqZH+
         75hyOnjtyb8sIRvEP6KO5yNYWSOrSK+iVlq8lm/tmSJGOy/QwmmmHiYEFsu0Wby4nVGB
         /Rt/PvccRKOvP758o+qrWbK+dcitnVxaXQz/p5peQQJbNYOlRir2DNcO/8KL5eZ8EE+C
         XL31SzCiIK5733FK2awjvD8RQrT88qktG8IhPLmQafQ0Mb8kX0QL/KRA7pr6MzBfzmOF
         0k37KowvqbMKuTy8UZ8XvbOoW7flphUvG/wNY/mSeMMpZhTS0ENpaC2RJnmiUVna64Ka
         Sc2w==
X-Gm-Message-State: ALoCoQlIBRJLm6VQM66Wg5rQSzdLmJWKfQl13gMsqKOYZV/CkEX7OrTawRFBchuG9gW43mxVGcS9
X-Received: by 10.66.254.166 with SMTP id aj6mr54493807pad.34.1442453959119;
        Wed, 16 Sep 2015 18:39:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:bde9:6711:470f:789])
        by smtp.gmail.com with ESMTPSA id fm5sm565166pab.24.2015.09.16.18.39.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 18:39:18 -0700 (PDT)
X-Mailer: git-send-email 2.6.0.rc0.131.gf624c3d
In-Reply-To: <1442453948-9885-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278097>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/fetch-options.txt |  7 +++++++
 builtin/fetch.c                 |  5 ++++-
 builtin/pull.c                  |  6 ++++++
 t/t5526-fetch-submodules.sh     | 19 +++++++++++++++++++
 4 files changed, 36 insertions(+), 1 deletion(-)

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
index 6620ed0..f28eac6 100644
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
@@ -1218,7 +1221,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 						    submodule_prefix,
 						    recurse_submodules,
 						    verbosity < 0,
-						    0);
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
2.6.0.rc0.131.gf624c3d
