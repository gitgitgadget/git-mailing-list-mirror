From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Builtin git-help.
Date: Sat,  2 Aug 2008 10:08:38 +0200
Message-ID: <1217664518-17047-1-git-send-email-vmiklos@frugalware.org>
References: <20080801144121.GU32057@genesis.frugalware.org>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 10:09:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPCB6-000305-2h
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 10:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbYHBIIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 04:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752215AbYHBIIP
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 04:08:15 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:59520 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201AbYHBIIK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 04:08:10 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 257FF1DDC5B;
	Sat,  2 Aug 2008 10:08:07 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 54FBC1AA738; Sat,  2 Aug 2008 10:08:38 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <20080801144121.GU32057@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91137>

This patch splits out git-help's functions to builtin-help.c and leaves
only functions used by other builtins in help.c.

First this removes git-help's functions from libgit which are not
interesting for other builtins, second this makes 'git help help' work
again.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

This is for 'next'.

 Makefile       |    3 +-
 builtin-help.c |  462 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 help.c         |  464 --------------------------------------------------------
 help.h         |    6 +
 4 files changed, 470 insertions(+), 465 deletions(-)
 create mode 100644 builtin-help.c

diff --git a/Makefile b/Makefile
index 8431ffd..562e453 100644
--- a/Makefile
+++ b/Makefile
@@ -519,6 +519,7 @@ BUILTIN_OBJS += builtin-for-each-ref.o
 BUILTIN_OBJS += builtin-fsck.o
 BUILTIN_OBJS += builtin-gc.o
 BUILTIN_OBJS += builtin-grep.o
+BUILTIN_OBJS += builtin-help.o
 BUILTIN_OBJS += builtin-init-db.o
 BUILTIN_OBJS += builtin-log.o
 BUILTIN_OBJS += builtin-ls-files.o
@@ -1090,7 +1091,7 @@ git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
 
-help.o: help.c common-cmds.h GIT-CFLAGS
+builtin-help.o: builtin-help.c common-cmds.h GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) \
 		'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
 		'-DGIT_MAN_PATH="$(mandir_SQ)"' \
