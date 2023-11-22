Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEoVChuR"
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429F1112
	for <git@vger.kernel.org>; Wed, 22 Nov 2023 11:18:42 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4083f61322fso613305e9.1
        for <git@vger.kernel.org>; Wed, 22 Nov 2023 11:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700680720; x=1701285520; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiLoCVeVr0figxewBdYEzSxmqCMtnQLP/5tvEUvlXWQ=;
        b=EEoVChuR61hbQKdPayEI+J/cXn7jRtDopUoK8jZiHj53DdUYjQSaxAzLAAk0xhWDgY
         SFU8cj4d1ErBeBeO5IcqhzBYOkjMN7W321P+PjH17ezjlgqPvIVy4vgIlmOrsePI1DSJ
         Zg6fKQLGtBHB1r0u/Tdx9bIMFTtaLcrhbqKJgS97LKo1USvGQ3yQp+K3P3ZlwrlgCKJy
         KuVup23/o0DOr7KbEy3qf+KxH19feOPv3VXzDemx4NXKLyzAGM9Fi7AYWyzEKW21T4LB
         Vo+RGOmiuTp1m2CSNhIIJowSC6xqrvmHE2DFMX3FHwVrQhDlWoTOQ0SJwR/Hg1zKDOEt
         aAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700680720; x=1701285520;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HiLoCVeVr0figxewBdYEzSxmqCMtnQLP/5tvEUvlXWQ=;
        b=Stl4ZrOapTdIWgc+NbeoyeKu2IP4ojtFU8B7AN5cZjOs7pM5Sj7a2Gu/uYW4GnMGhJ
         lz8OEeaSDff+5BqraFKBuJ4gKwd29qdiF9+teoiXUlQd2JNq5iX5pmuI3cAeusk+JQxR
         L5DpszaqS8IOXuB6xy4jO9qKLhIoiwK+tM+aK0wINpg9LT2yzVHLaJrBnb4CMK49+lF3
         kxRlzFf+PVEGx2bTdBz0VDvQdqfdkSK4+XHv83nNDOuPSpgHNavZAmeBLHl2wUWk5tQv
         jaAKjII897FeL6rxVz3tPfv9X2tulAWO5N4pQBUngZZ0H4GnsFme4rLe20z9LYKA0dDa
         /N9w==
X-Gm-Message-State: AOJu0Yz1yN77eq3uxMQG296uSmb0S/VNXkR0E70sCtQnC2zqlxgGWSk9
	gHUYPse1CqWc9VvYBGnhWo2Ms6weZGw=
X-Google-Smtp-Source: AGHT+IGaza+S7FwpiKhFKwqj9u5x9qtup1te05Z8+m4hc/raunV4c7G6IcS30wGd9+kjwjw8jWTHGg==
X-Received: by 2002:a05:600c:46cd:b0:408:4083:fbf2 with SMTP id q13-20020a05600c46cd00b004084083fbf2mr2718833wmo.22.1700680720221;
        Wed, 22 Nov 2023 11:18:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l17-20020a05600c4f1100b004063c9f68f2sm297723wmq.26.2023.11.22.11.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 11:18:39 -0800 (PST)
Message-ID: <a1686ab52f1bec4bddeaab973c9b77e55e8b539b.1700680717.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1616.git.1700680717.gitgitgadget@gmail.com>
References: <pull.1616.git.1700680717.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 22 Nov 2023 19:18:35 +0000
Subject: [PATCH 2/4] trace2: redact passwords from https:// URLs by default
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It is an unsafe practice to call something like

	git clone https://user:password@example.com/

This not only risks leaking the password "over the shoulder" or into the
readline history of the current Unix shell, it also gets logged via
Trace2 if enabled.

Let's at least avoid logging such secrets via Trace2, much like we avoid
logging secrets in `http.c`. Much like the code in `http.c` is guarded
via `GIT_TRACE_REDACT` (defaulting to `true`), we guard the new code via
`GIT_TRACE2_REDACT` (also defaulting to `true`).

The new tests added in this commit uncover leaks in `builtin/clone.c`
and `remote.c`. Therefore we need to turn off
`TEST_PASSES_SANITIZE_LEAK`. The reasons:

- We observed that `the_repository->remote_status` is not released
  properly.

- We are using `url...insteadOf` and that runs into a code path where an
  allocated URL is replaced with another URL, and the original URL is
  never released.

