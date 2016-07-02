Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC50D2018A
	for <e@80x24.org>; Sat,  2 Jul 2016 00:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbcGBAUZ (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 20:20:25 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34082 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbcGBAUW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 20:20:22 -0400
Received: by mail-pa0-f43.google.com with SMTP id bz2so42699905pad.1
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 17:20:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c3rUhllVW+QK5yT2/eeZbDx//j1Z4zdaesP59BypPF0=;
        b=TX2Iyb0wZsW68s1YzFF4avlBHd7m/hYHMnlVlzocUeOQ5qSllBVMlwK0/K5GeuWZ88
         NLxVRRpN3BAiWwdjmC38SWAQ+4mXeQzxaK6yFLqS/itddBb+dhTvFrYKpERuWK3hXES+
         xXBwazldQd+jYSxwHgPtVzcFxgh0IfIrWASqVx3ysf6v+RF7ych0CWaUKvFzOcWj4CLi
         jJfKV0MJ51DBRY5V7QC61Ydc/h/REW/Oe+MMVyO4As6rN68AOWnS6K+Ki397tK4DA+4w
         5WtPisxP8eIi01NLbJFMHtDlXzywSfKePIjG4ektf30Rq6KTWjMQDIcUhb1qTmgnvmsx
         +UJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c3rUhllVW+QK5yT2/eeZbDx//j1Z4zdaesP59BypPF0=;
        b=LddTPtHiAnrjFb7vSGgMylWBt6F+PfCELq4F5+QcIoM8JKILhAGpyAzfagvtXtBMp4
         kk0SajnWHAl2/DcuN5yx2uQZWjTZUWSauUUKMCJRBF3lUu1/NA5ma68cpfKncK9iLiw9
         +PkXOide06lz99yXVrgCpI6cWgB78m0g9oawK4T6q7izU7x3LP99znf3sydsJ54R5htq
         44shNUmW7GDkMTiW2pT5z1crJje9JM0CWAA4U7gFgWL6G0BtE/WYGaj71KkP5toBe3R4
         sJL0BG5KySSdKoS8bo0RJy2Omtfn7SSxEoUe8q844um8D/+SW1Ik2OfIZoPw3UnQyawW
         iSWA==
X-Gm-Message-State: ALyK8tLQvPrIq7B/TCr1QxISOgE/bJtQ7JVqBn1YgUxF5xyXRUYtihg4Gdt4D8wSe5kwUJBT
X-Received: by 10.66.8.74 with SMTP id p10mr1588835paa.119.1467418821610;
        Fri, 01 Jul 2016 17:20:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c009:86e6:19a6:486e])
        by smtp.gmail.com with ESMTPSA id ee10sm558330pac.31.2016.07.01.17.20.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 01 Jul 2016 17:20:20 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	git@vger.kernel.org, peff@peff.net
Cc:	dwwang@google.com, gitster@pobox.com, dennis@kaarsemaker.net,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 1/4] push options: {pre,post}-receive hook learns about push options
Date:	Fri,  1 Jul 2016 17:20:11 -0700
Message-Id: <20160702002014.29497-2-sbeller@google.com>
X-Mailer: git-send-email 2.9.0.141.gd59d3e9.dirty
In-Reply-To: <20160702002014.29497-1-sbeller@google.com>
References: <20160702002014.29497-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The environment variable GIT_PUSH_OPTION_COUNT is set to the number of
push options sent, and GIT_PUSH_OPTION_{0,1,..} is set to the transmitted
option.

The code is not executed as the push options are set to NULL, nor is the
new capability advertised.

There was some discussion back and forth how to present these push options
to the user as there are some ways to do it:

Keep all options in one environment variable
============================================
+ easiest way to implement in Git
- This would make things hard to parse correctly in the hook.

Put the options in files instead,
filenames are in GIT_PUSH_OPTION_FILES
======================================
+ After a discussion about environment variables and shells, we may not
  want to put user data into an environment variable (see [1] for example).
+ We could transmit binaries, i.e. we're not bound to C strings as
  we are when using environment variables to the user.