diff --git a/builtin-help.c b/builtin-help.c
new file mode 100644
index 0000000..391f749
--- /dev/null
+++ b/builtin-help.c
@@ -0,0 +1,462 @@
+/*
+ * builtin-help.c
+ *
+ * Builtin help command
+ */
+#include "cache.h"
+#include "builtin.h"
+#include "exec_cmd.h"
+#include "common-cmds.h"
+#include "parse-options.h"
+#include "run-command.h"
+#include "help.h"
+
+static struct man_viewer_list {
+	struct man_viewer_list *next;
+	char name[FLEX_ARRAY];
+} *man_viewer_list;
+
+static struct man_viewer_info_list {
+	struct man_viewer_info_list *next;
+	const char *info;
+	char name[FLEX_ARRAY];
+} *man_viewer_info_list;
+
+enum help_format {
+	HELP_FORMAT_MAN,
+	HELP_FORMAT_INFO,
+	HELP_FORMAT_WEB,
+};
+
+static int show_all = 0;
+static enum help_format help_format = HELP_FORMAT_MAN;
+static struct option builtin_help_options[] = {
+	OPT_BOOLEAN('a', "all", &show_all, "print all available commands"),
+	OPT_SET_INT('m', "man", &help_format, "show man page", HELP_FORMAT_MAN),
+	OPT_SET_INT('w', "web", &help_format, "show manual in web browser",
+			HELP_FORMAT_WEB),
+	OPT_SET_INT('i', "info", &help_format, "show info page",
+			HELP_FORMAT_INFO),
+	OPT_END(),
+};
+
+static const char * const builtin_help_usage[] = {
+	"git help [--all] [--man|--web|--info] [command]",
+	NULL
+};
+
+static enum help_format parse_help_format(const char *format)
+{
+	if (!strcmp(format, "man"))
+		return HELP_FORMAT_MAN;
+	if (!strcmp(format, "info"))
+		return HELP_FORMAT_INFO;
+	if (!strcmp(format, "web") || !strcmp(format, "html"))
+		return HELP_FORMAT_WEB;
+	die("unrecognized help format '%s'", format);
+}
+
+static const char *get_man_viewer_info(const char *name)
+{
+	struct man_viewer_info_list *viewer;
+
+	for (viewer = man_viewer_info_list; viewer; viewer = viewer->next)
+	{
+		if (!strcasecmp(name, viewer->name))
+			return viewer->info;
+	}
+	return NULL;
+}
+
+static int check_emacsclient_version(void)
+{
+	struct strbuf buffer = STRBUF_INIT;
+	struct child_process ec_process;
+	const char *argv_ec[] = { "emacsclient", "--version", NULL };
+	int version;
+
+	/* emacsclient prints its version number on stderr */
+	memset(&ec_process, 0, sizeof(ec_process));
+	ec_process.argv = argv_ec;
+	ec_process.err = -1;
+	ec_process.stdout_to_stderr = 1;
+	if (start_command(&ec_process)) {
+		fprintf(stderr, "Failed to start emacsclient.\n");
+		return -1;
+	}
+	strbuf_read(&buffer, ec_process.err, 20);
+	close(ec_process.err);
+
+	/*
+	 * Don't bother checking return value, because "emacsclient --version"
+	 * seems to always exits with code 1.
+	 */
+	finish_command(&ec_process);
+
+	if (prefixcmp(buffer.buf, "emacsclient")) {
+		fprintf(stderr, "Failed to parse emacsclient version.\n");
+		strbuf_release(&buffer);
+		return -1;
+	}
+
+	strbuf_remove(&buffer, 0, strlen("emacsclient"));
+	version = atoi(buffer.buf);
+
+	if (version < 22) {
+		fprintf(stderr,
+			"emacsclient version '%d' too old (< 22).\n",
+			version);
+		strbuf_release(&buffer);
+		return -1;
+	}
+
+	strbuf_release(&buffer);
+	return 0;
+}
+
+static void exec_woman_emacs(const char* path, const char *page)
+{
+	if (!check_emacsclient_version()) {
+		/* This works only with emacsclient version >= 22. */
+		struct strbuf man_page = STRBUF_INIT;
+
+		if (!path)
+			path = "emacsclient";
+		strbuf_addf(&man_page, "(woman \"%s\")", page);
+		execlp(path, "emacsclient", "-e", man_page.buf, NULL);
+		warning("failed to exec '%s': %s", path, strerror(errno));
+	}
+}
+
+static void exec_man_konqueror(const char* path, const char *page)
+{
+	const char *display = getenv("DISPLAY");
+	if (display && *display) {
+		struct strbuf man_page = STRBUF_INIT;
+		const char *filename = "kfmclient";
+
+		/* It's simpler to launch konqueror using kfmclient. */
+		if (path) {
+			const char *file = strrchr(path, '/');
+			if (file && !strcmp(file + 1, "konqueror")) {
+				char *new = xstrdup(path);
+				char *dest = strrchr(new, '/');
+
+				/* strlen("konqueror") == strlen("kfmclient") */
+				strcpy(dest + 1, "kfmclient");
+				path = new;
+			}
+			if (file)
+				filename = file;
+		} else
+			path = "kfmclient";
+		strbuf_addf(&man_page, "man:%s(1)", page);
+		execlp(path, filename, "newTab", man_page.buf, NULL);
+		warning("failed to exec '%s': %s", path, strerror(errno));
+	}
+}
+
+static void exec_man_man(const char* path, const char *page)
+{
+	if (!path)
+		path = "man";
+	execlp(path, "man", page, NULL);
+	warning("failed to exec '%s': %s", path, strerror(errno));
+}
+
+static void exec_man_cmd(const char *cmd, const char *page)
+{
+	struct strbuf shell_cmd = STRBUF_INIT;
+	strbuf_addf(&shell_cmd, "%s %s", cmd, page);
+	execl("/bin/sh", "sh", "-c", shell_cmd.buf, NULL);
+	warning("failed to exec '%s': %s", cmd, strerror(errno));
+}
+
+static void add_man_viewer(const char *name)
+{
+	struct man_viewer_list **p = &man_viewer_list;
+	size_t len = strlen(name);
+
+	while (*p)
+		p = &((*p)->next);
+	*p = xcalloc(1, (sizeof(**p) + len + 1));
+	strncpy((*p)->name, name, len);
+}
+
+static int supported_man_viewer(const char *name, size_t len)
+{
+	return (!strncasecmp("man", name, len) ||
+		!strncasecmp("woman", name, len) ||
+		!strncasecmp("konqueror", name, len));
+}
+
+static void do_add_man_viewer_info(const char *name,
+				   size_t len,
+				   const char *value)
+{
+	struct man_viewer_info_list *new = xcalloc(1, sizeof(*new) + len + 1);
+
+	strncpy(new->name, name, len);
+	new->info = xstrdup(value);
+	new->next = man_viewer_info_list;
+	man_viewer_info_list = new;
+}
+
+static int add_man_viewer_path(const char *name,
+			       size_t len,
+			       const char *value)
+{
+	if (supported_man_viewer(name, len))
+		do_add_man_viewer_info(name, len, value);
+	else
+		warning("'%s': path for unsupported man viewer.\n"
+			"Please consider using 'man.<tool>.cmd' instead.",
+			name);
+
+	return 0;
+}
+
+static int add_man_viewer_cmd(const char *name,
+			      size_t len,
+			      const char *value)
+{
+	if (supported_man_viewer(name, len))
+		warning("'%s': cmd for supported man viewer.\n"
+			"Please consider using 'man.<tool>.path' instead.",
+			name);
+	else
+		do_add_man_viewer_info(name, len, value);
+
+	return 0;
+}
+
+static int add_man_viewer_info(const char *var, const char *value)
+{
+	const char *name = var + 4;
+	const char *subkey = strrchr(name, '.');
+
+	if (!subkey)
+		return error("Config with no key for man viewer: %s", name);
+
+	if (!strcmp(subkey, ".path")) {
+		if (!value)
+			return config_error_nonbool(var);
+		return add_man_viewer_path(name, subkey - name, value);
+	}
+	if (!strcmp(subkey, ".cmd")) {
+		if (!value)
+			return config_error_nonbool(var);
+		return add_man_viewer_cmd(name, subkey - name, value);
+	}
+
+	warning("'%s': unsupported man viewer sub key.", subkey);
+	return 0;
+}
+
+static int git_help_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "help.format")) {
+		if (!value)
+			return config_error_nonbool(var);
+		help_format = parse_help_format(value);
+		return 0;
+	}
+	if (!strcmp(var, "man.viewer")) {
+		if (!value)
+			return config_error_nonbool(var);
+		add_man_viewer(value);
+		return 0;
+	}
+	if (!prefixcmp(var, "man."))
+		return add_man_viewer_info(var, value);
+
+	return git_default_config(var, value, cb);
+}
+
+struct cmdnames main_cmds, other_cmds;
+
+void list_common_cmds_help(void)
+{
+	int i, longest = 0;
+
+	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
+		if (longest < strlen(common_cmds[i].name))
+			longest = strlen(common_cmds[i].name);
+	}
+
+	puts("The most commonly used git commands are:");
+	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
+		printf("   %s   ", common_cmds[i].name);
+		mput_char(' ', longest - strlen(common_cmds[i].name));
+		puts(common_cmds[i].help);
+	}
+}
+
+static int is_git_command(const char *s)
+{
+	return is_in_cmdlist(&main_cmds, s) ||
+		is_in_cmdlist(&other_cmds, s);
+}
+
+static const char *prepend(const char *prefix, const char *cmd)
+{
+	size_t pre_len = strlen(prefix);
+	size_t cmd_len = strlen(cmd);
+	char *p = xmalloc(pre_len + cmd_len + 1);
+	memcpy(p, prefix, pre_len);
+	strcpy(p + pre_len, cmd);
+	return p;
+}
+
+static const char *cmd_to_page(const char *git_cmd)
+{
+	if (!git_cmd)
+		return "git";
+	else if (!prefixcmp(git_cmd, "git"))
+		return git_cmd;
+	else if (is_git_command(git_cmd))
+		return prepend("git-", git_cmd);
+	else
+		return prepend("git", git_cmd);
+}
+
+static void setup_man_path(void)
+{
+	struct strbuf new_path;
+	const char *old_path = getenv("MANPATH");
+
+	strbuf_init(&new_path, 0);
+
+	/* We should always put ':' after our path. If there is no
+	 * old_path, the ':' at the end will let 'man' to try
+	 * system-wide paths after ours to find the manual page. If
+	 * there is old_path, we need ':' as delimiter. */
+	strbuf_addstr(&new_path, GIT_MAN_PATH);
+	strbuf_addch(&new_path, ':');
+	if (old_path)
+		strbuf_addstr(&new_path, old_path);
+
+	setenv("MANPATH", new_path.buf, 1);
+
+	strbuf_release(&new_path);
+}
+
+static void exec_viewer(const char *name, const char *page)
+{
+	const char *info = get_man_viewer_info(name);
+
+	if (!strcasecmp(name, "man"))
+		exec_man_man(info, page);
+	else if (!strcasecmp(name, "woman"))
+		exec_woman_emacs(info, page);
+	else if (!strcasecmp(name, "konqueror"))
+		exec_man_konqueror(info, page);
+	else if (info)
+		exec_man_cmd(info, page);
+	else
+		warning("'%s': unknown man viewer.", name);
+}
+
+static void show_man_page(const char *git_cmd)
+{
+	struct man_viewer_list *viewer;
+	const char *page = cmd_to_page(git_cmd);
+
+	setup_man_path();
+	for (viewer = man_viewer_list; viewer; viewer = viewer->next)
+	{
+		exec_viewer(viewer->name, page); /* will return when unable */
+	}
+	exec_viewer("man", page);
+	die("no man viewer handled the request");
+}
+
+static void show_info_page(const char *git_cmd)
+{
+	const char *page = cmd_to_page(git_cmd);
+	setenv("INFOPATH", GIT_INFO_PATH, 1);
+	execlp("info", "info", "gitman", page, NULL);
+}
+
+static void get_html_page_path(struct strbuf *page_path, const char *page)
+{
+	struct stat st;
+	const char *html_path = system_path(GIT_HTML_PATH);
+
+	/* Check that we have a git documentation directory. */
+	if (stat(mkpath("%s/git.html", html_path), &st)
+	    || !S_ISREG(st.st_mode))
+		die("'%s': not a documentation directory.", html_path);
+
+	strbuf_init(page_path, 0);
+	strbuf_addf(page_path, "%s/%s.html", html_path, page);
+}
+
+/*
+ * If open_html is not defined in a platform-specific way (see for
+ * example compat/mingw.h), we use the script web--browse to display
+ * HTML.
+ */
+#ifndef open_html
+void open_html(const char *path)
+{
+	execl_git_cmd("web--browse", "-c", "help.browser", path, NULL);
+}
+#endif
+
+static void show_html_page(const char *git_cmd)
+{
+	const char *page = cmd_to_page(git_cmd);
+	struct strbuf page_path; /* it leaks but we exec bellow */
+
+	get_html_page_path(&page_path, page);
+
+	open_html(page_path.buf);
+}
+
+int cmd_help(int argc, const char **argv, const char *prefix)
+{
+	int nongit;
+	const char *alias;
+	unsigned int longest = load_command_list("git-", &main_cmds, &other_cmds);
+
+	setup_git_directory_gently(&nongit);
+	git_config(git_help_config, NULL);
+
+	argc = parse_options(argc, argv, builtin_help_options,
+			builtin_help_usage, 0);
+
+	if (show_all) {
+		printf("usage: %s\n\n", git_usage_string);
+		list_commands("git commands", longest, &main_cmds, &other_cmds);
+		printf("%s\n", git_more_info_string);
+		return 0;
+	}
+
+	if (!argv[0]) {
+		printf("usage: %s\n\n", git_usage_string);
+		list_common_cmds_help();
+		printf("\n%s\n", git_more_info_string);
+		return 0;
+	}
+
+	alias = alias_lookup(argv[0]);
+	if (alias && !is_git_command(argv[0])) {
+		printf("`git %s' is aliased to `%s'\n", argv[0], alias);
+		return 0;
+	}
+
+	switch (help_format) {
+	case HELP_FORMAT_MAN:
+		show_man_page(argv[0]);
+		break;
+	case HELP_FORMAT_INFO:
+		show_info_page(argv[0]);
+		break;
+	case HELP_FORMAT_WEB:
+		show_html_page(argv[0]);
+		break;
+	}
+
+	return 0;
+}
diff --git a/help.c b/help.c
index 968f368..1afbac0 100644
--- a/help.c
+++ b/help.c
@@ -1,278 +1,8 @@
-/*
- * builtin-help.c
- *
- * Builtin help-related commands (help, usage, version)
- */
 #include "cache.h"
 #include "builtin.h"
 #include "exec_cmd.h"
