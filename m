From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3] config.c: split some variables to $GIT_DIR/config.worktree
Date: Tue, 31 Mar 2015 19:14:39 +0700
Message-ID: <1427804079-13061-1-git-send-email-pclouds@gmail.com>
References: <1427371464-22237-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Jens.Lehmann@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 14:14:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ycv4D-0004hp-J1
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 14:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbbCaMOm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2015 08:14:42 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36182 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817AbbCaMOl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 08:14:41 -0400
Received: by pdmh5 with SMTP id h5so6696287pdm.3
        for <git@vger.kernel.org>; Tue, 31 Mar 2015 05:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jL1AmKMcVlh4RxSXKpsj/E8MagV96CQX86jptdpGAsY=;
        b=qfbA+eANLVpLqc04xRd9dKR68YlOcEjmRYCUdn3feGywDSHGgsAehwpZbqWdj9BGxG
         RbP1RnV82e8DvVWj1kNs8T2sgtyiPjKelY8bL0+WcytXiIYloJqhz2X2iitJqweAR5pQ
         ggMBrXGZL53XPxUIohnhImYIKKzdE5IgBltZdRfOUqdYF4UPdXBl7RffDxjc6QrYGN68
         GbFmebn8bJimBnl+jU/pwtbki24oBzWv/rE7lOP72LFawqRB2YALPxHcHnTOtBOyDA2+
         x3RpW4a+FIQ/MbjXN6oE1IsGQgcQQCCROeEznaPYXv+33KSFQvZEVIwuMhaQbYOxuPWS
         3rvQ==
X-Received: by 10.70.90.16 with SMTP id bs16mr51620842pdb.76.1427804080533;
        Tue, 31 Mar 2015 05:14:40 -0700 (PDT)
Received: from lanh ([115.73.249.124])
        by mx.google.com with ESMTPSA id zi10sm13176796pab.35.2015.03.31.05.14.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2015 05:14:39 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 31 Mar 2015 19:14:45 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1427371464-22237-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266520>

=2Egit/info/config.worktree is a pattern list that splits .git/config i=
n
to sets, the common set that does not match the patterns and the
worktree set.

In normal worktree, or in the main worktree when "git checkout --to"
is used, both sets are stored in .git/config. Nothing interesting.

In linked worktrees, the common and worktree sets are read from and
saved to .git/config and .git/config.worktree respectively. Config
keys in .git/config that belong to the worktree set is ignored. Those
are for the main worktree only.

The effect is similar to the $GIT_DIR/$GIT_COMMON_DIR split, we can
define that some vars can be shared and some cannot.

core.worktree and core.bare, which are treated specially in 31e26eb [1]=
,
are now moved to info/core.worktree and the special treatment reverted.

[1] 31e26eb (setup.c: support multi-checkout repo setup - 2014-11-30)

Helped-by: Max Kirillov <max@max630.net>
Helped-by: Jens Lehmann <Jens.Lehmann@web.de>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Much happier with this version, especially when we can now generalize
 the treatment for core.worktree and core.bare.
=20
 The general principle is like in the last mail: .git/config is for
 both shared and private keys of main worktree (i.e. nothing is
 changed from today).  .git/worktrees/xx/config.worktree is for
 private keys only (and private keys in .git/config are ignored)
=20
 With this we don't have to bump core.repository_format_version for
 main worktree because nothing is changed. There will be problems
 with info/config.worktree:

  - it's customizable, so expect the user to break it (*)

  - if we add new stuff to the template, we'll need to help migrate
    current info/core.worktree (which does not have new stuff).
    Auto updating this file could be risky. I'm tend to just
    warn the user that this and that keys should be included and let
    them modify the file.

 (*) but I don't want to keep the hard coded version of this in git
 binary either, simply to avoid this customization problem. The list
 compiled by Max shows that many keys may or may not be shared. So let
 the user decide what's best for them.

 Documentation/config.txt               | 10 ++++
 Documentation/gitrepository-layout.txt |  6 +++
 builtin/config.c                       |  8 +++
 cache.h                                |  2 +-
 config.c                               | 97 ++++++++++++++++++++++++++=
++++++--
 dir.c                                  | 41 ++++++++++++++
 dir.h                                  |  1 +
 setup.c                                |  8 +--
 t/t2025-checkout-to.sh                 | 26 +++++++++
 templates/info--config.worktree (new)  |  2 +
 10 files changed, 189 insertions(+), 12 deletions(-)
 create mode 100644 templates/info--config.worktree

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2700a1b..ca4de1f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -8,6 +8,16 @@ is used to store the configuration for that repository=
, and
 fallback values for the `.git/config` file. The file `/etc/gitconfig`
 can be used to store a system-wide default configuration.
=20
+Linked worktrees (see "multple working trees" in
+linkgit:git-checkout[1]) have two config files under its ".git"
+directory: "config" is shared with other worktrees while
+"config.worktree" is per worktree. Configuration variables that match
+patterns in $GIT_DIR/info/config.worktree are stored and read from
+"config.worktree". Matched configuration variables in "config" is
+ignored by linked worktrees. They are only used by the main
+worktree. The patterns follow gitignore syntax, where the separator is
+'.' instead of '/'.
+
 The configuration variables are used by both the Git plumbing
 and the porcelains. The variables are divided into sections, wherein
 the fully qualified variable name of the variable itself is the last
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/git=
repository-layout.txt
index 7173b38..6228280 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -212,6 +212,12 @@ info/sparse-checkout::
 	This file stores sparse checkout patterns.
 	See also: linkgit:git-read-tree[1].
