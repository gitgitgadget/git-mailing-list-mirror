From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH 2/2] git-clean: correct printing relative path
Date: Fri,  7 Mar 2008 04:13:17 +0300
Message-ID: <1204852397-20939-2-git-send-email-dpotapov@gmail.com>
References: <7vr6en8n7k.fsf@gitster.siamese.dyndns.org>
 <1204852397-20939-1-git-send-email-dpotapov@gmail.com>
Cc: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 02:14:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXR9u-0008S0-8N
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 02:14:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753722AbYCGBN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 20:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753107AbYCGBN0
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 20:13:26 -0500
Received: from smtp05.mtu.ru ([62.5.255.52]:49925 "EHLO smtp05.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752586AbYCGBNV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 20:13:21 -0500
Received: from smtp05.mtu.ru (localhost [127.0.0.1])
	by smtp05.mtu.ru (Postfix) with ESMTP id 7FBB1A2F306;
	Fri,  7 Mar 2008 04:13:20 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-140-168-16.pppoe.mtu-net.ru [85.140.168.16])
	by smtp05.mtu.ru (Postfix) with ESMTP id 52BBCA2C534;
	Fri,  7 Mar 2008 04:13:18 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JXR9B-0005S6-Q3; Fri, 07 Mar 2008 04:13:17 +0300
X-Mailer: git-send-email 1.5.4.3.452.g9b9f
In-Reply-To: <1204852397-20939-1-git-send-email-dpotapov@gmail.com>
X-DCC-STREAM-Metrics: smtp05.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76442>

When the given path contains '..' then git-clean incorrectly printed names
of files. This patch changes cmd_clean to use quote_path_relative().
Also, "failed to remove ..." message used absolutely path, but not it is
corrected to use relative path.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 builtin-clean.c |   32 ++++++++++++++------------------
 1 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/builtin-clean.c b/builtin-clean.c
index 3b220d5..fefec30 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -10,6 +10,7 @@
 #include "cache.h"
 #include "dir.h"
 #include "parse-options.h"
+#include "quote.h"
 
 static int force = -1; /* unset */
 
@@ -34,7 +35,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	struct dir_struct dir;
 	const char *path, *base;
 	static const char **pathspec;
-	int prefix_offset = 0;
+	struct strbuf buf;
+	const char *qname;
 	char *seen = NULL;
 	struct option options[] = {
 		OPT__QUIET(&quiet),
@@ -56,6 +58,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, options, builtin_clean_usage, 0);
 
+	strbuf_init(&buf, 0);
 	memset(&dir, 0, sizeof(dir));
 	if (ignored_only)
 		dir.show_ignored = 1;
@@ -72,8 +75,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	if (!ignored)
 		setup_standard_excludes(&dir);
 
-	if (prefix)
-		prefix_offset = strlen(prefix);
 	pathspec = get_pathspec(prefix, argv);
 	read_cache();
 
@@ -134,39 +135,34 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 		if (S_ISDIR(st.st_mode)) {
 			strbuf_addstr(&directory, ent->name);
+			qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
 			if (show_only && (remove_directories || matches)) {
-				printf("Would remove %s\n",
-				       directory.buf + prefix_offset);
+				printf("Would remove %s\n", qname);
 			} else if (remove_directories || matches) {
 				if (!quiet)
-					printf("Removing %s\n",
-					       directory.buf + prefix_offset);
+					printf("Removing %s\n", qname);
 				if (remove_dir_recursively(&directory, 0) != 0) {
-					warning("failed to remove '%s'",
-						directory.buf + prefix_offset);
+					warning("failed to remove '%s'", qname);
 					errors++;
 				}
 			} else if (show_only) {
-				printf("Would not remove %s\n",
-				       directory.buf + prefix_offset);
+				printf("Would not remove %s\n", qname);
 			} else {
-				printf("Not removing %s\n",
-				       directory.buf + prefix_offset);
+				printf("Not removing %s\n", qname);
 			}
 			strbuf_reset(&directory);
 		} else {
 			if (pathspec && !matches)
 				continue;
+			qname = quote_path_relative(ent->name, -1, &buf, prefix);
 			if (show_only) {
-				printf("Would remove %s\n",
-				       ent->name + prefix_offset);
+				printf("Would remove %s\n", qname);
 				continue;
 			} else if (!quiet) {
-				printf("Removing %s\n",
-				       ent->name + prefix_offset);
+				printf("Removing %s\n", qname);
 			}
 			if (unlink(ent->name) != 0) {
-				warning("failed to remove '%s'", ent->name);
+				warning("failed to remove '%s'", qname);
 				errors++;
 			}
 		}
-- 
1.5.4.3.452.g9b9f

