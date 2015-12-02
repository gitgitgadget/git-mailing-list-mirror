From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/5] config.c: move worktree-specific variables to .git/worktrees/...
Date: Wed,  2 Dec 2015 20:13:43 +0100
Message-ID: <1449083626-20075-3-git-send-email-pclouds@gmail.com>
References: <1449083626-20075-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Max Kirillov <max@max630.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 20:14:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4Cr5-0003VY-PJ
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 20:14:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756808AbbLBTOM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Dec 2015 14:14:12 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37803 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932938AbbLBTOH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 14:14:07 -0500
Received: by wmww144 with SMTP id w144so70489593wmw.0
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 11:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=UL6U6D6axfHSkj+RKwAWsEBFkJvfNYo5yRy7BJndr1w=;
        b=Y+QuTwQqtHI4SWEHaLtPt4bCYxy4sOc6AwIjR9E8byK/lfD+L2xIoWlHVY9LyHa6z6
         Alx6yr5dRIoN5NaHhOaVtKu/988G60ghk03TAfEOaQHGsGuW7Xyj753vxBf5XwxcXwND
         HjC2LK8Jxij7Qka9l7MSbm7EcGXspkzq70HfSLB/xv9jDwbESg/5ypR14WZsC/zU2dZF
         +Yegmqrj+25Znkml6LthTQINUVhg8TBpIp9kLg8GgpF6/s6jTVITwGnMKtZz72l3+WWZ
         IyxVy4g77JLAf6MHe7R7tjUTM7csuNwUEoy7vyylmL50S+GHof9tNHYgdX/hELc1XUpV
         jWWQ==
X-Received: by 10.28.173.21 with SMTP id w21mr8212002wme.102.1449083646151;
        Wed, 02 Dec 2015 11:14:06 -0800 (PST)
Received: from duynguyen-vnpc.dek-tpc.internal.homenet.telecomitalia.it (host171-164-static.60-79-b.business.telecomitalia.it. [79.60.164.171])
        by smtp.gmail.com with ESMTPSA id uz5sm4090822wjc.8.2015.12.02.11.14.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Dec 2015 11:14:04 -0800 (PST)
X-Mailer: git-send-email 2.2.0.513.g477eb31
In-Reply-To: <1449083626-20075-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281904>

=2Egit/info/config.worktree is a pattern list that splits .git/config i=
n
to sets: the worktree set matches the patterns, the commmon set does
not.

In normal worktrees, both sets are stored in .git/config. The
config.worktree has no effect. Nothing is changed.

In linked worktrees, the common and worktree sets are read from and
saved to .git/config and .git/config.worktree respectively. Config
keys in .git/config that belong to the worktree set is ignored. Those
are for the main worktree only. Similarly, keys not matching the
patterns come from .git/config, duplicate keys from
=2Egit/config.worktree are ignored.

The effect is similar to the $GIT_DIR/$GIT_COMMON_DIR split, we can
define that some vars can be shared and some cannot. And as a result
of the $GIT_DIR/$GIT_COMMON_DIR split, config.worktree is actually
found at .git/worktrees/<id>/config.worktree.

Throwing the exclude mechanism into this means reading config files
will be slower. But unless somebody reads thousands of keys, it should
not be noticable. The nice thing is we don't have to introduce yet
another pattern syntax.

In future, we might want to have a shared config file to contain
common worktree-specific settings, so that we have some good defaults,
but still allow customization. Or we could twist the above logic a
bit: for linked worktrees, read _all_ variables in config.worktree
regardless of the patterns. But let's wait and see..

Helped-by: Max Kirillov <max@max630.net>
Helped-by: Jens Lehmann <Jens.Lehmann@web.de>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt               |   4 +
 Documentation/gitrepository-layout.txt |  12 +++
 builtin/config.c                       |   9 +++
 cache.h                                |   2 +-
 config.c                               | 143 +++++++++++++++++++++++++=
++++++--
 dir.c                                  |   2 +-
 dir.h                                  |   1 +
 setup.c                                |   2 +-
 t/t2025-worktree-add.sh                |  26 ++++++
 9 files changed, 191 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 391a0c3..5c6cd4b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -8,6 +8,10 @@ is used to store the configuration for that repository=
