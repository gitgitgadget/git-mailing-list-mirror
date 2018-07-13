Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 588371F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 16:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbeGMRMA (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 13:12:00 -0400
Received: from siwi.pair.com ([209.68.5.199]:31804 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731651AbeGMRMA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 13:12:00 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 513953F4148;
        Fri, 13 Jul 2018 12:56:33 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id DDC673F4146;
        Fri, 13 Jul 2018 12:56:32 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v1 04/25] structured-logging: add session-id to log events
Date:   Fri, 13 Jul 2018 16:56:00 +0000
Message-Id: <20180713165621.52017-5-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180713165621.52017-1-git@jeffhostetler.com>
References: <20180713165621.52017-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach git to create a unique session id (SID) during structured
logging initialization and use that SID in all log events.

This SID is exported into a transient environment variable and
inherited by child processes.  This allows git child processes
to be related back to the parent git process event if there are
intermediate /bin/sh processes between them.

Update t0001 to ignore the environment variable GIT_SLOG_PARENT_SID.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/git.txt |  6 ++++++
 structured-logging.c  | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t0001-init.sh       |  1 +
 3 files changed, 59 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index dba7f0c..a24f399 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -766,6 +766,12 @@ standard output.
 	adequate and support for it is likely to be removed in the
 	foreseeable future (along with the variable).
 
+`GIT_SLOG_PARENT_SID`::
+	(Experimental) A transient environment variable set by top-level
+	Git commands and inherited by child Git commands.  It contains
+	a session id that will be written the structured logging output
+	to help associate child and parent processes.
+
 Discussion[[Discussion]]
 ------------------------
 
diff --git a/structured-logging.c b/structured-logging.c
index afa2224..289140f 100644
--- a/structured-logging.c
+++ b/structured-logging.c
@@ -31,9 +31,57 @@ static char *my__command_name;
 static char *my__sub_command_name;
 
 static struct argv_array my__argv = ARGV_ARRAY_INIT;
+static struct strbuf my__session_id = STRBUF_INIT;
 static struct json_writer my__errors = JSON_WRITER_INIT;
 
 /*
+ * Compute a new session id for the current process.  Build string
+ * with the start time and PID of the current process and append
+ * the inherited session id from our parent process (if present).
+ * The parent session id may include its parent session id.
+ *
+ * sid := <start-time> '-' <pid> [ ':' <parent-sid> [ ... ] ]
+ */
+static void compute_our_sid(void)
+{
+	const char *parent_sid;
+
+	if (my__session_id.len)
+		return;
+
+	/*
+	 * A "session id" (SID) is a cheap, unique-enough string to
+	 * associate child process with the hierarchy of invoking git
+	 * processes.
+	 *
+	 * This is stronger than a simple parent-pid because we may
+	 * have an intermediate shell between a top-level Git command
+	 * and a child Git command.  It also isolates from issues
+	 * about how the OS recycles PIDs.
+	 *
+	 * This could be a UUID/GUID, but that is overkill for our
+	 * needs here and more expensive to compute.
+	 *
+	 * Consumers should consider this an unordered opaque string
+	 * in case we decide to switch to a real UUID in the future.
+	 */
+	strbuf_addf(&my__session_id, "%"PRIuMAX"-%"PRIdMAX,
+		    (uintmax_t)my__start_time, (intmax_t)my__pid);
+
+	parent_sid = getenv("GIT_SLOG_PARENT_SID");
+	if (parent_sid && *parent_sid) {
+		strbuf_addch(&my__session_id, ':');
+		strbuf_addstr(&my__session_id, parent_sid);
+	}
+
+	/*
+	 * Install our SID into the environment for our child processes
+	 * to inherit.
+	 */
+	setenv("GIT_SLOG_PARENT_SID", my__session_id.buf, 1);
+}
+
+/*
  * Write a single event to the structured log file.
  */
 static void emit_event(struct json_writer *jw, const char *event_name)
@@ -75,6 +123,7 @@ static void emit_start_event(void)
 		jw_object_string(&jw, "event", "cmd_start");
 		jw_object_intmax(&jw, "clock_us", (intmax_t)my__start_time);
 		jw_object_intmax(&jw, "pid", (intmax_t)my__pid);
+		jw_object_string(&jw, "sid", my__session_id.buf);
 
 		if (my__command_name && *my__command_name)
 			jw_object_string(&jw, "command", my__command_name);
@@ -112,6 +161,7 @@ static void emit_exit_event(void)
 		jw_object_string(&jw, "event", "cmd_exit");
 		jw_object_intmax(&jw, "clock_us", (intmax_t)atexit_time);
 		jw_object_intmax(&jw, "pid", (intmax_t)my__pid);
+		jw_object_string(&jw, "sid", my__session_id.buf);
 
 		if (my__command_name && *my__command_name)
 			jw_object_string(&jw, "command", my__command_name);
@@ -250,6 +300,7 @@ static void do_final_steps(int in_signal)
 	free(my__sub_command_name);
 	argv_array_clear(&my__argv);
 	jw_release(&my__errors);
+	strbuf_release(&my__session_id);
 }
 
 static void slog_atexit(void)
@@ -289,6 +340,7 @@ static void initialize(int argc, const char **argv)
 {
 	my__start_time = getnanotime() / 1000;
 	my__pid = getpid();
+	compute_our_sid();
 
 	intern_argv(argc, argv);
 
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index c413bff..3dfc37a 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -92,6 +92,7 @@ test_expect_success 'No extra GIT_* on alias scripts' '
 	env |
 		sed -n \
 			-e "/^GIT_PREFIX=/d" \
+			-e "/^GIT_SLOG_PARENT_SID=/d" \
 			-e "/^GIT_TEXTDOMAINDIR=/d" \
 			-e "/^GIT_/s/=.*//p" |
 		sort
-- 
2.9.3

