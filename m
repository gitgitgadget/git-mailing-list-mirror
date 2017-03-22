Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6949720323
	for <e@80x24.org>; Wed, 22 Mar 2017 17:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935494AbdCVRCL (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 13:02:11 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36373 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935555AbdCVRB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 13:01:26 -0400
Received: by mail-qt0-f194.google.com with SMTP id n37so26100587qtb.3
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 10:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D509r+zEkp+X/WbmbNuoZAQLYwAGmUZsvcGJfxvNeMw=;
        b=foIiK1jHTab0R6xc5g5ewBYypM/c12CMc81g3S7vlI5RuWXy7NEgXqINhfxXpF3cIE
         q250+Jp2ShxIJHVPXSIHcrcLFwYWAmDnlxcFF5Fx6pnqmpHEI7gngWbuy2Zvkp77kBY5
         FyuvhkokKKmdFH+fl6GPFOTCI8JVaHHOvM5lGzCfsdS+QiV2t2YN3QNth5z+CMlRuV5N
         PyTgdiSOTFNOYARGOFQ3dQLln5E+2eGSXy75gxWk7+x6VnU6vFoCvMIP7YPMX4hJqBnQ
         CeOIUCJ1oTHM3wFVlRexAtMgnmOUbpodJ50cpSe5Y1PjHIaF9U+HEouRFo6+KrUm8ihO
         xJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D509r+zEkp+X/WbmbNuoZAQLYwAGmUZsvcGJfxvNeMw=;
        b=bUy3WlrcCzP2XZBMNy5HEQJpXuRaQyV1QspPWut8gJtHJsWllTxndmEv4r1VNIPh6a
         6lTq18zrdMaiEesIFs78K22sAnr90gG4OaiW+vLYiEsmUj2kwoPHK5VAKVbjc6UUIvnU
         5GKnepiSy9GJpS3FIaZAaXirS8KjaIBeb9k7HuR1gWyrHXyla/IQJ79ItvBAOVJzsozw
         oEhj7/QYoxGjD+6o0i8zL93KXauhN6FSzSlKnqs31RiBXuFc8Hk/c8wCS84mWe5/C2fR
         IjlV4RmlHH5ECgfH8t/zaffZpH/zagXK49G+Gw72T9YiXFpq1hhFIRN/pJNu2qcLzIc+
         hDPQ==
X-Gm-Message-State: AFeK/H0FgfF0Ae5EN2cG0+JCMn7xmtHXhLXfxybC4S7X1UB9kl8oZAmLk7xFGSxEMvexoA==
X-Received: by 10.200.42.213 with SMTP id c21mr42968731qta.257.1490201636352;
        Wed, 22 Mar 2017 09:53:56 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id t47sm1334588qte.45.2017.03.22.09.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 09:53:55 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     benpeart@microsoft.com, christian.couder@gmail.com,
        larsxschneider@gmail.com
Subject: [PATCH v1 2/3] sub-process: refactor the filter process code into a reusable module
Date:   Wed, 22 Mar 2017 12:52:19 -0400
Message-Id: <20170322165220.5660-3-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.0.gvfs.1.42.g0b7328eac2
In-Reply-To: <20170322165220.5660-1-benpeart@microsoft.com>
References: <20170322165220.5660-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new sub-process module that can be used to reduce the cost of
starting up a sub-process for multiple commands.  It does this by
keeping the external process running and processing all commands by
communicating over standard input and standard output using the packet
format (pkt-line) based protocol.  Full documentation is contained in
Documentation/technical/api-sub-process.txt.

This code is refactored from:

	Commit edcc85814c ("convert: add filter.<driver>.process option", 2016-10-16)
	keeps the external process running and processes all commands

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Documentation/technical/api-sub-process.txt |  55 ++++++++++++++
 Makefile                                    |   1 +
 sub-process.c                               | 113 ++++++++++++++++++++++++++++
 sub-process.h                               |  46 +++++++++++
 4 files changed, 215 insertions(+)
 create mode 100644 Documentation/technical/api-sub-process.txt
 create mode 100644 sub-process.c
 create mode 100644 sub-process.h

diff --git a/Documentation/technical/api-sub-process.txt b/Documentation/technical/api-sub-process.txt
new file mode 100644
index 0000000000..8471875611
--- /dev/null
+++ b/Documentation/technical/api-sub-process.txt
@@ -0,0 +1,55 @@
+sub-process API
+===============
+
+The sub-process API makes it possible to run background sub-processes
+that should run until the git command exits and communicate with it
+through stdin and stdout.  This reduces the overhead of having to fork
+a new process each time it needs to be communicated with.
+
+The sub-processes are kept in a hashmap by command name and looked up
+via the subprocess_find_entry function.  If an existing instance can not
+be found then a new process should be created and started.  When the
+parent git command terminates, all sub-processes are also terminated.
+
+This API is based on the run-command API.
+
+Data structures
+---------------
+
+* `struct subprocess_entry`
+
+The sub-process structure.  Members should not be accessed directly.
+
+Types
+-----
+
+'int(*subprocess_start_fn)(struct subprocess_entry *entry)'::
+
+	User-supplied function to initialize the sub-process.  This is
+	typically used to negoiate the interface version and capabilities.
+
+
+Functions
+---------
+
+`subprocess_start`::
+
+	Start a subprocess and add it to the subprocess hashmap.
+
+`subprocess_stop`::
+
+	Kill a subprocess and remove it from the subprocess hashmap.
+
+`subprocess_find_entry`::
+
+	Find a subprocess in the subprocess hashmap.
+
+`subprocess_get_child_process`::
+
+	Get the underlying `struct child_process` from a subprocess.
+
+`subprocess_read_status`::
+
+	Helper function to read packets looking for the last "status=<foo>"
+	key/value pair.
+
diff --git a/Makefile b/Makefile
index a5a11e721a..8afe733092 100644
--- a/Makefile
+++ b/Makefile
@@ -830,6 +830,7 @@ LIB_OBJS += streaming.o
 LIB_OBJS += string-list.o
 LIB_OBJS += submodule.o
 LIB_OBJS += submodule-config.o
+LIB_OBJS += sub-process.o
 LIB_OBJS += symlinks.o
 LIB_OBJS += tag.o
 LIB_OBJS += tempfile.o
diff --git a/sub-process.c b/sub-process.c
new file mode 100644
index 0000000000..02050b6867
--- /dev/null
+++ b/sub-process.c
@@ -0,0 +1,113 @@
+/*
+ * Generic implementation of background process infrastructure.
+ */
+#include "sub-process.h"
+#include "sigchain.h"
+#include "pkt-line.h"
+
+static int subprocess_map_initialized;
+static struct hashmap subprocess_map;
+
+static int name2process_cmp(const struct subprocess_entry *e1,
+		const struct subprocess_entry *e2, const void *unused)
+{
+	return strcmp(e1->cmd, e2->cmd);
+}
+
+static void subprocess_exit_handler(struct child_process *process)
+{
+	sigchain_push(SIGPIPE, SIG_IGN);
+	/* Closing the pipe signals the filter to initiate a shutdown. */
+	close(process->in);
+	close(process->out);
+	sigchain_pop(SIGPIPE);
+	/* Finish command will wait until the shutdown is complete. */
+	finish_command(process);
+}
+
+int subprocess_start(struct subprocess_entry *entry, const char *cmd,
+		subprocess_start_fn startfn)
+{
+	int err;
+	const char *argv[] = { cmd, NULL };
+
+	if (!subprocess_map_initialized) {
+		hashmap_init(&subprocess_map, (hashmap_cmp_fn)name2process_cmp, 0);
+		subprocess_map_initialized = 1;
+	}
+
+	entry->cmd = cmd;
+
+	child_process_init(&entry->process);
+	entry->process.argv = argv;
+	entry->process.use_shell = 1;
+	entry->process.in = -1;
+	entry->process.out = -1;
+	entry->process.clean_on_exit = 1;
+	entry->process.clean_on_exit_handler = subprocess_exit_handler;
+
+	err = start_command(&entry->process);
+	if (err) {
+		error("cannot fork to run sub-process '%s'", entry->cmd);
+		return err;
+	}
+
+	err = startfn(entry);
+	if (err) {
+		error("initialization for sub-process '%s' failed", entry->cmd);
+		subprocess_stop(entry);
+		return err;
+	}
+
+	hashmap_entry_init(entry, strhash(entry->cmd));
+	hashmap_add(&subprocess_map, entry);
+
+	return 0;
+}
+
+void subprocess_stop(struct subprocess_entry *entry)
+{
+	if (!entry)
+		return;
+
+	entry->process.clean_on_exit = 0;
+	kill(entry->process.pid, SIGTERM);
+	finish_command(&entry->process);
+
+	hashmap_remove(&subprocess_map, entry, NULL);
+}
+
+struct subprocess_entry *subprocess_find_entry(const char *cmd)
+{
+	struct subprocess_entry key;
+
+	if (!subprocess_map_initialized) {
+		hashmap_init(&subprocess_map, (hashmap_cmp_fn)name2process_cmp, 0);
+		subprocess_map_initialized = 1;
+		return NULL;
+	}
+
+	hashmap_entry_init(&key, strhash(cmd));
+	key.cmd = cmd;
+	return hashmap_get(&subprocess_map, &key, NULL);
+}
+
+void subprocess_read_status(int fd, struct strbuf *status)
+{
+	struct strbuf **pair;
+	char *line;
+	for (;;) {
+		line = packet_read_line(fd, NULL);
+		if (!line)
+			break;
+		pair = strbuf_split_str(line, '=', 2);
+		if (pair[0] && pair[0]->len && pair[1]) {
+			/* the last "status=<foo>" line wins */
+			if (!strcmp(pair[0]->buf, "status=")) {
+				strbuf_reset(status);
+				strbuf_addbuf(status, pair[1]);
+			}
+		}
+		strbuf_list_free(pair);
+	}
+}
diff --git a/sub-process.h b/sub-process.h
new file mode 100644
index 0000000000..235f1e5fa3
--- /dev/null
+++ b/sub-process.h
@@ -0,0 +1,46 @@
+#ifndef SUBPROCESS_H
+#define SUBPROCESS_H
+
+#include "git-compat-util.h"
+#include "hashmap.h"
+#include "run-command.h"
+
+/*
+ * Generic implementation of background process infrastructure.
+ * See Documentation/technical/api-background-process.txt.
+ */
+
+ /* data structures */
+
+struct subprocess_entry {
+	struct hashmap_entry ent; /* must be the first member! */
+	struct child_process process;
+	const char *cmd;
+};
+
+/* subprocess functions */
+
+typedef int(*subprocess_start_fn)(struct subprocess_entry *entry);
+int subprocess_start(struct subprocess_entry *entry, const char *cmd,
+		subprocess_start_fn startfn);
+
+void subprocess_stop(struct subprocess_entry *entry);
+
+struct subprocess_entry *subprocess_find_entry(const char *cmd);
+
+/* subprocess helper functions */
+
+static inline struct child_process *subprocess_get_child_process(
+		struct subprocess_entry *entry)
+{
+	return &entry->process;
+}
+
+/*
+ * Helper function that will read packets looking for "status=<foo>"
+ * key/value pairs and return the value from the last "status" packet
+ */
+
+void subprocess_read_status(int fd, struct strbuf *status);
+
+#endif
-- 
2.12.0.gvfs.1.42.g0b7328eac2