+ Maybe easier to parse than constructing environment variable names
  GIT_PUSH_OPTION_{0,1,..} yourself
- cleanup of the temporary files is hard to do reliably
- we have race conditions with multiple clients pushing, hence we'd need
  to use mkstemp. That's not too bad, but still.

Use environment variables, but restrict to key/value pairs
==========================================================
(When the user pushes a push option `foo=bar`, we'd
GIT_PUSH_OPTION_foo=bar)
+ very easy to parse for a simple model of push options
- it's not sufficient for more elaborate models, e.g.
  it doesn't allow doubles (e.g. cc=reviewer@email)

Present the options in different environment variables
======================================================
(This is implemented)
* harder to parse as a user, but we have a sample hook for that.
- doesn't allow binary files
+ allows the same option twice, i.e. is not restrictive about
  options, except for binary files.
+ doesn't clutter a remote directory with (possibly stale)
  temporary files

As we first want to focus on getting simple strings to work
reliably, we go with the last option for now. If we want to
do transmission of binaries later, we can just attach a
'side-channel', e.g. "any push option that contains a '\0' is
put into a file instead of the environment variable and we'd
have new GIT_PUSH_OPTION_FILES, GIT_PUSH_OPTION_FILENAME_{0,1,..}
environment variables".

We limit the push options for now
* to not exceed an arbitrary count, and
* to not exceed an arbitrary size.

This serves two purposes:
* DoS protection (i.e. one connection can add no more than 32kB
  now)
* We need to figure out how to handle large (>64kB). Jeff wrote:
  > Yes, but people are also happy when they can use a flexible and
  > standardized tool to do a thing. I'd be more frustrated when I found out
  > that Git's data-pushing protocol has arbitrary limitations (like, say, I
  > can't push a data item larger than a single 64K pkt-line), which would
  > easily just work with something like HTTP POSTs.
  So to keep a way open in the future to deal with large pay loads,
  the size is restricted for now.

[1] 'Shellshock' https://lwn.net/Articles/614218/

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/githooks.txt          |  6 +++++
 builtin/receive-pack.c              | 48 +++++++++++++++++++++++++++----------
 templates/hooks--pre-receive.sample | 22 +++++++++++++++++
 3 files changed, 63 insertions(+), 13 deletions(-)
 create mode 100644 templates/hooks--pre-receive.sample

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index d82e912..c875cde 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -247,6 +247,9 @@ Both standard output and standard error output are forwarded to
 'git send-pack' on the other end, so you can simply `echo` messages
 for the user.
 
+The number of push options are available in the variable GIT_PUSH_OPTION_COUNT
+and the options itself are in GIT_PUSH_OPTION_{0,1,...}.
+
 [[update]]
 update
 ~~~~~~
@@ -322,6 +325,9 @@ a sample script `post-receive-email` provided in the `contrib/hooks`
 directory in Git distribution, which implements sending commit
 emails.
 
+The number of push options are available in the variable GIT_PUSH_OPTION_COUNT
+and the options itself are in GIT_PUSH_OPTION_{0,1,...}.
+
 [[post-update]]
 post-update
 ~~~~~~~~~~~
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 15c323a..edbf81e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -550,8 +550,16 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 	}
 }
 
+struct receive_hook_feed_state {
+	struct command *cmd;
+	int skip_broken;
+	struct strbuf buf;
+	const struct string_list *push_options;
+};
+
 typedef int (*feed_fn)(void *, const char **, size_t *);
