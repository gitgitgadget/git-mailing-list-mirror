Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA46E20FCF
	for <e@80x24.org>; Thu, 30 Jun 2016 01:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbcF3B2J (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 21:28:09 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36851 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbcF3B2H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 21:28:07 -0400
Received: by mail-pf0-f175.google.com with SMTP id t190so23604285pfb.3
        for <git@vger.kernel.org>; Wed, 29 Jun 2016 18:27:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4FNBzWtt+y6cHuN2+ROtwPQwogwvKSojE8U/oeHUgnY=;
        b=l7UmyW+GfO2GXP7drDLpgJF1hjWEQOox9D9oy4N2gIeTRwaHTOUz22GrAf9AkeB8KL
         SNbv9nlkBDCxLEgX+9rEqei8X9VzGCgS2dDu89L0SxT2jTDsWT2KUal/tNNRo4MO/s8P
         BeOjcMCbt3UpnOd566J6lRGiggeRhPFPCU58k6KsYbOshygd4e0WXAx6vZb230LyEugQ
         Jp3Y5ZOjWr1XV8esi32zQvfmmFscSnDV/xXQbSRkeZy/u/tyh3mQAolFLs38Xx/CztrN
         Yu+bgEtY5Rn546a7DbmzX+WWn9hU+psnQI5tWt48X/1sI7UNeFSdneqvnAd5GcQ4yW39
         l+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4FNBzWtt+y6cHuN2+ROtwPQwogwvKSojE8U/oeHUgnY=;
        b=mx/S7Ikng9CAXyIokG+8sd/HIddMSVsDz2DmVqH25qGC90dqZ3ZeXsCzt7n0Y1Nh6l
         JIHxfPPEEIpbPZPBabVSL0ffZRPyt3GuP+rwt1xCL8Z5NSRrNxTax6CagLydhdp+9eo2
         8HrFP/X1KcqD6eLWaWnlZ79MX7R9t8+Vp1k0Ls0IRcWtxQRiG8zpmyXzZuRNGWPR8nLY
         dy3Vfmxu7NSehsFFlI3Jym7HUmlzKHqFf5+JsfP6a+FADJ3aG9U1BIzKSE5aWjJlAQI/
         hngwB2MgwNrYhX8JJZpv1qcfX6lrNEXexfvlsOxEqPItVoY2smmpnkUxlbryTFASFaug
         Gcdg==
X-Gm-Message-State: ALyK8tJzTDuHfTwoJc7tlZriCgB5/6vWTSucL1MsC+enJYk99+uVnXVm5ig98MTYs2GwDFS6
X-Received: by 10.98.216.199 with SMTP id e190mr16808532pfg.76.1467248411893;
        Wed, 29 Jun 2016 18:00:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4c6d:bc1b:299f:eb0])
        by smtp.gmail.com with ESMTPSA id rf14sm721440pab.25.2016.06.29.18.00.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 29 Jun 2016 18:00:11 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	git@vger.kernel.org, dwwang@google.com
Cc:	Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/4] push options: {pre,post}-receive hook learns about push options
Date:	Wed, 29 Jun 2016 17:59:48 -0700
Message-Id: <20160630005951.7408-2-sbeller@google.com>
X-Mailer: git-send-email 2.9.0.141.gdd65b60
In-Reply-To: <20160630005951.7408-1-sbeller@google.com>
References: <20160630005951.7408-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The environment variable GIT_PUSH_OPTION_FILE is set to the push options
separated by new line.

The code is not executed as the push options are set to NULL, nor is the
new capability advertised.

The rationale for keeping the actual options inside a file instead of
putting them directly into an environment variable has multiple reasons:

1) After a discussion about environment variables and shells, we may not
want to put user data into an environment variable (see [1] for example).

2) If a user passes multiple push options, we need to pass them to the
hooks in a way, the hook can separate them. This could be done via
multiple environment variables (e.g. have GIT_PUSH_OPTIONS_COUNT and
GIT_PUSH_OPTIONS_{0,1,2,...} set), or put it all in one environment
variable and choose an appropriate separator. That is hard to parse
in both ways. For now we'll just put it in a file separated by new line,
such that the hook scripts can pickup the variables as

    while read option ; do
        process_push_option() $option
    done < $GIT_PUSH_OPTION_FILE

3) environment variables are messed with in the run-command API depending
on the occurrence of a '=' to set or unset the variable. Having multiple
'=' is ok, such that we could have it set to a "key=value" pair.

4) When putting the options in a file, we need to take care of the race
condition of multiple clients pushing. That is actually rather easy.

5) We only inject new lines as separator into the file, so it is possible
to transmit binaries ("attach an image to a code review").

