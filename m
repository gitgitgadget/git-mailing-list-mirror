From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 9/9] git-verify-pack: make builtin
Date: Thu, 10 Aug 2006 17:02:38 +0200
Message-ID: <11552221581436-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <11552221582769-git-send-email-rene.scharfe@lsrfire.ath.cx>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 17:04:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBC3w-0007Pt-Na
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 17:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161306AbWHJPCu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 11:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161307AbWHJPCu
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 11:02:50 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:12229
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1161306AbWHJPCp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 11:02:45 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id C7B227036; Thu, 10 Aug 2006 17:02:38 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.2.rc4.g242a
In-Reply-To: <11552221582769-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25194>

Convert git-verify-pack to a builtin command.  Also rename ac to argc
and av to argv for consistancy.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Makefile              |    1 +
 builtin-verify-pack.c |   77 +++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h             |    1 +
 git.c                 |    1 +
 verify-pack.c         |   76 ------------------------------------------------
 5 files changed, 80 insertions(+), 76 deletions(-)

diff --git a/Makefile b/Makefile
index faa118a..07c421b 100644
--- a/Makefile
+++ b/Makefile
@@ -295,6 +295,7 @@ BUILTIN_OBJS = \
 	builtin-update-index.o \
 	builtin-update-ref.o \
 	builtin-upload-tar.o \
+	builtin-verify-pack.o \
 	builtin-write-tree.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
diff --git a/builtin-verify-pack.c b/builtin-verify-pack.c
new file mode 100644
index 0000000..15f2502
--- /dev/null
+++ b/builtin-verify-pack.c
@@ -0,0 +1,79 @@
+#include "builtin.h"
+#include "cache.h"
+#include "pack.h"
+
+static int verify_one_pack(const char *path, int verbose)
+{
+	char arg[PATH_MAX];
+	int len;
+	struct packed_git *pack;
+	int err;
+
+	len = strlcpy(arg, path, PATH_MAX);
+	if (len >= PATH_MAX)
+		return error("name too long: %s", path);
+
+	/*
+	 * In addition to "foo.idx" we accept "foo.pack" and "foo";
+	 * normalize these forms to "foo.idx" for add_packed_git().
+	 */
+	if (has_extension(arg, len, ".pack")) {
+		strcpy(arg + len - 5, ".idx");
+		len--;
+	} else if (!has_extension(arg, len, ".idx")) {
+		if (len + 4 >= PATH_MAX)
+			return error("name too long: %s.idx", arg);
+		strcpy(arg + len, ".idx");
+		len += 4;
+	}
+
+	/*
+	 * add_packed_git() uses our buffer (containing "foo.idx") to
+	 * build the pack filename ("foo.pack").  Make sure it fits.
+	 */
+	if (len + 1 >= PATH_MAX) {
+		arg[len - 4] = '\0';
+		return error("name too long: %s.pack", arg);
+	}
+
+	pack = add_packed_git(arg, len, 1);
+	if (!pack)
+		return error("packfile %s not found.", arg);
+
+	err = verify_pack(pack, verbose);
+	free(pack);
+
+	return err;
+}
+
+static const char verify_pack_usage[] = "git-verify-pack [-v] <pack>...";
+
+int cmd_verify_pack(int argc, const char **argv, const char *prefix)
+{
+	int err = 0;
+	int verbose = 0;
+	int no_more_options = 0;
+	int nothing_done = 1;
+
+	while (1 < argc) {
+		if (!no_more_options && argv[1][0] == '-') {
+			if (!strcmp("-v", argv[1]))
+				verbose = 1;
+			else if (!strcmp("--", argv[1]))
+				no_more_options = 1;
+			else
+				usage(verify_pack_usage);
+		}
+		else {
+			if (verify_one_pack(argv[1], verbose))
+				err = 1;
+			nothing_done = 0;
+		}
+		argc--; argv++;
+	}
+
+	if (nothing_done)
+		usage(verify_pack_usage);
+
+	return err;
+}
diff --git a/builtin.h b/builtin.h
index c0bdb05..ade58c4 100644
--- a/builtin.h
+++ b/builtin.h
@@ -59,5 +59,6 @@ extern int cmd_upload_tar(int argc, cons
 extern int cmd_version(int argc, const char **argv, const char *prefix);
 extern int cmd_whatchanged(int argc, const char **argv, const char *prefix);
 extern int cmd_write_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_verify_pack(int argc, const char **argv, const char *prefix);
 
 #endif
diff --git a/git.c b/git.c
index db0f867..5da7787 100644
--- a/git.c
+++ b/git.c
@@ -270,6 +270,7 @@ static void handle_internal_command(int 
 		{ "version", cmd_version },
 		{ "whatchanged", cmd_whatchanged, RUN_SETUP | USE_PAGER },
 		{ "write-tree", cmd_write_tree, RUN_SETUP },
+		{ "verify-pack", cmd_verify_pack },
 	};
 	int i;
 
diff --git a/verify-pack.c b/verify-pack.c
deleted file mode 100644
index f12cefe..0000000
--- a/verify-pack.c
+++ /dev/null
@@ -1,78 +0,0 @@
-#include "cache.h"
-#include "pack.h"
-
-static int verify_one_pack(const char *path, int verbose)
-{
-	char arg[PATH_MAX];
-	int len;
-	struct packed_git *pack;
-	int err;
-
-	len = strlcpy(arg, path, PATH_MAX);
-	if (len >= PATH_MAX)
-		return error("name too long: %s", path);
-	
-	/*
-	 * In addition to "foo.idx" we accept "foo.pack" and "foo";
-	 * normalize these forms to "foo.idx" for add_packed_git().
-	 */
-	if (has_extension(arg, len, ".pack")) {
-		strcpy(arg + len - 5, ".idx");
-		len--;
-	} else if (!has_extension(arg, len, ".idx")) {
-		if (len + 4 >= PATH_MAX)
-			return error("name too long: %s.idx", arg);
-		strcpy(arg + len, ".idx");
-		len += 4;
-	}
-
-	/*
-	 * add_packed_git() uses our buffer (containing "foo.idx") to
-	 * build the pack filename ("foo.pack").  Make sure it fits.
-	 */
-	if (len + 1 >= PATH_MAX) {
-		arg[len - 4] = '\0';
-		return error("name too long: %s.pack", arg);
-	}
-
-	pack = add_packed_git(arg, len, 1);
-	if (!pack)
-		return error("packfile %s not found.", arg);
-
-	err = verify_pack(pack, verbose);
-	free(pack);
-
-	return err;
-}
-
-static const char verify_pack_usage[] = "git-verify-pack [-v] <pack>...";
-
-int main(int ac, char **av)
-{
-	int err = 0;
-	int verbose = 0;
-	int no_more_options = 0;
-	int nothing_done = 1;
-
-	while (1 < ac) {
-		if (!no_more_options && av[1][0] == '-') {
-			if (!strcmp("-v", av[1]))
-				verbose = 1;
-			else if (!strcmp("--", av[1]))
-				no_more_options = 1;
-			else
-				usage(verify_pack_usage);
-		}
-		else {
-			if (verify_one_pack(av[1], verbose))
-				err = 1;
-			nothing_done = 0;
-		}
-		ac--; av++;
-	}
-
-	if (nothing_done)
-		usage(verify_pack_usage);
-
-	return err;
-}
-- 
1.4.2.rc2.g822a