- `remote_states` contains plenty of `struct remote`s whose refspecs
  seem to be usually allocated by never released.

More investigation is needed here to identify the exact cause and
proper fixes for these leaks/bugs.

Co-authored-by: Jeff Hostetler <jeffhostetler@github.com>
Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0210-trace2-normal.sh |  20 ++++++-
 trace2.c                 | 120 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 136 insertions(+), 4 deletions(-)

diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index 80e76a4695e..c312657a12c 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -2,7 +2,7 @@
 
 test_description='test trace2 facility (normal target)'
 
-TEST_PASSES_SANITIZE_LEAK=true
+TEST_PASSES_SANITIZE_LEAK=false
 . ./test-lib.sh
 
 # Turn off any inherited trace2 settings for this test.
@@ -283,4 +283,22 @@ test_expect_success 'using global config with include' '
 	test_cmp expect actual
 '
 
+test_expect_success 'unsafe URLs are redacted by default' '
+	test_when_finished \
+		"rm -r trace.normal unredacted.normal clone clone2" &&
+
+	test_config_global \
+		"url.$(pwd).insteadOf" https://user:pwd@example.com/ &&
+	test_config_global trace2.configParams "core.*,remote.*.url" &&
+
+	GIT_TRACE2="$(pwd)/trace.normal" \
+		git clone https://user:pwd@example.com/ clone &&
+	! grep user:pwd trace.normal &&
+
+	GIT_TRACE2_REDACT=0 GIT_TRACE2="$(pwd)/unredacted.normal" \
+		git clone https://user:pwd@example.com/ clone2 &&
+	grep "start .* clone https://user:pwd@example.com" unredacted.normal &&
+	grep "remote.origin.url=https://user:pwd@example.com" unredacted.normal
+'
+
 test_done
diff --git a/trace2.c b/trace2.c
index 6dc74dff4c7..87d9a3a0361 100644
--- a/trace2.c
+++ b/trace2.c
@@ -20,6 +20,7 @@
 #include "trace2/tr2_tmr.h"
 
 static int trace2_enabled;
+static int trace2_redact = 1;
 
 static int tr2_next_child_id; /* modify under lock */
 static int tr2_next_exec_id; /* modify under lock */
@@ -227,6 +228,8 @@ void trace2_initialize_fl(const char *file, int line)
 	if (!tr2_tgt_want_builtins())
 		return;
 	trace2_enabled = 1;
+	if (!git_env_bool("GIT_TRACE2_REDACT", 1))
+		trace2_redact = 0;
 
 	tr2_sid_get();
 
@@ -247,12 +250,93 @@ int trace2_is_enabled(void)
 	return trace2_enabled;
 }
 
+/*
+ * Redacts an argument, i.e. ensures that no password in
+ * https://user:password@host/-style URLs is logged.
+ *
+ * Returns the original if nothing needed to be redacted.
+ * Returns a pointer that needs to be `free()`d otherwise.
+ */
+static const char *redact_arg(const char *arg)
+{
+	const char *p, *colon;
+	size_t at;
+
+	if (!trace2_redact ||
+	    (!skip_prefix(arg, "https://", &p) &&
+	     !skip_prefix(arg, "http://", &p)))
+		return arg;
+
+	at = strcspn(p, "@/");
+	if (p[at] != '@')
+		return arg;
+
+	colon = memchr(p, ':', at);
+	if (!colon)
+		return arg;
+
+	return xstrfmt("%.*s:<REDACTED>%s", (int)(colon - arg), arg, p + at);
+}
+
+/*
+ * Redacts arguments in an argument list.
+ *
+ * Returns the original if nothing needed to be redacted.
+ * Otherwise, returns a new array that needs to be released
+ * via `free_redacted_argv()`.
+ */
+static const char **redact_argv(const char **argv)
+{
+	int i, j;
+	const char *redacted = NULL;
+	const char **ret;
+
+	if (!trace2_redact)
+		return argv;
+
+	for (i = 0; argv[i]; i++)
+		if ((redacted = redact_arg(argv[i])) != argv[i])
+			break;
+
+	if (!argv[i])
+		return argv;
+
+	for (j = 0; argv[j]; j++)
+		; /* keep counting */
+
+	ALLOC_ARRAY(ret, j + 1);
+	ret[j] = NULL;
+
+	for (j = 0; j < i; j++)
+		ret[j] = argv[j];
+	ret[i] = redacted;
+	for (++i; argv[i]; i++) {
+		redacted = redact_arg(argv[i]);
+		ret[i] = redacted ? redacted : argv[i];
+	}
+
+	return ret;
+}
+
+static void free_redacted_argv(const char **redacted, const char **argv)
+{
+	int i;
+
+	if (redacted != argv) {
+		for (i = 0; argv[i]; i++)
+			if (redacted[i] != argv[i])
+				free((void *)redacted[i]);
+		free((void *)redacted);
+	}
+}
+
 void trace2_cmd_start_fl(const char *file, int line, const char **argv)
 {
 	struct tr2_tgt *tgt_j;
 	int j;
 	uint64_t us_now;
 	uint64_t us_elapsed_absolute;
+	const char **redacted;
 
 	if (!trace2_enabled)
 		return;
@@ -260,10 +344,14 @@ void trace2_cmd_start_fl(const char *file, int line, const char **argv)
 	us_now = getnanotime() / 1000;
 	us_elapsed_absolute = tr2tls_absolute_elapsed(us_now);
 
+	redacted = redact_argv(argv);
+
 	for_each_wanted_builtin (j, tgt_j)
 		if (tgt_j->pfn_start_fl)
 			tgt_j->pfn_start_fl(file, line, us_elapsed_absolute,
-					    argv);
+					    redacted);
+
+	free_redacted_argv(redacted, argv);
 }
 
 void trace2_cmd_exit_fl(const char *file, int line, int code)
