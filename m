Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B877C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 20:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjBIUYU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 15:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjBIUYR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 15:24:17 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510F8485AC
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 12:24:16 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id y4so2136694pfe.4
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 12:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=x3S6VfBFuiDTXRtGcMbiCTXo2KqhqZ2n5nfhCxPzLt0=;
        b=ksJt4KEavxenR9Fm491AWJkfESOaSf3jBp41y6HYVCrHgeU7etuov/OSkW6VerFI2T
         SlP064RkRiu7sEN2HYdai6+DFvyy99B5Esoh8TiOoJLcacis874mJbutfU7BvhXIDYTU
         BelJDn35YZtIL5SvdDLykonk3Y4qDPHrMXN+5MDAkznjL8MLtOY3AZdBLHCsG8S4cYsz
         N6Vb9TzAwgqMLANeDn4293pi6TRdNjwnlMiV0LOhhutskcsBWtUBclEHyq23ajSOhQX+
         eoj6pLMsqQixurhj6iZoXkqXCuVuH794r8CQEpcbNTJu6PZeapo1Wf5PVAJ3oJrZlYdk
         5pKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3S6VfBFuiDTXRtGcMbiCTXo2KqhqZ2n5nfhCxPzLt0=;
        b=30f05KITgcmhpI7tIpCSavHTxS16PbQAgGrGwiB+FRis7FwJ+qvLnDoaStfomfKAoe
         D1n8R855gLgVBOaI1fcikEFQ+TGDfqUycsMpkv6JPyu2nHgPURVgbmri7txZSDiEez6w
         msjOlmDf9uaqGY0tqr/zjAi/WEuReDnasA3DUuaP7V2Lohf1n5L+XlbNwHdlJ/jzETZX
         pRB8B2ZVJnchHbTI/ory09ycXdUNzg524UpsO7U3MV/ul8I1TjodfCLbI2a2rpBeP/T2
         09cvPPp0SdraZmpdNeGl5NA89rccls0JI9F5UkEZDyjOs3nXTlzuMStOyvegk9Ocu12y
         RJtQ==
X-Gm-Message-State: AO0yUKVi10FqD6swzDjWelw4ltKaBBo1hpoE6TH/eCYnAGoMFbt+oVjO
        Z7wXZbVp/X0sC6TseTBQJCbLpl6xyqM=
X-Google-Smtp-Source: AK7set/B44kwQ1/t1cjGGE4BtyKURmPVjWBXJezWcj2Rq4xVmEpGcAVobeesXyvHoyd21O29d0D5Xg==
X-Received: by 2002:aa7:94b1:0:b0:5a8:4c8b:49e with SMTP id a17-20020aa794b1000000b005a84c8b049emr4711455pfl.3.1675974255401;
        Thu, 09 Feb 2023 12:24:15 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id y25-20020aa78559000000b0059275411af8sm1863194pfn.62.2023.02.09.12.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 12:24:14 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2] gpg-interface: lazily initialize and read the configuration
References: <Y+PGRaiTTaZ/DtlJ@work-laptop-max>
        <Y+PRTYtFDoE73XEM@coredump.intra.peff.net>
        <xmqqmt5orqgv.fsf@gitster.g> <xmqqh6vwrpce.fsf@gitster.g>
        <xmqqlel7rj9z.fsf_-_@gitster.g>
        <Y+Tr1g+HTn45rsTq@coredump.intra.peff.net>
        <xmqqwn4qokug.fsf@gitster.g>
Date:   Thu, 09 Feb 2023 12:24:14 -0800
In-Reply-To: <xmqqwn4qokug.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        09 Feb 2023 08:38:15 -0800")
Message-ID: <xmqqpmaimvtd.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of forcing the porcelain commands to always read the
configuration variables related to the signing and verifying
signatures, lazily initialize the necessary subsystem on demand upon
the first use.

This hopefully would make it more future-proof as we do not have to
think and decide whether we should call git_gpg_config() in the
git_config() callback for each command.

