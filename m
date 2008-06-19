From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 01/11] Move split_cmdline() to alias.c
Date: Fri, 20 Jun 2008 01:22:26 +0200
Message-ID: <b9fc7f1cc6c36ba197ed2c0394a6b89ed33c4b96.1213917600.git.vmiklos@frugalware.org>
References: <cover.1213917600.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 01:24:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9TUV-0006Vg-WA
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 01:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070AbYFSXXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 19:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754066AbYFSXXM
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 19:23:12 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:46956 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046AbYFSXXK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 19:23:10 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id E40C11DDC61
	for <git@vger.kernel.org>; Fri, 20 Jun 2008 01:22:39 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 7ED5318E0E4; Fri, 20 Jun 2008 01:22:36 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <cover.1213917600.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1213917600.git.vmiklos@frugalware.org>
References: <cover.1213917600.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85574>

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
index 81b7e17..26b2cad 100644
--- a/cache.h
+++ b/cache.h
@@ -827,5 +827,6 @@ int report_path_error(const char *ps_matched, const char **pathspec, int prefix_
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
