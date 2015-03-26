From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] config.c: split some variables to $GIT_DIR/config.worktree
Date: Thu, 26 Mar 2015 19:04:24 +0700
Message-ID: <1427371464-22237-1-git-send-email-pclouds@gmail.com>
References: <CACsJy8CYgMDY_zGi6o=UtD7QV+DQUcaDgwxo6tGrfktRXj+QSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Jens.Lehmann@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 13:04:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yb6Wr-0002Ou-0M
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 13:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785AbbCZMEt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Mar 2015 08:04:49 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34911 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138AbbCZMEp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 08:04:45 -0400
Received: by pdbop1 with SMTP id op1so60788176pdb.2
        for <git@vger.kernel.org>; Thu, 26 Mar 2015 05:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=aJZpOGtGQk8Bxk3fzXaT7lxXYFGm9xK0thVhgPQHp8Q=;
        b=ACqwv8YzOJ8bvAZHkMrTd4P4f8xO3R2aqAZNjut0OQYn488jRX1ZVsSkCkTUeWFscQ
         hVDsrGQxk+zhbaCR2JrfPojnGVy0FMA77qflPbAL3prc1DI6ngDCTYYq8c18PVrvrxek
         Ps4SDuPh0wmQ6FI/7yaj/lKi81DuGHqHCZboe3o4x6Vw3gtIVjYpO0Kn8hYi9SpSb4Q8
         CXucQPPVXUwam9+viwsimXSwfvJUhddF0kYYT1MmRW9FwlQ7c0ivTdi+3vH4qEnqRnZZ
         iOAihrFoGzK9HsYtV+qmMYaoZi+5Znliq0x9xHf0AWgGSHHNRFG38sKnFqt/vmzdEI38
         XhXg==
X-Received: by 10.66.122.204 with SMTP id lu12mr26197792pab.52.1427371483684;
        Thu, 26 Mar 2015 05:04:43 -0700 (PDT)
Received: from lanh ([115.73.229.111])
        by mx.google.com with ESMTPSA id dj3sm5393327pbd.48.2015.03.26.05.04.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2015 05:04:42 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 26 Mar 2015 19:04:42 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <CACsJy8CYgMDY_zGi6o=UtD7QV+DQUcaDgwxo6tGrfktRXj+QSw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266323>

When you define $GIT_DIR/info/config.worktree, which contains of
gitignore-style patterns (*), config variables that match these
patterns will be saved in $GIT_DIR/config.worktree instead of
$GIT_DIR/config.

On the surface, they are just like any other variables. You can read
or modify them with `git config` command, or config_* API. Underneath,
they are always stored in $GIT_DIR/config.worktree instead of
$GIT_DIR/config (and never in $HOME/.gitconfig or /etc/gitconfig)

The reason for this split is, as the name implies, for
worktree-specific configuration. When the same repo is attached to
more than one worktree, we can't use $GIT_DIR/config to store worktree
specific stuff because it's shared across worktrees.

(*) Config variable names are separated by dots. However as this is a
quick and dirty patch to experiment with submodules and multiple
worktrees, you must substitute dots with slashes when writing these
patterns, for now. E.g. write "remote/*/foo" instead of "remote.*.foo"

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Something for Max to play with if he's still experimenting with
 multiple worktree support for submodules :-) It's far from perfect,
 but good enough for this purpose.

 Documentation/config.txt |  6 ++++-
 builtin/config.c         |  8 ++++++
 config.c                 | 67 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 t/t1300-repo-config.sh   | 34 ++++++++++++++++++++++++
 4 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2700a1b..6d00f49 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2,11 +2,15 @@ CONFIGURATION FILE
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
+If `.git/info/core.worktree` exists, it contains gitignore-style
+patterns. Variables that match these patterns can only be contained in
+`.git/config.worktree`.
=20
 The configuration variables are used by both the Git plumbing
 and the porcelains. The variables are divided into sections, wherein
diff --git a/builtin/config.c b/builtin/config.c
index 8cc2604..4ca8fc2 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -555,6 +555,14 @@ int cmd_config(int argc, const char **argv, const =
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
index 15a2983..f68eb6a 100644
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
@@ -37,6 +38,7 @@ struct config_source {
 };
=20
 static struct config_source *cf;
+static struct exclude_list config_local;
=20
 static int zlib_compression_seen;
=20
@@ -84,6 +86,34 @@ static long config_buf_ftell(struct config_source *c=
onf)
 	return conf->u.buf.pos;
 }
