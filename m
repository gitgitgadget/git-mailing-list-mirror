From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH] exec_cmd: system_path memory leak fix
Date: Mon, 24 Nov 2014 19:11:40 +0600
Message-ID: <87fvd891fy.fsf@gmail.com>
References: <1416750981-24446-1-git-send-email-kuleshovmail@gmail.com> <1416750981-24446-2-git-send-email-kuleshovmail@gmail.com> <xmqqioi5ycme.fsf@gitster.dls.corp.google.com> <87sih9en65.fsf@gmail.com> <xmqq7fyly3xj.fsf@gitster.dls.corp.google.com> <87mw7haxdp.fsf@gmail.com> <CAPc5daWnJCGPTMA0Hyg8QEAmsnF17ZQ9njGq8xVaUAfuwCRQDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 14:24:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xstcn-00027K-Gy
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 14:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753547AbaKXNYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 08:24:11 -0500
Received: from mail-la0-f41.google.com ([209.85.215.41]:40132 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202AbaKXNYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 08:24:09 -0500
Received: by mail-la0-f41.google.com with SMTP id gf13so7524446lab.14
        for <git@vger.kernel.org>; Mon, 24 Nov 2014 05:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version:content-type;
        bh=aWhuXLJh/HPCaqbb1wHXaSq3iUn/NpYge1lT07uWAZ4=;
        b=IALBzkCBhdzpKTFOVLFpj8XYGiWDN/YeBzqur6uavz1oPNp1cwfx1g3g0RB3EtrFIH
         GwIMku8Ale4DpE3vnA9KXfQfl75wH7DI3Rd+oSnNv9yRcRHm2iy9K6XL2EkswkoyOXxh
         1S9TFQW4LvGRejSCZGKtoqhEOoUgQupOCtSf6leBRU9HFZxjZDCR1Go+RhDKb7ooukf6
         nL15+IJLJrXyodV28b9blu1+yzIAtS5a1+5l0h1h+m6u80w6pH6aR8njLkWDMRTFfE1L
         dQyMnOqmZc85wREJhU89U7SrRKEjpz9fpgXf3VAxVB7JpjmVIb5ljm7LwAoSPxn7qKwK
         +9AA==
X-Received: by 10.152.87.42 with SMTP id u10mr20614653laz.0.1416835447278;
        Mon, 24 Nov 2014 05:24:07 -0800 (PST)
Received: from alex-desktop ([95.59.100.64])
        by mx.google.com with ESMTPSA id z2sm1583709lal.45.2014.11.24.05.24.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Nov 2014 05:24:06 -0800 (PST)
In-reply-to: <CAPc5daWnJCGPTMA0Hyg8QEAmsnF17ZQ9njGq8xVaUAfuwCRQDA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260125>


Now system_path returns path which is allocated string to callers;
It prevents memory leaks in some places. All callers of system_path
are owners of path string and they must release it.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 attr.c            |  8 +++---
 builtin/config.c  | 73 +++++++++++++++++++++++++++++++++++++++++--------------
 builtin/help.c    | 30 ++++++++++++++++-------
 builtin/init-db.c | 12 +++++++--
 cache.h           |  4 +--
 config.c          | 10 +++++---
 exec_cmd.c        | 22 ++++++++---------
 exec_cmd.h        |  4 +--
 git.c             | 16 +++++++++---
 wrapper.c         |  4 ++-
 10 files changed, 127 insertions(+), 56 deletions(-)

diff --git a/attr.c b/attr.c
index cd54697..f96ddb4 100644
--- a/attr.c
+++ b/attr.c
@@ -462,9 +462,9 @@ static void drop_attr_stack(void)
 	}
 }

