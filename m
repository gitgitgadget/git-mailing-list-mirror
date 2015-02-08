From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] config.c: new config namespace worktree.* stored in $GIT_DIR/config.worktree
Date: Sun,  8 Feb 2015 20:16:32 +0700
Message-ID: <1423401394-13675-2-git-send-email-pclouds@gmail.com>
References: <1423401394-13675-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Max Kirillov <max@max630.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 14:16:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKRj9-0002PZ-HK
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 14:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbbBHNQi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 08:16:38 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:42898 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbbBHNQh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 08:16:37 -0500
Received: by pdjz10 with SMTP id z10so7754335pdj.9
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 05:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=UihqnoWwBVdMTZfShkiFj+lUmz9H8+qiR63S61CrSG0=;
        b=c2j5r8yMDR02iHC1MA7431T949LkbRtl/VDMm6hGvMqJ5RefvaUZWxmyVROIz0Njm1
         t+bfPN83vQhfXAeupTg+tqFPtTq4IJOTm684mrxiV4TpfhaP3fFBx8hafZjFsP6HiuNj
         ygs88oclu1o9h/FmNDhHI9uAUaHpZjasJVvoFAO0gdRj2DWlndHLJaeXAZK2uFckB8Gr
         6aB7jjBfHzaltcZhPmMHzqYBZAD1ffXt1Y/yIeTzHmWAaxL+wbT+Xxqvmj4RqXMUoYCo
         KbmJDD0gWyNiMn8xoVmdwd0K4jKgDijDtK8+mWuX9YYpakEMD0934W3NTt360SJU/Z08
         VhRQ==
X-Received: by 10.68.164.194 with SMTP id ys2mr20453581pbb.20.1423401397101;
        Sun, 08 Feb 2015 05:16:37 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id df7sm3160527pdb.14.2015.02.08.05.16.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 05:16:36 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 20:16:42 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423401394-13675-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263512>

On the surface, worktree.* variables are just like any other
variables. You can read or modify them with `git config` command, or
config_* API. Underneath, worktree.* are always stored in
$GIT_DIR/config.worktree instead of $GIT_DIR/config (and never in
$HOME/.gitconfig or /etc/gitconfig)

The reason for this split is, as the name implies, for
worktree-specific configuration. When the same repo is attached to
more than one worktree, we can't use $GIT_DIR/config to store worktree
specific stuff because it's shared across worktrees.

With this, both git-new-workdir and nd/multiple-work-trees will work.
git-new-workdir creates a symlink to $GIT_DIR/config in the new
worktree, but not $GIT_DIR/config.worktree. That file will be created
new when worktree.* are written in the new worktree.
`git checkout --to` can remap the path $GIT_DIR/config.worktree to make
it worktree-specific.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |  4 +++-
 builtin/config.c         |  8 ++++++++
 config.c                 | 38 ++++++++++++++++++++++++++++++++++++++
 t/t1300-repo-config.sh   | 31 +++++++++++++++++++++++++++++++
 4 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 04e2a71..26e4e07 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2,11 +2,13 @@ CONFIGURATION FILE
 ------------------
=20
 The Git configuration file contains a number of variables that affect
