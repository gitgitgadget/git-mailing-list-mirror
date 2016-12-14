Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6311A1FF76
	for <e@80x24.org>; Wed, 14 Dec 2016 08:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755081AbcLNIeZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 03:34:25 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:53242 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754837AbcLNIeY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 03:34:24 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3tdqcY2T1Kz5tly;
        Wed, 14 Dec 2016 09:34:21 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id EDF431E61;
        Wed, 14 Dec 2016 09:34:20 +0100 (CET)
Subject: Re: [PATCH v2 28/34] run_command_opt(): optionally hide stderr when
 the command succeeds
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
 <cover.1481642927.git.johannes.schindelin@gmx.de>
 <1e82aeabb906a35175362418b2b4957fae50c3b0.1481642927.git.johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <2637bed1-c36f-32f6-b255-ea32da76d792@kdbg.org>
Date:   Wed, 14 Dec 2016 09:34:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <1e82aeabb906a35175362418b2b4957fae50c3b0.1481642927.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.12.2016 um 16:32 schrieb Johannes Schindelin:
> This will be needed to hide the output of `git commit` when the
> sequencer handles an interactive rebase's script.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  run-command.c | 23 +++++++++++++++++++++++
>  run-command.h |  1 +
>  2 files changed, 24 insertions(+)
> 
> diff --git a/run-command.c b/run-command.c
> index ca905a9e80..5bb957afdd 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -589,6 +589,29 @@ int run_command_v_opt_cd_env(const char **argv, int opt, const char *dir, const
>  	cmd.clean_on_exit = opt & RUN_CLEAN_ON_EXIT ? 1 : 0;
>  	cmd.dir = dir;
>  	cmd.env = env;
> +
> +	if (opt & RUN_HIDE_STDERR_ON_SUCCESS) {
> +		struct strbuf buf = STRBUF_INIT;
> +		int res;
> +
> +		cmd.err = -1;
> +		if (start_command(&cmd) < 0)
> +			return -1;
> +
> +		if (strbuf_read(&buf, cmd.err, 0) < 0) {
> +			close(cmd.err);
> +			finish_command(&cmd); /* throw away exit code */
> +			return -1;
> +		}
> +
> +		close(cmd.err);
> +		res = finish_command(&cmd);
> +		if (res)
> +			fputs(buf.buf, stderr);
> +		strbuf_release(&buf);
> +		return res;
> +	}
> +
>  	return run_command(&cmd);
>  }

Clearly, this is a bolted-on feature. It's not the worst move that you
did not advertise the flag in Documentation/technical/api-run-command.txt...

I wanted to see what it would look like if we make it the caller's
responsibility to throw away stderr. The patch is below, as fixup
of patch 29/34. The change is gross, but the end result is not that
bad, though not really a delightful read, either, mostly due to the
strange cleanup semantics of the start_command/finish_command combo,
so... I dunno.

diff --git a/sequencer.c b/sequencer.c
index 41be4cde16..f375880bd7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -660,15 +660,16 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 			  int cleanup_commit_message)
 {
 	char **env = NULL;
-	struct argv_array array;
-	int opt = RUN_GIT_CMD, rc;
+	int rc;
 	const char *value;
+	struct strbuf errout = STRBUF_INIT;
+	struct child_process cmd = CHILD_PROCESS_INIT;
+
+	cmd.git_cmd = 1;
 
 	if (is_rebase_i(opts)) {
-		if (!edit) {
-			opt |= RUN_COMMAND_STDOUT_TO_STDERR;
-			opt |= RUN_HIDE_STDERR_ON_SUCCESS;
-		}
+		if (!edit)
+			cmd.stdout_to_stderr = 1;
 
 		env = read_author_script();
 		if (!env) {
@@ -679,36 +680,58 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 		}
 	}
 
-	argv_array_init(&array);
-	argv_array_push(&array, "commit");
-	argv_array_push(&array, "-n");
+	argv_array_push(&cmd.args, "commit");
+	argv_array_push(&cmd.args, "-n");
 
 	if (amend)
-		argv_array_push(&array, "--amend");
+		argv_array_push(&cmd.args, "--amend");
 	if (opts->gpg_sign)
-		argv_array_pushf(&array, "-S%s", opts->gpg_sign);
+		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
 	if (opts->signoff)
-		argv_array_push(&array, "-s");
+		argv_array_push(&cmd.args, "-s");
 	if (defmsg)
-		argv_array_pushl(&array, "-F", defmsg, NULL);
+		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
 	if (cleanup_commit_message)
-		argv_array_push(&array, "--cleanup=strip");
+		argv_array_push(&cmd.args, "--cleanup=strip");
 	if (edit)
-		argv_array_push(&array, "-e");
+		argv_array_push(&cmd.args, "-e");
 	else if (!cleanup_commit_message &&
 		 !opts->signoff && !opts->record_origin &&
 		 git_config_get_value("commit.cleanup", &value))
-		argv_array_push(&array, "--cleanup=verbatim");
+		argv_array_push(&cmd.args, "--cleanup=verbatim");
 
 	if (allow_empty)
-		argv_array_push(&array, "--allow-empty");
+		argv_array_push(&cmd.args, "--allow-empty");
 
 	if (opts->allow_empty_message)
-		argv_array_push(&array, "--allow-empty-message");
+		argv_array_push(&cmd.args, "--allow-empty-message");
+
+	cmd.env = (const char *const *)env;
+
+	if (cmd.stdout_to_stderr) {
+		/* hide stderr on success */
+		cmd.err = -1;
+		rc = -1;
+		if (start_command(&cmd) < 0)
+			goto cleanup;
+
+		if (strbuf_read(&errout, cmd.err, 0) < 0) {
+			close(cmd.err);
+			finish_command(&cmd); /* throw away exit code */
+			goto cleanup;
+		}
+
+		close(cmd.err);
+		rc = finish_command(&cmd);
+		if (rc)
+			fputs(errout.buf, stderr);
+	} else {
+		rc = run_command(&cmd);
+	}
 
-	rc = run_command_v_opt_cd_env(array.argv, opt, NULL,
-			(const char *const *)env);
-	argv_array_clear(&array);
+cleanup:
+	child_process_clear(&cmd);
+	strbuf_release(&errout);
 	free(env);
 
 	return rc;
-- 
2.11.0.79.g263f27a

