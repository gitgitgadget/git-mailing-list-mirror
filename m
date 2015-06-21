From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH] Add list-all-objects command
Date: Sun, 21 Jun 2015 20:20:31 +0100
Message-ID: <1434914431-7745-2-git-send-email-charles@hashpling.org>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
 <1434914431-7745-1-git-send-email-charles@hashpling.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 21 21:21:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6kni-0007ii-OZ
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 21:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbbFUTUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 15:20:54 -0400
Received: from host02.zombieandprude.com ([80.82.119.138]:43180 "EHLO
	host02.zombieandprude.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbbFUTUl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 15:20:41 -0400
Received: from hashpling.plus.com ([212.159.69.125]:53913)
	by host02.zombieandprude.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA256:128)
	(Exim 4.80)
	(envelope-from <charles@hashpling.org>)
	id 1Z6knI-0003Vs-28; Sun, 21 Jun 2015 20:20:40 +0100
X-Mailer: git-send-email 2.4.0.53.g8440f74
In-Reply-To: <1434914431-7745-1-git-send-email-charles@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272282>

From: Charles Bailey <cbailey32@bloomberg.net>

list-all-objects is a command to print the ids of all objects in the
object database of a repository. It is designed as a low overhead
interface for scripts that want to analyse all objects but don't require
the ordering implied by a revision walk.

It will list all objects, loose and packed, and will include unreachable
objects.

list-all-objects is faster that "rev-list --all --objects" but there is
no guarantee as to the order in which objects will be listed.

Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
---
 Documentation/git-list-all-objects.txt | 29 +++++++++++++++
 Makefile                               |  1 +
 builtin.h                              |  1 +
 builtin/list-all-objects.c             | 64 ++++++++++++++++++++++++++++++++++
 git.c                                  |  1 +
 t/t8100-list-all-objects.sh            | 45 ++++++++++++++++++++++++
 6 files changed, 141 insertions(+)
 create mode 100644 Documentation/git-list-all-objects.txt
 create mode 100644 builtin/list-all-objects.c
 create mode 100755 t/t8100-list-all-objects.sh

diff --git a/Documentation/git-list-all-objects.txt b/Documentation/git-list-all-objects.txt
new file mode 100644
index 0000000..5f28d41
--- /dev/null
+++ b/Documentation/git-list-all-objects.txt
@@ -0,0 +1,29 @@
+git-list-all-objects(1)
+=======================
+
+NAME
+----
+git-list-all-objects - List all objects in the repository.
+
+SYNOPSIS
+--------
+[verse]
+'git list-all-objects' [-v|--verbose]
+
+DESCRIPTION
+-----------
+List the ids of all objects in a repository, including any unreachable objects.
+If `--verbose` is specified then the object's type and size is printed out as
+well as its id.
+
+OPTIONS
+-------
+
+-v::
+--verbose::
+	Output in the followin format instead of just printing object ids:
+	<sha1> SP <type> SP <size>
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 149f1c7..cf4f0c3 100644
--- a/Makefile
+++ b/Makefile
@@ -853,6 +853,7 @@ BUILTIN_OBJS += builtin/help.o
 BUILTIN_OBJS += builtin/index-pack.o
 BUILTIN_OBJS += builtin/init-db.o
 BUILTIN_OBJS += builtin/interpret-trailers.o
+BUILTIN_OBJS += builtin/list-all-objects.o
 BUILTIN_OBJS += builtin/log.o
 BUILTIN_OBJS += builtin/ls-files.o
 BUILTIN_OBJS += builtin/ls-remote.o
diff --git a/builtin.h b/builtin.h
index b87df70..112bafb 100644
--- a/builtin.h
+++ b/builtin.h
@@ -74,6 +74,7 @@ extern int cmd_help(int argc, const char **argv, const char *prefix);
 extern int cmd_index_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_init_db(int argc, const char **argv, const char *prefix);
 extern int cmd_interpret_trailers(int argc, const char **argv, const char *prefix);
