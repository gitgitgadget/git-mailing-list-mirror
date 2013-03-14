From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] teach config parsing to read from strbuf
Date: Thu, 14 Mar 2013 03:39:14 -0400
Message-ID: <20130314073913.GA7024@sigill.intra.peff.net>
References: <20130310165642.GA1136@sandbox-ub.fritz.box>
 <20130310170052.GE1136@sandbox-ub.fritz.box>
 <20130312111806.GF11340@sigill.intra.peff.net>
 <20130312164254.GB4752@sandbox-ub.fritz.box>
 <20130312192959.GG17099@sigill.intra.peff.net>
 <20130314063933.GB4062@sandbox-ub.fritz.box>
 <20130314071046.GB6103@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Mar 14 08:39:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UG2lM-0008ED-Kg
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 08:39:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288Ab3CNHjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 03:39:17 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51471 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254Ab3CNHjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 03:39:16 -0400
Received: (qmail 12711 invoked by uid 107); 14 Mar 2013 07:40:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Mar 2013 03:40:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Mar 2013 03:39:14 -0400
Content-Disposition: inline
In-Reply-To: <20130314071046.GB6103@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218122>

On Thu, Mar 14, 2013 at 03:10:46AM -0400, Jeff King wrote:

> I looked into this a little. The first sticking point is that
> git_config_with_options needs to support the alternate source. Here's a
> sketch of what I think the solution should look like, on top of your
> patches.

Here it is again, with two changes:

  1. Rather than handling the blob lookup inline in
     git_config_with_options, it adds direct functions for reading
     config from blob sha1s and blob references. I think this should
     make it easier to reuse when you are trying to read .gitmodules
     from C code.

  2. It adds some basic tests.

I'll leave it here for tonight. The next step would be to rebase it on
your modified series (in particular, I think git_config_from_strbuf
should become git_config_from_buf, which will impact this).

Feel free to use, pick apart, rewrite, or discard as you see fit for
your series.

diff --git a/builtin/config.c b/builtin/config.c
index 33c9bf9..8d01b7a 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -21,6 +21,7 @@ static const char *given_config_file;
 
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
index a2621fa..9db5f74 100644
--- a/cache.h
+++ b/cache.h
@@ -1134,7 +1134,9 @@ extern int git_config_with_options(config_fn_t fn, void *,
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
index b8c8640..5c492a8 100644
--- a/config.c
+++ b/config.c
@@ -1009,6 +1009,47 @@ int git_config_from_strbuf(config_fn_t fn, const char *name, struct strbuf *strb
 	return do_config_from_source(&top, fn, data);
 }
 
+static int git_config_from_blob_sha1(config_fn_t fn,
+				     const char *name,
+				     const unsigned char *sha1,
+				     void *data)
+{
+	struct strbuf sb = STRBUF_INIT;
+	enum object_type type;
+	void *buf;
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
+	/*
+	 * read_sha1_file always NUL-terminates for us, so size+1 is OK;
+	 * we could skip this step if we had git_config_from_buf
+	 */
+	strbuf_attach(&sb, buf, size, size+1);
+	ret = git_config_from_strbuf(fn, name, &sb, data);
+	strbuf_release(&sb);
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
@@ -1074,7 +1115,9 @@ int git_config_with_options(config_fn_t fn, void *data,
 }
 
 int git_config_with_options(config_fn_t fn, void *data,
-			    const char *filename, int respect_includes)
+			    const char *filename,
+			    const char *blob_ref,
+			    int respect_includes)
 {
 	char *repo_config = NULL;
 	int ret;
@@ -1093,6 +1136,8 @@ int git_config_with_options(config_fn_t fn, void *data,
 	 */
 	if (filename)
 		return git_config_from_file(fn, filename, data);
+	else if (blob_ref)
+		return git_config_from_blob_ref(fn, blob_ref, data);
 
 	repo_config = git_pathdup("config");
 	ret = git_config_early(fn, data, repo_config);
@@ -1103,7 +1148,7 @@ int git_config(config_fn_t fn, void *data)
 
 int git_config(config_fn_t fn, void *data)
 {
-	return git_config_with_options(fn, data, NULL, 1);
+	return git_config_with_options(fn, data, NULL, NULL, 1);
 }
 
 /*
diff --git a/t/t1307-config-blob.sh b/t/t1307-config-blob.sh
index e69de29..141ca21 100755
--- a/t/t1307-config-blob.sh
+++ b/t/t1307-config-blob.sh
@@ -0,0 +1,66 @@
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
