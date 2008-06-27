From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 01/15] Move split_cmdline() to alias.c
Date: Fri, 27 Jun 2008 18:21:54 +0200
Message-ID: <58b2c36de6a6f51a562da303695482bea567f4bf.1214581610.git.vmiklos@frugalware.org>
References: <cover.1214581610.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 18:24:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCGk2-0004E3-3f
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 18:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760737AbYF0QWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 12:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760117AbYF0QWL
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 12:22:11 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:45330 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759561AbYF0QWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 12:22:09 -0400
Received: from vmobile.example.net (dsl5401C209.pool.t-online.hu [84.1.194.9])
	by yugo.frugalware.org (Postfix) with ESMTP id C23CA1DDC5D;
	Fri, 27 Jun 2008 18:22:05 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id D241818E829; Fri, 27 Jun 2008 18:22:08 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <cover.1214581610.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1214581610.git.vmiklos@frugalware.org>
References: <cover.1214581610.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86586>

split_cmdline() is currently used for aliases only, but later it can be
useful for other builtins as well. Move it to alias.c for now,
indicating that originally it's for aliases, but we'll have it in libgit
this way.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
index c8954ef..d5463d8 100644
--- a/cache.h
+++ b/cache.h
@@ -830,5 +830,6 @@ int report_path_error(const char *ps_matched, const char **pathspec, int prefix_
 void overlay_tree_on_cache(const char *tree_name, const char *prefix);
 
 char *alias_lookup(const char *alias);
+int split_cmdline(char *cmdline, const char ***argv);
 
 #endif /* CACHE_H */
diff --git a/git.c b/git.c
index 59f0fcc..2fbe96b 100644
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
1.5.6
