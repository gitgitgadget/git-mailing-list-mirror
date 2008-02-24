From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] make alias lookup a public, procedural function
Date: Sun, 24 Feb 2008 17:17:14 -0500
Message-ID: <20080224221714.GC31309@coredump.intra.peff.net>
References: <cover.1203890846.git.peff@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 23:17:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTPAQ-0002zS-Ev
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 23:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142AbYBXWRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 17:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752959AbYBXWRR
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 17:17:17 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4548 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752446AbYBXWRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 17:17:16 -0500
Received: (qmail 2387 invoked by uid 111); 24 Feb 2008 22:17:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 24 Feb 2008 17:17:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Feb 2008 17:17:14 -0500
Content-Disposition: inline
In-Reply-To: <cover.1203890846.git.peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74969>

This converts git_config_alias to the public alias_lookup
function. Because of the nature of our config parser, we
still have to rely on setting static data. However, that
interface is wrapped so that you can just say

  value = alias_lookup(key);

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile |    3 ++-
 alias.c  |   22 ++++++++++++++++++++++
 cache.h  |    2 ++
 git.c    |   17 +++--------------
 4 files changed, 29 insertions(+), 15 deletions(-)
 create mode 100644 alias.c

diff --git a/Makefile b/Makefile
index d33a556..b460bb2 100644
--- a/Makefile
+++ b/Makefile
@@ -327,7 +327,8 @@ LIB_OBJS = \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
 	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o \
-	transport.o bundle.o walker.o parse-options.o ws.o archive.o
+	transport.o bundle.o walker.o parse-options.o ws.o archive.o \
+	alias.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/alias.c b/alias.c
new file mode 100644
index 0000000..116cac8
--- /dev/null
+++ b/alias.c
@@ -0,0 +1,22 @@
+#include "cache.h"
+
+static const char *alias_key;
+static char *alias_val;
+static int alias_lookup_cb(const char *k, const char *v)
+{
+	if (!prefixcmp(k, "alias.") && !strcmp(k+6, alias_key)) {
+		if (!v)
+			return config_error_nonbool(k);
+		alias_val = xstrdup(v);
+		return 0;
+	}
+	return 0;
+}
+
+char *alias_lookup(const char *alias)
+{
+	alias_key = alias;
+	alias_val = NULL;
+	git_config(alias_lookup_cb);
+	return alias_val;
+}
diff --git a/cache.h b/cache.h
index fa5a9e5..1e9c937 100644
--- a/cache.h
+++ b/cache.h
@@ -765,4 +765,6 @@ int pathspec_match(const char **spec, char *matched, const char *filename, int s
 int report_path_error(const char *ps_matched, const char **pathspec, int prefix_offset);
 void overlay_tree_on_cache(const char *tree_name, const char *prefix);
 
+char *alias_lookup(const char *alias);
+
 #endif /* CACHE_H */
diff --git a/git.c b/git.c
index 0cb8688..8f08b12 100644
--- a/git.c
+++ b/git.c
@@ -87,19 +87,6 @@ static int handle_options(const char*** argv, int* argc, int* envchanged)
 	return handled;
 }
 
-static const char *alias_command;
-static char *alias_string;
-
-static int git_alias_config(const char *var, const char *value)
-{
-	if (!prefixcmp(var, "alias.") && !strcmp(var + 6, alias_command)) {
-		if (!value)
-			return config_error_nonbool(var);
-		alias_string = xstrdup(value);
-	}
-	return 0;
-}
-
 static int split_cmdline(char *cmdline, const char ***argv)
 {
 	int src, dst, count = 0, size = 16;
@@ -159,11 +146,13 @@ static int handle_alias(int *argcp, const char ***argv)
 	const char *subdir;
 	int count, option_count;
 	const char** new_argv;
+	const char *alias_command;
+	char *alias_string;
 
 	subdir = setup_git_directory_gently(&nongit);
 
 	alias_command = (*argv)[0];
-	git_config(git_alias_config);
+	alias_string = alias_lookup(alias_command);
 	if (alias_string) {
 		if (alias_string[0] == '!') {
 			if (*argcp > 1) {
-- 
1.5.4.3.305.g073a4