A few git_config() callback functions that used to be custom
callbacks are now just a thin wrapper around git_default_config().
We could further remove, git_FOO_config and replace calls to
git_config(git_FOO_config) with git_config(git_default_config), but
to make it clear which ones are affected and the effect is only the
removal of git_gpg_config(), it is vastly preferred not to do such a
change in this step (they can be done on top once the dust settled).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * OK, this time it comes with a small test addition ;-)

 builtin/am.c                     |  6 ------
 builtin/commit-tree.c            |  3 ---
 builtin/commit.c                 |  4 ----
 builtin/log.c                    |  2 --
 builtin/merge.c                  |  3 ---
 builtin/pull.c                   |  6 ------
 builtin/push.c                   |  5 -----
 builtin/receive-pack.c           |  4 ----
 builtin/send-pack.c              |  2 --
 builtin/tag.c                    |  5 -----
 builtin/verify-commit.c          |  3 ---
 builtin/verify-tag.c             |  3 ---
 fmt-merge-msg.c                  |  5 -----
 gpg-interface.c                  | 24 +++++++++++++++++++++++-
 gpg-interface.h                  |  1 -
 sequencer.c                      |  4 ----
 t/t7031-verify-tag-signed-ssh.sh | 10 ++++++++++
 17 files changed, 33 insertions(+), 57 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 82a41cbfc4..40126b59c5 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2314,12 +2314,6 @@ static int parse_opt_show_current_patch(const struct option *opt, const char *ar
 
 static int git_am_config(const char *k, const char *v, void *cb UNUSED)
 {
-	int status;
-
-	status = git_gpg_config(k, v, NULL);
-	if (status)
-		return status;
-
 	return git_default_config(k, v, NULL);
 }
 
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index cc8d584be2..f6a099d601 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -39,9 +39,6 @@ static void new_parent(struct commit *parent, struct commit_list **parents_p)
 
 static int commit_tree_config(const char *var, const char *value, void *cb)
 {
-	int status = git_gpg_config(var, value, NULL);
-	if (status)
-		return status;
 	return git_default_config(var, value, cb);
 }
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 44b763d7cd..794500dc9e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1600,7 +1600,6 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 static int git_commit_config(const char *k, const char *v, void *cb)
 {
 	struct wt_status *s = cb;
-	int status;
 
 	if (!strcmp(k, "commit.template"))
 		return git_config_pathname(&template_file, k, v);
@@ -1620,9 +1619,6 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 
-	status = git_gpg_config(k, v, NULL);
-	if (status)
-		return status;
 	return git_status_config(k, v, s);
 }
 
diff --git a/builtin/log.c b/builtin/log.c
index 04412dd9c9..56741c6d37 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -601,8 +601,6 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	if (git_gpg_config(var, value, cb) < 0)
-		return -1;
 	return git_diff_ui_config(var, value, cb);
 }
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 74de2ebd2b..289c13656c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -659,9 +659,6 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 	}
 
 	status = fmt_merge_msg_config(k, v, cb);
-	if (status)
-		return status;
-	status = git_gpg_config(k, v, NULL);
 	if (status)
 		return status;
 	return git_diff_ui_config(k, v, cb);
diff --git a/builtin/pull.c b/builtin/pull.c
index 1ab4de0005..4367727db6 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -359,8 +359,6 @@ static enum rebase_type config_get_rebase(int *rebase_unspecified)
  */
 static int git_pull_config(const char *var, const char *value, void *cb)
 {
-	int status;
-
 	if (!strcmp(var, "rebase.autostash")) {
 		config_autostash = git_config_bool(var, value);
 		return 0;
@@ -372,10 +370,6 @@ static int git_pull_config(const char *var, const char *value, void *cb)
 		check_trust_level = 0;
 	}
 
-	status = git_gpg_config(var, value, cb);
-	if (status)
-		return status;
-
 	return git_default_config(var, value, cb);
 }
 
