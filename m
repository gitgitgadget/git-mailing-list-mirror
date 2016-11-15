Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A89BF2021E
	for <e@80x24.org>; Tue, 15 Nov 2016 23:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935038AbcKOXHN (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 18:07:13 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33435 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934598AbcKOXHL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 18:07:11 -0500
Received: by mail-pg0-f51.google.com with SMTP id 3so71683733pgd.0
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 15:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hC6oAFtPKsfiFcnis+3fAyJzRt552RXoIHcoosIDCSI=;
        b=URZlB4hFI7Hy3J9igNxz5h67uqPlwjGKmngVzXZoEbQRyZmaxGWG8U6wpXZH+0HDoz
         +RtAsm//Q0+8vR3Q0Gx7vYFr0L1qExtzOag5wCQe4a2QsjfDX3bLLCiQexVTTevAYjAx
         IleauuUywoGc57RRFfCcGnYw5uPptp/a+wyhWkvWyp02SP95g/cETOdZUcnueIsjJZ2v
         uhI4Z8KA0qT06kDX3rkNxErer+IvtxJ3KC7yeqe6apBUnXvao/Qw2eRgk6xZ5Utbw45M
         eIJwgaqx9zW8pqfwb00k8ahfgu3LXVeTaBoRMQ3+TAdfVXbaI592yRmfVT+LxPsh6/aS
         AQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hC6oAFtPKsfiFcnis+3fAyJzRt552RXoIHcoosIDCSI=;
        b=QXtshZOvYR3OfxxxsOVlNMhOyFEfnOMu5VluvtYNwd9tvuK83cbzWG6bMJLJpU/odc
         ewtsxR7pNZ7bxatVwo8SP7118BTJ2DwO6JjUVuK9AjbQzllcW5PWcrTg04HsXmsgt4NH
         e+XE+/4obr+fZ+GXKwOc42lLAQOopUbVA08LRObrCmGbmrg14hOnhSVrOFZGjncik4jr
         00N5qgMJwp9QKEH4foPDl1ToVtdjdXrC2OMskJGdZSkUdHiryl307hplJk5DFObqurYU
         lTeDjtdwFu5u7x21dtxI3tUtxhElilD/hL4kZ2tnDnS9nvRrZopdfpWo85pTcUWLgOt3
         bNwQ==
X-Gm-Message-State: ABUngvcpnkS36ZVL1M7+cEpqltobAt7tcE++QlpoNoDIJLLW2PtXPYigUWEXbuUCLjGy6qEP
X-Received: by 10.98.67.89 with SMTP id q86mr61885pfa.178.1479251225576;
        Tue, 15 Nov 2016 15:07:05 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:1161:a721:e128:bf5f])
        by smtp.gmail.com with ESMTPSA id n17sm46283832pfg.80.2016.11.15.15.07.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Nov 2016 15:07:05 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com,
        jrnieder@gmail.com, mogulguy10@gmail.com,
        David.Turner@twosigma.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 09/16] update submodules: add scheduling to update submodules
Date:   Tue, 15 Nov 2016 15:06:44 -0800
Message-Id: <20161115230651.23953-10-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161115230651.23953-1-sbeller@google.com>
References: <20161115230651.23953-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The walker of a tree is only expected to call `schedule_submodule_for_update`
and once done, to run `update_submodules`. This avoids directory/file
conflicts and later we can parallelize all submodule actions if needed.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 submodule.h |   4 +++
 2 files changed, 121 insertions(+)

diff --git a/submodule.c b/submodule.c
index 0fa4613..2773151 100644
--- a/submodule.c
+++ b/submodule.c
@@ -308,6 +308,75 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
 	strbuf_release(&sb);
 }
 
