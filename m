From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 5/7] Add calls to git_extract_argv0_path() in programs that call git_config_*
Date: Sun, 17 Aug 2008 14:44:41 +0200
Message-ID: <1218977083-14526-6-git-send-email-prohaska@zib.de>
References: <1218977083-14526-1-git-send-email-prohaska@zib.de>
 <1218977083-14526-2-git-send-email-prohaska@zib.de>
 <1218977083-14526-3-git-send-email-prohaska@zib.de>
 <1218977083-14526-4-git-send-email-prohaska@zib.de>
 <1218977083-14526-5-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Aug 17 14:46:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUhel-0001rR-TI
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 14:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755407AbYHQMpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 08:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755387AbYHQMpp
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 08:45:45 -0400
Received: from mailer.zib.de ([130.73.108.11]:52297 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755375AbYHQMpn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 08:45:43 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m7HCjAIT022125;
	Sun, 17 Aug 2008 14:45:15 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m7HCihbS002872;
	Sun, 17 Aug 2008 14:44:44 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1218977083-14526-5-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92607>

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
index 8dcde73..172854e 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1055,6 +1055,9 @@ int main(int argc, char **argv)
 	gid_t gid = 0;
 	int i;
 
+	if (argv[0] && *argv[0])
+		git_extract_argv0_path(argv[0]);
+
 	/* Without this we cannot rely on waitpid() to tell
 	 * what happened to our children.
 	 */
diff --git a/fast-import.c b/fast-import.c
index 7089e6f..7789d60 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -150,6 +150,7 @@ Format of STDIN stream:
 #include "refs.h"
 #include "csum-file.h"
 #include "quote.h"
+#include "exec_cmd.h"
 
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
@@ -2394,6 +2395,9 @@ int main(int argc, const char **argv)
 {
 	unsigned int i, show_stats = 1;
 
+	if (argv[0] && *argv[0])
+		git_extract_argv0_path(argv[0]);
+
 	setup_git_directory();
 	git_config(git_pack_config, NULL);
 	if (!pack_compression_seen && core_compression_seen)
diff --git a/hash-object.c b/hash-object.c
index 46c06a9..0f77a46 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -7,6 +7,7 @@
 #include "cache.h"
 #include "blob.h"
 #include "quote.h"
+#include "exec_cmd.h"
 
 static void hash_object(const char *path, enum object_type type, int write_object)
 {
@@ -65,6 +66,9 @@ int main(int argc, char **argv)
 	int hashstdin = 0;
 	int stdin_paths = 0;
 
+	if (argv[0] && *argv[0])
+		git_extract_argv0_path(argv[0]);
+
 	git_config(git_default_config, NULL);
 
 	for (i = 1 ; i < argc; i++) {
diff --git a/index-pack.c b/index-pack.c
index 52064be..bd5983b 100644
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
 	struct pack_idx_entry **idx_objects;
 	unsigned char sha1[20];
 
+	if (argv[0] && *argv[0])
+		git_extract_argv0_path(argv[0]);
+
 	git_config(git_index_pack_config, NULL);
 
 	for (i = 1; i < argc; i++) {
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
1.6.0.rc3.22.g053fd