-#include "common-cmds.h"
-#include "parse-options.h"
-#include "run-command.h"
 #include "help.h"
 
-static struct man_viewer_list {
-	struct man_viewer_list *next;
-	char name[FLEX_ARRAY];
-} *man_viewer_list;
-
-static struct man_viewer_info_list {
-	struct man_viewer_info_list *next;
-	const char *info;
-	char name[FLEX_ARRAY];
-} *man_viewer_info_list;
-
-enum help_format {
-	HELP_FORMAT_MAN,
-	HELP_FORMAT_INFO,
-	HELP_FORMAT_WEB,
-};
-
-static int show_all = 0;
-static enum help_format help_format = HELP_FORMAT_MAN;
-static struct option builtin_help_options[] = {
-	OPT_BOOLEAN('a', "all", &show_all, "print all available commands"),
-	OPT_SET_INT('m', "man", &help_format, "show man page", HELP_FORMAT_MAN),
-	OPT_SET_INT('w', "web", &help_format, "show manual in web browser",
-			HELP_FORMAT_WEB),
-	OPT_SET_INT('i', "info", &help_format, "show info page",
-			HELP_FORMAT_INFO),
-	OPT_END(),
-};
-
-static const char * const builtin_help_usage[] = {
-	"git help [--all] [--man|--web|--info] [command]",
-	NULL
-};
-
-static enum help_format parse_help_format(const char *format)
-{
-	if (!strcmp(format, "man"))
-		return HELP_FORMAT_MAN;
-	if (!strcmp(format, "info"))
-		return HELP_FORMAT_INFO;
-	if (!strcmp(format, "web") || !strcmp(format, "html"))
-		return HELP_FORMAT_WEB;
-	die("unrecognized help format '%s'", format);
-}
-
-static const char *get_man_viewer_info(const char *name)
-{
-	struct man_viewer_info_list *viewer;
-
-	for (viewer = man_viewer_info_list; viewer; viewer = viewer->next)
-	{
-		if (!strcasecmp(name, viewer->name))
-			return viewer->info;
-	}
-	return NULL;
-}
-
-static int check_emacsclient_version(void)
-{
-	struct strbuf buffer = STRBUF_INIT;
-	struct child_process ec_process;
-	const char *argv_ec[] = { "emacsclient", "--version", NULL };
-	int version;
-
-	/* emacsclient prints its version number on stderr */
-	memset(&ec_process, 0, sizeof(ec_process));
-	ec_process.argv = argv_ec;
-	ec_process.err = -1;
-	ec_process.stdout_to_stderr = 1;
-	if (start_command(&ec_process)) {
-		fprintf(stderr, "Failed to start emacsclient.\n");
-		return -1;
-	}
-	strbuf_read(&buffer, ec_process.err, 20);
-	close(ec_process.err);
-
-	/*
-	 * Don't bother checking return value, because "emacsclient --version"
-	 * seems to always exits with code 1.
-	 */
-	finish_command(&ec_process);
-
-	if (prefixcmp(buffer.buf, "emacsclient")) {
-		fprintf(stderr, "Failed to parse emacsclient version.\n");
-		strbuf_release(&buffer);
-		return -1;
-	}
-
-	strbuf_remove(&buffer, 0, strlen("emacsclient"));
-	version = atoi(buffer.buf);
-
-	if (version < 22) {
-		fprintf(stderr,
-			"emacsclient version '%d' too old (< 22).\n",
-			version);
-		strbuf_release(&buffer);
-		return -1;
-	}
-
-	strbuf_release(&buffer);
-	return 0;
-}
-
-static void exec_woman_emacs(const char* path, const char *page)
-{
-	if (!check_emacsclient_version()) {
-		/* This works only with emacsclient version >= 22. */
-		struct strbuf man_page = STRBUF_INIT;
-
-		if (!path)
-			path = "emacsclient";
-		strbuf_addf(&man_page, "(woman \"%s\")", page);
-		execlp(path, "emacsclient", "-e", man_page.buf, NULL);
-		warning("failed to exec '%s': %s", path, strerror(errno));
-	}
-}
-
-static void exec_man_konqueror(const char* path, const char *page)
-{
-	const char *display = getenv("DISPLAY");
-	if (display && *display) {
-		struct strbuf man_page = STRBUF_INIT;
-		const char *filename = "kfmclient";
-
-		/* It's simpler to launch konqueror using kfmclient. */
-		if (path) {
-			const char *file = strrchr(path, '/');
-			if (file && !strcmp(file + 1, "konqueror")) {
-				char *new = xstrdup(path);
-				char *dest = strrchr(new, '/');
-
-				/* strlen("konqueror") == strlen("kfmclient") */
-				strcpy(dest + 1, "kfmclient");
-				path = new;
-			}
-			if (file)
-				filename = file;
-		} else
-			path = "kfmclient";
-		strbuf_addf(&man_page, "man:%s(1)", page);
-		execlp(path, filename, "newTab", man_page.buf, NULL);
-		warning("failed to exec '%s': %s", path, strerror(errno));
-	}
-}
-
-static void exec_man_man(const char* path, const char *page)
-{
-	if (!path)
-		path = "man";
-	execlp(path, "man", page, NULL);
-	warning("failed to exec '%s': %s", path, strerror(errno));
-}
-
-static void exec_man_cmd(const char *cmd, const char *page)
-{
-	struct strbuf shell_cmd = STRBUF_INIT;
-	strbuf_addf(&shell_cmd, "%s %s", cmd, page);
-	execl("/bin/sh", "sh", "-c", shell_cmd.buf, NULL);
-	warning("failed to exec '%s': %s", cmd, strerror(errno));
-}
-
-static void add_man_viewer(const char *name)
-{
-	struct man_viewer_list **p = &man_viewer_list;
-	size_t len = strlen(name);
-
-	while (*p)
-		p = &((*p)->next);
-	*p = xcalloc(1, (sizeof(**p) + len + 1));
-	strncpy((*p)->name, name, len);
-}
-
-static int supported_man_viewer(const char *name, size_t len)
-{
-	return (!strncasecmp("man", name, len) ||
-		!strncasecmp("woman", name, len) ||
-		!strncasecmp("konqueror", name, len));
-}
-
-static void do_add_man_viewer_info(const char *name,
-				   size_t len,
-				   const char *value)
-{
-	struct man_viewer_info_list *new = xcalloc(1, sizeof(*new) + len + 1);
-
-	strncpy(new->name, name, len);
-	new->info = xstrdup(value);
-	new->next = man_viewer_info_list;
-	man_viewer_info_list = new;
-}
-
-static int add_man_viewer_path(const char *name,
-			       size_t len,
-			       const char *value)
-{
-	if (supported_man_viewer(name, len))
-		do_add_man_viewer_info(name, len, value);
-	else
-		warning("'%s': path for unsupported man viewer.\n"
-			"Please consider using 'man.<tool>.cmd' instead.",
-			name);
-
-	return 0;
-}
-
-static int add_man_viewer_cmd(const char *name,
-			      size_t len,
-			      const char *value)
-{
-	if (supported_man_viewer(name, len))
-		warning("'%s': cmd for supported man viewer.\n"
-			"Please consider using 'man.<tool>.path' instead.",
-			name);
-	else
-		do_add_man_viewer_info(name, len, value);
-
-	return 0;
-}
-
-static int add_man_viewer_info(const char *var, const char *value)
-{
-	const char *name = var + 4;
-	const char *subkey = strrchr(name, '.');
-
-	if (!subkey)
-		return error("Config with no key for man viewer: %s", name);
-
-	if (!strcmp(subkey, ".path")) {
-		if (!value)
-			return config_error_nonbool(var);
-		return add_man_viewer_path(name, subkey - name, value);
-	}
-	if (!strcmp(subkey, ".cmd")) {
-		if (!value)
-			return config_error_nonbool(var);
-		return add_man_viewer_cmd(name, subkey - name, value);
-	}
-
-	warning("'%s': unsupported man viewer sub key.", subkey);
-	return 0;
-}
-
-static int git_help_config(const char *var, const char *value, void *cb)
-{
-	if (!strcmp(var, "help.format")) {
-		if (!value)
-			return config_error_nonbool(var);
-		help_format = parse_help_format(value);
-		return 0;
-	}
-	if (!strcmp(var, "man.viewer")) {
-		if (!value)
-			return config_error_nonbool(var);
-		add_man_viewer(value);
-		return 0;
-	}
-	if (!prefixcmp(var, "man."))
-		return add_man_viewer_info(var, value);
-
-	return git_default_config(var, value, cb);
-}
-
 /* most GUI terminals set COLUMNS (although some don't export it) */
 static int term_columns(void)
 {
@@ -295,14 +25,6 @@ static int term_columns(void)
 	return 80;
 }
 