-static const char *git_etc_gitattributes(void)
+static char *git_etc_gitattributes(void)
 {
-	static const char *system_wide;
+	static char *system_wide;
 	if (!system_wide)
 		system_wide = system_path(ETC_GITATTRIBUTES);
 	return system_wide;
@@ -489,7 +489,9 @@ static void bootstrap_attr_stack(void)
 	attr_stack = elem;

 	if (git_attr_system()) {
-		elem = read_attr_from_file(git_etc_gitattributes(), 1);
+		char *etc_attributes = git_etc_gitattributes();
+		elem = read_attr_from_file(etc_attributes, 1);
+		free(etc_attributes);
 		if (elem) {
 			elem->origin = NULL;
 			elem->prev = attr_stack;
diff --git a/builtin/config.c b/builtin/config.c
index 15a7bea..8ab3179 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -575,8 +575,14 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		if (given_config_source.blob)
 			die("editing blobs is not supported");
 		git_config(git_default_config, NULL);
-		config_file = xstrdup(given_config_source.file ?
-				      given_config_source.file : git_path("config"));
+
+		if (use_system_config)
+			config_file = given_config_source.file ?
+						  given_config_source.file : git_path("config");
+		else
+			config_file = xstrdup(given_config_source.file ?
+								  given_config_source.file : git_path("config"));
+
 		if (use_global_config) {
 			int fd = open(config_file, O_CREAT | O_EXCL | O_WRONLY, 0666);
 			if (fd) {
@@ -600,29 +606,43 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		if (ret == CONFIG_NOTHING_SET)
 			error("cannot overwrite multiple values with a single value\n"
 			"       Use a regexp, --add or --replace-all to change %s.", argv[0]);
+
+		if (use_system_config)
+			free(given_config_source.file);
 		return ret;
 	}
 	else if (actions == ACTION_SET_ALL) {
+		int ret;
 		check_write();
 		check_argc(argc, 2, 3);
 		value = normalize_value(argv[0], argv[1]);
-		return git_config_set_multivar_in_file(given_config_source.file,
-						       argv[0], value, argv[2], 0);
+		ret = git_config_set_multivar_in_file(given_config_source.file,
+											  argv[0], value, argv[2], 0);
+		if (use_system_config)
+			free(given_config_source.file);
+		return ret;
 	}
 	else if (actions == ACTION_ADD) {
+		int ret;
 		check_write();
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1]);
-		return git_config_set_multivar_in_file(given_config_source.file,
-						       argv[0], value,
-						       CONFIG_REGEX_NONE, 0);
+		ret = git_config_set_multivar_in_file(given_config_source.file, argv[0],
+											  value, CONFIG_REGEX_NONE, 0);
+		if (use_system_config)
+			free(given_config_source.file);
+		return ret;
 	}
 	else if (actions == ACTION_REPLACE_ALL) {
+		int ret;
 		check_write();
 		check_argc(argc, 2, 3);
 		value = normalize_value(argv[0], argv[1]);
-		return git_config_set_multivar_in_file(given_config_source.file,
-						       argv[0], value, argv[2], 1);
+		ret = git_config_set_multivar_in_file(given_config_source.file, argv[0],
+											  value, argv[2], 1);
+		if (use_system_config)
+			free(given_config_source.file);
+		return ret;
 	}
 	else if (actions == ACTION_GET) {
 		check_argc(argc, 1, 2);
@@ -645,27 +665,42 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		return get_urlmatch(argv[0], argv[1]);
 	}
 	else if (actions == ACTION_UNSET) {
+		int ret;
 		check_write();
 		check_argc(argc, 1, 2);
-		if (argc == 2)
-			return git_config_set_multivar_in_file(given_config_source.file,
-							       argv[0], NULL, argv[1], 0);
-		else
-			return git_config_set_in_file(given_config_source.file,
-						      argv[0], NULL);
+		if (argc == 2){
+			ret = git_config_set_multivar_in_file(given_config_source.file,
+												  argv[0], NULL, argv[1], 0);
+			if (use_system_config)
+				free(given_config_source.file);
+			return ret;
+		}
+		else{
+			ret = git_config_set_in_file(given_config_source.file,
+										 argv[0], NULL);
+			if (use_system_config)
+				free(given_config_source.file);
+			return ret;
+		}
 	}
 	else if (actions == ACTION_UNSET_ALL) {
+		int ret;
 		check_write();
 		check_argc(argc, 1, 2);
-		return git_config_set_multivar_in_file(given_config_source.file,
-						       argv[0], NULL, argv[1], 1);
+		ret = git_config_set_multivar_in_file(given_config_source.file,
+											  argv[0], NULL, argv[1], 1);
+		if (use_system_config)
+			free(given_config_source.file);
+		return ret;
 	}
 	else if (actions == ACTION_RENAME_SECTION) {
 		int ret;
 		check_write();
 		check_argc(argc, 2, 2);
 		ret = git_config_rename_section_in_file(given_config_source.file,
-							argv[0], argv[1]);
+												argv[0], argv[1]);
+		if (use_system_config)
+			free(given_config_source.file);
 		if (ret < 0)
 			return ret;
 		if (ret == 0)
@@ -677,6 +712,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_argc(argc, 1, 1);
 		ret = git_config_rename_section_in_file(given_config_source.file,
 							argv[0], NULL);
+		if (use_system_config)
+			free(given_config_source.file);
 		if (ret < 0)
 			return ret;
 		if (ret == 0)
diff --git a/builtin/help.c b/builtin/help.c
index b3c818e..20ffbb1 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -326,7 +326,8 @@ static void setup_man_path(void)
 	 * old_path, the ':' at the end will let 'man' to try
 	 * system-wide paths after ours to find the manual page. If
 	 * there is old_path, we need ':' as delimiter. */
-	strbuf_addstr(&new_path, system_path(GIT_MAN_PATH));
+	char *git_man_path = system_path(GIT_MAN_PATH);
+	strbuf_addstr(&new_path, git_man_path);
 	strbuf_addch(&new_path, ':');
 	if (old_path)
 		strbuf_addstr(&new_path, old_path);
@@ -334,6 +335,7 @@ static void setup_man_path(void)
 	setenv("MANPATH", new_path.buf, 1);

 	strbuf_release(&new_path);
+	free(git_man_path);
 }

 static void exec_viewer(const char *name, const char *page)
@@ -372,22 +374,25 @@ static void show_man_page(const char *git_cmd)
 static void show_info_page(const char *git_cmd)
 {
 	const char *page = cmd_to_page(git_cmd);
-	setenv("INFOPATH", system_path(GIT_INFO_PATH), 1);
+	char *git_info_path = system_path(GIT_INFO_PATH);
+	setenv("INFOPATH", git_info_path, 1);
+	free(git_info_path);
 	execlp("info", "info", "gitman", page, (char *)NULL);
 	die(_("no info viewer handled the request"));
 }

-static void get_html_page_path(struct strbuf *page_path, const char *page)
+static void get_html_page_path(struct strbuf *page_path, const char *page, char *html_path)
 {
 	struct stat st;
-	if (!html_path)
-		html_path = system_path(GIT_HTML_PATH);

 	/* Check that we have a git documentation directory. */
 	if (!strstr(html_path, "://")) {
 		if (stat(mkpath("%s/git.html", html_path), &st)
-		    || !S_ISREG(st.st_mode))
-			die("'%s': not a documentation directory.", html_path);
+				|| !S_ISREG(st.st_mode)){
+			printf("'%s': not a documentation directory.\n", html_path);
+			free(html_path);
+			exit(1);
+		}
 	}

 	strbuf_init(page_path, 0);
@@ -400,9 +405,10 @@ static void get_html_page_path(struct strbuf *page_path, const char *page)
  * HTML.
  */
 #ifndef open_html
-static void open_html(const char *path)
+static void open_html(char *path)
 {
 	execl_git_cmd("web--browse", "-c", "help.browser", path, (char *)NULL);
+	free(path);
 }
 #endif

@@ -410,8 +416,12 @@ static void show_html_page(const char *git_cmd)
 {
 	const char *page = cmd_to_page(git_cmd);
 	struct strbuf page_path; /* it leaks but we exec bellow */
+	char* html_path = NULL;
+
+	if (!html_path)
+		html_path = system_path(GIT_HTML_PATH);

-	get_html_page_path(&page_path, page);
+	get_html_page_path(&page_path, page, html_path);

 	open_html(page_path.buf);
 }
@@ -512,3 +522,5 @@ int cmd_help(int argc, const char **argv, const char *prefix)

 	return 0;
 }