+static int update_submodule(const char *path, const struct object_id *oid,
+			    int force, int is_new)
+{
+	const char *git_dir;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	const struct submodule *sub = submodule_from_path(null_sha1, path);
+
+	if (!sub || !sub->name)
+		return -1;
+
+	git_dir = resolve_gitdir(git_common_path("modules/%s", sub->name));
+
+	if (!git_dir)
+		return -1;
+
+	if (is_new)
+		connect_work_tree_and_git_dir(path, git_dir);
+
+	/* update index via `read-tree --reset sha1` */
+	argv_array_pushl(&cp.args, "read-tree",
+				   force ? "--reset" : "-m",
+				   "-u", sha1_to_hex(oid->hash), NULL);
+	prepare_submodule_repo_env(&cp.env_array);
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	cp.dir = path;
+	if (run_command(&cp)) {
+		warning(_("reading the index in submodule '%s' failed"), path);
+		child_process_clear(&cp);
+		return -1;
+	}
+
+	/* write index to working dir */
+	child_process_clear(&cp);
+	child_process_init(&cp);
+	argv_array_pushl(&cp.args, "checkout-index", "-a", NULL);
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	cp.dir = path;
+	if (force)
+		argv_array_push(&cp.args, "-f");
+
+	if (run_command(&cp)) {
+		warning(_("populating the working directory in submodule '%s' failed"), path);
+		child_process_clear(&cp);
+		return -1;
+	}
+
+	/* get the HEAD right */
+	child_process_clear(&cp);
+	child_process_init(&cp);
+	argv_array_pushl(&cp.args, "checkout", "--recurse-submodules", NULL);
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	cp.dir = path;
+	if (force)
+		argv_array_push(&cp.args, "-f");
+	argv_array_push(&cp.args, sha1_to_hex(oid->hash));
+
+	if (run_command(&cp)) {
+		warning(_("setting the HEAD in submodule '%s' failed"), path);
+		child_process_clear(&cp);
+		return -1;
+	}
+
+	child_process_clear(&cp);
+	return 0;
+}
+
 int depopulate_submodule(const char *path)
 {
 	int ret = 0;
@@ -1336,3 +1405,51 @@ void prepare_submodule_repo_env(struct argv_array *out)
 	}
 	argv_array_push(out, "GIT_DIR=.git");
 }
+
+struct scheduled_submodules_update_type {
+	const char *path;
+	const struct object_id *oid;
+	/*
+	 * Do we need to perform a complete checkout or just incremental
+	 * update?
+	 */
+	unsigned is_new:1;
+} *scheduled_submodules;
+#define SCHEDULED_SUBMODULES_INIT {NULL, NULL}
+
+int scheduled_submodules_nr, scheduled_submodules_alloc;
+
+void schedule_submodule_for_update(const struct cache_entry *ce, int is_new)
+{
+	struct scheduled_submodules_update_type *ssu;
+	ALLOC_GROW(scheduled_submodules,
+		   scheduled_submodules_nr + 1,
+		   scheduled_submodules_alloc);
+	ssu = &scheduled_submodules[scheduled_submodules_nr++];
+	ssu->path = ce->name;
+	ssu->oid = &ce->oid;
+	ssu->is_new = !!is_new;
+}
+
+int update_submodules(int force)
+{
+	int i;
+	gitmodules_config();
+
+	/*
+	 * NEEDSWORK: As submodule updates can potentially take some
+	 * time each and they do not overlap (i.e. no d/f conflicts;
+	 * this can be parallelized using the run_commands.h API.
+	 */
+	for (i = 0; i < scheduled_submodules_nr; i++) {
+		struct scheduled_submodules_update_type *ssu =
+			&scheduled_submodules[i];
+
+		if (submodule_is_interesting(ssu->path, null_sha1))
+			update_submodule(ssu->path, ssu->oid,
+					 force, ssu->is_new);
+	}
+
+	scheduled_submodules_nr = 0;
+	return 0;
+}
diff --git a/submodule.h b/submodule.h
index 8518cf3..f01f87c 100644
--- a/submodule.h
+++ b/submodule.h
@@ -94,4 +94,8 @@ extern int parallel_submodules(void);
  */
 extern void prepare_submodule_repo_env(struct argv_array *out);
 
+extern void schedule_submodule_for_update(const struct cache_entry *ce,
+					  int new);
+extern int update_submodules(int force);
+
 #endif
-- 
2.10.1.469.g00a8914