-the Git commands' behavior. The `.git/config` file in each repository
+the Git commands' behavior. The `.git/config` and `.git/config.worktre=
e`
+files in each repository
 is used to store the configuration for that repository, and
 `$HOME/.gitconfig` is used to store a per-user configuration as
 fallback values for the `.git/config` file. The file `/etc/gitconfig`
 can be used to store a system-wide default configuration.
+worktree.* variables can only be contained in `.git/config.worktree`
=20
 The configuration variables are used by both the Git plumbing
 and the porcelains. The variables are divided into sections, wherein
diff --git a/builtin/config.c b/builtin/config.c
index 15a7bea..d9333cd 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -552,6 +552,14 @@ int cmd_config(int argc, const char **argv, const =
char *prefix)
 			usage_with_options(builtin_config_usage, builtin_config_options);
 		}
=20
+	/*
+	 * For set operations, --local could be either config or
+	 * config.worktree. Let config.c determine the path based on
+	 * config keys.
+	 */
+	if (use_local_config && actions !=3D ACTION_LIST)
+		given_config_source.file =3D NULL;
+
 	if (actions =3D=3D ACTION_LIST) {
 		check_argc(argc, 0, 0);
 		if (git_config_with_options(show_all_config, NULL,
diff --git a/config.c b/config.c
index 752e2e2..3d46192 100644
--- a/config.c
+++ b/config.c
@@ -12,6 +12,7 @@
 #include "quote.h"
 #include "hashmap.h"
 #include "string-list.h"
+#include "dir.h"
=20
 struct config_source {
 	struct config_source *prev;
@@ -1177,6 +1178,15 @@ int git_config_system(void)
 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
 }
=20
+static int config_worktree_filter(const char *var, const char *value, =
void *data)
+{
+	struct config_include_data *inc =3D data;
+
+	if (!starts_with(var, "worktree."))
+		return error("$GIT_DIR/config.worktree can only contain worktree.*")=
;
+	return inc->fn(var, value, inc->data);
+}
+
 int git_config_early(config_fn_t fn, void *data, const char *repo_conf=
ig)
 {
 	int ret =3D 0, found =3D 0;
@@ -1202,8 +1212,19 @@ int git_config_early(config_fn_t fn, void *data,=
 const char *repo_config)
 	}
=20
 	if (repo_config && !access_or_die(repo_config, R_OK, 0)) {
+		char *wt_config;
 		ret +=3D git_config_from_file(fn, repo_config, data);
 		found +=3D 1;
+		wt_config =3D git_pathdup("config.worktree");
+		if (!access_or_die(wt_config, R_OK, 0)) {
+			struct config_include_data inc =3D CONFIG_INCLUDE_INIT;
+			inc.fn =3D fn;
+			inc.data =3D data;
+			ret +=3D git_config_from_file(config_worktree_filter,
+						    wt_config, &inc);
+			found +=3D 1;
+		}
+		free(wt_config);
 	}
=20
 	switch (git_config_from_parameters(fn, data)) {
@@ -1942,6 +1963,23 @@ int git_config_set_multivar_in_file(const char *=
config_filename,
=20
 	store.multi_replace =3D multi_replace;
=20
+	if (starts_with(key, "worktree.")) {
+		if (!config_filename)
+			config_filename =3D filename_buf =3D git_pathdup("config.worktree")=
;
+		/* cheap trick, but should work 90% of time */
+		else if (!ends_with(config_filename, ".worktree"))
+			die("worktree.* can only be stored in %s",
+			    git_path("config.worktree"));
+		else {
+			struct strbuf sb =3D STRBUF_INIT;
+			strbuf_addstr(&sb, real_path(config_filename));
+			if (strcmp_icase(sb.buf,
+					 real_path(git_path("config.worktree"))))
+				die("worktree.* can only be stored in %s",
+				    git_path("config.worktree"));
+			strbuf_release(&sb);
+		}
+	}
 	if (!config_filename)
 		config_filename =3D filename_buf =3D git_pathdup("config");
=20
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 938fc8b..58a5009 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1179,4 +1179,35 @@ test_expect_success POSIXPERM,PERL 'preserves ex=
isting permissions' '
 	  "die q(badrename) if ((stat(q(.git/config)))[2] & 07777) !=3D 0600"
 '
=20
+test_expect_success 'setting worktree.foo goes to config.worktree' '
+	test_when_finished "rm .git/config.worktree" &&
+	git config worktree.foo bar &&
+	cat >expect <<\EOF &&
+[worktree]
+	foo =3D bar
+EOF
+	test_cmp expect .git/config.worktree &&
+	test "`git config worktree.foo`" =3D bar
+'
+
+test_expect_success 'setting --local worktree.foo goes to config.workt=
ree' '
+	test_when_finished "rm .git/config.worktree" &&
+	git config --local worktree.fooo barr &&
+	cat >expect <<\EOF &&
+[worktree]
+	fooo =3D barr
+EOF
+	test_cmp expect .git/config.worktree &&
+	test "`git config worktree.fooo`" =3D barr
+'
+
+test_expect_success 'setting worktree.foo outside config.worktree' '
+	test_must_fail git config --global worktree.foo bar 2>err &&
+	grep config.worktree err &&
+	test_must_fail git config --system worktree.foo bar 2>err &&
+	grep config.worktree err &&
+	test_must_fail git config --file foo.worktree worktree.foo bar 2>err =
&&
+	grep config.worktree err
+'
+
 test_done
--=20
2.3.0.rc1.137.g477eb31
