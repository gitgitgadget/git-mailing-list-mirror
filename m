Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFC2C433F5
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 22:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346012AbhKYW7m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 17:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbhKYW5l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 17:57:41 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0776C061757
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:52:34 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 137so6716732wma.1
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OsBcJli4MkbJ8Y8iguiFgc2zzaV6UDo8tky+jVmrIcM=;
        b=Mz6ExfPnOBYQlO9NLvTjfG3Kl4wErcqnzIWVSwRVFmjx3qYF1VK9kpPZajQsuCS9vW
         arhiUKo5KAXoJxjeYaUYziwHEZf532siISRM3ZGDnFZCrTsIwR3M2SSDo7m3dwSvurZz
         z65TjZlRgYVjcOmCBNqo226UwUiJnaZdA8lukQP183Uangm5b04RcB93vYhV8wpT1y08
         7jvzziotbsLKJZ1KKLE/BTrqC81Olm7lKWGE3Krlze1LR1itceaFhzr87GAySmy8fD29
         HB7EdSjcTL1G/7xWIdR+UgyBA2F19yQW2A6J01fms2KYEYk7Cej/GpcuBqJzbkV5Pdae
         aVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OsBcJli4MkbJ8Y8iguiFgc2zzaV6UDo8tky+jVmrIcM=;
        b=FGGUpRjsdwUIEFPR/OYXqUMvmCQ21EjroT4pA4kh9Yrq+ib9RaP2nOPBEnSwCOzRJL
         994hz0ObtJcU/NO7CI5YB03BmBLsh6vwpg4LUo6Bm23Ig5opqsVOcilU5meE8UWPMuSc
         jbY0a4WfPF0gTxKuFSejnDqL5KFTLzfQ9j4pGVw4yVFj+xF/tQqzB8+Xq9u6mcvCDhWU
         WhUbKTRklOgDTNMW144VrQVuLWEMeHOPJKqdWwucK5/CDloOxjPv3u2TgGXJhSQ3iVm8
         0rEtA4UOwu4npJeqUqFmw6EVvNGjEm+cNBVU5aZSES4B9yLCNalb/QaDTx4PN7E3bqW2
         RxkA==
X-Gm-Message-State: AOAM533lxBF4PQKI4wuUlcz68BhjhkPWYQsSv772aaYVSanEkfVYYnzC
        OFO/ciQuPvzcLHEExChLsw2x+ZcBP0hzhA==
X-Google-Smtp-Source: ABdhPJxCI8/PyWBNIW26flOfja+eOlxRbBL1VuI7htxFD3DQdmsr/S6O5bYsYf9p4QAyj/n6x3Vi1w==
X-Received: by 2002:a7b:c341:: with SMTP id l1mr12045761wmj.60.1637880753215;
        Thu, 25 Nov 2021 14:52:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h22sm5001257wmq.14.2021.11.25.14.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 14:52:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 6/9] run-command API users: use strvec_push(), not argv construction
Date:   Thu, 25 Nov 2021 23:52:21 +0100
Message-Id: <patch-v3-6.9-7bdf963ed04-20211125T224833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.838.g779e9098efb
In-Reply-To: <cover-v3-0.9-00000000000-20211125T224833Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20211125T224833Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a pattern of hardcoding an "argv" array size, populating it and
assigning to the "argv" member of "struct child_process" to instead
use "strvec_push()" to add data to the "args" member.

As noted in the preceding commit this moves us further towards being
able to remove the "argv" member in a subsequent commit

