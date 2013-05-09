From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v3 4/5] teach config --blob option to parse config from
 database
Date: Thu, 9 May 2013 18:20:18 +0200
Message-ID: <20130509162018.GF3526@book-mint>
References: <20130509154020.GA26423@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 09 18:27:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaTgV-0004cJ-QC
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 18:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280Ab3EIQ1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 12:27:06 -0400
Received: from smtprelay03.ispgateway.de ([80.67.29.7]:35813 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257Ab3EIQ1F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 12:27:05 -0400
X-Greylist: delayed 617 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 May 2013 12:27:05 EDT
Received: from [213.221.117.228] (helo=book-mint)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UaTZu-0007Wr-SD; Thu, 09 May 2013 18:20:24 +0200
Content-Disposition: inline
In-Reply-To: <20130509154020.GA26423@book-mint>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223745>

This can be used to read configuration values directly from gits
database. For example it is useful for reading to be checked out
.gitmodules files directly from the database.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 builtin/config.c       | 31 +++++++++++++++---
 cache.h                |  6 +++-
 config.c               | 85 ++++++++++++++++++++++++++++++++++++++++++++++++--
 t/t1307-config-blob.sh | 70 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 185 insertions(+), 7 deletions(-)
 create mode 100755 t/t1307-config-blob.sh

diff --git a/builtin/config.c b/builtin/config.c
index 33c9bf9..8d01b7a 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -21,6 +21,7 @@ static char term = '\n';
 
 static int use_global_config, use_system_config, use_local_config;
 static const char *given_config_file;
+static const char *given_config_blob;
 static int actions, types;
 static const char *get_color_slot, *get_colorbool_slot;
 static int end_null;
@@ -53,6 +54,7 @@ static struct option builtin_config_options[] = {
 	OPT_BOOLEAN(0, "system", &use_system_config, N_("use system config file")),
 	OPT_BOOLEAN(0, "local", &use_local_config, N_("use repository config file")),
 	OPT_STRING('f', "file", &given_config_file, N_("file"), N_("use given config file")),
+	OPT_STRING(0, "blob", &given_config_blob, N_("blob-id"), N_("read config from given blob object")),
 	OPT_GROUP(N_("Action")),
 	OPT_BIT(0, "get", &actions, N_("get value: name [value-regex]"), ACTION_GET),
 	OPT_BIT(0, "get-all", &actions, N_("get all values: key [value-regex]"), ACTION_GET_ALL),
@@ -218,7 +220,8 @@ static int get_value(const char *key_, const char *regex_)
 	}
 
 	git_config_with_options(collect_config, &values,
-				given_config_file, respect_includes);
+				given_config_file, given_config_blob,
+				respect_includes);
 
 	ret = !values.nr;
 
@@ -302,7 +305,8 @@ static void get_color(const char *def_color)
 	get_color_found = 0;
 	parsed_color[0] = '\0';
 	git_config_with_options(git_get_color_config, NULL,
-				given_config_file, respect_includes);
+				given_config_file, given_config_blob,
+				respect_includes);
 
 	if (!get_color_found && def_color)
 		color_parse(def_color, "command line", parsed_color);
@@ -330,7 +334,8 @@ static int get_colorbool(int print)
 	get_colorbool_found = -1;
 	get_diff_color_found = -1;
 	git_config_with_options(git_get_colorbool_config, NULL,
-				given_config_file, respect_includes);
+				given_config_file, given_config_blob,
+				respect_includes);
 
 	if (get_colorbool_found < 0) {
 		if (!strcmp(get_colorbool_slot, "color.diff"))
@@ -348,6 +353,12 @@ static int get_colorbool(int print)
 		return get_colorbool_found ? 0 : 1;
 }
 