=20
+info/checkout.worktree:
+	This file stores the configuration variable pattern list where
+	$GIT_DIR/config.worktree is used as storage instead of
+	$GIT_DIR/config. The syntax is the same as .gitignore except
+	that '.' is considered the separator instead of '/'.
+
 remotes::
 	Stores shorthands for URL and default refnames for use
 	when interacting with remote repositories via 'git fetch',
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
diff --git a/cache.h b/cache.h
index 670e861..9431117 100644
--- a/cache.h
+++ b/cache.h
@@ -1355,7 +1355,7 @@ extern void git_config(config_fn_t fn, void *);
 extern int git_config_with_options(config_fn_t fn, void *,
 				   struct git_config_source *config_source,
 				   int respect_includes);
-extern int git_config_early(config_fn_t fn, void *, const char *repo_c=
onfig);
+extern int git_config_early(config_fn_t fn, void *, const char *repo_c=
onfig, const char *worktree_config);
 extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_config_int(const char *, const char *);
 extern int64_t git_config_int64(const char *, const char *);
diff --git a/config.c b/config.c
index 15a2983..3857023 100644
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
@@ -84,6 +86,33 @@ static long config_buf_ftell(struct config_source *c=
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
+		load_config_worktree(&config_local, git_path("info/config.worktree")=
);
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
@@ -1167,7 +1196,29 @@ int git_config_system(void)
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
 	char *xdg_config =3D NULL;
@@ -1191,7 +1242,23 @@ int git_config_early(config_fn_t fn, void *data,=
 const char *repo_config)
 		found +=3D 1;
 	}
=20
-	if (repo_config && !access_or_die(repo_config, R_OK, 0)) {
+	if (worktree_config) {
+		struct config_include_data inc =3D CONFIG_INCLUDE_INIT;
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
@@ -1217,6 +1284,7 @@ int git_config_with_options(config_fn_t fn, void =
*data,
 			    int respect_includes)
 {
 	char *repo_config =3D NULL;
+	char *worktree_config =3D NULL;
 	int ret;
 	struct config_include_data inc =3D CONFIG_INCLUDE_INIT;
=20
@@ -1239,9 +1307,11 @@ int git_config_with_options(config_fn_t fn, void=
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
@@ -1932,6 +2002,23 @@ int git_config_set_multivar_in_file(const char *=
config_filename,
=20
 	store.multi_replace =3D multi_replace;
=20
+	if (git_common_dir_env && is_config_local(key)) {
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
diff --git a/dir.c b/dir.c
index 3f7a025..69bf491 100644
--- a/dir.c
+++ b/dir.c
@@ -589,6 +589,47 @@ int add_excludes_from_file_to_list(const char *fna=
me,
 	return 0;
 }
=20
+void load_config_worktree(struct exclude_list *el, const char *path)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	int i, lineno =3D 1;
+	char *buf, *entry;
+	size_t size;
+
+	if (strbuf_read_file(&sb, path, 128) <=3D 0) {
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
 struct exclude_list *add_exclude_list(struct dir_struct *dir,
 				      int group_type, const char *src)
 {
diff --git a/dir.h b/dir.h
index 6c45e9d..539423d 100644
--- a/dir.h
+++ b/dir.h
@@ -165,6 +165,7 @@ extern struct exclude_list *add_exclude_list(struct=
 dir_struct *dir,
 					     int group_type, const char *src);
 extern int add_excludes_from_file_to_list(const char *fname, const cha=
r *base, int baselen,
 					  struct exclude_list *el, int check_index);
+extern void load_config_worktree(struct exclude_list *el, const char *=
fname);
 extern void add_excludes_from_file(struct dir_struct *, const char *fn=
ame);
 extern void parse_exclude_pattern(const char **string, int *patternlen=
, int *flags, int *nowildcardlen);
 extern void add_exclude(const char *string, const char *base,
diff --git a/setup.c b/setup.c
index fb61860..61e0403 100644
--- a/setup.c
+++ b/setup.c
@@ -356,13 +356,9 @@ static int check_repository_format_gently(const ch=
ar *gitdir, int *nongit_ok)
 {
 	struct strbuf sb =3D STRBUF_INIT;
 	const char *repo_config;
-	config_fn_t fn;
 	int ret =3D 0;
=20
-	if (get_common_dir(&sb, gitdir))
-		fn =3D check_repo_format;
-	else
-		fn =3D check_repository_format_version;
+	get_common_dir(&sb, gitdir);
 	strbuf_addstr(&sb, "/config");
 	repo_config =3D sb.buf;
=20
@@ -375,7 +371,7 @@ static int check_repository_format_gently(const cha=
r *gitdir, int *nongit_ok)
 	 * Use a gentler version of git_config() to check if this repo
 	 * is a good one.
 	 */
-	git_config_early(fn, NULL, repo_config);
+	git_config_early(check_repository_format_version, NULL, repo_config, =
NULL);
 	if (GIT_REPO_VERSION < repository_format_version) {
 		if (!nongit_ok)
 			die ("Expected git repo version <=3D %d, found %d",
diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
index f8e4df4..6f98279 100755
--- a/t/t2025-checkout-to.sh
+++ b/t/t2025-checkout-to.sh
@@ -126,4 +126,30 @@ test_expect_success 'checkout with grafts' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'setting worktree.foo goes to config.worktree' '
+	echo worKtree.Foo >> .git/info/config.worktree &&
+	git checkout --to wt.foo HEAD &&
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
diff --git a/templates/info--config.worktree b/templates/info--config.w=
orktree
new file mode 100644
index 0000000..f358230
--- /dev/null
+++ b/templates/info--config.worktree
@@ -0,0 +1,2 @@
+core.worktree
+core.bare
--=20
2.3.0.rc1.137.g477eb31