diff --git a/builtin/push.c b/builtin/push.c
index 60ac8017e5..8f8904dd08 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -502,11 +502,6 @@ static int git_push_config(const char *k, const char *v, void *cb)
 {
 	const char *slot_name;
 	int *flags = cb;
-	int status;
-
-	status = git_gpg_config(k, v, NULL);
-	if (status)
-		return status;
 
 	if (!strcmp(k, "push.followtags")) {
 		if (git_config_bool(k, v))
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a90af30363..9894dbdc79 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -133,10 +133,6 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 {
 	int status = parse_hide_refs_config(var, value, "receive", &hidden_refs);
 
-	if (status)
-		return status;
-
-	status = git_gpg_config(var, value, NULL);
 	if (status)
 		return status;
 
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 4c5d125fa0..c31e27346b 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -130,8 +130,6 @@ static void print_helper_status(struct ref *ref)
 
 static int send_pack_config(const char *k, const char *v, void *cb)
 {
-	git_gpg_config(k, v, NULL);
-
 	if (!strcmp(k, "push.gpgsign")) {
 		const char *value;
 		if (!git_config_get_value("push.gpgsign", &value)) {
diff --git a/builtin/tag.c b/builtin/tag.c
index d428c45dc8..725cfcd62b 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -180,8 +180,6 @@ static const char tag_template_nocleanup[] =
 
 static int git_tag_config(const char *var, const char *value, void *cb)
 {
-	int status;
-
 	if (!strcmp(var, "tag.gpgsign")) {
 		config_sign_tag = git_config_bool(var, value);
 		return 0;
@@ -194,9 +192,6 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	status = git_gpg_config(var, value, cb);
-	if (status)
-		return status;
 	if (!strcmp(var, "tag.forcesignannotated")) {
 		force_sign_annotate = git_config_bool(var, value);
 		return 0;
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 3ebad32b0f..3c5d0b024c 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -54,9 +54,6 @@ static int verify_commit(const char *name, unsigned flags)
 
 static int git_verify_commit_config(const char *var, const char *value, void *cb)
 {
-	int status = git_gpg_config(var, value, cb);
-	if (status)
-		return status;
 	return git_default_config(var, value, cb);
 }
 
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 217566952d..ecffb069bf 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -21,9 +21,6 @@ static const char * const verify_tag_usage[] = {
 
 static int git_verify_tag_config(const char *var, const char *value, void *cb)
 {
-	int status = git_gpg_config(var, value, cb);
-	if (status)
-		return status;
 	return git_default_config(var, value, cb);
 }
 
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index f48f44f9cd..9b83c95a08 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -17,8 +17,6 @@ static struct string_list suppress_dest_patterns = STRING_LIST_INIT_DUP;
 
 int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 {
-	int status = 0;
-
 	if (!strcmp(key, "merge.log") || !strcmp(key, "merge.summary")) {
 		int is_bool;
 		merge_log_config = git_config_bool_or_int(key, value, &is_bool);
@@ -37,9 +35,6 @@ int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 			string_list_append(&suppress_dest_patterns, value);
 		suppress_dest_pattern_seen = 1;
 	} else {
-		status = git_gpg_config(key, value, NULL);
-		if (status)
-			return status;
 		return git_default_config(key, value, cb);
 	}
 	return 0;
diff --git a/gpg-interface.c b/gpg-interface.c
index 687236430b..404d4cccf3 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -9,6 +9,18 @@
 #include "tempfile.h"
 #include "alias.h"
 
+static int git_gpg_config(const char *, const char *, void *);
+
+static void gpg_interface_lazy_init(void)
+{
+	static int done;
+
+	if (done)
+		return;
+	done = 1;
+	git_config(git_gpg_config, NULL);
+}
+
 static char *configured_signing_key;
 static const char *ssh_default_key_command, *ssh_allowed_signers, *ssh_revocation_file;
 static enum signature_trust_level configured_min_trust_level = TRUST_UNDEFINED;
@@ -632,6 +644,8 @@ int check_signature(struct signature_check *sigc,
 	struct gpg_format *fmt;
 	int status;
 
+	gpg_interface_lazy_init();
+
 	sigc->result = 'N';
 	sigc->trust_level = -1;
 
@@ -695,11 +709,13 @@ int parse_signature(const char *buf, size_t size, struct strbuf *payload, struct
 
 void set_signing_key(const char *key)
 {
+	gpg_interface_lazy_init();
+
 	free(configured_signing_key);
 	configured_signing_key = xstrdup(key);
 }
 
-int git_gpg_config(const char *var, const char *value, void *cb UNUSED)
+static int git_gpg_config(const char *var, const char *value, void *cb UNUSED)
 {
 	struct gpg_format *fmt = NULL;
 	char *fmtname = NULL;
@@ -888,6 +904,8 @@ static const char *get_ssh_key_id(void) {
 /* Returns a textual but unique representation of the signing key */
 const char *get_signing_key_id(void)
 {
+	gpg_interface_lazy_init();
+
 	if (use_format->get_key_id) {
 		return use_format->get_key_id();
 	}
@@ -898,6 +916,8 @@ const char *get_signing_key_id(void)
 
 const char *get_signing_key(void)
 {
+	gpg_interface_lazy_init();
+
 	if (configured_signing_key)
 		return configured_signing_key;
 	if (use_format->get_default_key) {
@@ -923,6 +943,8 @@ const char *gpg_trust_level_to_str(enum signature_trust_level level)
 
 int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
 {
+	gpg_interface_lazy_init();
+
 	return use_format->sign_buffer(buffer, signature, signing_key);
 }
 
diff --git a/gpg-interface.h b/gpg-interface.h
index 8a9ef41779..143cdc1c02 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -79,7 +79,6 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
  */
 const char *gpg_trust_level_to_str(enum signature_trust_level level);
 
-int git_gpg_config(const char *, const char *, void *);
 void set_signing_key(const char *);
 const char *get_signing_key(void);
 
diff --git a/sequencer.c b/sequencer.c
index 3e4a197289..a234b1ff88 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -263,10 +263,6 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
 	if (opts->action == REPLAY_REVERT && !strcmp(k, "revert.reference"))
 		opts->commit_use_reference = git_config_bool(k, v);
 
-	status = git_gpg_config(k, v, NULL);
-	if (status)
-		return status;
-
 	return git_diff_basic_config(k, v, NULL);
 }
 
diff --git a/t/t7031-verify-tag-signed-ssh.sh b/t/t7031-verify-tag-signed-ssh.sh
index 36eb86a4b1..20913b3713 100755
--- a/t/t7031-verify-tag-signed-ssh.sh
+++ b/t/t7031-verify-tag-signed-ssh.sh
@@ -200,4 +200,14 @@ test_expect_success GPGSSH 'verifying a forged tag with --format should fail sil
 	test_must_be_empty actual-forged
 '
 
+test_expect_success GPGSSH 'rev-list --format=%G' '
+	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git rev-list -1 --format="%G? %H" sixth-signed >actual &&
+	cat >expect <<-EOF &&
+	commit $(git rev-parse sixth-signed^0)
+	G $(git rev-parse sixth-signed^0)
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.39.1-418-g7876265d61

