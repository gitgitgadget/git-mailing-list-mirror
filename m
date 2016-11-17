Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80AC31FF40
	for <e@80x24.org>; Thu, 17 Nov 2016 18:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932790AbcKQSqW (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 13:46:22 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34761 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752673AbcKQSqU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 13:46:20 -0500
Received: by mail-pg0-f42.google.com with SMTP id x23so91272503pgx.1
        for <git@vger.kernel.org>; Thu, 17 Nov 2016 10:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IG+CaJV/EbKZaX6LLNnZAFv12d5VcVgwKhuRZ8EPZ7o=;
        b=ScHxLmk6ORePoIG+euLkSeKh2ZGjOlMs/l0P9fLvwNiqZ9h0umsFHWHAaBIkSPW9He
         F5+LrKtMH4u8zHZV3DFFpP50MetahlcGHcNtVVWPelQfnGxhKfYlQOOu1sESZlEkrh4e
         6KXFMI4j2n16fQzf3sETILyp7f9DBjdFBnE4hXVFN/wbkH8x5QI8xqQft6rYVeCrxan5
         flretC4mCawZcav34aQDl0paHGhe6cdfZZRm1XQfONA2gdULnSBbuDJsOvvY4Y+XIKro
         4uSgY/AgdX2kXTLm4RQAf6G8lm1vkZ+Uj6hzHS68GR5q377I4dROtpMyza59UJxjmhYy
         cwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IG+CaJV/EbKZaX6LLNnZAFv12d5VcVgwKhuRZ8EPZ7o=;
        b=a4aAWaMI+qnpwTrGckFWZSNsUTYZex9olkZgj8PzXoNoLaE7VOsUOsjHfGDjCP2dX+
         9pgujJdUjFwO+av8vRDuFkShBiuN86+1jdtpaseZRA7SV83oawNvR5Z6/6Ks5x5WCCxs
         SHZMgCAc1G5NkSDmRbyXBaADB21RoKwF3dXC9bZbxYbmpGBujZSfyVOWB/DdQU7ciWJl
         veNBUy0z5j2IR+NfE9TvlTwURIcawPJgJU/gYxbx4zfGInqC64MnZH6YkwzogelPLy4z
         NZakwjW6KpGCrmbiY6ZVBieXE1WoQU3IUyODZntRNdBJMUXhOFryc9FuusoUsww7oAKa
         qthw==
X-Gm-Message-State: ABUngveCjmochl7L31/mxswteX30xql9Zn08cTwjPPMmfV1inNqHEPs94p18LxIR8stRj9od
X-Received: by 10.99.219.21 with SMTP id e21mr10212766pgg.136.1479408379365;
        Thu, 17 Nov 2016 10:46:19 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id u23sm9898946pfg.86.2016.11.17.10.46.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Nov 2016 10:46:18 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, hvoigt@hvoigt.net,
        sbeller@google.com, j6t@kdbg.org
Subject: [PATCH v2 2/2] push: fix --dry-run to not push submodules
Date:   Thu, 17 Nov 2016 10:46:04 -0800
Message-Id: <1479408364-150268-3-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1479408364-150268-1-git-send-email-bmwill@google.com>
References: <1479172735-698-1-git-send-email-bmwill@google.com>
 <1479408364-150268-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach push to respect the --dry-run option when configured to
recursively push submodules 'on-demand'.  This is done by passing the
--dry-run flag to the child process which performs a push for a
submodules when performing a dry-run.

In order to preserve good user experience, the additional check for
unpushed submodules is skipped during a dry-run when
--recurse-submodules=on-demand.  The check is skipped because the submodule
pushes were performed as dry-runs and this check would always fail as the
submodules would still need to be pushed.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c                    | 13 ++++++++-----
 submodule.h                    |  4 +++-
 t/t5531-deep-submodule-push.sh |  2 +-
 transport.c                    | 11 +++++++----
 4 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/submodule.c b/submodule.c
index b509488..de20588 100644
--- a/submodule.c
+++ b/submodule.c
@@ -683,16 +683,17 @@ int find_unpushed_submodules(struct sha1_array *commits,
 	return needs_pushing->nr;
 }
 
-static int push_submodule(const char *path)
+static int push_submodule(const char *path, int dry_run)
 {
 	if (add_submodule_odb(path))
 		return 1;
 
 	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
 		struct child_process cp = CHILD_PROCESS_INIT;
-		const char *argv[] = {"push", NULL};
+		argv_array_push(&cp.args, "push");
+		if (dry_run)
+			argv_array_push(&cp.args, "--dry-run");
 
-		cp.argv = argv;
 		prepare_submodule_repo_env(&cp.env_array);
 		cp.git_cmd = 1;
 		cp.no_stdin = 1;
@@ -705,7 +706,9 @@ static int push_submodule(const char *path)
 	return 1;
 }
 
-int push_unpushed_submodules(struct sha1_array *commits, const char *remotes_name)
+int push_unpushed_submodules(struct sha1_array *commits,
+			     const char *remotes_name,
+			     int dry_run)
 {
 	int i, ret = 1;
 	struct string_list needs_pushing = STRING_LIST_INIT_DUP;
@@ -716,7 +719,7 @@ int push_unpushed_submodules(struct sha1_array *commits, const char *remotes_nam
 	for (i = 0; i < needs_pushing.nr; i++) {
 		const char *path = needs_pushing.items[i].string;
 		fprintf(stderr, "Pushing submodule '%s'\n", path);
-		if (!push_submodule(path)) {
+		if (!push_submodule(path, dry_run)) {
 			fprintf(stderr, "Unable to push submodule '%s'\n", path);
 			ret = 0;
 		}
diff --git a/submodule.h b/submodule.h
index 9454806..23d7668 100644
--- a/submodule.h
+++ b/submodule.h
@@ -65,7 +65,9 @@ int merge_submodule(unsigned char result[20], const char *path, const unsigned c
 		    const unsigned char a[20], const unsigned char b[20], int search);
 int find_unpushed_submodules(struct sha1_array *commits, const char *remotes_name,
 		struct string_list *needs_pushing);
-int push_unpushed_submodules(struct sha1_array *commits, const char *remotes_name);
+extern int push_unpushed_submodules(struct sha1_array *commits,
+				    const char *remotes_name,
+				    int dry_run);
 void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
 int parallel_submodules(void);
 
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 7840032..1524ff5 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -431,7 +431,7 @@ test_expect_success 'push unpushable submodule recursively fails' '
 	test_cmp expected actual
 '
 
-test_expect_failure 'push --dry-run does not recursively update submodules' '
+test_expect_success 'push --dry-run does not recursively update submodules' '
 	(
 		cd work/gar/bage &&
 		git checkout master &&
diff --git a/transport.c b/transport.c
index c3fdd5d..940b75d 100644
--- a/transport.c
+++ b/transport.c
@@ -921,15 +921,18 @@ int transport_push(struct transport *transport,
 				if (!is_null_oid(&ref->new_oid))
 					sha1_array_append(&commits, ref->new_oid.hash);
 
-			if (!push_unpushed_submodules(&commits, transport->remote->name)) {
+			if (!push_unpushed_submodules(&commits,
+						      transport->remote->name,
+						      pretend)) {
 				sha1_array_clear(&commits);
-				die("Failed to push all needed submodules!");
+				die ("Failed to push all needed submodules!");
 			}
 			sha1_array_clear(&commits);
 		}
 
-		if ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
-			      TRANSPORT_RECURSE_SUBMODULES_CHECK)) && !is_bare_repository()) {
+		if (((flags & TRANSPORT_RECURSE_SUBMODULES_CHECK) ||
+		     ((flags & TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND) &&
+		      !pretend)) && !is_bare_repository()) {
 			struct ref *ref = remote_refs;
 			struct string_list needs_pushing = STRING_LIST_INIT_DUP;
 			struct sha1_array commits = SHA1_ARRAY_INIT;
-- 
2.8.0.rc3.226.g39d4020