+
+// git help --web commit
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 2619ca5..6f36f3f 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -126,11 +126,17 @@ static void copy_templates(const char *template_dir)
 		template_dir = init_db_template_dir;
 	if (!template_dir)
 		template_dir = system_path(DEFAULT_GIT_TEMPLATE_DIR);
-	if (!template_dir[0])
+	if (!template_dir[0]){
+		if (!template_dir)
+			free((char*)template_dir);
 		return;
+	}
 	template_len = strlen(template_dir);
-	if (PATH_MAX <= (template_len+strlen("/config")))
+	if (PATH_MAX <= (template_len+strlen("/config"))){
+		if (!template_dir)
+			free((char*)template_dir);
 		die(_("insanely long template path %s"), template_dir);
+	}
 	strcpy(template_path, template_dir);
 	if (template_path[template_len-1] != '/') {
 		template_path[template_len++] = '/';
@@ -139,6 +145,7 @@ static void copy_templates(const char *template_dir)
 	dir = opendir(template_path);
 	if (!dir) {
 		warning(_("templates not found %s"), template_dir);
+		free((char*)template_dir);
 		return;
 	}

@@ -155,6 +162,7 @@ static void copy_templates(const char *template_dir)
 			"a wrong format version %d from '%s'"),
 			repository_format_version,
 			template_dir);