+static void check_blob_write(void)
+{
+	if (given_config_blob)
+		die("writing config blobs is not supported");
+}
+
 int cmd_config(int argc, const char **argv, const char *prefix)
 {
 	int nongit = !startup_info->have_repository;
@@ -359,7 +370,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			     builtin_config_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
-	if (use_global_config + use_system_config + use_local_config + !!given_config_file > 1) {
+	if (use_global_config + use_system_config + use_local_config +
+	    !!given_config_file + !!given_config_blob > 1) {
 		error("only one config file at a time.");
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
@@ -438,6 +450,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_argc(argc, 0, 0);
 		if (git_config_with_options(show_all_config, NULL,
 					    given_config_file,
+					    given_config_blob,
 					    respect_includes) < 0) {
 			if (given_config_file)
 				die_errno("unable to read config file '%s'",
@@ -450,6 +463,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_argc(argc, 0, 0);
 		if (!given_config_file && nongit)
 			die("not in a git directory");
+		if (given_config_blob)
+			die("editing blobs is not supported");
 		git_config(git_default_config, NULL);
 		launch_editor(given_config_file ?
 			      given_config_file : git_path("config"),
@@ -457,6 +472,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	}
 	else if (actions == ACTION_SET) {
 		int ret;
+		check_blob_write();
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1]);
 		ret = git_config_set_in_file(given_config_file, argv[0], value);
@@ -466,18 +482,21 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		return ret;
 	}
 	else if (actions == ACTION_SET_ALL) {
+		check_blob_write();
 		check_argc(argc, 2, 3);
 		value = normalize_value(argv[0], argv[1]);
 		return git_config_set_multivar_in_file(given_config_file,
 						       argv[0], value, argv[2], 0);
 	}
 	else if (actions == ACTION_ADD) {
+		check_blob_write();
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1]);
 		return git_config_set_multivar_in_file(given_config_file,
 						       argv[0], value, "^$", 0);
 	}
 	else if (actions == ACTION_REPLACE_ALL) {
+		check_blob_write();
 		check_argc(argc, 2, 3);
 		value = normalize_value(argv[0], argv[1]);
 		return git_config_set_multivar_in_file(given_config_file,
@@ -500,6 +519,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		return get_value(argv[0], argv[1]);
 	}
 	else if (actions == ACTION_UNSET) {
+		check_blob_write();
 		check_argc(argc, 1, 2);
 		if (argc == 2)
 			return git_config_set_multivar_in_file(given_config_file,
@@ -509,12 +529,14 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 						      argv[0], NULL);
 	}
 	else if (actions == ACTION_UNSET_ALL) {
+		check_blob_write();
 		check_argc(argc, 1, 2);
 		return git_config_set_multivar_in_file(given_config_file,
 						       argv[0], NULL, argv[1], 1);
 	}
 	else if (actions == ACTION_RENAME_SECTION) {
 		int ret;
+		check_blob_write();
 		check_argc(argc, 2, 2);
 		ret = git_config_rename_section_in_file(given_config_file,
 							argv[0], argv[1]);
@@ -525,6 +547,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	}
 	else if (actions == ACTION_REMOVE_SECTION) {
 		int ret;
+		check_blob_write();
 		check_argc(argc, 1, 1);
 		ret = git_config_rename_section_in_file(given_config_file,
 							argv[0], NULL);
diff --git a/cache.h b/cache.h
index 94ca1ac..be48c4b 100644
--- a/cache.h
+++ b/cache.h
@@ -1142,11 +1142,15 @@ extern int update_server_info(int);
 typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
+extern int git_config_from_buf(config_fn_t fn, const char *name,
+			       const char *buf, size_t len, void *data);
 extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
 extern int git_config(config_fn_t fn, void *);
 extern int git_config_with_options(config_fn_t fn, void *,
-				   const char *filename, int respect_includes);
+				   const char *filename,
+				   const char *blob_ref,
+				   int respect_includes);
 extern int git_config_early(config_fn_t fn, void *, const char *repo_config);
 extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_config_int(const char *, const char *);
diff --git a/config.c b/config.c
index 2390458..50c762a 100644
--- a/config.c
+++ b/config.c
@@ -14,6 +14,11 @@ struct config_source {
 	struct config_source *prev;
 	union {
 		FILE *file;
+		struct config_buf {
+			const char *buf;
+			size_t len;
+			size_t pos;
+		} buf;
 	};
 	const char *name;
 	int linenr;
@@ -45,6 +50,28 @@ static long config_file_ftell(struct config_source *conf)
 	return ftell(conf->file);
 }
 
+
+static int config_buf_fgetc(struct config_source *conf)
+{
+	if (conf->buf.pos < conf->buf.len && conf->buf.buf[conf->buf.pos])
+		return conf->buf.buf[conf->buf.pos++];
+
+	return EOF;
+}
+
+static int config_buf_ungetc(int c, struct config_source *conf)
+{
+	if (conf->buf.pos > 0)
+		return conf->buf.buf[--conf->buf.pos];
+
+	return EOF;
+}
+
+static long config_buf_ftell(struct config_source *conf)
+{
+	return conf->buf.pos;
+}
+
 #define MAX_INCLUDE_DEPTH 10
 static const char include_depth_advice[] =
 "exceeded maximum include depth (%d) while including\n"
@@ -961,6 +988,56 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 	return ret;
 }
 
+int git_config_from_buf(config_fn_t fn, const char *name, const char *buf,
+			size_t len, void *data)
+{
+	struct config_source top;
+
+	top.buf.buf = buf;
+	top.buf.pos = 0;
+	top.name = name;
+	top.fgetc = config_buf_fgetc;
+	top.ungetc = config_buf_ungetc;
+	top.ftell = config_buf_ftell;
+
+	return do_config_from_source(&top, fn, data);
+}
+
+static int git_config_from_blob_sha1(config_fn_t fn,
+				     const char *name,
+				     const unsigned char *sha1,
+				     void *data)
+{
+	enum object_type type;
+	char *buf;
+	unsigned long size;
+	int ret;
+
+	buf = read_sha1_file(sha1, &type, &size);
+	if (!buf)
+		return error("unable to load config blob object '%s'", name);
+	if (type != OBJ_BLOB) {
+		free(buf);
+		return error("reference '%s' does not point to a blob", name);
+	}
+
+	ret = git_config_from_buf(fn, name, buf, size, data);
+	free(buf);
+
+	return ret;
+}
+
+static int git_config_from_blob_ref(config_fn_t fn,
+				    const char *name,
+				    void *data)
+{
+	unsigned char sha1[20];
+
+	if (get_sha1(name, sha1) < 0)
+		return error("unable to resolve config blob '%s'", name);
+	return git_config_from_blob_sha1(fn, name, sha1, data);
+}
+
 const char *git_etc_gitconfig(void)
 {
 	static const char *system_wide;
@@ -1026,7 +1103,9 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 }
 
 int git_config_with_options(config_fn_t fn, void *data,
-			    const char *filename, int respect_includes)
+			    const char *filename,
+			    const char *blob_ref,
+			    int respect_includes)
 {
 	char *repo_config = NULL;
 	int ret;
@@ -1045,6 +1124,8 @@ int git_config_with_options(config_fn_t fn, void *data,
 	 */
 	if (filename)
 		return git_config_from_file(fn, filename, data);
+	else if (blob_ref)
+		return git_config_from_blob_ref(fn, blob_ref, data);
 
 	repo_config = git_pathdup("config");
 	ret = git_config_early(fn, data, repo_config);
@@ -1055,7 +1136,7 @@ int git_config_with_options(config_fn_t fn, void *data,
 
 int git_config(config_fn_t fn, void *data)
 {
-	return git_config_with_options(fn, data, NULL, 1);
+	return git_config_with_options(fn, data, NULL, NULL, 1);
 }
 
 /*
diff --git a/t/t1307-config-blob.sh b/t/t1307-config-blob.sh
new file mode 100755
index 0000000..fdc257e
--- /dev/null
+++ b/t/t1307-config-blob.sh
@@ -0,0 +1,70 @@
+#!/bin/sh
+
+test_description='support for reading config from a blob'
+. ./test-lib.sh
+
+test_expect_success 'create config blob' '
+	cat >config <<-\EOF &&
+	[some]
+		value = 1
+	EOF
+	git add config &&
+	git commit -m foo
+'
+
+test_expect_success 'list config blob contents' '
+	echo some.value=1 >expect &&
+	git config --blob=HEAD:config --list >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'fetch value from blob' '
+	echo true >expect &&
+	git config --blob=HEAD:config --bool some.value >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'reading non-existing value from blob is an error' '
+	test_must_fail git config --blob=HEAD:config non.existing
+'
+
+test_expect_success 'reading from blob and file is an error' '
+	test_must_fail git config --blob=HEAD:config --system --list
+'
+
+test_expect_success 'reading from missing ref is an error' '
+	test_must_fail git config --blob=HEAD:doesnotexist --list
+'
+
+test_expect_success 'reading from non-blob is an error' '
+	test_must_fail git config --blob=HEAD --list
+'
+
+test_expect_success 'setting a value in a blob is an error' '
+	test_must_fail git config --blob=HEAD:config some.value foo
+'
+
+test_expect_success 'deleting a value in a blob is an error' '
+	test_must_fail git config --blob=HEAD:config --unset some.value
+'
+
+test_expect_success 'editing a blob is an error' '
+	test_must_fail git config --blob=HEAD:config --edit
+'
+
+test_expect_success 'parse errors in blobs are properly attributed' '
+	cat >config <<-\EOF &&
+	[some]
+		value = "
+	EOF
+	git add config &&
+	git commit -m broken &&
+
+	test_must_fail git config --blob=HEAD:config some.value 2>err &&
+
+	# just grep for our token as the exact error message is likely to
+	# change or be internationalized
+	grep "HEAD:config" err
+'
+
+test_done
-- 
1.8.3.rc1.40.gba374ae