-static int run_and_feed_hook(const char *hook_name, feed_fn feed, void *feed_state)
+static int run_and_feed_hook(const char *hook_name, feed_fn feed,
+			     struct receive_hook_feed_state *feed_state)
 {
 	struct child_process proc = CHILD_PROCESS_INIT;
 	struct async muxer;
@@ -567,6 +575,15 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed, void *feed_sta
 	proc.argv = argv;
 	proc.in = -1;
 	proc.stdout_to_stderr = 1;
+	if (feed_state && feed_state->push_options) {
+		int i;
+		for (i = 0; i < feed_state->push_options->nr; i++)
+			argv_array_pushf(&proc.env_array,
+				"GIT_PUSH_OPTION_%d=%s", i,
+				feed_state->push_options->items[i].string);
+		argv_array_pushf(&proc.env_array, "GIT_PUSH_OPTION_COUNT=%d",
+				 feed_state->push_options->nr);
+	}
 
 	if (use_sideband) {
 		memset(&muxer, 0, sizeof(muxer));
@@ -606,12 +623,6 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed, void *feed_sta
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
@@ -634,8 +645,10 @@ static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
 	return 0;
 }
 
-static int run_receive_hook(struct command *commands, const char *hook_name,
-			    int skip_broken)
+static int run_receive_hook(struct command *commands,
+			    const char *hook_name,
+			    int skip_broken,
+			    const struct string_list *push_options)
 {
 	struct receive_hook_feed_state state;
 	int status;
@@ -646,6 +659,7 @@ static int run_receive_hook(struct command *commands, const char *hook_name,
 	if (feed_receive_hook(&state, NULL, NULL))
 		return 0;
 	state.cmd = commands;
+	state.push_options = push_options;
 	status = run_and_feed_hook(hook_name, feed_receive_hook, &state);
 	strbuf_release(&state.buf);
 	return status;
@@ -1316,7 +1330,8 @@ cleanup:
 
 static void execute_commands(struct command *commands,
 			     const char *unpacker_error,
-			     struct shallow_info *si)
+			     struct shallow_info *si,
+			     const struct string_list *push_options)
 {
 	struct command *cmd;
 	unsigned char sha1[20];
@@ -1335,7 +1350,7 @@ static void execute_commands(struct command *commands,
 
 	reject_updates_to_hidden(commands);
 
-	if (run_receive_hook(commands, "pre-receive", 0)) {
+	if (run_receive_hook(commands, "pre-receive", 0, push_options)) {
 		for (cmd = commands; cmd; cmd = cmd->next) {
 			if (!cmd->error_string)
 				cmd->error_string = "pre-receive hook declined";
@@ -1756,6 +1771,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 
 	if ((commands = read_head_info(&shallow)) != NULL) {
 		const char *unpack_status = NULL;
+		struct string_list *push_options = NULL;
 
 		prepare_shallow_info(&si, &shallow);
 		if (!si.nr_ours && !si.nr_theirs)
@@ -1764,13 +1780,19 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 			unpack_status = unpack_with_sideband(&si);
 			update_shallow_info(commands, &si, &ref);
 		}
-		execute_commands(commands, unpack_status, &si);
+		execute_commands(commands, unpack_status, &si,
+				 push_options);
 		if (pack_lockfile)
 			unlink_or_warn(pack_lockfile);
 		if (report_status)
 			report(commands, unpack_status);
-		run_receive_hook(commands, "post-receive", 1);
+		run_receive_hook(commands, "post-receive", 1,
+				 push_options);
 		run_update_post_hook(commands);
+		if (push_options) {
+			string_list_clear(push_options, 0);
+			free(push_options);
+		}
 		if (auto_gc) {
 			const char *argv_gc_auto[] = {
 				"gc", "--auto", "--quiet", NULL,
diff --git a/templates/hooks--pre-receive.sample b/templates/hooks--pre-receive.sample
new file mode 100644
index 0000000..e4d3edc
--- /dev/null
+++ b/templates/hooks--pre-receive.sample
@@ -0,0 +1,22 @@
+#!/bin/sh
+#
+# An example hook script to make use of push options.
+# The example simply echoes all push options that start with 'echoback='
+# and rejects all pushes when the "reject" push option is used.
+#
+# To enable this hook, rename this file to "pre-receive".
+
+if test -n "$GIT_PUSH_OPTION_COUNT"; then
+	i=0
+	while test "$i" -lt "$GIT_PUSH_OPTION_COUNT"; do
+		eval "value=\$GIT_PUSH_OPTION_$i"
+		case "$value" in
+		echoback=*)
+			echo "echo from the pre-receive-hook ${value#*=}" >&2
+			;;
+		reject)
+			exit 1
+		esac
+		i=$((i + 1))
+	done
+fi
-- 
2.9.0.141.gd59d3e9.dirty