@@ -409,6 +497,7 @@ void trace2_child_start_fl(const char *file, int line,
 	int j;
 	uint64_t us_now;
 	uint64_t us_elapsed_absolute;
+	const char **orig_argv = cmd->args.v;
 
 	if (!trace2_enabled)
 		return;
@@ -419,10 +508,24 @@ void trace2_child_start_fl(const char *file, int line,
 	cmd->trace2_child_id = tr2tls_locked_increment(&tr2_next_child_id);
 	cmd->trace2_child_us_start = us_now;
 
+	/*
+	 * The `pfn_child_start_fl` API takes a `struct child_process`
+	 * rather than a simple `argv` for the child because some
+	 * targets make use of the additional context bits/values. So
+	 * temporarily replace the original argv (inside the `strvec`)
+	 * with a possibly redacted version.
+	 */
+	cmd->args.v = redact_argv(orig_argv);
+
 	for_each_wanted_builtin (j, tgt_j)
 		if (tgt_j->pfn_child_start_fl)
 			tgt_j->pfn_child_start_fl(file, line,
 						  us_elapsed_absolute, cmd);
+
+	if (cmd->args.v != orig_argv) {
+		free_redacted_argv(cmd->args.v, orig_argv);
+		cmd->args.v = orig_argv;
+	}
 }
 
 void trace2_child_exit_fl(const char *file, int line, struct child_process *cmd,
@@ -493,6 +596,7 @@ int trace2_exec_fl(const char *file, int line, const char *exe,
 	int exec_id;
 	uint64_t us_now;
 	uint64_t us_elapsed_absolute;
+	const char **redacted;
 
 	if (!trace2_enabled)
 		return -1;
@@ -502,10 +606,14 @@ int trace2_exec_fl(const char *file, int line, const char *exe,
 
 	exec_id = tr2tls_locked_increment(&tr2_next_exec_id);
 
+	redacted = redact_argv(argv);
+
 	for_each_wanted_builtin (j, tgt_j)
 		if (tgt_j->pfn_exec_fl)
 			tgt_j->pfn_exec_fl(file, line, us_elapsed_absolute,
-					   exec_id, exe, argv);
+					   exec_id, exe, redacted);
+
+	free_redacted_argv(redacted, argv);
 
 	return exec_id;
 }
@@ -637,13 +745,19 @@ void trace2_def_param_fl(const char *file, int line, const char *param,
 {
 	struct tr2_tgt *tgt_j;
 	int j;
+	const char *redacted;
 
 	if (!trace2_enabled)
 		return;
 
+	redacted = redact_arg(value);
+
 	for_each_wanted_builtin (j, tgt_j)
 		if (tgt_j->pfn_param_fl)
-			tgt_j->pfn_param_fl(file, line, param, value, kvi);
+			tgt_j->pfn_param_fl(file, line, param, redacted, kvi);
+
+	if (redacted != value)
+		free((void *)redacted);
 }
 
 void trace2_def_repo_fl(const char *file, int line, struct repository *repo)
-- 
gitgitgadget

