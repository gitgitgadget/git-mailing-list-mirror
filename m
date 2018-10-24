Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9024A1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 07:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbeJXQE5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 12:04:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:52434 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730027AbeJXQE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 12:04:57 -0400
Received: (qmail 7477 invoked by uid 109); 24 Oct 2018 07:38:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 24 Oct 2018 07:38:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2221 invoked by uid 111); 24 Oct 2018 07:37:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Oct 2018 03:37:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Oct 2018 03:38:00 -0400
Date:   Wed, 24 Oct 2018 03:38:00 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] run-command: mark path lookup errors with ENOENT
Message-ID: <20181024073800.GB31202@sigill.intra.peff.net>
References: <20181024073637.GA31069@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181024073637.GA31069@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since commit e3a434468f (run-command: use the
async-signal-safe execv instead of execvp, 2017-04-19),
prepare_cmd() does its own PATH lookup for any commands we
run (on non-Windows platforms).

However, its logic does not match the old execvp call when
we fail to find a matching entry in the PATH. Instead of
feeding the name directly to execv, execvp would consider
that an ENOENT error. By continuing and passing the name
directly to execv, we effectively behave as if "." was
included at the end of the PATH. This can have confusing and
even dangerous results.

The fix itself is pretty straight-forward. There's a new
test in t0061 to cover this explicitly, and I've also added
a duplicate of the ENOENT test to ensure that we return the
correct errno for this case.

Signed-off-by: Jeff King <peff@peff.net>
---
 run-command.c          | 20 ++++++++++++++++----
 t/t0061-run-command.sh | 13 ++++++++++++-
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/run-command.c b/run-command.c
index 84b883c213..639ea5ac33 100644
--- a/run-command.c
+++ b/run-command.c
@@ -380,7 +380,7 @@ static void child_err_spew(struct child_process *cmd, struct child_err *cerr)
 	set_error_routine(old_errfn);
 }
 
-static void prepare_cmd(struct argv_array *out, const struct child_process *cmd)
+static int prepare_cmd(struct argv_array *out, const struct child_process *cmd)
 {
 	if (!cmd->argv[0])
 		BUG("command is empty");
@@ -403,16 +403,22 @@ static void prepare_cmd(struct argv_array *out, const struct child_process *cmd)
 	/*
 	 * If there are no '/' characters in the command then perform a path
 	 * lookup and use the resolved path as the command to exec.  If there
-	 * are no '/' characters or if the command wasn't found in the path,
-	 * have exec attempt to invoke the command directly.
+	 * are '/' characters, we have exec attempt to invoke the command
+	 * directly.
 	 */
 	if (!strchr(out->argv[1], '/')) {
 		char *program = locate_in_PATH(out->argv[1]);
 		if (program) {
 			free((char *)out->argv[1]);
 			out->argv[1] = program;
+		} else {
+			argv_array_clear(out);
+			errno = ENOENT;
+			return -1;
 		}
 	}
+
+	return 0;
 }
 
 static char **prep_childenv(const char *const *deltaenv)
@@ -719,6 +725,12 @@ int start_command(struct child_process *cmd)
 	struct child_err cerr;
 	struct atfork_state as;
 
+	if (prepare_cmd(&argv, cmd) < 0) {
+		failed_errno = errno;
+		cmd->pid = -1;
+		goto end_of_spawn;
+	}
+
 	if (pipe(notify_pipe))
 		notify_pipe[0] = notify_pipe[1] = -1;
 
@@ -729,7 +741,6 @@ int start_command(struct child_process *cmd)
 		set_cloexec(null_fd);
 	}
 
-	prepare_cmd(&argv, cmd);
 	childenv = prep_childenv(cmd->env);
 	atfork_prepare(&as);
 
@@ -910,6 +921,7 @@ int start_command(struct child_process *cmd)
 }
 #endif
 
+end_of_spawn:
 	if (cmd->pid < 0) {
 		if (need_in)
 			close_pair(fdin);
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 3e131c5325..cf932c8514 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -12,10 +12,14 @@ cat >hello-script <<-EOF
 	cat hello-script
 EOF
 
-test_expect_success 'start_command reports ENOENT' '
+test_expect_success 'start_command reports ENOENT (slash)' '
 	test-tool run-command start-command-ENOENT ./does-not-exist
 '
 
+test_expect_success 'start_command reports ENOENT (no slash)' '
+	test-tool run-command start-command-ENOENT does-not-exist
+'
+
 test_expect_success 'run_command can run a command' '
 	cat hello-script >hello.sh &&
 	chmod +x hello.sh &&
@@ -25,6 +29,13 @@ test_expect_success 'run_command can run a command' '
 	test_must_be_empty err
 '
 
+test_expect_success 'run_command is restricted to PATH' '
+	write_script should-not-run <<-\EOF &&
+	echo yikes
+	EOF
+	test_must_fail test-tool run-command run-command should-not-run
+'
+
 test_expect_success !MINGW 'run_command can run a script without a #! line' '
 	cat >hello <<-\EOF &&
 	cat hello-script
-- 
2.19.1.1094.gd480080bf6
