From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: [PATCH 2/2] Add git-upload-archive
Date: Tue, 5 Sep 2006 14:22:27 +0200
Message-ID: <cda58cb80609050522o30b9a28n596121a29eb7d482@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Rene Scharfe" <rene.scharfe@lsrfire.ath.cx>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 05 14:22:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKZwn-00072W-0w
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 14:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWIEMW3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 08:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWIEMW3
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 08:22:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:34588 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932155AbWIEMW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Sep 2006 08:22:28 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1919497ugc
        for <git@vger.kernel.org>; Tue, 05 Sep 2006 05:22:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SzIh/crxI4xaDVgMYA3blORKa4+l8e/2kryNMhumuZjonfloPsRj9Y+kHl9+gPHrn42VUxTkKsfyw6anBDInRvlR9pIhaQBNic27alJ3i+r8aG+hdF1s/ABwV0/lK0xl7z/1aqq3ELPN6cp1/jIl6haEPUOymdn+GWpStb1q7As=
Received: by 10.66.240.12 with SMTP id n12mr3575623ugh;
        Tue, 05 Sep 2006 05:22:27 -0700 (PDT)
Received: by 10.67.95.4 with HTTP; Tue, 5 Sep 2006 05:22:27 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26473>

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
 .gitignore               |    1
 Makefile                 |    1
 builtin-upload-archive.c |  102 ++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h                |    1
 daemon.c                 |   13 +++++-
 git.c                    |    1
 6 files changed, 117 insertions(+), 2 deletions(-)

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
index 0000000..5e389fc
--- /dev/null
+++ b/builtin-upload-archive.c
@@ -0,0 +1,102 @@
+/*
+ * Copyright (c) 2006 Franck Bui-Huu
+ */
+#include <time.h>
+#include "cache.h"
+#include "builtin.h"
+#include "archive.h"
+#include "pkt-line.h"
+
+#define MAX_ARGS	32
+
+static const char upload_archive_usage[] =
+	"git-upload-archive --format=fmt <repo>";
+
+static int NACK(const char *reason)
+{
+	packet_write(1, "NACK %s\n", reason);
+	packet_flush(1);
+	return -1;
+}
+
+int cmd_upload_archive(int argc, const char **argv, const char *prefix)
+{
+	struct archiver_struct *ar;
+	const char *sent_argv[MAX_ARGS];
+	const char *arg_cmd = "arguments ";
+	const char *reason;
+	char *p, buf[8192];
+	int treeish_idx;
+	int sent_argc;
+	int len;
+	int rv;
+
+	const char **pathspec;
+	struct tree *tree;
+	const unsigned char *commit_sha1;
+	time_t archive_time;
+
+	if (argc != 3)
+		usage(upload_archive_usage);
+
+	if (strlen(argv[2]) > sizeof(buf)) {
+		reason = "insanely long repository name";
+		goto nack;
+	}
+	strcpy(buf, argv[2]); /* enter-repo smudges its argument */
+
+	if (!enter_repo(buf, 0)) {
+		reason = "not a git archive";
+		goto nack;
+	}
+
+	len = packet_read_line(0, buf, sizeof(buf));
+	if (len < strlen(arg_cmd) || strncmp(arg_cmd, buf, strlen(arg_cmd))) {
+		reason = "expected 'arguments' command";
+		goto nack;
+	}
+	if (buf[len-1] == '\n')
+		buf[--len] = 0;
+
+	/* we can safely override 'arg_cmd' */
+	len = packet_read_line(0, buf, strlen(arg_cmd));
+	if (len) {
+		reason = "flush expected";
+		goto nack;
+	}
+	p = buf + strlen(arg_cmd);
+
+	/* put received line options in sent_argv[] */
+	sent_argv[0] = "git-upload-archive";
+	sent_argv[1] = argv[1]; /* --format=<fmt> */
+	sent_argc = 2;
+	while (p) {
+		if (sent_argc > MAX_ARGS - 2) {
+			reason = "Too many options (>29)";
+			goto nack;
+		}
+		sent_argv[sent_argc++] = strsep(&p, " ");
+	}
+	sent_argv[sent_argc] = NULL;
+
+	/* parse all options sent by the client */
+	treeish_idx = parse_archive_args(sent_argc, sent_argv, &ar, &reason);
+	if (treeish_idx < 0)
+		goto nack;
+
+	rv = parse_treeish_arg(sent_argv + treeish_idx, &tree, &commit_sha1,
+			       &archive_time, prefix, &reason);
+	if (rv < 0)
+		goto nack;
+
+	pathspec = get_pathspec(ar->prefix, sent_argv + treeish_idx + 1);
+
+	packet_write(1, "ACK\n");
+	packet_flush(1);
+
+	return ar->write_archive(tree, commit_sha1, ar->prefix,
+				 archive_time, pathspec);
+nack:
+	return NACK(reason);
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
index a4a08f3..c09280f 100644
--- a/daemon.c
+++ b/daemon.c
@@ -324,12 +324,21 @@ static int upload_pack(void)
 	return -1;
 }

-static int upload_tar(void)
+static int upload_archive(const char *fmt)
 {
-	execl_git_cmd("upload-tar", ".", NULL);
+	char buf[64];
+
+	snprintf(buf, sizeof(buf), "--format=%s", fmt);
+
+	execl_git_cmd("upload-archive", buf, ".", NULL);
 	return -1;
 }

+static int upload_tar(void)
+{
+	return upload_archive("tar");
+}
+
 static struct daemon_service daemon_service[] = {
 	{ "upload-pack", "uploadpack", upload_pack, 1, 1 },
 	{ "upload-tar", "uploadtar", upload_tar, 0, 1 },
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
1.4.2.gbba4
