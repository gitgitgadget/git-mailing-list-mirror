Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65EAC1F45D
	for <e@80x24.org>; Mon, 12 Aug 2019 21:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfHLVfq (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 17:35:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32793 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfHLVfp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 17:35:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id n190so9321968pgn.0
        for <git@vger.kernel.org>; Mon, 12 Aug 2019 14:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=RNK5GunDI8/5lxwgXMYn/H/s4sE4TKLor0aZz4uKfsI=;
        b=Hg3DcQq3nbAWD5pYQ3zZVSafqOZAcRWWTEbrAe1WmsRYzq8KclmtE68zYC30CfdTu0
         R+gyuJfr2x5mhuGwAVx6RHnNkJLdjkPOdPEwj9Oe86qbuQ3FphXQvBQrX84d5oXomsR2
         cWSQtVaiiYOFG5R86vjbYBH2iw8ShZg8p9yUwfrWFzHTmr2ee/RfYaNAwmwSV1WQik7Q
         OjC2X9SwDzIeKxrd4oZg5DxE7cM1SEJMvtBFCT2E0UhM0Sv2rEV+tWrg4aBnGP59nTs+
         l6Qdwkd/BNn5qT9UJiyN0UGpvrL72cEv+fEcbmPNGPMTNcSAKmYPak1DYEb0fWikJUbq
         0uQg==
X-Gm-Message-State: APjAAAWrEJffk8GmlEJw5iXN0lOBw8fw4RwJGashe7q21de6Au574cFA
        K8xUTXgW97yHKiMhAAfp0dVYBQ==
X-Google-Smtp-Source: APXvYqw+bodooOm3UNWSYBqd0CxrwVpmQVkkL57BT6Csql/huOZOVXjKc8coDGDgLMFtwdR0Vp54IA==
X-Received: by 2002:a17:90a:a78b:: with SMTP id f11mr1267055pjq.16.1565645744227;
        Mon, 12 Aug 2019 14:35:44 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id w189sm6568289pfb.35.2019.08.12.14.35.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 14:35:43 -0700 (PDT)
Subject: [PATCH v2 2/5] fetch: Add the "--fetch-jobs" option
Date:   Mon, 12 Aug 2019 14:34:45 -0700
Message-Id: <20190812213448.2649-3-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190812213448.2649-1-palmer@sifive.com>
References: <20190812213448.2649-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     peff@peff.net, e@80x24.org, chriscool@tuxfamily.org,
        gitster@pobox.com, jonathantanmy@google.com, tboegi@web.de,
        bwilliams.eng@gmail.com, jeffhost@microsoft.com,
        Palmer Dabbelt <palmer@sifive.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This argument allows users to select the number of jobs that will run in
parallel when fetching, with each job fetching from a different remote.
This is particularly useful when fetching from many remotes that change
slowly on a high latency link, as the fetch time is dominated by
handshake latency -- probably not the most common use case, but one that
ends up frusturating me with some frequency.

This patch implements --fetch-jobs via run_processes_parallel_tr2(),
which allows the user to restrict the amount of parallelism.  While this
adds a lot of boilerplate to the implementation, the pattern is fairly
straight-forward and matches the existing submodule parallel fetch code.
The submodule version of this is a lot more complicated and does things
like retrying and scheduling I/O, but I don't get bit by those issues so
it didn't seem worth the effort.

The speedup is quite noticable for me, even when I'm on a fast link --
my Linux fetches go from 6 seconds to 2 seconds, for example.

I've given this a quick test locally, but haven't done anything
exhaustive like attempting to fetch against broken remotes (where the
intent is that the other remotes are fetched and the result is an
error).

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 Documentation/fetch-options.txt |   5 ++
 builtin/fetch.c                 | 141 +++++++++++++++++++++++++++-----
 2 files changed, 126 insertions(+), 20 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 3c9b4f9e0951..dbd2add686dd 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -165,6 +165,11 @@ ifndef::git-pull[]
 	submodules will be faster. By default submodules will be fetched
 	one at a time.
 
+--fetch-jobs=<n>::
+	Number of parallel children to be used for fetching.  Each will fetch
+	from different remotes, such that fetching from many remotes will be
+	faster.  By default remotes will be fetched from one at a time.
+
 --no-recurse-submodules::
 	Disable recursive fetching of submodules (this has the same effect as
 	using the `--recurse-submodules=no` option).
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8aa6a0caf1ab..fa12ad44e7d9 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -55,6 +55,7 @@ static int progress = -1;
 static int enable_auto_gc = 1;
 static int tags = TAGS_DEFAULT, unshallow, update_shallow, deepen;
 static int max_children_for_submodules = 1;
+static int max_children_for_fetch = 1;
 static enum transport_family family;
 static const char *depth;
 static const char *deepen_since;
@@ -136,6 +137,8 @@ static struct option builtin_fetch_options[] = {
 		    N_("do not fetch all tags (--no-tags)"), TAGS_UNSET),
 	OPT_INTEGER('j', "jobs", &max_children_for_submodules,
 		    N_("number of submodules fetched in parallel")),
+	OPT_INTEGER(0, "fetch-jobs", &max_children_for_fetch,
+		    N_("number of remotes fetched in parallel")),
 	OPT_BOOL('p', "prune", &prune,
 		 N_("prune remote-tracking branches no longer on remote")),
 	OPT_BOOL('P', "prune-tags", &prune_tags,
@@ -1463,10 +1466,100 @@ static void add_options_to_argv(struct argv_array *argv)
 
 }
 
-static int fetch_multiple(struct string_list *list)
+/*
+ * Support for fetching multiple remotes in parallel.  This is spread over
+ * multiple functions and structures, all of which are helpers for
+ * fench_multiple().  The general idea is that there is a single struct
+ * fetch_remote, which contains the entire state for a fetch_multiple()
+ * instance.
+ */
+struct fetch_remote_task {
+	int in_use;
+	struct argv_array argv;
+};
+
+struct fetch_remote {
+	struct string_list *all_remotes;
+	int next_remote_index;
+	struct fetch_remote_task *all_tasks;
+	int task_count;
+	int result;
+};
+
+static int next_remote_to_fetch(struct child_process *cp,
+				struct strbuf *out,
+				void *state_uncast,
+				void **task_state_out)
+{
+	int i;
+	struct fetch_remote *state = state_uncast;
+	struct fetch_remote_task *task_state = NULL;
+	const char *remote_name;
+
+	if (state->next_remote_index >= state->all_remotes->nr)
+		return 0;
+
+	remote_name = state->all_remotes->items[state->next_remote_index].string;
+	state->next_remote_index++;
+
+	/*
+	 * Finds somewhere to store the state for a task.  This is guarnteed to
+	 * succeed because there are always enough tasks allocated to cover the
+	 * number that have been requested to run in parallel.  Rather than
+	 * bothering with some sort of free list, this just brute force
+	 * searches for a free task.  The assumption is that there aren't that
+	 * many tasks to look through.
+	 */
+	for (i = 0; i < state->task_count; ++i) {
+		if (!state->all_tasks[i].in_use) {
+			task_state = state->all_tasks + i;
+			break;
+		}
+	}
+	assert(task_state != NULL);
+	task_state->in_use = 1;
+
+	*task_state_out = task_state;
+	argv_array_push(&task_state->argv, remote_name);
+	cp->argv = task_state->argv.argv;
+	cp->git_cmd = 1;
+
+	printf(_("Fetching %s\n"), remote_name);
+
+	return 1;
+}
+
+static int remote_fetch_failed_to_start(struct strbuf *out,
+					void *state_uncast,
+					void *task_state_uncast)
+{
+	struct fetch_remote *state = state_uncast;
+	struct fetch_remote_task *task_state = task_state_uncast;
+	assert(task_state != NULL);
+	argv_array_pop(&task_state->argv);
+	task_state->in_use = 0;
+	state->result |= -1;
+	return 0;
+}
+
+static int remote_fetch_finished(int result,
+				 struct strbuf *out,
+				 void *state_uncast,
+				 void *task_state_uncast)
+{
+	struct fetch_remote *state = state_uncast;
+	struct fetch_remote_task *task_state = task_state_uncast;
+	assert(task_state != NULL);
+	argv_array_pop(&task_state->argv);
+	task_state->in_use = 0;
+	state->result |= result;
+	return 0;
+}
+
+static int fetch_multiple(struct string_list *all_remotes, int max_children)
 {
 	int i, result = 0;
-	struct argv_array argv = ARGV_ARRAY_INIT;
+	struct fetch_remote state;
 
 	if (!append && !dry_run) {
 		int errcode = truncate_fetch_head();
@@ -1474,23 +1567,31 @@ static int fetch_multiple(struct string_list *list)
 			return errcode;
 	}
 
-	argv_array_pushl(&argv, "fetch", "--append", "--no-auto-gc", NULL);
-	add_options_to_argv(&argv);
-
-	for (i = 0; i < list->nr; i++) {
-		const char *name = list->items[i].string;
-		argv_array_push(&argv, name);
-		if (verbosity >= 0)
-			printf(_("Fetching %s\n"), name);
-		if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
-			error(_("Could not fetch %s"), name);
-			result = 1;
-		}
-		argv_array_pop(&argv);
-	}
-
-	argv_array_clear(&argv);
-	return result;
+	state.all_remotes = all_remotes;
+	state.next_remote_index = 0;
+	state.all_tasks = xcalloc(sizeof(*state.all_tasks), max_children);
+	state.task_count = max_children;
+	state.result = 0;
+
+	for (i = 0; i < max_children; ++i) {
+		struct argv_array *argv = &state.all_tasks[i].argv;
+		state.all_tasks[i].in_use = 0;
+		argv_array_init(argv);
+		argv_array_pushl(argv, "fetch", "--append", "--no-auto-gc", NULL);
+		add_options_to_argv(argv);
+	};
+
+	result = run_processes_parallel_tr2(max_children,
+					    &next_remote_to_fetch,
+					    &remote_fetch_failed_to_start,
+					    &remote_fetch_finished,
+					    &state,
+					    "fetch", "parallel");
+
+	for (i = 0; i < max_children; ++i)
+		argv_array_clear(&state.all_tasks[i].argv);
+	free(state.all_tasks);
+	return result | state.result;
 }
 
 /*
@@ -1704,7 +1805,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			die(_("--filter can only be used with the remote "
 			      "configured in extensions.partialclone"));
 		/* TODO should this also die if we have a previous partial-clone? */
-		result = fetch_multiple(&list);
+		result = fetch_multiple(&list, max_children_for_fetch);
 	}
 
 	if (!result && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
-- 
2.21.0

