Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2C601FC96
	for <e@80x24.org>; Sat,  3 Dec 2016 00:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757117AbcLCAbA (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 19:31:00 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33671 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755299AbcLCAat (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 19:30:49 -0500
Received: by mail-pf0-f181.google.com with SMTP id d2so55121919pfd.0
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 16:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=njlAm61+8nuTmeJqwmkUvUyTjPwHeGcya3cWTQjrzck=;
        b=lBaKUowGrXvmKEbwAMtGz7otompLV9JgkrAXya7jSmMglq+U3fCcgjczQiwnE9je9s
         EYBcvcgSreQVUsveBMeStdHDx9l4ilzd0H6jSonQ1Lu6TH2v0FSvvOZOYT3TK1Jr5KRv
         YbCi8asEshXpOd+io2z2LVtylqv5q3kiHO8eJd3BC+ArtAurpwmpwpjqToxPOWQVmQpO
         zvHIbdJdEDWiobMuSQ43XD02FantNWUsAku5Pas/LZ/O5Ge0FHVmQXS1sl6z55Saqp7d
         KhE3KysIaFL2bDZSM6bVbEfjg/RH/9+JiJdsJZ9VRI7TB55c4GCfN78YkLko+YlJvx6U
         UnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=njlAm61+8nuTmeJqwmkUvUyTjPwHeGcya3cWTQjrzck=;
        b=crIhH3lYLVnC4owGjDJUuQbF7QgBZk/OC3Oy+ysBQHFjzAtFyKEjz8L9YJTyznRS4i
         0baQ1qZsT0o0CP5aDu5GHr3BDQGV9uxF2Ua9TgDVLNRiNMaBX1qZb9A4Gv+AYCWSTNDd
         aELITO6goORsWDI/PBnvCBR3xgayVzZNFnWHC8XRlktMGO5R4GL/aK15QuVDcRdy+ooA
         ZD7XW0tuTREqfCTs99UWhP3cclMKyOBDxNn44YEW6e+gUiu0balidysd624F1VvwrPZ5
         lvGsX+UgoeFpHPMjKbfuzEEcPQdZM7AL75m0sZHwkByP+Rcf1U0TDbjCnZA5RC+mR3Db
         NHGg==
X-Gm-Message-State: AKaTC024PUwY1dIhYpH3WcnEolCYEqVZIoTvUyet7Xt2cRbDiD8+pFJh0YAPsSZqGO+zi68k
X-Received: by 10.84.218.72 with SMTP id f8mr102445193plm.141.1480725043874;
        Fri, 02 Dec 2016 16:30:43 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:99ac:e2be:c532:3e35])
        by smtp.gmail.com with ESMTPSA id i76sm10147776pfk.89.2016.12.02.16.30.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 16:30:43 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, David.Turner@twosigma.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        hvoigt@hvoigt.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [RFC PATCHv2 09/17] update submodules: add scheduling to update submodules
Date:   Fri,  2 Dec 2016 16:30:14 -0800
Message-Id: <20161203003022.29797-10-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.28.g2673dad
In-Reply-To: <20161203003022.29797-1-sbeller@google.com>
References: <20161203003022.29797-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The walker of a tree is only expected to call `schedule_submodule_for_update`
and once done, to run `update_submodules`. This avoids directory/file
conflicts and later we can parallelize all submodule actions if needed.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 submodule.h |   5 +++
 2 files changed, 137 insertions(+)

diff --git a/submodule.c b/submodule.c
index 7bb64d6c69..02c28ef56b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1348,3 +1348,135 @@ int parallel_submodules(void)
 {
 	return parallel_jobs;
 }
+
+static struct scheduled_submodules_update_type {
+	const char *path;
+	const struct object_id *oid;
+	/*
+	 * Do we need to perform a complete checkout or just incremental
+	 * update?
+	 */
+	unsigned is_new:1;
+} *scheduled_submodules;
+#define SCHEDULED_SUBMODULES_INIT {NULL, NULL, 0}
+
+static int scheduled_submodules_nr, scheduled_submodules_alloc;
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
+		struct submodule *sub;
+		struct scheduled_submodules_update_type *ssu =
+			&scheduled_submodules[i];
+
+		if (!submodule_is_interesting(ssu->path))
+			continue;
+
+		sub = submodule_from_path(null_sha1, ssu->path);
+
+		switch (sub->update_strategy) {
+		case SM_UPDATE_UNSPECIFIED: /* fall thru */
+		case SM_UPDATE_CHECKOUT:
+			update_submodule(ssu->path, ssu->oid,
+					 force, ssu->is_new);
+			break;
+		case SM_UPDATE_REBASE:
+		case SM_UPDATE_MERGE:
+		case SM_UPDATE_NONE:
+		case SM_UPDATE_COMMAND:
+			warning("update strategy for submodule '%s' not supported", ssu->path);
+		}
+	}
+
+	scheduled_submodules_nr = 0;
+	return 0;
+}
diff --git a/submodule.h b/submodule.h
index d8bb1d4baf..74df8b93d5 100644
--- a/submodule.h
+++ b/submodule.h
@@ -90,4 +90,9 @@ extern int parallel_submodules(void);
  * retaining any config in the environment.
  */
 extern void prepare_submodule_repo_env(struct argv_array *out);
+
+extern void schedule_submodule_for_update(const struct cache_entry *ce,
+					  int new);
+extern int update_submodules(int force);
+
 #endif
-- 
2.11.0.rc2.28.g2673dad

