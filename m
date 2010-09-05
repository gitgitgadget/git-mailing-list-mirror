From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 03/15] Read sparse limiting args from $GIT_DIR/sparse-limit
Date: Sat,  4 Sep 2010 18:13:55 -0600
Message-ID: <1283645647-1891-4-git-send-email-newren@gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
Cc: pclouds@gmail.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 02:13:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os2rk-0008IQ-2U
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 02:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535Ab0IEANI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 20:13:08 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:65512 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754482Ab0IEAM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 20:12:58 -0400
Received: by pwi3 with SMTP id 3so647396pwi.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 17:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7yaOTjAvJSflDdfLl/5V0/iZMS1CBqZq/GyOP6/mdJI=;
        b=K0QDSzpcJWrQvJo777gDWdEPT4xCSj9s32KcoVotSwcIbiEFp1F9EF0YyygYYXukyK
         kHQzJUiKxR5+/H73qLGo4/MWH7QD4hbezlygVIRnRw9/krV9CogjUHY61jgqX74vjCPG
         9mdAO+FNCFqkeVH3vephMpzGEEd2Ev+Ttoj9U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tJ4wa+vK13QZGddqg5HCB9uHVp92Nnwe13oNR1FiEiE5cdZeAPPl+rySiMDwzQNJL/
         r7IavebGjXPfDp644HUX3/GpskMQ//1ey2gm9B88pyJN81nS4vNL/XP/+MT3Mx+ev10O
         pkrdf3ng+CrPhS05Eadj1+1gh0NM8uoBpBRao=
Received: by 10.114.173.5 with SMTP id v5mr1244071wae.79.1283645577498;
        Sat, 04 Sep 2010 17:12:57 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 33sm7341833wad.18.2010.09.04.17.12.55
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 17:12:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.140.gd06af
In-Reply-To: <1283645647-1891-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155399>

Sparse clones will be created by specifying rev-list args to clone in order
to limit what is downloaded.  In order to avoid accessing unavailable
objects, these limiting rev-list args are recorded in $GIT_DIR/sparse-limit
so that other operations can make use of them.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Makefile      |    2 +
 cache.h       |    3 ++
 environment.c |    2 +
 setup.c       |    2 +
 sparse-repo.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sparse-repo.h |    3 ++
 tree-diff.c   |    2 +
 7 files changed, 78 insertions(+), 0 deletions(-)
 create mode 100644 sparse-repo.c
 create mode 100644 sparse-repo.h

diff --git a/Makefile b/Makefile
index d3db459..ba4b9bf 100644
--- a/Makefile
+++ b/Makefile
@@ -548,6 +548,7 @@ LIB_H += run-command.h
 LIB_H += sha1-lookup.h
 LIB_H += sideband.h
 LIB_H += sigchain.h
+LIB_H += sparse-repo.h
 LIB_H += strbuf.h
 LIB_H += string-list.h
 LIB_H += submodule.h
@@ -657,6 +658,7 @@ LIB_OBJS += sha1_name.o
 LIB_OBJS += shallow.o
 LIB_OBJS += sideband.o
 LIB_OBJS += sigchain.o
+LIB_OBJS += sparse-repo.o
 LIB_OBJS += strbuf.o
 LIB_OBJS += string-list.o
 LIB_OBJS += submodule.o
diff --git a/cache.h b/cache.h
index ce7bdd1..6f88dbb 100644
--- a/cache.h
+++ b/cache.h
@@ -403,6 +403,9 @@ extern const char *const local_repo_env[LOCAL_REPO_ENV_SIZE + 1];
 extern int is_bare_repository_cfg;
 extern int is_bare_repository(void);
 extern int is_inside_git_dir(void);
+extern const char **git_sparse_limits;
+extern const char **git_sparse_pathspecs;
+extern struct diff_options git_sparse_diffopts;
 extern char *git_work_tree_cfg;
 extern int is_inside_work_tree(void);
 extern int have_git_dir(void);
