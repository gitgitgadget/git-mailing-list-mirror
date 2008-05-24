From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 2/5] Move split_cmdline() to libgit
Date: Sat, 24 May 2008 02:01:05 +0200
Message-ID: <28874c24faf45e6e4499c9692cc1de1e93cd4dcf.1211586801.git.vmiklos@frugalware.org>
References: <cover.1211586801.git.vmiklos@frugalware.org>
 <40d6845554a032ef66a20289aea6c7b2f157fed3.1211586801.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 24 02:02:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzhD3-00012y-He
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 02:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758965AbYEXABO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 20:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758939AbYEXABM
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 20:01:12 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:36662 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbYEXABH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 20:01:07 -0400
Received: from vmobile.example.net (catv-5062e605.catv.broadband.hu [80.98.230.5])
	by yugo.frugalware.org (Postfix) with ESMTP id 8CF2C1DDC5D
	for <git@vger.kernel.org>; Sat, 24 May 2008 02:01:04 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 7E417185E18; Sat, 24 May 2008 02:01:08 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.357.g1af8b.dirty
In-Reply-To: <40d6845554a032ef66a20289aea6c7b2f157fed3.1211586801.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1211586801.git.vmiklos@frugalware.org>
References: <cover.1211586801.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82778>

split_cmdline() is currently used for aliases only, but later it can be
useful for other builtins as well. Move it to alias.c for now,
indicating that originally it's for aliases, but we'll have it in libgit
this way.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 alias.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 cache.h |    1 +
 git.c   |   53 -----------------------------------------------------
 3 files changed, 55 insertions(+), 53 deletions(-)

diff --git a/alias.c b/alias.c
index 116cac8..75bc48a 100644
--- a/alias.c
+++ b/alias.c
@@ -20,3 +20,57 @@ char *alias_lookup(const char *alias)
 	git_config(alias_lookup_cb);
 	return alias_val;
 }
+
+int split_cmdline(char *cmdline, const char ***argv)
+{
+	int src, dst, count = 0, size = 16;
+	char quoted = 0;
+
+	*argv = xmalloc(sizeof(char*) * size);
+
+	/* split alias_string */
+	(*argv)[count++] = cmdline;
+	for (src = dst = 0; cmdline[src];) {
+		char c = cmdline[src];
+		if (!quoted && isspace(c)) {
+			cmdline[dst++] = 0;
+			while (cmdline[++src]
+					&& isspace(cmdline[src]))
+				; /* skip */
+			if (count >= size) {
+				size += 16;
+				*argv = xrealloc(*argv, sizeof(char*) * size);
+			}
+			(*argv)[count++] = cmdline + dst;
+		} else if (!quoted && (c == '\'' || c == '"')) {
+			quoted = c;
+			src++;
+		} else if (c == quoted) {
+			quoted = 0;
+			src++;
+		} else {
+			if (c == '\\' && quoted != '\'') {
+				src++;
+				c = cmdline[src];
+				if (!c) {
+					free(*argv);
+					*argv = NULL;
+					return error("cmdline ends with \\");
+				}
+			}
+			cmdline[dst++] = c;
+			src++;
+		}
+	}
+
+	cmdline[dst] = 0;
+
+	if (quoted) {
+		free(*argv);
+		*argv = NULL;
+		return error("unclosed quote");
+	}
+
+	return count;
+}
+
diff --git a/cache.h b/cache.h
index 093f04c..5e22b1e 100644
--- a/cache.h
+++ b/cache.h
@@ -814,5 +814,6 @@ int report_path_error(const char *ps_matched, const char **pathspec, int prefix_
 void overlay_tree_on_cache(const char *tree_name, const char *prefix);
 
 char *alias_lookup(const char *alias);
+int split_cmdline(char *cmdline, const char ***argv);
 
 #endif /* CACHE_H */
diff --git a/git.c b/git.c
index 89b431f..b8df19e 100644
--- a/git.c
+++ b/git.c
@@ -87,59 +87,6 @@ static int handle_options(const char*** argv, int* argc, int* envchanged)
 	return handled;
 }
 
-static int split_cmdline(char *cmdline, const char ***argv)
-{
-	int src, dst, count = 0, size = 16;
-	char quoted = 0;
-
-	*argv = xmalloc(sizeof(char*) * size);
-
-	/* split alias_string */
-	(*argv)[count++] = cmdline;
-	for (src = dst = 0; cmdline[src];) {
-		char c = cmdline[src];
-		if (!quoted && isspace(c)) {
-			cmdline[dst++] = 0;
-			while (cmdline[++src]
-					&& isspace(cmdline[src]))
-				; /* skip */
-			if (count >= size) {
-				size += 16;
-				*argv = xrealloc(*argv, sizeof(char*) * size);
-			}
-			(*argv)[count++] = cmdline + dst;
-		} else if(!quoted && (c == '\'' || c == '"')) {
-			quoted = c;
-			src++;
-		} else if (c == quoted) {
-			quoted = 0;
-			src++;
-		} else {
-			if (c == '\\' && quoted != '\'') {
-				src++;
-				c = cmdline[src];
-				if (!c) {
-					free(*argv);
-					*argv = NULL;
-					return error("cmdline ends with \\");
-				}
-			}
-			cmdline[dst++] = c;
-			src++;
-		}
-	}
-
-	cmdline[dst] = 0;
-
-	if (quoted) {
-		free(*argv);
-		*argv = NULL;
-		return error("unclosed quote");
-	}
-
-	return count;
-}
-
 static int handle_alias(int *argcp, const char ***argv)
 {
 	int envchanged = 0, ret = 0, saved_errno = errno;
-- 
1.5.5.1.357.g1af8b.dirty
