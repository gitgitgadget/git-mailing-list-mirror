From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] teach config parsing to read from strbuf
Date: Thu, 14 Mar 2013 03:10:46 -0400
Message-ID: <20130314071046.GB6103@sigill.intra.peff.net>
References: <20130310165642.GA1136@sandbox-ub.fritz.box>
 <20130310170052.GE1136@sandbox-ub.fritz.box>
 <20130312111806.GF11340@sigill.intra.peff.net>
 <20130312164254.GB4752@sandbox-ub.fritz.box>
 <20130312192959.GG17099@sigill.intra.peff.net>
 <20130314063933.GB4062@sandbox-ub.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Mar 14 08:11:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UG2Jr-0006hb-3P
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 08:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754686Ab3CNHKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 03:10:50 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51455 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754617Ab3CNHKt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 03:10:49 -0400
Received: (qmail 12559 invoked by uid 107); 14 Mar 2013 07:12:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Mar 2013 03:12:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Mar 2013 03:10:46 -0400
Content-Disposition: inline
In-Reply-To: <20130314063933.GB4062@sandbox-ub.fritz.box>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218121>

On Thu, Mar 14, 2013 at 07:39:33AM +0100, Heiko Voigt wrote:

> > I am on the fence. I do not want to create more work for you, but I do
> > think it may come in handy, if only for doing submodule things from
> > shell. And it is hopefully not a very large patch. I'd say try it, and
> > if starts looking like it will be very ugly, the right thing may be to
> > leave it until somebody really wants it.
> 
> Thats what I will do: Try it and see where I get.

I looked into this a little. The first sticking point is that
git_config_with_options needs to support the alternate source. Here's a
sketch of what I think the solution should look like, on top of your
patches.

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
index b8c8640..35aa8e2 100644
--- a/config.c
+++ b/config.c
@@ -1073,8 +1073,34 @@ int git_config_with_options(config_fn_t fn, void *data,
 	return ret == 0 ? found : ret;
 }
 
+static int read_blob_reference(const char *ref,
+			       struct strbuf *sb)
+{
+	unsigned char sha1[20];
+	enum object_type type;
+	void *buf;
+	unsigned long size;
+
+	if (get_sha1(ref, sha1) < 0)
+		return error("unable to resolve config blob '%s'", ref);
+
+	buf = read_sha1_file(sha1, &type, &size);
+	if (!buf)
+		return error("unable to load config blob object '%s'", ref);
+	if (type != OBJ_BLOB) {
+		free(buf);
+		return error("reference '%s' does not point to a blob", ref);
+	}
+
+	/* read_sha1_file always NUL-terminates for us, so size+1 is OK */
+	strbuf_attach(sb, buf, size, size+1);
+	return 0;
+}
+
 int git_config_with_options(config_fn_t fn, void *data,
-			    const char *filename, int respect_includes)
+			    const char *filename,
+			    const char *blob_ref,
+			    int respect_includes)
 {
 	char *repo_config = NULL;
 	int ret;
@@ -1093,6 +1119,15 @@ int git_config_with_options(config_fn_t fn, void *data,
 	 */
 	if (filename)
 		return git_config_from_file(fn, filename, data);
+	else if (blob_ref) {
+		struct strbuf buf = STRBUF_INIT;
+		if (read_blob_reference(blob_ref, &buf) < 0)
+			return -1;
+
+		ret = git_config_from_strbuf(fn, blob_ref, &buf, data);
+		strbuf_release(&buf);
+		return ret;
+	}
 
 	repo_config = git_pathdup("config");
 	ret = git_config_early(fn, data, repo_config);
@@ -1103,7 +1138,7 @@ int git_config(config_fn_t fn, void *data)
 
 int git_config(config_fn_t fn, void *data)
 {
-	return git_config_with_options(fn, data, NULL, 1);
+	return git_config_with_options(fn, data, NULL, NULL, 1);
 }
 
 /*
