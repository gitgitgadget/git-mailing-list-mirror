Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E76FA1F405
	for <e@80x24.org>; Tue, 18 Dec 2018 01:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbeLRBIP (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 20:08:15 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:48064 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbeLRBIP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 20:08:15 -0500
Received: by mail-pl1-f202.google.com with SMTP id a10so10590429plp.14
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 17:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=G52j0o7T/WxbXwKvnjr2MccLgBoBoyhG7eCdFP1qeF4=;
        b=EBQBDWzdk4/kwm3L4/EsMNzrZOE9ECLiQYD/1fd1OJZEO76qqGPXUQwToShmjCmknS
         GJiPhZdMX948bJiTLLJzmsRNdcSCk6kZCm8AUNPSgMIUJV5Z35ArzaTa6q8nWZ/HT1ax
         3gy9AWKqRrLEeEMFZ/NDsd2UkzfxlJORUOpDqdcoie6bGnnzcjXT0NE+lWmCVkxFl/87
         ynZsesPgGz0k3R0YOy1tzKxxRposm3Lw7skxBan2VR1fo+I9x0XU3X1TfJh4fmVEenDS
         IN9cwqp/4Qc3e2v5JJ2yJdSnLhBBzJm81C5jDQaO3QqHyq5FmXRxUPDw7w4LFRRkOSyr
         7sYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=G52j0o7T/WxbXwKvnjr2MccLgBoBoyhG7eCdFP1qeF4=;
        b=Bill870GGyV+zcCBquEqekJei1CRNunvWR4/Y0EbZg/7mKAtzV3TQjb9MtvsxA9WRn
         XdHFCE53aECrMxmvaFiRc9KZskSlt61DW1Gala30WZa2+gXUMZVrE2bx7rNUCmfB1g2E
         nFj2ga+HGnHYG0Yo7Ah/K/uAGjrqpV/W1IoHHn3mRYRW7yoALrXqIvdKC3q2kxaaO6Sz
         25XzW3Z6sy1vRR8CfT0LW2QCR7fXYLVaboopG0+sg2iRaj5ugpnOrT36ymLzPEuJxkNa
         BAOIq+yU3fPwmKYTHC+4yWV2bcjuAdJJCMjsB7zAgbdB63d5mSv5ySoWTEV6wgfxlc/G
         kHOA==
X-Gm-Message-State: AA+aEWaSo2WLB7qU6BLUPDxiXatlu1aHtZWdev2YrkeQaMwGI96OBI66
        bxTuwGyN3ZwUbjk0G+ohI7G6Uip+CcYGrtYhOfBcPy5y5QpdO9hIH9M5JqrP71/S7ibVlk8wynY
        oFtV2VHUocNwyzClH9pYt6Z/EUDBcCUy8I7sl/aXZGdWg2i5PejU2OV/Num/TjZzFkhAtyDBBpo
        +n
X-Google-Smtp-Source: AFSGD/XxfHi4ACaGlGvd+9pJPv9gl5nhpwWS+2XXiIf0FLNDnozW7chB4i6EyJd4DwLGF8z04q2GQV50bdM+zNaLTG9r
X-Received: by 2002:a63:36ce:: with SMTP id d197mr8395034pga.27.1545095294317;
 Mon, 17 Dec 2018 17:08:14 -0800 (PST)
Date:   Mon, 17 Dec 2018 17:08:11 -0800
Message-Id: <20181218010811.143608-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH] shallow: clear shallow cache when committing lock
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When setup_alternate_shallow() is invoked a second time in the same
process, it fails with the error "shallow file has changed since we read
it". One way of reproducing this is to fetch using protocol v2 in such a
way that backfill_tags() is required, and that the responses to both
requests contain a "shallow-info" section.

This is because when the shallow lock is committed, the stat information
of the shallow file is not cleared. Ensure that this information is
always cleared whenever the shallow lock is committed by introducing a
new API that hides the shallow lock behind a custom struct.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This was discovered with the help of Aevar's GIT_TEST_PROTOCOL_VERSION
patches.

If rebased onto Aevar's GIT_TEST_PROTOCOL_VERSION patches [1], all tests
still pass with GIT_TEST_PROTOCOL_VERSION=2 and without. Also, this
patch allows the following diff to be applied:

> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 8b1217ea26..8baa57cf84 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -791,7 +791,7 @@ test_expect_success 'shallow clone exclude tag two' '
>  '
>
>  test_expect_success 'fetch exclude tag one' '
> -       GIT_TEST_PROTOCOL_VERSION= git -C shallow12 fetch --shallow-exclude one origin &&
> +       git -C shallow12 fetch --shallow-exclude one origin &&
>         git -C shallow12 log --pretty=tformat:%s origin/master >actual &&
>         test_write_lines three two >expected &&
>         test_cmp expected actual

