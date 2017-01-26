Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA9BC1F6DC
	for <e@80x24.org>; Thu, 26 Jan 2017 01:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752382AbdAZBRV (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 20:17:21 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:29018 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752327AbdAZBRT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 20:17:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 2EC6B1E2CF8;
        Thu, 26 Jan 2017 02:17:16 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ndUhTHYsJnX5; Thu, 26 Jan 2017 02:17:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 2AE821E2D10;
        Thu, 26 Jan 2017 02:17:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id X4KaNCo4Ekqb; Thu, 26 Jan 2017 02:17:15 +0100 (CET)
Received: from localhost.localdomain (aftr-185-17-206-216.dynamic.mnet-online.de [185.17.206.216])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 817FF1E2CF8;
        Thu, 26 Jan 2017 02:17:14 +0100 (CET)
From:   cornelius.weig@tngtech.com
To:     peff@peff.net
Cc:     gitster@pobox.com, git@vger.kernel.org, novalis@novalis.org,
        pclouds@gmail.com, Cornelius Weig <cornelius.weig@tngtech.com>
Subject: [PATCH] refs: add option core.logAllRefUpdates = always
Date:   Thu, 26 Jan 2017 02:16:54 +0100
Message-Id: <20170126011654.21729-2-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170126011654.21729-1-cornelius.weig@tngtech.com>
References: <20170125213328.meehgxvzuajjgvag@sigill.intra.peff.net>
 <20170126011654.21729-1-cornelius.weig@tngtech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

When core.logallrefupdates is true, we only create a new reflog for refs
that are under certain well-known hierarchies. The reason is that we
know that some hierarchies (like refs/tags) do not typically change, and
that unknown hierarchies might not want reflogs at all (e.g., a
hypothetical refs/foo might be meant to change often and drop old
history immediately).

However, sometimes it is useful to override this decision and simply log
for all refs, because the safety and audit trail is more important than
the performance implications of keeping the log around.

This patch introduces a new "always" mode for the core.logallrefupdates
option which will log updates to everything under refs/, regardless
where in the hierarchy it is (we still will not log things like
ORIG_HEAD and FETCH_HEAD, which are known to be transient).

Based-on-patch-by: Jeff King <peff@peff.net>
Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
---
 Documentation/config.txt  |  7 +++++--
 Documentation/git-tag.txt |  3 ++-
 branch.c                  |  2 +-
 builtin/init-db.c         |  2 +-
 cache.h                   |  9 +++++++-
 config.c                  |  7 ++++++-
 environment.c             |  2 +-
 refs.c                    | 15 +++++++++-----
 refs/files-backend.c      |  6 +++---
 t/t1400-update-ref.sh     | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 90 insertions(+), 16 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index af2ae4c..2117616 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -517,10 +517,13 @@ core.logAllRefUpdates::
 	"`$GIT_DIR/logs/<ref>`", by appending the new and old
 	SHA-1, the date/time and the reason of the update, but
 	only when the file exists.  If this configuration
-	variable is set to true, missing "`$GIT_DIR/logs/<ref>`"
+	variable is set to `true`, missing "`$GIT_DIR/logs/<ref>`"
 	file is automatically created for branch heads (i.e. under
 	refs/heads/), remote refs (i.e. under refs/remotes/),
-	note refs (i.e. under refs/notes/), and the symbolic ref HEAD.
+	`refs/heads/`), remote refs (i.e. under `refs/remotes/`),
+	note refs (i.e. under `refs/notes/`), and the symbolic ref `HEAD`.
+	If it is set to `always`, then a missing reflog is automatically
+	created for any ref under `refs/`.
 +
 This information can be used to determine what commit
 was the tip of a branch "2 days ago".
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 5055a96..2ac25a9 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -150,7 +150,8 @@ This option is only applicable when listing tags without annotation lines.
 	'strip' removes both whitespace and commentary.
 
 --create-reflog::
-	Create a reflog for the tag.
+	Create a reflog for the tag. To globally enable reflogs for tags, see
+	`core.logAllRefUpdates` in linkgit:git-config[1].
 
 <tagname>::
 	The name of the tag to create, delete, or describe.
