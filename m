From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 4/4] Add git-upload-archive
Date: Thu,  7 Sep 2006 15:12:05 +0200
Message-ID: <11576347263684-git-send-email-vagabon.xyz@gmail.com>
References: <450019C3.4030001@innova-card.com>
Cc: rene.scharfe@lsrfire.ath.cx, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 15:12:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLJfm-0007SI-5n
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 15:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbWIGNL5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 09:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbWIGNL5
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 09:11:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:60214 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751797AbWIGNLz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 09:11:55 -0400
Received: by nf-out-0910.google.com with SMTP id o25so434641nfa
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 06:11:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LnYCXcUWXnvwRooP00B1Pt4I9JhZ14EyMj18uI585Dwjx5DGOruD3SQeBG0eOwoabS7qpuuLJXQvretlb71fJizsYSHHLx7WslQ7qNZ98zqL9wrLQlVsfC7kLnk7RO+5HFEpDMtAM7dLNw5wtltUc2l5fVNnxWsJSPaubUoYnpw=
Received: by 10.49.8.1 with SMTP id l1mr2507428nfi;
        Thu, 07 Sep 2006 06:11:53 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.gmail.com with ESMTP id x1sm3369549nfb.2006.09.07.06.11.52;
        Thu, 07 Sep 2006 06:11:52 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 3523023F770; Thu,  7 Sep 2006 15:12:06 +0200 (CEST)
To: junkio@cox.net
X-Mailer: git-send-email 1.4.2
In-Reply-To: <450019C3.4030001@innova-card.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26637>

This command implements the git archive protocol on the server
side. This command is not intended to be used by the end user.
Underlying git-archive command line options are sent over the
protocol from "git-archive --remote=...", just like upload-tar
currently does with "git-tar-tree=...".

As for "git-archive" command implementation, this new command
does not execute any existing "git-{tar,zip}-tree" but rely
on the archive API defined by "git-archive" patch. Hence we
get 2 good points:

 - "git-archive" and "git-upload-archive" share all option
   parsing code.

 - All kind of git-upload-{tar,zip} could be removed.

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 .gitignore                           |    1 
 Documentation/git-upload-archive.txt |   37 +++++++++++++++++
 Makefile                             |    1 
 builtin-upload-archive.c             |   72 ++++++++++++++++++++++++++++++++++
 builtin.h                            |    1 
 daemon.c                             |    7 +++
 git.c                                |    1 
 7 files changed, 120 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index a3e7ca1..fda9bf2 100644
--- a/.gitignore
+++ b/.gitignore
@@ -119,6 +119,7 @@ git-unpack-objects
 git-update-index
 git-update-ref
 git-update-server-info
+git-upload-archive
 git-upload-pack
 git-upload-tar
 git-var
diff --git a/Documentation/git-upload-archive.txt b/Documentation/git-upload-archive.txt
new file mode 100644
index 0000000..388bb53
--- /dev/null
+++ b/Documentation/git-upload-archive.txt
@@ -0,0 +1,37 @@
+git-upload-archive(1)
+====================
+
+NAME
+----
+git-upload-archive - Send archive
+
+
+SYNOPSIS
+--------
+'git-upload-archive' <directory>
+
+DESCRIPTION
+-----------
+Invoked by 'git-archive --remote' and sends a generated archive to the
+other end over the git protocol.
+
+This command is usually not invoked directly by the end user.  The UI
+for the protocol is on the 'git-archive' side, and the program pair
+is meant to be used to get an archive from a remote repository.
+
+OPTIONS
+-------
+<directory>::
+	The repository to get a tar archive from.
+
+Author
+------
+Written by Franck Bui-Huu.
+
+Documentation
+--------------
+Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the gitlink:git[7] suite
diff --git a/Makefile b/Makefile
index 51ed4dd..461e1d6 100644
--- a/Makefile
+++ b/Makefile
@@ -305,6 +305,7 @@ BUILTIN_OBJS = \
 	builtin-unpack-objects.o \
 	builtin-update-index.o \
 	builtin-update-ref.o \
+	builtin-upload-archive.o \
 	builtin-upload-tar.o \
 	builtin-verify-pack.o \
 	builtin-write-tree.o \