, and
 fallback values for the `.git/config` file. The file `/etc/gitconfig`
 can be used to store a system-wide default configuration.
=20
+Linked worktrees (see linkgit:git-worktree[1]) also have a
+worktree-specific file "config.worktree". See
+linkgit:gitrepository-layout[5] for more information.
+
 The configuration variables are used by both the Git plumbing
 and the porcelains. The variables are divided into sections, wherein
 the fully qualified variable name of the variable itself is the last
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/git=
repository-layout.txt
index 577ee84..62f7e33 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -212,6 +212,12 @@ info/sparse-checkout::
 	This file stores sparse checkout patterns.
 	See also: linkgit:git-read-tree[1].
=20
+info/config.worktree:
+	This file stores the configuration variable pattern list where
+	$GIT_DIR/config.worktree is used as storage instead of
+	$GIT_DIR/config. The syntax is the same as .gitignore except
+	that '.' is considered the separator instead of '/'.
+
 remotes::
 	Stores shorthands for URL and default refnames for use
 	when interacting with remote repositories via 'git fetch',
@@ -276,6 +282,12 @@ worktrees/<id>/link::
 	file. It is used to detect if the linked repository is
 	manually removed.
=20
+worktrees/<id>/config.worktree::
+	This file contains worktree-specific configuration
+	variables. The list of variables is controlled by
+	$GIT_COMMON_DIR/info/config.worktree. The same variables in
+	$GIT_COMMON_DIR/config are ignored.
+
 SEE ALSO
 --------
 linkgit:git-init[1],
diff --git a/builtin/config.c b/builtin/config.c
index adc7727..2b4d56e 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -533,6 +533,15 @@ int cmd_config(int argc, const char **argv, const =
char *prefix)
 		default:
 			usage_with_options(builtin_config_usage, builtin_config_options);
 		}