+extern int cmd_list_all_objects(int argc, const char **argv, const char *prefix);
 extern int cmd_log(int argc, const char **argv, const char *prefix);
 extern int cmd_log_reflog(int argc, const char **argv, const char *prefix);
 extern int cmd_ls_files(int argc, const char **argv, const char *prefix);
diff --git a/builtin/list-all-objects.c b/builtin/list-all-objects.c
new file mode 100644
index 0000000..3b43b02
--- /dev/null
+++ b/builtin/list-all-objects.c
@@ -0,0 +1,64 @@
+#include "cache.h"
+#include "builtin.h"
+#include "revision.h"
+#include "parse-options.h"
+
+#include <stdio.h>
+
+static int verbose;
+
+static int print_object(const unsigned char *sha1)
+{
+	if (verbose) {
+		unsigned long size;
+		int type = sha1_object_info(sha1, &size);
+
+		if (type < 0)
+			return -1;
+
+		printf("%s %s %lu\n", sha1_to_hex(sha1), typename(type), size);
+	}
+	else
+		printf("%s\n", sha1_to_hex(sha1));
+
+	return 0;
+}
+
+static int check_loose_object(const unsigned char *sha1,
+			      const char *path,
+			      void *data)
+{
+	return print_object(sha1);
+}
+
+static int check_packed_object(const unsigned char *sha1,
+			       struct packed_git *pack,
+			       uint32_t pos,
+			       void *data)
+{
+	return print_object(sha1);
+}
+
+static struct option builtin_filter_objects_options[] = {
+	OPT__VERBOSE(&verbose, "show object type and size"),
+	OPT_END()
+};
+
+int cmd_list_all_objects(int argc, const char **argv, const char *prefix)
+{
+	struct packed_git *p;
+
+	argc = parse_options(argc, argv, prefix, builtin_filter_objects_options,
+			     NULL, 0);
+
+	for_each_loose_object(check_loose_object, NULL, 0);
+
+	prepare_packed_git();
+	for (p = packed_git; p; p = p->next) {
+		open_pack_index(p);
+	}
+
+	for_each_packed_object(check_packed_object, NULL, 0);
+
+	return 0;
+}
diff --git a/git.c b/git.c
index 44374b1..81e8ae4 100644
--- a/git.c
+++ b/git.c
@@ -417,6 +417,7 @@ static struct cmd_struct commands[] = {
 	{ "init", cmd_init_db, NO_SETUP },
 	{ "init-db", cmd_init_db, NO_SETUP },
 	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP },
+	{ "list-all-objects", cmd_list_all_objects, RUN_SETUP },
 	{ "log", cmd_log, RUN_SETUP },
 	{ "ls-files", cmd_ls_files, RUN_SETUP },
 	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
diff --git a/t/t8100-list-all-objects.sh b/t/t8100-list-all-objects.sh
new file mode 100755
index 0000000..a7b51ce
--- /dev/null
+++ b/t/t8100-list-all-objects.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+test_description='git list-all-objects'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo hello, world >file &&
+	git add file &&
+	git commit -m "initial"
+'
+
+test_basic_repo_objects () {
+	git cat-file --batch-check="%(objectname)" <<-EOF >expected.unsorted &&
+		HEAD
+		HEAD:file
+		HEAD^{tree}
+	EOF
+	git list-all-objects >all-objects.unsorted &&
+	sort expected.unsorted >expected &&
+	sort all-objects.unsorted >all-objects &&
+	test_cmp all-objects expected
+}
+
+test_expect_success 'list all objects' '
+	test_basic_repo_objects
+'
+test_expect_success 'list all objects after pack' '
+	git repack -Ad &&
+	test_basic_repo_objects
+'
+
+test_expect_success 'verbose output' '
+	git cat-file --batch-check="%(objectname) %(objecttype) %(objectsize)" \
+			<<-EOF >expected.unsorted &&
+		HEAD
+		HEAD:file
+		HEAD^{tree}
+	EOF
+	git list-all-objects -v >all-objects.unsorted &&
+	sort expected.unsorted >expected &&
+	sort all-objects.unsorted >all-objects &&
+	test_cmp all-objects expected
+'
+
+test_done
-- 
2.4.0.53.g8440f74
