From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 5/7] Add calls to git_extract_argv0_path() in programs that call git_config_*
Date: Sun, 21 Sep 2008 18:24:36 +0200
Message-ID: <1222014278-11071-6-git-send-email-prohaska@zib.de>
References: <1222014278-11071-1-git-send-email-prohaska@zib.de>
 <1222014278-11071-2-git-send-email-prohaska@zib.de>
 <1222014278-11071-3-git-send-email-prohaska@zib.de>
 <1222014278-11071-4-git-send-email-prohaska@zib.de>
 <1222014278-11071-5-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Sep 21 18:30:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhRpP-0002GU-Px
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 18:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbYIUQ3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 12:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbYIUQ3X
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 12:29:23 -0400
Received: from mailer.zib.de ([130.73.108.11]:51224 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751823AbYIUQ3V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 12:29:21 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m8LGOdKo005002;
	Sun, 21 Sep 2008 18:24:44 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m8LGOcxS015855;
	Sun, 21 Sep 2008 18:24:39 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1222014278-11071-5-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96410>

Programs that use git_config need to find the global
configuration.  When runtime prefix computation is enabled, this
requires that git_extract_argv0_path() is called early in the
program's main().

This commit adds the necessary calls in the programs that use
git_config.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 daemon.c      |    3 +++
 fast-import.c |    4 ++++
 hash-object.c |    4 ++++
 index-pack.c  |    4 ++++
 unpack-file.c |    4 ++++
 var.c         |    4 ++++
 6 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/daemon.c b/daemon.c
index 0e026f6..c46ddd4 100644
--- a/daemon.c
+++ b/daemon.c
@@ -956,6 +956,9 @@ int main(int argc, char **argv)
 	gid_t gid = 0;
 	int i;
 
+	if (argv[0] && *argv[0])
+		git_extract_argv0_path(argv[0]);
+
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
 
diff --git a/fast-import.c b/fast-import.c
index ccdf2e5..8a74f38 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -150,6 +150,7 @@ Format of STDIN stream:
 #include "refs.h"
 #include "csum-file.h"
 #include "quote.h"
+#include "exec_cmd.h"
 
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
@@ -2395,6 +2396,9 @@ int main(int argc, const char **argv)
 {
 	unsigned int i, show_stats = 1;
 
+	if (argv[0] && *argv[0])
+		git_extract_argv0_path(argv[0]);
+
 	setup_git_directory();
 	git_config(git_pack_config, NULL);
 	if (!pack_compression_seen && core_compression_seen)
diff --git a/hash-object.c b/hash-object.c
index a4d127c..6d9f948 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -8,6 +8,7 @@
 #include "blob.h"
 #include "quote.h"
 #include "parse-options.h"
+#include "exec_cmd.h"
 
 static void hash_fd(int fd, const char *type, int write_object, const char *path)
 {
@@ -83,6 +84,9 @@ int main(int argc, const char **argv)
 
 	type = blob_type;
 
+	if (argv[0] && *argv[0])
+		git_extract_argv0_path(argv[0]);
+
 	git_config(git_default_config, NULL);
 
 	argc = parse_options(argc, argv, hash_object_options, hash_object_usage, 0);
diff --git a/index-pack.c b/index-pack.c
index a6e91fe..c6ac0e6 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -8,6 +8,7 @@
 #include "tree.h"
 #include "progress.h"
 #include "fsck.h"
+#include "exec_cmd.h"
 
 static const char index_pack_usage[] =
 "git index-pack [-v] [-o <index-file>] [{ ---keep | --keep=<msg> }] [--strict] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
@@ -877,6 +878,9 @@ int main(int argc, char **argv)
 	unsigned char pack_sha1[20];
 	int nongit = 0;
 
+	if (argv[0] && *argv[0])
+		git_extract_argv0_path(argv[0]);
+
 	setup_git_directory_gently(&nongit);
 	git_config(git_index_pack_config, NULL);
 
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
1.6.0.2.GIT
