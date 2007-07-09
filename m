From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH v2] Make fetch-pack a builtin with an internal API
Date: Mon, 9 Jul 2007 01:10:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707090104120.6977@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jul 09 07:10:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7lVw-0005N6-Uc
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 07:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbXGIFKV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 01:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbXGIFKT
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 01:10:19 -0400
Received: from iabervon.org ([66.92.72.58]:2186 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751581AbXGIFKS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 01:10:18 -0400
Received: (qmail 29215 invoked by uid 1000); 9 Jul 2007 05:10:16 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Jul 2007 05:10:16 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51952>

In addition to making fetch-pack a builtin, this allows it to be called 
directly from other built-in code without generating and parsing argument 
lists, which will be useful for builtin-fetch.

Incidently, it makes git-fetch-pack not output lists of what it fetched 
when it fails.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Makefile                             |    1 +
 fetch-pack.c => builtin-fetch-pack.c |   92 ++++++++++++++++++++++++++--------
 builtin.h                            |    1 +
 fetch-pack.h                         |   16 ++++++
 git.c                                |    1 +
 5 files changed, 89 insertions(+), 22 deletions(-)
 rename fetch-pack.c => builtin-fetch-pack.c (92%)
 create mode 100644 fetch-pack.h

diff --git a/Makefile b/Makefile
index 4ea5e45..da750f8 100644
--- a/Makefile
+++ b/Makefile
@@ -342,6 +342,7 @@ BUILTIN_OBJS = \
 	builtin-diff-files.o \
 	builtin-diff-index.o \
 	builtin-diff-tree.o \
+	builtin-fetch-pack.o \
 	builtin-fetch--tool.o \
 	builtin-fmt-merge-msg.o \
 	builtin-for-each-ref.o \
diff --git a/fetch-pack.c b/builtin-fetch-pack.c
similarity index 92%
rename from fetch-pack.c
rename to builtin-fetch-pack.c
index 9c81305..27daa33 100644
--- a/fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -6,6 +6,7 @@
 #include "exec_cmd.h"
 #include "pack.h"
 #include "sideband.h"
+#include "fetch-pack.h"
 
 static int keep_pack;
 static int transfer_unpack_limit = -1;
@@ -573,7 +574,7 @@ static int get_pack(int xd[2])
 	die("%s died of unnatural causes %d", argv[0], status);
 }
 
-static int fetch_pack(int fd[2], int nr_match, char **match)
+static struct ref *do_fetch_pack(int fd[2], int nr_match, char **match)
 {
 	struct ref *ref;
 	unsigned char sha1[20];
@@ -615,12 +616,7 @@ static int fetch_pack(int fd[2], int nr_match, char **match)
 		die("git-fetch-pack: fetch failed.");
 
  all_done:
-	while (ref) {
-		printf("%s %s\n",
-		       sha1_to_hex(ref->old_sha1), ref->name);
-		ref = ref->next;
-	}
-	return 0;
+	return ref;
 }
 
 static int remove_duplicates(int nr_heads, char **heads)
@@ -663,15 +659,36 @@ static int fetch_pack_config(const char *var, const char *value)
 
 static struct lock_file lock;
 
-int main(int argc, char **argv)
+void setup_fetch_pack(const char *_uploadpack,
+		      int _quiet,
+		      int _keep_pack,
+		      int _unpacklimit,
+		      int _use_thin_pack,
+		      int _fetch_all,
+		      int _verbose,
+		      int _depth,
+		      int _no_progress)
+{
+	uploadpack = _uploadpack;
+	quiet = _quiet;
+	keep_pack = _keep_pack;
+	if (_unpacklimit >= 0)
+		unpack_limit = _unpacklimit;
+	if (keep_pack)
+		unpack_limit = 0;
+	use_thin_pack = _use_thin_pack;
+	fetch_all = _fetch_all;
+	verbose = _verbose;
+	depth = _depth;
+	no_progress = _no_progress;
+}
+
+int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, ret, nr_heads;
+	struct ref *ref;
 	char *dest = NULL, **heads;
-	int fd[2];
-	pid_t pid;
-	struct stat st;
 
-	setup_git_directory();
 	git_config(fetch_pack_config);
 
 	if (0 <= transfer_unpack_limit)
