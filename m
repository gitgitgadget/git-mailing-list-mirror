From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH] config: git_config_from_file(): handle "-" filename as
 stdin
Date: Fri, 14 Feb 2014 22:04:35 +0200
Message-ID: <20140214200435.GA13633@node.dhcp.inet.fi>
References: <1392384878-7080-1-git-send-email-kirill@shutemov.name>
 <xmqqlhxdim80.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 14 21:04:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEP0E-0006e3-1G
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 21:04:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbaBNUEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 15:04:46 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:49516 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965AbaBNUEp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 15:04:45 -0500
Received: from node.shutemov.name (80.220.224.16) by kirsi1.inet.fi (8.5.140.03)
        id 529734CF067DDDCD; Fri, 14 Feb 2014 22:04:39 +0200
Received: by node.shutemov.name (Postfix, from userid 1000)
	id DEFFA40647; Fri, 14 Feb 2014 22:04:35 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <xmqqlhxdim80.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.22.1-rc1 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242141>

On Fri, Feb 14, 2014 at 10:27:11AM -0800, Junio C Hamano wrote:
> "Kirill A. Shutemov" <kirill@shutemov.name> writes:
> 
> > The patch extends git config --file interface to allow read config from
> > stdin.
> 
> Thanks.  The external interface proposed by this change that behaves
> the way your new test expects is a good addition to the system.  I
> would describe it as:
> 
>   Subject: config: teach "git config --file -" to read from the standard input
> 
> I however think the patch implements it at the level that is too low
> in the callchain.  It will affect a lot more than the dash given to
> "git config --file -".  Fortunately, it does not make it possible
> for users to make this mistake
> 
> 	[include]
>         	path = -
> 
> and scratch their heads, wondering why "git config" is not answering
> until they hit ^D.  But that is _only_ because we check if a file
> whose name is "-" actually exists in the current directory before
> falling into this codepath (and usually no such file exists).  If
> such a funnily-named file does exist, we read from that file, not
> the standard input.  So that "include" codepath happens to be safe,
> but who knows what dragons lie in other codepaths that call this
> function.
> 
> I recall that an earlier implementation of "git diff --no-index"
> that made "-" read one side to be compared from the standard input
> had exactly the same issue of comparing filename with "-", which we
> had to fix with code reorganization recently.  I'd prefer to see
> this update to "git config --file -" done the right way from the
> start.

Okay, reworked version is below. It's slightly more invasive then the
original.

>From 199e6a995bb5228578e66189ef586421a4d8d9ba Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Fri, 14 Feb 2014 21:59:39 +0200
Subject: [PATCH] config: teach "git config --file -" to read from the standard
 input

The patch extends git config --file interface to allow read config from
stdin.

Editing stdin or setting value in stdin is an error.

Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
---
 builtin/config.c       | 39 ++++++++++++++++++++++++++-------------
 cache.h                |  1 +
 config.c               | 41 +++++++++++++++++++++++++++--------------
 t/t1300-repo-config.sh | 17 +++++++++++++++--
 4 files changed, 69 insertions(+), 29 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 92ebf23f0a9a..625f914c44a0 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -21,6 +21,7 @@ static char key_delim = ' ';
 static char term = '\n';
 
 static int use_global_config, use_system_config, use_local_config;
+static int use_stdin;
 static const char *given_config_file;
 static const char *given_config_blob;
 static int actions, types;
@@ -224,7 +225,7 @@ static int get_value(const char *key_, const char *regex_)
 	}
 
 	git_config_with_options(collect_config, &values,
-				given_config_file, given_config_blob,
+				use_stdin, given_config_file, given_config_blob,
 				respect_includes);
 
 	ret = !values.nr;
@@ -309,7 +310,7 @@ static void get_color(const char *def_color)
 	get_color_found = 0;
 	parsed_color[0] = '\0';
 	git_config_with_options(git_get_color_config, NULL,
-				given_config_file, given_config_blob,
+				use_stdin, given_config_file, given_config_blob,
 				respect_includes);
 
 	if (!get_color_found && def_color)