diff --git a/branch.c b/branch.c
index c431cbf..b955d4f 100644
--- a/branch.c
+++ b/branch.c
@@ -298,7 +298,7 @@ void create_branch(const char *name, const char *start_name,
 			 start_name);
 
 	if (reflog)
-		log_all_ref_updates = 1;
+		log_all_ref_updates = LOG_REFS_NORMAL;
 
 	if (!dont_change_ref) {
 		struct ref_transaction *transaction;
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 76d68fa..1d4d6a0 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -262,7 +262,7 @@ static int create_default_files(const char *template_path,
 		const char *work_tree = get_git_work_tree();
 		git_config_set("core.bare", "false");
 		/* allow template config file to override the default */
-		if (log_all_ref_updates == -1)
+		if (log_all_ref_updates == LOG_REFS_UNSET)
 			git_config_set("core.logallrefupdates", "true");
 		if (needs_work_tree_config(original_git_dir, work_tree))
 			git_config_set("core.worktree", work_tree);
diff --git a/cache.h b/cache.h
index 00a029a..96eeaaf 100644
--- a/cache.h
+++ b/cache.h
@@ -660,7 +660,6 @@ extern int minimum_abbrev, default_abbrev;
 extern int ignore_case;
 extern int assume_unchanged;
 extern int prefer_symlink_refs;
-extern int log_all_ref_updates;
 extern int warn_ambiguous_refs;
 extern int warn_on_object_refname_ambiguity;
 extern const char *apply_default_whitespace;
@@ -728,6 +727,14 @@ enum hide_dotfiles_type {
 };
 extern enum hide_dotfiles_type hide_dotfiles;
 
+enum log_refs_config {
+	LOG_REFS_UNSET = -1,
+	LOG_REFS_NONE = 0,
+	LOG_REFS_NORMAL,
+	LOG_REFS_ALWAYS
+};
+extern enum log_refs_config log_all_ref_updates;
+
 enum branch_track {
 	BRANCH_TRACK_UNSPECIFIED = -1,
 	BRANCH_TRACK_NEVER = 0,
diff --git a/config.c b/config.c
index b680f79..c6b874a 100644
--- a/config.c
+++ b/config.c
@@ -826,7 +826,12 @@ static int git_default_core_config(const char *var, const char *value)
 	}
 
 	if (!strcmp(var, "core.logallrefupdates")) {
-		log_all_ref_updates = git_config_bool(var, value);
+		if (value && !strcasecmp(value, "always"))
+			log_all_ref_updates = LOG_REFS_ALWAYS;
+		else if (git_config_bool(var, value))
+			log_all_ref_updates = LOG_REFS_NORMAL;
+		else
+			log_all_ref_updates = LOG_REFS_NONE;
 		return 0;
 	}
 
diff --git a/environment.c b/environment.c
index 8a83101..c07fb17 100644
--- a/environment.c
+++ b/environment.c
@@ -21,7 +21,6 @@ int ignore_case;
 int assume_unchanged;
 int prefer_symlink_refs;
 int is_bare_repository_cfg = -1; /* unspecified */
-int log_all_ref_updates = -1; /* unspecified */
 int warn_ambiguous_refs = 1;
 int warn_on_object_refname_ambiguity = 1;
 int ref_paranoia = -1;
@@ -64,6 +63,7 @@ int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
 enum hide_dotfiles_type hide_dotfiles = HIDE_DOTFILES_DOTGITONLY;
+enum log_refs_config log_all_ref_updates = LOG_REFS_UNSET;
 
 #ifndef PROTECT_HFS_DEFAULT
 #define PROTECT_HFS_DEFAULT 0
diff --git a/refs.c b/refs.c
index 9bd0bc1..cd36b64 100644
--- a/refs.c
+++ b/refs.c
@@ -638,12 +638,17 @@ int copy_reflog_msg(char *buf, const char *msg)
 
 int should_autocreate_reflog(const char *refname)
 {
-	if (!log_all_ref_updates)
+	switch (log_all_ref_updates) {
+	case LOG_REFS_ALWAYS:
+		return 1;
+	case LOG_REFS_NORMAL:
+		return starts_with(refname, "refs/heads/") ||
+			starts_with(refname, "refs/remotes/") ||
+			starts_with(refname, "refs/notes/") ||
+			!strcmp(refname, "HEAD");
+	default:
 		return 0;
-	return starts_with(refname, "refs/heads/") ||
-		starts_with(refname, "refs/remotes/") ||
-		starts_with(refname, "refs/notes/") ||
-		!strcmp(refname, "HEAD");
+	}
 }
 
 int is_branch(const char *refname)
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f902393..14b17a6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2682,7 +2682,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 	}
 
 	flag = log_all_ref_updates;
-	log_all_ref_updates = 0;
+	log_all_ref_updates = LOG_REFS_NONE;
 	if (write_ref_to_lockfile(lock, orig_sha1, &err) ||
 	    commit_ref_update(refs, lock, orig_sha1, NULL, &err)) {
 		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
@@ -2835,8 +2835,8 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
 {
 	int logfd, result, oflags = O_APPEND | O_WRONLY;
 
-	if (log_all_ref_updates < 0)
-		log_all_ref_updates = !is_bare_repository();
+	if (log_all_ref_updates == LOG_REFS_UNSET)
+		log_all_ref_updates = is_bare_repository() ? LOG_REFS_NONE : LOG_REFS_NORMAL;
 
 	result = log_ref_setup(refname, logfile, err, flags & REF_FORCE_CREATE_REFLOG);
 
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index d4fb977..a920559 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -93,6 +93,36 @@ test_expect_success 'update-ref creates reflogs with --create-reflog' '
 	git reflog exists $outside
 '
 
+test_expect_success 'core.logAllRefUpdates=true does not create reflog by default' '
+	test_config core.logAllRefUpdates true &&
+	test_when_finished "git update-ref -d $outside" &&
+	git update-ref $outside $A &&
+	git rev-parse $A >expect &&
+	git rev-parse $outside >actual &&
+	test_cmp expect actual &&
+	test_must_fail git reflog exists $outside
+'
+
+test_expect_success 'core.logAllRefUpdates=always creates reflog by default' '
+	test_config core.logAllRefUpdates always &&
+	test_when_finished "git update-ref -d $outside" &&
+	git update-ref $outside $A &&
+	git rev-parse $A >expect &&
+	git rev-parse $outside >actual &&
+	test_cmp expect actual &&
+	git reflog exists $outside
+'
+
+test_expect_success 'update-ref does not create reflog with --no-create-reflog if core.logAllRefUpdates=always' '
+	test_config core.logAllRefUpdates true &&
+	test_when_finished "git update-ref -d $outside" &&
+	git update-ref --no-create-reflog $outside $A &&
+	git rev-parse $A >expect &&
+	git rev-parse $outside >actual &&
+	test_cmp expect actual &&
+	test_must_fail git reflog exists $outside
+'
+
 test_expect_success \
 	"create $m (by HEAD)" \
 	"git update-ref HEAD $A &&
@@ -501,6 +531,7 @@ test_expect_success 'stdin does not create reflogs by default' '
 '
 
 test_expect_success 'stdin creates reflogs with --create-reflog' '
+	test_when_finished "git update-ref -d $outside" &&
 	echo "create $outside $m" >stdin &&
 	git update-ref --create-reflog --stdin <stdin &&
 	git rev-parse $m >expect &&
@@ -509,6 +540,28 @@ test_expect_success 'stdin creates reflogs with --create-reflog' '
 	git reflog exists $outside
 '
 
+test_expect_success 'stdin does not create reflog when core.logAllRefUpdates=true' '
+	test_config core.logAllRefUpdates true &&
+	test_when_finished "git update-ref -d $outside" &&
+	echo "create $outside $m" >stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $outside >actual &&
+	test_cmp expect actual &&
+	test_must_fail git reflog exists $outside
+'
+
+test_expect_success 'stdin creates reflog when core.logAllRefUpdates=always' '
+	test_config core.logAllRefUpdates always &&
+	test_when_finished "git update-ref -d $outside" &&
+	echo "create $outside $m" >stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $outside >actual &&
+	test_cmp expect actual &&
+	git reflog exists $outside
+'
+
 test_expect_success 'stdin succeeds with quoted argument' '
 	git update-ref -d $a &&
 	echo "create $a \"$m\"" >stdin &&
-- 
2.10.2

