Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCD221FAF4
	for <e@80x24.org>; Fri, 10 Feb 2017 07:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbdBJHUy (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 02:20:54 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:33143 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbdBJHUx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 02:20:53 -0500
Received: from homiemail-a12.g.dreamhost.com (sub3.mail.dreamhost.com [69.163.253.7])
        by hapkido.dreamhost.com (Postfix) with ESMTP id A1E2088ADA
        for <git@vger.kernel.org>; Thu,  9 Feb 2017 11:17:42 -0800 (PST)
Received: from homiemail-a12.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a12.g.dreamhost.com (Postfix) with ESMTP id B16BE26206C;
        Thu,  9 Feb 2017 11:17:30 -0800 (PST)
Received: from localhost.localdomain (gzac12-mdf2-1.aoa.twosigma.com [208.77.215.155])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a12.g.dreamhost.com (Postfix) with ESMTPSA id 34AD0262065;
        Thu,  9 Feb 2017 11:17:30 -0800 (PST)
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, pclouds@gmail.com,
        David Turner <dturner@twosigma.com>
Subject: [PATCH v2] gc: ignore old gc.log files
Date:   Thu,  9 Feb 2017 14:17:24 -0500
Message-Id: <20170209191724.3987-1-dturner@twosigma.com>
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
(by default) one day old.  It also learns about a config, gc.logExpiry
to manage this.  There is also some cleanup: a successful manual gc,
or a warning-free auto gc with an old log file, will remove any old
gc.log files.

So git should never get itself into a state where it refuses to do any
maintenance, just because at some point some piece of the maintenance
didn't make progress.  That might still happen (e.g. because the repo
is corrupt), but at the very least it won't be because Git is too dumb
to try again.

Signed-off-by: David Turner <dturner@twosigma.com>
Helped-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt |  5 +++++
 builtin/gc.c             | 42 +++++++++++++++++++++++++++++++++++-------
 t/t6500-gc.sh            | 13 +++++++++++++
 3 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fc5a28a32..2c2c9c75c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1402,6 +1402,11 @@ gc.autoDetach::
 	Make `git gc --auto` return immediately and run in background
 	if the system supports it. Default is true.
 
+gc.logExpiry::
+	If the file gc.log exists, then `git gc --auto` won't run
+	unless that file is more than 'gc.logExpiry' old.  Default is
+	"1.day".  See `gc.pruneExpire` for more possible values.
+
 gc.packRefs::
 	Running `git pack-refs` in a repository renders it
 	unclonable by Git versions prior to 1.5.1.2 over dumb
diff --git a/builtin/gc.c b/builtin/gc.c
index 331f21926..46edcff30 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -33,6 +33,7 @@ static int aggressive_window = 250;
 static int gc_auto_threshold = 6700;
 static int gc_auto_pack_limit = 50;
 static int detach_auto = 1;
+static unsigned long gc_log_expire_time;
 static const char *prune_expire = "2.weeks.ago";
 static const char *prune_worktrees_expire = "3.months.ago";
 
@@ -76,10 +77,12 @@ static void git_config_date_string(const char *key, const char **output)
 static void process_log_file(void)
 {
 	struct stat st;
-	if (!fstat(get_lock_file_fd(&log_lock), &st) && st.st_size)
+	if (!fstat(get_lock_file_fd(&log_lock), &st) && st.st_size) {
 		commit_lock_file(&log_lock);
-	else
+	} else {
+		unlink(git_path("gc.log"));
 		rollback_lock_file(&log_lock);
+	}
 }
 
 static void process_log_file_at_exit(void)
@@ -111,6 +114,11 @@ static void gc_config(void)
 	git_config_get_int("gc.auto", &gc_auto_threshold);
 	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
 	git_config_get_bool("gc.autodetach", &detach_auto);
+
+	if (!git_config_get_value("gc.logexpiry", &value)) {
+		parse_expiry_date(value, &gc_log_expire_time);
+	}
+
 	git_config_date_string("gc.pruneexpire", &prune_expire);
 	git_config_date_string("gc.worktreepruneexpire", &prune_worktrees_expire);
 	git_config(git_default_config, NULL);
@@ -290,19 +298,34 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 static int report_last_gc_error(void)
 {
 	struct strbuf sb = STRBUF_INIT;
-	int ret;
+	int ret = 0;
+	struct stat st;
+	char *gc_log_path = git_pathdup("gc.log");
 
-	ret = strbuf_read_file(&sb, git_path("gc.log"), 0);
+	if (stat(gc_log_path, &st)) {
+		if (errno == ENOENT)
+			goto done;
+
+		ret = error(_("Can't read %s"), gc_log_path);
+		goto done;
+	}
+
+	if (st.st_mtime < gc_log_expire_time)
+		goto done;
+
+	ret = strbuf_read_file(&sb, gc_log_path, 0);
 	if (ret > 0)
-		return error(_("The last gc run reported the following. "
+		ret = error(_("The last gc run reported the following. "
 			       "Please correct the root cause\n"
 			       "and remove %s.\n"
 			       "Automatic cleanup will not be performed "
 			       "until the file is removed.\n\n"
 			       "%s"),
-			     git_path("gc.log"), sb.buf);
+			    gc_log_path, sb.buf);
 	strbuf_release(&sb);
-	return 0;
+done:
+	free(gc_log_path);
+	return ret;
 }
 
 static int gc_before_repack(void)
@@ -349,6 +372,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	argv_array_pushl(&prune_worktrees, "worktree", "prune", "--expire", NULL);
 	argv_array_pushl(&rerere, "rerere", "gc", NULL);
 
+	/* default expiry time, overwritten in gc_config */
+	parse_expiry_date("1.day", &gc_log_expire_time);
 	gc_config();
 
 	if (pack_refs < 0)
@@ -448,5 +473,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		warning(_("There are too many unreachable loose objects; "
 			"run 'git prune' to remove them."));
 
+	if (!daemonized)
+		unlink(git_path("gc.log"));
+
 	return 0;
 }
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 1762dfa6a..84ad07eb2 100755
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
+	echo fleem >.git/gc.log &&
+	test_must_fail git gc --auto 2>err &&
+	test_i18ngrep "^error:" err &&
+	test-chmtime =-86401 .git/gc.log &&
+	git gc --auto
+'
 
 test_done
-- 
2.11.GIT