+		free((char*)template_dir);
 		closedir(dir);
 		return;
 	}
diff --git a/cache.h b/cache.h
index 1b05115..7048e7a 100644
--- a/cache.h
+++ b/cache.h
@@ -1354,7 +1354,7 @@ extern int update_server_info(int);

 struct git_config_source {
 	unsigned int use_stdin:1;
-	const char *file;
+	char *file;
 	const char *blob;
 };

@@ -1386,7 +1386,7 @@ extern int git_config_set_multivar(const char *, const char *, const char *, int
 extern int git_config_set_multivar_in_file(const char *, const char *, const char *, const char *, int);
 extern int git_config_rename_section(const char *, const char *);
 extern int git_config_rename_section_in_file(const char *, const char *, const char *);
-extern const char *git_etc_gitconfig(void);
+extern char *git_etc_gitconfig(void);
 extern int check_repository_format_version(const char *var, const char *value, void *cb);
 extern int git_env_bool(const char *, int);
 extern unsigned long git_env_ulong(const char *, unsigned long);
diff --git a/config.c b/config.c
index ae1398f..0ed8890 100644
--- a/config.c
+++ b/config.c
@@ -1132,9 +1132,9 @@ static int git_config_from_blob_ref(config_fn_t fn,
 	return git_config_from_blob_sha1(fn, name, sha1, data);
 }

-const char *git_etc_gitconfig(void)
+char *git_etc_gitconfig(void)
 {
-	static const char *system_wide;
+	static char *system_wide;
 	if (!system_wide)
 		system_wide = system_path(ETC_GITCONFIG);
 	return system_wide;
@@ -1172,13 +1172,15 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 	int ret = 0, found = 0;
 	char *xdg_config = NULL;
 	char *user_config = NULL;
+	char *git_etc_config = git_etc_gitconfig();

 	home_config_paths(&user_config, &xdg_config, "config");

-	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0)) {
-		ret += git_config_from_file(fn, git_etc_gitconfig(),
+	if (git_etc_config && !access_or_die(git_etc_config, R_OK, 0)) {
+		ret += git_config_from_file(fn, git_etc_config,
 					    data);
 		found += 1;
+		free(git_etc_config);
 	}

 	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK)) {
diff --git a/exec_cmd.c b/exec_cmd.c
index 698e752..d35ecac 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -6,7 +6,7 @@
 static const char *argv_exec_path;
 static const char *argv0_path;

-const char *system_path(const char *path)
+char *system_path(const char *path)
 {
 #ifdef RUNTIME_PREFIX
 	static const char *prefix;
@@ -16,7 +16,7 @@ const char *system_path(const char *path)
 	struct strbuf d = STRBUF_INIT;

 	if (is_absolute_path(path))
-		return path;
+		return strdup(path);

 #ifdef RUNTIME_PREFIX
 	assert(argv0_path);
@@ -34,8 +34,7 @@ const char *system_path(const char *path)
 #endif

 	strbuf_addf(&d, "%s/%s", prefix, path);
-	path = strbuf_detach(&d, NULL);
-	return path;
+	return d.buf;
 }

 const char *git_extract_argv0_path(const char *argv0)
@@ -68,17 +67,16 @@ void git_set_argv_exec_path(const char *exec_path)


 /* Returns the highest-priority, location to look for git programs. */
-const char *git_exec_path(void)
+char *git_exec_path(void)
 {
-	const char *env;
+	char *env;

 	if (argv_exec_path)
-		return argv_exec_path;
+		return strdup(argv_exec_path);

 	env = getenv(EXEC_PATH_ENVIRONMENT);
-	if (env && *env) {
-		return env;
-	}
+	if (env && *env)
+		return strdup(env);

 	return system_path(GIT_EXEC_PATH);
 }
@@ -96,7 +94,8 @@ void setup_path(void)
 	const char *old_path = getenv("PATH");
 	struct strbuf new_path = STRBUF_INIT;

-	add_path(&new_path, git_exec_path());
+	char *exec_path = git_exec_path();
+	add_path(&new_path, exec_path);
 	add_path(&new_path, argv0_path);

 	if (old_path)
@@ -107,6 +106,7 @@ void setup_path(void)
 	setenv("PATH", new_path.buf, 1);

 	strbuf_release(&new_path);
+	free(exec_path);
 }

 const char **prepare_git_cmd(const char **argv)