@@ -339,7 +340,7 @@ static int get_colorbool(int print)
 	get_diff_color_found = -1;
 	get_color_ui_found = -1;
 	git_config_with_options(git_get_colorbool_config, NULL,
-				given_config_file, given_config_blob,
+				use_stdin, given_config_file, given_config_blob,
 				respect_includes);
 
 	if (get_colorbool_found < 0) {
@@ -362,8 +363,11 @@ static int get_colorbool(int print)
 		return get_colorbool_found ? 0 : 1;
 }
 
-static void check_blob_write(void)
+static void check_write(void)
 {
+	if (use_stdin)
+		die("writing to stdin is not supported");
+
 	if (given_config_blob)
 		die("writing config blobs is not supported");
 }
@@ -435,7 +439,8 @@ static int get_urlmatch(const char *var, const char *url)
 	}
 
 	git_config_with_options(urlmatch_config_entry, &config,
-				given_config_file, NULL, respect_includes);
+				use_stdin, given_config_file, NULL,
+				respect_includes);
 
 	for_each_string_list_item(item, &values) {
 		struct urlmatch_current_candidate_value *matched = item->util;
@@ -476,6 +481,11 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
+	if (given_config_file && !strcmp(given_config_file, "-")) {
+		given_config_file = NULL;
+		use_stdin = 1;
+	}
+
 	if (use_global_config) {
 		char *user_config = NULL;
 		char *xdg_config = NULL;
@@ -549,6 +559,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	if (actions == ACTION_LIST) {
 		check_argc(argc, 0, 0);
 		if (git_config_with_options(show_all_config, NULL,
+					    use_stdin,
 					    given_config_file,
 					    given_config_blob,
 					    respect_includes) < 0) {
@@ -563,6 +574,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_argc(argc, 0, 0);
 		if (!given_config_file && nongit)
 			die("not in a git directory");
+		if (use_stdin)
+			die("editing stdin is not supported");
 		if (given_config_blob)
 			die("editing blobs is not supported");
 		git_config(git_default_config, NULL);
@@ -572,7 +585,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	}
 	else if (actions == ACTION_SET) {
 		int ret;
-		check_blob_write();
+		check_write();
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1]);
 		ret = git_config_set_in_file(given_config_file, argv[0], value);
@@ -582,21 +595,21 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		return ret;
 	}
 	else if (actions == ACTION_SET_ALL) {
-		check_blob_write();
+		check_write();
 		check_argc(argc, 2, 3);
 		value = normalize_value(argv[0], argv[1]);
 		return git_config_set_multivar_in_file(given_config_file,
 						       argv[0], value, argv[2], 0);
 	}
 	else if (actions == ACTION_ADD) {
-		check_blob_write();
+		check_write();
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1]);
 		return git_config_set_multivar_in_file(given_config_file,
 						       argv[0], value, "^$", 0);
 	}
 	else if (actions == ACTION_REPLACE_ALL) {
-		check_blob_write();
+		check_write();
 		check_argc(argc, 2, 3);
 		value = normalize_value(argv[0], argv[1]);
 		return git_config_set_multivar_in_file(given_config_file,
@@ -623,7 +636,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		return get_urlmatch(argv[0], argv[1]);
 	}
 	else if (actions == ACTION_UNSET) {
-		check_blob_write();
+		check_write();
 		check_argc(argc, 1, 2);
 		if (argc == 2)
 			return git_config_set_multivar_in_file(given_config_file,
@@ -633,14 +646,14 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 						      argv[0], NULL);
 	}
 	else if (actions == ACTION_UNSET_ALL) {
-		check_blob_write();
+		check_write();
 		check_argc(argc, 1, 2);
 		return git_config_set_multivar_in_file(given_config_file,
 						       argv[0], NULL, argv[1], 1);
 	}
 	else if (actions == ACTION_RENAME_SECTION) {
 		int ret;
-		check_blob_write();
+		check_write();
 		check_argc(argc, 2, 2);
 		ret = git_config_rename_section_in_file(given_config_file,
 							argv[0], argv[1]);
@@ -651,7 +664,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	}
 	else if (actions == ACTION_REMOVE_SECTION) {
 		int ret;
-		check_blob_write();
+		check_write();
 		check_argc(argc, 1, 1);
 		ret = git_config_rename_section_in_file(given_config_file,
 							argv[0], NULL);
diff --git a/cache.h b/cache.h
index dc040fb1aa99..538c28a1564a 100644
--- a/cache.h
+++ b/cache.h
@@ -1155,6 +1155,7 @@ extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
 extern int git_config(config_fn_t fn, void *);
 extern int git_config_with_options(config_fn_t fn, void *,
+				   int use_stdin,
 				   const char *filename,
 				   const char *blob_ref,
 				   int respect_includes);
diff --git a/config.c b/config.c
index d969a5aefc2b..53dd39f0b9ef 100644
--- a/config.c
+++ b/config.c
@@ -1030,24 +1030,34 @@ static int do_config_from(struct config_source *top, config_fn_t fn, void *data)
 	return ret;
 }
 
-int git_config_from_file(config_fn_t fn, const char *filename, void *data)
+static int do_config_from_file(config_fn_t fn, const char *filename, FILE *f,
+			       void *data)
 {
-	int ret;
-	FILE *f = fopen(filename, "r");
+	struct config_source top;
 
-	ret = -1;
-	if (f) {
-		struct config_source top;
+	top.u.file = f;
+	top.name = filename;
+	top.die_on_error = 1;
+	top.do_fgetc = config_file_fgetc;
+	top.do_ungetc = config_file_ungetc;
+	top.do_ftell = config_file_ftell;
+
+	return do_config_from(&top, fn, data);
+}
 
-		top.u.file = f;
-		top.name = filename;
-		top.die_on_error = 1;
-		top.do_fgetc = config_file_fgetc;
-		top.do_ungetc = config_file_ungetc;
-		top.do_ftell = config_file_ftell;
+static int git_config_from_stdin(config_fn_t fn, void *data)
+{
+	return do_config_from_file(fn, "<stdin>", stdin, data);
+}
 
-		ret = do_config_from(&top, fn, data);
+int git_config_from_file(config_fn_t fn, const char *filename, void *data)
+{
+	int ret = -1;
+	FILE *f;
 
+	f = fopen(filename, "r");
+	if (f) {
+		ret = do_config_from_file(fn, filename, f, data);
 		fclose(f);
 	}
 	return ret;
@@ -1170,6 +1180,7 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 }
 
 int git_config_with_options(config_fn_t fn, void *data,
+			    int use_stdin,
 			    const char *filename,
 			    const char *blob_ref,
 			    int respect_includes)
@@ -1189,6 +1200,8 @@ int git_config_with_options(config_fn_t fn, void *data,
 	 * If we have a specific filename, use it. Otherwise, follow the
 	 * regular lookup sequence.
 	 */
+	if (use_stdin)
+		return git_config_from_stdin(fn, data);
 	if (filename)
 		return git_config_from_file(fn, filename, data);
 	else if (blob_ref)
@@ -1203,7 +1216,7 @@ int git_config_with_options(config_fn_t fn, void *data,
 
 int git_config(config_fn_t fn, void *data)
 {
-	return git_config_with_options(fn, data, NULL, NULL, 1);
+	return git_config_with_options(fn, data, 0, NULL, NULL, 1);
 }
 
 /*
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 967359344dab..c9c426c273e5 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -475,15 +475,28 @@ ein.bahn=strasse
 EOF
 
 test_expect_success 'alternative GIT_CONFIG' '
-	GIT_CONFIG=other-config git config -l >output &&
+	GIT_CONFIG=other-config git config --list >output &&
 	test_cmp expect output
 '
 
 test_expect_success 'alternative GIT_CONFIG (--file)' '
-	git config --file other-config -l > output &&
+	git config --file other-config --list >output &&
 	test_cmp expect output
 '
 
+test_expect_success 'alternative GIT_CONFIG (--file=-)' '
+	git config --file - --list <other-config >output &&
+	test_cmp expect output
+'
+
+test_expect_success 'setting a value in stdin is an error' '
+	test_must_fail git config --file - some.value foo
+'
+
+test_expect_success 'editing stdin is an error' '
+	test_must_fail git config --file - --edit
+'
+
 test_expect_success 'refer config from subdirectory' '
 	mkdir x &&
 	(
-- 
 Kirill A. Shutemov
