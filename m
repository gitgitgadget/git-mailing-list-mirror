Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499B0C4332F
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 16:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240112AbhKVQHd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 11:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240114AbhKVQHa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 11:07:30 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8C8C06174A
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 08:04:20 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id n29so33596560wra.11
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 08:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=befEe3hHYq8uxOiuLwpgbkDEpG+IHjZUoIVjNwYziMk=;
        b=H02qWpWay+x3WoL9jzmMehMWkLcn/BWfdUhvUVQntIoiIjiRABqbohmxXMcIAHfRkw
         m78/EkqWjfqZb8C7oGtYbXfsiPjZ6EILEknA7mXAdmOhbreOG6EU/beRTtgknfWQAGb+
         73l14vLaKcRC1eyxMw34h9IpLTYWKg3+zdUvMQ1QsdBMxtHFRWgMNauF2o3YKoYMxmut
         OYFGReIcwPMSiZywrCmlOop+oQZ+awFdS25qS2fjhkhGv6QbFItCiGkmSVL13nrEzVVS
         nBDpPldioES5vCPxexqkZSZKhECTd4GBLoCtV5P1W0ZzFyTyw49tkr16vik4xMcD7Nk6
         c5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=befEe3hHYq8uxOiuLwpgbkDEpG+IHjZUoIVjNwYziMk=;
        b=xuyMEzSg2UcnONtAf+ndueDvqYenubawUpkwjdUer3uqoS7Sbm/+x4n5Get+1scLlo
         hg37fpSi7ly4OFPCPeB/C9aAdATIkIsMze44YQ316hbWwySftH5y7G235yxYD4zUFfCG
         dqASZMaUPBoO0V82XWZ9DRIvq7H45M6nP6e9z2hC0KkbLYN1zfhdEkHZkRWPUow6SKBB
         Lf3iEC3CfsL5WHINPLqVuuv6V8p3Y29t441RsXPtPkh8k1hBUW7mFvN2b2GiulVvxZxI
         n4HuPLCSk+8b7b/0uMxAcJIXpnN7zr6hf8wXHnIRKTVFrU83Q8jiLTQk7sv67AUVQyJK
         kjYg==
X-Gm-Message-State: AOAM532iMN0hic8SpcFS7lcA7fdZ+EZtW71CJix5KTZqw++U3PhH4noN
        FG/sEdoCJ4RtOQdcZ/emfEVBv1D/lyXq0A==
X-Google-Smtp-Source: ABdhPJx27/xjD2VApB3Eg5d4zUy7qayi45Ct65qrJT2qWpDb6rH0DWPv79zoQE847maOazH5KZIppw==
X-Received: by 2002:adf:e484:: with SMTP id i4mr38791503wrm.49.1637597058216;
        Mon, 22 Nov 2021 08:04:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h27sm24005953wmc.43.2021.11.22.08.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 08:04:17 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/5] run-command API users: use strvec_pushl(), not argv construction
Date:   Mon, 22 Nov 2021 17:04:06 +0100
Message-Id: <patch-4.5-61751f55ff2-20211122T153605Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.822.gf3f912c366d
In-Reply-To: <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
References: <YZseJ4jOVIK3+bUD@coredump.intra.peff.net> <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Migrate those run-command API users that assign directly to the "argv"
member to use a strvec_pushl() of a list instead, this gets rid of the
intermediate "const char *args[]" these callers were using.