[1] 'Shellshock' https://lwn.net/Articles/614218/

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/githooks.txt |  4 ++++
 builtin/receive-pack.c     | 41 ++++++++++++++++++++++++++++-------------
 2 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index d82e912..dc80574 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -247,6 +247,8 @@ Both standard output and standard error output are forwarded to
 'git send-pack' on the other end, so you can simply `echo` messages
 for the user.
 
+The push options are available in the variable GIT_PUSH_OPTION_FILE.
+
 [[update]]
 update
 ~~~~~~
@@ -322,6 +324,8 @@ a sample script `post-receive-email` provided in the `contrib/hooks`
 directory in Git distribution, which implements sending commit
 emails.
 
+The push options are available in the variable GIT_PUSH_OPTION_FILE.
+
 [[post-update]]
 post-update
 ~~~~~~~~~~~
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 15c323a..0da6852 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -550,8 +550,16 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 	}
 }
 
+struct receive_hook_feed_state {
+	struct command *cmd;
+	int skip_broken;
+	struct strbuf buf;
+	const char *push_options_file;
+};
+
 typedef int (*feed_fn)(void *, const char **, size_t *);
-static int run_and_feed_hook(const char *hook_name, feed_fn feed, void *feed_state)
+static int run_and_feed_hook(const char *hook_name, feed_fn feed,
+			     struct receive_hook_feed_state *feed_state)
 {
 	struct child_process proc = CHILD_PROCESS_INIT;
 	struct async muxer;
@@ -567,6 +575,9 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed, void *feed_sta
 	proc.argv = argv;
 	proc.in = -1;
 	proc.stdout_to_stderr = 1;
+	if (feed_state && feed_state->push_options_file)
+		argv_array_pushf(&proc.env_array, "GIT_PUSH_OPTION_FILE=%s",
+				 feed_state->push_options_file);
 
 	if (use_sideband) {
 		memset(&muxer, 0, sizeof(muxer));
@@ -606,12 +617,6 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed, void *feed_sta
 	return finish_command(&proc);
 }
 
-struct receive_hook_feed_state {
-	struct command *cmd;
-	int skip_broken;
-	struct strbuf buf;
-};
-
 static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
 {
 	struct receive_hook_feed_state *state = state_;
@@ -634,8 +639,10 @@ static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
 	return 0;
 }
 
-static int run_receive_hook(struct command *commands, const char *hook_name,
-			    int skip_broken)
+static int run_receive_hook(struct command *commands,
+			    const char *hook_name,
+			    int skip_broken,
+			    const char *push_options_file)
 {
 	struct receive_hook_feed_state state;
 	int status;
@@ -646,6 +653,7 @@ static int run_receive_hook(struct command *commands, const char *hook_name,
 	if (feed_receive_hook(&state, NULL, NULL))
 		return 0;
 	state.cmd = commands;
+	state.push_options_file = push_options_file;
 	status = run_and_feed_hook(hook_name, feed_receive_hook, &state);
 	strbuf_release(&state.buf);
 	return status;
@@ -1316,7 +1324,8 @@ cleanup:
 
 static void execute_commands(struct command *commands,
 			     const char *unpacker_error,
-			     struct shallow_info *si)
+			     struct shallow_info *si,
+			     const char *push_options_file)
 {
 	struct command *cmd;
 	unsigned char sha1[20];
@@ -1335,7 +1344,7 @@ static void execute_commands(struct command *commands,
 
 	reject_updates_to_hidden(commands);
 
-	if (run_receive_hook(commands, "pre-receive", 0)) {
+	if (run_receive_hook(commands, "pre-receive", 0, push_options_file)) {
 		for (cmd = commands; cmd; cmd = cmd->next) {
 			if (!cmd->error_string)
 				cmd->error_string = "pre-receive hook declined";
@@ -1756,6 +1765,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 
 	if ((commands = read_head_info(&shallow)) != NULL) {
 		const char *unpack_status = NULL;
+		const char *push_options_file = NULL;
 
 		prepare_shallow_info(&si, &shallow);
 		if (!si.nr_ours && !si.nr_theirs)
@@ -1764,13 +1774,18 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 			unpack_status = unpack_with_sideband(&si);
 			update_shallow_info(commands, &si, &ref);
 		}
-		execute_commands(commands, unpack_status, &si);
+		execute_commands(commands, unpack_status, &si,
+				 push_options_file);
 		if (pack_lockfile)
 			unlink_or_warn(pack_lockfile);
 		if (report_status)
 			report(commands, unpack_status);
-		run_receive_hook(commands, "post-receive", 1);
+		run_receive_hook(commands, "post-receive", 1,
+				 push_options_file);
 		run_update_post_hook(commands);
+		if (push_options_file)
+			/* ignore errors */
+			unlink(push_options_file);
 		if (auto_gc) {
 			const char *argv_gc_auto[] = {
 				"gc", "--auto", "--quiet", NULL,
-- 
2.9.0.141.gdd65b60

