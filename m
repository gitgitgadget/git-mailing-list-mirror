From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH] git-clean: correct printing relative path
Date: Wed,  5 Mar 2008 16:47:29 +0300
Message-ID: <1204724849-11298-1-git-send-email-dpotapov@gmail.com>
References: <20080305094058.GF4793@artemis.madism.org>
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 15:23:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWuWK-0002ge-5b
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 15:23:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbYCEOWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 09:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751895AbYCEOWW
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 09:22:22 -0500
Received: from smtp03.mtu.ru ([62.5.255.50]:57137 "EHLO smtp03.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751866AbYCEOWU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 09:22:20 -0500
Received: from smtp03.mtu.ru (localhost.mtu.ru [127.0.0.1])
	by smtp03.mtu.ru (Postfix) with ESMTP id AEE661870920;
	Wed,  5 Mar 2008 17:22:18 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-189-14.pppoe.mtu-net.ru [85.141.189.14])
	by smtp03.mtu.ru (Postfix) with ESMTP id 76AD7187088C;
	Wed,  5 Mar 2008 17:22:18 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JWtxx-0002wZ-G7; Wed, 05 Mar 2008 16:47:29 +0300
X-Mailer: git-send-email 1.5.4
In-Reply-To: <20080305094058.GF4793@artemis.madism.org>
X-DCC-STREAM-Metrics: smtp03.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76218>

When the given path contains '..' then git-clean incorrectly printed names
of files. This patch changes cmd_clean to use quote_path() from wt-status.
Also, "failed to remove ..." message used absolutely path, but not it is
corrected to use relative path.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 builtin-clean.c |   31 +++++++++++++------------------
 wt-status.c     |    4 ++--
 wt-status.h     |    2 ++
 3 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/builtin-clean.c b/builtin-clean.c
index 3b220d5..3d75ad6 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -34,7 +34,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	struct dir_struct dir;
 	const char *path, *base;
 	static const char **pathspec;
-	int prefix_offset = 0;
+	struct strbuf buf;
+	const char *qname;
 	char *seen = NULL;
 	struct option options[] = {
 		OPT__QUIET(&quiet),
@@ -56,6 +57,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, options, builtin_clean_usage, 0);
 
+	strbuf_init(&buf, 0);
 	memset(&dir, 0, sizeof(dir));
 	if (ignored_only)
 		dir.show_ignored = 1;
@@ -72,8 +74,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	if (!ignored)
 		setup_standard_excludes(&dir);
 
-	if (prefix)
-		prefix_offset = strlen(prefix);
 	pathspec = get_pathspec(prefix, argv);
 	read_cache();
 
@@ -133,40 +133,35 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		}
 
 		if (S_ISDIR(st.st_mode)) {
+			qname = quote_path(directory.buf, -1, &buf, prefix);
 			strbuf_addstr(&directory, ent->name);
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
+			qname = quote_path(ent->name, -1, &buf, prefix);
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
diff --git a/wt-status.c b/wt-status.c
index 32d780a..712fe91 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -82,8 +82,8 @@ static void wt_status_print_trailer(struct wt_status *s)
 	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
 }
 
-static char *quote_path(const char *in, int len,
-			struct strbuf *out, const char *prefix)
+char *quote_path(const char *in, int len,
+		struct strbuf *out, const char *prefix)
 {
 	if (len < 0)
 		len = strlen(in);
diff --git a/wt-status.h b/wt-status.h
index 02afaa6..4b46dda 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -32,5 +32,7 @@ int wt_status_use_color;
 int wt_status_relative_paths;
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
+char *quote_path(const char *in, int len,
+		struct strbuf *out, const char *prefix);
 
 #endif /* STATUS_H */
-- 
1.5.4

