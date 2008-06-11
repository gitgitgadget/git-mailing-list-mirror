From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 01/10] Move split_cmdline() to alias.c
Date: Wed, 11 Jun 2008 22:50:25 +0200
Message-ID: <4818a0b71b7f6b44ef49621045a5871458ba5c38.1213217187.git.vmiklos@frugalware.org>
References: <cover.1213217187.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 22:51:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6XI3-00007M-65
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 22:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355AbYFKUug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 16:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752245AbYFKUug
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 16:50:36 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:32874 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167AbYFKUuf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 16:50:35 -0400
Received: from vmobile.example.net (dsl5401C482.pool.t-online.hu [84.1.196.130])
	by yugo.frugalware.org (Postfix) with ESMTP id E91661DDC5B
	for <git@vger.kernel.org>; Wed, 11 Jun 2008 22:50:31 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id AF33C18DFDB; Wed, 11 Jun 2008 22:50:35 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc2.dirty
In-Reply-To: <cover.1213217187.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1213217187.git.vmiklos@frugalware.org>
References: <cover.1213217187.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84651>

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
index 995f3e6..ccb1108 100644
--- a/alias.c
+++ b/alias.c
@@ -21,3 +21,57 @@ char *alias_lookup(const char *alias)
 	git_config(alias_lookup_cb, NULL);
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
index 0a63c0e..18ec38c 100644
--- a/cache.h
+++ b/cache.h
@@ -832,5 +832,6 @@ int report_path_error(const char *ps_matched, const char **pathspec, int prefix_
 void overlay_tree_on_cache(const char *tree_name, const char *prefix);
 
 char *alias_lookup(const char *alias);
+int split_cmdline(char *cmdline, const char ***argv);
 
 #endif /* CACHE_H */
diff --git a/git.c b/git.c
index 15a0e71..0a0b11e 100644
--- a/git.c
+++ b/git.c
@@ -90,59 +90,6 @@ static int handle_options(const char*** argv, int* argc, int* envchanged)
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
1.5.6.rc2.dirty
