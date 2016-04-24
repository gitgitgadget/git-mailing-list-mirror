From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 83/83] builtin/am: use apply api in run_apply()
Date: Sun, 24 Apr 2016 15:39:49 +0200
Message-ID: <1461505189-16234-4-git-send-email-chriscool@tuxfamily.org>
References: <1461505189-16234-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:40:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKGs-0001uG-8K
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188AbcDXNkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:40:16 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:32847 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbcDXNkI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:40:08 -0400
Received: by mail-wm0-f51.google.com with SMTP id 127so17930782wmz.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UX0pNAnKUYpBI4HiqdJgD12JGgmfR8pKw33/fzIkQgU=;
        b=Ko+02RoAJ6mKUHd+CPCerOEu2oec46Dtl6UdUIBVGNZzqCSs3BE5YdLAlr834iJS/O
         0ExKTxDJAcndF6rv2Du7U9C6zO7fPD3axCuyvWz/PUOWvClmnxlUCrBpqKUU+4Cp1lPC
         2rWRE8sExD1drkjj9BU/P62NimIuu+SPkTS69AUjfl8uYmzEWfZMbLVDEzmdGhVt2qhl
         pc3ixw5z3xKsqaHa7ue3goVrNWd8DykMQIWuEMtzUzI8RTvno2tsErnDO0omdNbrY3ld
         F0smcfyAWPIiloHNVsro0U0ENb+lXek3D0v+dRjriZZfIT99twq0zca+ywwh6cj13EhN
         evjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UX0pNAnKUYpBI4HiqdJgD12JGgmfR8pKw33/fzIkQgU=;
        b=gZiZ8rhtUIamJm8OMshMeBvmjLqWP/HC57SzNcc4VLa26cq6w2NWZx6sGw6/qy3aqa
         Fbp842FrXNo5U2s2WeDsd5KtoEc2CXokeqbNq4uExvOorsBD67jYUJB7+4b0MD9K+8n3
         tk9mXNOCs+VW56t2+c3FDLpa7lpwHg9RE142nej+Yup5qaXjWZfTDQTnYM1mK/oDaLlW
         XsPpgnn05f2Y6t65pJsY3uWr+ymPCOcfkMhvM+pcQJDU+rw6r3K9bF88FjuEvnIUIFIM
         KL/umuzH5VSGg+GM+V2RRGC2naIiQsraVXagZ/0KCoQ3/OMXUh4wDd92SkyvUdM5KPRM
         RnNQ==
X-Gm-Message-State: AOPr4FU+Z2rEDxdgpzSXbHxmVZTQtJp3INEQOombGgUSpWW33LBYkVu5Aj8rZMyCF1bZIA==
X-Received: by 10.28.129.6 with SMTP id c6mr7326915wmd.75.1461505206615;
        Sun, 24 Apr 2016 06:40:06 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id by7sm18530771wjc.18.2016.04.24.06.40.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:40:05 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461505189-16234-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292405>

This replaces run_apply() implementation with a new one that
uses the apply api that has been previously prepared in
apply.c and apply.h.

This shoud improve performance a lot in certain cases.

As the previous implementation was creating a new `git apply`
process to apply each patch, it could be slow on systems like
Windows where it is costly to create new processes.

Also the new `git apply` process had to read the index from
disk, and when the process was done the calling process
discarded its own index and read back from disk the new
index that had been created by the `git apply` process.

This could be very inefficient with big repositories that
have big index files, especially when the system decided
that it was a good idea to run the `git apply` processes on
a different processor core.

Also eliminating index reads enables further performance
improvements by using:

`git update-index --split-index`

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/am.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 85 insertions(+), 18 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index d003939..85a77d7 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -28,6 +28,7 @@
 #include "rerere.h"
 #include "prompt.h"
 #include "mailinfo.h"
