Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A4AF1F78F
	for <e@80x24.org>; Mon,  1 May 2017 18:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750914AbdEASBR (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 14:01:17 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34111 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbdEASBL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 14:01:11 -0400
Received: by mail-pg0-f53.google.com with SMTP id v1so48102581pgv.1
        for <git@vger.kernel.org>; Mon, 01 May 2017 11:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DHKcWVWGCchWD4zE+8Nn1jgDr2IxKNuRlsiJS1tQvec=;
        b=NdN11ZKwlOjvpduv4sFlTbp89LO91sqpOyepwDKU4h8ecVDfgmjKZDhJYANwxdJUJc
         kzQfg7lGBZP+H9BrQoZyeTTcptiE+Yq9ExH+ukbVFGenMvAwuDedsjErCf6Ib/COR2dF
         +NM4W9h2C6CH6ZExpyjekY/Es9oMX6gopGcrbbFk46+bwToC3LhhLRkhmDvpIaME0zES
         0Fui6Hhpt/4oF4XN/40ZoRdfRXhjk/Sq1pY5rmv5Yw1cJIok7jlc/mAJZ/gT+1J7Q7a4
         1BK9VnVdzlDNRVyR2ZWK5/9u2vd3qnDLay8q+j8oRJ7gK2ObLazIdnbPlnxAM4xht3QP
         mSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DHKcWVWGCchWD4zE+8Nn1jgDr2IxKNuRlsiJS1tQvec=;
        b=GC47421TvrA77GCSEGa5u4vEGLN8kPsn0mnUP7zyWIVtQTLnfPmAVqKlMQ6Z4SXRMg
         7DoiZMNiIMGGoYNqdkEEzFTAlu21xlhZZm2uzJM4VFuZ3uB8zz/BwLDf4gGkCGJNETha
         z2L365wOq3tqE8J724ul3fvasPXMpl+jPP3Zq0CZPylIwE2sk9DxDPVB7bHQEu/cSzyU
         4Kl3PNJCUaLC7bTM8NeMHTSBHOjG0JzV3eXaYYF83Ll18fkgAdiUGegdrRcrfHPpTqSI
         NxITFIElBYJWORlhUdP+T77xaaZMPhbcaOqgdnqtYg9I8Ab4vD8MZ6JEunZ5aUnHoOny
         1elw==
X-Gm-Message-State: AN3rC/54Y0rkhX+52WxgN6e5HFkAhS+R1VtLc1xKiybYlAiLCFdZ9vYd
        I1J6tOw5xhvOgzLOwY1Cww==
X-Received: by 10.98.21.87 with SMTP id 84mr6093295pfv.71.1493661670869;
        Mon, 01 May 2017 11:01:10 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c4be:9746:6a14:c7a4])
        by smtp.gmail.com with ESMTPSA id v187sm23403835pgv.18.2017.05.01.11.01.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 11:01:10 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jrnieder@gmail.com, bmwill@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH 4/5] submodule--helper: reattach-HEAD
Date:   Mon,  1 May 2017 11:00:57 -0700
Message-Id: <20170501180058.8063-5-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.1.gbc33f0f778
In-Reply-To: <20170501180058.8063-1-sbeller@google.com>
References: <20170501180058.8063-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new command, that reattaches a detached HEAD to its configured
branch in a submodule.

In a later patch we will teach git-submodule as well as other submodule
worktree manipulators (git reset/checkout --recurse-submodules) to not
end up in a detached HEAD state in the submodules.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 12 ++++++++
 submodule.c                 | 69 +++++++++++++++++++++++++++++++++++++++++++++
 submodule.h                 | 10 +++++++
 3 files changed, 91 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 36e4231821..645ceac999 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1196,6 +1196,17 @@ static int is_active(int argc, const char **argv, const char *prefix)
 	return !is_submodule_initialized(argv[1]);
 }
 