-static inline void mput_char(char c, unsigned int num)
-{
-	while(num--)
-		putchar(c);
-}
-
-struct cmdnames main_cmds, other_cmds;
-
 void add_cmdname(struct cmdnames *cmds, const char *name, int len)
 {
 	struct cmdname *ent = xmalloc(sizeof(*ent) + len + 1);
@@ -526,23 +248,6 @@ void list_commands(const char *title, unsigned int longest,
 	}
 }
 
-void list_common_cmds_help(void)
-{
-	int i, longest = 0;
-
-	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
-		if (longest < strlen(common_cmds[i].name))
-			longest = strlen(common_cmds[i].name);
-	}
-
-	puts("The most commonly used git commands are:");
-	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
-		printf("   %s   ", common_cmds[i].name);
-		mput_char(' ', longest - strlen(common_cmds[i].name));
-		puts(common_cmds[i].help);
-	}
-}
-
 int is_in_cmdlist(struct cmdnames *c, const char *s)
 {
 	int i;
@@ -552,128 +257,6 @@ int is_in_cmdlist(struct cmdnames *c, const char *s)
 	return 0;
 }
 
-static int is_git_command(const char *s)
-{
-	return is_in_cmdlist(&main_cmds, s) ||
-		is_in_cmdlist(&other_cmds, s);
-}
-
-static const char *prepend(const char *prefix, const char *cmd)
-{
-	size_t pre_len = strlen(prefix);
-	size_t cmd_len = strlen(cmd);
-	char *p = xmalloc(pre_len + cmd_len + 1);
-	memcpy(p, prefix, pre_len);
-	strcpy(p + pre_len, cmd);
-	return p;
-}
-
-static const char *cmd_to_page(const char *git_cmd)
-{
-	if (!git_cmd)
-		return "git";
-	else if (!prefixcmp(git_cmd, "git"))
-		return git_cmd;
-	else if (is_git_command(git_cmd))
-		return prepend("git-", git_cmd);
-	else
-		return prepend("git", git_cmd);
-}
-
-static void setup_man_path(void)
-{
-	struct strbuf new_path;
-	const char *old_path = getenv("MANPATH");
-
-	strbuf_init(&new_path, 0);
-
-	/* We should always put ':' after our path. If there is no
-	 * old_path, the ':' at the end will let 'man' to try
-	 * system-wide paths after ours to find the manual page. If
-	 * there is old_path, we need ':' as delimiter. */
-	strbuf_addstr(&new_path, GIT_MAN_PATH);
-	strbuf_addch(&new_path, ':');
-	if (old_path)
-		strbuf_addstr(&new_path, old_path);
-
-	setenv("MANPATH", new_path.buf, 1);
-
-	strbuf_release(&new_path);
-}
-
-static void exec_viewer(const char *name, const char *page)
-{
-	const char *info = get_man_viewer_info(name);
-
-	if (!strcasecmp(name, "man"))
-		exec_man_man(info, page);
-	else if (!strcasecmp(name, "woman"))
-		exec_woman_emacs(info, page);
-	else if (!strcasecmp(name, "konqueror"))
-		exec_man_konqueror(info, page);
-	else if (info)
-		exec_man_cmd(info, page);
-	else
-		warning("'%s': unknown man viewer.", name);
-}
-
-static void show_man_page(const char *git_cmd)
-{
-	struct man_viewer_list *viewer;
-	const char *page = cmd_to_page(git_cmd);
-
-	setup_man_path();
-	for (viewer = man_viewer_list; viewer; viewer = viewer->next)
-	{
-		exec_viewer(viewer->name, page); /* will return when unable */
-	}
-	exec_viewer("man", page);
-	die("no man viewer handled the request");
-}
-
-static void show_info_page(const char *git_cmd)
-{
-	const char *page = cmd_to_page(git_cmd);
-	setenv("INFOPATH", GIT_INFO_PATH, 1);
-	execlp("info", "info", "gitman", page, NULL);
-}
-
-static void get_html_page_path(struct strbuf *page_path, const char *page)
-{
-	struct stat st;
-	const char *html_path = system_path(GIT_HTML_PATH);
-
-	/* Check that we have a git documentation directory. */
-	if (stat(mkpath("%s/git.html", html_path), &st)
-	    || !S_ISREG(st.st_mode))
-		die("'%s': not a documentation directory.", html_path);
-
-	strbuf_init(page_path, 0);
-	strbuf_addf(page_path, "%s/%s.html", html_path, page);
-}
-
-/*
- * If open_html is not defined in a platform-specific way (see for
- * example compat/mingw.h), we use the script web--browse to display
- * HTML.
- */
-#ifndef open_html
-void open_html(const char *path)
-{
-	execl_git_cmd("web--browse", "-c", "help.browser", path, NULL);
-}
-#endif
-
-static void show_html_page(const char *git_cmd)
-{
-	const char *page = cmd_to_page(git_cmd);
-	struct strbuf page_path; /* it leaks but we exec bellow */
-
-	get_html_page_path(&page_path, page);
-
-	open_html(page_path.buf);
-}
-
 void help_unknown_cmd(const char *cmd)
 {
 	fprintf(stderr, "git: '%s' is not a git-command. See 'git --help'.\n", cmd);
@@ -685,50 +268,3 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 	printf("git version %s\n", git_version_string);
 	return 0;
 }
