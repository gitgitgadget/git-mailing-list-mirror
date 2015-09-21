From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 08/13] submodules: allow parallel fetching, add tests and documentation
Date: Mon, 21 Sep 2015 15:39:14 -0700
Message-ID: <1442875159-13027-9-git-send-email-sbeller@google.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 00:40:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze9ko-0007AG-UK
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 00:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933067AbbIUWkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 18:40:00 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33066 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932998AbbIUWje (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 18:39:34 -0400
Received: by pacex6 with SMTP id ex6so128685681pac.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 15:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gsPqQISND60REjRGJptJqtQwMaaex4/Fi8cvesplnxs=;
        b=A1q11RHPeRoap1lWdfjarSn9RQnUXoow1QbnLEc/9nP7CbqZOsZ47jlnCWPkP+7Di1
         ImQXhnsg1v7F5YzNdbFOd+U/N0T3sBl/6ZjwRQG3sbx7sX3UmbNiNu+oxM9MZ0iqvRAb
         g81xbV/QGolB/dFBAjwfoe+lvxRZ0vcrUqYn64R/1Goum43UAI/FWOJPaACbunyWKXUA
         O1mGD9PLxkGhru4sdwbFoWDxTXUq74rg0lDw0koXwuyXzDdAgRe4wwojdoYJ+5borW+R
         //ZpLsnpZJ2ysD1Jm0Epk24aRc/n1q/5k43z8qyuhX18wK59HgcuObzgeHp3OFoqQASD
         IALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gsPqQISND60REjRGJptJqtQwMaaex4/Fi8cvesplnxs=;
        b=iII8yZwoChhCFw2P6zT5qvjwG0Llfajjem5K1bNeo96ehvEJqm5G2rYdbOw4NGLpG4
         00gLoOp8AQPndKFaRQSWHRVJcBcBf5PEz+QGUaRigLOSg/xTfrqL0ndrUcXzKoloKm3h
         a/Setyn7vfgnA7Sm+8b63Ap9KttVdoHXVi0y3/UUDBAWAWsgZlGDrslP8QN1rCE/o/Pw
         3527yin/fdwfFxX2Ei3AU3n/SE04NlbGDdkMXgpisOCMzU2vi7bQ7aFOEgpxH3h8P6NP
         X96BFzH7o58Y6cHhq5DnUhRIS/ovQ2DoSLioWFD2D/tAbDLsTKN52IrhKFZQqmnThMdN
         xnOg==
X-Gm-Message-State: ALoCoQmE/Ao8Oe2c59bpoQu4+fxWX3CoBh9Uuj9ZCZOov1qNRp8U9KSbkAY2jtFdQacCvCEwsOzf
X-Received: by 10.66.242.138 with SMTP id wq10mr11379526pac.2.1442875174438;
        Mon, 21 Sep 2015 15:39:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:a032:5a54:ea65:75ca])
        by smtp.gmail.com with ESMTPSA id jv5sm26467192pbc.47.2015.09.21.15.39.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 21 Sep 2015 15:39:33 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.275.ge015d2a
In-Reply-To: <1442875159-13027-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278348>

This enables the work of the previous patches.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/fetch-options.txt |  7 +++++++
 builtin/fetch.c                 |  5 ++++-
 builtin/pull.c                  |  6 ++++++
 submodule.c                     |  4 ++--
 t/t5526-fetch-submodules.sh     | 19 +++++++++++++++++++
 5 files changed, 38 insertions(+), 3 deletions(-)

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
diff --git a/submodule.c b/submodule.c
index a0e06e8..d15364f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -759,10 +759,10 @@ int get_next_submodule(void *data, struct child_process *cp,
 		strbuf_release(&submodule_prefix);
 		if (ret) {
 			spf->count++;
-			return 0;
+			return 1;
 		}
 	}
-	return 1;
+	return 0;
 }
 
 unsigned is_submodule_modified(const char *path, int ignore_untracked)
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
2.5.0.275.ge015d2a