(There is still one more instance of GIT_TEST_PROTOCOL_VERSION in that
file that is still not fixed.)

I couldn't figure out if the test case included in this patch can be
reduced - if any one has any idea, help is appreciated.

I'm also not sure why this issue only occurs with protocol v2. It's true
that, when using protocol v0, the server can communicate shallow
information both before and after "want"s are received, and if shallow
communication is only communicated before, the client will invoke
setup_temporary_shallow() instead of setup_alternate_shallow(). (In
protocol v2, shallow information is always communicated after "want"s,
thus demonstrating the issue.) But even in protocol v0, writes to the
shallow file go through setup_alternate_shallow() anyway (in
update_shallow()), so I would think that the issue would occur, but it
doesn't.

[1] https://public-inbox.org/git/20181213155817.27666-1-avarab@gmail.com/
---
 builtin/receive-pack.c |  7 +++----
 commit.h               |  8 +++++++-
 fetch-pack.c           | 13 ++++++-------
 shallow.c              | 25 +++++++++++++++++++++----
 t/t5702-protocol-v2.sh | 16 ++++++++++++++++
 5 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 33187bd8e9..ab7bc5ceb1 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1,7 +1,6 @@
 #include "builtin.h"
 #include "repository.h"
 #include "config.h"
-#include "lockfile.h"
 #include "pack.h"
 #include "refs.h"
 #include "pkt-line.h"
@@ -864,7 +863,7 @@ static void refuse_unconfigured_deny_delete_current(void)
 static int command_singleton_iterator(void *cb_data, struct object_id *oid);
 static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 {
-	struct lock_file shallow_lock = LOCK_INIT;
+	struct shallow_lock shallow_lock;
 	struct oid_array extra = OID_ARRAY_INIT;
 	struct check_connected_options opt = CHECK_CONNECTED_INIT;
 	uint32_t mask = 1 << (cmd->index % 32);
@@ -881,12 +880,12 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 	opt.env = tmp_objdir_env(tmp_objdir);
 	setup_alternate_shallow(&shallow_lock, &opt.shallow_file, &extra);
 	if (check_connected(command_singleton_iterator, cmd, &opt)) {
-		rollback_lock_file(&shallow_lock);
+		rollback_shallow_lock(&shallow_lock);
 		oid_array_clear(&extra);
 		return -1;
 	}
 
-	commit_lock_file(&shallow_lock);
+	commit_shallow_lock(&shallow_lock);
 
 	/*
 	 * Make sure setup_alternate_shallow() for the next ref does
diff --git a/commit.h b/commit.h
index 98664536cb..233a30ceef 100644
--- a/commit.h
+++ b/commit.h
@@ -9,6 +9,7 @@
 #include "string-list.h"
 #include "pretty.h"
 #include "commit-slab.h"
+#include "lockfile.h"
 
 #define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
 #define GENERATION_NUMBER_INFINITY 0xFFFFFFFF
@@ -224,9 +225,14 @@ extern struct commit_list *get_shallow_commits_by_rev_list(
 extern void set_alternate_shallow_file(struct repository *r, const char *path, int override);
 extern int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
 				 const struct oid_array *extra);
-extern void setup_alternate_shallow(struct lock_file *shallow_lock,
+struct shallow_lock {
+	struct lock_file lock;
+};
+extern void setup_alternate_shallow(struct shallow_lock *shallow_lock,
 				    const char **alternate_shallow_file,
 				    const struct oid_array *extra);
+extern int commit_shallow_lock(struct shallow_lock *shallow_lock);
+extern void rollback_shallow_lock(struct shallow_lock *shallow_lock);
 extern const char *setup_temporary_shallow(const struct oid_array *extra);
 extern void advertise_shallow_grafts(int);
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 9691046e64..1ae1cf225a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1,7 +1,6 @@
 #include "cache.h"
 #include "repository.h"
 #include "config.h"
-#include "lockfile.h"
 #include "refs.h"
 #include "pkt-line.h"
 #include "commit.h"
@@ -34,7 +33,7 @@ static int fetch_fsck_objects = -1;
 static int transfer_fsck_objects = -1;
 static int agent_supported;
 static int server_supports_filtering;
-static struct lock_file shallow_lock;
+static struct shallow_lock shallow_lock;
 static const char *alternate_shallow_file;
 static char *negotiation_algorithm;
 static struct strbuf fsck_msg_types = STRBUF_INIT;
@@ -1512,9 +1511,9 @@ static void update_shallow(struct fetch_pack_args *args,
 	if (args->deepen && alternate_shallow_file) {
 		if (*alternate_shallow_file == '\0') { /* --unshallow */
 			unlink_or_warn(git_path_shallow(the_repository));
-			rollback_lock_file(&shallow_lock);
+			rollback_shallow_lock(&shallow_lock);
 		} else
