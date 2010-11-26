From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 39/47] setup: limit get_git_work_tree()'s to explicit setup case only
Date: Fri, 26 Nov 2010 22:32:35 +0700
Message-ID: <1290785563-15339-40-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 17:04:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0mu-0003Vy-2y
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 17:04:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755004Ab0KZQEf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 11:04:35 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:48546 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954Ab0KZQEe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 11:04:34 -0500
Received: by pva4 with SMTP id 4so354717pva.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 08:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=+KrBAQG9NMijAn3XgRGuViUyIXqQECoGeRwBZcxGXvE=;
        b=HBFgcGY7ghJXnI7ExJj9KJlhIf2NRuw15dA9++kX0DuFnkc7AuThoJf9NQEZaDAYNA
         ujA+6znPzRhLR7Xx+XD2j357QyHqDWVhvJIKGZSOzcFesHbDLSk8/ZJzifsdKJ8zDZns
         wDO86mgWyTOOR/EWzEwxuhF30DmoCt27wMIf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Bt0LxTkAzSUpIaZzuQ4Mp4VeG5vLhkHYx68l4F5QxJilfB0r46muxjiKecPlHgUcAi
         379oIvv3Tq5Pcz3r0ag4JvGpsp3KM89ALbjF1qoacUNhPLBig+nVanvuiLUp2AfXNAtY
         nfL5M9kUWskn0vmS/O12FlxHmwb4F4gHl4bIA=
Received: by 10.142.179.21 with SMTP id b21mr2519899wff.432.1290786522015;
        Fri, 26 Nov 2010 07:48:42 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id b11sm2690719wff.9.2010.11.26.07.48.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:48:41 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:47:23 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162263>

get_git_work_tree() takes input as core.worktree, core.bare,
GIT_WORK_TREE and decides correct worktree setting.

Unfortunately it does not do its job well. core.worktree and
GIT_WORK_TREE should only be taken into account, if GIT_DIR is set
(which is handled by setup_explicit_git_dir). For other setup cases,
only core.bare matters.

Add a temporary variable setup_explicit to adjust get_git_work_tree()
behavior as such. This variable will be gone once setup_* rework is
done.

Also remove is_bare_repository_cfg check in set_git_work_tree() to
ease the rework. We are going to check for core.bare and core.worktree
early before setting worktree. For example, if core.bare is true, no
need to set worktree.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/init-db.c     |    1 +
 cache.h               |    1 +
 environment.c         |   10 ++++++-
 setup.c               |   10 ++++++-
 t/t1510-repo-setup.sh |   66 ++++++++++++++++++++++++-----------------=
-------
 5 files changed, 51 insertions(+), 37 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 9d4886c..ea06478 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -496,6 +496,7 @@ int cmd_init_db(int argc, const char **argv, const =
char *prefix)
 	if (is_bare_repository_cfg < 0)
 		is_bare_repository_cfg =3D guess_repository_type(git_dir);