+
+	/*
+	 * For set operations, --local could be either config or
+	 * config.worktree. Let config.c determine the path based on
+	 * config keys.
+	 */
+	if (use_local_config && actions !=3D ACTION_LIST)
+		given_config_source.file =3D NULL;
+
 	if (omit_values &&
 	    !(actions =3D=3D ACTION_LIST || actions =3D=3D ACTION_GET_REGEXP)=
) {
 		error("--name-only is only applicable to --list or --get-regexp");
diff --git a/cache.h b/cache.h
index 3ba0b8f..27bc3bc 100644
--- a/cache.h
+++ b/cache.h
@@ -1468,7 +1468,7 @@ extern void git_config(config_fn_t fn, void *);
 extern int git_config_with_options(config_fn_t fn, void *,
 				   struct git_config_source *config_source,
 				   int respect_includes);
-extern int git_config_early(config_fn_t fn, void *, const char *repo_c=
onfig);
+extern int git_config_early(config_fn_t fn, void *, const char *repo_c=
onfig, const char *worktree_config);
 extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_parse_maybe_bool(const char *);
 extern int git_config_int(const char *, const char *);
diff --git a/config.c b/config.c
index 248a21a..75c45e1 100644
--- a/config.c
+++ b/config.c
@@ -13,6 +13,7 @@
 #include "hashmap.h"
 #include "string-list.h"
 #include "utf8.h"
+#include "dir.h"
=20
 struct config_source {
 	struct config_source *prev;
@@ -38,6 +39,7 @@ struct config_source {
 };
=20
 static struct config_source *cf;
+static struct exclude_list config_local;
=20
 static int zlib_compression_seen;
=20
@@ -89,6 +91,73 @@ static long config_buf_ftell(struct config_source *c=
onf)
 	return conf->u.buf.pos;
 }
=20
+static void load_info_config_worktree(void)
+{
+	struct exclude_list *el =3D &config_local;
+	struct strbuf sb =3D STRBUF_INIT;
+	int i, lineno =3D 1;
+	char *buf, *entry;
+	size_t size;
+
+	clear_exclude_list(el);
+
+	if (strbuf_read_file(&sb,
+			     git_path("info/config.worktree"),
+			     128) <=3D 0) {
+		strbuf_release(&sb);
+		return;
+	}
+	strbuf_addch(&sb, '\n');
+	el->filebuf =3D buf =3D strbuf_detach(&sb, &size);
+
+	for (i =3D 0; i < size; i++)
+		if (buf[i] =3D=3D '.')
+			buf[i] =3D '/';
+		else
+			buf[i] =3D tolower(buf[i]);
+
+	entry =3D buf;
+	for (i =3D 0; i < size; i++) {
+		if (buf[i] =3D=3D '\n') {
+			if (entry !=3D buf + i && entry[0] !=3D '#') {
+				buf[i - (i && buf[i-1] =3D=3D '\r')] =3D 0;
+				trim_trailing_spaces(entry);
+				add_exclude(entry, "", 0, el, lineno);
+			}
+			lineno++;
+			entry =3D buf + i + 1;
+		}
+	}
+
+	/*
+	 * avoid base name matching because it may confusion in
+	 * non-directory context.
+	 */
+	for (i =3D 0; i < el->nr; i++)
+		el->excludes[i]->flags &=3D ~EXC_FLAG_NODIR;
+}
+
+static int is_config_local(const char *key_)
+{
+	static struct strbuf key =3D STRBUF_INIT;
+	int i, dtype;
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
@@ -1184,7 +1253,29 @@ int git_config_system(void)
 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
 }
=20
-int git_config_early(config_fn_t fn, void *data, const char *repo_conf=
ig)
+static int config_worktree_filter_in(const char *var,
+				     const char *value, void *data)
+{
+	struct config_include_data *inc =3D data;
+
+	if (!is_config_local(var))
+		return error("%s in config.worktree is ignored", var);
+	return inc->fn(var, value, inc->data);
+}
+
+static int config_worktree_filter_out(const char *var,
+				      const char *value, void *data)
+{
+	struct config_include_data *inc =3D data;
+
+	if (is_config_local(var))
+		return 0;	/* these are for main worktree only */
+
+	return inc->fn(var, value, inc->data);
+}
+
+int git_config_early(config_fn_t fn, void *data, const char *repo_conf=
ig,
+		     const char *worktree_config)
 {
 	int ret =3D 0, found =3D 0;
 	char *xdg_config =3D xdg_config_home("config");
@@ -1206,7 +1297,25 @@ int git_config_early(config_fn_t fn, void *data,=
 const char *repo_config)
 		found +=3D 1;
 	}
=20
-	if (repo_config && !access_or_die(repo_config, R_OK, 0)) {
+	if (worktree_config) {
+		struct config_include_data inc =3D CONFIG_INCLUDE_INIT;
+
+		load_info_config_worktree();
+
+		inc.fn =3D fn;
+		inc.data =3D data;
+		if (!access_or_die(worktree_config, R_OK, 0)) {
+			ret +=3D git_config_from_file(config_worktree_filter_in,
+						    worktree_config, &inc);
+			found +=3D 1;
+		}
+
+		if (repo_config && !access_or_die(repo_config, R_OK, 0)) {
+			ret +=3D git_config_from_file(config_worktree_filter_out,
+						    repo_config, &inc);
+			found +=3D 1;
+		}
+	} else if (repo_config && !access_or_die(repo_config, R_OK, 0)) {
 		ret +=3D git_config_from_file(fn, repo_config, data);
 		found +=3D 1;
 	}
@@ -1232,6 +1341,7 @@ int git_config_with_options(config_fn_t fn, void =
*data,
 			    int respect_includes)
 {
 	char *repo_config =3D NULL;
+	char *worktree_config =3D NULL;
 	int ret;
 	struct config_include_data inc =3D CONFIG_INCLUDE_INIT;
=20
@@ -1254,9 +1364,11 @@ int git_config_with_options(config_fn_t fn, void=
 *data,
 		return git_config_from_blob_ref(fn, config_source->blob, data);
=20
 	repo_config =3D git_pathdup("config");
-	ret =3D git_config_early(fn, data, repo_config);
-	if (repo_config)
-		free(repo_config);
+	if (git_common_dir_env)
+		worktree_config =3D git_pathdup("config.worktree");
+	ret =3D git_config_early(fn, data, repo_config, worktree_config);
+	free(repo_config);
+	free(worktree_config);
 	return ret;
 }
=20
@@ -1925,6 +2037,24 @@ int git_config_key_is_valid(const char *key)
 	return !git_config_parse_key_1(key, NULL, NULL, 1);
 }
=20
+static const char *get_config_filename(const char *config_filename,
+				       const char *key,
+				       char **filename_buf)
+{
+	if (config_filename)
+		return config_filename;
+	if (!git_common_dir_env) {
+		config_filename =3D *filename_buf =3D git_pathdup("config");
+		return config_filename;
+	}
+	load_info_config_worktree();
+	if (!is_config_local(key))
+		config_filename =3D *filename_buf =3D git_pathdup("config");
+	else
+		config_filename =3D *filename_buf =3D git_pathdup("config.worktree")=
;
+	return config_filename;
+}
+
 /*
  * If value=3D=3DNULL, unset in (remove from) config,
  * if value_regex!=3DNULL, disregard key/value pairs where value does =
not match.
@@ -1968,8 +2098,7 @@ int git_config_set_multivar_in_file(const char *c=
onfig_filename,
=20
 	store.multi_replace =3D multi_replace;
=20
-	if (!config_filename)
-		config_filename =3D filename_buf =3D git_pathdup("config");
+	config_filename =3D get_config_filename(config_filename, key, &filena=
me_buf);
=20
 	/*
 	 * The lock serves a purpose in addition to locking: the new
diff --git a/dir.c b/dir.c
index b8b4576..9522b89 100644
--- a/dir.c
+++ b/dir.c
@@ -567,7 +567,7 @@ void clear_exclude_list(struct exclude_list *el)
 	memset(el, 0, sizeof(*el));
 }
=20
-static void trim_trailing_spaces(char *buf)
+void trim_trailing_spaces(char *buf)
 {
 	char *p, *last_space =3D NULL;
=20
diff --git a/dir.h b/dir.h
index 7b5855d..52ded83 100644
--- a/dir.h
+++ b/dir.h
@@ -248,6 +248,7 @@ extern void clear_exclude_list(struct exclude_list =
*el);
 extern void clear_directory(struct dir_struct *dir);
 extern int file_exists(const char *);
=20
+extern void trim_trailing_spaces(char *buf);
 extern int is_inside_dir(const char *dir);
 extern int dir_inside_of(const char *subdir, const char *dir);
=20
diff --git a/setup.c b/setup.c
index d343725..0047d40 100644
--- a/setup.c
+++ b/setup.c
@@ -404,7 +404,7 @@ static int check_repository_format_gently(const cha=
r *gitdir, int *nongit_ok)
 	 * Use a gentler version of git_config() to check if this repo
 	 * is a good one.
 	 */
-	git_config_early(fn, NULL, repo_config);
+	git_config_early(fn, NULL, repo_config, NULL);
 	if (GIT_REPO_VERSION_READ < repository_format_version) {
 		if (!nongit_ok)
 			die ("Expected git repo version <=3D %d, found %d",
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 3694174..e8d8da4 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -198,4 +198,30 @@ test_expect_success 'local clone from linked check=
out' '
 	( cd here-clone && git fsck )
 '
=20
+test_expect_success 'setting worktree.foo goes to config.worktree' '
+	echo worKtree.Foo >> .git/info/config.worktree &&
+	git worktree add wt.foo HEAD &&
+	git config woRKtree.FOO barrrr &&
+	git --git-dir=3Dwt.foo/.git config woRKtree.FOO bar &&
+	cat >expect <<\EOF &&
+[woRKtree]
+	FOO =3D bar
+EOF
+	test_cmp expect .git/worktrees/wt.foo/config.worktree &&
+	git --git-dir=3Dwt.foo/.git config woRktree.foo >actual2 &&
+	echo bar >expect2 &&
+	test_cmp expect2 actual2 &&
+	test_path_is_missing .git/config.worktree &&
+	git config WORKTREE.FOO >actual3 &&
+	echo barrrr >expect3 &&
+	test_cmp expect3 actual3
+'
+
+test_expect_success 'shared config still goes to config' '
+	git config random.key randomValue &&
+	git --git-dir=3Dwt.foo/.git config random.key >actual &&
+	echo randomValue >expect &&
+	test_cmp expect actual
+'
+
 test_done
--=20
2.2.0.513.g477eb31