This is in preparation for getting rid of the "argv" member from the
run-command API itself.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 archive-tar.c     |  5 +----
 builtin/add.c     |  6 +-----
 builtin/fsck.c    | 12 ++++--------
 builtin/help.c    |  3 +--
 builtin/merge.c   |  3 +--
 builtin/replace.c |  3 +--
 daemon.c          | 15 +++------------
 diff.c            |  7 +------
 prompt.c          |  7 +------
 upload-pack.c     |  5 +----
 10 files changed, 15 insertions(+), 51 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 4154d9a0953..3c74db17468 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -430,7 +430,6 @@ static int write_tar_filter_archive(const struct archiver *ar,
 {
 	struct strbuf cmd = STRBUF_INIT;
 	struct child_process filter = CHILD_PROCESS_INIT;
-	const char *argv[2];
 	int r;
 
 	if (!ar->data)
@@ -440,9 +439,7 @@ static int write_tar_filter_archive(const struct archiver *ar,
 	if (args->compression_level >= 0)
 		strbuf_addf(&cmd, " -%d", args->compression_level);
 
-	argv[0] = cmd.buf;
-	argv[1] = NULL;
-	filter.argv = argv;
+	strvec_push(&filter.args, cmd.buf);
 	filter.use_shell = 1;
 	filter.in = -1;
 
diff --git a/builtin/add.c b/builtin/add.c
index ef6b619c45e..6357c0c3f9a 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -302,15 +302,11 @@ int interactive_add(const char **argv, const char *prefix, int patch)
 static int edit_patch(int argc, const char **argv, const char *prefix)
 {
 	char *file = git_pathdup("ADD_EDIT.patch");
-	const char *apply_argv[] = { "apply", "--recount", "--cached",
-		NULL, NULL };
 	struct child_process child = CHILD_PROCESS_INIT;
 	struct rev_info rev;
 	int out;
 	struct stat st;
 
-	apply_argv[3] = file;
-
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 
 	if (read_cache() < 0)
@@ -338,7 +334,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 		die(_("Empty patch. Aborted."));
 
 	child.git_cmd = 1;
-	child.argv = apply_argv;
+	strvec_pushl(&child.args, "apply", "--recount", "--cached", file, NULL);
 	if (run_command(&child))
 		die(_("Could not apply '%s'"), file);
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 27b9e78094d..9e54892311d 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -944,15 +944,13 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	if (the_repository->settings.core_commit_graph) {
 		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
-		const char *verify_argv[] = { "commit-graph", "verify", NULL, NULL, NULL };
 
 		prepare_alt_odb(the_repository);
 		for (odb = the_repository->objects->odb; odb; odb = odb->next) {
 			child_process_init(&commit_graph_verify);
-			commit_graph_verify.argv = verify_argv;
 			commit_graph_verify.git_cmd = 1;
-			verify_argv[2] = "--object-dir";
-			verify_argv[3] = odb->path;
+			strvec_pushl(&commit_graph_verify.args, "commit-graph",
+				     "verify", "--object-dir", odb->path, NULL);
 			if (run_command(&commit_graph_verify))
 				errors_found |= ERROR_COMMIT_GRAPH;
 		}
@@ -960,15 +958,13 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	if (the_repository->settings.core_multi_pack_index) {
 		struct child_process midx_verify = CHILD_PROCESS_INIT;
-		const char *midx_argv[] = { "multi-pack-index", "verify", NULL, NULL, NULL };
 
 		prepare_alt_odb(the_repository);
 		for (odb = the_repository->objects->odb; odb; odb = odb->next) {
 			child_process_init(&midx_verify);
-			midx_verify.argv = midx_argv;
 			midx_verify.git_cmd = 1;
-			midx_argv[2] = "--object-dir";
-			midx_argv[3] = odb->path;
+			strvec_pushl(&midx_verify.args, "multi-pack-index",
+				     "verify", "--object-dir", odb->path, NULL);
 			if (run_command(&midx_verify))
 				errors_found |= ERROR_MULTI_PACK_INDEX;
 		}
diff --git a/builtin/help.c b/builtin/help.c
index 75cd2fb407f..d387131dd83 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -212,11 +212,10 @@ static int check_emacsclient_version(void)
 {
 	struct strbuf buffer = STRBUF_INIT;
 	struct child_process ec_process = CHILD_PROCESS_INIT;
-	const char *argv_ec[] = { "emacsclient", "--version", NULL };
 	int version;
 
 	/* emacsclient prints its version number on stderr */
-	ec_process.argv = argv_ec;
+	strvec_pushl(&ec_process.args, "emacsclient", "--version", NULL);
 	ec_process.err = -1;
 	ec_process.stdout_to_stderr = 1;
 	if (start_command(&ec_process))
diff --git a/builtin/merge.c b/builtin/merge.c
index ea3112e0c0b..5f0476b0b76 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -310,10 +310,9 @@ static int save_state(struct object_id *stash)
 	int len;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf buffer = STRBUF_INIT;
-	const char *argv[] = {"stash", "create", NULL};
 	int rc = -1;
 
-	cp.argv = argv;
+	strvec_pushl(&cp.args, "stash", "create", NULL);
 	cp.out = -1;
 	cp.git_cmd = 1;
 
diff --git a/builtin/replace.c b/builtin/replace.c
index 946938d011e..6ff1734d587 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -258,11 +258,10 @@ static int import_object(struct object_id *oid, enum object_type type,
 		return error_errno(_("unable to open %s for reading"), filename);
 
 	if (!raw && type == OBJ_TREE) {
-		const char *argv[] = { "mktree", NULL };
 		struct child_process cmd = CHILD_PROCESS_INIT;
 		struct strbuf result = STRBUF_INIT;
 
-		cmd.argv = argv;
+		strvec_push(&cmd.args, "mktree");
 		cmd.git_cmd = 1;
 		cmd.in = fd;
 		cmd.out = -1;
diff --git a/daemon.c b/daemon.c
index 8df21f2130c..cc278077d2f 100644
--- a/daemon.c
+++ b/daemon.c
@@ -326,22 +326,13 @@ static int run_access_hook(struct daemon_service *service, const char *dir,
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
-	const char *argv[8];
-	const char **arg = argv;
 	char *eol;
 	int seen_errors = 0;
 
-	*arg++ = access_hook;
-	*arg++ = service->name;
-	*arg++ = path;
-	*arg++ = hi->hostname.buf;
-	*arg++ = get_canon_hostname(hi);
-	*arg++ = get_ip_address(hi);
-	*arg++ = hi->tcp_port.buf;
-	*arg = NULL;
-
 	child.use_shell = 1;
-	child.argv = argv;
+	strvec_pushl(&child.args, access_hook, service->name, path,
+		     hi->hostname.buf, get_canon_hostname(hi),
+		     get_ip_address(hi), hi->tcp_port.buf, NULL);
 	child.no_stdin = 1;
 	child.no_stderr = 1;
 	child.out = -1;
diff --git a/diff.c b/diff.c
index 861282db1c3..70711090b29 100644
--- a/diff.c
+++ b/diff.c
@@ -6921,19 +6921,14 @@ static char *run_textconv(struct repository *r,
 			  size_t *outsize)
 {
 	struct diff_tempfile *temp;
-	const char *argv[3];
-	const char **arg = argv;
 	struct child_process child = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	int err = 0;
 
 	temp = prepare_temp_file(r, spec->path, spec);
-	*arg++ = pgm;
-	*arg++ = temp->name;
-	*arg = NULL;
 
 	child.use_shell = 1;
-	child.argv = argv;
+	strvec_pushl(&child.args, pgm, temp->name, NULL);
 	child.out = -1;
 	if (start_command(&child)) {
 		remove_tempfile();
diff --git a/prompt.c b/prompt.c
index 5ded21a017f..aff9d7b65b2 100644
--- a/prompt.c
+++ b/prompt.c
@@ -8,15 +8,10 @@
 static char *do_askpass(const char *cmd, const char *prompt)
 {
 	struct child_process pass = CHILD_PROCESS_INIT;
-	const char *args[3];
 	static struct strbuf buffer = STRBUF_INIT;
 	int err = 0;
 
-	args[0] = cmd;
-	args[1]	= prompt;
-	args[2] = NULL;
-
-	pass.argv = args;
+	strvec_pushl(&pass.args, cmd, prompt, NULL);
 	pass.out = -1;
 
 	if (start_command(&pass))
diff --git a/upload-pack.c b/upload-pack.c
index c78d55bc674..9b5db32623f 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -596,14 +596,11 @@ static int do_reachable_revlist(struct child_process *cmd,
 				struct object_array *reachable,
 				enum allow_uor allow_uor)
 {
-	static const char *argv[] = {
-		"rev-list", "--stdin", NULL,
-	};
 	struct object *o;
 	FILE *cmd_in = NULL;
 	int i;
 
-	cmd->argv = argv;
+	strvec_pushl(&cmd->args, "rev-list", "--stdin", NULL);
 	cmd->git_cmd = 1;
 	cmd->no_stderr = 1;
 	cmd->in = -1;
-- 
2.34.0.822.gb876f875f1b