=20
+static int is_config_local(const char *key_)
+{
+	static struct strbuf key =3D STRBUF_INIT;
+	static int loaded;
+	int i, dtype;
+
+	if (!loaded) {
+		add_excludes_from_file_to_list(git_path("info/config.worktree"),
+					       "", 0, &config_local, 0);
+		loaded =3D 1;
+	}
+
+	if (!config_local.nr)
+		return 0;
+
+	strbuf_reset(&key);
+	strbuf_addstr(&key, key_);
+	for (i =3D 0; i < key.len; i++) {
+		if (key.buf[i] =3D=3D '.')
+			key.buf[i] =3D '/';
+		else
+			key.buf[i] =3D tolower(key.buf[i]);
+	}
+	dtype =3D DT_REG;
+	return is_excluded_from_list(key.buf, key.len, "", &dtype,
+				     &config_local) > 0;
+}
+
 #define MAX_INCLUDE_DEPTH 10
 static const char include_depth_advice[] =3D
 "exceeded maximum include depth (%d) while including\n"
@@ -1167,6 +1197,15 @@ int git_config_system(void)
 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
 }
=20
+static int config_local_filter(const char *var, const char *value, voi=
d *data)
+{
+	struct config_include_data *inc =3D data;
+
+	if (!is_config_local(var))
+		return error("%s does not belong to config.worktree", var);
+	return inc->fn(var, value, inc->data);
+}
+
 int git_config_early(config_fn_t fn, void *data, const char *repo_conf=
ig)
 {
 	int ret =3D 0, found =3D 0;
@@ -1192,8 +1231,19 @@ int git_config_early(config_fn_t fn, void *data,=
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
+			ret +=3D git_config_from_file(config_local_filter,
+						    wt_config, &inc);
+			found +=3D 1;
+		}
+		free(wt_config);
 	}
=20
 	switch (git_config_from_parameters(fn, data)) {
@@ -1932,6 +1982,23 @@ int git_config_set_multivar_in_file(const char *=
config_filename,
=20
 	store.multi_replace =3D multi_replace;
=20
+	if (is_config_local(key)) {
+		if (!config_filename)
+			config_filename =3D filename_buf =3D git_pathdup("config.worktree")=
;
+		/* cheap trick, but should work 90% of time */
+		else if (!ends_with(config_filename, ".worktree"))
+			die("%s can only be stored in %s",
+			    key, git_path("config.worktree"));
+		else {
+			struct strbuf sb =3D STRBUF_INIT;
+			strbuf_addstr(&sb, real_path(config_filename));
+			if (strcmp_icase(sb.buf,
+					 real_path(git_path("config.worktree"))))
+				die("%s can only be stored in %s",
+				    key, git_path("config.worktree"));
+			strbuf_release(&sb);
+		}
+	}
 	if (!config_filename)
 		config_filename =3D filename_buf =3D git_pathdup("config");
=20
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 938fc8b..c01effb 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1179,4 +1179,38 @@ test_expect_success POSIXPERM,PERL 'preserves ex=
isting permissions' '
 	  "die q(badrename) if ((stat(q(.git/config)))[2] & 07777) !=3D 0600"
 '
=20
+test_expect_success 'setting worktree.foo goes to config.worktree' '
+	test_when_finished "rm .git/config.worktree" &&
+	echo "worktree/*" >.git/info/config.worktree &&
+	git config wOrktree.foo bar &&
+	cat >expect <<\EOF &&
+[wOrktree]
+	foo =3D bar
+EOF
+	test_cmp expect .git/config.worktree &&
+	test "`git config woRktree.foo`" =3D bar
+'
+
+test_expect_success 'setting --local worktree.foo goes to config.workt=
ree' '
+	test_when_finished "rm .git/config.worktree" &&
+	echo "worktree/*" >.git/info/config.worktree &&
+	git config --local worKtree.fooo barr &&
+	cat >expect <<\EOF &&
+[worKtree]
+	fooo =3D barr
+EOF
+	test_cmp expect .git/config.worktree &&
+	test "`git config worktreE.fooo`" =3D barr
+'
+
+test_expect_success 'setting worktree.foo outside config.worktree' '
+	echo "worktree/*" >.git/info/config.worktree &&
+	test_must_fail git config --global Worktree.foo bar 2>err &&
+	grep config.worktree err &&
+	test_must_fail git config --system workTree.foo bar 2>err &&
+	grep config.worktree err &&
+	test_must_fail git config --file foo.worktree worktree.foo bar 2>err =
&&
+	grep config.worktree err
+'
+
 test_done
--=20
2.3.0.rc1.137.g477eb31
