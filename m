Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 738A12023D
	for <e@80x24.org>; Sat,  4 Mar 2017 19:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752320AbdCDTgF (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Mar 2017 14:36:05 -0500
Received: from dalaran.tastycake.net ([212.13.201.165]:53624 "EHLO
        dalaran.tastycake.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752278AbdCDTgD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2017 14:36:03 -0500
Received: from [176.27.107.90] (helo=localhost.localdomain)
        by dalaran.tastycake.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <markbt@efaref.net>)
        id 1ckFCv-0001xc-Sf; Sat, 04 Mar 2017 19:19:09 +0000
From:   Mark Thomas <markbt@efaref.net>
To:     git@vger.kernel.org
Cc:     Mark Thomas <markbt@efaref.net>
Subject: [RFC 1/4] upload-file: Add upload-file command
Date:   Sat,  4 Mar 2017 19:18:58 +0000
Message-Id: <20170304191901.9622-2-markbt@efaref.net>
X-Mailer: git-send-email 2.12.0.193.g9dc7f06
In-Reply-To: <20170304191901.9622-1-markbt@efaref.net>
References: <20170304191901.9622-1-markbt@efaref.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The upload-file command allows a remote to request specific files by sha1.

Signed-off-by: Mark Thomas <markbt@efaref.net>
---
 .gitignore    |  1 +
 Makefile      |  2 ++
 daemon.c      |  6 +++++
 upload-file.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+)
 create mode 100644 upload-file.c

diff --git a/.gitignore b/.gitignore
index 833ef3b..c2db9c2 100644
--- a/.gitignore
+++ b/.gitignore
@@ -165,6 +165,7 @@
 /git-update-ref
 /git-update-server-info
 /git-upload-archive
+/git-upload-file
 /git-upload-pack
 /git-var
 /git-verify-commit
diff --git a/Makefile b/Makefile
index 9ec6065..1b84322 100644
--- a/Makefile
+++ b/Makefile
@@ -597,6 +597,7 @@ PROGRAM_OBJS += sh-i18n--envsubst.o
 PROGRAM_OBJS += shell.o
 PROGRAM_OBJS += show-index.o
 PROGRAM_OBJS += upload-pack.o
+PROGRAM_OBJS += upload-file.o
 PROGRAM_OBJS += remote-testsvn.o
 
 # Binary suffix, set to .exe for Windows builds
@@ -668,6 +669,7 @@ BINDIR_PROGRAMS_NEED_X += git-upload-pack
 BINDIR_PROGRAMS_NEED_X += git-receive-pack
 BINDIR_PROGRAMS_NEED_X += git-upload-archive
 BINDIR_PROGRAMS_NEED_X += git-shell
+BINDIR_PROGRAMS_NEED_X += git-upload-file
 
 BINDIR_PROGRAMS_NO_X += git-cvsserver
 
diff --git a/daemon.c b/daemon.c
index 473e6b6..8b5b026 100644
--- a/daemon.c
+++ b/daemon.c
@@ -479,6 +479,11 @@ static int upload_pack(void)
 	return run_service_command(argv);
 }
 
+static int upload_file(void)
+{
+	const char *argv[] = { "upload-file", ".", NULL };
+	return run_service_command(argv);
+}
 static int upload_archive(void)
 {
 	static const char *argv[] = { "upload-archive", ".", NULL };
@@ -494,6 +499,7 @@ static int receive_pack(void)
 static struct daemon_service daemon_service[] = {
 	{ "upload-archive", "uploadarch", upload_archive, 0, 1 },
 	{ "upload-pack", "uploadpack", upload_pack, 1, 1 },
+	{ "upload-file", "uploadfile", upload_file, 1, 1 },
 	{ "receive-pack", "receivepack", receive_pack, 0, 1 },
 };
 
diff --git a/upload-file.c b/upload-file.c
new file mode 100644
index 0000000..cb2bfe8
--- /dev/null
+++ b/upload-file.c
@@ -0,0 +1,87 @@
+
+#include "cache.h"
+#include "exec_cmd.h"
+#include "parse-options.h"
+#include "pkt-line.h"
+
+static const char * const upload_file_usage[] = {
+	N_("git upload-file [<options>] <dir>"),
+	NULL
+};
+
+
+static void upload_file(void)
+{
+	for (;;) {
+		char *line = packet_read_line(0, NULL);
+		const char *arg;
+		if (!line)
+			break;
+
+		if (skip_prefix(line, "info ", &arg)) {
+			unsigned char sha1[20];
+			void *buffer;
+			enum object_type type;
+			unsigned long size;
+
+			if (get_sha1_hex(arg, sha1))
+				die("invalid sha: %s", arg);
+
+			buffer = read_sha1_file(sha1, &type, &size);
+			if (buffer) {
+				packet_write_fmt(1, "found %s %d %ld\n", sha1_to_hex(sha1), type, size);
+				free(buffer);
+			} else {
+				packet_write_fmt(1, "missing %s\n", sha1_to_hex(sha1));
+			}
+		}
+
+		if (skip_prefix(line, "get ", &arg)) {
+			unsigned char sha1[20];
+			void *buffer;
+			enum object_type type;
+			unsigned long size;
+
+			if (get_sha1_hex(arg, sha1))
+				die("invalid sha: %s", arg);
+
+			buffer = read_sha1_file(sha1, &type, &size);
+			if (buffer) {
+				packet_write_fmt(1, "found %s %d %ld\n", sha1_to_hex(sha1), type, size);
+				write_or_die(1, buffer, size);
+				free(buffer);
+			} else {
+				packet_write_fmt(1, "missing %s\n", sha1_to_hex(sha1));
+			}
+			
+		}
+
+		if (!strcmp(line, "end"))
+			break;
+	}
+}
+
+int cmd_main(int argc, const char **argv)
+{
+	const char *dir;
+	struct option options[] = {
+		OPT_END()
+	};
+
+	packet_trace_identity("upload-file");
+
+	argc = parse_options(argc, argv, NULL, options, upload_file_usage, 0);
+
+	if (argc != 1)
+		usage_with_options(upload_file_usage, options);
+
+	setup_path();
+
+	dir = argv[0];
+
+	if (!enter_repo(dir, 0))
+		die("'%s' does not appear to be a git repository", dir);
+
+	upload_file();
+	return 0;
+}
-- 
2.7.4