-
-int cmd_help(int argc, const char **argv, const char *prefix)
-{
-	int nongit;
-	const char *alias;
-	unsigned int longest = load_command_list("git-", &main_cmds, &other_cmds);
-
-	setup_git_directory_gently(&nongit);
-	git_config(git_help_config, NULL);
-
-	argc = parse_options(argc, argv, builtin_help_options,
-			builtin_help_usage, 0);
-
-	if (show_all) {
-		printf("usage: %s\n\n", git_usage_string);
-		list_commands("git commands", longest, &main_cmds, &other_cmds);
-		printf("%s\n", git_more_info_string);
-		return 0;
-	}
-
-	if (!argv[0]) {
-		printf("usage: %s\n\n", git_usage_string);
-		list_common_cmds_help();
-		printf("\n%s\n", git_more_info_string);
-		return 0;
-	}
-
-	alias = alias_lookup(argv[0]);
-	if (alias && !is_git_command(argv[0])) {
-		printf("`git %s' is aliased to `%s'\n", argv[0], alias);
-		return 0;
-	}
-
-	switch (help_format) {
-	case HELP_FORMAT_MAN:
-		show_man_page(argv[0]);
-		break;
-	case HELP_FORMAT_INFO:
-		show_info_page(argv[0]);
-		break;
-	case HELP_FORMAT_WEB:
-		show_html_page(argv[0]);
-		break;
-	}
-
-	return 0;
-}
diff --git a/help.h b/help.h
index d614e54..3f1ae89 100644
--- a/help.h
+++ b/help.h
@@ -10,6 +10,12 @@ struct cmdnames {
 	} **names;
 };
 
+static inline void mput_char(char c, unsigned int num)
+{
+	while(num--)
+		putchar(c);
+}
+
 unsigned int load_command_list(const char *prefix,
 		struct cmdnames *main_cmds,
 		struct cmdnames *other_cmds);
-- 
1.6.0.rc0.14.g95f8.dirty