=20
+	startup_info->setup_explicit =3D 1;
 	if (!is_bare_repository_cfg) {
 		if (git_dir) {
 			const char *git_dir_parent =3D strrchr(git_dir, '/');
diff --git a/cache.h b/cache.h
index 123dd4b..b2cdda7 100644
--- a/cache.h
+++ b/cache.h
@@ -1119,6 +1119,7 @@ const char *split_cmdline_strerror(int cmdline_er=
rno);
 /* git.c */
 struct startup_info {
 	int have_repository;
+	int setup_explicit;
 };
 extern struct startup_info *startup_info;
=20
diff --git a/environment.c b/environment.c
index de5581f..d811049 100644
--- a/environment.c
+++ b/environment.c
@@ -137,8 +137,6 @@ static int git_work_tree_initialized;
  */
 void set_git_work_tree(const char *new_work_tree)
 {
-	if (is_bare_repository_cfg >=3D 0)
-		die("cannot set work tree after initialization");
 	git_work_tree_initialized =3D 1;
 	free(work_tree);
 	work_tree =3D xstrdup(make_absolute_path(new_work_tree));
@@ -147,6 +145,14 @@ void set_git_work_tree(const char *new_work_tree)
=20
 const char *get_git_work_tree(void)
 {
+	if (startup_info && !startup_info->setup_explicit) {
+		if (is_bare_repository_cfg =3D=3D 1)
+			return NULL;
+		if (work_tree)
+			is_bare_repository_cfg =3D 0;
+		return work_tree;
+	}
+
 	if (!git_work_tree_initialized) {
 		work_tree =3D getenv(GIT_WORK_TREE_ENVIRONMENT);
 		/* core.bare =3D true overrides implicit and config work tree */
diff --git a/setup.c b/setup.c
index 49a1a25..c7d7198 100644
--- a/setup.c
+++ b/setup.c
@@ -331,6 +331,8 @@ static const char *setup_explicit_git_dir(const cha=
r *gitdirenv,
 	static char buffer[1024 + 1];
 	const char *retval;
=20
+	if (startup_info)
+		startup_info->setup_explicit =3D 1;
 	if (PATH_MAX - 40 < strlen(gitdirenv))
 		die("'$%s' too big", GIT_DIR_ENVIRONMENT);
 	if (!is_git_directory(gitdirenv)) {
@@ -382,12 +384,15 @@ static const char *setup_discovered_git_dir(const=
 char *work_tree_env,
 					    char *cwd, int *nongit_ok)
 {
 	int root_len;
+	char *work_tree;
=20
 	inside_git_dir =3D 0;
 	if (!work_tree_env)
 		inside_work_tree =3D 1;
 	root_len =3D offset_1st_component(cwd);
-	git_work_tree_cfg =3D xstrndup(cwd, offset > root_len ? offset : root=
_len);
+	work_tree =3D xstrndup(cwd, offset > root_len ? offset : root_len);
+	set_git_work_tree(work_tree);
+	free(work_tree);
 	if (check_repository_format_gently(gitdir, nongit_ok))
 		return NULL;
 	if (offset =3D=3D len)
@@ -627,7 +632,8 @@ const char *setup_git_directory(void)
 	const char *retval =3D setup_git_directory_gently(NULL);
=20
 	/* If the work tree is not the default one, recompute prefix */
-	if (inside_work_tree < 0) {
+	if ((!startup_info || startup_info->setup_explicit) &&
+	    inside_work_tree < 0) {
 		static char buffer[PATH_MAX + 1];
 		char *rel;
 		if (retval && chdir(retval))
diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index d8c181d..45feb80 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -132,7 +132,7 @@ test_expect_success '#1: setup' '
 	cd ..
 '
=20
-test_expect_failure '#1: at root' '
+test_expect_success '#1: at root' '
 	cat >1/expected <<EOF &&
 setup: git_dir: .git
 setup: worktree: $TRASH_DIRECTORY/1
@@ -142,7 +142,7 @@ EOF
 	test_repo 1
 '
=20
-test_expect_failure '#1: in subdir' '
+test_expect_success '#1: in subdir' '
 	cat >1/sub/expected <<EOF &&
 setup: git_dir: .git
 setup: worktree: $TRASH_DIRECTORY/1
@@ -512,7 +512,7 @@ test_expect_success '#4: setup' '
 	cd ..
 '
=20
-test_expect_failure '#4: at root' '
+test_expect_success '#4: at root' '
 	cat >4/expected <<EOF &&
 setup: git_dir: .git
 setup: worktree: $TRASH_DIRECTORY/4
@@ -522,7 +522,7 @@ EOF
 	test_repo 4
 '
=20
-test_expect_failure '#4: in subdir' '
+test_expect_success '#4: in subdir' '
 	cat >4/sub/expected <<EOF &&
 setup: git_dir: .git
 setup: worktree: $TRASH_DIRECTORY/4
@@ -560,7 +560,7 @@ test_expect_success '#5: setup' '
 	cd ..
 '
=20
-test_expect_failure '#5: at root' '
+test_expect_success '#5: at root' '
 	cat >5/expected <<EOF &&
 setup: git_dir: .git
 setup: worktree: $TRASH_DIRECTORY/5
@@ -570,7 +570,7 @@ EOF
 	test_repo 5
 '
=20
-test_expect_failure '#5: in subdir' '
+test_expect_success '#5: in subdir' '
 	cat >5/sub/expected <<EOF &&
 setup: git_dir: .git
 setup: worktree: $TRASH_DIRECTORY/5
@@ -1213,7 +1213,7 @@ test_expect_success '#9: setup' '
 	cd ..
 '
=20
-test_expect_failure '#9: at root' '
+test_expect_success '#9: at root' '
 	cat >9/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/9.git
 setup: worktree: $TRASH_DIRECTORY/9
@@ -1223,7 +1223,7 @@ EOF
 	test_repo 9
 '
=20
-test_expect_failure '#9: in subdir' '
+test_expect_success '#9: in subdir' '
 	cat >9/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/9.git
 setup: worktree: $TRASH_DIRECTORY/9
@@ -1596,7 +1596,7 @@ test_expect_success '#12: setup' '
 	cd ..
 '
=20
-test_expect_failure '#12: at root' '
+test_expect_success '#12: at root' '
 	cat >12/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/12.git
 setup: worktree: $TRASH_DIRECTORY/12
@@ -1606,7 +1606,7 @@ EOF
 	test_repo 12
 '
=20
-test_expect_failure '#12: in subdir' '
+test_expect_success '#12: in subdir' '
 	cat >12/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/12.git
 setup: worktree: $TRASH_DIRECTORY/12
@@ -1646,7 +1646,7 @@ test_expect_success '#13: setup' '
 	cd ..
 '
=20
-test_expect_failure '#13: at root' '
+test_expect_success '#13: at root' '
 	cat >13/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/13.git
 setup: worktree: $TRASH_DIRECTORY/13
@@ -1656,7 +1656,7 @@ EOF
 	test_repo 13
 '
=20
-test_expect_failure '#13: in subdir' '
+test_expect_success '#13: in subdir' '
 	cat >13/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/13.git
 setup: worktree: $TRASH_DIRECTORY/13
@@ -2388,7 +2388,7 @@ test_expect_success '#17.1: setup' '
 	cd ..
 '
=20
-test_expect_failure '#17.1: at .git' '
+test_expect_success '#17.1: at .git' '
 	cat >17/.git/expected <<EOF &&
 setup: git_dir: .
 setup: worktree: (null)
@@ -2398,7 +2398,7 @@ EOF
 	test_repo 17/.git
 '
=20
-test_expect_failure '#17.1: in .git/wt' '
+test_expect_success '#17.1: in .git/wt' '
 	cat >17/.git/wt/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/17/.git
 setup: worktree: (null)
@@ -2408,7 +2408,7 @@ EOF
 	test_repo 17/.git/wt
 '
=20
-test_expect_failure '#17.1: in .git/wt/sub' '
+test_expect_success '#17.1: in .git/wt/sub' '
 	cat >17/.git/wt/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/17/.git
 setup: worktree: (null)
@@ -2439,7 +2439,7 @@ test_expect_success '#17.2: setup' '
 	git config --file=3D"$TRASH_DIRECTORY/17/.git/config" core.bare true
 '
=20
-test_expect_failure '#17.2: at .git' '
+test_expect_success '#17.2: at .git' '
 	cat >17/.git/expected <<EOF &&
 setup: git_dir: .
 setup: worktree: (null)
@@ -2449,7 +2449,7 @@ EOF
 	test_repo 17/.git
 '
=20
-test_expect_failure '#17.2: in .git/wt' '
+test_expect_success '#17.2: in .git/wt' '
 	cat >17/.git/wt/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/17/.git
 setup: worktree: (null)
@@ -2459,7 +2459,7 @@ EOF
 	test_repo 17/.git/wt
 '
=20
-test_expect_failure '#17.2: in .git/wt/sub' '
+test_expect_success '#17.2: in .git/wt/sub' '
 	cat >17/.git/wt/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/17/.git
 setup: worktree: (null)
@@ -2469,7 +2469,7 @@ EOF
 	test_repo 17/.git/wt/sub
 '
=20
-test_expect_failure '#17.2: at root' '
+test_expect_success '#17.2: at root' '
 	cat >17/expected <<EOF &&
 setup: git_dir: .git
 setup: worktree: (null)
@@ -2853,7 +2853,7 @@ test_expect_success '#20.1: setup' '
 	cd ..
 '
=20
-test_expect_failure '#20.1: at .git' '
+test_expect_success '#20.1: at .git' '
 	cat >20/.git/expected <<EOF &&
 setup: git_dir: .
 setup: worktree: (null)
@@ -2863,7 +2863,7 @@ EOF
 	test_repo 20/.git
 '
=20
-test_expect_failure '#20.1: in .git/wt' '
+test_expect_success '#20.1: in .git/wt' '
 	cat >20/.git/wt/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/20/.git
 setup: worktree: (null)
@@ -2873,7 +2873,7 @@ EOF
 	test_repo 20/.git/wt
 '
=20
-test_expect_failure '#20.1: in .git/wt/sub' '
+test_expect_success '#20.1: in .git/wt/sub' '
 	cat >20/.git/wt/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/20/.git
 setup: worktree: (null)
@@ -2983,7 +2983,7 @@ test_expect_success '#21.1: setup' '
 	cd ..
 '
=20
-test_expect_failure '#21.1: at .git' '
+test_expect_success '#21.1: at .git' '
 	cat >21/.git/expected <<EOF &&
 setup: git_dir: .
 setup: worktree: (null)
@@ -2993,7 +2993,7 @@ EOF
 	test_repo 21/.git
 '
=20
-test_expect_failure '#21.1: in .git/wt' '
+test_expect_success '#21.1: in .git/wt' '
 	cat >21/.git/wt/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/21/.git
 setup: worktree: (null)
@@ -3003,7 +3003,7 @@ EOF
 	test_repo 21/.git/wt
 '
=20
-test_expect_failure '#21.1: in .git/wt/sub' '
+test_expect_success '#21.1: in .git/wt/sub' '
 	cat >21/.git/wt/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/21/.git
 setup: worktree: (null)
@@ -3034,7 +3034,7 @@ test_expect_success '#21.2: setup' '
 	git config --file=3D"$TRASH_DIRECTORY/21/.git/config" core.bare true
 '
=20
-test_expect_failure '#21.2: at .git' '
+test_expect_success '#21.2: at .git' '
 	cat >21/.git/expected <<EOF &&
 setup: git_dir: .
 setup: worktree: (null)
@@ -3044,7 +3044,7 @@ EOF
 	test_repo 21/.git
 '
=20
-test_expect_failure '#21.2: in .git/wt' '
+test_expect_success '#21.2: in .git/wt' '
 	cat >21/.git/wt/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/21/.git
 setup: worktree: (null)
@@ -3054,7 +3054,7 @@ EOF
 	test_repo 21/.git/wt
 '
=20
-test_expect_failure '#21.2: in .git/wt/sub' '
+test_expect_success '#21.2: in .git/wt/sub' '
 	cat >21/.git/wt/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/21/.git
 setup: worktree: (null)
@@ -3064,7 +3064,7 @@ EOF
 	test_repo 21/.git/wt/sub
 '
=20
-test_expect_failure '#21.2: at root' '
+test_expect_success '#21.2: at root' '
 	cat >21/expected <<EOF &&
 setup: git_dir: .git
 setup: worktree: (null)
@@ -3716,7 +3716,7 @@ test_expect_success '#24: setup' '
 	cd ..
 '
=20
-test_expect_success '#24: at root' '
+test_expect_failure '#24: at root' '
 	cat >24/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/24.git
 setup: worktree: (null)
@@ -3726,7 +3726,7 @@ EOF
 	test_repo 24
 '
=20
-test_expect_success '#24: in subdir' '
+test_expect_failure '#24: in subdir' '
 	cat >24/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/24.git
 setup: worktree: (null)
@@ -4151,7 +4151,7 @@ test_expect_success '#28: setup' '
 	cd ..
 '
=20
-test_expect_success '#28: at root' '
+test_expect_failure '#28: at root' '
 	cat >28/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/28.git
 setup: worktree: (null)
@@ -4161,7 +4161,7 @@ EOF
 	test_repo 28
 '
=20
-test_expect_success '#28: in subdir' '
+test_expect_failure '#28: in subdir' '
 	cat >28/sub/expected <<EOF &&
 setup: git_dir: $TRASH_DIRECTORY/28.git
 setup: worktree: (null)
--=20
1.7.3.2.316.gda8b3
