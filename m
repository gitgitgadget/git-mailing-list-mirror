From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 4/6] Add calls to git_extract_argv0_path() in programs that call git_config_*
Date: Sat, 10 Jan 2009 14:50:50 +0100
Message-ID: <1231595452-27698-4-git-send-email-prohaska@zib.de>
References: <1231595452-27698-1-git-send-email-prohaska@zib.de>
 <1231595452-27698-2-git-send-email-prohaska@zib.de>
 <1231595452-27698-3-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 14:53:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLeH4-0006VW-3J
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 14:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280AbZAJNvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 08:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753155AbZAJNvc
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 08:51:32 -0500
Received: from mailer.zib.de ([130.73.108.11]:45501 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753137AbZAJNv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 08:51:27 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n0ADosNS025834;
	Sat, 10 Jan 2009 14:51:03 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n0ADorWO016764;
	Sat, 10 Jan 2009 14:50:54 +0100 (MET)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1231595452-27698-3-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105106>

Programs that use git_config need to find the global configuration.
When runtime prefix computation is enabled, this requires that
git_extract_argv0_path() is called early in the program's main().

This commit adds the necessary calls.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 daemon.c             |    3 +++
 fast-import.c        |    4 ++++
 hash-object.c        |    4 ++++
 http-push.c          |    3 +++
 imap-send.c          |    4 ++++
 index-pack.c         |    4 ++++
 merge-index.c        |    4 ++++
 merge-tree.c         |    4 ++++
 mktag.c              |    4 ++++
 mktree.c             |    4 ++++
 pack-redundant.c     |    4 ++++
 patch-id.c           |    4 ++++
 unpack-file.c        |    4 ++++
 update-server-info.c |    4 ++++
 var.c                |    4 ++++
 15 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/daemon.c b/daemon.c
index 540700e..1c5e604 100644
--- a/daemon.c
+++ b/daemon.c
@@ -937,6 +937,9 @@ int main(int argc, char **argv)
 	gid_t gid = 0;
 	int i;
 
+	if (argv[0] && *argv[0])
+		git_extract_argv0_path(argv[0]);
+
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
 
diff --git a/fast-import.c b/fast-import.c
index a6bce66..7762205 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -150,6 +150,7 @@ Format of STDIN stream:
 #include "refs.h"
 #include "csum-file.h"
 #include "quote.h"
+#include "exec_cmd.h"
 
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
@@ -2405,6 +2406,9 @@ int main(int argc, const char **argv)
 {
 	unsigned int i, show_stats = 1;
 
+	if (argv[0] && *argv[0])
+		git_extract_argv0_path(argv[0]);
+
 	setup_git_directory();
 	git_config(git_pack_config, NULL);
 	if (!pack_compression_seen && core_compression_seen)
diff --git a/hash-object.c b/hash-object.c
index 846e91a..a689cc6 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -8,6 +8,7 @@
 #include "blob.h"
 #include "quote.h"
 #include "parse-options.h"
+#include "exec_cmd.h"
 
 static void hash_fd(int fd, const char *type, int write_object, const char *path)
 {
@@ -81,6 +82,9 @@ int main(int argc, const char **argv)
 
 	type = blob_type;
 
+	if (argv[0] && *argv[0])
+		git_extract_argv0_path(argv[0]);
+
 	git_config(git_default_config, NULL);
 
 	argc = parse_options(argc, argv, hash_object_options, hash_object_usage, 0);
diff --git a/http-push.c b/http-push.c
index a4b7d08..dd2b2b1 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2179,6 +2179,9 @@ int main(int argc, char **argv)
 	struct ref *ref;
 	char *rewritten_url = NULL;
 
+	if (argv[0] && *argv[0])
+		git_extract_argv0_path(argv[0]);
+
 	setup_git_directory();
 
 	remote = xcalloc(sizeof(*remote), 1);
diff --git a/imap-send.c b/imap-send.c
index c3fa0df..6e92aee 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -23,6 +23,7 @@
  */
 
 #include "cache.h"
+#include "exec_cmd.h"
 #ifdef NO_OPENSSL
 typedef void *SSL;
 #endif
@@ -1389,6 +1390,9 @@ int main(int argc, char **argv)
 	int total, n = 0;
 	int nongit_ok;
 
+	if (argv[0] && *argv[0])
+		git_extract_argv0_path(argv[0]);
+
 	/* init the random number generator */
 	arc4_init();
 
diff --git a/index-pack.c b/index-pack.c
index 2931511..0df297b 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -8,6 +8,7 @@
 #include "tree.h"
 #include "progress.h"
 #include "fsck.h"
+#include "exec_cmd.h"
 
 static const char index_pack_usage[] =
 "git index-pack [-v] [-o <index-file>] [{ ---keep | --keep=<msg> }] [--strict] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
@@ -880,6 +881,9 @@ int main(int argc, char **argv)
 	struct pack_idx_entry **idx_objects;
 	unsigned char pack_sha1[20];
 
+	if (argv[0] && *argv[0])
+		git_extract_argv0_path(argv[0]);
+
 	/*
 	 * We wish to read the repository's config file if any, and
 	 * for that it is necessary to call setup_git_directory_gently().
diff --git a/merge-index.c b/merge-index.c
index 7827e87..5d89ead 100644
--- a/merge-index.c
+++ b/merge-index.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "run-command.h"
+#include "exec_cmd.h"
 
 static const char *pgm;
 static const char *arguments[9];
@@ -93,6 +94,9 @@ int main(int argc, char **argv)
 	if (argc < 3)
 		usage("git-merge-index [-o] [-q] <merge-program> (-a | [--] <filename>*)");
 
+	if (argv[0] && *argv[0])
+		git_extract_argv0_path(argv[0]);
+
 	setup_git_directory();
 	read_cache();
 
diff --git a/merge-tree.c b/merge-tree.c
index 2d1413e..165ccfc 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -2,6 +2,7 @@
 #include "tree-walk.h"
 #include "xdiff-interface.h"
 #include "blob.h"
+#include "exec_cmd.h"
 
 static const char merge_tree_usage[] = "git-merge-tree <base-tree> <branch1> <branch2>";
 static int resolve_directories = 1;
@@ -344,6 +345,9 @@ int main(int argc, char **argv)
 	if (argc != 4)
 		usage(merge_tree_usage);
 
+	if (argv[0] && *argv[0])
+		git_extract_argv0_path(argv[0]);
+
 	setup_git_directory();
 
 	buf1 = get_tree_descriptor(t+0, argv[1]);
diff --git a/mktag.c b/mktag.c
index ba3d495..ff32f8a 100644
--- a/mktag.c
+++ b/mktag.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "tag.h"
+#include "exec_cmd.h"
 
 /*
  * A signature file has a very simple fixed format: four lines
@@ -159,6 +160,9 @@ int main(int argc, char **argv)
 	if (argc != 1)
 		usage("git-mktag < signaturefile");
 
+	if (argv[0] && *argv[0])
+		git_extract_argv0_path(argv[0]);
+
 	setup_git_directory();
 
 	if (strbuf_read(&buf, 0, 4096) < 0) {
diff --git a/mktree.c b/mktree.c
index 514fd9b..8ac0d57 100644
--- a/mktree.c
+++ b/mktree.c
@@ -6,6 +6,7 @@
 #include "cache.h"
 #include "quote.h"
 #include "tree.h"
+#include "exec_cmd.h"
 
 static struct treeent {
 	unsigned mode;
@@ -70,6 +71,9 @@ int main(int ac, char **av)
 	unsigned char sha1[20];
 	int line_termination = '\n';
 
+	if (av[0] && *av[0])
+		git_extract_argv0_path(av[0]);
+
 	setup_git_directory();
 
 	while ((1 < ac) && av[1][0] == '-') {
diff --git a/pack-redundant.c b/pack-redundant.c
index e93eb96..8ff119b 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -7,6 +7,7 @@
 */
 
 #include "cache.h"
+#include "exec_cmd.h"
 
 #define BLKSIZE 512
 
@@ -601,6 +602,9 @@ int main(int argc, char **argv)
 	unsigned char *sha1;
 	char buf[42]; /* 40 byte sha1 + \n + \0 */
 
+	if (argv[0] && *argv[0])
+		git_extract_argv0_path(argv[0]);
+
 	setup_git_directory();
 
 	for (i = 1; i < argc; i++) {
diff --git a/patch-id.c b/patch-id.c
index 871f1d2..ff460e2 100644
--- a/patch-id.c
+++ b/patch-id.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "exec_cmd.h"
 
 static void flush_current_id(int patchlen, unsigned char *id, git_SHA_CTX *c)
 {
@@ -79,6 +80,9 @@ int main(int argc, char **argv)
 	if (argc != 1)
 		usage(patch_id_usage);
 
+	if (argv[0] && *argv[0])
+		git_extract_argv0_path(argv[0]);
+
 	generate_id_list();
 	return 0;
 }
diff --git a/unpack-file.c b/unpack-file.c
index bcdc8bb..f8bfda7 100644
--- a/unpack-file.c
+++ b/unpack-file.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "blob.h"
+#include "exec_cmd.h"
 
 static char *create_temp_file(unsigned char *sha1)
 {
@@ -25,6 +26,9 @@ int main(int argc, char **argv)
 {
 	unsigned char sha1[20];
 
+	if (argv[0] && *argv[0])
+		git_extract_argv0_path(argv[0]);
+
 	if (argc != 2)
 		usage("git-unpack-file <sha1>");
 	if (get_sha1(argv[1], sha1))
diff --git a/update-server-info.c b/update-server-info.c
index 7e8209e..286a4dd 100644
--- a/update-server-info.c
+++ b/update-server-info.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "exec_cmd.h"
 
 static const char update_server_info_usage[] =
 "git update-server-info [--force]";
@@ -19,6 +20,9 @@ int main(int ac, char **av)
 	if (i != ac)
 		usage(update_server_info_usage);
 
+	if (av[0] && *av[0])
+		git_extract_argv0_path(av[0]);
+
 	setup_git_directory();
 
 	return !!update_server_info(force);
diff --git a/var.c b/var.c
index f1eb314..33457dc 100644
--- a/var.c
+++ b/var.c
@@ -4,6 +4,7 @@
  * Copyright (C) Eric Biederman, 2005
  */
 #include "cache.h"
+#include "exec_cmd.h"
 
 static const char var_usage[] = "git var [-l | <variable>]";
 
@@ -56,6 +57,9 @@ int main(int argc, char **argv)
 		usage(var_usage);
 	}
 
+	if (argv[0] && *argv[0])
+		git_extract_argv0_path(argv[0]);
+
 	setup_git_directory_gently(&nongit);
 	val = NULL;
 
-- 
1.6.1.85.g32c5d