These callers could have used strvec_pushl(), but moving to
strvec_push() makes the diff easier to read, and keeps the arguments
aligned as before.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 archive-tar.c          |  9 +++------
 builtin/receive-pack.c | 31 ++++++++++++-------------------
 daemon.c               | 18 +++++++-----------
 diff.c                 |  8 ++------
 prompt.c               |  7 ++-----
 transport.c            | 11 +++++------
 6 files changed, 31 insertions(+), 53 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 05d2455870d..3c74db17468 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -430,7 +430,6 @@ static int write_tar_filter_archive(const struct archiver *ar,
 {
 	struct strbuf cmd = STRBUF_INIT;
 	struct child_process filter = CHILD_PROCESS_INIT;
-	const char *argv[2];
 	int r;
 
 	if (!ar->data)
@@ -440,14 +439,12 @@ static int write_tar_filter_archive(const struct archiver *ar,
 	if (args->compression_level >= 0)
 		strbuf_addf(&cmd, " -%d", args->compression_level);
 
-	argv[0] = cmd.buf;
-	argv[1] = NULL;
-	filter.argv = argv;
+	strvec_push(&filter.args, cmd.buf);
 	filter.use_shell = 1;
 	filter.in = -1;
 
 	if (start_command(&filter) < 0)
-		die_errno(_("unable to start '%s' filter"), argv[0]);
+		die_errno(_("unable to start '%s' filter"), cmd.buf);
 	close(1);
 	if (dup2(filter.in, 1) < 0)
 		die_errno(_("unable to redirect descriptor"));
@@ -457,7 +454,7 @@ static int write_tar_filter_archive(const struct archiver *ar,
 
 	close(1);
 	if (finish_command(&filter) != 0)
-		die(_("'%s' filter reported error"), argv[0]);
+		die(_("'%s' filter reported error"), cmd.buf);
 
 	strbuf_release(&cmd);
 	return r;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 6149d507965..48c99c8ee45 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -812,16 +812,13 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed,
 {
 	struct child_process proc = CHILD_PROCESS_INIT;
 	struct async muxer;
-	const char *argv[2];
 	int code;
+	const char *hook_path = find_hook(hook_name);
 
-	argv[0] = find_hook(hook_name);
-	if (!argv[0])
+	if (!hook_path)
 		return 0;
 
-	argv[1] = NULL;
-
-	proc.argv = argv;
+	strvec_push(&proc.args, hook_path);
 	proc.in = -1;
 	proc.stdout_to_stderr = 1;
 	proc.trace2_hook_name = hook_name;
@@ -943,23 +940,21 @@ static int run_receive_hook(struct command *commands,
 
 static int run_update_hook(struct command *cmd)
 {
-	const char *argv[5];
 	struct child_process proc = CHILD_PROCESS_INIT;
 	int code;
+	const char *hook_path = find_hook("update");
 
-	argv[0] = find_hook("update");
-	if (!argv[0])
+	if (!hook_path)
 		return 0;
 
-	argv[1] = cmd->ref_name;
-	argv[2] = oid_to_hex(&cmd->old_oid);
-	argv[3] = oid_to_hex(&cmd->new_oid);
-	argv[4] = NULL;
+	strvec_push(&proc.args, hook_path);
+	strvec_push(&proc.args, cmd->ref_name);
+	strvec_push(&proc.args, oid_to_hex(&cmd->old_oid));
+	strvec_push(&proc.args, oid_to_hex(&cmd->new_oid));
 
 	proc.no_stdin = 1;
 	proc.stdout_to_stderr = 1;
 	proc.err = use_sideband ? -1 : 0;
-	proc.argv = argv;
 	proc.trace2_hook_name = "update";
 
 	code = start_command(&proc);
@@ -1117,22 +1112,20 @@ static int run_proc_receive_hook(struct command *commands,
 	struct child_process proc = CHILD_PROCESS_INIT;
 	struct async muxer;
 	struct command *cmd;
-	const char *argv[2];
 	struct packet_reader reader;
 	struct strbuf cap = STRBUF_INIT;
 	struct strbuf errmsg = STRBUF_INIT;
 	int hook_use_push_options = 0;
 	int version = 0;
 	int code;
+	const char *hook_path = find_hook("proc-receive");
 
-	argv[0] = find_hook("proc-receive");
-	if (!argv[0]) {
+	if (!hook_path) {
 		rp_error("cannot find hook 'proc-receive'");
 		return -1;
 	}
-	argv[1] = NULL;
 
-	proc.argv = argv;
+	strvec_push(&proc.args, hook_path);
 	proc.in = -1;
 	proc.out = -1;
 	proc.trace2_hook_name = "proc-receive";
diff --git a/daemon.c b/daemon.c
index 8df21f2130c..4a000ee4afa 100644
--- a/daemon.c
+++ b/daemon.c
@@ -326,22 +326,18 @@ static int run_access_hook(struct daemon_service *service, const char *dir,
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
+	strvec_push(&child.args, access_hook);
+	strvec_push(&child.args, service->name);
+	strvec_push(&child.args, path);
+	strvec_push(&child.args, hi->hostname.buf);
+	strvec_push(&child.args, get_canon_hostname(hi));
+	strvec_push(&child.args, get_ip_address(hi));
+	strvec_push(&child.args, hi->tcp_port.buf);
 
 	child.use_shell = 1;
-	child.argv = argv;
 	child.no_stdin = 1;
 	child.no_stderr = 1;
 	child.out = -1;
diff --git a/diff.c b/diff.c
index 861282db1c3..41076857428 100644
--- a/diff.c
+++ b/diff.c
@@ -6921,19 +6921,15 @@ static char *run_textconv(struct repository *r,
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
+	strvec_push(&child.args, pgm);
+	strvec_push(&child.args, temp->name);
 
 	child.use_shell = 1;
-	child.argv = argv;
 	child.out = -1;
 	if (start_command(&child)) {
 		remove_tempfile();
diff --git a/prompt.c b/prompt.c
index 5ded21a017f..50df17279d1 100644
--- a/prompt.c
+++ b/prompt.c
@@ -8,15 +8,12 @@
 static char *do_askpass(const char *cmd, const char *prompt)
 {
 	struct child_process pass = CHILD_PROCESS_INIT;
-	const char *args[3];
 	static struct strbuf buffer = STRBUF_INIT;
 	int err = 0;
 
-	args[0] = cmd;
-	args[1]	= prompt;
-	args[2] = NULL;
+	strvec_push(&pass.args, cmd);
+	strvec_push(&pass.args, prompt);
 
-	pass.argv = args;
 	pass.out = -1;
 
 	if (start_command(&pass))
diff --git a/transport.c b/transport.c
index e4f1decae20..92ab9a3fa6b 100644
--- a/transport.c
+++ b/transport.c
@@ -1204,16 +1204,15 @@ static int run_pre_push_hook(struct transport *transport,
 	struct ref *r;
 	struct child_process proc = CHILD_PROCESS_INIT;
 	struct strbuf buf;
-	const char *argv[4];
+	const char *hook_path = find_hook("pre-push");
 
-	if (!(argv[0] = find_hook("pre-push")))
+	if (!hook_path)
 		return 0;
 
-	argv[1] = transport->remote->name;
-	argv[2] = transport->url;
-	argv[3] = NULL;
+	strvec_push(&proc.args, hook_path);
+	strvec_push(&proc.args, transport->remote->name);
+	strvec_push(&proc.args, transport->url);
 
-	proc.argv = argv;
 	proc.in = -1;
 	proc.trace2_hook_name = "pre-push";
 
-- 
2.34.1.838.g779e9098efb