+#include "apply.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -1522,39 +1523,105 @@ static int parse_mail_rebase(struct am_state *state, const char *mail)
  */
 static int run_apply(const struct am_state *state, const char *index_file)
 {
-	struct child_process cp = CHILD_PROCESS_INIT;
-
-	cp.git_cmd = 1;
-
-	if (index_file)
-		argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s", index_file);
+	struct argv_array apply_paths = ARGV_ARRAY_INIT;
+	struct argv_array apply_opts = ARGV_ARRAY_INIT;
+	struct apply_state apply_state;
+	int save_stdout_fd, save_stderr_fd;
+	int res, opts_left;
+	char *save_index_file;
+
+	struct option am_apply_options[] = {
+		{ OPTION_CALLBACK, 0, "whitespace", &apply_state, N_("action"),
+			N_("detect new or modified lines that have whitespace errors"),
+			0, apply_option_parse_whitespace },
+		{ OPTION_CALLBACK, 0, "ignore-space-change", &apply_state, NULL,
+			N_("ignore changes in whitespace when finding context"),
+			PARSE_OPT_NOARG, apply_option_parse_space_change },
+		{ OPTION_CALLBACK, 0, "ignore-whitespace", &apply_state, NULL,
+			N_("ignore changes in whitespace when finding context"),
+			PARSE_OPT_NOARG, apply_option_parse_space_change },
+		{ OPTION_CALLBACK, 0, "directory", &apply_state, N_("root"),
+			N_("prepend <root> to all filenames"),
+			0, apply_option_parse_directory },
+		{ OPTION_CALLBACK, 0, "exclude", &apply_state, N_("path"),
+			N_("don't apply changes matching the given path"),
+			0, apply_option_parse_exclude },
+		{ OPTION_CALLBACK, 0, "include", &apply_state, N_("path"),
+			N_("apply changes matching the given path"),
+			0, apply_option_parse_include },
+		OPT_INTEGER('C', NULL, &apply_state.p_context,
+				N_("ensure at least <n> lines of context match")),
+		{ OPTION_CALLBACK, 'p', NULL, &apply_state, N_("num"),
+			N_("remove <num> leading slashes from traditional diff paths"),
+			0, apply_option_parse_p },
+		OPT_BOOL(0, "reject", &apply_state.apply_with_reject,
+			N_("leave the rejected hunks in corresponding *.rej files")),
+		OPT_END()
+	};
 
 	/*
 	 * If we are allowed to fall back on 3-way merge, don't give false
 	 * errors during the initial attempt.
 	 */
+
 	if (state->threeway && !index_file) {
-		cp.no_stdout = 1;
-		cp.no_stderr = 1;
+		save_stdout_fd = dup(1);
+		dup_devnull(1);
+		save_stderr_fd = dup(2);
+		dup_devnull(2);
 	}
 
-	argv_array_push(&cp.args, "apply");
+	if (index_file) {
+		save_index_file = get_index_file();
+		set_index_file((char *)index_file);
+	}
 
-	argv_array_pushv(&cp.args, state->git_apply_opts.argv);
+	if (init_apply_state(&apply_state, NULL))
+		die("init_apply_state() failed");
+
+	argv_array_push(&apply_opts, "apply");
+	argv_array_pushv(&apply_opts, state->git_apply_opts.argv);
+
+	opts_left = parse_options(apply_opts.argc, apply_opts.argv,
+				  NULL, am_apply_options, NULL, 0);
+
+	if (opts_left != 0)
+		die("unknown option passed thru to git apply");
 
 	if (index_file)
-		argv_array_push(&cp.args, "--cached");
+		apply_state.cached = 1;
 	else
-		argv_array_push(&cp.args, "--index");
+		apply_state.check_index = 1;
 
-	argv_array_push(&cp.args, am_path(state, "patch"));
+	if (check_apply_state(&apply_state, 0))
+		die("check_apply_state() failed");
 
-	if (run_command(&cp))
-		return -1;
+	argv_array_push(&apply_paths, am_path(state, "patch"));
 
-	/* Reload index as git-apply will have modified it. */
-	discard_cache();
-	read_cache_from(index_file ? index_file : get_index_file());
+	res = apply_all_patches(&apply_state, apply_paths.argc, apply_paths.argv, 0);
+
+	/* Restore stdout and stderr */
+	if (state->threeway && !index_file) {
+		dup2(save_stdout_fd, 1);
+		close(save_stdout_fd);
+		dup2(save_stderr_fd, 2);
+		close(save_stderr_fd);
+	}
+
+	if (index_file)
+		set_index_file(save_index_file);
+
+	argv_array_clear(&apply_paths);
+	argv_array_clear(&apply_opts);
+
+	if (res)
+		return res;
+
+	if (index_file) {
+		/* Reload index as apply_all_patches() will have modified it. */
+		discard_cache();
+		read_cache_from(index_file);
+	}
 
 	return 0;
 }
-- 
2.8.1.300.g5fed0c0
