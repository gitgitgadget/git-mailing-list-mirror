Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2ACD1FAF4
	for <e@80x24.org>; Thu,  9 Feb 2017 02:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751226AbdBICEm (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 21:04:42 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:47566 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdBICEk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 21:04:40 -0500
Received: from homiemail-a12.g.dreamhost.com (sub3.mail.dreamhost.com [69.163.253.7])
        by hapkido.dreamhost.com (Postfix) with ESMTP id 03DC89DC3D
        for <git@vger.kernel.org>; Wed,  8 Feb 2017 18:03:36 -0800 (PST)
Received: from homiemail-a12.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a12.g.dreamhost.com (Postfix) with ESMTP id 24C35262062;
        Wed,  8 Feb 2017 18:02:35 -0800 (PST)
Received: from localhost.localdomain (gzac12-mdf2-1.aoa.twosigma.com [208.77.215.155])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a12.g.dreamhost.com (Postfix) with ESMTPSA id 953B0262065;
        Wed,  8 Feb 2017 18:02:34 -0800 (PST)
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, pclouds@gmail.com,
        David Turner <dturner@twosigma.com>
Subject: [PATCH] gc: ignore old gc.log files
Date:   Wed,  8 Feb 2017 21:02:22 -0500
Message-Id: <20170209020222.23642-1-dturner@twosigma.com>
X-Mailer: git-send-email 2.11.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The intent of automatic gc is to have a git repository be relatively
low-maintenance from a server-operator perspective.  Of course, large
operators like GitHub will need a more complicated management strategy,
but for ordinary usage, git should just work.

In this commit, git learns to ignore gc.log files which are older than
(by default) one day old.  It also learns about a config, gc.maxLogAge
to manage this.

So git should never get itself into a state where it refuses to do any
maintenance, just because at some point some piece of the maintenance
didn't make progress.  That might still happen (e.g. because the repo
is corrupt), but at the very least it won't be because Git is too dumb
to try again.

Signed-off-by: David Turner <dturner@twosigma.com>
Helped-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt |  5 +++++
 builtin/gc.c             | 15 ++++++++++++++-
 t/t6500-gc.sh            | 13 +++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fc5a28a32..6751371cf 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1402,6 +1402,11 @@ gc.autoDetach::
 	Make `git gc --auto` return immediately and run in background
 	if the system supports it. Default is true.
 
+gc.maxLogAge::
+	If the file gc.log exists, then `git gc --auto` won't run
+	unless that file is more than maxLogAge seconds old.  Default
+	is 86400, one day.
+
 gc.packRefs::
 	Running `git pack-refs` in a repository renders it
 	unclonable by Git versions prior to 1.5.1.2 over dumb
diff --git a/builtin/gc.c b/builtin/gc.c
index 331f21926..62fc84815 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -33,6 +33,7 @@ static int aggressive_window = 250;
 static int gc_auto_threshold = 6700;
 static int gc_auto_pack_limit = 50;
 static int detach_auto = 1;
+static int gc_max_log_age_seconds = 86400;
 static const char *prune_expire = "2.weeks.ago";
 static const char *prune_worktrees_expire = "3.months.ago";
 
@@ -111,6 +112,7 @@ static void gc_config(void)
 	git_config_get_int("gc.auto", &gc_auto_threshold);
 	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
 	git_config_get_bool("gc.autodetach", &detach_auto);
+	git_config_get_int("gc.maxlogage", &gc_max_log_age_seconds);
 	git_config_date_string("gc.pruneexpire", &prune_expire);
 	git_config_date_string("gc.worktreepruneexpire", &prune_worktrees_expire);
 	git_config(git_default_config, NULL);
@@ -291,8 +293,19 @@ static int report_last_gc_error(void)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int ret;
+	struct stat st;
+	const char *gc_log_path = git_path("gc.log");
+
+	if (stat(gc_log_path, &st)) {
+		if (errno == ENOENT)
+			return 0;
+		return error(_("Can't read %s"), gc_log_path);
+	}
+
+	if (time(NULL) - st.st_mtime > gc_max_log_age_seconds)
+		return 0;
 
-	ret = strbuf_read_file(&sb, git_path("gc.log"), 0);
+	ret = strbuf_read_file(&sb, gc_log_path, 0);
 	if (ret > 0)
 		return error(_("The last gc run reported the following. "
 			       "Please correct the root cause\n"
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 1762dfa6a..b69c2c190 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -67,5 +67,18 @@ test_expect_success 'auto gc with too many loose objects does not attempt to cre
 	test_line_count = 2 new # There is one new pack and its .idx
 '
 
+test_expect_success 'background auto gc does not run if gc.log is present and recent but does if it is old' '
+	keep=$(ls .git/objects/pack/*.pack|head -1|sed -e "s/pack$/keep/") &&
+	test_commit foo &&
+	test_commit bar &&
+	git repack &&
+	test_config gc.autopacklimit 1 &&
+	test_config gc.autodetach true &&
+	echo fleem> .git/gc.log &&
+	test_must_fail git gc --auto 2>err &&
+	test_i18ngrep "^error:" err &&
+	test-chmtime =-86401 .git/gc.log &&
+	git gc --auto
+'
 
 test_done
-- 
2.11.GIT

