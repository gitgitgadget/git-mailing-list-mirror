From: Max Kirillov <max@max630.net>
Subject: [PATCH v4 2/2] path: implement common_dir handling in git_path_submodule()
Date: Wed, 18 Mar 2015 23:10:52 +0200
Message-ID: <1426713052-19171-3-git-send-email-max@max630.net>
References: <1426713052-19171-1-git-send-email-max@max630.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Max Kirillov <max@max630.net>
To: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 18 22:19:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYLN6-00052c-Cb
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 22:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756812AbbCRVTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 17:19:18 -0400
Received: from p3plsmtpa11-07.prod.phx3.secureserver.net ([68.178.252.108]:52307
	"EHLO p3plsmtpa11-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756801AbbCRVTP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Mar 2015 17:19:15 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Mar 2015 17:19:12 EDT
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa11-07.prod.phx3.secureserver.net with 
	id 59Bw1q00T5B68XE019C5Tn; Wed, 18 Mar 2015 14:12:07 -0700
X-Mailer: git-send-email 2.1.1.391.g7a54a76
In-Reply-To: <1426713052-19171-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265763>

This allows making submodules a linked workdirs.

Same as for .git, but ignores the GIT_COMMON_DIR environment variable,
because it would mean common directory for the parent repository and
does not make sense for submodule.

Also add test for functionality which uses this call.

Signed-off-by: Max Kirillov <max@max630.net>
---
 cache.h                          |  1 +
 path.c                           | 24 ++++++++++++++++++++----
 setup.c                          | 17 ++++++++++++-----
 t/t7410-submodule-checkout-to.sh | 10 ++++++++++
 4 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index 670e861..4cd03f0 100644
--- a/cache.h
+++ b/cache.h
@@ -437,6 +437,7 @@ extern char *get_object_directory(void);
 extern char *get_index_file(void);
 extern char *get_graft_file(void);
 extern int set_git_dir(const char *path);
+extern int get_common_dir_noenv(struct strbuf *sb, const char *gitdir);
 extern int get_common_dir(struct strbuf *sb, const char *gitdir);
 extern const char *get_git_namespace(void);
 extern const char *strip_namespace(const char *namespaced_ref);
diff --git a/path.c b/path.c
index a5c51a3..78f718f 100644
--- a/path.c
+++ b/path.c
@@ -98,7 +98,7 @@ static const char *common_list[] = {
 	NULL
 };
 
-static void update_common_dir(struct strbuf *buf, int git_dir_len)
+static void update_common_dir(struct strbuf *buf, int git_dir_len, const char* common_dir)
 {
 	char *base = buf->buf + git_dir_len;
 	const char **p;
@@ -115,12 +115,17 @@ static void update_common_dir(struct strbuf *buf, int git_dir_len)
 			path++;
 			is_dir = 1;
 		}
+
+		if (!common_dir) {
+			common_dir = get_git_common_dir();
+		}
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
@@ -160,7 +165,7 @@ static void adjust_git_path(struct strbuf *buf, int git_dir_len)
 	else if (git_db_env && dir_prefix(base, "objects"))
 		replace_dir(buf, git_dir_len + 7, get_object_directory());
 	else if (git_common_dir_env)
-		update_common_dir(buf, git_dir_len);
+		update_common_dir(buf, git_dir_len, NULL);
 }
 
 static void do_git_path(struct strbuf *buf, const char *fmt, va_list args)
@@ -256,6 +261,8 @@ const char *git_path_submodule(const char *path, const char *fmt, ...)
 {
 	struct strbuf *buf = get_pathname();
 	const char *git_dir;
+	struct strbuf git_submodule_common_dir = STRBUF_INIT;
+	struct strbuf git_submodule_dir = STRBUF_INIT;
 	va_list args;
 
 	strbuf_addstr(buf, path);
@@ -269,11 +276,20 @@ const char *git_path_submodule(const char *path, const char *fmt, ...)
 		strbuf_addstr(buf, git_dir);
 	}
 	strbuf_addch(buf, '/');
+	strbuf_addstr(&git_submodule_dir, buf->buf);
 
 	va_start(args, fmt);
 	strbuf_vaddf(buf, fmt, args);
 	va_end(args);
+
+	if (get_common_dir_noenv(&git_submodule_common_dir, git_submodule_dir.buf)) {
+		update_common_dir(buf, git_submodule_dir.len, git_submodule_common_dir.buf);
+	}
+
 	strbuf_cleanup_path(buf);
+
+	strbuf_release(&git_submodule_dir);
+	strbuf_release(&git_submodule_common_dir);
 	return buf->buf;
 }
 
diff --git a/setup.c b/setup.c
index fb61860..ffda622 100644
--- a/setup.c
+++ b/setup.c
@@ -226,14 +226,21 @@ void verify_non_filename(const char *prefix, const char *arg)
 
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
index 8f30aed..b43391a 100755
--- a/t/t7410-submodule-checkout-to.sh
+++ b/t/t7410-submodule-checkout-to.sh
@@ -47,4 +47,14 @@ test_expect_success 'checkout main and initialize independed clones' \
 test_expect_success 'can see submodule diffs after independed cloning' \
     '(cd fully_cloned_submodule/main && git diff --submodule master"^!" | grep "file1 updated")'
 
+test_expect_success 'checkout sub manually' \
+    'mkdir linked_submodule &&
+    (cd clone/main &&
+	git checkout --to "$base_path/linked_submodule/main" "$rev1_hash_main") &&
+    (cd clone/main/sub &&
+	git checkout --to "$base_path/linked_submodule/main/sub" "$rev1_hash_sub")'
+
+test_expect_success 'can see submodule diffs after manual checkout of linked submodule' \
+    '(cd linked_submodule/main && git diff --submodule master"^!" | grep "file1 updated")'
+
 test_done
-- 
2.1.1.391.g7a54a76