diff --git a/exec_cmd.h b/exec_cmd.h
index e4c9702..03c8599 100644
--- a/exec_cmd.h
+++ b/exec_cmd.h
@@ -3,12 +3,12 @@

 extern void git_set_argv_exec_path(const char *exec_path);
 extern const char *git_extract_argv0_path(const char *path);
-extern const char *git_exec_path(void);
+extern char *git_exec_path(void);
 extern void setup_path(void);
 extern const char **prepare_git_cmd(const char **argv);
 extern int execv_git_cmd(const char **argv); /* NULL terminated */
 LAST_ARG_MUST_BE_NULL
 extern int execl_git_cmd(const char *cmd, ...);
-extern const char *system_path(const char *path);
+extern char *system_path(const char *path);

 #endif /* GIT_EXEC_CMD_H */
diff --git a/git.c b/git.c
index 82d7a1c..d01c4f1 100644
--- a/git.c
+++ b/git.c
@@ -95,17 +95,25 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			if (*cmd == '=')
 				git_set_argv_exec_path(cmd + 1);
 			else {
-				puts(git_exec_path());
+				char *exec_path = git_exec_path();
+				puts(exec_path);
+				free(exec_path);
 				exit(0);
 			}
 		} else if (!strcmp(cmd, "--html-path")) {
-			puts(system_path(GIT_HTML_PATH));
+			char *git_html_path = system_path(GIT_HTML_PATH);
+			puts(git_html_path);
+			free(git_html_path);
 			exit(0);
 		} else if (!strcmp(cmd, "--man-path")) {
-			puts(system_path(GIT_MAN_PATH));
+			char *git_man_path = system_path(GIT_MAN_PATH);
+			puts(git_man_path);
+			free(git_man_path);
 			exit(0);
 		} else if (!strcmp(cmd, "--info-path")) {
-			puts(system_path(GIT_INFO_PATH));
+			char *git_info_path = system_path(GIT_INFO_PATH);
+			puts(git_info_path);
+			free(git_info_path);
 			exit(0);
 		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
 			use_pager = 1;
diff --git a/wrapper.c b/wrapper.c
index 007ec0d..ede9268 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -526,8 +526,10 @@ int access_or_warn(const char *path, int mode, unsigned flag)
 int access_or_die(const char *path, int mode, unsigned flag)
 {
 	int ret = access(path, mode);
-	if (ret && !access_error_is_ok(errno, flag))
+	if (ret && !access_error_is_ok(errno, flag)){
+		free((char*)path);
 		die_errno(_("unable to access '%s'"), path);
+	}
 	return ret;
 }

--
2.2.0-rc3