+static int cmd_reattach_HEAD(int argc, const char **argv, const char *prefix)
+{
+	if (argc != 2)
+		die("submodule--helper reattach-HEAD takes exactly 1 argument");
+
+	gitmodules_config();
+	git_config(submodule_config, NULL);
+
+	return reattach_HEAD(argv[1], REATTACH_HEAD_DIE_ON_ERROR);
+}
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -1217,6 +1228,7 @@ static struct cmd_struct commands[] = {
 	{"push-check", push_check, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
 	{"is-active", is_active, 0},
+	{"reattach-HEAD", cmd_reattach_HEAD, 0}
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/submodule.c b/submodule.c
index df03691199..4e74e38829 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1499,6 +1499,75 @@ int submodule_move_head(const char *path,
 	return ret;
 }
 
+int reattach_HEAD(const char *submodule_path, int flags)
+{
+	const char *branch;
+	struct object_id sub_head_object;
+	struct object_id sub_branch_object;
+
+	const struct submodule *sub = submodule_from_path(null_sha1, submodule_path);
+
+	if (!sub) {
+		if (!(flags & REATTACH_HEAD_DIE_ON_ERROR))
+			return -1;
+		die(_("no submodule mapping found in .gitmodules for path '%s'"),
+			submodule_path);
+	}
+
+	if (!sub->branch) {
+		if (!(flags & REATTACH_HEAD_DIE_ON_ERROR))
+			return -1;
+		die(_("no branch configured to follow for submodule '%s'"),
+			sub->path);
+	}
+
+	/* lookup branch value in .gitmodules */
+	if (strcmp(".", sub->branch)) {
+		branch = sub->branch;
+	} else {
+		/* special care for '.': Is the superproject on a branch? */
+		struct object_id oid;
+		branch = resolve_refdup("HEAD", 0, oid.hash, NULL);
+		if (!branch) {
+			if (!(flags & REATTACH_HEAD_DIE_ON_ERROR))
+				return -1;
+			die(_("Not on any branch, but submodule configured to follow superprojects branch"));
+		}
+	}
+
+	if (!strcmp("HEAD", branch))
+		return 0;
+
+	resolve_gitlink_ref(sub->path, "HEAD", sub_head_object.hash);
+	resolve_gitlink_ref(sub->path, branch, sub_branch_object.hash);
+
+	if (!oidcmp(&sub_head_object, &sub_branch_object)) {
+		struct child_process cp = CHILD_PROCESS_INIT;
+		struct strbuf reason = STRBUF_INIT;
+
+		cp.dir = sub->path;
+		prepare_submodule_repo_env(&cp.env_array);
+
+		strbuf_addf(&reason, "reattach HEAD to %s", branch);
+		argv_array_pushl(&cp.args, "git", "symbolic-ref",
+				 "-m", reason.buf, "HEAD", branch, NULL);
+		if (run_command(&cp)) {
+			if (!(flags & REATTACH_HEAD_DIE_ON_ERROR))
+				return -1;
+			die(_("could not run symbolic-ref in submodule '%s'"),
+			    sub->path);
+		}
+		strbuf_release(&reason);
+		return 0;
+	} else {
+		fprintf(stderr, "not reattaching HEAD, object ids differ:\n"
+				"HEAD is %s\n branch is %s",
+				oid_to_hex(&sub_head_object),
+				oid_to_hex(&sub_branch_object));
+		return 1;
+	}
+}
+
 static int find_first_merges(struct object_array *result, const char *path,
 		struct commit *a, struct commit *b)
 {
diff --git a/submodule.h b/submodule.h
index 1277480add..f7bb565a6d 100644
--- a/submodule.h
+++ b/submodule.h
@@ -119,6 +119,16 @@ extern int submodule_move_head(const char *path,
  */
 extern void prepare_submodule_repo_env(struct argv_array *out);
 
+/*
+ * Attach the submodules HEAD to its configured branch if the underlying
+ * object id are the same. Returns
+ * -  0 when the branch could be reattached.
+ * - +1 when the branch could not be reattached due to object name mismatch
+ * - <0 when an error occurred (e.g. missing .gitmodules file)
+ */
+#define REATTACH_HEAD_DIE_ON_ERROR (1<<0)
+extern int reattach_HEAD(const char *submodule_path, int flags);
+
 #define ABSORB_GITDIR_RECURSE_SUBMODULES (1<<0)
 extern void absorb_git_dir_into_superproject(const char *prefix,
 					     const char *path,
-- 
2.13.0.rc1.1.gbc33f0f778

