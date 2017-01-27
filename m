Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 735AB1F6DC
	for <e@80x24.org>; Fri, 27 Jan 2017 10:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754814AbdA0KWD (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 05:22:03 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:60723 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754785AbdA0KVi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 05:21:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 31FF41E2D45;
        Fri, 27 Jan 2017 11:11:44 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5BXvNFzMUwFV; Fri, 27 Jan 2017 11:11:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 15AE11E2D65;
        Fri, 27 Jan 2017 11:11:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oUlehhgVVZbb; Fri, 27 Jan 2017 11:11:42 +0100 (CET)
Received: from localhost.localdomain (unknown [46.128.140.114])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 9F6291E2D45;
        Fri, 27 Jan 2017 11:11:42 +0100 (CET)
From:   cornelius.weig@tngtech.com
To:     gitster@pobox.com
Cc:     peff@peff.net, git@vger.kernel.org,
        Cornelius Weig <cornelius.weig@tngtech.com>
Subject: [PATCH v3 2/3] refs: add option core.logAllRefUpdates = always
Date:   Fri, 27 Jan 2017 11:09:47 +0100
Message-Id: <20170127100948.29408-2-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170127100948.29408-1-cornelius.weig@tngtech.com>
References: <xmqqvat11k1i.fsf@gitster.mtv.corp.google.com>
 <20170127100948.29408-1-cornelius.weig@tngtech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

When core.logallrefupdates is true, we only create a new reflog for refs
that are under certain well-known hierarchies. The reason is that we
know that some hierarchies (like refs/tags) are not meant to change, and
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
Reviewed-by: Jeff King <peff@peff.net>
---

Notes:
    Changes wrt v2:
    
     - change wording in commit message s/do not typically/are not meant to/;
     - in update_refs_for_switch move refname to the enclosing block, so that
       should_autocreate_reflog has access. Thanks Junio for spotting this
       potential bug early :)
     - add test that asserts reflogs are created for tags if
       logAllRefUpdates=always. The case with logAllRefUpdates=true is IMHO already
       covered by the default case. To make that clearer, I explicitly added
       logAllRefUpdates=true.
    
    When writing the test for git-tag, I realized that the option
    --no-create-reflog to git-tag does not take precedence over
    logAllRefUpdate=always. IOW the setting cannot be overridden on the command
    line. Do you think this is a defect or would it not be desirable to have this
    feature anyway?

 Documentation/config.txt  |  2 ++
 Documentation/git-tag.txt |  3 ++-
 branch.c                  |  2 +-
 builtin/checkout.c        |  7 +++----
 builtin/init-db.c         |  2 +-
 cache.h                   |  9 ++++++++-
 config.c                  |  7 ++++++-
 environment.c             |  2 +-
 refs.c                    | 15 ++++++++++-----
 refs.h                    |  2 ++
 refs/files-backend.c      |  6 +++---
 refs/refs-internal.h      |  2 --
 t/t1400-update-ref.sh     | 37 +++++++++++++++++++++++++++++++++++++
 t/t7004-tag.sh            |  8 ++++++++
 14 files changed, 84 insertions(+), 20 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c7d8a01..d1fab67 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -521,6 +521,8 @@ core.logAllRefUpdates::
 	file is automatically created for branch heads (i.e. under
 	`refs/heads/`), remote refs (i.e. under `refs/remotes/`),
 	note refs (i.e. under `refs/notes/`), and the symbolic ref `HEAD`.
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
diff --git a/builtin/checkout.c b/builtin/checkout.c
index bfe685c..81ea2ed 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -612,14 +612,12 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 	const char *old_desc, *reflog_msg;
 	if (opts->new_branch) {
 		if (opts->new_orphan_branch) {
-			if (opts->new_branch_log && !log_all_ref_updates) {
+			const char *refname = mkpathdup("refs/heads/%s", opts->new_orphan_branch);
+			if (opts->new_branch_log && should_autocreate_reflog(refname)) {
 				int ret;
-				char *refname;
 				struct strbuf err = STRBUF_INIT;
 
-				refname = mkpathdup("refs/heads/%s", opts->new_orphan_branch);
 				ret = safe_create_reflog(refname, 1, &err);
-				free(refname);
 				if (ret) {
 					fprintf(stderr, _("Can not do reflog for '%s': %s\n"),
 						opts->new_orphan_branch, err.buf);
@@ -628,6 +626,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 				}
 				strbuf_release(&err);
 			}
+			free(refname);
 		}
 		else
 			create_branch(opts->new_branch, new->name,
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
diff --git a/refs.h b/refs.h
index 6947843..9fbff90 100644
--- a/refs.h
+++ b/refs.h
@@ -64,6 +64,8 @@ int read_ref(const char *refname, unsigned char *sha1);
 
 int ref_exists(const char *refname);
 
+int should_autocreate_reflog(const char *refname);
+
 int is_branch(const char *refname);
 
 extern int refs_init_db(struct strbuf *err);
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
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 708b260..25444cf 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -133,8 +133,6 @@ int verify_refname_available(const char *newname,
  */
 int copy_reflog_msg(char *buf, const char *msg);
 
-int should_autocreate_reflog(const char *refname);
-
 /**
  * Information needed for a single ref update. Set new_sha1 to the new
  * value or to null_sha1 to delete the ref. To check the old value
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index d4fb977..b9084ca 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -93,6 +93,42 @@ test_expect_success 'update-ref creates reflogs with --create-reflog' '
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
+test_expect_success 'core.logAllRefUpdates=always creates no reflog for ORIG_HEAD' '
+	test_config core.logAllRefUpdates always &&
+	git update-ref ORIG_HEAD $A &&
+	test_must_fail git reflog exists ORIG_HEAD
+'
+
+test_expect_success '--no-create-reflog overrides core.logAllRefUpdates=always' '
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
@@ -501,6 +537,7 @@ test_expect_success 'stdin does not create reflogs by default' '
 '
 
 test_expect_success 'stdin creates reflogs with --create-reflog' '
+	test_when_finished "git update-ref -d $outside" &&
 	echo "create $outside $m" >stdin &&
 	git update-ref --create-reflog --stdin <stdin &&
 	git rev-parse $m >expect &&
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 1cfa8a2..1bf622d 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -71,6 +71,7 @@ test_expect_success 'creating a tag for an unknown revision should fail' '
 
 # commit used in the tests, test_tick is also called here to freeze the date:
 test_expect_success 'creating a tag using default HEAD should succeed' '
+	test_config core.logAllRefUpdates true &&
 	test_tick &&
 	echo foo >foo &&
 	git add foo &&
@@ -90,6 +91,13 @@ test_expect_success '--create-reflog does not create reflog on failure' '
 	test_must_fail git reflog exists refs/tags/mytag
 '
 
+test_expect_success 'option core.logAllRefUpdates=always creates reflog' '
+	test_when_finished "git tag -d tag_with_reflog" &&
+	test_config core.logAllRefUpdates always &&
+	git tag tag_with_reflog &&
+	git reflog exists refs/tags/tag_with_reflog
+'
+
 test_expect_success 'listing all tags if one exists should succeed' '
 	git tag -l &&
 	git tag
-- 
2.10.2