-			commit_lock_file(&shallow_lock);
+			commit_shallow_lock(&shallow_lock);
 		return;
 	}
 
@@ -1537,7 +1536,7 @@ static void update_shallow(struct fetch_pack_args *args,
 			setup_alternate_shallow(&shallow_lock,
 						&alternate_shallow_file,
 						&extra);
-			commit_lock_file(&shallow_lock);
+			commit_shallow_lock(&shallow_lock);
 		}
 		oid_array_clear(&extra);
 		return;
@@ -1574,7 +1573,7 @@ static void update_shallow(struct fetch_pack_args *args,
 		setup_alternate_shallow(&shallow_lock,
 					&alternate_shallow_file,
 					&extra);
-		commit_lock_file(&shallow_lock);
+		commit_shallow_lock(&shallow_lock);
 		oid_array_clear(&extra);
 		oid_array_clear(&ref);
 		return;
@@ -1660,7 +1659,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 			error(_("remote did not send all necessary objects"));
 			free_refs(ref_cpy);
 			ref_cpy = NULL;
-			rollback_lock_file(&shallow_lock);
+			rollback_shallow_lock(&shallow_lock);
 			goto cleanup;
 		}
 		args->connectivity_checked = 1;
diff --git a/shallow.c b/shallow.c
index 02fdbfc554..0d39906419 100644
--- a/shallow.c
+++ b/shallow.c
@@ -333,22 +333,23 @@ const char *setup_temporary_shallow(const struct oid_array *extra)
 	return "";
 }
 
-void setup_alternate_shallow(struct lock_file *shallow_lock,
+void setup_alternate_shallow(struct shallow_lock *shallow_lock,
 			     const char **alternate_shallow_file,
 			     const struct oid_array *extra)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int fd;
 
-	fd = hold_lock_file_for_update(shallow_lock,
+	fd = hold_lock_file_for_update(&shallow_lock->lock,
 				       git_path_shallow(the_repository),
 				       LOCK_DIE_ON_ERROR);
 	check_shallow_file_for_update(the_repository);
 	if (write_shallow_commits(&sb, 0, extra)) {
 		if (write_in_full(fd, sb.buf, sb.len) < 0)
 			die_errno("failed to write to %s",
-				  get_lock_file_path(shallow_lock));
-		*alternate_shallow_file = get_lock_file_path(shallow_lock);
+				  get_lock_file_path(&shallow_lock->lock));
+		*alternate_shallow_file =
+			get_lock_file_path(&shallow_lock->lock);
 	} else
 		/*
 		 * is_repository_shallow() sees empty string as "no
@@ -358,6 +359,22 @@ void setup_alternate_shallow(struct lock_file *shallow_lock,
 	strbuf_release(&sb);
 }
 
+int commit_shallow_lock(struct shallow_lock *shallow_lock)
+{
+	int ret;
+
+	if ((ret = commit_lock_file(&shallow_lock->lock)))
+		return ret;
+	the_repository->parsed_objects->is_shallow = -1;
+	stat_validity_clear(the_repository->parsed_objects->shallow_stat);
+	return 0;
+}
+
+void rollback_shallow_lock(struct shallow_lock *shallow_lock)
+{
+	rollback_lock_file(&shallow_lock->lock);
+}
+
 static int advertise_shallow_grafts_cb(const struct commit_graft *graft, void *cb)
 {
 	int fd = *(int *)cb;
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 0f2b09ebb8..390a71399d 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -471,6 +471,22 @@ test_expect_success 'upload-pack respects client shallows' '
 	grep "fetch< version 2" trace
 '
 
+test_expect_success '2 fetches in one process updating shallow' '
+	rm -rf server client trace &&
+
+	test_create_repo server &&
+	test_commit -C server one &&
+	test_commit -C server two &&
+	test_commit -C server three &&
+	git clone --shallow-exclude two "file://$(pwd)/server" client &&
+
+	# Triggers tag following (thus, 2 fetches in one process)
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
+		fetch --shallow-exclude one origin &&
+	# Ensure that protocol v2 is used
+	grep "fetch< version 2" trace
+'
+
 # Test protocol v2 with 'http://' transport
 #
 . "$TEST_DIRECTORY"/lib-httpd.sh
-- 
2.19.0.271.gfe8321ec05.dirty