@@ -682,7 +699,7 @@ int main(int argc, char **argv)
 	nr_heads = 0;
 	heads = NULL;
 	for (i = 1; i < argc; i++) {
-		char *arg = argv[i];
+		const char *arg = argv[i];
 
 		if (*arg == '-') {
 			if (!prefixcmp(arg, "--upload-pack=")) {
@@ -716,8 +733,6 @@ int main(int argc, char **argv)
 			}
 			if (!prefixcmp(arg, "--depth=")) {
 				depth = strtol(arg + 8, NULL, 0);
-				if (stat(git_path("shallow"), &st))
-					st.st_mtime = 0;
 				continue;
 			}
 			if (!strcmp("--no-progress", arg)) {
@@ -726,22 +741,52 @@ int main(int argc, char **argv)
 			}
 			usage(fetch_pack_usage);
 		}
-		dest = arg;
-		heads = argv + i + 1;
+		dest = (char *)arg;
+		heads = (char **)(argv + i + 1);
 		nr_heads = argc - i - 1;
 		break;
 	}
 	if (!dest)
 		usage(fetch_pack_usage);
-	pid = git_connect(fd, dest, uploadpack, verbose ? CONNECT_VERBOSE : 0);
+
+	ref = fetch_pack(dest, nr_heads, heads);
+
+	ret = !ref;
+
+	while (ref) {
+		printf("%s %s\n",
+		       sha1_to_hex(ref->old_sha1), ref->name);
+		ref = ref->next;
+	}
+
+	return ret;
+}
+
+struct ref *fetch_pack(const char *dest, int nr_heads, char **heads)
+{
+	int i, ret;
+	int fd[2];
+	pid_t pid;
+	struct ref *ref;
+	struct stat st;
+
+	if (depth > 0) {
+		if (stat(git_path("shallow"), &st))
+			st.st_mtime = 0;
+	}
+
+	printf("connect to %s\n", dest);
+
+	pid = git_connect(fd, (char *)dest, uploadpack,
+                          verbose ? CONNECT_VERBOSE : 0);
 	if (pid < 0)
-		return 1;
+		return NULL;
 	if (heads && nr_heads)
 		nr_heads = remove_duplicates(nr_heads, heads);
-	ret = fetch_pack(fd, nr_heads, heads);
+	ref = do_fetch_pack(fd, nr_heads, heads);
 	close(fd[0]);
 	close(fd[1]);
-	ret |= finish_connect(pid);
+	ret = finish_connect(pid);
 
 	if (!ret && nr_heads) {
 		/* If the heads to pull were given, we should have
@@ -785,5 +830,8 @@ int main(int argc, char **argv)
 		}
 	}
 
-	return !!ret;
+	if (ret)
+		ref = NULL;
+
+	return ref;
 }
diff --git a/builtin.h b/builtin.h
index 661a92f..8fa38d4 100644
--- a/builtin.h
+++ b/builtin.h
@@ -31,6 +31,7 @@ extern int cmd_diff_files(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_index(int argc, const char **argv, const char *prefix);
 extern int cmd_diff(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_fetch_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_fetch__tool(int argc, const char **argv, const char *prefix);
 extern int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix);
 extern int cmd_for_each_ref(int argc, const char **argv, const char *prefix);
diff --git a/fetch-pack.h b/fetch-pack.h
new file mode 100644
index 0000000..2bd05a8
--- /dev/null
+++ b/fetch-pack.h
@@ -0,0 +1,16 @@
+#ifndef FETCH_PACK_API
+#define FETCH_PACK_API
+
+void setup_fetch_pack(const char *_uploadpack,
+		      int _quiet,
+		      int _keep_pack,
+		      int _unpacklimit,
+		      int _use_thin_pack,
+		      int _fetch_all,
+		      int _verbose,
+		      int _depth,
+		      int _no_progress);
+
+struct ref *fetch_pack(const char *dest, int nr_heads, char **heads);
+
+#endif
diff --git a/git.c b/git.c
index b949cbb..df45161 100644
--- a/git.c
+++ b/git.c
@@ -307,6 +307,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "diff-files", cmd_diff_files },
 		{ "diff-index", cmd_diff_index, RUN_SETUP },
 		{ "diff-tree", cmd_diff_tree, RUN_SETUP },
+		{ "fetch-pack", cmd_fetch_pack, RUN_SETUP },
 		{ "fetch--tool", cmd_fetch__tool, RUN_SETUP },
 		{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
 		{ "for-each-ref", cmd_for_each_ref, RUN_SETUP },
-- 
1.5.2.2.1399.g097d5-dirty
