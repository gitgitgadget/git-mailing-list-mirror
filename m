From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/6] config.c: move worktree-specific variables to .git/worktrees/...
Date: Sun, 27 Dec 2015 10:14:35 +0700
Message-ID: <1451186079-6119-3-git-send-email-pclouds@gmail.com>
References: <1449083626-20075-1-git-send-email-pclouds@gmail.com>
 <1451186079-6119-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@drmicha.warpmail.net, max@max630.net, Jens.Lehmann@web.de,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 27 04:15:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aD1nc-0003Dw-6M
	for gcvg-git-2@plane.gmane.org; Sun, 27 Dec 2015 04:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490AbbL0DPG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Dec 2015 22:15:06 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34540 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491AbbL0DPE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2015 22:15:04 -0500
Received: by mail-pa0-f44.google.com with SMTP id uo6so71172884pac.1
        for <git@vger.kernel.org>; Sat, 26 Dec 2015 19:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=U1dlQl4svZGuC8IK9oX/qYZSqQqE5O5MUUWnqM7duv8=;
        b=u4aDw+jZM6OgN/EbHZkw9H0d4mLmgsgUHYK5+vfqJErA/vI2HHNvqwJm5EkgBcC/sO
         jAPrUnUQIya6PPKPXJlsSThB8bB/1219k/EpP+ceNYcfHphHoqFf4vUZzQJju7tT3xQK
         f/z7XFB76WkUw9WxOnMhqNX5ncvCqnTKikRyWx9ENorpadHXfnjT1AyVDFh+h0lD6cY+
         aW4dQWgDS35MpPKquXHqr4avuuDvKO9Cw4mbs5cDl1N2DDAau8LzO3xHZXVAlxmeC4/D
         YvlyytNFujSenL+IhOUU65GmxzhJvthd1XVfAKIt2QaXIO/i879QZqhF/m7Etv2ZntVi
         S6xA==
X-Received: by 10.66.154.161 with SMTP id vp1mr68383036pab.25.1451186104397;
        Sat, 26 Dec 2015 19:15:04 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id u67sm67950736pfa.84.2015.12.26.19.14.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Dec 2015 19:15:02 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 27 Dec 2015 10:15:09 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283010>

In multiple worktree setup, a set of variables will be read from
$GIT_DIR/worktrees/<id>/config instead of $GIT_DIR/config, when the
config variables are accessed from a linked worktree. When accessed
from the main worktree, the same set is still read from $GIT_DIR/config=
=2E

