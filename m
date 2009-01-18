From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 4/7 v2] Add calls to git_extract_argv0_path() in programs that call git_config_*
Date: Sun, 18 Jan 2009 13:00:12 +0100
Message-ID: <1232280015-8144-5-git-send-email-prohaska@zib.de>
References: <1232280015-8144-1-git-send-email-prohaska@zib.de>
 <1232280015-8144-2-git-send-email-prohaska@zib.de>
 <1232280015-8144-3-git-send-email-prohaska@zib.de>
 <1232280015-8144-4-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 13:02:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOWMJ-0007Kr-JG
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 13:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765724AbZARMAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 07:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765667AbZARMAo
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 07:00:44 -0500
Received: from mailer.zib.de ([130.73.108.11]:32928 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765345AbZARMAj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 07:00:39 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n0IC0GGq026431;
	Sun, 18 Jan 2009 13:00:21 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n0IC0FJ5001758;
	Sun, 18 Jan 2009 13:00:16 +0100 (MET)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1232280015-8144-4-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106178>

Programs that use git_config need to find the global configuration.
When runtime prefix computation is enabled, this requires that
git_extract_argv0_path() is called early in the program's main().

This commit adds the necessary calls.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 daemon.c             |    2 ++
 fast-import.c        |    3 +++
 hash-object.c        |    3 +++
 http-push.c          |    2 ++
 imap-send.c          |    3 +++
 index-pack.c         |    3 +++
 merge-index.c        |    3 +++
 merge-tree.c         |    3 +++
 mktag.c              |    3 +++
 mktree.c             |    3 +++
 pack-redundant.c     |    3 +++
 patch-id.c           |    3 +++
 unpack-file.c        |    3 +++
 update-server-info.c |    3 +++
 upload-pack.c        |    2 ++
 var.c                |    3 +++
 16 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/daemon.c b/daemon.c
index 540700e..d93cf96 100644
--- a/daemon.c
+++ b/daemon.c
@@ -937,6 +937,8 @@ int main(int argc, char **argv)
 	gid_t gid = 0;
 	int i;
 
+	git_extract_argv0_path(argv[0]);
+
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
 
diff --git a/fast-import.c b/fast-import.c
index f0e08ac..1935206 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -150,6 +150,7 @@ Format of STDIN stream:
 #include "refs.h"
 #include "csum-file.h"
 #include "quote.h"
+#include "exec_cmd.h"
 
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
@@ -2406,6 +2407,8 @@ int main(int argc, const char **argv)
 {
 	unsigned int i, show_stats = 1;
 
+	git_extract_argv0_path(argv[0]);
+
 	setup_git_directory();
 	git_config(git_pack_config, NULL);
 	if (!pack_compression_seen && core_compression_seen)
diff --git a/hash-object.c b/hash-object.c
index 846e91a..37e6677 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -8,6 +8,7 @@
 #include "blob.h"
 #include "quote.h"
 #include "parse-options.h"
+#include "exec_cmd.h"
 
 static void hash_fd(int fd, const char *type, int write_object, const char *path)
 {
@@ -81,6 +82,8 @@ int main(int argc, const char **argv)
 
 	type = blob_type;
 
+	git_extract_argv0_path(argv[0]);
+
 	git_config(git_default_config, NULL);
 
 	argc = parse_options(argc, argv, hash_object_options, hash_object_usage, 0);
diff --git a/http-push.c b/http-push.c
index a4b7d08..09caede 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2179,6 +2179,8 @@ int main(int argc, char **argv)
 	struct ref *ref;
 	char *rewritten_url = NULL;
 
+	git_extract_argv0_path(argv[0]);
+
 	setup_git_directory();
 
 	remote = xcalloc(sizeof(*remote), 1);
diff --git a/imap-send.c b/imap-send.c
index c3fa0df..f91293c 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -23,6 +23,7 @@
  */
 
 #include "cache.h"
+#include "exec_cmd.h"
 #ifdef NO_OPENSSL
 typedef void *SSL;
 #endif
@@ -1389,6 +1390,8 @@ int main(int argc, char **argv)
 	int total, n = 0;
 	int nongit_ok;
 
+	git_extract_argv0_path(argv[0]);
+
 	/* init the random number generator */
 	arc4_init();
 
diff --git a/index-pack.c b/index-pack.c
index 2931511..72c41fd 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -8,6 +8,7 @@
 #include "tree.h"
 #include "progress.h"
 #include "fsck.h"
+#include "exec_cmd.h"
 
 static const char index_pack_usage[] =
 "git index-pack [-v] [-o <index-file>] [{ ---keep | --keep=<msg> }] [--strict] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
@@ -880,6 +881,8 @@ int main(int argc, char **argv)
 	struct pack_idx_entry **idx_objects;
 	unsigned char pack_sha1[20];
 
+	git_extract_argv0_path(argv[0]);
+
 	/*
 	 * We wish to read the repository's config file if any, and
 	 * for that it is necessary to call setup_git_directory_gently().
diff --git a/merge-index.c b/merge-index.c
index 7827e87..c00a2b3 100644
--- a/merge-index.c
+++ b/merge-index.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "run-command.h"
+#include "exec_cmd.h"
 
 static const char *pgm;
 static const char *arguments[9];
@@ -93,6 +94,8 @@ int main(int argc, char **argv)
 	if (argc < 3)
 		usage("git-merge-index [-o] [-q] <merge-program> (-a | [--] <filename>*)");
 
+	git_extract_argv0_path(argv[0]);
+
 	setup_git_directory();
 	read_cache();
 
diff --git a/merge-tree.c b/merge-tree.c
index 2d1413e..f18201a 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -2,6 +2,7 @@
 #include "tree-walk.h"
 #include "xdiff-interface.h"
 #include "blob.h"
+#include "exec_cmd.h"
 
 static const char merge_tree_usage[] = "git-merge-tree <base-tree> <branch1> <branch2>";
 static int resolve_directories = 1;
@@ -344,6 +345,8 @@ int main(int argc, char **argv)
 	if (argc != 4)
 		usage(merge_tree_usage);
 
+	git_extract_argv0_path(argv[0]);
+
 	setup_git_directory();
 
 	buf1 = get_tree_descriptor(t+0, argv[1]);
diff --git a/mktag.c b/mktag.c
index ba3d495..6d5083e 100644
--- a/mktag.c
+++ b/mktag.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "tag.h"
+#include "exec_cmd.h"
 
 /*
  * A signature file has a very simple fixed format: four lines
@@ -159,6 +160,8 @@ int main(int argc, char **argv)
 	if (argc != 1)
 		usage("git-mktag < signaturefile");
 
+	git_extract_argv0_path(argv[0]);
+
 	setup_git_directory();
 
 	if (strbuf_read(&buf, 0, 4096) < 0) {
diff --git a/mktree.c b/mktree.c
index 514fd9b..6283bc3 100644
--- a/mktree.c
+++ b/mktree.c
@@ -6,6 +6,7 @@
 #include "cache.h"
 #include "quote.h"
 #include "tree.h"
+#include "exec_cmd.h"
 
 static struct treeent {
 	unsigned mode;
@@ -70,6 +71,8 @@ int main(int ac, char **av)
 	unsigned char sha1[20];
 	int line_termination = '\n';
 
+	git_extract_argv0_path(av[0]);
+
 	setup_git_directory();
 
 	while ((1 < ac) && av[1][0] == '-') {
diff --git a/pack-redundant.c b/pack-redundant.c
index e93eb96..48a12bc 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -7,6 +7,7 @@
 */
 
 #include "cache.h"
+#include "exec_cmd.h"
 
 #define BLKSIZE 512
 
@@ -601,6 +602,8 @@ int main(int argc, char **argv)
 	unsigned char *sha1;
 	char buf[42]; /* 40 byte sha1 + \n + \0 */
 
+	git_extract_argv0_path(argv[0]);
+
 	setup_git_directory();
 
 	for (i = 1; i < argc; i++) {
diff --git a/patch-id.c b/patch-id.c
index 871f1d2..3660ad4 100644
--- a/patch-id.c
+++ b/patch-id.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "exec_cmd.h"
 
 static void flush_current_id(int patchlen, unsigned char *id, git_SHA_CTX *c)
 {
@@ -79,6 +80,8 @@ int main(int argc, char **argv)
 	if (argc != 1)
 		usage(patch_id_usage);
 
+	git_extract_argv0_path(argv[0]);
+
 	generate_id_list();
 	return 0;
 }
diff --git a/unpack-file.c b/unpack-file.c
index bcdc8bb..6dd8ad0 100644
--- a/unpack-file.c
+++ b/unpack-file.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "blob.h"
+#include "exec_cmd.h"
 
 static char *create_temp_file(unsigned char *sha1)
 {
@@ -25,6 +26,8 @@ int main(int argc, char **argv)
 {
 	unsigned char sha1[20];
 
+	git_extract_argv0_path(argv[0]);
+
 	if (argc != 2)
 		usage("git-unpack-file <sha1>");
 	if (get_sha1(argv[1], sha1))
diff --git a/update-server-info.c b/update-server-info.c
index 7e8209e..7b38fd8 100644
--- a/update-server-info.c
+++ b/update-server-info.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "exec_cmd.h"
 
 static const char update_server_info_usage[] =
 "git update-server-info [--force]";
@@ -19,6 +20,8 @@ int main(int ac, char **av)
 	if (i != ac)
 		usage(update_server_info_usage);
 
+	git_extract_argv0_path(av[0]);
+
 	setup_git_directory();
 
 	return !!update_server_info(force);
diff --git a/upload-pack.c b/upload-pack.c
index e5adbc0..5db6f93 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -616,6 +616,8 @@ int main(int argc, char **argv)
 	int i;
 	int strict = 0;
 
+	git_extract_argv0_path(argv[0]);
+
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
 
diff --git a/var.c b/var.c
index f1eb314..7362ed8 100644
--- a/var.c
+++ b/var.c
@@ -4,6 +4,7 @@
  * Copyright (C) Eric Biederman, 2005
  */
 #include "cache.h"
+#include "exec_cmd.h"
 
 static const char var_usage[] = "git var [-l | <variable>]";
 
@@ -56,6 +57,8 @@ int main(int argc, char **argv)
 		usage(var_usage);
 	}
 
+	git_extract_argv0_path(argv[0]);
+
 	setup_git_directory_gently(&nongit);
 	val = NULL;
 
-- 
1.6.1.87.g15624