diff --git a/builtin-upload-archive.c b/builtin-upload-archive.c
new file mode 100644
index 0000000..4fad377
--- /dev/null
+++ b/builtin-upload-archive.c
@@ -0,0 +1,72 @@
+/*
+ * Copyright (c) 2006 Franck Bui-Huu
+ */
+#include <time.h>
+#include "cache.h"
+#include "builtin.h"
+#include "archive.h"
+#include "pkt-line.h"
+
+static const char upload_archive_usage[] =
+	"git-upload-archive <repo>";
+
+
+int cmd_upload_archive(int argc, const char **argv, const char *prefix)
+{
+	struct archiver *ar;
+	const char *sent_argv[MAX_ARGS];
+	const char *arg_cmd = "argument ";
+	char *p, buf[4096];
+	int treeish_idx;
+	int sent_argc;
+	int len;
+
+	if (argc != 2)
+		usage(upload_archive_usage);
+
+	if (strlen(argv[1]) > sizeof(buf))
+		die("insanely long repository name");
+
+	strcpy(buf, argv[1]); /* enter-repo smudges its argument */
+
+	if (!enter_repo(buf, 0))
+		die("not a git archive");
+
+	/* put received options in sent_argv[] */
+	sent_argc = 1;
+	sent_argv[0] = "git-upload-archive";
+	for (p = buf;;) {
+		/* This will die if not enough free space in buf */
+		len = packet_read_line(0, p, (buf + sizeof buf) - p);
+		if (len == 0)
+			break;	/* got a flush */
+		if (sent_argc > MAX_ARGS - 2)
+			die("Too many options (>29)");
+
+		if (p[len-1] == '\n') {
+			p[--len] = 0;
+		}
+		if (len < strlen(arg_cmd) ||
+		    strncmp(arg_cmd, p, strlen(arg_cmd)))
+			die("'argument' token or flush expected");
+
+		len -= strlen(arg_cmd);
+		memmove(p, p + strlen(arg_cmd), len);
+		sent_argv[sent_argc++] = p;
+		p += len;
+		*p++ = 0;
+	}
+	sent_argv[sent_argc] = NULL;
+
+	/* parse all options sent by the client */
+	treeish_idx = parse_archive_args(sent_argc, sent_argv, &ar);
+
+	parse_treeish_arg(sent_argv + treeish_idx, &ar->args, prefix);
+	parse_pathspec_arg(sent_argv + treeish_idx + 1, &ar->args);
+
+	packet_write(1, "ACK\n");
+	packet_flush(1);
+
+	return ar->write_archive(&ar->args);
+}
+
diff --git a/builtin.h b/builtin.h
index 2391afb..f3efb58 100644
--- a/builtin.h
+++ b/builtin.h
@@ -58,6 +58,7 @@ extern int cmd_zip_tree(int argc, const 
 extern int cmd_unpack_objects(int argc, const char **argv, const char *prefix);
 extern int cmd_update_index(int argc, const char **argv, const char *prefix);
 extern int cmd_update_ref(int argc, const char **argv, const char *prefix);
+extern int cmd_upload_archive(int argc, const char **argv, const char *prefix);
 extern int cmd_upload_tar(int argc, const char **argv, const char *prefix);
 extern int cmd_version(int argc, const char **argv, const char *prefix);
 extern int cmd_whatchanged(int argc, const char **argv, const char *prefix);
diff --git a/daemon.c b/daemon.c
index a4a08f3..5570878 100644
--- a/daemon.c
+++ b/daemon.c
@@ -324,6 +324,12 @@ static int upload_pack(void)
 	return -1;
 }
 
+static int upload_archive(void)
+{
+	execl_git_cmd("upload-archive", ".", NULL);
+	return -1;
+}
+
 static int upload_tar(void)
 {
 	execl_git_cmd("upload-tar", ".", NULL);
@@ -331,6 +337,7 @@ static int upload_tar(void)
 }
 
 static struct daemon_service daemon_service[] = {
+	{ "upload-archive", "uploadarch", upload_archive, 0, 1 },
 	{ "upload-pack", "uploadpack", upload_pack, 1, 1 },
 	{ "upload-tar", "uploadtar", upload_tar, 0, 1 },
 };
diff --git a/git.c b/git.c
index c62c5cf..315dc0b 100644
--- a/git.c
+++ b/git.c
@@ -261,6 +261,7 @@ static void handle_internal_command(int 
 		{ "unpack-objects", cmd_unpack_objects, RUN_SETUP },
 		{ "update-index", cmd_update_index, RUN_SETUP },
 		{ "update-ref", cmd_update_ref, RUN_SETUP },
+		{ "upload-archive", cmd_upload_archive },
 		{ "upload-tar", cmd_upload_tar },
 		{ "version", cmd_version },
 		{ "whatchanged", cmd_whatchanged, RUN_SETUP | USE_PAGER },
-- 
1.4.2