This mechanism is needed because we do have worktree-specific config
variables such as core.worktree. But for now, no config variable is
marked per-worktree (so can't test yet).

This is the new behavior when repo extension worktree=3D1 is defined.

Helped-by: Max Kirillov <max@max630.net>
Helped-by: Jens Lehmann <Jens.Lehmann@web.de>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt               |   4 ++
 Documentation/git-worktree.txt         |  11 +++
 Documentation/gitrepository-layout.txt |   5 ++
 builtin/config.c                       |   9 +++
 cache.h                                |   2 +-
 config.c                               | 121 +++++++++++++++++++++++++=
++++++--
 setup.c                                |   2 +-
 7 files changed, 145 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f617886..d507b8a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -8,6 +8,10 @@ is used to store the configuration for that repository=
, and
 fallback values for the `.git/config` file. The file `/etc/gitconfig`
 can be used to store a system-wide default configuration.
=20
+Linked worktrees (see linkgit:git-worktree[1]) also have a
+worktree-specific file config. See linkgit:gitrepository-layout[5] for
+more information.
+
 The configuration variables are used by both the Git plumbing
 and the porcelains. The variables are divided into sections, wherein
 the fully qualified variable name of the variable itself is the last
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
index 5b9ad04..bc0734c 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -147,6 +147,17 @@ to `/path/main/.git/worktrees/test-next` then a fi=
le named
 `test-next` entry from being pruned.  See
 linkgit:gitrepository-layout[5] for details.
=20
+Similar to the file system split in ".git", the repository config file
+is also split. Certain variables, for example core.worktree, are
+per-worktree while the majority of variables are still shared (see
+linkgit:git-config[1] for details). Shared variables and per-working
+tree ones that belong to the main working tree are in .git/config.
+Per-working tree variables for working tree X are in
+$GIT_COMMON_DIR/worktrees/X/config. Even though per-working tree
+variables for the main working tree are in the default config place,
+they are invisible from all linked working trees. The following
+configuration variables are per working directory:
+
 LIST OUTPUT FORMAT
 ------------------
 The worktree list command has two output formats.  The default format =
shows the
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/git=
repository-layout.txt
index 577ee84..cf724e6 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -276,6 +276,11 @@ worktrees/<id>/link::
 	file. It is used to detect if the linked repository is
 	manually removed.
=20
+worktrees/<id>/config::
+	This file contains worktree-specific configuration
+	variables. See the list of variables in linkgit:git-worktree[1].
+	The same variables in $GIT_COMMON_DIR/config are ignored.
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
index fa0a64b..10f4ff8 100644
--- a/cache.h
+++ b/cache.h
@@ -1494,7 +1494,7 @@ extern void git_config(config_fn_t fn, void *);
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
index 86a5eb2..7d94f21 100644
--- a/config.c
+++ b/config.c
@@ -37,10 +37,25 @@ struct config_source {
 	long (*do_ftell)(struct config_source *c);
 };
=20
+struct config_pattern {
+	unsigned int prefix;
+	unsigned int len;
+	const char *pattern;
+};
+
 static struct config_source *cf;
=20
 static int zlib_compression_seen;
=20
+static struct config_pattern worktree_v1[] =3D {
+	{ 0, 0, NULL }
+};
+
+static struct config_pattern *worktree_patterns[] =3D {
+	NULL,
+	worktree_v1
+};
+
 /*
  * Default config_set that contains key-value pairs from the usual set=
 of config
  * config files (i.e repo specific .git/config, user wide ~/.gitconfig=
, XDG
@@ -89,6 +104,34 @@ static long config_buf_ftell(struct config_source *=
conf)
 	return conf->u.buf.pos;
 }
=20
+static int is_config_local(const char *key_)
+{
+	int len;
+	struct config_pattern *cp;
+
+	if (repository_format_worktree_version < 0 ||
+	    repository_format_worktree_version >=3D ARRAY_SIZE(worktree_patte=
rns))
+		die("unknown config version %d", repository_format_worktree_version)=
;
+
+	cp =3D worktree_patterns[repository_format_worktree_version];
+	if (!cp)
+		return 0;
+	len =3D strlen(key_);
+	for (; ; cp++) {
+		if (!cp->pattern)
+			return 0;
+		if (!cp->len)
+			cp->len =3D strlen(cp->pattern);
+		if (len < cp->len)
+			continue;
+		if (strncmp(key_, cp->pattern, len))
+			continue;
+		if (!cp->prefix && len > cp->len)
+			continue;
+		return 1;
+	}
+}
+
 #define MAX_INCLUDE_DEPTH 10
 static const char include_depth_advice[] =3D
 "exceeded maximum include depth (%d) while including\n"
@@ -1184,7 +1227,36 @@ int git_config_system(void)
 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
 }
=20
-int git_config_early(config_fn_t fn, void *data, const char *repo_conf=
ig)
+static char *worktree_config_path(void)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	strbuf_addf(&sb, "%s/config", get_git_dir());
+	return strbuf_detach(&sb, NULL);
+}
+
+static int config_worktree_filter_in(const char *var,
+				     const char *value, void *data)
+{
+	struct config_include_data *inc =3D data;
+
+	if (!is_config_local(var))
+		return error("%s in per-worktree config file is ignored", var);
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
@@ -1206,7 +1278,23 @@ int git_config_early(config_fn_t fn, void *data,=
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
@@ -1232,6 +1320,7 @@ int git_config_with_options(config_fn_t fn, void =
*data,
 			    int respect_includes)
 {
 	char *repo_config =3D NULL;
+	char *worktree_config =3D NULL;
 	int ret;
 	struct config_include_data inc =3D CONFIG_INCLUDE_INIT;
=20
@@ -1254,9 +1343,11 @@ int git_config_with_options(config_fn_t fn, void=
 *data,
 		return git_config_from_blob_ref(fn, config_source->blob, data);
=20
 	repo_config =3D git_pathdup("config");
-	ret =3D git_config_early(fn, data, repo_config);
-	if (repo_config)
-		free(repo_config);
+	if (git_common_dir_env)
+		worktree_config =3D worktree_config_path();
+	ret =3D git_config_early(fn, data, repo_config, worktree_config);
+	free(repo_config);
+	free(worktree_config);
 	return ret;
 }
=20
@@ -1925,6 +2016,23 @@ int git_config_key_is_valid(const char *key)
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
+	if (!is_config_local(key))
+		config_filename =3D *filename_buf =3D git_pathdup("config");
+	else
+		config_filename =3D *filename_buf =3D worktree_config_path();
+	return config_filename;
+}
+
 /*
  * If value=3D=3DNULL, unset in (remove from) config,
  * if value_regex!=3DNULL, disregard key/value pairs where value does =
not match.
@@ -1968,8 +2076,7 @@ int git_config_set_multivar_in_file(const char *c=
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
diff --git a/setup.c b/setup.c
index 2f41648..9196945 100644
--- a/setup.c
+++ b/setup.c
@@ -407,7 +407,7 @@ static int check_repository_format_gently(const cha=
r *gitdir, int *nongit_ok)
 	 * Use a gentler version of git_config() to check if this repo
 	 * is a good one.
 	 */
-	git_config_early(fn, NULL, repo_config);
+	git_config_early(fn, NULL, repo_config, NULL);
 	if (GIT_REPO_VERSION_READ < repository_format_version) {
 		if (!nongit_ok)
 			die ("Expected git repo version <=3D %d, found %d",
--=20
2.3.0.rc1.137.g477eb31