diff --git a/environment.c b/environment.c
index cc097b7..fc9d21d 100644
--- a/environment.c
+++ b/environment.c
@@ -61,6 +61,8 @@ struct startup_info *startup_info;
 int core_preload_index = 0;
 
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
+const char **git_sparse_limits = NULL;
+const char **git_sparse_pathspecs = NULL;
 char *git_work_tree_cfg;
 static char *work_tree;
 
diff --git a/setup.c b/setup.c
index a3b76de..92f4385 100644
--- a/setup.c
+++ b/setup.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "dir.h"
+#include "sparse-repo.h"
 
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
@@ -256,6 +257,7 @@ static int check_repository_format_gently(int *nongit_ok)
 		*nongit_ok = -1;
 		return -1;
 	}
+	check_sparse_repo();
 	return 0;
 }
 
diff --git a/sparse-repo.c b/sparse-repo.c
new file mode 100644
index 0000000..18ea976
--- /dev/null
+++ b/sparse-repo.c
@@ -0,0 +1,64 @@
+#include "sparse-repo.h"
+#include "cache.h"
+#include "diff.h"
+#include "quote.h"
+
+#define SPARSE_FILE "sparse-limits"
+
+void register_sparse_limits(const char **revlist_argv)
+{
+	if (revlist_argv != git_sparse_limits) {
+		free(git_sparse_limits);
+		git_sparse_limits = revlist_argv;
+	}
+
+	git_sparse_pathspecs = git_sparse_limits;
+	for (; *git_sparse_pathspecs; git_sparse_pathspecs++)
+		/*
+		 * Sparse limiting args must always have a double dash before
+		 * any paths, since users will likely fetch/pull from bare
+		 * repositories.  That makes it easy to find the pathspec
+		 * portion of the sparse limits.
+		 */
+		if (strcmp(*git_sparse_pathspecs, "--") == 0) {
+			/*
+			 * Make git_sparse_limits provide quick access
+			 * to non-pathspec rev-list arguments, and
+			 * git_sparse_pathspec provide access to the
+			 * rest.
+			 */
+			*git_sparse_pathspecs = NULL;
+			git_sparse_pathspecs++;
+			break;
+		}
+	diff_tree_setup_paths(git_sparse_pathspecs, &git_sparse_diffopts);
+}
+
+void register_quoted_sparse_limits(char *quoted_argv)
+{
+	int nr = 0, alloc = 0;
+
+	sq_dequote_to_argv(strdup(quoted_argv), &git_sparse_limits, &nr, &alloc);
+	ALLOC_GROW(git_sparse_limits, nr+1, alloc);
+	git_sparse_limits[nr] = NULL;
+
+	register_sparse_limits(git_sparse_limits);
+}
+
+void check_sparse_repo(void)
+{
+	struct stat statbuf;
+	struct strbuf buffer = STRBUF_INIT;
+
+	char *sparse_file = git_path(SPARSE_FILE);
+	if (stat(sparse_file, &statbuf))
+		return;
+
+	if (git_sparse_limits)
+		die("tried to initialize sparse limits twice!\n");
+
+	if (strbuf_read_file(&buffer, sparse_file, statbuf.st_size) < 0)
+		die_errno("could not read %s", sparse_file);
+	register_quoted_sparse_limits(buffer.buf);
+	strbuf_release(&buffer);
+}
diff --git a/sparse-repo.h b/sparse-repo.h
new file mode 100644
index 0000000..ed9018a
--- /dev/null
+++ b/sparse-repo.h
@@ -0,0 +1,3 @@
+void register_sparse_limits(const char **revlist_argv);
+void register_quoted_sparse_limits(char *quoted_argv);
+void check_sparse_repo(void);
diff --git a/tree-diff.c b/tree-diff.c
index d976bdf..951b53b 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -6,6 +6,8 @@
 #include "diffcore.h"
 #include "tree.h"
 
+struct diff_options git_sparse_diffopts;
+
 static char *malloc_base(const char *base, int baselen, const char *path, int pathlen)
 {
 	char *newbase = xmalloc(baselen + pathlen + 2);
-- 
1.7.2.2.140.gd06af
