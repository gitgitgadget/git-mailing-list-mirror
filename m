From: Max Kirillov <max@max630.net>
Subject: [PATCH v9 2/2] path: implement common_dir handling in git_pathdup_submodule()
Date: Mon, 14 Sep 2015 01:17:42 +0300
Message-ID: <1442182662-28834-3-git-send-email-max@max630.net>
References: <1442182662-28834-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>, Duy Nguyen <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 00:18:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbFbH-0005a3-BG
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 00:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbbIMWSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 18:18:12 -0400
Received: from p3plsmtpa07-08.prod.phx3.secureserver.net ([173.201.192.237]:50585
	"EHLO p3plsmtpa07-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751893AbbIMWSJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Sep 2015 18:18:09 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa07-08.prod.phx3.secureserver.net with 
	id GmHx1r0035B68XE01mJ77m; Sun, 13 Sep 2015 15:18:09 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <1442182662-28834-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277798>

When submodule is a linked worktree, "git diff --submodule" and other
calls which directly access the submodule's object database do not correctly
calculate its path. Fix it by changing the git_pathdup_submodule() behavior,
to use either common or per-worktree directory.

Do it similarly as for parent repository, but ignore the GIT_COMMON_DIR
environment variable, because it would mean common directory for the parent
repository and does not make sense for submodule.

Also add test for functionality which uses this call.

Signed-off-by: Max Kirillov <max@max630.net>
---
 cache.h                          |  1 +
 path.c                           | 22 ++++++++++++++++++----
 setup.c                          | 17 ++++++++++++-----
 t/t7410-submodule-checkout-to.sh | 10 ++++++++++
 4 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index 79066e5..5eb36b4 100644
--- a/cache.h
+++ b/cache.h
@@ -443,6 +443,7 @@ extern char *get_object_directory(void);
 extern char *get_index_file(void);
 extern char *get_graft_file(void);
 extern int set_git_dir(const char *path);
+extern int get_common_dir_noenv(struct strbuf *sb, const char *gitdir);
 extern int get_common_dir(struct strbuf *sb, const char *gitdir);
 extern const char *get_git_namespace(void);
 extern const char *strip_namespace(const char *namespaced_ref);
diff --git a/path.c b/path.c
index 95acbaf..22b9e0b 100644
--- a/path.c
+++ b/path.c
@@ -98,7 +98,7 @@ static const char *common_list[] = {
 	NULL
 };
 
-static void update_common_dir(struct strbuf *buf, int git_dir_len)
+static void update_common_dir(struct strbuf *buf, int git_dir_len, const char *common_dir)
 {
 	char *base = buf->buf + git_dir_len;
 	const char **p;
@@ -115,12 +115,16 @@ static void update_common_dir(struct strbuf *buf, int git_dir_len)
 			path++;
 			is_dir = 1;
 		}
+
+		if (!common_dir)
+			common_dir = get_git_common_dir();
+
 		if (is_dir && dir_prefix(base, path)) {
-			replace_dir(buf, git_dir_len, get_git_common_dir());
+			replace_dir(buf, git_dir_len, common_dir);
 			return;
 		}
 		if (!is_dir && !strcmp(base, path)) {
-			replace_dir(buf, git_dir_len, get_git_common_dir());
+			replace_dir(buf, git_dir_len, common_dir);
 			return;
 		}
 	}
@@ -160,7 +164,7 @@ static void adjust_git_path(struct strbuf *buf, int git_dir_len)
 	else if (git_db_env && dir_prefix(base, "objects"))
 		replace_dir(buf, git_dir_len + 7, get_object_directory());
 	else if (git_common_dir_env)
-		update_common_dir(buf, git_dir_len);
+		update_common_dir(buf, git_dir_len, NULL);
 }
 
 static void do_git_path(struct strbuf *buf, const char *fmt, va_list args)
@@ -228,6 +232,8 @@ static void do_submodule_path(struct strbuf *buf, const char *path,
 			      const char *fmt, va_list args)
 {
 	const char *git_dir;
+	struct strbuf git_submodule_common_dir = STRBUF_INIT;
+	struct strbuf git_submodule_dir = STRBUF_INIT;
 
 	strbuf_addstr(buf, path);
 	if (buf->len && buf->buf[buf->len - 1] != '/')
@@ -240,9 +246,17 @@ static void do_submodule_path(struct strbuf *buf, const char *path,
 		strbuf_addstr(buf, git_dir);
 	}
 	strbuf_addch(buf, '/');
+	strbuf_addstr(&git_submodule_dir, buf->buf);
 
 	strbuf_vaddf(buf, fmt, args);
+
+	if (get_common_dir_noenv(&git_submodule_common_dir, git_submodule_dir.buf))
+		update_common_dir(buf, git_submodule_dir.len, git_submodule_common_dir.buf);
+
 	strbuf_cleanup_path(buf);
+
+	strbuf_release(&git_submodule_dir);
+	strbuf_release(&git_submodule_common_dir);
 }
 
 char *git_pathdup_submodule(const char *path, const char *fmt, ...)
diff --git a/setup.c b/setup.c
index a17c51e..e41e5e1 100644
--- a/setup.c
+++ b/setup.c
@@ -229,14 +229,21 @@ void verify_non_filename(const char *prefix, const char *arg)
 
 int get_common_dir(struct strbuf *sb, const char *gitdir)
 {
+	const char *git_env_common_dir = getenv(GIT_COMMON_DIR_ENVIRONMENT);
+	if (git_env_common_dir) {
+		strbuf_addstr(sb, git_env_common_dir);
+		return 1;
+	} else {
+		return get_common_dir_noenv(sb, gitdir);
+	}
+}
+
+int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
+{
 	struct strbuf data = STRBUF_INIT;
 	struct strbuf path = STRBUF_INIT;
-	const char *git_common_dir = getenv(GIT_COMMON_DIR_ENVIRONMENT);
 	int ret = 0;
-	if (git_common_dir) {
-		strbuf_addstr(sb, git_common_dir);
-		return 1;
-	}
+
 	strbuf_addf(&path, "%s/commondir", gitdir);
 	if (file_exists(path.buf)) {
 		if (strbuf_read_file(&data, path.buf, 0) <= 0)
diff --git a/t/t7410-submodule-checkout-to.sh b/t/t7410-submodule-checkout-to.sh
index 3f609e8..1acef32 100755
--- a/t/t7410-submodule-checkout-to.sh
+++ b/t/t7410-submodule-checkout-to.sh
@@ -47,4 +47,14 @@ test_expect_success 'checkout main and initialize independed clones' \
 test_expect_success 'can see submodule diffs after independed cloning' \
     '(cd fully_cloned_submodule/main && git diff --submodule master"^!" | grep "file1 updated")'
 
+test_expect_success 'checkout sub manually' \
+    'mkdir linked_submodule &&
+    (cd clone/main &&
+	git worktree add "$base_path/linked_submodule/main" "$rev1_hash_main") &&
+    (cd clone/main/sub &&
+	git worktree add "$base_path/linked_submodule/main/sub" "$rev1_hash_sub")'
+
+test_expect_success 'can see submodule diffs after manual checkout of linked submodule' \
+    '(cd linked_submodule/main && git diff --submodule master"^!" | grep "file1 updated")'
+
 test_done
-- 
2.3.4.2801.g3d0809b
